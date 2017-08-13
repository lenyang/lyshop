<?php
//日志类
class Log
{
	//操作日志写入
	public static function op($manager_id,$action,$content)
	{
		$logs = array('manager_id'=>$manager_id,'action'=>$action,'content'=>$content,'ip'=>Chips::getIP(),'url'=>Url::requestUri(),'time'=>date('Y-m-d H:i:s'));
		$model = new Model('log_operation');
		$model->data($logs)->insert();
	}
	//余额日志变化写入
	public static function balance($amount,$user_id,$note='',$type=0,$admin_id=0)
	{
		//事件类型: 0:订单支付 1:用户充值 2:管理员充值 3:提现
		$model = new Model('customer');
		$customer = $model->fields("balance")->where("user_id=".$user_id)->find();
		if($customer){
			$log = array('amount'=>$amount,'user_id'=>$user_id,'time'=>date('Y-m-d H:i:s'),'amount_log'=>$customer['balance'],'admin_id'=>$admin_id,'type'=>$type,'note'=>$note);
			$model->table("balance_log")->data($log)->insert();
		}
	}
}
?>