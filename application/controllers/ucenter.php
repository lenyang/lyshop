<?php
/**
 * 内容模块
 *
 * @author Crazy、Ly
 * @package SimpleController
 */
class UcenterController extends Controller
{

    public $layout='index';
    public $safebox = null;
    private $model = null;
    private $category = array();
    private $cookie_time = 31622400;
    public  $sidebar = array(
        '交易管理'=>array(
            '我的订单'=>'order',
            '退款申请'=>'refund',
            '我的关注'=>'attention',
            ),
        '客户服务'=>array(
            '商品咨询'=>'consult',
            '商品评价'=>'review',
            '我的消息'=>'message',
            ),
        '账户管理'=>array(
            '个人资料'=>'info',
            '账户安全'=>'safety',
            '账号绑定'=>'union',
            '收货地址'=>'address',
            '我的优惠券'=>'voucher',
            '账户金额'=>'account',
            '我的积分'=>'point',
            )

        );

    public function init()
    {
        header("Content-type: text/html; charset=".$this->encoding);
        $this->model = new Model();
        $this->safebox =  Safebox::getInstance();
        $this->user = $this->safebox->get('user');
        if($this->user==null){
            $this->user = Common::autoLoginUserInfo();
            $this->safebox->set('user',$this->user);
        }
        $category = Category::getInstance();

        $this->category = $category->getCategory();
        $cart = Cart::getCart();
        $action = Req::args("act");
        switch ($action) {
            case 'order_detail':
            $action = 'order';
            break;
            case 'refund_detail':
            $action = 'refund';
            case 'check_identity':
            $action = 'safety';
            case 'update_obj':
            $action = 'safety';
            case 'update_obj_success':
            $action = 'safety';
            break;
        }
        $this->assign("actionId",$action);
        $this->assign("cart",$cart->all());
        $this->assign("sidebar",$this->sidebar);
        $this->assign("category",$this->category);
        $this->assign("url_index",'');
        $this->assign("seo_title","用户中心");
    }

    public function checkRight($actionId)
    {
        if(isset($this->user['name']) && $this->user['name']!=null){
            return true;
        }else{
            return false;
        }
    }
    public function noRight()
    {
        $this->redirect("/simple/login");
    }

    public function withdraw()
    {
        Filter::form();
        $account = floatval(Req::args('account'));
        $name = Filter::txt(Req::args('name'));
        $type_name = Filter::txt(Req::args('type_name'));
        $account = Filter::txt(Req::args('account'));
        $amount = Filter::float(Req::args('amount'));
        $info = array('status'=>'success','msg'=>'申请成功.');

        $model = new Model('customer');
        $customer = $model->where("user_id=".$this->user['id'])->find();
        if($customer['balance']<$amount){
            $info = array('status'=>'fail','msg'=>'提现金额超出的账户余额');
        }
        $obj = $model->table("withdraw")->where("user_id=".$this->user['id'].' and status=0')->find();
        if($obj){
            $info = array('status'=>'fail','msg'=>'上次申请的提现，还未处理，处理后才可再申请。');
        }else{
            $data = array('name'=>$name,'type_name'=>$type_name,'account'=>$account,'amount'=>$amount,'time'=>date('Y-m-d H:i:s'),'user_id'=>$this->user['id']);
            $model->table("withdraw")->data($data)->insert();

            //发送提现申请提醒
            $NoticeService = new NoticeService();
            $template_data = array('user'=>$this->user['name'],'amount'=>$amount,'account'=>$type_name.'('.$account.')','name'=>$name);
            $NoticeService->send('withdrawal_application',$template_data);
        }
        echo JSON::encode($info);

    }
    public function point()
    {
        $customer = $this->model->table("customer")->where("user_id=".$this->user['id'])->find();
        $this->assign("customer",$customer);
        $this->redirect();
    }
    public function point_exchange()
    {
        $id = Filter::int(Req::args('id'));
        $voucher = $this->model->table("voucher_template")->where("id=$id")->find();
        if($voucher){
            $use_point = 0 - $voucher['point'];
            $result = Pointlog::write($this->user['id'], $use_point, '积分兑换代金券，扣除了'.$use_point.'积分');
            if(true===$result){
                Common::paymentVoucher($voucher,$this->user['id']);
                $info = array('status'=>'success');
            }else{
                $info = array('status'=>'fail','msg'=>$result['msg']);
            }
            echo JSON::encode($info);
        }else{
            $info = array('status'=>'fail','msg'=>'你要兑换的代金券，不存在！');
            echo JSON::encode($info);
        }
    }

