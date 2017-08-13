<?php
/**
 * 支付模块
 *
 * @author Crazy、Ly
 * @package AdminController
 */
class PaymentController extends Controller
{
    public $layout='';
    public $model = null;
    private $user;
    public $needRightActions = array('dopay'=>true,'callback'=>true);

    public function init(){
        header("Content-type: text/html; charset=".$this->encoding);
        $this->model = new Model();
        $safebox =  Safebox::getInstance();
        $this->user = $safebox->get('user');
    }
    public function checkRight($actionId){
        $rights = $this->needRightActions;
        if(isset($rights[$actionId]) && $rights[$actionId]){
            if(isset($this->user['name']) && $this->user['name']!=null)
            return true;
            else return false;
        }else{
            return true;
        }

    }
    public function noRight(){
        $this->redirect("/simple/login");
    }
    //余额支付方式，服务器端处理
    public function pay_balance(){

        $model = new Model('user as us');
        $userInfo = $model->join('left join customer as cu on us.id = cu.user_id')->where('cu.user_id = '.$this->user['id'])->find();
        if($userInfo['pay_password_open'] == 1){
            $pay_password = Req::args('pay_password');
            $order_id = Req::post('order_id');
            $payment_id = Req::post('payment_id');
            if($userInfo['pay_password'] != CHash::md5($pay_password,$userInfo['pay_validcode'])){
                $msg = '支付密码错误';
                $this->redirect('/payment/dopay/order_id/'.$order_id.'/payment_id/'.$payment_id,true,array('msg'=>$msg));
                exit;
            }

        }
        $sign = Req::post('sign');
        $args = Req::post();
        unset($args['sign']);
        unset($args['pay_password']);
        unset($args['order_id']);
        unset($args['payment_id']);

        $total_fee = Filter::float(Req::post('total_fee'));
        $attach = Filter::int(Req::post('attach'));

        $return['attach']     = $attach;
        $return['total_fee']  = $total_fee;
        $return['order_no']   = Filter::sql(Req::post('order_no'));
        $return['return_url'] = Req::post('return_url');

        if(stripos($return['order_no'],'recharge_') !== false)
        {
            $msg = array('type'=>'fail','msg'=>'余额支付方式,不能用于在线充值功能！');
            $this->redirect('/index/msg',false,$msg);
            exit;
        }
        if(floatval($return['total_fee']) < 0 || $return['order_no'] == '' || $return['return_url'] == '')
        {
            $msg = array('type'=>'fail','msg'=>'支付参数不正确！');
            $this->redirect('/index/msg',false,$msg);
        }
        else{

            $payment = new Payment($attach);
            $pay_balance = $payment->getPaymentPlugin();
            $classConfig = $pay_balance->getClassConfig();

            $filter_param = $pay_balance->filterParam($args);
            //对待签名参数数组排序
            $para_sort = $pay_balance->argSort($filter_param);
            $mysign = $pay_balance->buildSign($para_sort,$classConfig['partner_key']);

            if($mysign == $sign)
            {
                $user_id = $this->user['id'];
                $model = new Model("customer");
                $customer = $model->where("user_id=".$user_id)->find();
                if($customer['balance']>=$total_fee){
                    $order = $model->table("order")->where("order_no='".$return['order_no']."' and user_id=".$user_id)->find();
                    if($order){
                        if($order['pay_status']==0){
                            $flag = $model->table("customer")->where("user_id=".$user_id)->data(array('balance'=>"`balance`-".$total_fee))->update();
                            $return['order_status'] = 'TINY_SECCESS';

                            //记录支付日志
                            Log::balance((0-$total_fee),$user_id,'通过余额支付方式进行商品购买,订单编号：'.$return['order_no']);

                            $filter_param = $pay_balance->filterParam($return);
                            $para_sort = $pay_balance->argSort($filter_param);
                            $sign = $pay_balance->buildSign($para_sort,$classConfig['partner_key']);
                            $prestr = $pay_balance->createLinkstring($para_sort);

                            $nextUrl = urldecode($return['return_url']);
                            if(stripos($nextUrl,'?') === false)
                            {
                               // $return_url = $nextUrl.'?'.$prestr;
                            }
                            else
                            {
                                //$return_url = $nextUrl.'&'.$prestr;
                            }
                            $return_url=$nextUrl;//.= '&sign='.$sign;
                            $return['sign'] = $sign;
                            //var_dump($return_url,$return,$prestr);exit();
                            $this->redirect("$return_url",true,$return);
                            //header('location:'.$return_url,true,$result);
                            exit;
                        }else{
                            $msg = array('type'=>'fail','msg'=>'订单已经处理过，请查看订单信息！');
                            $this->redirect('/index/msg',false,$msg);
                            exit;
                        }

                    }else{
                        $msg = array('type'=>'fail','msg'=>'订单不存在！');
                        $this->redirect('/index/msg',false,$msg);
                        exit;
                    }

                }else{
                    $msg = array('type'=>'fail','msg'=>'余额不足,请选择其它支付方式！');
                    $this->redirect('/index/msg',false,$msg);
                    exit;
                }
            }
            else
            {
                $msg = array('type'=>'fail','msg'=>'签名错误！');
                $this->redirect('/index/msg',false,$msg);
                exit;
            }
        }
    }
    //货到付款方式，服务器端处理
    public function pay_received(){

        $sign = Req::post('sign');
        $args = Req::post();
        unset($args['sign']);

        $total_fee = Filter::float(Req::post('total_fee'));
        $attach = Filter::int(Req::post('attach'));

        $return['attach']     = $attach;
        $return['total_fee']  = $total_fee;
        $return['order_no']   = Filter::sql(Req::post('order_no'));
        $return['return_url'] = Req::post('return_url');

        if(stripos($return['order_no'],'recharge_') !== false)
        {
            $msg = array('type'=>'fail','msg'=>'货到贷款方式,不能用于在线充值功能！');
            $this->redirect('/index/msg',false,$msg);
            exit;
        }
        if(floatval($return['total_fee']) <= 0 || $return['order_no'] == '' || $return['return_url'] == '')
        {
            $msg = array('type'=>'fail','msg'=>'支付参数不正确！');
            $this->redirect('/index/msg',false,$msg);
        }
        else{

            $payment = new Payment($attach);
            $pay_received = $payment->getPaymentPlugin();
            $classConfig = $pay_received->getClassConfig();

            $filter_param = $pay_received->filterParam($args);
            //对待签名参数数组排序
            $para_sort = $pay_received->argSort($filter_param);
            $mysign = $pay_received->buildSign($para_sort,$classConfig['partner_key']);

            if($mysign == $sign)
            {
                $user_id = $this->user['id'];
                $model = new Model("customer");
                $customer = $model->where("user_id=".$user_id)->find();
                if($customer){
                    $order = $model->table("order")->where("order_no='".$return['order_no']."' and user_id=".$user_id)->find();
                    if($order){
                        if($order['pay_status']==0){
                            //$flag = $model->table("customer")->where("user_id=".$user_id)->data(array('balance'=>"`balance`-".$total_fee))->update();
                            $return['order_status'] = 'TINY_SECCESS';

                            //记录支付日志
                            //Log::balance((0-$total_fee),$user_id,'通过货到付款的方式进行商品购买,订单编号：'.$return['order_no']);

                            $filter_param = $pay_received->filterParam($return);
                            $para_sort = $pay_received->argSort($filter_param);
                            $sign = $pay_received->buildSign($para_sort,$classConfig['partner_key']);
                            $prestr = $pay_received->createLinkstring($para_sort);

                            $nextUrl = urldecode($return['return_url']);
                            $return_url=$nextUrl;
                            $return['sign'] = $sign;
                            $this->redirect("$return_url",true,$return);
                            exit;
                        }else{
                            $msg = array('type'=>'fail','msg'=>'订单已经处理过，请查看订单信息！');
                            $this->redirect('/index/msg',false,$msg);
                            exit;
                        }

                    }else{
                        $msg = array('type'=>'fail','msg'=>'订单不存在！');
                        $this->redirect('/index/msg',false,$msg);
                        exit;
                    }

                }else{
                    $msg = array('type'=>'fail','msg'=>'用户不存在！');
                    $this->redirect('/index/msg',false,$msg);
                    exit;
                }
            }
            else
            {
                $msg = array('type'=>'fail','msg'=>'签名错误！');
                $this->redirect('/index/msg',false,$msg);
                exit;
            }
        }
    }

