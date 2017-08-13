<?php
 /**
 * @class paypal
 * @brief 贝宝[外卡]接口
 */
class pay_paypal extends PaymentPlugin
{
	//支付插件名称
    public $name = '贝宝支付';

	//提交地址
	public function submitUrl()
	{
		return 'https://www.paypal.com/cgi-bin/webscr';
	}

	//取得配制参数
    public static function config()
    {
    	return array(
    		array('field'=>'partner_id','caption'=>'合作身份者id','type'=>'string'),
    		array('field'=>'partner_key','caption'=>'安全检验码key','type'=>'string'),
    	);
    }
	//同步处理
	public function callback($callbackData,&$paymentId,&$money,&$message,&$orderNo)
	{
		
		$payment = new Payment($paymentId);
		$payment_plugin = $payment->getPaymentPlugin();
		$classConfig = $payment_plugin->getClassConfig();
		$UserName = $classConfig['partner_id'];
		$IDcode   = $classConfig['partner_key'];

		$return                = array();
		$return['business']    = urldecode($UserName);
		$return['item_number'] = urldecode($callbackData['item_number']);
		$return['amount']      = urldecode($callbackData['amt']);
		$return['return']      = urldecode($this->callbackUrl);
		$return['notify_url']  = urldecode($this->serverCallbackUrl);
		$md5Code               = $this->createMD5($return,$IDcode);

		//校验md5码 防止篡改数据
		if(urldecode($callbackData['cm']) == $md5Code)
		{
            switch($callbackData['st'])
            {
                case 'Completed':
                {
					$orderNo  = $callbackData['item_number'];
					$money    = $callbackData['amt'];
                	return true;
                    break;
                }
                default:
                {
                	return false;
                	break;
                }
            }
		}
		else
		{
			$message = '校验码不正确';
		}
		return false;
	}

	//异步处理
	public function asyncCallback($callbackData,&$paymentId,&$money,&$message,&$orderNo)
	{
    	//通过soket检查回值是否合法
    	$req = 'cmd=_notify-validate';
		foreach ($_POST as $key => $value)
		{
			$value = urlencode(stripslashes($value));
			$req  .= "&$key=$value";
		}

		$header .= "POST /cgi-bin/webscr HTTP/1.0\r\n";
		$header .= "Content-Type:application/x-www-form-urlencoded\r\n";
		$header .= "Content-Length:" . strlen($req) ."\r\n\r\n";
		$fp      = fsockopen ('www.paypal.com', 80, $errno, $errstr, 30);
		if(!$fp)
		{
			return false;
		}
		else
		{
			fputs ($fp, $header .$req);
			while (!feof($fp))
			{
				$res = fgets ($fp, 1024);
				if (strcmp ($res, "VERIFIED") == 0)
				{
					return $this->callback($callbackData,$paymentId,$money,$message,$orderNo);
				}
				else if (strcmp ($res, "INVALID") == 0)
				{
					return false;
				}
			}
			fclose ($fp);
		}
	}

	//数据打包
	public function packData($payment)
	{
    	$return = array();

		$UserName = $payment['M_PartnerId'];
		$IDcode   = $payment['M_PartnerKey'];

		$return['business']    = $UserName;
		$return['item_number'] = $payment['M_OrderNO'];
		$return['amount']      = $payment['M_Amount'];
		$return['return']      = $this->callbackUrl;
		$return['notify_url']  = $this->asyncCallbackUrl;
		$return['custom']      = $this->createMD5($return,$IDcode);
		$return['item_name']   = $payment['R_Name'];
		$return['cmd']         = '_xclick';
		$return['charset']     = 'utf-8';

        return $return;
	}

    /**
    * @brief 生成md5防篡改码
	* @param array  要加密的原数据
	* @param string id密钥
	* @return string md5码
    */
    private function createMD5($rdata,$idCode)
    {
    	$rdataMD5   = '';
    	$rdataArray = array();

    	//让数组以键值进行排序
        ksort($rdata);
        reset($rdata);

    	foreach($rdata as $key => $val)
    	{
    		$rdataArray[] = $val;
    	}

    	$rdataMD5 = join('&',$rdataArray);
    	return md5($rdataMD5.$idCode);
    }
}