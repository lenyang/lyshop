<?php
//促销处理类
class Prom{
	private $total_amount = 0.0;
	//活动类型: 0满额打折 1满额优惠金额 2满额送倍数积分 3满额送优惠券 4满额免运费
	private $prom_order = array(0,1,2,3,4);
	//活动类型: 0直接打折 1减价优惠 2固定金额 3买就赠优惠券 4买M件送N件
	private $prom_goods = array(0,1,2,3,4);

	public function __construct($amount=0){
		if(is_numeric($amount)){
			$this->total_amount = $amount;
		}else{
			//显示错误
		}
	}

	public function setAmount($amount=0){
		if(is_numeric($amount)){
			$this->total_amount = $amount;
		}else{
			$this->total_amount = 0;
		}
	}

	//取得满足条件的规则
	public function meetProms($group_id=0){
		$model = new Model("prom_order");
		$time = date('Y-m-d H:i:s');
		$where = " `money` <= ".$this->total_amount." and is_close=0 and start_time < '".$time."' and end_time > '".$time."'";
		$safebox =  Safebox::getInstance();
    	$user = $safebox->get('user');
    	$group_id = ',0,';
    	if(isset($user['group_id'])) $group_id = ','.$user['group_id'].',';
		if($group_id){
			$where.=" and CONCAT(',',`group`,',') like '%".$group_id."%'";
		}
		$proms = $model->where($where)->order("type,cast(expression as decimal) desc")->findAll();
		return $proms;
	}
	
	public function parsePorm($prom){
		$type = $prom['type'];
		$expr = $prom['expression'];
		$result = array('total_amount'=>$this->total_amount,'value'=>0.00);
		switch ($type) {
			case '0':
				$result['total_amount'] = $this->total_amount*($expr)/100;
				$result['note'] = "省".($this->total_amount*(100-$expr)/100)."（".($expr/10)."折）";
				$result['value'] = floatval($this->total_amount*(100-$expr)/100);
				break;
			case '1':
				$result['total_amount'] = $this->total_amount-$expr;
				$result['note'] = "省".$expr."（立减".$expr."）";
				$result['value'] = floatval($expr);
				break;
			case '2':
				$result['value'] = intval($expr);
				$result['note'] = "送".$expr."倍积分";
				break;
			case '3':
				$model = new Model("voucher_template");
				$voucher = $model->where("id=".Filter::int($expr))->find();
				if($voucher){
					$result['note'] = "面值".$voucher['value']."优惠券";
				}else{
					$result['note'] = "所送的优惠券已不存在";
				}
				break;
			case '4':
				$result['note'] = "免运费";
				break;
		}
		return $result;
	}

	public function prom_goods($goods){
		$price = $goods['sell_price'];
		$nums = $goods['goods_nums'];
		$result = array('real_price'=>$price,'note'=>'','minus'=>"-0");
		$prom_id = $goods['prom_id'];
		if($prom_id>0){
			$model = new Model('prom_goods');
			$time = date('Y-m-d H:i:s');
			$prom = $model->where("id=$prom_id and is_close=0 and start_time < '".$time."' and end_time > '".$time."'")->find();
			$safebox =  Safebox::getInstance();
	    	$user = $safebox->get('user');
	    	$group_id = ',0,';
	    	if(isset($user['group_id'])) $group_id = ','.$user['group_id'].',';
	    	
			if($prom && stripos(','.$prom['group'].',',$group_id)!==false){
				$type = $prom['type'];
				$expr = $prom['expression'];
				$result['prom'] = $prom;
				//0直接打折 1减价优惠 2固定金额 3买就赠优惠券 4买M件送N件
				switch ($type) {
					case '0':
						$result['real_price'] = $price*$expr/100;
						$result['minus'] = "*".($expr/100);
						$result['note'] = '直接'.($expr/10)."折";
						break;
					case '1':
						$result['real_price'] = ($price-$expr)>0?($price-$expr):0;
						$result['real_price'] = sprintf("%01.2f",$result['real_price']);
						$result['minus'] = "-".$expr;
						$result['note'] = "立减".$expr;
						break;
					case '2':
						$result['real_price'] = sprintf("%01.2f",$expr);
						$result['minus'] = "*0+".$expr;
						$result['note'] = "促销价".$expr;
						break;
					case '3':
						$model = new Model("voucher_template");
						$voucher = $model->where("id=".$expr)->find();
						if($voucher){
							$result['note'] = "送".$voucher['name']."优惠券,面值".$voucher['value'];
						}else{
							$result['note'] = "所送的优惠券已不存在";
						}
						break;
					case '4':
						$expr = explode('/', $expr);
						if($nums>=$expr[0]) $result['note'] = "满".$expr[0]."件送".$expr[1];
						break;
				}
			}
		}
		return $result;
	}
}