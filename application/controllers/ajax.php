<?php
/**
 * description...
 *
 * @author Crazy、Ly
 * @package AdminController
 */
class AjaxController extends Controller
{
	public $layout='';
	public $model = null;
	public $needRightActions = array('*'=>false);
	public function init()
	{
		header("Content-type: text/html; charset=".$this->encoding);
		$this->model = new Model();
	}
	//团购结束更新
	public function groupbuy_end()
	{

		$id = Filter::int(Req::args('id'));
		if($id){
			$item = $this->model->table("groupbuy")->where("id=$id")->find();
	        $end_diff = time()-strtotime($item['end_time']);
	        if($end_diff>0){
				$this->model->table("groupbuy")->where("id=$id")->data(array('is_end'=>1))->update();
			}
		}

	}
	//抢购结束更新
	public function flashbuy_end()
	{
		$id = Filter::int(Req::args('id'));
		if($id){
					$item = $this->model->table("flash_sale")->where("id=$id")->find();
	        $end_diff = time()-strtotime($item['end_time']);
	        if($end_diff>0){
				$this->model->table("flash_sale")->where("id=$id")->data(array('is_end'=>1))->update();
			}
		}

	}
	//订单是否已经付款
	public function isOrderPayment()
	{
		$order_no = Req::args('order_no');
		if(stripos($order_no,'recharge_') !== false){
			$model = new Model('recharge');
			$tradenoArray = explode('_',$order_no);
            $recharge_no  = isset($tradenoArray[1]) ? $tradenoArray[1] : 0;
			$obj = $model->where("recharge_no='".Filter::int($recharge_no)."' and status = 1")->find();
		}else{
			$model = new Model('order');
			$obj = $model->where("order_no='".Filter::int($order_no)."' and pay_status = 1")->find();
		}
		$info = array('status'=>'fail');
		if($obj){
			$info = array('status'=>'success');
		}
		echo JSON::encode($info);
	}
	public function send_sms()
	{
		$mobile = Filter::sql(Req::args('mobile'));
		if(Validator::mobi($mobile)){
			$model = new Model('mobile_code');
			$time = time() - 120;
			$obj = $model->where("send_time < $time")->delete();
			$obj = $model->where("mobile='".$mobile."'")->find();
			if($obj){
				$info = array('status'=>'fail','msg'=>'120秒内仅能获取一次短信验证码,请稍后重试!');
			}else{
				$sms = SMS::getInstance();
				if($sms->getStatus()){
					$code = CHash::random('6','int');
					$result = $sms->sendCode($mobile,$code);
					if($result['status']=='success')
					{
						$info = array('status'=>'success','msg'=>$result['message']);
						$model->data(array('mobile'=>$mobile,'code'=>$code,'send_time'=>time()))->insert();
					}else{
						$info = array('status'=>'fail','msg'=>$result['message']);
					}
				}else{
					$info = array('status'=>'fail','msg'=>'请开启手机验证功能!');
				}
			}
		}
		echo JSON::encode($info);
	}

	public function calculate_fare()
	{
		$allvirtual = Req::args("allvirtual");
		if($allvirtual == 'true'){
			$fee = 0;
		}else{
			$weight = Filter::int(Req::args('weight'));
			$id = Filter::int(Req::args('id'));
			$fare = new Fare($weight);
			$fee = $fare->calculate($id);
		}

		echo JSON::encode(array('status'=>"success",'fee'=>$fee));
	}

	public function email()
	{
		$email = Filter::sql(Req::args('email'));
		$info = array('status'=>false,'msg'=>'此用户已经注册');
		$model = new Model('user');
		$obj = $model->where("email='$email'")->find();
		if(!$obj) $info = array('status'=>true,'msg'=>'');
		echo JSON::encode($info);
	}

	public function mobile()
	{
		$mobile = Filter::sql(Req::args('mobile'));
		$info = array('status'=>false,'msg'=>'此手机号已经注册');
		$model = new Model('customer');
		$obj = $model->where("mobile='$mobile'")->find();
		if(!$obj) $info = array('status'=>true,'msg'=>'');
		echo JSON::encode($info);
	}

