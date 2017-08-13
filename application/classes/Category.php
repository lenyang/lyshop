<?php
class Category{
	private $model = null;
	private static $category=null;
	private $_iniCategory = null;
	private function __construct(){
		$this->model = new Model();
	}
	private function __clone(){}
    public static function getInstance()
    {
		if(!self::$category instanceof self)
		{
			self::$category = new self();
		}
		return self::$category;
    }
	public function getCategoryChild($path,$parent_level=0){
        $category = $this->getCateGory();
        $child = array();
        if(is_string($path)) $path = explode(",", $path);
        if(is_array($path)){
            $len = count($path);
            if($parent_level>$len || $parent_level<0) $parent_level = 0;
            if($len==1){
                if($parent_level==0)$child = $category[$path[0]];
                else $child['child'] = $category;
            }
            else if($len>1){
                $child = $category[$path[0]];
                $len = $len-$parent_level;
                for($i=1;$i<$len;$i++)if(isset($child['child'][$path[$i]]))$child = $child['child'][$path[$i]];
            }
        }
        return $child;
    }
    public function getCateGory(){
    	$cache = CacheFactory::getInstance();
        $items = $cache->get("_GoodsCategory");
        if($cache->get("_GoodsCategory")===null)
        {
            $items = $this->_CategoryInit(0);
            $cache->set("_GoodsCategory",$items,315360000);
        }
        return $items;
    }
	private function _CategoryInit($id, $level = '0') {
        $result = $this->model->table('goods_category')->where("parent_id=".$id)->order("sort desc")->findAll();
        $list = array();
        if($result) {
            foreach($result as $key => $value) {
                $id = $value['id'];
                $list[$id]['id'] = $value['id'];
                $list[$id]['pid'] = $value['parent_id'];
                $list[$id]['title'] = $value['name'];
                $list[$id]['level'] = $level;
                $list[$id]['path'] = $value['path'];
                $list[$id]['img'] = $value['img'];
                $list[$id]['imgs'] = $value['imgs'];
                $list[$id]['nav_show'] = $value['nav_show'];
                $list[$id]['list_show'] = $value['list_show'];
                $list[$id]['child'] = $this->_CategoryInit($value['id'], $level + 1);
            }
        }
        return $list;
    }
}
