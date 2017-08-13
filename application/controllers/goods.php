<?php
/**
 *商品模块 
 *
 * @author Crazy、Ly
 * @package AdminController
 */
class GoodsController extends Controller
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
		$this->redirect("/admin/noright");
	}

	//商品上下架
	public function set_online()
	{
		$id = Req::args("id");
		if(is_array($id)){
			$id = implode(',', $id);
		}
		$status = Filter::int(Req::args('status'));
		if($status!=0 && $status!=1) $status = 0;
		$model = new Model('goods');
		$model->data(array('is_online'=>$status))->where("id in($id)")->update();
		$this->redirect("goods_list");
	}
	function goods_type_save(){
		$attr_id = Req::args('attr_id');
		$attr_name = Req::args('attr_name');
		$attr_type = Req::args('attr_type');
		$attr_value = Req::args('attr_value');
		$brand = Req::args('brand');
		//spec 处理部分开始
		$spec = Req::args('spec');
		$specs_array = array();
		if($spec){
			$spec_ids = $spec['id'];
			if(is_array($spec_ids)) $spec_ids = implode(',', $spec_ids);
			$model = new Model('goods_spec');
			$specs = $model->where('id in('.$spec_ids.')')->order("find_in_set(id,'".$spec_ids."')")->findAll();
			$spec_value = new Model('spec_value');
			foreach ($specs as $k=>$row) {
				$result = $spec_value->where('spec_id='.$row['id'])->findAll();
				$row['spec'] = $result;
				$row['show_type'] = $spec['show_type'][$k];
				$specs_array[] = $row;
			}

		}
		Req::args('spec',serialize($specs_array));
		//spec 处理结束

		$values = array();
		if(is_array($brand)) $brand = implode(',', $brand);
		Req::args('brand',$brand);
		$goods_type = new Model("goods_type");
		$id = Req::args('id');
		if($id == null){
			$result = $goods_type->insert();
			$lastid = $result;
			Log::op($this->manager['id'],"添加商品类型","管理员[".$this->manager['name']."]:添加了商品类型 ".Req::args('name'));
		}else{
			$result = $goods_type->where("id=".$id)->update();
			$lastid = $id;
			Log::op($this->manager['id'],"修改商品类型","管理员[".$this->manager['name']."]:修改了商品类型 ".Req::args('name'));
		}
		$goods_attr = new Model('goods_attr');
		$attr_value_model = new Model("attr_value");
		$attr_ids ='';
		if(is_array($attr_id)){
			foreach($attr_id as $v){
				if($v!=0) $attr_ids .=$v.',';
			}
			$attr_ids = rtrim($attr_ids,',');
			$goods_attr->where('type_id = '.$lastid.' and id not in('.$attr_ids.')')->delete();

			foreach ($attr_id as $k=>$v) {
				if($v=='0'){
					$attr_last_id = $goods_attr->data(array('name'=>$attr_name[$k],'type_id'=>$lastid,'show_type'=>$attr_type[$k],'sort'=>$k))->insert();
					$this->update_attr_value($attr_value_model,$attr_last_id,$attr_value[$k]);
				}
				else{
					$goods_attr->data(array('name'=>$attr_name[$k],'type_id'=>$lastid,'show_type'=>$attr_type[$k],'sort'=>$k))->where('id='.$attr_id[$k])->update();
					$this->update_attr_value($attr_value_model,$attr_id[$k],$attr_value[$k]);
				}
			}
			$goods_attrs = $goods_attr->where('type_id='.$lastid)->order("sort")->findAll();
			foreach ($goods_attrs  as $key => $row) {
				$row['values'] = $attr_value_model->where('attr_id = '.$row['id'])->order('sort')->findAll();
				$goods_attrs[$key] = $row;
			}
			$goods_type->data(array('attr'=>serialize($goods_attrs)))->where('id='.$lastid)->update();
		}else{

			$dbinfo = DBFactory::getDbInfo();
			$table_pre = $dbinfo['tablePre'];
			$attr_value_model->where("attr_id  in (select id from {$table_pre}goods_attr where type_id = ".$lastid.")")->delete();
			$goods_attr->where('type_id = '.$lastid)->delete();

		}

		$this->redirect('goods_type_list');
	}
	//更新属性值
	private function update_attr_value($attr_value_model,$attr_id,$attr_values){

		$attr_values = explode(',', $attr_values);
		$value_ids = '';
		foreach ($attr_values as $key => $value) {
			$value_array = explode(":=:", $value);
			if(count($value_array)>1){
				if($value_array[0]==0){
					$new_id = $attr_value_model->data(array('attr_id'=>$attr_id,'name'=>$value_array[1],'sort'=>$key))->insert();
					$value_ids .= $new_id.',';
				}
				else{
					$attr_value_model->data(array('attr_id'=>$attr_id,'name'=>$value_array[1],'sort'=>$key))->where('id='.$value_array[0])->update();
					$value_ids .= $value_array[0].',';
				}
			}

		}
		$value_ids = rtrim($value_ids,',');
		if($value_ids=='')
			$attr_value_model->where('attr_id = '.$attr_id)->delete();
		else
			$attr_value_model->where('attr_id = '.$attr_id.' and id not in('.$value_ids.')')->delete();
	}
	function attr_values(){
		$this->layout='';
		$this->redirect();
	}
	function goods_type_del(){
		$id = Req::args('id');
		$dbinfo = DBFactory::getDbInfo();
		$table_pre = $dbinfo['tablePre'];
		if($id){
			$model = new Model();
			if(is_array($id)){
				$ids = implode(',',$id);
				$goods_types = $model->table('goods_type')->where('id in('.$ids.')')->findAll();
				$model->table('goods_type')->where('id in('.$ids.')')->delete();
				$model->table('attr_value')->where("attr_id in (select id from {$table_pre}goods_attr where type_id in ({$ids}))")->delete();
				$model->table('goods_attr')->where('type_id in('.$ids.')')->delete();
			}
			else{
				$goods_types = $model->table('goods_type')->where('id in('.$id.')')->findAll();
				$model->table('goods_type')->where('id='.$id)->delete();
				$model->table('attr_value')->where("attr_id in (select id from {$table_pre}goods_attr where type_id ={$id})")->delete();
				$model->table('goods_attr')->where('type_id ='.$id)->delete();
			}
			$str = '';
			foreach ($goods_types as $key => $value) {
				$str .= $value['name'].'、';
			}
			Log::op($this->manager['id'],"删除商品类型","管理员[".$this->manager['name']."]:删除了商品类型 ".$str);

			$this->redirect('goods_type_list');
		}else{
			$this->msg = array("warning","未选择项目，无法删除！");
			$this->redirect('goods_type_list',false);
		}
	}
	function goods_spec_show(){
		$this->layout = '';
		$this->redirect();
	}
	function goods_spec_save(){
		$id = Req::args('id');
		$value = Req::args('value');
		$img = Req::args('img');
		$value_id = Req::args('value_id');
		$name = Req::args("name");
		$values = array();
		$goods_spec = new Model("goods_spec");
		if($id){
			$goods_spec->save();
			$lastid = $id;
			Log::op($this->manager['id'],"修改商品规格","管理员[".$this->manager['name']."]:修改了规格 ".$name);
		}else{
			$lastid = $goods_spec->save();
			Log::op($this->manager['id'],"添加商品规格","管理员[".$this->manager['name']."]:添加了规格 ".$name);
		}
		$spec_value = new Model('spec_value');
		$value_ids ='';
		if(is_array($value_id)){
			foreach($value_id as $v){
				if($v!=0) $value_ids .=$v.',';
			}
			$value_ids = rtrim($value_ids,',');
			$spec_value->where('spec_id = '.$lastid.' and id not in('.$value_ids.')')->delete();
			foreach ($value_id as $k=>$v) {
				if($v=='0'){
					$spec_value->data(array('name'=>$value[$k],'spec_id'=>$lastid,'sort'=>$k,'img'=>is_array($img)?$img[$k]:''))->insert();
				}
				else $spec_value->data(array('name'=>$value[$k],'spec_id'=>$lastid,'sort'=>$k,'img'=>is_array($img)?$img[$k]:''))->where('id='.$value_id[$k])->update();

			}
			$spec_values = $spec_value->where('spec_id = '.$lastid)->findAll();
			$goods_spec->data(array('value'=>serialize($spec_values)))->where('id='.$lastid)->update();
		}
		else{
			$spec_value->where('spec_id = '.$lastid)->delete();
		}
		$this->redirect('goods_spec_list');
	}
	function goods_spec_del(){
		$id = Req::args('id');
		if($id){
			$model = new Model();
			if(is_array($id)){
				$ids = implode(',',$id);
				$specs = $model->table('goods_spec')->where('id in('.$ids.')')->findAll();
				$model->table('goods_spec')->where('id in('.$ids.')')->delete();
				$model->table('spec_value')->where('spec_id in('.$ids.')')->delete();

			}
			else{
				$specs = $model->table('goods_spec')->where('id='.$id)->findAll();
				$model->table('goods_spec')->where('id='.$id)->delete();
				$model->table('spec_value')->where('spec_id ='.$id)->delete();
			}
			$str = '';
			foreach ($specs as $key => $value) {
				$str .= $value['name'].'、';
			}
			Log::op($this->manager['id'],"删除商品规格","管理员[".$this->manager['name']."]:删除了规格 ".$str);
			$this->redirect('goods_spec_list');
		}else{
			$this->msg = array("warning","未选择项目，无法删除！");
			$this->redirect('goods_spec_list',false);
		}
	}

	//商品分类
	function goods_category_save(){
		$goods_category = new Model("goods_category");
		$name = Req::args("name");
		$alias = Req::args("alias");
		$parent_id = Req::args("parent_id");
		$sort = intval(Req::args("sort"));
		$id = Req::args("id")==null?0:Req::args("id");
		$type_id = Req::args('type_id');
		$nav_show = Filter::int(Req::args('nav_show'));
		$list_show = Filter::int(Req::args('list_show'));
		$seo_title = Req::args('seo_title');
		$seo_keywords = Req::args("seo_keywords");
		$seo_description = Req::args('seo_description');
		$img = Filter::sql(Req::args("img"));
		$imgs_array = is_array(Req::args("imgs"))?Req::args("imgs"):array();
		$links = is_array(Req::args("links"))?Req::args("links"):array();
		$imgs = array();
		foreach ($imgs_array as $key => $value) {
			$imgs[] = array('img'=>$value,'link'=>$links[$key]);
		}


		$item = $goods_category->where("id != $id and ((name = '$name' and parent_id =$parent_id ) or alias = '$alias' )")->find();
		if($item){
			if($alias == $item['alias']) $this->msg = array("warning","别名要求唯一,方便url美化,操作失败！");
				else $this->msg = array("error","同一级别下已经在在相同分类！");
				unset($item['id']);
			$this->redirect("goods_category_edit",false,Req::args());
		}else{
			//最得父节点的信息
			$parent_node = $goods_category->where("id = $parent_id")->find();
			$parent_path = "";
			if($parent_node){
				$parent_path = $parent_node['path'];
			}
			$current_node = $goods_category->where("id = $id")->find();
			//更新节点
			if($current_node){
				$current_path = $current_node['path'];
				if(strpos($parent_path, $current_path)===false){

					if($parent_path!='')$new_path = $parent_path.$current_node['id'].",";
					else $new_path = ','.$current_node['id'].',';

					$goods_category->data(array('path'=>"replace(`path`,'$current_path','$new_path')"))->where("path like '$current_path%'")->update();
					$goods_category->data(array('parent_id'=>$parent_id,'id'=>$id,'sort'=>$sort,'name'=>$name,'alias'=>$alias,'nav_show'=>$nav_show,'list_show'=>$list_show,'type_id'=>$type_id,'seo_title'=>$seo_title,'seo_keywords'=>$seo_keywords,'seo_description'=>$seo_description,'img'=>$img,'imgs'=>serialize($imgs)))->update();
					Log::op($this->manager['id'],"更新商品分类","管理员[".$this->manager['name']."]:更新了商品分类 ".Req::args('name'));
					$this->redirect("goods_category_list");
				}else{
					$this->msg = array("warning","此节点不能放到自己的子节点上,操作失败！");
					$this->redirect("goods_category_edit",false,Req::args());
				}
			}
			else{
				//插件节点
				$lastid = $goods_category->insert();
				if($parent_path!='')$new_path = $parent_path."$lastid,";
				else $new_path = ",$lastid,";
				$goods_category->data(array('path'=>"$new_path",'id'=>$lastid,'sort'=>$sort,'nav_show'=>$nav_show,'list_show'=>$list_show,'type_id'=>$type_id,'seo_title'=>$seo_title,'seo_keywords'=>$seo_keywords,'seo_description'=>$seo_description,'img'=>$img,'imgs'=>serialize($imgs)))->update();

				Log::op($this->manager['id'],"添加商品分类","管理员[".$this->manager['name']."]:添加商品分类 ".Req::args('name'));
				$this->redirect("goods_category_list");
			}
			$cache = CacheFactory::getInstance();
        	$cache->delete("_GoodsCategory");
		}
	}
	//商品分类删除
	function goods_category_del(){
		$id = Req::args('id');
		$category = new Model("goods_category");
		$child = $category->where("parent_id = $id")->find();
		if($child){
			$this->msg = array("warning","由于存在子分类，此分类不能删除，操作失败！");
			$this->redirect("goods_category_list",false);
		}
		else{
			$goods = new Model("goods");
			$row = $goods->where('category_id = '.$id)->find();
			if($row){
				$this->msg = array("warning","此分类下还有商品，无法删除！");
			$this->redirect("goods_category_list",false);
			}else{
				$obj = $category->where("id=$id")->find();
				$category->where("id=$id")->delete();
				if($obj)Log::op($this->manager['id'],"删除商品分类","管理员[".$this->manager['name']."]:删除了商品分类 ".$obj['name']);
				$cache = CacheFactory::getInstance();
        		$cache->delete("_GoodsCategory");

				$this->redirect("goods_category_list");
			}
		}
	}

	function goods_save(){
		$spec_items = Req::args('spec_items');
		$spec_item = Req::args('spec_item');
		$items = explode(",", $spec_items);
		$values_array = array();
		//货品中的一些变量
		$pro_no = Req::args("pro_no");
		$store_nums = Req::args("store_nums");
		$warning_line = Req::args("warning_line");
		$weight = Req::args("weight");
		$sell_price = Req::args("sell_price");
		$market_price = Req::args("market_price");
		$cost_price = Req::args("cost_price");
		$is_online = Req::args("is_online");
		if($is_online == null)Req::args("is_online",1);

		$goods_type = Filter::int(Req::args('goods_type'));
		$virtual_extend = Filter::sql(Req::args('virtual_extend'));


		if($goods_type != 0){
			$weight = 0;
			Req::args("weight",0);
		}


		//values的笛卡尔积
		$values_dcr = array();
		$specs_new = array();
		if(is_array($spec_item)){
			foreach ($spec_item as $item) {
				$values = explode(",", $item);

				foreach ($values as $value) {
					$value_items = explode(":", $value);
					$values_array[$value_items[0]]=$value_items;
				}
			}
			$value_ids = implode(",",array_keys($values_array));
			$values_model = new Model('spec_value');
			$spec_model = new Model('goods_spec');
			$specs = $spec_model->where("id in ({$spec_items})")->findAll();
			$values = $values_model->where("id in ({$value_ids})")->order('sort')->findAll();
			$values_new = array();
			foreach ($values as $k => $row) {
				$current = $values_array[$row['id']];
				if($current[1]!=$current[2]) $row['name'] = $current[2];
				if($current[3]!='') $row['img'] = $current[3];
				$values_new[$row['spec_id']][$row['id']] = $row;
			}

			foreach ($specs as $key => $value) {
				$value['value'] = isset($values_new[$value['id']])?$values_new[$value['id']]:null;
				$specs_new[$value['id']] = $value;
			}

			foreach ($spec_item as $item) {
				$values = explode(",", $item);
				$key_code = ';';
				foreach ($values as $k => $value) {
					$value_items = explode(":", $value);
					$key = $items[$k];
					$tem[$key] = $specs_new[$key];
					$tem[$key]['value'] = $values_array[$value_items[0]];
					$key_code .= $key.':'.$values_array[$value_items[0]][0].';';
				}
				$values_dcr[$key_code] = $tem;
			}
		}

		//商品处理
		$goods = new Model('goods');
		Req::args('specs',serialize($specs_new));
		$attrs = is_array(Req::args("attr"))?Req::args("attr"):array();
		$imgs = is_array(Req::args("imgs"))?Req::args("imgs"):array();
		Req::args('attrs',serialize($attrs));
		Req::args('imgs',serialize($imgs));
		Req::args('up_time',date("Y-m-d H:i:s"));

		$id = intval(Req::args("id"));
		$gdata = Req::args();
		$gdata['name'] = Filter::sql($gdata['name']);
		if(is_array($gdata['pro_no'])) $gdata['pro_no'] = $gdata['pro_no'][0];
		if($id==0){
			$gdata['create_time'] = date("Y-m-d H:i:s");
			$goods_id = $goods->data($gdata)->save();
			Log::op($this->manager['id'],"添加商品","管理员[".$this->manager['name']."]:添加了商品 ".Req::args('name'));
		}else{
			$goods_id = $id;
			$goods->data($gdata)->where("id=".$id)->update();
			Log::op($this->manager['id'],"修改商品","管理员[".$this->manager['name']."]:修改了商品 ".Req::args('name'));
		}
		//货品添加处理
		$g_store_nums = $g_warning_line = $g_weight = $g_sell_price = $g_market_price = $g_cost_price = 0;
		$products = new Model("products");

		$k = 0;

		foreach ($values_dcr as $key => $value) {
			$store_num = $store_nums[$k];
			if($goods_type == 2){
				$virtual_goods_model = new Model('virtual_goods');
				$vg = $virtual_goods_model->fields("count(id) as total")->where('template_id='.$virtual_extend.' and status=1')->find();
				if($vg){
					$store_num = $vg['total'];
				}else{
					$store_num = 0;
				}
			}

			$result = $products->where("goods_id = ".$goods_id." and specs_key = '$key'")->find();

			$data = array('goods_id' =>$goods_id,'pro_no'=>$pro_no[$k],'store_nums'=>$store_num,'warning_line'=>$warning_line[$k],'weight'=>$weight[$k],'sell_price'=>$sell_price[$k],'market_price'=>$market_price[$k],'cost_price'=>$cost_price[$k],'specs_key'=>$key,'spec'=>serialize($value),'goods_type'=>$goods_type,'virtual_extend'=>$virtual_extend);
			$g_store_nums += $data['store_nums'];
			if($g_warning_line==0) $g_warning_line = $data['warning_line'];
			else if($g_warning_line>$data['warning_line']) $g_warning_line = $data['warning_line'];
			if($g_weight==0) $g_weight = $data['weight'];
			else if($g_weight<$data['weight']) $g_weight = $data['weight'];
			if($g_sell_price==0) $g_sell_price = $data['sell_price'];
			else if($g_sell_price>$data['sell_price']) $g_sell_price = $data['sell_price'];
			if($g_market_price==0) $g_market_price = $data['market_price'];
			else if($g_market_price<$data['market_price']) $g_market_price = $data['market_price'];
			if($g_cost_price==0) $g_cost_price = $data['cost_price'];
			else if($g_cost_price<$data['cost_price']) $g_cost_price = $data['cost_price'];

			if(!$result){
				$products->data($data)->insert();
			}else{
				$products->data($data)->where("goods_id=".$goods_id." and specs_key='$key'")->update();
			}
			$k++;
		}
		//如果没有规格
		if($k==0){

			$store_num = $store_nums;
			if($goods_type == 2){
				$virtual_goods_model = new Model('virtual_goods');
				$vg = $virtual_goods_model->fields("count(id) as total")->where('template_id='.$virtual_extend.' and status=1')->find();
				if($vg){
					$store_num = $vg['total'];
				}else{
					$store_num = 0;
				}
			}

			$g_store_nums = $store_num;
			$g_warning_line = $warning_line;
			$g_weight = $weight;
			$g_sell_price = $sell_price;
			$g_market_price = $market_price;
			$g_cost_price = $cost_price;



			$data = array('goods_id' =>$goods_id,'pro_no'=>$pro_no,'store_nums'=>$store_nums,'warning_line'=>$warning_line,'weight'=>$weight,'sell_price'=>$sell_price,'market_price'=>$market_price,'cost_price'=>$cost_price,'specs_key'=>'','spec'=>serialize(array()),'goods_type'=>$goods_type,'virtual_extend'=>$virtual_extend);
			$result = $products->where("goods_id = ".$goods_id)->find();
			if(!$result){
				$products->data($data)->insert();
			}else{
				$products->data($data)->where("goods_id=".$goods_id)->update();
			}
		}
		//更新商品相关货品的部分信息
		$goods->data(array('store_nums'=>$g_store_nums,'warning_line'=>$g_warning_line,'weight'=>$g_weight,'sell_price'=>$g_sell_price,'market_price'=>$g_market_price,'cost_price'=>$g_cost_price))->where("id=".$goods_id)->update();

		$keys = array_keys($values_dcr);
		$keys = implode("','", $keys);
		//清理多余的货品
		$products->where("goods_id=".$goods_id." and specs_key not in('$keys')")->delete();

		//规格与属性表添加部分
		$spec_attr = new Model("spec_attr");
		//处理属性部分

		$value_str = '';
		if($attrs){
			foreach ($attrs as $key => $attr) {
				if(is_numeric($attr)) $value_str .= "($goods_id,$key,$attr),";
			}
		}
		foreach ($specs_new as $key => $spec) {
			if(isset($spec['value']))foreach($spec['value'] as $k => $v)$value_str .= "($goods_id,$key,$k),";
		}
		$value_str = rtrim($value_str,',');
		//更新商品键值对表
		$spec_attr->where("goods_id = ".$goods_id)->delete();
		$dbinfo = DBFactory::getDbInfo();
		$spec_attr->query("insert into {$dbinfo['tablePre']}spec_attr values $value_str");
		$this->redirect("goods_list");
	}
	function goods_del()
	{
		$id = Req::args("id");
		$model = new Model();
		$str = '';
		if(is_array($id)){
			$id = implode(',',$id);
			$model->table("spec_attr")->where("goods_id in($id)")->delete();
			$model->table("products")->where("goods_id in($id)")->delete();
			$goods = $model->table("goods")->where("id in ($id)")->findAll();
			$model->table("goods")->where("id in ($id)")->delete();
		}else if(is_numeric($id)){
			$model->table("spec_attr")->where("goods_id = $id")->delete();
			$model->table("products")->where("goods_id = $id")->delete();
			$goods = $model->table("goods")->where("id = $id ")->findAll();
			$model->table("goods")->where("id = $id ")->delete();
		}
		foreach ($goods as $gd) {
			$str .= $gd['name'].'、';
		}
		$str = trim($str,'、');
		Log::op($this->manager['id'],"删除商品","管理员[".$this->manager['name']."]:删除了商品 ".$str);
		$msg = array('success',"成功删除商品 ".$str);
		$this->redirect("goods_list",false,array('msg'=> $msg));
	}
	function goods_list(){

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

	public function virtual_goods_list()
	{
		$condition = Req::args('condition');
		$condition_str = Common::str2where($condition);
		if($condition_str)$this->assign("where",$condition_str);
		else $this->assign("where","1=1");
		$this->assign("condition",$condition);
		$this->redirect();
	}

	public function virtual_template(){
		$auto = Filter::int(Req::args('auto'));
		$model = new Model('virtual_template');
		$objs = $model->where('auto='.$auto)->findAll();
		echo JSON::encode($objs);
	}

	public function upload_file()
	{

		$info = array('status'=>'fail','msg'=>'上传失败!');
		$file = $_FILES['upfile'];
		if($file['error']==4){
			$info['msg'] = '请选择文件后再上传！';
		}
		else if($file['error']==1){
			$info['msg'] = '文件超出了php.ini文件指定大小！';
		}
		else if($file['size']>0){
			$key = md5_file($file['tmp_name']);
			$upfile_path = Tiny::getPath("uploads").'/virtual/';
			$upfile_url = preg_replace("|^".APP_URL."|",'',Tiny::getPath("uploads_url"));
			$upfile = new UploadFile('upfile',$upfile_path,'10m','rar,zip','hash',$key);
			$upfile->save();
			$info = $upfile->getInfo();
			$result = array();
			if($info[0]['status']==1){
				$info = array('status'=>'success','fileid'=>$key);
			}
			else{
				$info['msg']=$info[0]['msg'];
			}

		}
		echo JSON::encode($info);
		exit;
	}

	function create_virtual_goods()
	{
		$template_id = Filter::int(Req::args("template_id"));
		$name = Filter::sql(Req::args("name"));
		$value = Filter::float(Req::args("value"));
		$start_time = Filter::sql(Req::args('start_time'));
		$end_time = Filter::sql(Req::args('end_time'));
		$account = Filter::sql(Req::args('account'));
		$password = Filter::sql(Req::args('password'));



		$data = array(
			'template_id'=>$template_id,
			'name'=>$name,
			'value'=>$value,
			'start_time'=>$start_time,
			'end_time'=>$end_time,
			'status'=>1,
			'account'=>$account,
			'password'=>$password
			);
		$model = new Model('virtual_goods');
		$model->data($data)->insert();
		$info = array(
			'status'=>'success'
			);
		$count = $model->fields("count(id) as num")->where("template_id=".$template_id." and status=1")->find();
		if ($count) {
			$model->table('products')->data(array('store_nums'=>$count['num']))->where('virtual_extend='.$template_id)->update();
			$model->table('goods')->data(array('store_nums'=>$count['num']))->where('virtual_extend='.$template_id)->update();
		}
		echo JSON::encode($info);
	}

	function show_spec_select(){
		$this->layout = '';
		$this->redirect();
	}
	function photoshop(){
		$this->layout = '';
		$this->redirect();
	}
}