    public function upload_head()
    {
        $upfile_path = Tiny::getPath("uploads")."/head/";
        $upfile_url = preg_replace("|".APP_URL."|",'',Tiny::getPath("uploads_url")."head/",1);
        //$upfile_url = strtr(Tiny::getPath("uploads_url")."head/",APP_URL,'');
        $upfile = new UploadFile('imgFile',$upfile_path,'500k','','hash',$this->user['id']);
        $upfile->save();
        $info = $upfile->getInfo();
        $result = array();
        if($info[0]['status']==1){
            $result = array('error'=>0,'url'=>$upfile_url.$info[0]['path']);
            $image_url = $upfile_url.$info[0]['path'];
            $image = new Image();
            $image->suffix = '';
            $image->thumb(APP_ROOT.$image_url,100,100);
            $model = new Model('user');
            $model->data(array('head_pic'=>$image_url))->where("id=".$this->user['id'])->update();

            $safebox =  Safebox::getInstance();
            $user = $this->user;
            $user['head_pic'] = $image_url;
            $safebox->set('user',$user);
        }
        else{
            $result = array('error'=>1,'message'=>$info[0]['msg']);
        }
        echo JSON::encode($result);
    }
    public function account()
    {
        $customer = $this->model->table("customer")->where("user_id=".$this->user['id'])->find();
        $this->assign("customer",$customer);
        $this->redirect();
    }
    public function refund_act()
    {
        $order_no = Filter::sql(Req::args('order_no'));
        $order = $this->model->table("order")->where("order_no='$order_no' and user_id = ".$this->user['id'])->find();
        if($order){
            if($order['pay_status']==1){
                $refund = $this->model->table("doc_refund")->where("order_no='$order_no' and user_id = ".$this->user['id'])->find();
                if($refund){
                    $this->redirect("refund",false,array('msg'=>array("warning","不能重复申请退款！")));
                }
                else{
                    Filter::form(array('text'=>'account_name|refund_account|account_bank|content','int'=>'order_no|refund_type'));
                    $data = array(
                        'account_name'=>Req::args('account_name'),
                        'refund_account'=>Req::args('refund_account'),
                        'account_bank'=>Req::args('account_bank'),
                        'order_no'=>Req::args('order_no'),
                        'refund_type'=>Req::args('refund_type'),
                        'create_time'=>date('Y-m-d H:i:s'),
                        'user_id'=>$this->user['id'],
                        'order_id'=>$order['id'],
                        'content'=>Req::args('content'),
                        'pay_status'=>0
                        );
                    $this->model->table("doc_refund")->data($data)->insert();
                    $this->redirect("refund",false,array('msg'=>array("success","申请已经成功提交,请等候处理！")));
                }
            }else{
                $this->redirect("refund",false,array('msg'=>array("warning","此订单还未支付，无法申请退款！")));
            }

        }else{
            $this->redirect("refund",false,array('msg'=>array("warning","此订单编号不存在！")));
        }
    }
    public function refund_detail()
    {
        $id = Filter::int(Req::args('id'));
        $refund = $this->model->table("doc_refund")->where("id=$id and user_id=".$this->user['id'])->find();
        if($refund){
            $this->assign("refund",$refund);
            $this->redirect();
        }
        else{
            Tiny::Msg($this, 404);
        }
    }
    public function refund_del()
    {
        $order_no = Filter::sql(Req::args('order_no'));
        $obj = $this->model->table("doc_refund")->where("order_no='$order_no' and  pay_status=0 and user_id = ".$this->user['id'])->delete();
        $this->redirect("refund");
    }
    public function voucher_activated()
    {
        if(!Tiny::app()->checkToken())$this->redirect("voucher");
        $rules = array('account:required:账号不能为空!','password:required:密码不能为空！');
        $info = Validator::check($rules);
        if(!is_array($info) && $info==true) {
            Filter::form(array('sql'=>'account'));
            $account = Filter::sql(Req::args("account"));
            $voucher = $this->model->table("voucher")->where("account='$account' and is_send = 0")->find();
            if($voucher && $voucher['password'] == Req::args("password")){
                if(strtotime($voucher['end_time']) > time()){
                    if($voucher['status'] ==0){
                        $this->model->table("voucher")->data(array('user_id'=>$this->user['id'],'is_send'=>1,'status'=>0))->where("account='$account'")->update();
                        $this->redirect("voucher",false,array('msg'=>array("success","优惠券成功激活！")));
                    }else{
                        $this->redirect("voucher",false,array('msg'=>array("warning","此优惠券已使用过！")));
                    }
                }
                else{
                    //过期
                    $this->redirect("voucher",false,array('msg'=>array("warning","优惠券已过期！")));
                }

            }else{
                //不存在此优惠券
                $this->redirect("voucher",false,array('msg'=>array("error","优惠券账号或密码错误！")));
            }
        }else{
            //输入信息有误
            $this->redirect("voucher",false,array('msg'=>array("info","输入的信息不格式不正确")));
        }
    }
    public function get_consult()
    {
        $page = Filter::int(Req::args("page"));
        $type = Filter::int(Req::args("type"));
        $status = Req::args("status");
        $where = "ak.user_id = ".$this->user['id'];
        switch ($status) {
            case 'n':
            $where .= " and ak.status = 0";
            break;
            case 'y':
            $where .= " and ak.status = 1";
            break;
            default:
            break;
        }
        $ask = $this->model->table("ask as ak")->join("left join goods as go on ak.goods_id = go.id")->fields("ak.*,go.name,go.id as gid,go.img,go.sell_price")->where($where)->order("ak.id desc")->findPage($page,10,$type,true);
        foreach ($ask['data'] as $key => $value) {
            $ask['data'][$key]['img'] = Common::thumb($value['img'],100,100);
        }
        $ask['status'] = "success";
        echo JSON::encode($ask);
    }
    //获取商品评价
    public function get_review()
    {
        $page = Filter::int(Req::args("page"));
        $type = Filter::int(Req::args("type"));
        $status = Req::args("status");
        $where = "re.user_id = ".$this->user['id'];
        switch ($status) {
            case 'n':
            $where .= " and re.status = 0";
            break;
            case 'y':
            $where .= " and re.status = 1";
            break;
            default:
            break;
        }
        $review = $this->model->table("review as re")->join("left join goods as go on re.goods_id = go.id")->fields("re.*,go.name,go.id as gid,go.img as img,go.sell_price")->where($where)->order("re.id desc")->findPage($page,10,$type,true);
        $data = $review['data'];
        foreach ($data as $key => $value) {
            $value['point'] = ($value['point']/5)*100;
            $data[$key] = $value;
        }
        $review['status'] = "success";
        $review['data'] = $data;
        echo JSON::encode($review);
    }
    //获取商品评价
    public function get_message()
    {
        $page = Filter::int(Req::args("page"));
        $type = Filter::int(Req::args("type"));
        $status = Req::args("status");
        $where = "";
        $customer = $this->model->table("customer")->where("user_id=".$this->user['id'])->find();
        $message_ids = '';
        if($customer){
            $message_ids = ','.$customer['message_ids'].',';
            switch ($status) {
                case 'y':
                $message_ids = preg_replace('/,\d+,/i', ',', $message_ids);
                $message_ids = preg_replace('/-/i','',$message_ids);
                break;
                case 'n':
                $message_ids = preg_replace('/,-\d+,/i', ',', $message_ids);
                break;
                default:
                break;
            }
            $message_ids = trim($message_ids,',');
        }

        $message  = array();
        if($message_ids!=''){
            $message = $this->model->table("message")->where("id in ($message_ids)")->order("id desc")->findPage($page,10,$type,true);
        }
        $message['status'] = "success";
        echo JSON::encode($message);
    }

