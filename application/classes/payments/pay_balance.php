<?php

 /**
 * @class pay_balance
 * @brief 账户余额支付接口
 */
class pay_balance extends PaymentPlugin
{
	 public $name = '账户余额支付';

	//提交地址
    public function submitUrl()
    {
    	return Url::fullUrlFormat("/payment/pay_balance");
    }

	//取得配制参数
    public static function config()
    {
    	return array(
    		array('field'=>'partner_id','caption'=>'合作身份者id','type'=>'string'),
    		array('field'=>'partner_key','caption'=>'安全检验码key','type'=>'string'),
    	);
    }
    //打包数据
    public function packData($payment)
    {
    	$partnerId  = $payment['M_PartnerId'];
    	$partnerKey = $payment['M_PartnerKey'];

        $safebox =  Safebox::getInstance();
        $user = $safebox->get('user');
        $user_id = $user['id'];

		$return['attach']     = $payment['M_Paymentid'];
		$return['total_fee']  = $payment['M_Amount'];
		$return['order_no']   = $payment['M_OrderNO'];
		$return['return_url'] = $this->callbackUrl;

        //过虑无效参数
        $filter_param = $this->filterParam($return);

        //对待签名参数数组排序
        $para_sort = $this->argSort($filter_param);

        //生成签名
        $mysign = $this->buildSign($para_sort, $payment['M_PartnerKey']);

        //签名结果与签名方式加入请求提交参数组中
        $return['sign'] = $mysign;
        return $return;
    }

	//同步处理
    public function callback($callbackData,&$paymentId,&$money,&$message,&$orderNo)
    {
        //除去待签名参数数组中的空值和签名参数
        $filter_param = $this->filterParam($callbackData);

        //对待签名参数数组排序
        $para_sort = $this->argSort($filter_param);

        //生成签名结果
        $payment = new Payment($paymentId);
		$payment_plugin = $payment->getPaymentPlugin();
		$classConfig = $payment_plugin->getClassConfig();

        $mysign = $this->buildSign($para_sort,$classConfig['partner_key']);
        if($callbackData['sign'] == $mysign)
        {
            //回传数据
            $orderNo = $callbackData['order_no'];
            $money   = $callbackData['total_fee'];

            if($callbackData['order_status'] == 'TINY_SECCESS')
            {
                return true;
            }
            $message = '支付失败';
        }
        else
        {
            $message = '签名不正确';
        }
        return false;
    }
    //过滤处理
    public function filterParam($para)
    {
        $filter_param = array();
        foreach($para as $key => $val)
        {
            if($key == "sign" || $key == "sign_type" || $val === "")
            {
                continue;
            }
            else
            {
                $filter_param[$key] = $para[$key];
            }
        }
        return $filter_param;
    }
    //参数排序
    public function argSort($para)
    {
        ksort($para);
        reset($para);
        return $para;
    }

    //生成签名
    public function buildSign($sort_para,$key,$sign_type = "MD5")
    {
        //把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
        $prestr = $this->createLinkstring($sort_para);
        //把拼接后的字符串再与安全校验码直接连接起来
        $prestr = $prestr.$key;
        $mysgin = md5($prestr);
        return $mysgin;
    }

    //生成连接字符串
    public function createLinkstring($para){
        $arg  = "";
        foreach($para as $key => $val){
            $arg.=$key."=".$val."&";
        }
        //去掉最后一个&字符
        $arg = trim($arg,'&');
        //如果存在转义字符，那么去掉转义
        if(get_magic_quotes_gpc()){
            $arg = stripslashes($arg);
        }
        return $arg;
    }

	//异步处理
    public function asyncCallback($ExternalData,&$paymentId,&$money,&$message,&$orderNo){}

}
