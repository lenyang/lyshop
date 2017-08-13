<?php
//运费计算类
class Fare{
	private $weight = 0;
	public function __construct($weight=0){
		$this->weight = $weight;
	}

	public function calculate($address_id){
		$total = 0;
		$model = new model("fare");
		$fare = $model->where("is_default=1")->find();
		if($fare){
			$addr = $model->table('address')->where("id=$address_id")->find();
			if($addr){
				$city = $addr['city'];
				$first_price = $fare['first_price'];
				$second_price = $fare['second_price'];
				$first_weight = $fare['first_weight'];
				$second_weight = $fare['second_weight'];

				$zoning = unserialize($fare['zoning']);
				foreach ($zoning as $zon) {
					if(preg_match(','.$city.',', ','.$zon['area'].',')>0){
						$first_price = $zon['f_price'];
						$second_price = $zon['s_price'];
						$first_weight = $zon['f_weight'];
						$second_weight = $zon['s_weight'];
						break;
					}
				}

				if($this->weight<=$first_weight) $total = $first_price;
				else{
					$weight = $this->weight - $first_weight;
					$total = $first_price + ceil($weight/$second_weight)*$second_price;
				}
			}
			
		}
		return sprintf("%01.2f",$total);
	}
}