    public function message_read()
    {
        $id = Filter::int(Req::args("id"));
        $customer = $this->model->table("customer")->where("user_id=".$this->user['id'])->find();
        $message_ids = ','.$customer['message_ids'].',';
        $message_ids = str_replace(",$id,",',-'.$id.',',$message_ids);
        $message_ids = trim($message_ids,',');
        $this->model->table("customer")->where("user_id=".$this->user['id'])->data(array('message_ids'=>$message_ids))->update();
        echo JSON::encode(array("status"=>'success'));
    }
    public function message_del()
    {
        $id = Filter::int(Req::args("id"));
        $customer = $this->model->table("customer")->where("user_id=".$this->user['id'])->find();
        $message_ids =','.$customer['message_ids'].',';
        $message_ids = str_replace(",-$id,",',',$message_ids);
        $message_ids = rtrim($message_ids,',');
        $this->model->table("customer")->where("user_id=".$this->user['id'])->data(array('message_ids'=>$message_ids))->update();
        echo JSON::encode(array("status"=>'success'));
    }
    public function get_voucher()
    {
        $page = Filter::int(Req::args("page"));
        $pagetype = Filter::int(Req::args("pagetype"));
        $status = Req::args("status");
        $where = "user_id = ".$this->user['id']." and is_send = 1";
        switch ($status) {
            case 'n':
            $where .= " and status = 0 and '".date("Y-m-d H:i:s")."' <=end_time";
            break;
            case 'u':
            $where .= " and status = 1";
            break;
            case 'p':
            $where .= " and status = 0 and '".date("Y-m-d H:i:s")."' > end_time";
            break;
            default:
            break;
        }
        $voucher = $this->model->table("voucher")->where($where)->order("id desc")->findPage($page,10,$pagetype,true);
        $data = $voucher['data'];
        foreach ($data as $key => $value) {
            $value['start_time'] = substr($value['start_time'],0,10);
            $value['end_time'] = substr($value['end_time'],0,10);
            $data[$key] = $value;
        }
        $voucher['data'] = $data;
        $voucher['status'] = "success";
        echo JSON::encode($voucher);
    }
    public function info()
    {
        $info = $this->model->table("customer as cu ")->fields("cu.*,us.email,us.name,gr.name as gname")->join("left join user as us on cu.user_id = us.id left join grade as gr on cu.group_id = gr.id")->where("cu.user_id = ".$this->user['id'])->find();
        if($info){
            $this->assign("info",$info);
            $info = array_merge($info,Req::args());
            $this->redirect("info",false,$info);
        }else Tiny::Msg($this, 404);

    }
    public function info_save()
    {
        $rules = array('name:required:昵称不能为空!','real_name:required:真实姓名不能为空!','sex:int:性别必需选择！','birthday:date:生日日期格式不正确！','province:[1-9]\d*:选择地区必需完成','city:[1-9]\d*:选择地区必需完成','county:[1-9]\d*:选择地区必需完成');
        $info = Validator::check($rules);
        if(is_array($info)){
            $this->redirect("info",false,array('msg'=>array("info",$info['msg'])));
        }else{
            $data = array(
                'name'=>Filter::txt(Req::args('name')),
                'real_name'=>Filter::text(Req::args('real_name')),
                'sex'=>Filter::int(Req::args('sex')),
                'birthday'=>Filter::sql(Req::args('birthday')),

                'phone'=>Filter::sql(Req::args('phone')),
                'province'=>Filter::int(Req::args('province')),
                'city'=>Filter::int(Req::args('city')),
                'county'=>Filter::int(Req::args('county')),
                'addr'=>Filter::text(Req::args('addr'))
                );


            if($this->user['mobile'] == ''){
                $mobile = Filter::int(Req::args('mobile'));
                $obj = $this->model->table("customer")->where("mobile='$mobile'")->find();
                $data['mobile'] = $mobile;
                if($obj){
                    $this->redirect("info",false,array('msg'=>array("info",'此手机号已经存在！')));
                    exit;
                }
            }
            if($this->user['email'] == $this->user['mobile'].'@no.com'){
                $email = Req::args('email');
                if(Validator::email($email)){
                    $userData['email'] = $email;
                    $obj = $this->model->table("user")->where("email='$email'")->find();
                    if($obj){
                        $this->redirect("info",false,array('msg'=>array("info",'此邮箱号已存在')));
                        exit;
                    }
                }
            }

            $userData['name'] = Filter::sql(Req::args("name"));
            $id = $this->user['id'];
            $this->model->table("user")->data($userData)->where("id=$id")->update();

            $this->model->table("customer")->data($data)->where("user_id=$id")->update();
            $obj = $this->model->table("user as us")->join("left join customer as cu on us.id = cu.user_id")->fields("us.*,cu.group_id,cu.login_time,cu.mobile")->where("us.id=$id")->find();
            $this->safebox->set('user',$obj,$this->cookie_time);
            $this->redirect("info",false,array('msg'=>array("success","保存成功！")));
        }
    }
    public function attention()
    {
        $page = Filter::int(Req::args('p'));
        $attention = $this->model->table("attention as at")->fields("at.*,go.name,go.store_nums,go.img,go.sell_price,go.id as gid")->join("left join goods as go on at.goods_id = go.id")->where("at.user_id = ".$this->user['id'])->findPage($page);
        $this->assign("attention",$attention);
        $this->redirect();
    }
    public function attention_del()
    {
        $id = Filter::int(Req::args("id"));
        if(is_array($id)){
            $ids = implode(",", $id);
        }else{
            $ids = $id;
        }
        $this->model->table("attention")->where("id in($ids) and user_id=".$this->user['id'])->delete();
        $this->redirect("attention");
    }
    //商品展示与商品状态修改
    public function order()
    {
        $config = Config::getInstance();
        $config_other = $config->get('other');
        $valid_time = array();
        $valid_time[0] = isset($config_other['other_order_delay'])?intval($config_other['other_order_delay']):0;
        $valid_time[1] = isset($config_other['other_order_delay_group'])?intval($config_other['other_order_delay_group']):120;
        $valid_time[2] = isset($config_other['other_order_delay_flash'])?intval($config_other['other_order_delay_flash']):120;
        $valid_time[3] = isset($config_other['other_order_delay_bund'])?intval($config_other['other_order_delay_bund']):0;

        $query = new Query('order');
        $query->where = "user_id = ".$this->user['id'];
        $query->order = "id desc";
        $query->page = 1;
        $orders = $query->find();
        $order_id = array();
        $now = time();
        foreach ($orders as $order) {
            if($order['pay_status']==0 && $order['status'] <= 3){
                $time = isset($valid_time[$order['type']])?$valid_time[$order['type']]:$valid_time[0];
                if($time>0){
                    $time *= 60;
                    if($now - strtotime($order['create_time']) >= $time){
                        $order_id[] = $order['id'];
                    }
                }

            }
        }
        //处理过期订单状态
        if(count($order_id)>0){
            $ids = implode(',', $order_id);
            $order_model = new Model('order');
            $data = array("status"=>6);
            $order_model->where("id in (".$ids.")")->data($data)->update();
        }
        $this->redirect();

    }
    public function order_detail()
    {
        $id = Filter::int(Req::args("id"));
        $order = $this->model->table("order as od")->fields("od.*,pa.pay_name")->join("left join payment as pa on od.payment = pa.id")->where("od.id = $id and od.user_id=".$this->user['id'])->find();
        if($order){
            $invoice = $this->model->table("doc_invoice as di")->fields("di.*,ec.code as ec_code,ec.name as ec_name,ec.alias as ec_alias")->join("left join express_company as ec on di.express_company_id = ec.id")->where("di.order_id=".$id)->find();
            $order_goods = $this->model->table("order_goods as og ")->join("left join goods as go on og.goods_id = go.id left join products as pr on og.product_id = pr.id")->where("og.order_id=".$id)->findAll();
            $area_ids = $order['province'].','.$order['city'].','.$order['county'];
            if($area_ids!='')$areas = $this->model->table("area")->where("id in ($area_ids)")->findAll();
            $parse_area = array();
            foreach ($areas as $area) {
                $parse_area[$area['id']] = $area['name'];
            }
            $this->assign("parse_area",$parse_area);
            $this->assign("order_goods",$order_goods);
            $this->assign("invoice",$invoice);
            $this->assign("order",$order);
            $this->redirect();
        }else{
            Tiny::Msg($this, 404);
        }
    }
    //订单签收
    public function order_sign()
    {
        $id = Filter::int(Req::args("id"));
        $info = array('status'=>'fail');
        $result = $this->model->table('order')->where("id=$id and user_id=".$this->user['id']." and status=3 and pay_status=1 and delivery_status=1")->data(array('delivery_status'=>2,'status'=>4,'completion_time'=>date('Y-m-d H:i:s')))->update();
        if($result){
            $info = array('status'=>'success');
            //提取购买商品信息
            $products = $this->model->table('order as od')->join('left join order_goods as og on od.id=og.order_id')->where('od.id='.$id)->findAll();
            foreach ($products as $product) {
                $data = array('goods_id'=>$product['goods_id'],'user_id'=>$this->user['id'],'order_no'=>$product['order_no'],'buy_time'=>$product['create_time']);
                $this->model->table('review')->data($data)->insert();
            }
        }
        echo JSON::encode($info);
    }
    public function address()
    {
        $model = new Model("address");
        $address = $model->where("user_id=".$this->user['id'])->order("id desc")->findAll();
        $area_ids = array();
        foreach ($address as $addr) {
            $area_ids[$addr['province']] = $addr['province'];
            $area_ids[$addr['city']] = $addr['city'];
            $area_ids[$addr['county']] = $addr['county'];
        }
        $area_ids = implode(',', $area_ids);
        $areas = array();
        if($area_ids!='')$areas = $model->table("area")->where("id in ($area_ids)")->findAll();
        $parse_area = array();
        foreach ($areas as $area) {
            $parse_area[$area['id']] = $area['name'];
        }
        $this->assign("address",$address);
        $this->assign("parse_area",$parse_area);
        $this->redirect();
    }
    public function address_del()
    {
        $id = Filter::int(Req::args("id"));
        $this->model->table("address")->where("id=$id and user_id=".$this->user['id'])->delete();
        $this->redirect("address");
    }
    public function index()
    {
        $id = $this->user['id'];

        $customer = $this->model->table("customer as cu")->fields("cu.*,gr.name as gname")->join("left join grade as gr on cu.group_id = gr.id")->where("cu.user_id = $id")->find();
        $orders = $this->model->table("order")->where("user_id = $id")->findAll();
        $order = array('amount'=>0,'pending'=>0);
        foreach ($orders as $obj) {
            if($obj['status']==4)$order['amount'] += $obj['order_amount'];
            else if($obj['status']<3)$order['pending']++;
        }
        $comment = $this->model->table("review")->fields("count(*) as num")->where("user_id = $id and status=0")->find();
        $this->assign("comment",$comment);
        $this->assign("order",$order);
        $this->assign("customer",$customer);
        $this->redirect();
    }

