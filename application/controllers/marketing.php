<?php
/**
 * 市场营销
 *
 * @author Crazy、Ly
 * @package AdminController
 */
class MarketingController extends Controller
{
	public $layout='admin';
	private $top = null;
	public $needRightActions = array('*'=>true);

	public function init()
	{
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
		$this->assign('manager',$this->safebox->get('manager'));

		$currentNode = $menu->currentNode();
        if(isset($currentNode['name']))$this->assign('admin_title',$currentNode['name']);
	}

	public function noRight()
	{
		$this->redirect("admin/noright");
	}

	//编辑捆绑促销
	public function bundling_save()
	{
		$id = Req::args('id');
		$goods_id = Req::args("goods_id");
		if(count($goods_id)<2){
			$this->msg = array("warning","捆绑促销商品数量至少2件！");
			$this->redirect('bundling_edit',false,Req::args());
			exit();
		}
		if(is_array($goods_id)){
			$goods_id = array_unique($goods_id);
			$goods_id = implode(',', $goods_id);
		}
		Req::args("goods_id",$goods_id);
		$model = new Model('bundling');
		$model->save();
		if($id){
			Log::op($this->manager['id'],"修改捆绑促销","管理员[".$this->manager['name']."]:修改了捆绑促销 ".Req::args('title'));
		}else{
			Log::op($this->manager['id'],"添加捆绑促销","管理员[".$this->manager['name']."]:添加了捆绑促销 ".Req::args('title'));
		}
		$this->redirect("bundling_list");
	}

	//删除捆绑促销
	public function bundling_del()
	{
		$model = new Model("bundling");
		$id = Req::args("id");
		if($id){
			$obj =  $model->where("id = $id")->find();
			$model->where("id = $id")->delete();
			if($obj)Log::op($this->manager['id'],"删除捆绑促销","管理员[".$this->manager['name']."]:删除了捆绑促销 ".$obj['title']);
		}
		$this->redirect("bundling_list");
	}

	//选择捆绑促销的商品
	public function bundling_goods_select()
	{
		$this->layout = "blank";
		$s_type = Req::args("s_type");
		$s_content = Req::args("s_content");
		$where = "1=1";
		if($s_content && $s_content!=''){
			if($s_type==1){
				$where .= " and goods_no = '{$s_content}'";
			}else if($s_type==2) {
				$where .= " and name like '{$s_content}%' ";
			}
		}
		$this->assign("s_type",$s_type);
		$this->assign("s_content",$s_content);

		$goods_id = Req::args("goods_id");
		if(is_array($goods_id)){
			$goods_id = implode(',', $goods_id);

		}
		if($goods_id) $where .= " and id not in($goods_id)";
		$id = Req::args('id');
		if(!$id  || $id=='') $id = 0;
		$this->assign('id',$id);
		$this->assign('goods_id',$goods_id);
		$this->assign("where",$where);
		$this->redirect();

	}

	public function radio_goods_select()
	{
		$this->layout = "blank";
		$s_type = Req::args("s_type");
		$s_content = Req::args("s_content");
		$where = "1=1";
		if($s_content && $s_content!=''){
			if($s_type==1){
				$where = "goods_no = '{$s_content}'";
			}else if($s_type==2) {
				$where = "name like '{$s_content}%' ";
			}
		}
		$this->assign("s_type",$s_type);
		$this->assign("s_content",$s_content);

		$id = Req::args('id');
		if(!$id  || $id=='') $id = 0;
		$this->assign('id',$id);
		$this->assign("where",$where);
		$this->redirect();

	}

	public function prom_goods_save()
	{
		$group = Req::args("group");
		$id = Req::args('id');
		if(is_array($group)){
			$group = implode(',', $group);
			Req::args("group",$group);
		}else{
			Req::args("group",'');
		}
		$model = new Model('prom_goods');
		if($id){
			$model->where("id=$id")->update();
			$last_id = $id;
			Log::op($this->manager['id'],"修改商品促销","管理员[".$this->manager['name']."]:修改了商品促销 ".Req::args('name'));
		}else{
			$last_id = $model->insert();
			Log::op($this->manager['id'],"添加商品促销","管理员[".$this->manager['name']."]:添加了商品促销 ".Req::args('name'));
		}
		$goods_id = Req::args("goods_id");

		$model->table("goods")->data(array('prom_id'=>0))->where("prom_id = $last_id")->update();
		if(is_array($goods_id)){
			$goods_id = implode(',', $goods_id);
			$where = " id in($goods_id)";
			$model->table("goods")->data(array('prom_id'=>$last_id))->where($where)->update();
		}
		$this->redirect("prom_goods_list");
	}