    public function doPay(){
        // 获得payment_id 获得相关参数
        $payment_id = Filter::int(Req::args('payment_id'));
        $order_id = Filter::int(Req::args('order_id'));
        $recharge = Req::args('recharge');
        $extendDatas = Req::args();
        if($payment_id){
            $payment = new Payment($payment_id);
            $paymentPlugin = $payment->getPaymentPlugin();
            $payment_info = $payment->getPayment();
            //充值处理
            if($recharge != null){
                $recharge   = Filter::float($recharge);
                $paymentInfo = $payment->getPayment();
                $data   = array('account' => $recharge , 'paymentName' => $paymentInfo['name']);
                $packData = $payment->getPaymentInfo('recharge',$data);
                $packData = array_merge($extendDatas,$packData);
                $sendData = $paymentPlugin->packData($packData);
                if(!$paymentPlugin->isNeedSubmit()){
                    echo($sendData);
                    exit();
                }
            }else if($order_id != null){
                $model = new Model('order');
                $order = $model->where('id='.$order_id)->find();
                if($order){
                    if($order['order_amount']==0 && $payment_info['class_name']!='balance'){
                        $this->redirect("/index/msg",false,array('type'=>'fail','msg'=>'0元订单，仅限预付款支付，请选择预付款支付方式。'));
                        exit();
                    }
                    //获取订单可能延时时长，0不限制
                    $config = Config::getInstance();
                    $config_other = $config->get('other');
                    switch ($order['type']) {
                        case '1':
                            $order_delay = isset($config_other['other_order_delay_group'])?intval($config_other['other_order_delay_group']):120;
                            break;
                        case '2':
                            $order_delay = isset($config_other['other_order_delay_flash'])?intval($config_other['other_order_delay_flash']):120;
                            break;
                        case '3':
                            $order_delay = isset($config_other['other_order_delay_bund'])?intval($config_other['other_order_delay_bund']):0;
                            break;

                        default:
                            $order_delay = isset($config_other['other_order_delay'])?intval($config_other['other_order_delay']):0;
                            break;
                    }

                    $time = strtotime("-".$order_delay." Minute");
                    $create_time = strtotime($order['create_time']);
                    if($create_time>=$time || $order_delay==0){
                        //取得所有订单商品
                        $order_goods = $model->table('order_goods')->fields("product_id,goods_nums")->where('order_id='.$order_id)->findAll();
                        $product_ids = array();
                        $order_products = array();
                        foreach ($order_goods  as $value) {
                            $product_ids[] = $value['product_id'];
                            $order_products[$value['product_id']] = $value['goods_nums'];
                        }
                        $product_ids = implode(',', $product_ids);

                        $products = $model->table('products')->fields("id,store_nums")->where("id in ($product_ids)")->findAll();
                        $products_list = array();
                        foreach ($products as $value) {
                            $products_list[$value['id']]=$value['store_nums'];
                        }
                        $flag = true;
                        foreach ($order_goods as $value) {
                            if($order_products[$value['product_id']]>$products_list[$value['product_id']]){
                                $flag = false;
                                break;
                            }
                        }
                        //检测库存是否还能满足订单
                        if($flag){
                            //团购订单
                            if($order['type']==1 || $order['type']==2){
                                if($order['type']==1){
                                    $prom_name='团购';
                                    $prom_table = "groupbuy";
                                }else{
                                    $prom_name='抢购';
                                    $prom_table = "flash_sale";
                                }
                                $prom = $model->table($prom_table)->where("id=".$order['prom_id'])->find();
                                if($prom){
                                    if(time() > strtotime($prom['end_time']) || $prom['max_num']<=$prom["goods_num"]){
                                        $model->table("order")->data(array('status'=>6))->where('id='.$order_id)->update();
                                        $this->redirect("/index/msg",false,array('type'=>'fail','msg'=>'支付晚了，'.$prom_name."活动已结束。"));
                            exit;
                                    }
                                }
                            }
                            $packData = $payment->getPaymentInfo('order',$order_id);
                            $packData = array_merge($extendDatas,$packData);
                            $sendData = $paymentPlugin->packData($packData);
                            if(!$paymentPlugin->isNeedSubmit()){
                                echo($sendData);
                                exit();
                            }
                        }else{
                            if($order['status'] < 4 && $order['pay_status'] == 0){
                                $model->table("order")->data(array('status'=>6))->where('id='.$order_id)->update();
                                $this->redirect("/index/msg",false,array('type'=>'fail','msg'=>'支付晚了，库存已不足。'));

                            }else{
                                $this->redirect("/index/msg",false,array('type'=>'fail','msg'=>'已付款订单，无法再次进行支付。'));
                            }
                            exit;

                        }

                    }else{
                        $model->data(array('status'=>6))->where('id='.$order_id)->update();
                        $this->redirect("/index/msg",false,array('type'=>'fail','msg'=>'订单超出了规定时间内付款，已作废.'));
                        exit;
                    }
                }

            }
            if(!empty($sendData)){
                $this->assign("paymentPlugin",$paymentPlugin);
                $this->assign("sendData",$sendData);
                if($paymentPlugin instanceof pay_balance){
                    $model = new Model('user as us');
                    $userInfo = $model->join('left join customer as cu on us.id = cu.user_id')->where('cu.user_id = '.$this->user['id'])->find();
                    if($userInfo['pay_password_open'] == 1){
                        $this->assign('userInfo',$userInfo);
                        $this->assign('order_id',$order_id);
                        $this->assign('payment_id',$payment_id);
                    }
                }
                $this->redirect('pay_form',false);
            }else{
                $this->redirect("/index/msg",false,array('type'=>'fail','msg'=>'需要支付的订单已经不存在。'));
            }

        }else{
            echo "fail";
        }
    }