    protected function order_status($item)
    {
        $status = $item['status'];
        $pay_status = $item['pay_status'];
        $delivery_status = $item['delivery_status'];
        $str = '';
        switch ($status) {
            case '1':
            $str = '<span class="text-danger">等待付款</span> <a href="'.Url::urlFormat("/simple/order_status/order_id/$item[id]").'" class="btn btn-main btn-mini">付款</a>';
            break;
            case '2':
            if($pay_status ==1) $str = '<span class="text-warning">等待审核</span>';
            else {
                $payment_info = Common::getPaymentInfo($item['payment']);
                if($payment_info['class_name']=='received')
                    $str = '<span class="text-warning">等待审核 <a href="'.Url::urlFormat("/simple/order_status/order_id/$item[id]").'" class="btn btn-main btn-mini">另选支付</a></span>';
                else
                    $str = '<span class="text-danger">等待付款 <a href="'.Url::urlFormat("/simple/order_status/order_id/$item[id]").'" class="btn btn-main btn-mini">付款</a></span>';
            }
            break;
            case '3':
            if($delivery_status == 0) $str = '<span class="text-info">等待发货</span>';
            else if($delivery_status == 1) $str = '<span class="text-info">已发货</span> <a href="javascript:;" class="btn btn-main btn-mini" onclick="order_sign('.$item['id'].')">已收货</a>';
            if($pay_status==3)$str = '<span class="text-success">已退款</span>';
            break;
            case '4':
            $str = '<span class="text-success"><b>已完成</b></span>';
            if($pay_status==3)$str = '<span class="text-success">已退款</span>';
            break;
            case '5':
            $str = '<span class="text-gray"><s>已取消</s></span>';
            break;
            case '6':
            $str = '<span class="text-gray"><s>已作废</s></span>';
            break;
            default:
                # code...
            break;
        }
        return $str;
    }





