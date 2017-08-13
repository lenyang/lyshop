<?php
/**
 * 首页
 *
 * @author Crazy、Ly
 * @package IndexController
 */
class IndexController extends Controller{

    public $layout='index';
    public $safebox = null;
    private $model = null;
    private $category = array();

    protected $needRightActions=array('review'=>true,'review_act'=>true);

    public function init(){
        header("Content-type: text/html; charset=".$this->encoding);
        $this->model = new Model();
        $this->safebox =  Safebox::getInstance();
        $this->user = $this->safebox->get('user');
        $category = Category::getInstance();
        if($this->user==null){
            $this->user = Common::autoLoginUserInfo();
            $this->safebox->set('user',$this->user);
        }

        $this->category = $category->getCategory();
        $cart = Cart::getCart();
        $this->assign("cart",$cart->all());
        $this->assign("category",$this->category);
        $keyword = urldecode(Req::args('keyword'));
        if($keyword!=null)$this->assign("keyword",Filter::text($keyword));
        $url_index = '/'.Req::args('con').'/'.Req::args('act');
        $url_index = Url::urlFormat($url_index);
        $this->assign("url_index",Url::requestUri());
        //配制中的站点信息
        $config = Config::getInstance();
        $site_config = $config->get("globals");
        $this->assign('seo_title',$site_config['site_name']);
        $this->assign('site_title',$site_config['site_name']);
        $this->assign('seo_keywords',$site_config['site_keywords']);
        $this->assign('seo_description',$site_config['site_description']);

    }
    public function attention()
    {
        $goods_id = Filter::int(Req::args('goods_id'));
        $info = array('status' => 0);
        if(isset($this->user['name'])){
            $obj = $this->model->table("attention")->where("goods_id=$goods_id and user_id=".$this->user['id'])->find();
            if($obj) $info = array('status' => 2);
            else {
                $this->model->table("attention")->data(array('goods_id'=>$goods_id,'user_id'=>$this->user['id'],'time'=>date('Y-m-d H:i:s')))->insert();
                $info = array('status' => 1);
            }
        }
        echo JSON::encode($info);
    }
    public function msg()
    {

        $type = $this->type==null?'fail':$this->type;
        $msg = $this->msg==null?'失败':$this->msg;
        $content = $this->content==null?'':$this->content;
        $redirect = $this->redirect==null?'':$this->redirect;

        $this->assign("type",$type);
        $this->assign("msg",$msg);
        $this->assign("content",$content);
        $this->assign("redirect",$redirect);
        $this->redirect();
    }
    public function img_upload()
    {
        $path = APP_ROOT;
        $upf = new  UploadFile('imgFile',$path,'2m','jpg,jpeg,gif');
        $upf->save();
        $info = $upf->getInfo();
        if($info[0]['status']==1)
        {
            echo JSON::encode(array('error' => 0, 'url' => $info[0]['path']));
            exit;
        }
    }

    public function cart_get()
    {
        $cart = $this->getCart();
        $products = $cart->all();
        echo JSON::encode($products);
    }
    private function getCart(){
        $type = Req::args('cart_type');
        if($type=='goods'){
            return Cart::getCart('goods');
        }else{
            return Cart::getCart();
        }
    }

    public function cart_add()
    {
        $id = Filter::int(Req::args("id"));
        $num = intval(Req::args("num"));
        $num = $num>0?$num:1;
        $cart = $this->getCart();
        $cart->addItem($id,$num);
        $products = $cart->all();
        echo JSON::encode($products);
    }

    public function goods_add()
    {
        $cart = Cart::getCart('goods');
        $cart->clear();
        $id = Filter::int(Req::args("id"));
        $num = intval(Req::args("num"));
        $num = $num>0?$num:1;
        $cart->addItem($id,$num);
        $this->redirect('/simple/cart/cart_type/goods');
    }
    public function cart_del()
    {
        $id = Filter::int(Req::args("id"));
        $cart = $this->getCart();
        $cart->delItem($id);
        $info = array('status' =>"fail");
        if(!$cart->hasItem($id))$info = array('status' =>"success");
        echo JSON::encode($info);
    }

