<?php
/**
 *分销管理类
 *
 * author Crazy、Ly
 * package DistributionController
 * 
 */
Class DistributionController extends Controller{
	public $layout='admin';
	private $top = null;
	public $needRightActions = array('*'=>true);
	private $manager;
	public function init(){
		$menu = new Menu();
		$this->assign('mainMenu',$menu->getMenu());
		$menu_index = $menu->current_menu();
		$this->assign('menu_index',$menu_index);
		$this->assign('subMenu',$menu->getSubMenu($menu_index['menu']));
		$this->assign('menu',$menu);
		$nav_act = Req::get('act')==null?$this->defaultAction:Req::get('act');
		$nav_act = preg_replace("/(_edit)$/", "_list", $nav_act);
		$this->assign('nav_link','/'.Req::get('con').'/'.$nav_act);
		$this->assign('node_index',$menu->currentNode());
		$this->safebox = Safebox::getInstance();
		$this->manager = $this->safebox->get('manager');
		$this->assign('manager',$this->safebox->get('manager'));

		$currentNode = $menu->currentNode();
        if(isset($currentNode['name']))$this->assign('admin_title',$currentNode['name']);
	}
	public function noRight(){
		// $this->redirect("/admin/noright");
		$this->layout = 'blank';
		if($this->is_ajax_request()){
			echo JSON::encode(array('status'=>'fail','msg'=>'没有该项操作权限!'));
		}else{
			$this->redirect("noright");
		}
	}

	public 	function agent_list(){
		$condition = Req::args("condition");
		$condition_str =  Common::str2where($condition);
		if($condition_str){
			$where = $condition_str;
		}else{
			$where = "1=1";
		}
		$this->assign("condition",$condition);
		$this->assign("where",$where);
		$this->redirect();
	}
	/**
	 * 分销代理保存
	 * @return [type] [description]
	 */
	public function agent_save(){
		$id = Req::args("id");
		$mobile = Req::args("mobile");
		$weixin = Req::args("weixin");
		$password = Req::args("password");
		$agent = new Model("agent");
		if($id){
			$ag = $agent->where("id=$id")->find();
			if($ag){
				$agent->where("id=$id")->update();
				Log::op($this->manager['id'],"修改代理","管理员[".$this->manager['name']."]:修改了代理".$mobile."的信息");
			}
			$this->redirect("agent_list");
		}else{
			$ag = $agent->where("mobile='$mobile' or weixin='$weixin'")->find();
			if($ag){
				$this->msg =array("error","手机号或微信号已经注册成为分销商！");
				$this->redirect("agent_edit",false);
				exit;
			}else{
				Req::args('password',md5($password));
				Req::args('reg_time',date('Y-m-d H:i:s',time()));
				Req::args('login_time',date('Y-m-d H:i:s',time()));
				$last_id = $agent->insert();
				Log::op($this->manager['id'],"添加代理","管理员[".$this->manager['name']."]:添加了会员 ".$mobile." 的信息");
			}
		}
		$this->redirect("agent_list");
	}


	/**
	 * 分销代理激活
	 * @return [type] [description]
	 */
	public function agent_audit(){
		$id =Req::args("id");
		$status =Filter::int(Req::args('status'));
		if($status!=0 && $status!=1) $status = 0;
		$model = new Model('agent');
		$model->data(array('status'=>$status))->where("id=$id")->update();
		$this->redirect("agent_list");
	}

	/**
	 * 分销代理密码修改
	 * @return [type] [description]
	 */
	public function agent_password(){
		$id = Req::post("id");
		$password = Req::post("password");
		$repassword = Req::post("repassword");
		$info = array('status'=>'fail');
		if($id && $passwordd &&$password);
		$model = new Model('agent');
		$flag = $model->where("id=$id")->data(array('password'=>md5($password)))->update();
		if($flag){
			$info = array('status'=>'success');
		}
		echo JSON::encode($info);
	}
	/**
	 * 分销代理删除
	 * @return [type] [description]
	 */
	public function agent_del(){
		$id =Req::args("id");
		if(is_array($id)){
			$cond = ' in ('.implode(",",$id).')';
		}else{
			$cond ="=$id";
		}
		$agents = $model->table("agent")->where("id $cond")->findAll();
		$model->table("agents")->where("id $cond")->delete();
		if($agents){
			$agents_name ="";
			foreach($agents as $ag){
				$agents_name .=$ag['mobile']."、";
			}
			$agents_name = trim($agents_name,'、');
		}
		Log::op($this->manager['id'],"删除会员","管理员[".$this->manager['name']."]:删除了会员 ".$agents_name);
	}

	/**
	 * 分销商品列表
	 * @return [type] [description]
	 */
	public function dispro_list(){
		$condition =Req::args("condition");
		$condition_str =Common::str2where($condition);
		if($condition_str){
			$this->assign("where",$condition_str);
		}else{
			$this->assign("where","1=1");
		}
		$this->assign("condition",$condition);
		$this->redirect();

	}
	/**
	 * 分销商品保存
	 * @return [type] [description]
	 */
	public function dispro_save(){
		$id = Req::args("id");
		$name = Req::args("name");
		$pro = new Model("dispro");
		if($id){
			$p = $pro->where("id = $id")->find();
			if($p){
				$pro->where("id = $id")->update();
				Log::op($this->manager['id'],"修改了分销商品","管理员[".$this->manager['name']."]:修改了分销商品".$name."的信息");
			}
			$this->redirect("dispro_list");
		}else{
			$p = $pro->where("name='$name'")->find();
			if($p){
				$this->msg =array("error","该商品已经被添加，请认真确认");
				$this->redirect("dispro_list",false);
				exit;
			}else{
				$imgs = is_array(Req::args("imgs"))?Req::args("imgs"):array();
				Req::args('imgs',serialize($imgs));
				Req::args('create_time',date("Y-m-d H:i:s"));
				$last_id = $pro->insert();
				Log::op($this->manager['id'],"添加分销商品","管理员[".$this->manager['name']."]:添加了分销商品".$name."的信息");
			}
		}
		$this->redirect("dispro_list");
	}

	/**
	 * 分销商品删除
	 * @return [type] [description]
	 */
	public function dispro_del(){
		$id = Req::args("id");
		if(is_array($id)){
			$cond = ' in ('.implode(",",$id).')';
		}else{
			$cond ="$id";
		}
		$model = new Model();
		$pro = $model->table("dispro")->where("id $cond")->findAll();
		$model->table('dispro')->where("id $cond")->delete();
		if($pro){
			$pros_name ="";
			foreach($pro as $p){
				$pros_name .= $p['name'].'、';
			}
			$pros_name =trim($pros_name,'、'); 
		}
		Log::op($this->manage['id'],"删除分销商品","管理员[".$this->manage['name']."]:删除了分销商品".$pros_name);
	}


	/**
	 * 分销商品上下架
	 * @return [type] [description]
	 */
	public function dispro_audit(){
		$id = Req::args("id");
		$status =Filter::int(Req::args('status'));
		if($status!=0&&$status!=1){
			$status=0;
		}
		$model = new Model('dispro');
		$model->data(array('status'=>$status))->where("id=$id")->update();
		$this->redirect("dispro_list");
	}

	/**
	 * 分销等级保存
	 * @return [type] [description]
	 */
	public function level_save(){
		$id = Req::args("id");
		$name = Req::args("name");
		$level = new Model("level");
		if($id){
			$lev = $level->where("id = $id")->find();
			if($lev){
				$level->where("id =$id")->update();
				Log::op($this->manager['id'],"修改了分销代理等级","管理员[".$this->manager['name']."]:修改了分销代理等级".$name."的信息");
			}
			$this->redirect("level_list");

		}else{
			$lev = $level->where("name='$name'")->find();
			if($lev){
				$this->msg =array("error","该等级已经被添加,请认真确认!");
				$this->redirect("level_list",false);
				exit;
			}else{
				$last_id = $level->insert();
				Log::op($this->manage['id'],"添加分销等级","管理员[".$this->manager['name']."]:添加了分销代理等级".$name."的信息");
				
			}
		}
		$this->redirect("level_list");
	}

	/**
	 * 分销等级审核
	 * @return [type] [description]
	 */
	public function level_audit(){
		$id = Req::args("id");
		$is_alow =Filter::int(Req::args('is_alow'));
		if($is_alow!=0&&$is_alow!=1){
			$is_alow =0;
		}
		$model =new Model('level');
		$model->data(array('is_alow'=>$is_alow))->where("id=$id")->update();
		$this->redirect("level_list");
	}

	/**
	 *分销等级删除
	 * @return [type] [description]
	 */
	public function level_del(){
		$id = Req::args("id");
		if(is_array($id)){
			$cond = ' in ('.implode(",",$id).')';
		}else{
			$cond = "$id";
		}
		$model = new  Model();
		$level =$model->table("dis_level")->where("id $cond")->findAll();
		$model->table('dis_level')->where("id $cond")->delete();
		if($level){
			$levs_name = "";
			foreach($level as $lev){
				$levs_name .=$lev['name'].'、';
			}
			$levs_name = trim($levs_name,'、');
		}
		Log::op($this->manage['id'],"删除等级","管理员[".$this->manage['name']."]:删除了等级".$levs_name); 
	}


	/**
	 * [rebate_set 分销返利设置]
	 * @return [type] [description]
	 */
	public function rebate_set_save(){
		$group = Req::args('group');
		$config = Config::getInstance();
		if(Req::args('submit')!=null)
		{
			$configService = new ConfigService($config);
			if(method_exists($configService,$group))
			{
				$result = $configService->$group();
				if(is_array($result))
				{
					$this->assign('message',$result['msg']);
				}
				else if($result ==true)
				{
					$this->assign('message','信息保存成功！');
				}
			}
		}
		$this->assign('data',$config->get($group));
		$this->redirect('rebate_set',false);
	}


	/**
	 * [rebate_list 分销返利列表]
	 * @return [type] [description]
	 */
	public function rebate_list(){
		$condition = Req::args("condition");
		$condition_str =Common::str2where($condition);
		if($condition_str){
			$this->assign("where",$condition_str);
		}else{
			$this->assign("where","1=1");
		}
		$this->assign("condition",$condition);
		$this->redirect();
	}

	/**
	 * 分销返利审核
	 * @return [type] [description]
	 */
	public function rebate_audit(){
		$id = Req::args("id");
		$staus =Filter::int(Req::args('status'));
		if($status){
			$model = new Model('rebate');
			$model->data(array('status'=>$status))->where("id =$id")->update();
			$this->redirect('rebate_list');
		}
	}
	/**
	 * 分销返利删除
	 * @return [type] [description]
	 */
	public function rebate_del(){
		$id = Req::args("id");
		if(is_array($id)){
			$cond = ' in ('.implode(",",$id).')';

		}else{
			$cond ="$id";
		}
		$model = new  Model();
		$rebate = $model->table("rebate")->where("id $cond")->findAll();
		$model->table("rebate")->where("id $cond")->delete();
		if($rebate){
			$rebate_name ="";
			foreach($rebate as $reb){
				$rebate_name .=$reb['rebate_no'].'、'; 
			}
			$rebate_name = trim($rebate_name,'、');
		}
		Log::op($this->manage['id'],"删除返利记录","管理员[".$this->manage['name']."]:删除了返利记录".$rebate_name);
	}


	/**
	 * 分销订单列表
	 * @return [type] [description]
	 */
	public function disorder_list(){
		$condition =Req::args("condition");
		$condition_str =Common::str2where($condition);
		if($condition_str){
			$this->assign("where",$condition_str);
		}else{
			$this->assign("where","1=1");
		}
		$this->assign("condition",$condition);
		$this->redirect();
	}

	/**
	 * 分销订单审核
	 * @return [type] [description]
	 */
	 //  'rebate' => 
  // array (
  //   'rebate_line' => '100',
  //   'rebate_one' => '10',
  //   'rebate_two' => '20',
  //   'rebate_three' => '30',
  //   'rebate_level' => '1',
  //   'rebate_status' => '0',
  // ),
	public function disorder_audit(){
		$id =Req::args("id");
		$status = Filter::int(Req::args('status'));
		if($status!=0&&$status!=1){
			$model = new Model('disorder');
			$model->data(array('status'=>$staus))->where("id=$id")->update();
			$disorder = $model->where('id =$id')->find()
			$rebate = Config::getInstance()->get('rebate');
			var_dump($disorder,$rebate);
			exit;
			$this->redirect("disorder_list");
		}
	}
	/**
	 * 分销订单删除
	 * @return [type] [description]
	 */
	public function disorder_del(){
		$id = Req::args("id");
		if(is_array($id)){
			$cond = ' in ('.implode(",",$id).')';
		}else{
			$cond = "$id";
		}
		$model = new Model();
		$disorder = $model->table("disorder")->where("id $cond")->findAll();
		$model->table('disorder')->where("id $cond")->delete();
		if($disorder){
			$orders_name ="";
			foreach($orders_name as $orde){
				$orders_name .=$orde['order_no'].'、';
			}
			$orders_name =trim($orders_name,'、');
		}
		Log::op($this->manage['id'],"删除订单记录","管理员[".$this->manage['name']."]:删除了订单记录".$orders_name);
	}


}