    public function check_identity()
    {
        $verified = $this->verifiedType();
        $this->redirect();
    }

    public function verified()
    {
        $code = Req::args('code');
        $type = Req::args('type');
        $obj = Req::args('obj');
        $obj = $this->updateObj($obj);
        $verifiedInfo =  Session::get("verifiedInfo");
        if($code == $verifiedInfo['code']){
            $verifiedInfo['obj'] = $obj;
            Session::set("verifiedInfo",$verifiedInfo);
            $this->redirect("/ucenter/update_obj/r/".$verifiedInfo['random']);
        }else{
            $customer = $this->model->table('customer')->where("user_id=".$this->user['id'])->find();
            if($customer['pay_password'] == CHash::md5($code,$customer['pay_validcode'])){
                $random = CHash::random(20,'char');
                $verifiedInfo = array('code'=>$code,'time'=>time(),'type'=>'paypwd','obj'=>$obj,'random'=>$random);
                Session::set("verifiedInfo",$verifiedInfo);
                $this->redirect("/ucenter/update_obj/r/".$verifiedInfo['random']);
            }else{
                $info = array('field'=>'code','msg'=>'验证码错误！');
                if($type=='paypwd'){
                    $info = array('field'=>'code','msg'=>'支付密码错误！');
                }
                $this->assign("invalid",$info);
                $this->redirect("/ucenter/check_identity/obj/".$obj."/type/".$type,false);
            }
        }
    }

