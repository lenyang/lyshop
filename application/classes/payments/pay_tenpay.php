<?php
/**
 * @class pay_tenpay
 * @brief 腾讯财付通[即时到账]
 */
class pay_tenpay extends PaymentPlugin
{
	//支付插件名称
    public $name = '财付通';

    public function submitUrl(){
        return 'https://gw.tenpay.com/gateway/pay.htm';
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
        //除去待签名参数数组中的空值和签名参数
        $filter_param = $this->filterParam($callbackData);

        //对待签名参数数组排序
        $para_sort = $this->argSort($filter_param);

        //生成签名结果
        $payment = new Payment($paymentId);
		$payment_plugin = $payment->getPaymentPlugin();
		$classConfig = $payment_plugin->getClassConfig();

        $mysign = $this->buildSign($para_sort,$classConfig['partner_key']);

        if($callbackData['sign'] == strtoupper($mysign))
        {
            //回传数据
            $orderNo = $callbackData['out_trade_no'];
            $money   = $callbackData['total_fee']/100;
            $message = isset($callbackData['pay_info']) ? $callbackData['pay_info'] : '';

            if($message == '' && $callbackData['trade_state'] == '0')
            {
                return true;
            }
        }
        else
        {
            $message = '数字签名不正确';
        }
        return false;
    }

    //异步处理
    public function asyncCallback($callbackData,&$paymentId,&$money,&$message,&$orderNo)
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
        
        if($callbackData['sign'] == strtoupper($mysign))
        {
            //回传数据
            $orderNo = $callbackData['out_trade_no'];
            $money   = $callbackData['total_fee']/100;
            $message = isset($callbackData['pay_info']) ? $callbackData['pay_info'] : '';

            if($message == '' && $callbackData['trade_state'] == '0')
            {
                return true;
            }
        }
        return false;
    }

    //数据打包
    public function packData($payment)
    {
        $return = array();
        $price  = ceil($payment['M_Amount'] * 100);

        $return["input_charset"] = 'UTF-8';
        $return["body"] = $payment['R_Name'];
        $return["return_url"] = $this->callbackUrl;
        $return["notify_url"] = $this->asyncCallbackUrl;
        $return["partner"]    = $payment['M_PartnerId'];
        $return["out_trade_no"] = $payment['M_OrderNO'];
        $return["total_fee"] = $price;
        $return["spbill_create_ip"] = $_SERVER['REMOTE_ADDR'];
        $return["bank_type"] = 'DEFAULT';
        $return['orderAmount'] = $price;
        $return['orderId']= $payment['M_OrderNO'];

        //除去待签名参数数组中的空值和签名参数
        $filter_param = $this->filterParam($return);

        //对待签名参数数组排序
        $para_sort = $this->argSort($filter_param);

        //生成签名结果
        $mysign = $this->buildSign($para_sort, $payment['M_PartnerKey']);

        //签名结果与签名方式加入请求提交参数组中
        $return['sign'] = strtoupper($mysign);

        return $return;
    }


    /**
     * 除去数组中的空值和签名参数
     * @param $para 签名参数组
     * return 去掉空值与签名参数后的新签名参数组
     */
    private function filterParam($para)
    {
        $filter_param = array();
        foreach($para as $key => $val)
        {
            if($key == "sign" || $val == "")
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

    /**
     * 对数组排序
     * @param $para 排序前的数组
     * return 排序后的数组
     */
    private function argSort($para)
    {
        ksort($para);
        reset($para);
        return $para;
    }

    /**
     * 生成签名结果
     * @param $sort_para 要签名的数组
     * @param $key 支付交易安全校验码
     * @param $sign_type 签名类型 默认值：MD5
     * return 签名结果字符串
     */
    private function buildSign($sort_para,$key,$sign_type = "MD5")
    {
        //把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
        $prestr = $this->createLinkstring($sort_para);
        //把拼接后的字符串再与安全校验码直接连接起来
        $prestr = $prestr.'&key='.$key;
        //把最终的字符串签名，获得签名结果
        $mysgin = md5($prestr);
        return $mysgin;
    }

    /**
     * 把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
     * @param $para 需要拼接的数组
     * return 拼接完成以后的字符串
     */
    private function createLinkstring($para)
    {
        $arg  = "";
        foreach($para as $key => $val)
        {
            $arg.=$key."=".$val."&";
        }

        //去掉最后一个&字符
        $arg = trim($arg,'&');

        //如果存在转义字符，那么去掉转义
        if(get_magic_quotes_gpc())
        {
            $arg = stripslashes($arg);
        }

        return $arg;
    }
}