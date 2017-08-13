<?php
/**
 * description...
 *
 * @author Crazy、Ly
 * @package AdminController
 */
class AdminController extends Controller
{
	public $layout='admin';
	private $top = null;
	public $needRightActions = array('*'=>true);
	private $manager;
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
		$this->manager = $this->safebox->get('manager');
		$this->assign('manager',$this->safebox->get('manager'));

		$currentNode = $menu->currentNode();
		if(isset($currentNode['name']))$this->assign('admin_title',$currentNode['name']);
	}
	public function noRight()
	{
		$this->layout = 'blank';
		if($this->is_ajax_request()){
			echo JSON::encode(array('status'=>'fail','msg'=>'没有该项操作权限!'));
		}else{
			$this->redirect("noright");
		}
	}
	//后台首页
	public function index()
	{
		$model = new Model('user');
		$user = $model->fields("count(id) as num")->query();
		$goods = $model->table("goods")->fields("count(id) as num")->query();
		$warning = $model->table("goods as go")->fields("count(go.id) as num")->join("left join products as pd on go.id = pd.goods_id")->where("go.is_online=0 and pd.store_nums<=pd.warning_line")->query();

		$rows = $model->table("order")->fields("count(id) as num,type")->group('type')->query();
		$num = 0;
		$orders = array();
		foreach ($rows as $row) {
			$orders[$row['type']] = $row['num'];
			$num += $row['num'];
		}
		$orders_num = $num;
		$ask = $model->table("ask")->fields("count(id) as num")->where("status=0")->query();
		$withdraw = $model->table("withdraw")->fields("count(id) as num")->where("status=0")->query();
		$returns = $model->table("doc_returns")->fields("count(id) as num")->where("status=0")->query();
		$review = $model->table("review")->fields("count(id) as num")->where("point<3")->query();
		$refund = $model->table("doc_refund")->fields("count(id) as num")->where("pay_status=0")->query();

		$shipped= $model->table("order")->fields("count(id) as num")->where("status<4 and pay_status=1 and delivery_status=0")->query();

		$this->assign("user_num",$user[0]['num']);
		$this->assign("goods_num",$goods[0]['num']);
		$this->assign("warning_num",$warning[0]['num']);
		$this->assign("withdraw_num",$withdraw[0]['num']);
		$this->assign("orders",$orders);
		$this->assign("orders_num",$orders_num);
		$this->assign("ask_num",$ask[0]['num']);
		$this->assign("returns_num",$returns[0]['num']);
		$this->assign("review_num",$review[0]['num']);
		$this->assign("refund_num",$refund[0]['num']);
		$this->assign("shipped_num",$shipped[0]['num']);
		$this->redirect();
	}
	//登录验证
	public  function check()
	{

		$this->safebox = Safebox::getInstance();
		$this->title='后台登录';


		$code = $this->safebox->get($this->captchaKey);
		if($code != strtolower(Req::args($this->captchaKey)))
		{
			$this->msg='验证码错误！';
			$this->layout = "";
			$this->redirect('login',false);
		}
		else
		{
			$manager = new Manager(Req::args('name'),Req::args('password'));
			$this->msg='验证码错误！';
			if($manager->getStatus() == 'online')
			{
				$back = Req::args('callback');
				$model = new Model("manager");
				$ip = Chips::getIP();
				$model->data(array('last_ip'=>$ip,'last_login'=>date("Y-m-d H:i:s")))->where("id=".$manager->id)->update();

				$NoticeService = new NoticeService();
				$template_data = array('ip'=>$ip,'time'=>date('Y-m-d H:i:s'),'login_type'=>'PC','manager'=>$manager->name);
				$NoticeService->send('admin_login',$template_data);

				if($back === null) $back = $this->defaultAction;
				$this->redirect($back,true);
			}
			else
			{
				$this->msg='用户名或者密码错误';
				$this->layout = "";
				$this->redirect('login',false);
			}
		}
	}
	function class_config_save()
	{
		$class_name = Filter::sql(Req::args('class_name'));
		$status = Filter::int(Req::args('status'));
		$config_form = call_user_func(array("$class_name","config"));//$class_name::config();
		$config = array();
		foreach ($config_form as $item) {
			$config[$item['field']] = Req::args($item['field']);
		}
		$model = new Model('class_config');
		$model->data(array('status'=>$status,'config'=>serialize($config)))->where("class_name='".$class_name."'")->update();
		$this->redirect('class_config_list');
	}
	//主题管理
	function theme_list()
	{
		$theme_path = APP_ROOT.'/themes/';
		$themes = array();
		if(is_dir($theme_path)){
			if($dh = opendir($theme_path)){
				while (($file = readdir($dh))!==false) {
					if($file!='.' && $file!='..' && is_dir($theme_path.$file)){
						$theme_path_file =  $theme_path.$file."/info.php";
						if(is_file($theme_path_file)){
							$info = include($theme_path_file);
							if(isset($info['type']) && $info['type']=='mobile')$themes['mobile'][] = array('file'=>$file,'info'=>$info);
							else $themes['pc'][] = array('file'=>$file,'info'=>$info);
						}

					}
				}
				closedir($dh);
			}
		}
		$config_path = APP_CODE_ROOT.'config/config.php';
		$config = require($config_path);
		if(isset($config['theme'])) $theme_pc = $config['theme'];
		else $theme_pc = 'default';
		if(isset($config['themes_mobile'])) $themes_mobile = $config['themes_mobile'];
		else $themes_mobile = 'default';
		$this->assign("current_theme_pc",$theme_pc);
		$this->assign("current_theme_mobile",$themes_mobile);
		$theme_pc_info = isset($themes['pc'])?$themes['pc']:array();
		$theme_mobile_info = isset($themes['mobile'])?$themes['mobile']:array();
		$this->assign('themes_pc',$theme_pc_info);
		$this->assign('themes_mobile',$theme_mobile_info);
		$this->redirect();
	}
	//设置主题
	function set_theme()
	{
		$theme = Req::args('theme');
		$type = Req::args('type');
		$theme_path = APP_ROOT.'/themes/';
		$info = array('status'=>'fail','msg'=>'主题设置失败');
		if(file_exists($theme_path.$theme)){
			$config_path = APP_CODE_ROOT.'config/config.php';
			$config = require($config_path);
			if($type=='mobile')
				$config['themes_mobile'] = $theme;
			else
				$config['theme'] = $theme;
			$str = var_export($config,true);
			file_put_contents($config_path, '<?php return '.$str.';?>');
			$info = array('status'=>'success','msg'=>'主题设置成功');
		}
		echo JSON::encode($info);
	}
	public function area_list()
	{
		$this->redirect();
	}
	//地区操作
	public function area_op()
	{
		$id = Filter::int(Req::args('id'));
		$op = Req::args('op');
		$model = new Model('area');
		$cache = CacheFactory::getInstance();
		$info = array('status'=>'success','msg'=>'');
		switch ($op) {
			case 'up':
			case 'down':{
				$area = $model->where('id='.$id)->find();
				$objs = $model->where('parent_id='.$area['parent_id'])->order('sort')->findAll();
				$perv = $curr = $next = false;
				$last = end($objs);
				reset($objs);
				foreach ($objs as $obj) {
					if($area['id']==$obj['id']){
						$curr = $obj;
						if($curr['id']==$last['id']){
							$next = false;
							end($objs);
							$prev = prev($objs);
						}
						else{
							$next = current($objs);
							$prev = prev($objs);
							$prev = prev($objs);
						}
						break;
					}
				}
				if($op=='up'){
					if($prev){
						$curr_sort = $prev['sort'];
						$prev_sort = $curr['sort'];
						$model->data(array('sort'=>$curr_sort))->where('id='.$curr['id'])->update();
						$model->data(array('sort'=>$prev_sort))->where('id='.$prev['id'])->update();
						$cache->delete("_AreaData");
					}
				}else{
					if($next){
						$curr_sort = $next['sort'];
						$next_sort = $curr['sort'];
						$model->data(array('sort'=>$curr_sort))->where('id='.$curr['id'])->update();
						$model->data(array('sort'=>$next_sort))->where('id='.$next['id'])->update();
						$cache->delete("_AreaData");
					}
				}
				$info = array('status'=>'success','msg'=>'排序已更新');
				break;
			}
			case 'add':
			{
				$objs = $model->fields('max(sort) as sort')->where('parent_id='.$id)->query();
				if($objs){
					$sort = $objs[0]['sort'];
					$sort++;
				}else{
					$sort = 1;
				}
				$name = Filter::sql(Req::args('name'));
				$model->data(array('name'=>$name,'parent_id'=>$id,'sort'=>$sort))->insert();
				$cache->delete("_AreaData");
				$info = array('status'=>'success','msg'=>'成功添加节点');
				break;
			}
			case 'edit':{
				$name = Filter::sql(Req::args('name'));
				$model->data(array('name'=>$name))->where('id='.$id)->update();
				$cache->delete("_AreaData");
				$info = array('status'=>'success','msg'=>'节点已更新');
				break;
			}
			case 'del':{
				$obj = $model->where('parent_id='.$id)->find();
				if(!$obj){
					$model->where('id='.$id)->delete();
					$cache->delete("_AreaData");
					$info = array('status'=>'success','msg'=>'节点已经删除');
				}else{
					$info = array('status'=>'fail','msg'=>'子节点还有节点，无法删除');
				}
				break;
			}
		}
		echo JSON::encode($info);
	}
	public function payment_list()
	{
		$model = new Model('payment as pa');
		$list = $model->join("left join pay_plugin as pi on pa.plugin_id = pi.id")->fields("pa.id,pa.plugin_id,pa.pay_name,pa.status,pi.description,pi.logo,pi.class_name")->order('pa.sort desc')->findAll();
		$this->assign("payment_list",$list);
		$this->redirect('payment_list');
	}
	public function payment_validator()
	{
		$fee_type = Req::args("fee_type");
		if($fee_type==2)Req::args("pay_fee",Req::args("pay_fee_fix"));
		$plugin_id = Filter::int(Req::args('plugin_id'));
		$model = new Model("pay_plugin");
		$pay_plugin = $model->where("id=$plugin_id")->find();
		$class_name = 'pay_'.$pay_plugin['class_name'];
		$fields = call_user_func(array("$class_name","config"));//$class_name::config();
		$config = array();
		foreach($fields as $field)
		{
			$config[$field['field']] = Filter::sql(trim(Req::args($field['field'])));
		}
		Req::args('config',serialize($config));
	}
	public function payment_edit()
	{
		$id = Filter::int(Req::args('id'));
		$plugin_id = Filter::int(Req::args('plugin_id'));

		if($id){
			$model = new Model("payment");
			$payment = $model->where("id = $id")->find();
			$pay_plugin = $model->table("pay_plugin")->where("id=".$payment['plugin_id'])->find();
			$class_name = 'pay_'.$pay_plugin['class_name'];
			$this->assign("config_form",call_user_func(array("$class_name","config")));
			$this->assign("pay_plugin",$pay_plugin);

			$this->redirect("payment_edit",false,$payment);
		}else if($plugin_id){
			$model = new Model("pay_plugin");
			$pay_plugin = $model->where("id=$plugin_id")->find();
			$class_name = 'pay_'.$pay_plugin['class_name'];
			$this->assign("config_form",call_user_func(array("$class_name","config")));
			if($pay_plugin){
				$this->assign("pay_plugin",$pay_plugin);
				$this->redirect("payment_edit");
			}else{
				$this->redirect("payment_list");
			}
		}else{
			$this->redirect("payment_list");
		}

	}
    //区域列表
	public function zoning_list()
	{
		$model = new Model('area');
		$rows = $model->where("parent_id = 0")->findAll();
		$parse_province = array();
		foreach ($rows as $row) {
			$parse_province[$row['id']] = $row['name'];
		}
		$selected_provinces = '';
		$rows = $model->table("zoning")->findAll();
		foreach ($rows as $row) {
			$selected_provinces .= $row['provinces'].',';
		}
		$selected_provinces =  explode(',',$selected_provinces);
		$selected_provinces = array_flip($selected_provinces);
		$this->assign('selected_provinces',$selected_provinces);
		$this->assign('parse_province',$parse_province);
		$this->redirect();
	}
	//区域编辑
	public function zoning_edit()
	{
		$this->layout = "blank";
		$id = intval(Req::args('id'));

		$model = new Model('zoning');
		$obj = array();
		if($id){
			$rows = $model->where("id!=$id")->findAll();
			$obj = $model->where("id=$id")->find();

		}
		else $rows = $model->findAll();

		$selected_provinces = '';
		foreach ($rows as $row) {
			$selected_provinces .= $row['provinces'].',';
		}
		$selected_provinces =  explode(',',$selected_provinces);
		$selected_provinces = array_flip($selected_provinces);
		$this->assign('selected_provinces',$selected_provinces);
		$this->redirect("zoning_edit",false,$obj);
	}
	//区域划分保存
	public function zoning_save()
	{
		$id = Req::args('id');
		$provinces = Req::args('provinces');
		if(is_array($provinces)){
			$provinces = implode(',', $provinces);
			Req::args("provinces",$provinces);
		}
		$model = new Model('zoning');
		$model->save();
		$this->redirect("zoning_list");
	}
	//设定默认运费
	public function fare_use()
	{
		$id = Filter::int(Req::args('id'));
		if($id){
			$model = new Model("fare");
			$model->data(array('is_default'=>0))->update();
			$model->data(array('is_default'=>1))->where("id=$id")->update();
		}
		$this->redirect("fare_list");
	}

	//提醒功能是否支持检测
	public function notice_template_validator()
	{
		$style = Req::args('style');
		$status = Req::args('status');
		$right = true;
		$style_name = "";
		if($style=='weixin'){
			if(!class_exists("WeChat")) $right = false;
			$style_name = "微信";
		}else if($style=='sms'){
			if(!class_exists("SMS")) $right = false;
			$style_name = "短信";
		}
		if(!$right && $status==1) return array('msg'=>'你使用的版本不支持'.$style_name.'提醒功能，请不要开启');
	}

	//提醒管理
	public function notice_template_list()
	{
		$model = new Model('notice_template');
		$objs = $model->findAll();
		$notices = array();
		if($objs){
			foreach ($objs as $obj) {
				$notices[$obj['key_id'].'_'.$obj['obje']][]=$obj;
			}
		}
		$this->assign('notices',$notices);
		$this->redirect();
	}
	//运费
	public function fare_save()
	{
		$zoning = Req::args("zoning");
		$f_weight = Req::args("f_weight");
		$f_price = Req::args("f_price");
		$s_weight = Req::args("s_weight");
		$s_price = Req::args("s_price");
		$zoning_name = Req::args("zoning_name");

		$zoning_info = array();
		if(is_array($zoning)){
			foreach ($zoning as $key => $value) {
				$row = array();
				$row['area'] = trim($value,',');
				$row['f_weight'] = $f_weight[$key];
				$row['f_price'] = $f_price[$key];
				$row['s_weight'] = $s_weight[$key];
				$row['s_price'] = $s_price[$key];
				$row['names'] = trim($zoning_name[$key],',');
				$zoning_info[] = $row;
			}
		}
		$zoning_info = serialize($zoning_info);
		Req::args("zoning",$zoning_info);
		$model = new Model('fare');
		$model->save();
		$this->redirect("fare_list");
	}
	//区域选择
	public function fare_show_area()
	{
		$selected_city = Req::args("selected_city");
		$current_city = Req::args("current_city");
		$this->layout = 'blank';
		$model = new Model("area");
		$rows = $model->where("parent_id = 0")->findAll();
		$areas = array();
		foreach ($rows as $row) {
			$areas[$row['id']] = $row;
		}
		$rows = $model->table("zoning")->findAll();
		$zoning = array();
		foreach ($rows as $row) {
			$provinces = explode(',',$row['provinces']);
			$tem = array();
			foreach ($provinces as $province) {
				$tem[] = $areas[$province];
			}
			$zoning[$row['id']] = $row;
			$zoning[$row['id']]['zoning'] = $tem;
		}
		$this->assign("zoning",$zoning);
		$this->assign("selected_city",','.$selected_city.',');
		$this->assign("current_city",','.$current_city.',');
		$this->redirect();
	}
	//保存管理员
	public function manager_save()
	{
		$id = Req::args("id");
		$name = Req::args("name");
		$password = Req::args("password");
		$roles = Req::args("roles");

		$managerModel = new Model("manager");
		$model = new Model('roles');
		if($roles=='administrator') $roles_name = '超级管理员';
		else {
			$roles_obj = $model->where("id=".$roles)->find();
			$roles_name = $roles_obj['name'];
		}

		if($id){
			$user = $managerModel->where("id=$id")->find();
			if($user){
				if($roles){
					$managerModel->data(array('roles'=>$roles))->where("id=$id")->update();
					Log::op($this->manager['id'],'修改管理员角色','修改管理员【'.$user['name'].'】的角色为【'.$roles_name.'】！');
				}
			}
		}else{
			$user = $managerModel->where("name = '$name'")->find();
			if($user){
				$this->msg=array("error","用户名已经存在！");
				$this->redirect("manager_edit",false);
				exit;
			}else{
				$validcode = CHash::random(8);
				$key = md5($validcode);
				$password = substr($key,0,16).$password.substr($key,16,16);
				$password = md5($password);
				$managerModel->data(array('name'=>$name,'password'=>$password,'roles'=>$roles,'validcode'=>$validcode))->insert();
				Log::op($this->manager['id'],'添加管理员','添加管理员【'.$name.'】,角色为【'.$roles_name.'】！');
			}

		}
		$this->redirect("manager_list");
	}
	//删除管理员
	public function manager_del()
	{
		$id = Req::args('id');
		$model = new Model("manager");
		$manager = $model->where("id=$id")->find();
		if($manager)Log::op($this->manager['id'],'删除管理员','删除管理员【'.$manager['name'].'】！');
		$model->where("id=$id")->delete();
		$this->redirect("manager_list");

	}
	//修改管理员密码
	public function manager_password()
	{
		$id = Req::post("id");
		$password = Req::post("password");
		$repassword = Req::post("repassword");
		$info = array('status'=>'fail','msg'=>'密码修改失败');
		if($id && $password && $password == $repassword){
			$model = new Model("manager");
			$validcode = CHash::random(8);
			$key = md5($validcode);
			$password = substr($key,0,16).$password.substr($key,16,16);
			$password = md5($password);


			$flag = $model->where("id=$id")->data(array('password'=>$password,'validcode'=>$validcode))->update();
			if($flag)$info = array('status'=>'success');
			$manager = $model->where("id=$id")->find();
			Log::op($this->manager['id'],'修改管理员密码','修改管理员【'.$manager['name'].'】的密码！');
		}
		echo JSON::encode($info);

	}
	//编辑角色
	public function roles_edit()
	{
		$id = Req::args("id");
		$model = new Model("resources");
		$rows = $model->findAll();
		$resources = array();
		foreach ($rows as $row) {
			$resources[$row['group']][]=$row;
		}
		$this->assign('resources',$resources);

		$role_rights = '';
		if($id){
			$role = $model->table('roles')->where("id=$id")->find();
			if($role){
				$role_rights = $role['rights'];
			}
			$data = $role;
		}
		else $data = Req::args();
		$this->assign("rights",$role_rights);

		$this->redirect("roles_edit",false,$data);
	}
	//角色保存
	public function roles_save()
	{
		$id = Req::args('id');
		$right = Req::args("right");
		if(is_array($right)) $right = implode(',', $right);
		$model = new Model("resources");
		$res = $model->where("id in($right)")->findAll();
		$rights = '';
		foreach ($res as $re) {
			$rights .= ','.$re['right'];
		}
		$rights = explode(',', trim($rights,','));
		$rights = array_unique($rights);
		$rights = implode(',', $rights);
		Req::args('rights',$rights);
		$model = new Model("roles");
		if($id){
			$model->where("id=$id")->update();
		}
		else $model->insert();
		$this->redirect("roles_list");
	}
	//权限资源保存
	function resources_save()
	{
		$id = Req::args("id");
		$right = Req::args("right");
		if(is_array($right))$right = implode(',', $right);
		Req::args('right',$right);
		$model = new Model("resources");
		$model->save();
		$this->redirect("resources_list");
	}
	//列出某个控制器的action动作和视图
	function list_action()
	{
		$controller_name     = Req::args('controller_name');
		if($controller_name != '')
		{
			$base_controller = get_class_methods('Controller');
			$current_controller  = get_class_methods($controller_name."Controller");
			$controller_action  = array_diff($current_controller,$base_controller);
			echo JSON::encode($controller_action);
		}
	}

	//数据库表列表页
	function tables_list(){
		$model = new Model();
		$tables = $model->query("show table status");
		$this->assign("tables",$tables);
		$this->redirect();
	}
	//数据库表备份操作
	function tables_back()
	{
		$msg = array("warning","必需选择对应的表，才能进行备份！");
		$tables = Req::args("tables");
		if($tables){
			$backup = new Backup();
			$file_name = date('YmdH').'_'.rand(1000,9999).'_'.rand(1000,9999).'.sql';
			$backup->back($tables,$file_name);
			if($backup->back($tables,$file_name)){
				$msg=array("success","备份成功！");
			}
			else $msg = array("error","备份失败！");
		}
		if($msg[0]=="success"){
			Log::op($this->manager['id'],'备份数据库','管理员【'.$this->manager['name'].'】,备份了数据库，文件名为：'.$file_name);
			$this->redirect('back_list',false,array('msg'=>$msg));
		}
		else{
			$this->msg = $msg;
			$this->redirect('tables_list',false);
		}
	}
	//备份列表页
	function back_list()
	{
		$database_path = Tiny::getPath('database');
		$files = glob($database_path . '*.sql');
		$this->assign('files',$files);
		$database_url = Tiny::getPath('database_url');
		$this->assign("database_url",$database_url);
		$this->redirect();
	}
	//备份下载操作
	function down()
	{
		$database_path = Tiny::getPath('database');
		$backs = Req::args("back");
		Http::download($database_path.$backs,$backs);
	}
	// 备份压缩操作
	function zip()
	{
		$database_path = Tiny::getPath('database');
		$backs = Req::args("back");
		if(!empty($backs)){
			if(is_array($backs))
			{
				$len = count($backs);
				for($i=0;$i<$len;$i++) {
					$backs[$i] = $database_path.$backs[$i];
				}
			}
			if(file_exists($database_path."sql.zip"))unlink($database_path."sql.zip");
			Http::zip($backs,$database_path."sql.zip");
			Http::download($database_path."sql.zip",date('YmdH').'_'.rand(1000,9999).".zip");
		}
		else{
			$this->msg = array("warning",'必需选择文件，才能进行打包下载！');
			$this->redirect("back_list",false);
		}
	}
	// 备份删除操作
	function back_del()
	{
		$database_path = Tiny::getPath('database');
		$backs = Req::args("back");
		if(!empty($backs)){
			if(is_array($backs))
			{
				foreach ($backs as $back) {
					unlink($database_path.$back);
				}
			}
			else unlink($database_path.$backs);
			$this->redirect("back_list");
		}else{
			$this->msg = array("warning",'必需选择文件，才能进行删除操作！');
			$this->redirect("back_list",false);
		}

	}
	//备份恢复
	function back_recover()
	{
		$msg = array('error','恢复失败!');
		$back = Req::args("back");
		$database_path = Tiny::getPath('database');
		if(is_file($database_path.$back)){
			$backup = new Backup();
			$sqls = $backup->parseSql($database_path.$back);
			if($backup->install($sqls)){
				$msg = array('success','恢复成功!');
				Log::op($this->manager['id'],'恢复数据库','管理员【'.$this->manager['name'].'】,使用文件：'.$back.'恢复了数据库。');
			}
		}
		$this->msg =  $msg;
		$this->redirect("back_list",false);
	}
	//上传图片
	function upload_image()
	{
		$upfile_path = Tiny::getPath("uploads");
		$upfile_url = Tiny::getPath("uploads_url");
		$upfile = new UploadFile('imgFile',$upfile_path,'10m');
		$upfile->save();
		$info = $upfile->getInfo();
		$result = array();
		if($info[0]['status']==1){
			$result = array('error'=>0,'url'=>$upfile_url.$info[0]['path']);
		}
		else{
			$result = array('error'=>1,'message'=>$info[0]['msg']);
		}
		echo JSON::encode($result);
	}
	//上传SQL文件恢复
	function upload_recover()
	{
		$upfile_path = Tiny::getPath("uploads");
		$upfile = new UploadFile('sqlfile',$upfile_path,'100m','.sql');
		$upfile->save();
		$info = $upfile->getInfo();
		$msg = array("error","恢复失败！");

		if($info[0]['status']==1){
			$file_path = $upfile_path.$info[0]['path'];
			$backup = new Backup();
			$sqls = $backup->parseSql($file_path);
			if($backup->install($sqls)){
				Log::op($this->manager['id'],'恢复数据库','管理员【'.$this->manager['name'].'】,通过上传文件的方式,恢复了数据库。');
				$msg = array("success","恢复成功！");
				unlink($file_path);
			}
		}
		$this->msg = $msg;
		$this->redirect("back_list",false);
	}
	//版本升级
	public function update()
	{
		$updateFile = Tiny::getPath('data').'update.php';
		$this->assign('status','0');
		if(file_exists($updateFile)){
			$updateInfo = include($updateFile);
			if(isset($updateInfo['version'])){
				$version = $updateInfo['version'];
				$versionFile = APP_CODE_ROOT.'version.php';
				$currentVersion = include($versionFile);
				if($currentVersion == $version[0]){
					$do = Req::args('do');
					if($do == 'yes'){
						$dbinfo = DBFactory::getDbInfo();
						$this->assign('status','1');
						if(isset($updateInfo['sql'][$dbinfo['type']]))
						{
							$sqls = $updateInfo['sql'][$dbinfo['type']];
							$db = DBFactory::getInstance();
							if(is_array($sqls)) foreach($sqls as $sql) $db->doSql($sql);
							File::putContents($versionFile,"<?php return '{$version[1]}';?>");
							unlink($updateFile);
							$this->assign('info','升级成功！');
						}else{
							$this->assign('info','不支持'.$dbinfo['type'].'数据库类型的升级！');
						}
					}else{
						$this->assign('info','系统可从当前版本:'.$currentVersion.'升级到'.$version[1]);
					}

				}else{
					$this->assign('status','-1');
					$this->assign('info','没有可升级的信息!');
				}
			}else{
				$this->assign('status','-1');
				$this->assign('info','没有可升级的信息!');
			}
		}else{
			$this->assign('status','-1');
			$this->assign('info','没有可升级的信息！');
		}
		$this->redirect();
	}
	//登录
	function login()
	{
		$this->layout = '';
		$this->redirect();
	}
	public function clear_act()
	{
		$type = Req::args('type');
		$info = array('status'=>'fail','msg'=>'缓存清理失败!');
		if($type == 'data'){
			if(File::rmdir(APP_ROOT.'cache')){
				$info = array('status'=>'success','msg'=>'数据缓存已成功清理!');
			}
		}else if($type=='theme'){
			if(File::rmdir(APP_ROOT.'runtime')){
				$info = array('status'=>'success','msg'=>'模板缓存已成功清理!');
			}
		}else{
			if(File::rmdir(APP_ROOT.'runtime') && File::rmdir(APP_ROOT.'cache')){
				$info = array('status'=>'success','msg'=>'数据及模板缓存已成功清理!');
			}
		}
		echo JSON::encode($info);
	}
    //清理缓存
	public function clear()
	{
		$this->redirect();
	}
    //配制处理action
	public function config()
	{
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
		$this->redirect('config_'.$group,false);
	}
	//图库文件
	function photoshop()
	{
		$this->layout = '';
		$this->redirect();
	}
	//图库图片上传
	function photoshop_upload()
	{
		$id = Req::args('id');

		$info = array('jsonrpc' =>'2.0',"id"=>$id);

		$file = $_FILES['upfile'];
		if($file['error']==4){
			$info['error']=array('code'=>'101','message'=>'请选择文件后再上传！');
		}
		else if($file['error']==1){

			$info['error']=array('code'=>'102','message'=>'文件超出了php.ini文件指定大小！');
		}
		else if($file['size']>0){
			$key = md5_file($file['tmp_name']);
			$gallery = new Model('gallery');
			$img = $gallery->where("`key`='".$key."'")->find();
			if(!$img){
				$upfile_path = Tiny::getPath("uploads");
				$upfile_url = preg_replace("|^".APP_URL."|",'',Tiny::getPath("uploads_url"));
				$upfile = new UploadFile('upfile',$upfile_path,'10m');
				$upfile->save();
				$info = $upfile->getInfo();
				$result = array();
				if($info[0]['status']==1){
					$url = $upfile_url.$info[0]['path'];
					$key = md5_file($upfile_path.$info[0]['path']);
					$type = Req::args("type")==null?0:intval(Req::args('type'));
					$gallery->data(array('key'=>$key,'type'=>$type,'img'=>$url))->save();
					$info['img']=$url;
				}
				else{
					$info['error']=array('code'=>'103','message'=>$info[0]['msg']);
				}
			}else{
				$info['img']=$img['img'];
			}
		}
		echo JSON::encode($info);
		exit;
	}
	public function send_email_test()
	{
		$test_email = Req::args('email');
		if(Validator::email($test_email)){
			$mail = new Mail();
			try{
				$flag = $mail->send_email($test_email,'邮箱验证测试',"<div><h3>亲爱的WorldUhot用户您好:</h3><p style='text-indent:2em;'>当您收到这封邮件时，说明您的信息配制正确，邮件系统可以正常工作。</p></div>");
				$info = array('status'=>'success','msg'=>'测试成功，邮件已发送');
				if(!$flag){
					$info = array('status'=>'fail','msg'=>'测试失败，请检测配制信息');
				}
				echo JSON::encode($info);
			}catch (Exception $e){
				$msg = $e->errorMessage();
				$info = array('status'=>'fail','msg'=>$msg);
				echo JSON::encode($info);
			}
		}else{
			$info = array('status'=>'fail','msg'=>'测试邮箱地址格式不正确，核实后再测试');
			echo JSON::encode($info);
		}
	}
}
