<?php
class Cart{

	private static $ins = null;
	private $items = array();

	final protected function __construct() {
	}
	final protected function __clone() {
	}

	public static function getIns() {
		if (!(self::$ins instanceof self)) {
			self::$ins = new self();
		}
		return self::$ins;
	}

	public static function getCart($type='cart') {
		if($type=='cart'){
			$safebox =  Safebox::getInstance();
			$user = $safebox->get('user');
			if(isset($user['name']) && $user['name']!=''){

				$model = new Model('cart');
				$obj = $model->where('user_id='.$user['id'])->find();

				if(!isset($obj['cart'])){
					$sessionCart = Session::get("tiny_cart");
					if ($sessionCart instanceof self &&  $sessionCart->getCnt() > 0){
						$model->data(array('user_id'=>$user['id'],'cart' =>serialize(Session::get("tiny_cart"))))->insert();
					}else{
						$model->data(array('user_id'=>$user['id'],'cart' =>serialize(self::getIns())))->insert();
					}

					$obj = $model->where('user_id='.$user['id'])->find();
				}else{

					$sessionCart = Session::get("tiny_cart");
					if ($sessionCart instanceof self &&  $sessionCart->getCnt() > 0){
						$cart = unserialize($obj['cart']);
						foreach ($sessionCart->items as $key => $item) {
							if (isset($cart->items[$key])){
								$cart->items[$key] += $item;
							}else{
								$cart->items[$key] = $item;
							}
						}
						$model->data(array('cart' =>serialize($cart)))->where('user_id='.$user['id'])->update();
						Session::set("tiny_cart",null);
						$obj = $model->where('user_id='.$user['id'])->find();
					}

				}
				return unserialize($obj['cart']);
			}else{

				if(Session::get("tiny_cart")==null || !(Session::get("tiny_cart") instanceof self)) {
					Session::set("tiny_cart",self::getIns());
				}
				return Session::get("tiny_cart");
			}
		}else{
			if(Session::get("tiny_goods")==null || !(Session::get("tiny_goods") instanceof self)) {
				Session::set("tiny_goods",self::getIns());
			}
			return Session::get("tiny_goods");
		}
	}

	public  function addItem($id,$num=1) {
		if ($this->hasItem($id)) {
			$this->incNum($id,$num);
			return;
		}
		$this->items[$id] = $num;
		$this->updateDBSelf();
	}

	public function hasItem($id) {
		return isset($this->items[$id]);
	}

	public function delItem($id) {
		unset($this->items[$id]);
		$this->updateDBSelf();
	}

	public function modNum($id,$num=1) {
		if (!$this->hasItem($id)) {
			return false;
		}
		$this->items[$id] = $num;
		$this->updateDBSelf();
	}

	public function incNum($id,$num=1) {
		if ($this->hasItem($id)) {
			$this->items[$id] += $num;
		}
		$this->updateDBSelf();
	}

	public function decNum($id,$num=1) {
		if ($this->hasItem($id)) {
			$this->items[$id] -= $num;
		}
		if ($this->items[$id] <1) {
			$this->delItem($id);
		}
		$this->updateDBSelf();
	}

	public function getCnt() {
		return count($this->items);
	}

	public function getNum(){
		if ($this->getCnt() == 0) {
			return 0;
		}

		$sum = 0;
		foreach ($this->items as $item) {
			$sum += $item;
		}
		return $sum;
	}

	public function all() {
		$products = array();
		if($this->getCnt()>0){
			$model = new Model("products as pr");
			$ids = array_keys($this->items);
			$ids = trim(implode(",", $ids),',');
			if($ids!=''){
				$prom = new Prom();
				$items= $model->fields("pr.*,go.img,go.name,go.prom_id,go.point")->join("left join goods as go on pr.goods_id = go.id ")->where("pr.id in($ids)")->findAll();
				foreach ($items as $item) {
					$num = $this->items[$item['id']];
					if($num > $item['store_nums']){
						$num = $item['store_nums'];
						$this->modNum($item['id'],$num);
					}

					if($num<=0){
						$this->delItem($item['id']);
					}else{
						$item['goods_nums']=$num;
						$prom_goods = $prom->prom_goods($item);
						$amount = sprintf("%01.2f",$prom_goods['real_price']*$num);
						$sell_total = $item['sell_price']*$num;
						$products[$item['id']] = array('id'=>$item['id'],'goods_id'=>$item['goods_id'],'name'=>$item['name'],'img'=>$item['img'],'num'=>$num,'store_nums'=>$item['store_nums'],'price'=>$item['sell_price'],'prom_id'=>$item['prom_id'],'real_price'=>$prom_goods['real_price'],'sell_price'=>$item['sell_price'],'spec'=>unserialize($item['spec']),'amount'=>$amount,'prom'=>$prom_goods['note'],'weight'=>$item['weight'],'point'=>$item['point'],'sell_total'=>$sell_total,"prom_goods"=>$prom_goods,'goods_type'=>$item['goods_type'],'virtual_extend'=>$item['virtual_extend']);
					}
				}
			}

		}
		return $products;
	}

	function updateDBSelf()
	{
		$safebox =  Safebox::getInstance();
        $user = $safebox->get('user');
        if(isset($user['name']) && $user['name']!=''){
            $model = new Model('cart');
            $model->data(array('cart' =>serialize($this)))->where('user_id='.$user['id'])->update();
        }
	}

	public function clear() {
		$this->items = array();
		$this->updateDBSelf();
	}
}