    public function notify()
    {
        $payment = new Payment('weixin');
        $payment_weixin = $payment->getPaymentPlugin();
        WxPayConfig::setConfig($payment_weixin->getClassConfig());
        $paymentId = $payment_weixin->getPaymentId();
        $notify = new PayNotifyCallBack();
        $notify->paymentId = $paymentId;
        $notify->Handle(false);
    }

    public function callback(){
        //从URL中获取支付方式
        $payment_id      = Filter::int(Req::get('payment_id'));
        $payment = new Payment($payment_id);
        $paymentPlugin = $payment->getPaymentPlugin();

        if(!is_object($paymentPlugin))
        {
            $msg = array('type'=>'fail','msg'=>'支付方式不存在！');
            $this->redirect('/index/msg',false,$msg);
            exit;
        }

        //初始化参数
        $money   = '';
        $message = '支付失败';
        $orderNo = '';

        //执行接口回调函数
        $callbackData = Req::args();//array_merge($_POST,$_GET);
        unset($callbackData['con']);
        unset($callbackData['act']);
        unset($callbackData['payment_id']);
        unset($callbackData['tiny_token_redirect']);
        $return = $paymentPlugin->callback($callbackData,$payment_id,$money,$message,$orderNo);
        //支付成功
        if($return == 1)
        {
            //充值方式
            if(stripos($orderNo,'recharge_') !== false)
            {
                $tradenoArray = explode('_',$orderNo);
                $recharge_no  = isset($tradenoArray[1]) ? $tradenoArray[1] : 0;
                $recharge_id = Order::recharge($recharge_no,$payment_id,$callbackData);
                if($recharge_id){
                    //$this->redirect("/ucenter/account/$recharge_id");
                    $model = new Model('recharge');
                    $obj = $model->where("id=".$recharge_id.' and status=1')->find();
                    if($obj){
                        $msg = array('type'=>'success','msg'=>'充值成功！','content'=>'充值编号：'.$recharge_no.',充值方式：'.$obj['payment_name'],'redirect'=>'/ucenter/account');
                        $this->redirect('/index/msg',true,$msg);
                    }
                    exit;
                }
                $msg = array('type'=>'fail','msg'=>'支充值失败！');
                $this->redirect('/index/msg',false,$msg);
                exit;
            }
            else{
                $payment_plugin = $payment->getPayment();
                //货到付款的处理
                if($payment_plugin['class_name'] =='received' ){
                    $model = new Model("order");
                    $order = $model->where("order_no='".$orderNo."'")->find();
                    if(!empty($order)){
                        $model->where("order_no='".$orderNo."'")->data(array('payment'=>$payment_id))->update();
                        $this->redirect("/simple/order_completed/order_id/".$order['id']);
                        exit;
                    }
                }
                else{
                    $order_id = Order::updateStatus($orderNo,$payment_id,$callbackData);
                    if($order_id)
                    {
                        $this->redirect("/simple/order_completed/order_id/".$order_id);
                        exit;
                    }
                    $msg = array('type'=>'fail','msg'=>'订单修改失败！');
                    $this->redirect('/index/msg',false,$msg);
                    exit;
                }
            }
        }
        //支付失败
        else
        {
            $message = $message ? $message : '支付失败';
            $msg = array('type'=>'fail','msg'=>$message);
            $this->redirect('/index/msg',false,$msg);
            exit;
        }
    }

