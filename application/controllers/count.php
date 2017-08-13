<?php
/**
 * description...
 * 
 * @author Crazy、Ly
 * @package AdminController
 */
class CountController extends Controller
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
	public function noRight(){
		$this->redirect("admin/noright");
	}
	
	public function index()
	{
		$model = new Model("order_goods as og");
		$cal = $this->calendar();
		$stime = $cal['start'];
		$etime = $cal['end'];
		$s_time = $cal['str'];
		$num = $cal['days'];
		
		$monthData = array();
		$realData = array();
		$model = new Model("order");
		
		if($num<=3){
			$rows = $model->fields("sum(payable_amount) as amount,sum(order_amount) as order_amount,TIME_FORMAT(create_time, '%H:00') as day ")->where("create_time between '$stime' and '$etime' and pay_status=1")->group('hour(create_time)')->findAll();

			for($i=0;$i<24;$i++){
				$monthData[($i<10?'0'.$i:$i).':00']=0.00;
				$realData[($i<10?'0'.$i:$i).':00']=0.00;
			}
		}else{
			$rows = $model->fields("sum(payable_amount) as amount,sum(order_amount) as order_amount,date_format(create_time,'%m-%d') as day ")->where("create_time between '$stime' and '$etime' and pay_status=1")->group('day')->findAll();
			$month_day = null;
			for($i=0;$i<$num;$i++){
				$month_day = date("m-d",strtotime($stime.'+'.$i.'day'));
				$monthData[$month_day]=0.00;
				$realData[$month_day] = 0.00;
			}
		}
		
		if($rows){
			foreach ($rows as $row) {
				$monthData[$row['day']] = $row['amount'];
				$realData[$row['day']] = $row['order_amount'];
			}
		}
		
		$month = implode("','",array_keys($monthData));
		$data = implode(",",$monthData);
		$realData = implode(",", $realData);
		$this->assign('s_time',$s_time);
		$this->assign("month","'$month'");
		$this->assign("data",$data);
		$this->assign("real_data",$realData);
		$this->redirect();
	}
	public function user_reg(){
		$cal = $this->calendar();
		$stime = $cal['start'];
		$etime = $cal['end'];
		$s_time = $cal['str'];

		$model = new Model("customer as cu");
		$rows = $model->fields("count(*) as num, cu.province,ae.name as pro_name")->join("left join area as ae on cu.province = ae.id ")->where("cu.reg_time between '$stime' and '$etime'")->group("cu.province")->findAll();
		$mapdata = array();
		foreach ($rows as $row) {
			$mapdata[] = "'".preg_replace("/(\s|省|市)/", '', $row['pro_name'])."'".':'.$row['num'];
		}

		$this->assign('mapdata',implode(',',$mapdata));
		$this->assign('s_time',$s_time);

		$this->redirect();

	}
	public function area_buy(){
		
		$cal = $this->calendar();
		$stime = $cal['start'];
		$etime = $cal['end'];
		$s_time = $cal['str'];

		$model = new Model("order as od");
		$rows = $model->fields("count(*) as num, province,ae.name as pro_name")->join("left join area as ae on od.province = ae.id ")->where("pay_time between '$stime' and '$etime' and pay_status = 1")->group("od.province")->query();
		$mapdata = array();
		foreach ($rows as $row) {
			$mapdata[] = "'".preg_replace("/(\s|省|市)/", '', $row['pro_name'])."'".':'.$row['num'];
		}

		$this->assign('mapdata',implode(',',$mapdata));
		$this->assign('s_time',$s_time);

		$this->redirect();

	}
	public function hot()
	{
		$model = new Model("order_goods as og");
		$cal = $this->calendar();
		$stime = $cal['start'];
		$etime = $cal['end'];
		$s_time = $cal['str'];
		$days = $cal['days'];
		$monthData = array();
		$xdata = array();
		if($days<3){
			$rows = $model->join("left join order as od on od.id = og.order_id")->fields("count(og.id) as num,og.goods_id,TIME_FORMAT(od.create_time, '%H:00') as day ,od.order_amount as amount")->where("od.create_time between '$stime' and '$etime' and od.pay_status=1")->order('num desc')->group("og.goods_id")->limit(3)->findAll();

			for($i=0;$i<24;$i++) $xdata[($i<10?'0'.$i:$i).':00']=0.00;
			foreach ($rows as $row) $monthData[$row['goods_id']] = $xdata;
			
		}
		else{
			$rows = $model->join("left join order as od on od.id = og.order_id")->fields("count(og.id) as num,og.goods_id,date_format(od.create_time,'%m-%d') as day ,od.order_amount as amount")->where("od.create_time between '$stime' and '$etime' and od.pay_status=1")->order('num desc')->group("og.goods_id")->limit(3)->findAll();

			$month_day = null;
			for($i=0;$i<$days;$i++){
				$month_day = date("m-d",strtotime($stime.'+'.$i.'day'));
				$xdata[$month_day]=0.00;
			}
			foreach ($rows as $row) $monthData[$row['goods_id']] = $xdata;
			
		}
		if($rows){
			foreach ($rows as $row) {
				$monthData[$row['goods_id']][$row['day']] = $row['amount'];
			}
			foreach ($rows as $row) {
				$data[$row['goods_id']] = implode(",",$monthData[$row['goods_id']]);
			}
			$goods_id = implode(",",array_keys($data));
			$goods  = $model->table("goods")->where("id in ($goods_id)")->findAll();
			$parse_goods = array();
			foreach ($goods as $v) {
				$parse_goods[$v['id']] = $v['name'];
			}
			$this->assign("parse_goods",$parse_goods);
		}
		$month = implode("','",array_keys($xdata));
		$this->assign("nodata",implode(",",array_values($xdata)));
		$this->assign("s_time",$s_time);
		$this->assign("month","'$month'");
		$this->assign("data",isset($data)?$data:array());
		
		$this->redirect();
	}

	private function calendar(){
		$cal = array();
		$s_time = Req::args("s_time");
		if(!$s_time){
			$s_time = date("Y-m-d -- Y-m-d");
		}
		$date = explode(' -- ', $s_time);
		$stime = date('Y-m-d 00:00:00',strtotime($date[0]));
		$etime = date('Y-m-d 00:00:00',strtotime($date[1].'+1day'));
		$cle = strtotime($etime) - strtotime($stime);
		$num = ceil($cle/86400);
		$cal['start'] = $stime;
		$cal['end'] = $etime;
		$cal['days'] = $num;
		$cal['str'] = $s_time;
 		return $cal;
	}
}