    public function cart_num()
    {
        $id = Filter::int(Req::args("id"));
        $num = intval(Req::args("num"));
        $num = $num>0?$num:1;
        $cart = $this->getCart();
        $cart->modNum($id,$num);
        $products = $cart->all();
        echo JSON::encode($products);
    }
    public function goods_consult()
    {
        $id = Filter::int(Req::args('id'));
        $content = Filter::txt(Req::args("content"));
        $content = TString::nl2br($content);
        $verifyCode = Req::args("verifyCode");
        $this->safebox = Safebox::getInstance();
        $code = $this->safebox->get($this->captchaKey);
        $info = array("status"=>"fail","msg"=>"验证码错误！");
        if(isset($this->user['id']) && $this->user['name']){
            if($code == $verifyCode){
                $this->model->table("ask")->data(array('question'=>$content,'user_id'=>$this->user['id'],'goods_id'=>$id,'ask_time'=>date('Y-m-d H:i:s')))->insert();
                $info = array("status"=>"success","msg"=>"咨询成功！");
                //发送用户咨询通知
                $NoticeService = new NoticeService();
                $template_data = array('user'=>$this->user['name'],
                    'content'=>$content
                    );

                $NoticeService->send('user_ask',$template_data);
            }
        }else{
            $info = array("status"=>"fail","msg"=>"登录后才能咨询。");
        }

        echo JSON::encode($info);
    }
    //帮助
    public function help()
    {
        $id = Filter::int(Req::args("id"));
        $help = $this->model->table('help')->where("id=$id")->find();
        if($help){
            $this->assign("id",$id);
            $this->assign('seo_title',$help['title']);
            $this->assign('help',$help);
            $this->redirect();
        }else{
            Tiny::Msg($this,'帮助文档不存在！');
        }

    }
    //文章
    public function article()
    {
        $id = Filter::int(Req::args("id"));
        $model = new Model('article');
        $article = $model->where("id = $id")->find();
        if($article){
            $this->assign('seo_title',$article['title']);
            $this->assign('article',$article);
            $this->assign("id",$id);
            $this->redirect();
        }else{
            Tiny::Msg($this,'文章不存在！');
        }

    }
    //文章列表
    public function article_list()
    {
        $id = Filter::int(Req::args("id"));
        $this->assign("id",$id);
        $where = "1=1";
        if($id){
            $where = 'category_id = '.$id;
        }
        $this->assign("where",$where);
        $this->redirect();
    }
    public function group()
    {
        $this->assign('seo_title','团购,优惠精选');
        $this->assign('seo_keywords','团购,优惠促销精选');
        $this->redirect();
    }
    public function flash()
    {
        $this->assign('seo_title','抢购,优惠精选');
        $this->assign('seo_keywords','抢购,优惠促销精选,限时抢购,更多优惠.');
        $this->redirect();
    }
    //团购
    public function groupbuy()
    {
        $id = Filter::int(Req::args("id"));
        $goods = $this->model->table("groupbuy as gb")->join("left join goods as go on gb.goods_id = go.id")->where("gb.id=$id")->find();
        if(isset($goods['id'])){
            //检测团购是否结束
            if($goods['store_nums']<=0 || $goods['goods_num']>=$goods['max_num'] || time()>= strtotime($goods['end_time'])){
                $this->model->table('groupbuy')->data(array('is_end'=>1))->where("id=$id")->update();
                $goods['is_end'] = 1;
            }
            $skumap = array();
            $products = $this->model->table("products")->fields("sell_price,market_price,store_nums,specs_key,pro_no,id")->where("goods_id = $goods[id]")->findAll();
            if($products){
                foreach ($products as $product) {
                    $skumap[$product['specs_key']] = $product;
                }
            }
            $attr_array = unserialize($goods['attrs']);
            $goods_attrs = array();
            if($attr_array){
                $rows = $this->model->fields("ga.*,av.name as vname,av.id as vid")->table("goods_attr as ga")->join("left join attr_value as av on ga.id=av.attr_id")->where("ga.type_id = $goods[type_id]")->findAll();
                $attrs = $_attrs = array();
                foreach ($rows as $row) {
                    $attrs[$row['id'].'-'.$row['vid']] = $row;
                    $_attrs[$row['id']] = $row;
                }
                foreach ($attr_array as $key => $value) {
                    if(isset($attrs[$key.'-'.$value])) $goods_attrs[] = $attrs[$key.'-'.$value];
                    else{
                        $_attrs[$key]['vname'] = $value;
                        $goods_attrs[] = $_attrs[$key];
                    }
                }
                unset($attrs,$_attrs);
            }
            $this->assign('seo_title',$goods['title']);
            $this->assign('id',$id);
            $this->assign("skumap",$skumap);
            $this->assign("attr_array",$attr_array);
            $this->assign("goods_attrs",$goods_attrs);
            $this->assign("goods",$goods);
            $this->redirect();
        }else{
            Tiny::Msg($this,"404");
        }
    }
    //抢购
    public function flashbuy(){
        $id = Filter::int(Req::args("id"));
        $goods = $this->model->table("flash_sale as gb")->join("left join goods as go on gb.goods_id = go.id")->where("gb.id=$id")->find();
        if($goods){
            //检测抢购是否结束
            if($goods['store_nums']<=0 || $goods['goods_num']>=$goods['max_num'] || time()>= strtotime($goods['end_time'])){
                $this->model->table('flash_sale')->data(array('is_end'=>1))->where("id=$id")->update();
                $goods['is_end'] = 1;
            }
            $skumap = array();
            $products = $this->model->table("products")->fields("sell_price,market_price,store_nums,specs_key,pro_no,id")->where("goods_id = $goods[id]")->findAll();
            if($products){
                foreach ($products as $product) {
                    $skumap[$product['specs_key']] = $product;
                }
            }
            $attr_array = unserialize($goods['attrs']);
            $goods_attrs = array();
            if($attr_array){
                $rows = $this->model->fields("ga.*,av.name as vname,av.id as vid")->table("goods_attr as ga")->join("left join attr_value as av on ga.id=av.attr_id")->where("ga.type_id = $goods[type_id]")->findAll();
                $attrs = $_attrs = array();
                foreach ($rows as $row) {
                    $attrs[$row['id'].'-'.$row['vid']] = $row;
                    $_attrs[$row['id']] = $row;
                }
                foreach ($attr_array as $key => $value) {
                    if(isset($attrs[$key.'-'.$value])) $goods_attrs[] = $attrs[$key.'-'.$value];
                    else{
                        $_attrs[$key]['vname'] = $value;
                        $goods_attrs[] = $_attrs[$key];
                    }
                }
                unset($attrs,$_attrs);
            }

            $this->assign('id',$id);
            $this->assign("skumap",$skumap);
            $this->assign("attr_array",$attr_array);
            $this->assign("goods_attrs",$goods_attrs);
            $this->assign("goods",$goods);
            $this->redirect();
        }else{
            Tiny::Msg($this,"404");
        }
    }
    //捆绑
    public function bundbuy(){
        $id = Filter::int(Req::args("id"));
        $bund = $this->model->table("bundling")->where("id=$id and status = 1")->find();
        if($bund){
            $goods = $this->model->table("goods")->where("id in ($bund[goods_id])")->findAll();
            $gids = array();
            $goods_price = 0.00;
            foreach ($goods as $go) {
                $gids[] = $go['id'];
                $goods_price += $go['sell_price'];
            }
            $gids = implode(',', $gids);
            $skumap = array();
            $products = $this->model->table("products")->fields("sell_price,market_price,store_nums,specs_key,pro_no,id,goods_id")->where("goods_id in ($gids)")->findAll();
            if($products){
                foreach ($products as $product) {
                    if($product['specs_key'])$skumap[$product['specs_key'].$product['goods_id']] = $product;
                    else $skumap[$product['goods_id']] = $product;
                }
            }
            $this->assign("bund",$bund);
            $this->assign("goods_price",$goods_price);
            $this->assign("skumap",$skumap);
            $this->assign("goods",$goods);
            $this->assign("id",$id);
            $this->redirect();
        }else{
            Tiny::msg($this,'',404);
        }

    }
    //商品展示
    public function product()
    {
        $parse = array('直接打折','减价优惠','固定金额','买就赠优惠券','买M件送N件');
        $id = Filter::int(Req::args('id'));
        $this->assign('id',$id);
        $id = is_numeric($id)?$id:0;
        $goods = $this->model->table("goods as go")->join("left join tiny_goods_category as gc on go.category_id = gc.id")->fields("go.*,gc.path")->where("go.id=$id and go.is_online=0")->find();
        if($goods){

            $skumap = array();
            $products = $this->model->table("products")->fields("sell_price,market_price,store_nums,specs_key,pro_no,id")->where("goods_id = $id")->findAll();
            if($products){
                foreach ($products as $product) {
                    $skumap[$product['specs_key']] = $product;
                }
            }

            $path = trim($goods['path'],',');
            $category = Category::getInstance();
            $childCategory = $category->getCategoryChild($path);
            $category = $this->model->table("goods_category")->where("id in ($path)")->order("field(`id`,$path)")->findAll();
            $time = "'".date('Y-m-d H:i:s')."'";

            $prom = $this->model->table("prom_goods")->where("id=".$goods['prom_id']." and is_close=0 and $time >=start_time and $time <= end_time")->find();


            $attr_array = unserialize($goods['attrs']);
            $goods_attrs = array();
            if($attr_array){
                $rows = $this->model->fields("ga.*,av.name as vname,av.id as vid")->table("goods_attr as ga")->join("left join attr_value as av on ga.id=av.attr_id")->where("ga.type_id = $goods[type_id]")->findAll();
                $attrs = $_attrs = array();
                foreach ($rows as $row) {
                    $attrs[$row['id'].'-'.$row['vid']] = $row;
                    $_attrs[$row['id']] = $row;
                }
                foreach ($attr_array as $key => $value) {
                    if(isset($attrs[$key.'-'.$value])) $goods_attrs[] = $attrs[$key.'-'.$value];
                    else{
                        $_attrs[$key]['vname'] = $value;
                        $goods_attrs[] = $_attrs[$key];
                    }
                }
                unset($attrs,$_attrs);
            }
            //评论
            $comment = array();
            $review = array('1'=>0,'2'=>0,'3'=>0,'4'=>0,'5'=>0);
            $rows = $this->model->table("review")->fields("count(id) as num,point")->where("status=1 and goods_id = $id")->group("point")->findAll();
            foreach ($rows as $row) {
                $review[$row['point']] = intval($row['num']);
            }
            $a = ($review[4]+$review[5]);
            $b = ($review[3]);
            $c = ($review[1]+$review[2]);
            $total = $a+$b+$c;
            $comment['total'] = $total;
            if($total==0) $total = 1;
            $comment['a'] = array('num'=>$a,'percent'=>round((100*$a/$total)));
            $comment['b'] = array('num'=>$b,'percent'=>round((100*$b/$total)));
            $comment['c'] = array('num'=>$c,'percent'=>round((100*$c/$total)));

            if($goods['seo_title']!='') $seo_title = $goods['seo_title'];
            else if($goods['name']!='') $seo_title = $goods['name'];

            if($seo_title!='') $this->assign('seo_title',$seo_title);
            if($goods['seo_keywords']!='') $this->assign('seo_keywords',$goods['seo_keywords']);
            if($goods['seo_description']!='') $this->assign('seo_description',$goods['seo_description']);

            $proms = new Prom();
            $goods['goods_nums'] = PHP_INT_MAX;
            if(!empty($prom))$prom['parse'] = $proms->prom_goods($goods);
            //售后保障
            $sale_protection = $this->model->table('help')->where("title='售后保障'")->find();
            if($sale_protection){
                $this->assign("sale_protection",$sale_protection['content']);
            }
            $this->assign("child_category",$childCategory);
            $this->assign("prom",$prom);
            $this->assign("goods",$goods);
            $this->assign("goods_attrs",$goods_attrs);
            $this->assign("category_nav",$category);
            $this->assign("skumap",$skumap);
            $this->assign("comment",$comment);
            $this->redirect();
        }else{
            Tiny::Msg($this,"404");
        }

    }
    //搜索处理
    public function search()
    {
        $this->parseCondition();
    }
    public function category()
    {
        $this->parseCondition();
    }
    //搜索与分类的条件解析
    private function parseCondition()
    {

        $page = intval(Req::args("p"));
        $page_size = 36;
        $sort = Filter::int(Req::args("sort"));
        $sort = $sort==null?0:$sort;
        $cid = Filter::int(Req::args("cid"));
        $cid = $cid==null?0:$cid;
        $brand = Filter::int(Req::args("brand"));
        $price = Req::args("price");//下面已进行拆分过滤


        $keyword = Req::args('keyword');
        if($keyword!=null){
            $keyword = urldecode($keyword);
            $keyword = Filter::text($keyword);
            $keyword = Filter::commonChar($keyword);
        }

        //初始化数据
        $attrs = $specs = $spec_attr = $category_child = $spec_attr_selected = $selected = $has_category = $category = $current_category = array();
        $where = $spec_attr_where = $url = "";
        $condition_num = 0;

        $model = $this->model;
        //基本条件的建立
        //关于搜索的处理
        $action = strtolower(Req::args("act"));
        if($action=='search'){
            //关于类型的处理
            ////提取商品下的类型
            $seo_title = $seo_keywords = $keyword;
            $where = "name like '%$keyword%'";
            $rows = $model->table("goods")->fields("category_id,count(id) as num")->where($where)->group("category_id")->findAll();
            $category_ids = "";
            $category_count = array();
            foreach ($rows as $row) {
                $category_ids .= $row['category_id'].',';
                $category_count[$row['category_id']] = $row['num'];
            }
            $category_ids = trim($category_ids,",");
            $has_category = array();

            $seo_description = '';

            if($category_ids){

                    //搜索到内容且真正的点击搜索时进行统计
                if($this->getModule()->checkToken()){
                    $keyword = urldecode(Req::args('keyword'));
                    $keyword = Filter::sql($keyword);
                    $keyword = trim($keyword);
                    $len = TString::strlen($keyword);
                    if($len>=2 && $len<=8){
                        $model = new Model("tags");
                        $obj = $model->where("name='$keyword'")->find();
                        if($obj){
                            $model->data(array('num'=>"`num`+1"))->where("id=".$obj['id'])->update();
                        }else{
                            $model->data(array('name'=>$keyword))->insert();
                        }
                    }
                }

                $rows = $model->table("goods_category")->where("id in ($category_ids)")->findAll();
                foreach ($rows as $row) {
                    $path = trim($row['path'],',');
                    $paths = explode(',', $path);
                    $root = 0;
                    if(is_array($paths)) $root = $paths[0];
                    $row['num'] = $category_count[$row['id']];
                    $has_category[$root][] = $row;
                    $seo_description .= $row['name'].',';
                }
            }
            if($cid!=0){
                $where = "category_id=$cid and name like '%$keyword%'";
                $category = $model->table("goods_category as gc ")->join("left join goods_type as gt on gc.type_id = gt.id")->where("gc.id=$cid")->find();
                if($category){
                    $attrs = unserialize($category['attr']);
                    $specs = unserialize($category['spec']);

                    if($category['seo_title']!='') $seo_title = $category['seo_title'];
                    else $seo_title = $category['name'];
                    if($category['seo_keywords']!='') $seo_keywords = $category['seo_keywords'];
                    if($category['seo_description']!='') $seo_description = $category['seo_description'];
                }
            }

        //关于分类检索的处理
        }else if($action=='category'){
            $seo_title = "分类检索";
            $seo_keywords = "全部分类";
            $seo_description = "所有分类商品";
            //取得商品的子分类
            $category_ids = "";
            $categ = Category::getInstance();
            if($cid==0){
                $category_child = $categ->getCategoryChild(0,1);
            }else{
                $current_category = $this->model->table("goods_category as gc")->fields("gc.*,gt.name as gname,gt.attr,gt.spec,gc.seo_title,gc.seo_keywords,gc.seo_description")->join("left join goods_type as gt on gc.type_id = gt.id")->where("gc.id = $cid")->find();
                if($current_category){
                    $path  = trim($current_category['path'],',');
                    $rows = $this->model->table("goods_category")->where("path like '$current_category[path]%'")->order("field(`id`,$path)")->findAll();
                    $category = $this->model->table("goods_category")->where("id in ($path)")->order("field(`id`,$path)")->findAll();

                    foreach ($rows as $row) {
                        $category_ids .= $row['id'].',';
                    }
                    $category_ids = trim($category_ids,",");
                    $category_child = $categ->getCategoryChild($path,1);

                    $attrs = unserialize($current_category['attr']);
                    $specs = unserialize($current_category['spec']);
                    $attrs = is_array($attrs)?$attrs:array();
                    $specs = is_array($specs)?$specs:array();


                }

            }
            $seo_category = $model->table('goods_category')->where("id=$cid")->find();
            if($seo_category){
                if($seo_category['seo_title']!='') $seo_title = $seo_category['seo_title'];
                else $seo_title = $seo_category['name'];
                if($seo_category['seo_keywords']!='') $seo_keywords = $seo_category['name'].','.$seo_category['seo_keywords'];
                else $seo_keywords = $seo_category['name'];
                if($seo_category['seo_description']!='') $seo_description = $seo_category['seo_description'];
                else $seo_description = $seo_category['name'];
            }
            if($category_ids != "")$where = "go.category_id in ($category_ids)";
            else $where = "1=1";

        }
        //品牌筛选
        $rows = $model->table("goods as go")->fields("brand_id,count(id) as num")->where($where)->group("brand_id")->findAll();
        $brand_ids = '';
        $brand_num = $has_brand = array();
        foreach ($rows as $row) {
            $brand_ids .= $row['brand_id'].',';
            $brand_num[$row['brand_id']] = $row['num'];
        }
        $brand_ids = trim($brand_ids,',');

        //价格区间
        $prices = $model->table("goods as go")->fields("max(sell_price) as max,min(sell_price) as min,avg(sell_price) as avg")->where($where)->find();
        $price_range = Common::priceRange($prices);

        if($brand_ids){
            $has_brand = $model->table("brand")->where("id in ($brand_ids)")->findAll();
        }
        //var_dump($price_range);exit();
        if(!empty($price_range))$has_price = array_flip($price_range);
        else $has_price = array();
        if($price && isset($has_price[$price])){
            $prices = explode('-', $price);
            if(count($prices)==2) $where .= " and sell_price>=".Filter::int($prices[0])." and sell_price <=".Filter::int($prices[1]);
            else $where .= " and sell_price>=".Filter::int($prices[0]);
            $url .= "/price/$price";
        }


        if($brand && isset($brand_num[$brand])){
            $url .= "/brand/$brand";
            $where .= " and brand_id = $brand ";
        }

        //规格与属性的处理
        if(is_array($attrs)){
            foreach ($attrs as $attr) {
                if($attr['show_type']==1){
                    $spec_attr[$attr['id']] = $attr;
                }
            }
        }

        if(is_array($specs)){
            foreach ($specs as $spec) {
                $spec['values'] = unserialize($spec['value']);
                unset($spec['value'],$spec['spec']);
                $spec_attr[$spec['id']] = $spec;
            }
        }
        foreach ($selected as $key => $value) {
            if(isset($spec_attr[$key])){
                $spec_attr_selected[$key] = $spec_attr[$key];
                foreach ($spec_attr_selected[$key]['values'] as $k => $v) {
                    if($value == $v['id']){
                        $spec_attr_selected[$key]['values'] = $v;
                        break;
                    }
                }
            }
        }


        //规格处属性的筛选
        $args = Req::args();
        unset($args['con'],$args['act'],$args['p'],$args['sort'],$args['brand'],$args['price']);
        foreach ($args as $key => $value) {
            if(is_numeric($key) && is_numeric($value)){
                if(isset($spec_attr[$key])){
                    $spec_attr_where .= "or (`key`=$key and `value` = $value) ";
                    $condition_num++;
                    $url .= '/'.$key.'/'.$value;
                }
            }
            $selected[$key] = $value;
        }
        $selected['price'] = $price;
        $selected['brand'] = $brand;

        $spec_attr_where = trim($spec_attr_where,"or");
        $where .= ' and go.is_online =0';
        if($condition_num>0){
            $where .= " and go.id in (select goods_id from tiny_spec_attr where $spec_attr_where group by goods_id having count(goods_id) >= $condition_num)";
        }

        //排序的处理
        switch ($sort) {
            case '1':
            $goods_model = $model->table("goods as go")->join("left join tiny_order_goods as og on go.id = og.goods_id")->fields("go.*,sum(og.goods_nums) as sell_num")->order("sell_num desc")->group("go.id");
            break;
            case '2':
            $goods_model = $model->table("goods as go")->join("left join tiny_review as re on go.id = re.goods_id")->fields("go.*,count(re.goods_id) as renum")->group("go.id")->order("renum desc");
            break;
            case '3':
            $goods_model = $model->table("goods as go")->order("sell_price desc");
            break;
            case '4':
            $goods_model = $model->table("goods as go")->order("sell_price");
            break;
            case '5':
            $goods_model = $model->table("goods as go")->order("id desc");
            break;
            default:
            $goods_model = $model->table("goods as go")->order("sort desc");
            break;
        }
        //var_dump($where);exit;
        //提取商品
        $goods = $goods_model->where($where)->findPage($page,$page_size);

        //品牌处理
        preg_match_all('!(<(a|span)[^>]+>(上一页|下一页)</\2>)!', $goods['html'], $matches);
        $topPageBar = "";
        if(count($matches[0])>0) $topPageBar = implode("", $matches[0]);
        $this->assign("topPageBar",$topPageBar);

        //赋值处理
        $this->assign('seo_title',$seo_title);
        $this->assign('seo_keywords',$seo_keywords);
        $this->assign('seo_description','对应的商品共有'.$goods['page']['total'].'件商品,包括以下分类：'.$seo_description);

        $keyword = str_replace('|', '',$keyword);
        $this->assign("keyword",$keyword);
        $this->assign("sort",$sort);
        $this->assign("has_brand",$has_brand);
        $this->assign("brand_num",$brand_num);
        $this->assign("current_category",$current_category);
        $this->assign("goods",$goods);
        $this->assign("selected",$selected);
        $this->assign("spec_attr",$spec_attr);
        $this->assign("spec_attr_selected",$spec_attr_selected);
        $this->assign("category_child",$category_child);
        $this->assign("price_range",$price_range);
        $this->assign("category_nav",$category);
        $this->assign("has_category",$has_category);
        $this->assign("cid",$cid);



        if($action=='search') $this->assign("url","/index/search/keyword/".$keyword."/cid/$cid/sort/$sort".$url);
        else $this->assign("url","/index/category/cid/".$cid."/sort/$sort".$url);
        $this->redirect();


    }
    //取得咨询
    public function get_ask(){
        $page = Filter::int(Req::args("page"));
        $id = Filter::int(Req::args("id"));
        $asks = $this->model->table("ask as ak")->fields("ak.*,ak.id as id,us.name as uname,us.head_pic")->join("left join user as us on ak.user_id = us.id")->where("ak.goods_id = $id and ak.status!=2")->order('ak.id desc')->findPage($page,10,1,true);
        foreach ($asks['data'] as $key => $value) {
            $asks['data'][$key]['head_pic'] = $value['head_pic']!=''?Url::urlFormat("@").$value['head_pic']:Url::urlFormat("#images/no-img.png");
            $asks['data'][$key]['uname'] = TString::msubstr($value['uname'],0,3,'utf-8','***');
        }
        $asks['status'] = "success";
        echo JSON::encode($asks);

    }
    //取得评价
    public function get_review(){
        $page = Filter::int(Req::args("page"));
        $id = Filter::int(Req::args("id"));
        $pagetype = Filter::int(Req::args("pagetype"));
        $score = Req::args("score");
        $where = "re.status=1 and re.goods_id = $id";
        switch ($score) {
            case 'a':
            $where .= " and re.point > 3";
            break;
            case 'b':
            $where .= " and re.point = 3";
            break;
            case 'c':
            $where .= " and re.point < 3";
            break;
            default:
            break;
        }
        $review = $this->model->table("review as re")->join("left join user as us on re.user_id = us.id")->fields("re.*,re.id as id,us.name as uname,us.head_pic")->where($where)->order("re.id desc")->findPage($page,10,$pagetype,true);
        $data = $review['data'];
        foreach ($data as  $key => $value) {
            $data[$key]['point'] = round($data[$key]['point']/5,2)*100;
            $data[$key]['head_pic'] = $value['head_pic']!=''?Url::urlFormat("@").$value['head_pic']:Url::urlFormat("#images/no-img.png");
            $data[$key]['uname'] = TString::msubstr($value['uname'],0,3,'utf-8','***');

        }
        $review['data'] = $data;
        $review['status'] = "success";
        echo JSON::encode($review);
    }