    public function update_obj()
    {
        $r = Req::args('r');
        $verifiedInfo =  Session::get("verifiedInfo");

        if($r == $verifiedInfo['random'] && $r != null){
            $this->assign("obj",$verifiedInfo['obj']);
            $this->redirect();
        }else{
            $this->redirect("/ucenter/check_identity");
        }
    }

    public function activate_obj()
    {
        $obj = Req::args('obj');
        $obj = $this->updateObj($obj);
        $model = new Model('user as us');
        $userInfo = $model->join('left join customer as cu on us.id = cu.user_id')->where('cu.user_id = '.$this->user['id'])->find();
        $random = CHash::random(20,'char');
        $verifiedInfo = array('obj'=>$obj,'random'=>$random);
        if($obj == 'email' &&  $userInfo['email_verified'] == 0){
            Session::set('verifiedInfo',$verifiedInfo);
            $this->redirect("/ucenter/update_obj/r/".$verifiedInfo['random']);
        }elseif($obj == 'mobile' && $userInfo['mobile_verified'] == 0){
            Session::set('verifiedInfo',$verifiedInfo);
            $this->redirect("/ucenter/update_obj/r/".$verifiedInfo['random']);
        }elseif($obj == 'paypwd' && $userInfo['pay_password_open'] == 0){
            Session::set('verifiedInfo',$verifiedInfo);
            $this->redirect("/ucenter/update_obj/r/".$verifiedInfo['random']);
        }else{
            $this->redirect('/ucenter/safety');
        }
    }

    public function update_obj_act()
    {
        $verifiedInfo =  Session::get("verifiedInfo");
        $obj = $verifiedInfo['obj'];
        $info = array();
        if($obj == 'password' || $obj == 'paypwd'){
            $password = Req::args('password');
            $repassword = Req::args('repassword');
            if($password == $repassword){
                if($obj == 'password'){
                    $validcode = CHash::random(8);
                    $this->model->table('user')->data(array('password'=>CHash::md5($password,$validcode),'validcode'=>$validcode))->where('id='.$this->user['id'])->update();
                    Session::clear('verifiedInfo');
                    $this->redirect('/ucenter/update_obj_success/obj/'.$obj);
                    exit;
                }elseif($obj == 'paypwd'){
                    $validcode = CHash::random(8);
                    $this->model->table('customer')->data(array('pay_password'=>CHash::md5($password,$validcode),'pay_validcode'=>$validcode,'pay_password_open'=>1))->where('user_id='.$this->user['id'])->update();
                    Session::clear('verifiedInfo');
                    $this->redirect('/ucenter/update_obj_success/obj/'.$obj);
                    exit;
                }

            }else{
                $info = array('field' =>'repassword' , 'msg'=>'两次密码不一致。');
            }
        }else if($obj == 'mobile' || $obj == 'email'){
            $code = Req::args('code');
            $account = Req::args('account');
            $activateObj = Session::get('activateObj');
            $newCode = $activateObj['code'];
            $newAccount = $activateObj['obj'];
            if($code == $newCode && $account == $newAccount){
                if($obj == 'email' && Validator::email($account)){
                    $result = $this->model->table('user')->where("email='".$account."' and id != ".$this->user['id'])->find();
                    if(!$result){
                        $this->model->table('user')->data(array('email'=>$account))->where('id='.$this->user['id'])->update();
                        $this->model->table('customer')->data(array('email_verified'=>1))->where('user_id='.$this->user['id'])->update();
                        Session::clear('verifiedInfo');
                        Session::clear('activateObj');
                        $this->redirect('/ucenter/update_obj_success/obj/'.$obj);
                        exit;
                    }else{
                        $info = array('field' =>'account' , 'msg'=>'此邮箱已被其它用户占用，无法修改为此邮箱。');
                    }

                }elseif($obj == 'mobile' && Validator::mobi($account) ){
                    $result = $this->model->table('customer')->where("mobile ='".$account."'".'  and user_id!='.$this->user['id'])->find();
                    if(!$result){
                        $this->model->table('customer')->data(array('mobile'=>$account,'mobile_verified'=>1))->where('user_id='.$this->user['id'])->update();
                        Session::clear('verifiedInfo');
                        Session::clear('activateObj');
                        $this->redirect('/ucenter/update_obj_success/obj/'.$obj);
                        exit;
                    }else{
                        $info = array('field' =>'account' , 'msg'=>'此手机号已被其它用户占用，无法修改为此手机号。');
                    }

                }

            }else{
                $info = array('field' =>'account' , 'msg'=>'账号或验证码不正确。');
            }
        }
        $this->redirect("/ucenter/update_obj/r/".$verifiedInfo['random'],true,array('invalid'=>$info,'account'=>$account));
    }

