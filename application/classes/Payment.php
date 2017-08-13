<?php

/**
 * @class Payment
 * @brief 支付方式 操作类
 */

class Payment{

	private $payment_id;
	private $payment = array();
	private $_config = null;

	public function __construct($payment_id){
		$model = new Model("payment as pa");
		$this->payment = $model->fields('pa.*,pi.class_name,pi.name,pi.logo')->join("left join pay_plugin as pi on pa.plugin_id = pi.id")->where("pa.id = '".$payment_id."' or pi.class_name = '".$payment_id."'")->find();
		if($this->payment){
            $this->payment_id = $this->payment['id'];
            $this->_config = unserialize($this->payment['config']);
            if(empty($this->_config)) $this->_config = null;
        }
	}

	public function getPaymentPlugin(){
		if($this->payment){
            $class_name = 'pay_'.$this->payment['class_name'];
            $newClass = new $class_name($this->payment_id);
            $newClass->setClassConfig($this->_config);
            return $newClass;
        }else{
            return null;
        }
	}

	/**
	 * @brief 根据支付方式配置编号  获取该插件的详细配置信息
	 * @param int	支付方式配置编号
	 * @return 返回支付插件类对象
	 */
	public function getPayment(){
		return $this->payment;
	}



	/**
	 * @brief 获取订单中的支付信息
	 * @type         信息获取方式 order:订单支付;recharge:在线充值;
	 * @argument     参数
	 * @return array 支付提交信息
	 * R表示店铺 ; P表示用户;
	 */
	public function getPaymentInfo($type,$argument){

		$controller = Tiny::app()->getController();
		//支付信息
		$payment = array();

		//取的支付商户的ID与密钥
		$paymentObj = $this->getPayment();
		$payment['M_PartnerId']  = isset($this->_config['partner_id'])?$this->_config['partner_id']:'';
		$payment['M_PartnerKey'] = isset($this->_config['partner_key'])?$this->_config['partner_key']:'';

		$model = new Model("order");
		if($type == 'order'){
			$order_id = $argument;
			//获取订单信息
			$order = $model->where('id = '.$order_id.' and status = 2')->find();
			if(empty($order))
			{
				$msg = array('type'=>'fail','msg'=>'订单信息不正确，不能进行支付！');
                $controller ->redirect('/index/msg',false,$msg);
                exit;
			}

			$payment ['M_Remark']    = $order['user_remark'];
			$payment ['M_OrderId']   = $order['id'];
			$payment ['M_OrderNO']   = $order['order_no'];
			$payment ['M_Amount']    = $order['order_amount'];
			//用户信息
			$payment ['P_Mobile']    = $order['mobile'];
			$payment ['P_Name']      = $order['accept_name'];
			$payment ['P_PostCode']  = $order['zip'];
			$payment ['P_Telephone'] = $order['phone'];
			$payment ['P_Address']   = $order['addr'];
			$payment ['P_Email']     = '';
		}
		else if($type == 'recharge')
		{
			if(!isset($argument['account']) || $argument['account'] <= 0){
				$msg = array('type'=>'fail','msg'=>'请填入正确的充值金额！');
                $controller ->redirect('/index/msg',false,$msg);
                exit;
			}
			$safebox =  Safebox::getInstance();
			$user = $safebox->get('user');
			$recharge = new Model('recharge');
			$data      = array(
				'user_id'     => $user['id'],
				'recharge_no' => Common::createOrderNo(),
				'account'     => $argument['account'],
				'time'        => date('Y-m-d H:i:s'),
				'payment_name'=> $argument['paymentName'],
				'status'      => 0,
			);

			$r_id = $recharge->data($data)->insert();

			//充值时用户id跟随交易号一起发送,以"_"分割
			$payment ['M_OrderNO']   = 'recharge_'.$data['recharge_no'];
			$payment ['M_OrderId']   = $r_id;
			$payment ['M_Amount']    = $data['account'];
		}

		$config = Config::getInstance();
		$site_config = $config->get("globals");

		//交易信息
		$payment ['M_Def_Amount']= 0.01;
		$payment ['M_Time']      = time ();
		$payment ['M_Goods']     = '';
		$payment ['M_Language']  = "zh_CN";
		$payment ['M_Paymentid'] = $this->payment_id;

		//商城信息
		$payment ['R_Address']   = isset($site_config['site_addr'])  ? $site_config['site_addr'] : '';
		$payment ['R_Name']      = isset($site_config['site_name'])  ? $site_config['site_name'] : '';
		$payment ['R_Mobile']    = isset($site_config['site_mobile'])? $site_config['site_mobile'] : '';
		$payment ['R_Telephone'] = isset($site_config['site_phone']) ? $site_config['site_phone'] : '';
		$payment ['R_Postcode']  = isset($site_config['site_zip'])   ? $site_config['site_zip'] : '';
		$payment ['R_Email']     = isset($site_config['site_email']) ? $site_config['site_email'] : '';

		return $payment;
	}
}
?>
