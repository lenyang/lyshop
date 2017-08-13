<?php
 /**
 * @class PaymentPlugin
 * @brief 支付插件基类
 */
class PaymentPlugin
{
    public $method      = "post";//form提交模式
    public $charset     = "utf8";//字符集
    public $name        = null;//支付插件名称
    public $version     = 1.0;//版本
    public $callbackUrl = null;//支付完成后，回调地址
    public $asyncCallbackUrl = null;//异步通知地址
    protected $classConfig   = null;//支付插件配置信息
    protected $paymentId = null;
	protected $needSubmit = true;
    protected $onlinePay = true;//在线支付
    /**
    * @brief 构造函数
    */
    public function __construct($paymentId=0){
        //同步回调地址
        $this->callbackUrl = str_replace('plugins/','',Url::fullUrlFormat("/payment/callback/payment_id/{$paymentId}"));

        //异步回调地址
        $this->asyncCallbackUrl = str_replace('plugins/','',Url::fullUrlFormat("/payment/async_callback/payment_id/{$paymentId}"));
        $this->paymentId = $paymentId;
    }

	public function setClassConfig ($config=null)
	{
		$this->classConfig = $config;
	}
	public function getClassConfig ()
	{
		return $this->classConfig;
	}
	public static function config()
	{
		return array();
	}
    //终止异步处理
    public function asyncStop(){
        echo "success";
    }
    //提交地址
    public function submitUrl(){
        return '';
    }

    //打包支付信息
    public function packData($paymentInfo){
        return false;
    }

    //同步支付回调
    public function callback($in,&$paymentId,&$money,&$message,&$tradeNo){
        return false;
    }

    //异步支付回调
    public function asyncCallback($in,&$paymentId,&$money,&$message,&$tradeNo){
        $this->callback($in,$paymentId,$money,$message,$tradeNo);
    }

    //后期与服务同步处理类
    public function afterAsync()
    {
        return null;
    }
    //取得paymentId
    public function getPaymentId()
    {
        return $this->paymentId;
    }
    //是否需要单独页面表单提交
    public function isNeedSubmit()
    {
        return $this->needSubmit;
    }
    //是否需要在线支付
    public function isOnlinePay()
    {
        return $this->onlinePay;
    }
}
?>
