<?php
/**
 * description...
 *
 * @author Crazy、Ly
 * @package AdminController
 */
class CustomerController extends Controller
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

	//充值与退款
	public function balance_op()
	{
		$user_id = Filter::int(Req::args('user_id'));
		$type = Filter::int(Req::args('type'));
		$amount = Filter::float(Req::args('amount'));
		//事件类型: 0:订单支付 1:用户充值 2:管理员充值 3:提现 4:退款到余额
		$model = new Model("customer");
		$obj = $model->where("user_id=$user_id")->find();
		$info = array('status'=>'fail');
		$range = 1000000000-$obj['balance'];
		if($obj && $amount>0 && $amount<=$range){
			if($type==2){
				$model->data(array('balance'=>"`balance`+".$amount))->where("user_id=$user_id")->update();
				Log::balance($amount,$user_id,'管理员为您充值,充值的金额为：'.$amount,2,$this->manager['id']);
				$info = array('status'=>'success','msg'=>'充值成功。');
			}else if($type==4){
				$model->data(array('balance'=>"`balance`+".$amount))->where("user_id=$user_id")->update();
				Log::balance($amount,$user_id,'管理员退款到您的余额中,退款金额为：'.$amount,4,$this->manager['id']);
				$info = array('status'=>'success','msg'=>'退款成功。');
			}
		}else{
			$info = array('status'=>'fail','msg'=>'此用户可充值的金额范围0.01-'.sprintf("%01.2f",$range));
		}
		echo JSON::encode($info);
	}
	public function balance_list()
	{
		$condition = Req::args("condition");
		$condition_str = Common::str2where($condition);
		if($condition_str) $this->assign("where",$condition_str);
		else $this->assign("where","1=1");
		$this->assign("condition",$condition);
		$this->redirect();
	}

	public function withdraw_list()
	{
		$condition = Req::args("condition");
		$condition_str = Common::str2where($condition);
		if($condition_str) $this->assign("where",$condition_str);
		else $this->assign("where","1=1");
		$this->assign("condition",$condition);
		$this->redirect();
	}

	public function withdraw_view()
	{
		$this->layout = "blank";
		$id =Filter::int(Req::args('id'));
		if($id){
			$model = new Model('withdraw as wd');
			$withdraw = $model->fields("wd.*,us.name as uname,cu.balance")->join("left join user as us on wd.user_id = us.id left join customer as cu on wd.user_id = cu.user_id")->where("wd.id=$id")->find();
			$this->assign("withdraw",$withdraw);
			$this->redirect();
		}
	}
	//处理提现
	public function withdraw_act()
	{
		$id = Filter::int(Req::args('id'));
		$status = intval(Req::args('status'));
		$re_note = Filter::text(Req::args('re_note'));
		$model = new Model('withdraw as wd');
		$obj = $model->fields("wd.*,cu.balance")->join("left join customer as cu on wd.user_id = cu.user_id")->where("wd.id=$id and wd.status=0")->find();
		if($obj){
			if($obj['amount']<=$obj['balance']){
				$model->table('withdraw')->data(array('status'=>$status,'re_note'=>$re_note))->where("id=$id")->update();
				if($status==1){
					$model->table('customer')->data(array('balance'=>"`balance`-".$obj['amount']))->where('user_id='.$obj['user_id'])->update();

					Log::balance(0-$obj['amount'],$obj['user_id'],'提现到'.$obj['type_name'].',账号:'.$obj['account'],3,$this->manager['id']);

					$statusInfo = '通过';

				}else{
					$statusInfo = '未通过';
				}
				//退换货申请处理提醒
				$user_info = $model->table('customer')->where('user_id='.$obj['user_id'])->find();
				if(isset($user_info['mobile'])){
					$template_data = array('amount'=>$obj['amount'],'status'=>$statusInfo,'tousers'=>$user_info['mobile']);
					$NoticeService = new NoticeService();
					$NoticeService->send('withdrawal_action',$template_data);
				}

				echo "<script>parent.close_dialog();</script>";
			}
			else{
				echo"<script>alert('提现金额大于了余额。')</script>";
			}
			//扣除账户里的余额
		}
	}

	public function export_excel()
	{
		$this->layout = '';
		$condition = Req::args("condition");
		$fields = Req::args("fields");
		$condition =  Common::str2where($condition);
		$notify_model = new Model("notify as n");
		if($condition){
			$items = $notify_model->fields("n.*,go.name as goods_name,u.name as user_name")->join("left join user as u on n.user_id = u.id left join goods as go on n.goods_id = go.id")->where($condition)->findAll();
			if($items){
				header("Content-type:application/vnd.ms-excel");
				header("Content-Disposition:filename=csat.xls");
				$fields_array = array('email'=>'邮件','mobile'=>'电话','user_name'=>'用户名','goods_name'=>'商品名','register_time'=>'登记时间','notify_status'=>'是否通知');
				$str = "<table border=1><tr>";
				foreach ($fields as $value) {
					$str .= "<th>".iconv("UTF-8","GB2312",$fields_array[$value])."</th>";
				}
				$str .= "</tr>";
				foreach ($items as $item) {
					$str .= "<tr>";
					foreach ($fields as $value) {
						$str .= "<td>".iconv("UTF-8","GB2312",$item[$value])."</td>";
					}
					$str .= "</tr>";
				}
				$str .= "</table>";
				echo $str;
				exit;
			}else{
				$this->msg=array("warning","没有符合该筛选条件的数据，请重新筛选！");
				$this->redirect("notify_list",false,Req::args());
			}
		}else{
				$this->msg=array("warning","请选择筛选条件后再导出！");
				$this->redirect("notify_list",false);
			}

	}
	public function send_notify()
	{
		$condition = Req::args("condition");
		$notify_model = new Model("notify as n");
		$condition = Common::str2where($condition);
		if($condition!=null){
			$items = $notify_model->fields("n.*,go.name as goods_name,u.name as user_name")->join("left join user as u on n.user_id = u.id left join goods as go on n.goods_id = go.id")->where($condition)->findAll();
			$mail = new Mail();
			$msg_model = new Model("msg_template");
			$template = $msg_model->where("id=1")->find();
			$success = 0;
			$fail = 0;
			foreach($items as $item){
				$subject = str_replace(array('{$user_name}','{$goods_name}'), array($item['user_name'],$item['goods_name']), $template['title']);
				$body = str_replace(array('{$user_name}','{$goods_name}'), array($item['user_name'],$item['goods_name']), $template["content"]);
				$status = $mail->send_email($item['email'],$subject , $body);
				if($status){
					$data = array('notify_time'=>date('Y-m-d H:i:s'),'notify_status'=>'1');
					$notify_model->data($data)->where('id='.$item['id'])->update();
					$success++;
				}
				else{
					$fail++;
				}
			}
			$return = array('isError' => false, 'count'   => count($items), 'success' => $success, 'fail'  => $fail);
		}
		else{
			$return = array('isError' => true, 'msg'   => '没有选择筛选条件！');
		}
		echo JSON::encode($return);
	}

	public function message_send()
	{
		$condition = Req::post("condition");
		$condition = Common::str2where($condition);
		$model = new Model();
		Req::post("time",date('Y-m-d H:i:s'));
		$has_user = true;
		if($condition!=''){
			$users = $model->table("customer")->where($condition)->find();
			if($users) $has_user = true;
			else $has_user = false;
		}
		if($has_user){
			$last_id = $model->table("message")->insert();
			$model->table("customer")->data(array('message_ids'=>"concat_ws (',',`message_ids`,'$last_id')"));
			if($condition!='') $model->where($condition)->update();
			else $model->update();
			$this->redirect("message_list");
		}else{
			$this->msg=array("warning","发送的对象不存在，因此无法发送，请修改筛选条件重新发送！");
			$this->redirect("message_edit",false,Req::args());
		}

	}
	public function message_edit()
	{
		$model = new Model('grade');
		$rows = $model->findAll();
		$grade = '';
		foreach ($rows as $row) {
			$grade .= $row['id'].":'".$row['name']."',";
		}
		$grade = trim($grade,',');
		$this->assign('grade',$grade);
		$this->redirect();
	}
	function ask_edit()
	{
		$id = intval(Req::args("id"));
		if($id){
			$model = new Model("ask");
			$obj = $model->where("id=$id")->find();
			if($obj){
				$goods = $model->table("goods")->fields("name")->where("id=".$obj['goods_id'])->find();
				$user = $model->table("user")->fields("name")->where("id=".$obj['user_id'])->find();
				$obj['goods_name'] = isset($goods['name'])?$goods['name']:'<h1 class="red">商品已经不存在</h1>';
				$obj['user_name'] = isset($user['name'])?$user['name']:'用户已不存在';
				$this->redirect("ask_edit",false,$obj);
			}
			else{
				$this->msg=array("error","此咨询不存在，查证后再试！");
				$this->redirect("ask_edit",false,Req::args());
			}
		}else{
			$this->msg=array("error","此咨询不存在，查证后再试！");
			$this->redirect("ask_edit",false,Req::args());
		}
	}
	//商品咨询
	function ask_list()
	{
		$condition = Req::args("condition");
		$condition_str = Common::str2where($condition);
		if($condition_str) $this->assign("where",$condition_str);
		else $this->assign("where","1=1");
		$this->assign("condition",$condition);
		$this->redirect();
	}
	//商品评价
	function review_list()
	{
		$condition = Req::args("condition");
		$condition_str = Common::str2where($condition);
		if($condition_str) $this->assign("where",$condition_str);
		else $this->assign("where","1=1");
		$this->assign("condition",$condition);
		$this->redirect();
	}
	//对应article的验证与过滤
	function ask_validator()
	{
		$manager =  $this->safebox->get('manager');
		$rules = array('content:required:内容不能为空！');
		$info = Validator::check($rules);
		if($info==true) {
			Filter::form(array('text'=>'content'));
			$content = TString::nl2br(Req::args('content'));
			Req::args('content',$content);
			if(Req::args('id')!=null){
				Req::args('reply_time',date('Y-m-d H:i:s'));
				Req::args('status',1);
				Req::args('admin_id',$manager['id']);
			}
		}
		return $info;
	}
	function customer_list()
	{
		$condition = Req::args("condition");
		$condition_str = Common::str2where($condition);
		if($condition_str) $this->assign("where",$condition_str);
		else $this->assign("where","1=1");
		$this->assign("condition",$condition);
		$this->redirect();
	}
	public function customer_edit()
	{
		$id = Req::args("id");

		$customer = Req::args();
		if($id){
			$model = new Model("customer as c");
			$customer = $model->join("user as u on c.user_id = u.id")->where("c.user_id=".$id)->find();
		}
		$this->redirect('customer_edit',false,$customer);
	}
	public function customer_del()
	{
		$id = Req::args("id");
		if(is_array($id)){
			$cond = ' in ('.implode(",",$id).')';
		}
		else{
			$cond = " = $id";
		}
		$model = new Model();
		$users = $model->table("user")->where("id $cond")->findAll();
		$model->table("customer")->where("user_id $cond")->delete();
		$model->table("user")->where("id $cond")->delete();
		if($users){
			$user_names = "";
			foreach ($users as $user) {
				$user_names .= $user['name']."、";
			}
			$user_names = trim($user_names,'、');
			Log::op($this->manager['id'],"删除会员","管理员[".$this->manager['name']."]:删除了会员 ".$user_names);
		}
		$this->redirect("customer_list");
	}
	public function customer_save()
	{
		$id = Req::args("id");
		$name = Req::args("name");
		$email = Req::args("email");
		$password = Req::args("password");
		$birthday = Req::post("birthday");
		$userModel = new Model("user");

		$customerModel = new Model("customer");
		if($id){
			$user = $userModel->where("id=$id")->find();
			if($user){
				if($name && $email)$userModel->data(array('name'=>$name,'email'=>$email))->where("id=$id")->update();
				Req::args('user_id',$id);
				$customerModel->where("user_id=$id")->update();
				Log::op($this->manager['id'],"修改会员","管理员[".$this->manager['name']."]:修改了会员 ".$user['name']." 的信息");
			}
		}else{
			$user = $userModel->where("name = '$name' or email = '$email'")->find();
			if($user){
				$this->msg=array("error","用户名或邮箱已经存在！");
				$this->redirect("customer_edit",false);
				exit;
			}else{
				$validcode = CHash::random(8);
				$last_id = $userModel->data(array('name'=>$name,'password'=>CHash::md5($password,$validcode),'validcode'=>$validcode,'email'=>$email))->add();
				Req::args('user_id',$last_id);
				if(!Validator::date(Req::post('birthday')))Req::post('birthday',date('Y-m-d'));
				$customerModel->insert();
				Log::op($this->manager['id'],"添加会员","管理员[".$this->manager['name']."]:添加了会员 ".$name." 的信息");
			}

		}
		$this->redirect("customer_list");
	}
	public function customer_password()
	{
		$id = Req::post("id");
		$password = Req::post("password");
		$repassword = Req::post("repassword");
		$info = array('status'=>'fail');
		if($id && $password && $password == $repassword){
			$model = new Model("user");
			$validcode = CHash::random(8);
			$flag = $model->where("id=$id")->data(array('password'=>CHash::md5($password,$validcode),'validcode'=>$validcode))->update();
			if($flag)$info = array('status'=>'success');
		}
		echo JSON::encode($info);
	}
}
