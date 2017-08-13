<?php
 /**
 * @class pay_unionpay
 * @brief 中国银联【网关支付接口】插件类
 */
 class pay_unionpay extends PaymentPlugin{

    //支付插件名称
    public $name = '中国银联支付接口';

    protected $needSubmit =  true;

    protected $config = array(
    );

    //提交地址
    public function submitUrl(){
		//return 'https://101.231.204.80:5000/gateway/api/frontTransReq.do'; //测试环境请求地址
		return 'https://gateway.95516.com/gateway/api/frontTransReq.do'; //生产环境
    }
	//取得配制参数
    public static function config()
    {
    	return array(
    		array('field'=>'merId','caption'=>'商户代码（merId）','type'=>'string'),
            array('field'=>'certPwd','caption'=>'证书密码(certPwd)','type'=>'string'),
    		array('field'=>'bizType','caption'=>'业务类型','type'=>'select','options'=>'000201:网关支付,000202:企业网银支付')
         );
    }
    //同步处理
    public function callback($callbackData,&$paymentId,&$money,&$message,&$orderNo)
    {
        if (isset ( $callbackData['signature'] )){
           if (UnionPayServices::verify ( $callbackData )){
            if($callbackData['respCode'] == "00"){
					$orderNo = $callbackData['orderId'];
					// $callbackData['queryId']
					return true;
				}
				$message = '状态码不正确:'.$callbackData['respCode'];
			}else{
				$message = '签名不正确';
			}
		}else{
			$message = '签名为空';
		}
		return false;
    }

    //异步处理
    public function asyncCallback($callbackData,&$paymentId,&$money,&$message,&$orderNo)
    {
        return $this->callback($callbackData,$paymentId,$money,$message,$orderNo);
    }

    //打包数据
    public function packData($payment)
    {
        $merId       = $this->classConfig['merId'];
        $certPwd   = $this->classConfig['certPwd'];
        $bizType   = $this->classConfig['bizType'];

        UnionPayServices::setCertPwd($certPwd);
        $params = array(
        //以下信息非特殊情况不需要改动
        'version' => '5.0.0',                 //版本号
        'encoding' => 'utf-8',                //编码方式
        'txnType' => '01',                    //交易类型
        'txnSubType' => '01',                 //交易子类
        'bizType' => $bizType,//000201                //业务类型
        'frontUrl' =>  $this->callbackUrl,    //前台通知地址
        'backUrl' => $this->asyncCallbackUrl, //后台通知地址
        'signMethod' => '01',                 //签名方法
        'channelType' => '07',                //渠道类型，07-PC，08-手机
        'accessType' => '0',                  //接入类型
        'currencyCode' => '156',              //交易币种，境内商户固定156
        //TODO 以下信息需要填写
        'merId' => $merId,     //商户代码，请改自己的测试商户号，此处默认取demo演示页面传递的参数
        'orderId' => $payment['M_OrderNO'], //商户订单号，8-32位数字字母，不能含“-”或“_”，此处默认取demo演示页面传递的参数，可以自行定制规则
        'txnTime' => date('YmdHis'), //订单发送时间，格式为YYYYMMDDhhmmss，取北京时间，此处默认取demo演示页面传递的参数
        'txnAmt' => $payment['M_Amount']*100,   //交易金额，单位分，此处默认取demo演示页面传递的参数
        'reqReserved' =>$payment['M_OrderId'],        //请求方保留域，透传字段，查询、通知、对账文件中均会原样出现，如有需要请启用并修改自己希望透传的数据
        );
        UnionPayServices::sign($params);
        return $params;
    }
}
