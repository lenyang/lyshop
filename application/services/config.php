<?php
class ConfigService
{
	private $config;
	public function __construct(&$config)
	{
		$this->config = &$config;
	}
    public function globals()
    {
		$globals = array(
			'site_name'=>Req::args('site_name'),
			'site_logo'=>Req::args('site_logo'),
			'site_keywords'=>Req::args('site_keywords'),
			'site_description'=>Req::args('site_description'),
			'site_icp'=>Req::args('site_icp'),
			'site_url'=>Req::args('site_url'),
			'site_addr'=>Req::args('site_addr'),
			'site_mobile'=>Req::args('site_mobile'),
			'site_email'=>Req::args('site_email'),
			'site_zip'=>Req::args('site_zip'),
			'site_phone'=>Req::args('site_phone')
		);
		$this->config->set('globals',$globals);
		return true;
    }
    public function photo()
    {
    	$photo = array(
			'photo_width'=>Req::args('photo_width'),
			'photo_small_width'=>Req::args('photo_small_width')
		);
		$this->config->set('photo',$photo);
		return true;
    }
    public function email()
    {
    	$email = array(
			'email_sendtype'=>Req::args('email_sendtype'),
			'email_host'=>Req::args('email_host'),
			'email_ssl'=>Req::args('email_ssl'),
			'email_port'=>Req::args('email_port'),
			'email_account'=>Req::args('email_account'),
			'email_password'=>Req::args('email_password'),
			'email_sender_name'=>Req::args('email_sender_name')
		);
		$this->config->set('email',$email);
		return true;
    }
    public function other(){
        $other_reg_way = Req::args('other_reg_way');
        $other_reg_way = is_array($other_reg_way)?implode(',', $other_reg_way):$other_reg_way;
    	$other = array(
            'other_currency_symbol'=>Req::args('other_currency_symbol'),
            'other_reg_way'=>($other_reg_way==null?'0':$other_reg_way),
    		'other_currency_unit'=>Req::args('other_currency_unit'),
    		'other_is_invoice'=>Req::args('other_is_invoice'),
    		'other_tax'=>Req::args('other_tax'),
    		'other_grade_days'=>Req::args('other_grade_days'),
    		'other_order_delay'=>Req::args('other_order_delay'),
    		'other_order_delay_flash'=>Req::args('other_order_delay_flash'),
    		'other_order_delay_group'=>Req::args('other_order_delay_group'),
    		'other_order_delay_bund'=>Req::args('other_order_delay_bund'),
    		'other_verification_eamil'=>Req::args('other_verification_eamil'),
    	);
    	$this->config->set('other',$other);
		return true;
    }
	public function safe()
    {
    	$safe = array(
			'safe_reg_limit'=>Req::args('safe_reg_limit'),
			'safe_reg_num'=>Req::args('safe_reg_num'),
			'safe_comment_limit'=>Req::args('safe_comment_limit'),
			'safe_comment_num'=>Req::args('safe_comment_num'),
			'safe_album_limit'=>Req::args('safe_album_limit'),
			'safe_album_num'=>Req::args('safe_album_num'),
			'safe_click_count'=>Req::args('safe_click_count')
		);
		$this->config->set('safe',$safe);
		return true;
    }

    public function rebate()
    {
    	$rebate = array(
			'rebate_line'=>Req::args('rebate_line'),
			'rebate_one'=>Req::args('rebate_one'),
			'rebate_two'=>Req::args('rebate_two'),
			'rebate_three'=>Req::args('rebate_three'),
			'rebate_level'=>Req::args('rebate_level'),
			'rebate_status'=>Req::args('rebate_status')
		);
		$this->config->set('rebate',$rebate);
		return true;
    }
}