	public function prom_order_save()
	{
		$group = Req::args("group");
		if(is_array($group)){
			$group = implode(',', $group);
			Req::args("group",$group);
		}else{
			Req::args("group",'');
		}
		$id = Req::args("id");
		$model = new Model('prom_order');
		if($id){
			$model->where("id=$id")->update();
			Log::op($this->manager['id'],"修改订单促销","管理员[".$this->manager['name']."]:修改了订单促销 ".Req::args('name'));
		}else{
			$model->where("id=$id")->insert();
			Log::op($this->manager['id'],"添加订单促销","管理员[".$this->manager['name']."]:添加了订单促销 ".Req::args('name'));
		}
		$this->redirect("prom_order_list");
	}

	public function prom_goods_list()
	{
		$parse_type = array('0'=>'直接打折','1'=>'减价优惠','2'=>'固定金额出售','3'=>'买就赠优惠券','4'=>'买M件送N件');
		$this->assign("parse_type",$parse_type);
		$model = new Model('grade');
		$rows = $model->findAll();
		$grades = array(0=>'默认会员');
		foreach ($rows as $row) {
			$grades[$row['id']] = $row['name'];
		}
		$this->assign("grades",$grades);
		$this->redirect();
	}

	public function prom_goods_del()
	{
		$model = new Model();
		$id = Req::args("id");
		if($id){
			$model->table("goods")->data(array('prom_id'=>0))->where("prom_id = $id")->update();
			$obj =  $model->table('prom_goods')->where("id = $id")->find();
			$model->table('prom_goods')->where("id = $id")->delete();
			if($obj)Log::op($this->manager['id'],"删除商品促销","管理员[".$this->manager['name']."]:删除了商品促销 ".$obj['name']);
		}
		$this->redirect("prom_goods_list");
	}

	public function prom_order_del()
	{
		$model = new Model("prom_order");
		$id = Req::args("id");
		if($id){
			$obj =  $model->where("id = $id")->find();
			$model->where("id = $id")->delete();
			if($obj)Log::op($this->manager['id'],"删除订单促销","管理员[".$this->manager['name']."]:删除了订单促销 ".$obj['name']);
		}
		$this->redirect("prom_order_list");
	}

	public function prom_order_list()
	{
		$parse_type = array('0'=>'满额打折','1'=>'满额优惠金额','2'=>'满额送倍数积分','3'=>'满额送优惠券','4'=>'满额免运费');
		$this->assign("parse_type",$parse_type);
		$model = new Model('grade');
		$rows = $model->findAll();
		$grades = array(0=>'默认会员');
		foreach ($rows as $row) {
			$grades[$row['id']] = $row['name'];
		}
		$this->assign("grades",$grades);
		$this->redirect();
	}

	public function goods_select()
	{
		$this->layout = "blank";
		$s_type = Req::args("s_type");
		$s_content = Req::args("s_content");
		$where = "";
		if($s_content && $s_content!=''){
			if($s_type == 1){
				$where = " and goods_no = '{$s_content}'";
			}else if($s_type==2) {
				$where = " and name like '{$s_content}%' ";
			}
		}
		$this->assign("s_type",$s_type);
		$this->assign("s_content",$s_content);

		$goods_id = Req::args("goods_id");
		if(is_array($goods_id)){
			$goods_id = implode(',', $goods_id);
			$where .= " and id not in($goods_id)";
		}else{
			$where .= "";
		}
		$id = Req::args('id');
		if(!$id  || $id=='') $id = 0;
		$this->assign('id',$id);
		$this->assign("where",$where);
		$this->redirect();

	}