    function index(){
        $this->redirect();
    }
    public function login(){
        $this->layout = "simple";
        $this->redirect("login");
    }
    public function result(){
        $this->layout = "simple";
        $this->redirect();
    }
    public function reg()
    {
        $this->layout = "simple";
        $this->redirect("reg");
    }
    //订阅到货通知
    public function notify()
    {
        $rules = array('email:email:邮箱格式不正确!','mobile:mobi:手机格式不正确!');
        $validator_info = Validator::check($rules);
        if(is_array($validator_info)){
            array('status'=>'fail','msg'=>$validator_info['msg']);
            echo JSON::encode($info);
        }else{
            $goods_id = Filter::int(Req::args('goods_id'));
            $email = Filter::sql(Req::args('email'));
            $mobile = Filter::int(Req::args('mobile'));
            $model =  new Model('notify');

            $register_time = Date('Y-m-d H:i:s');
            $info = array('status'=>'fail','msg'=>'您还没有登录，无法订阅到货通知。');
            if(isset($this->user['id'])){
                $time = date('Y-m-d H:i:s' , strtotime('-3 day'));
                $obj = $model->where('user_id = '.$this->user['id'].' and goods_id='.$goods_id.' and register_time >'."'$time'")->find();
                if($obj){
                    $info = array('status'=>'warning','msg'=>'您已订阅过了该商品的到货通知。');
                }else{
                    $data = array('user_id'=>$this->user['id'],'goods_id'=>$goods_id,'register_time'=>$register_time,'email'=>$email,'mobile'=>$mobile);
                    $last_id = $model->data($data)->insert();
                    if($last_id>0)$info = array('status'=>'success','msg'=>'订阅成功。');
                    else $info = array('status'=>'fail','msg'=>'订阅失败。');
                }
            }
            echo JSON::encode($info);
        }

    }
    //用户商品评价
    public function review()
    {
        $id = Filter::int(Req::args('id'));
        $review = $this->model->table("review as re")->join("left join goods as go on re.goods_id = go.id")->fields("re.*,go.name,go.img,go.id as gid,go.sell_price")->where("re.id=$id and user_id = ".$this->user['id']." and status=0")->find();
        if($review){
            $this->assign("review",$review);
            $this->redirect();
        }
        else{
            $this->redirect("msg",false,array('type'=>'fail','msg'=>'商品已经评论。'));
        }
    }
    public function review_act(){
        $id = Filter::int(Req::args('id'));
        $point = intval(Req::args('point'));
        if($point>5)$point = 5;
        elseif ($point<1) $point = 1;
        $content = Filter::txt(Req::args('content'));
        $content = TString::nl2br($content);

        $flage = $this->model->table("review")->data(array('status'=>1,'point'=>$point,'content'=>$content,'comment_time'=>date('Y-m-d')))->where("id=$id and user_id=".$this->user['id'])->update();
        $this->redirect("msg",false,array('type'=>"success",'msg'=>"评价成功！","redirect"=>"/ucenter/review"));
    }
    public function reg_act(){
        $email = Filter::sql(Req::post('email'));
        $passWord = Req::post('password');
        $rePassWord = Req::post('repassword');
        $this->safebox = Safebox::getInstance();
        $code = $this->safebox->get($this->captchaKey);
        $verifyCode = Req::args("verifyCode");
        $info = array('field'=>'verifyCode','msg'=>'验证码错误!');
        if($verifyCode==$code){
            if($passWord == $rePassWord){
                $model = $this->model->table("user");
                $obj = $model->where("email='$email'")->find();
                if($obj==null){
                    $validcode = CHash::random(8);
                    $model->data(array('email'=>$email,'name'=>$email,'password'=>CHash::md5($passWord,$validcode),'validcode'=>$validcode))->insert();
                    $this->redirect("index");
                }
                else{
                    $info = array('field'=>'email','msg'=>'此用户已经被注册！');
                }
            }
            else{
                $info = array('field'=>'repassword','msg'=>'两次密码输入不一致！');
            }
        }
        $this->assign("invalid",$info);
        $this->redirect("reg",false,Req::args());
    }
    public function js()
    {

        $id = Filter::sql(Req::args("id"));
        $model = new Model("ad");
        $time = date('Y-m-d');

        $ad = $model->where("number = '$id' and start_time<='$time' and end_time >='$time'")->find();
        if($ad==null) return;
        if($ad['is_open']==0) return;
        if($ad['type']!=5) $ad['content'] = unserialize($ad['content']);
        $str = '';
        $width = "";
        if($ad['width']==0) $width = "width:100%;";
        else $width = "width:".$ad['width'].'px;';
        if($ad['type']==1){
            foreach ($ad['content'] as $key => $item) {
               if($item['url']) $str = '<a href="'.$item['url'].'" target="_blank"><img src="'.Url::fullUrlFormat('@'.$item['path']).'" title="'.$item['title'].'"></a>';
               else $str = '<img src="'.Url::fullUrlFormat('@'.$item['path']).'" title="'.$item['title'].'">';
           }
       }
       else if($ad['type']==2){
          $str = '';

          foreach ($ad['content'] as $key => $item) {
                //$str .= '<a href="'.$item['url'].'" target="_blank" style="display:block;height:'.$ad['height'].'px;position:relative;width:100%;">fff</a>';
           if($item['url']) $str .= '<li  style="background-image: url('.Url::fullUrlFormat('@'.$item['path']).'); background-position: 50% 0%; background-repeat: no-repeat no-repeat; height: '.$ad['height'].'px;'.$width.';float:left;"><a href="'.$item['url'].'" target="_blank"></a></li>';
           else $str .= '<li  style="background-image: url('.Url::fullUrlFormat('@'.$item['path']).'); background-position: 50% 0%; background-repeat: no-repeat no-repeat; height: '.$ad['height'].'px;'.$width.';float:left;"></li>';
       }

       $str = '<div id="slider-'.$ad['number'].'" class="slider" style="margin-top:10px; height: '.$ad['height'].'px;'.$width.'"><ul class="items" style="white-space:nowrap;">'.$str.'</ul></div>';



   }
   else if($ad['type']==3){
    $content = $ad['content'];
    $str = '<a href="'.$content['url'].'" style="color:'.$content['color'].'" target="_blank">'.$content['title'].'</a>';
}
else if($ad['type']==4){
    foreach ($ad['content'] as $key => $item) {
       if($item['url']) $str = '<a href="'.$item['url'].'" target="_blank"><img src="'.Url::fullUrlFormat('@'.$item['path']).'" title="'.$item['title'].'"></a>';
       else $str = '<img src="'.Url::fullUrlFormat('@'.$item['path']).'" title="'.$item['title'].'">';
   }
            //$str = '<div style="position: fixed;left:0;bottom:0">'.$str.'</div>';
}
else{
    $str = preg_replace('/(\n|\r)/i', ' ', $ad['content']);
    $str = preg_replace("/'/i", "\'", $str);
}
$css='';
if($ad['type']==4){
    $info = $ad['content'][0];

    switch($info['position']){
        case 0:
        $css = "{left:0,top:0,right:'',bottom:'','z-index': 10000}";
        break;
        case 1:
        $css = "{left:w_middle,top:0,right:'',bottom:'','z-index': 10000}";
        break;
        case 2:
        $css = "{right:0,top:0,left:'',bottom:'','z-index': 10000}";
        break;
        case 3:
        $css = "{right:'',top:h_middle,left:0,bottom:'','z-index': 10000}";
        break;
        case 4:
        $css = "{right:'',top:h_middle,left:w_middle,bottom:'','z-index': 10000}";
        break;
        case 5:
        $css = "{right:0,top:h_middle,left:'',bottom:'','z-index': 10000}";
        break;
        case 6:
        $css = "{right:'',top:'',left:0,bottom:0,'z-index': 10000}";
        break;
        case 7:
        $css = "{right:'',top:'',left:w_middle,bottom:0,'z-index': 10000}";
        break;
        case 8:
        $css = "{right:0,top:'',left:'',bottom:0,'z-index': 10000}";
        break;

    }

    if($info['is_close']==1)$str .= '<a style="dispaly:block;border:red 1px solid;text-decoration: none; background: #f1f1f1; width:12px;height:12px; position:absolute;top:2px;right:2px;font-size:12px;font-family: serif;color:red;" href="javascript:$(\\\'#ad-'.$ad['number'].'\\\').remove()">×</a>';

    $str = '<div id="ad-'.$ad['number'].'" style="position: fixed;left:0;bottom:0;'.$width.'height:'.$ad['height'].'px;overflow: hidden;">'.$str.'</div>';
}
else{
    $str = '<div id="ad-'.$ad['number'].'" style="'.$width.'height:'.$ad['height'].'px;overflow: hidden;">'.$str.'</div>';
}
if($ad['type']==2)$str.='<script type="text/javascript">$("#slider-'.$ad['number'].'").Slider();</script>';
else if($ad['type']==4){
    $css = preg_replace('/\'/', '"', $css);
    $str.='<script type="text/javascript"> var w_middle = ($(window).width()-$("#ad-'.$ad['number'].'").width())/2+"px";var h_middle = ($(window).height()-$("#ad-'.$ad['number'].'").height())/2+"px";var css='.$css.';$("#ad-'.$ad['number'].'").css(css);</script>';
}
header('Content-type: text/javascript');
echo "document.write('".$str."');";
        // exit;
}
public function checkRight($actionId){
    if(isset($this->needRightActions[$actionId]) && $this->needRightActions[$actionId]){
        if(isset($this->user['name']) && $this->user['name']!=null) return true;
        else return false;
    }
    else return true;
}
public function noRight(){
    $this->redirect("/simple/login");
}
}