    public function update_obj_success()
    {
        $obj = Req::args('obj');
        if($obj != null){
            $this->redirect();
        }else{
            $this->redirect('/ucenter/safety');
        }
    }

    public function send_objcode()
    {
        $account = Req::args('account');
        $activateObj = Session::get('activateObj');
        $sendAble = true;
        $haveTime = 120;
        if(isset($activateObj['time']) ){
            $time = $activateObj['time'];
            $haveTime = time() - $time;
            if($haveTime <= 120){
                $sendAble = false;
            }
        }

        if($sendAble){
            $code = CHash::random(6,'int');
            if(Validator::email($account)){
                $mail = new Mail();
                $flag = $mail->send_email($account,'您的邮箱身份核实验证码',"核实邮箱验证码：".$code);
                if(!$flag){
                    $info = array('status'=>'fail','msg'=>'邮件发送失败请联系管理人员');
                }else{
                    $activateObj = array('time'=>time(),'code'=>$code,'obj'=>$account);
                    Session::set('activateObj',$activateObj);
                    $info = array('status'=>'success');
                }
            }else if(Validator::mobi($account)){
                $sms = SMS::getInstance();
                if($sms->getStatus()){
                    $result = $sms->sendCode($account,$code);
                    if($result['status']=='success'){
                        $info = array('status'=>'success','msg'=>$result['message']);
                        $activateObj = array('time'=>time(),'code'=>$code,'obj'=>$account);
                        Session::set('activateObj',$activateObj);
                        $info = array('status'=>'success');
                    }else{
                        $info = array('status'=>'fail','msg'=>$result['message']);
                    }
                }else{
                    $info = array('status'=>'fail','msg'=>'系统没有开启手机验证功能!');
                }
            }else{
                $info = array('status'=>'fail','msg'=>'除邮箱及手机号外，不支持发送!');
            }
        }else{
            $info = array('status'=>'fail','msg'=>'还有'.(120 - $haveTime).'秒后可发送！');
        }
        $info['haveTime'] = (120 - $haveTime);
        echo JSON::encode($info);
    }

    public function send_code(){
        $info = array('status'=>'fail','msg'=>'');
        $type = Req::args('type');
        $code = CHash::random(6,'int');
        $obj = Req::args('obj');
        $verifiedInfo = Session::get('verifiedInfo');
        $sendAble = true;
        $haveTime = 120;

        if(isset($verifiedInfo['time']) && $type == $verifiedInfo['type']){
            $time = $verifiedInfo['time'];
            $haveTime = time() - $time;
            if($haveTime <= 120){
                $sendAble = false;
            }
        }

        if($sendAble){

            $obj = $this->updateObj($obj);
            $random = CHash::random(20,'char');
            $verifiedInfo = array('code'=>$code,'time'=>time(),'type'=>$type,'obj'=>$obj,'random'=>$random);
            if($type == 'email'){
                $mail = new Mail();
                $flag = $mail->send_email($this->user['email'],'您的验证身份验证码',"身份验证码：".$code);
                if(!$flag){
                    $info = array('status'=>'fail','msg'=>'邮件发送失败请联系管理人员');
                }else{
                    Session::set('verifiedInfo',$verifiedInfo);
                    $info = array('status'=>'success');
                }
            }else if($type == 'mobile'){
                $sms = SMS::getInstance();
                if($sms->getStatus()){
                    $result = $sms->sendCode($this->user['mobile'],$code);
                    if($result['status']=='success'){
                        $info = array('status'=>'success','msg'=>$result['message']);
                        Session::set('verifiedInfo',$verifiedInfo);
                        $info = array('status'=>'success');
                    }else{
                        $info = array('status'=>'fail','msg'=>$result['message']);
                    }
                }else{
                    $info = array('status'=>'fail','msg'=>'系统没有开启手机验证功能!');
                }
            }
        }else{
            $info = array('status'=>'fail','msg'=>'还有'.(120 - $haveTime).'秒后可发送！');
        }
        $info['haveTime'] = (120 - $haveTime);

        echo JSON::encode($info);
    }