    // 支付回调[异步]
    function async_callback()
    {
        //从URL中获取支付方式
        $payment_id      = Filter::int(Req::args('payment_id'));
        $payment = new Payment($payment_id);
        $paymentPlugin = $payment->getPaymentPlugin();

        if(!is_object($paymentPlugin)){
            echo "fail";
        }

        //初始化参数
        $money   = '';
        $message = '支付失败';
        $orderNo = '';

        //执行接口回调函数
        $callbackData = Req::args();//array_merge($_POST,$_GET);
        unset($callbackData['con']);
        unset($callbackData['act']);
        unset($callbackData['payment_id']);
        $return = $paymentPlugin->asyncCallback($callbackData,$payment_id,$money,$message,$orderNo);

        //支付成功
        if($return == 1)
        {
            //充值方式
            if(stripos($orderNo,'recharge_') !== false)
            {
                $tradenoArray = explode('_',$orderNo);
                $recharge_no  = isset($tradenoArray[1]) ? $tradenoArray[1] : 0;
                if(Order::recharge($recharge_no,$payment_id,$callbackData))
                {
                    $paymentPlugin->asyncStop();
                    exit;
                }
            }
            else
            {
                $order_id = Order::updateStatus($orderNo,$payment_id,$callbackData);
                if($order_id)
                {
                    $paymentPlugin->asyncStop();
                    exit;
                }
            }
        }
    }
}
