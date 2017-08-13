<?php
//操作日志类
class Pointlog
{
	public static function write($user_id,$value,$note){
		if(is_numeric($value)){
			$model = new Model('customer');
			$customer = $model->where("user_id=".$user_id)->find();
			if($customer){
				if($value<0){
					if($customer['point']<abs($value)) return array('status'=>'fail','msg'=>'积分不够扣除！');
				}
				$new_point = $customer['point'] + $value;
				$model->where("user_id=".$user_id)->data(array('point'=>$new_point))->update();
				$logs = array('user_id'=>$user_id,'value'=>$value,'point'=>$new_point,'note'=>$note,'create_time'=>date('Y-m-d H:i:s'));
				$model = new Model('point_log');
				$model->data($logs)->insert();
				return true;
			}
			
		}
		else{
			return array('status'=>'fail','msg'=>'积分必需为数值。');
		}
		
	}
}
?>