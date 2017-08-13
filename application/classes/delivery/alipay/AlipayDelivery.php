<?php 
/**
 * @copyright Copyright(c) 2014 http://www.tinyrise.com
 * @breif 
 * @author Tiny
 * @date 2014-11-25
 * @version 1.0
 */
/**
 * 发货同步处理
 * 
 * @author Tiny
 * @class alipayDelivery
 */
class AlipayDelivery
{
    private $config;
    
    public function __construct($partner_id,$partner_key)
    {
        $this->config['partner']		= $partner_id;
        //安全检验码，以数字和字母组成的32位字符
        $this->config['key']			= $partner_key;
        
        //签名方式 不需修改
        $this->config['sign_type']    = strtoupper('MD5');
        
        //字符编码格式 目前支持 gbk 或 utf-8
        $this->config['input_charset']= strtolower('utf-8');
        
        //ca证书路径地址，用于curl中ssl校验
        //请保证cacert.pem文件在当前文件夹目录中
        $this->config['cacert']    = getcwd().'\\cacert.pem';
        
        //访问模式,根据自己的服务器是否支持ssl访问，若支持请选择https；若不支持请选择http
        $this->config['transport']    = 'http';
    }

    public function send($trade_no,$logistics_name,$invoice_no)
    {
        require_once("lib/alipay_submit.class.php");
        $alipaySubmit = new AlipaySubmit($this->config);
        $parameter = array(
                "service" => "send_goods_confirm_by_platform",
                "partner" => trim($this->config['partner']),
                "trade_no"	=> $trade_no,
                "logistics_name"	=> $logistics_name,
                "invoice_no"	=> $invoice_no,
                "transport_type"	=> 'EXPRESS',
                "_input_charset"	=> trim(strtolower($alipay_config['input_charset']))
        );
        $html_text = $alipaySubmit->buildRequestHttp($parameter);
    }
}