	public function account()
	{

		$account = Req::args('account');
		if(Validator::email($account)){
			Req::args('email',$account);
			$this->email();
		}elseif(Validator::mobi($account)){
			Req::args('mobile',$account);
			$this->mobile();
		}elseif(Validator::name($account)){
			$info = array('status'=>false,'msg'=>'此用户名已存在');
			$model = new Model('user');
			$obj = $model->where("name='$account'")->find();
			if(!$obj) $info = array('status'=>true,'msg'=>'');
			echo JSON::encode($info);
		}else{
			$info = array('status'=>true,'msg'=>'');
			echo JSON::encode($info);
		}
	}

	public function verifyCode()
	{
		$info = array('status'=>false,'msg'=>'验证码错误！');
		$this->safebox = Safebox::getInstance();
		$code = $this->safebox->get($this->captchaKey);
		$verifyCode = Req::args("verifyCode");
		if($code == $verifyCode) $info = array('status'=>true,'msg'=>'');
		echo JSON::encode($info);
	}
	public function category_type()
	{
		$id = Filter::int(Req::args('id'));
		$json_array = array('type_id'=>"-1");
		if($id){
			$model = new Model("goods_category");
			$category = $model->where("id=".$id)->find();
			if($category)$json_array = array('type_id'=>$category['type_id']);
		}
		echo JSON::encode($json_array);
	}
	public function type_attr()
	{
		$id = Filter::int(Req::args('id'));
		$json_array = array();
		if($id){
			$model = new Model("goods_type");
			$type = $model->where("id=".$id)->find();
			if($type)$json_array = unserialize($type['attr']);
		}
		echo JSON::encode($json_array);
	}
	public function area()
	{
		$id = Filter::int(Req::args('id'));
		$json_array = array();
		if($id){
			$model = new Model("area");
			$area = $model->where("parent_id=".$id)->order('sort')->findAll();
			if($area) $json_array = $area;
		}
		echo JSON::encode($json_array);
	}
	private function _AreaInit($id, $level = '0')
	{
		$result = $this->model->table('area')->where("parent_id=".$id)->order('sort')->findAll();
		$list = array();
		if($result) {

			foreach($result as $key => $value) {
				$id = "o_".$value['id'];
				//$list["$id"]['i'] = $value['id'];
				//$list["$id"]['pid'] = $value['parent_id'];
				$list["$id"]['t'] = $value['name'];
				//$list["$id"]['level'] = $level;
				if($level<2)$list[$id]['c'] = $this->_AreaInit($value['id'], $level + 1);
			}
		}
		return $list;
	}
	public function areas()
	{
		$cache = CacheFactory::getInstance();
        $items = $cache->get("_AreaData");
        if($items == null)
        {
            $items = JSON::encode($this->_AreaInit(0));
            $cache->set("_AreaData",$items,315360000);
        }
        return $items;
	}
	public function area_data()
	{
		$result = $this->areas();
		echo ($result);
	}
	public function test()
	{
		$codebar = "BCGcode128";//$_REQUEST['codebar'];
		$color_black = new BCGColor(0, 0, 0);
		$color_white = new BCGColor(255, 255, 255);
		$drawException = null;
		try {
		    $code = new $codebar();//实例化对应的编码格式
		    $code->setScale(2); // Resolution
		    $code->setThickness(23); // Thickness
		    $code->setForegroundColor($color_black); // Color of bars
		    $code->setBackgroundColor($color_white); // Color of spaces
		    $text = Req::args('code'); //条形码将要数据的内容
		    $code->parse($text);
		} catch(Exception $exception) {
		    $drawException = $exception;
		}
		$drawing = new BCGDrawing('', $color_white);
		if($drawException) {
		    $drawing->drawException($drawException);
		} else {
		    $drawing->setBarcode($code);
		    $drawing->draw();
		}
		header('Content-Type: image/png');
		$drawing->finish(BCGDrawing::IMG_FORMAT_PNG);
	}
}