    public function virtual_goods_show()
    {
        $this->layout = '';
        $goods_type = Filter::int(Req::args('goods_type'));
        $order_id = Filter::int(Req::args('order_id'));
        $virtual_extend = Filter::sql(Req::args('virtual_extend'));
        $virtual_goods = array();
        $orderModel = new Model('order');
        $orderObj = $orderModel->where('id='.$order_id.' and user_id='.$this->user['id'])->find();
        if ($orderObj && $orderObj['pay_status'] == 1 ){
            if($goods_type==1 || $goods_type ==2){
                $model = new Model('virtual_goods');
                $virtual_goods = $model->where('order_id='.$order_id.' and status=0 and template_id='.$virtual_extend.'  and user_id='.$this->user['id'])->findAll();
                $this->assign('virtual_list',$virtual_goods);

            }else if($goods_type == 3){

                $this->assign('code',$virtual_extend);
            }
            $this->assign("payStatus",true);
        }else{
            $this->assign("payStatus",false);
        }

        $this->assign('goods_type',$goods_type);
        $this->redirect();

    }

    public function download()
    {
        $code = Req::args("code");
        $num=crc32($code);
        $num = sprintf('%u',$num);
        $url=Tiny::getPath('uploads').'virtual/'.($num%1024)."/".(($num>>=10)%1024)."/".($num>>=10)."/".Crypt::md5($code);
        if(file_exists($url.'.rar')){
            Http::download($url.'.rar',Crypt::md5($code).'.rar');
        }else if(file_exists($url.'.zip')){
            Http::download($url.'.zip',Crypt::md5($code).'.zip');
        }else{
            echo "<div style='marign:40px 10px;'>文件已不存在，请联系管理人员!</div>";
        }
    }

    public function safety()
    {
        $verified = $this->verifiedType();
        $this->redirect();
    }

    private function verifiedType()
    {
        $verified_type = array(
            'mobile'=>"已验证手机",
            'email'=>"已验证邮箱",
            'paypwd'=>"支付密码"
            );

        $model = new Model('user as us');
        $userInfo = $model->join('left join customer as cu on us.id = cu.user_id')->where('cu.user_id = '.$this->user['id'])->find();
        if($userInfo){
            if($userInfo['email_verified']!=1)unset($verified_type['email']);
            if($userInfo['mobile_verified']!=1) unset($verified_type['mobile']);
            if($userInfo['pay_password_open']!=1) unset($verified_type['paypwd']);
            $userInfo['email'] = preg_replace("/^(\w{1}).*(\w{1}@.+)$/i", "$1*****$2", $userInfo['email']);
            $userInfo['mobile'] = preg_replace("/^(\d{3})\d+(\d{3})$/i", "$1*****$2", $userInfo['mobile']);

        }
        $type = Req::args('type');
        $obj = Req::args('obj');
        $obj = $this->updateObj($obj);

        $type = $type==null?'mobile':$type;
        if(isset($verified_type[$type])){
            unset($verified_type[$type]);
        }else{
            if(count($verified_type)>0){
                $keys = array_keys($verified_type);
                $type = current($keys);
                unset($verified_type[$type]);
            }else{
                $type = null;
            }

        }
        $this->assign("userInfo",$userInfo);
        $this->assign("obj",$obj);
        $this->assign("verified",$verified_type);
        $this->assign("type",$type);
    }

    private function updateObj($obj)
    {
        $objs = array('email'=>true,'mobile'=>true,'password'=>true,'paypwd'=>true);
        if(!isset($objs[$obj])){
            $obj = 'password';
        }
        return $obj;
    }


    public function union()
    {
        $oauth_login = array();
        $model = new Model('oauth');
        $oauths = $model->where('status = 1 order by `sort` desc')->findAll();
        $model_oauth_user = new Model('oauth_user');
        $oauth_users = $model_oauth_user->where('user_id='.$this->user['id'])->findAll();
        foreach ($oauths as $oauth) {
           $tem = new $oauth['class_name']();
           $oauth_login[$oauth['class_name']]['name'] = $oauth['name'];
           $oauth_login[$oauth['class_name']]['url'] = $tem->getRequestCodeURL();
           $oauth_login[$oauth['class_name']]['icon'] = $oauth['icon'];
       }
       foreach ($oauth_users as $oauth_user) {
        if(isset($oauth_login[$oauth_user['oauth_type']])){
            $oauth_login[$oauth_user['oauth_type']]['binding'] = true;
            $oauth_login[$oauth_user['oauth_type']]['oauth_type'] = $oauth_user['oauth_type'];
            $oauth_login[$oauth_user['oauth_type']]['open_name'] = $oauth_user['open_name'];
        }
    }
    $this->assign('oauth_login',$oauth_login);
    $this->redirect();
}

public function union_remove()
{
    $oauth_type = Filter::sql(Req::args('oauth_type'));
    $model = new Model('oauth_user');
    $model->where('user_id='.$this->user['id'].' and oauth_type='."'".$oauth_type."'")->delete();
    $this->redirect("union");
}

    //检测用户是否在线
private function checkOnline()
{
    if(isset($this->user)&& $this->user['name']!=null)
        return true;
    else return false;
}
}
