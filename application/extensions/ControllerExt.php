<?php
//控制器扩展
class ControllerExt implements Extension
{
    public function before($obj=null)
    {
        //测试平板或者手机端主题
        $clientType = Chips::clientType();
        if($clientType=='tablet' || $clientType=='mobile'){
            $config_path = APP_CODE_ROOT.'config/config.php';
            $config = require($config_path);
            if(isset($config['themes_mobile'])) $themes_mobile = Tiny::app()->setTheme($config['themes_mobile']);
            else Tiny::app()->setTheme("default");
            if(strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false){
                $weixin_openid = Cookie::get('weixin_openid');
                if(class_exists('pay_weixin') && ($weixin_openid==null || $weixin_openid==false)){
                    $pay_weixin = new pay_weixin();
                    $payment = new Payment('weixin');
                    $payment_info = $payment->getPayment();
                    if(isset($payment_info['status']) && $payment_info['status'] == 0){
                        $payment_weixin = $payment->getPaymentPlugin();
                        WxPayConfig::setConfig($payment_weixin->getClassConfig());
                        $tools = new JsApiPay();
                        $openId = $tools->GetOpenid();
                        Cookie::set('weixin_openid',$openId);
                        $weixin_preurl = Cookie::get('weixin_preurl');
                        Cookie::clear('weixin_preurl');
                        Header("Location: $weixin_preurl");
                    }
                }
            }

        }
        $config = Config::getInstance();
        $site = $config->get('globals');
        $other = $config->get('other');
        $currency_symbol = isset($other['other_currency_symbol'])?$other['other_currency_symbol']:'￥';
        $currency_unit = isset($other['other_currency_unit'])?$other['other_currency_unit']:'元';
        $site_logo = (isset($site['site_logo'])&&$site['site_logo']!='')?$site['site_logo']:'static/images/logo.png';
        $site_name = isset($site['site_name'])?$site['site_name']:'TinyShop商城';
        $site_icp = isset($site['site_icp'])?$site['site_icp']:'鲁ICP备00000100号';

        $obj->assign('currency_symbol',$currency_symbol);
        $obj->assign('currency_unit',$currency_unit);
        $obj->assign('site_logo',$site_logo);
        $obj->assign('site_name',$site_name);
        $obj->assign('site_icp',$site_icp);
    }
    public function after($obj=null)
    {
    }
}