	public function goods_show()
	{
		$this->layout = "blank";
		$id = Req::args('id');
		$this->assign("id",$id);
		$this->redirect();
	}

	public function voucher_list()
	{
		$condition = Req::args('condition');
		$condition_str = Common::str2where($condition);
		if($condition_str)$this->assign("where",$condition_str);
		else $this->assign("where","1=1");
		$this->assign("condition",$condition);
		$parse_status = array(0=>'<b class="green">未使用</b>',1=>'<b>已使用</b>',2=>'<b class="red">临时锁定</b>',3=>'<s class="red"><b>禁用</b></s>');
		$this->assign("parse_status",$parse_status);
		$this->redirect();
	}

	public function voucher_csv()
	{
		$fields_array = array(
			'id'=>'ID编号',
			'name'=>'名称',
			'account'=>'账号',
			'password'=>'密码',
			'value'=>'面值',
			'start_time'=>'开始时间',
			'end_time'=>'到期时间',
			'status'=>'状态',
			'is_send'=>'发放情况'
			);
		$heading = array();
		$condition = Req::args('condition');
		$fields = Req::args('fields');
		$fields_key = array();
		if(is_array($fields)){
			foreach ($fields as $fied) {
				if(isset($fields_array[$fied])){
					$heading[] = $fields_array[$fied];
					$fields_key[] = $fied;
				}
			}
		}
		$condition_str = Common::str2where($condition);
		if($condition_str == null)$condition_str = " 1=1 ";
		if(empty($fields_key)){
			$fields_key = array_keys($fields_array);
			$heading = array_values($fields_array);
		}
		$model = new Model('voucher');
		$fields_str = implode(',', $fields_key);
		$vouchers = $model->fields($fields_str)->where($condition_str)->findAll();
		Http::exportCSV($heading,$vouchers,"vouchers_".date("Y_m_d"));


	}

	public function voucher_disabled()
	{
		$id = Req::args("id");
		$model = new Model('voucher');
		if(is_array($id)){
			$ids = implode(',', $id);
			$model->data(array('status'=>3))->where("id in($ids)")->update();
		}
		elseif ($id) {
			$model->data(array('status'=>3))->where("id = $id")->update();
		}
		$this->redirect("voucher_list");
	}

	public function voucher_send()
	{
		$id = Req::args("id");
		$model = new Model('voucher');
		if(is_array($id)){
			$ids = implode(',', $id);
			$model->data(array('is_send'=>1))->where("id in($ids)")->update();
		}
		elseif ($id) {
			$model->data(array('is_send'=>1))->where("id = $id")->update();
		}
		$this->redirect("voucher_list");
	}

	public function voucher_create()
	{
		$id = Req::args("id");
		$start_time = Req::args("start_time");
		$start_time = $start_time==null?date("Y-m-d"):$start_time;
		$end_time = Req::args("end_time");
		$end_time = $end_time==null?date("Y-m-d 23:59:59", strtotime("+30 days")):date("Y-m-d 23:59:59", strtotime($end_time));

		$model = new Model('voucher_template');
		$voucher_template = $model->where("id = $id")->find();
		if($voucher_template){
			$voucher_model = new Model('voucher');
			$num = Req::args('num');
			$i = 0;
			while ( $i < $num) {
				do{
					$account = strtoupper(CHash::random(10,'char'));
					$password = strtoupper(CHash::random(10,'char'));
					$voucher_template['account'] = $account;
					$voucher_template['password'] = $password;
					$voucher_template['start_time'] = $start_time;
					$voucher_template['end_time'] = $end_time;
					$obj = $voucher_model->where("account = '$account'")->find();
				}while($obj);
				unset($voucher_template['id'],$voucher_template['point']);
				$voucher_model->data($voucher_template)->insert();
				$i++;
			}
		}
		echo JSON::encode(array('status'=>'success','msg'=>'已成功生成['.$voucher_template['name'].']代金券('.$num.')张'));
	}

	public function voucher_template_validator()
	{
		$rules = array('name:required:模板名称不能为空!','value:float:面值必需是数据型格式!','point:int:积分必需为整数！','money:int:需满足的消费金额必需为整数！');
		$info = Validator::check($rules);
		return $info;
	}

}
