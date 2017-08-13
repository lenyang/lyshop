<?php
/**
 * 公共模块
 *
 * @author Crazy、Ly
 * @package SimpleController
 */
class SimpleController extends Controller{

    public $layout='simple';
    public $safebox = null;
    //private $user;
    private $model = null;
    private $cookie_time = 31622400;
    private $cart = array();

    public function init(){
        header("Content-type: text/html; charset=".$this->encoding);
        $this->model = new Model();
        $this->safebox =  Safebox::getInstance();
        $this->user = $this->safebox->get('user');
        if($this->user==null){
            $this->user = Common::autoLoginUserInfo();
            $this->safebox->set('user',$this->user);
        }
        $config = Config::getInstance();
        $site_config = $config->get("globals");
        $this->assign('seo_title',$site_config['site_name']);
        $this->assign('site_title',$site_config['site_name']);

        $cart = Cart::getCart();
        $this->cart = $cart->all();
        $this->assign("cart",$this->cart);
    }

    public function reg_act(){
        if($this->getModule()->checkToken('reg')){
            $email = Filter::sql(Req::post('email'));
            $mobile = Filter::int(Req::args('mobile'));
            $passWord = Req::post('password');
            $rePassWord = Req::post('repassword');
            $this->safebox = Safebox::getInstance();
            $code = $this->safebox->get($this->captchaKey);
            $verifyCode = Req::args("verifyCode");

            $config = Config::getInstance();
            $other = $config->get('other');
            $reg_way = isset($other['other_reg_way'])?$other['other_reg_way']:0;
            $reg_way = explode(',',$reg_way);
            $reg_way = array_flip($reg_way);

            $smsCheck = false;
            if(isset($reg_way[1]) && class_exists('SMS')){
                $sms = SMS::getInstance();
                if($sms->getStatus()) $smsCheck = true;
            }
            $mobile = '';
            $checkFlag = false;
            $mobile = Filter::int(Req::args('mobile'));
            if($smsCheck){
                $mobile_code = Req::args('mobile_code');
                $mobile_model = new Model('mobile_code');
                $time = time() - 120;
                $obj = $mobile_model->where("send_time > $time and mobile ='".$mobile."'")->find();
                if($obj){
                    $checkFlag = ( $mobile_code == $obj['code']);
                    if(!$checkFlag){
                        $info = array('field'=>'mobile_code','msg'=>'短信验证码错误!');
                    }
                }

            }else{
                $checkFlag = ($verifyCode==$code);
                if(!$checkFlag)$info = array('field'=>'verifyCode','msg'=>'验证码错误!');
            }
            if($checkFlag){
                if(isset($reg_way[0])){
                    if(!Validator::email($email)){
                        $info = array('field'=>'email','msg'=>'邮箱格式不正确！');
                    }
                }
                if(isset($reg_way[1])){
                    if(!Validator::mobi($mobile)){
                        $info = array('field'=>'mobile','msg'=>' 手机号码格式不正确！');
                    }
                }
                if(strlen($passWord)<6){
                    $info = array('field'=>'password','msg'=>'密码长度必需大于6位！');
                }
                if(!isset($info)){
                    $model = $this->model->table("user");
                    if($passWord == $rePassWord){
                        if(isset($reg_way[0]) && isset($reg_way[1])){
                            $userObj = $model->where("email='$email'")->find();

                            $customerModel = new Model("customer");
                            $customerObj = $customerModel->where("mobile='$mobile'")->find();
                            if($userObj ==null && $customerObj == null){
                                $name = $mobile;
                                $obj = null;
                            }else{
                                if($userObj) $info = array('field'=>'email','msg'=>'邮箱格式不正确！');
                                if($customerObj) $info = array('field'=>'mobile','msg'=>'此手机号已被注册！');
                            }
                        }elseif(isset($reg_way[0])){
                            $obj = $model->where("email='$email'")->find();
                            if($obj==null) $name = $email;
                        }elseif(isset($reg_way[1])){
                            $customerModel = new Model("customer");
                            $customerObj = $customerModel->where("mobile='$mobile'")->find();
                            $obj = $customerObj;
                            if($customerObj == null){
                                $name = $mobile;
                                $email = $mobile.'@no.com';
                            }else{
                                $info = array('field'=>'mobile','msg'=>'此手机号已被注册！');
                            }
                        }
                        if($obj==null) {
                            $user_status = 1;
                            if(isset($other['other_verification_eamil']) && $other['other_verification_eamil'] ==1 ){
                                $user_status = 0;
                            }

                            $validcode = CHash::random(8);
                            $last_id = $model->data(array('email'=>$email,'name'=>$name,'password'=>CHash::md5($passWord,$validcode),'validcode'=>$validcode,'status'=>$user_status))->insert();

                            $time = date('Y-m-d H:i:s');
                            $model->table("customer")->data(array('user_id'=>$last_id ,'reg_time'=>$time,'login_time'=>$time,'mobile'=>$mobile))->insert();

                            if($user_status==1){
                                //记录登录信息
                                $obj = $model->table("user as us")->join("left join customer as cu on us.id = cu.user_id")->fields("us.*,cu.group_id,cu.login_time")->where("us.email='$email'")->find();
                                $this->safebox->set('user',$obj,1800);
                            }else{
                                $email_code = Crypt::encode($email);
                                $valid_code = md5($validcode);
                                $str_code = urlencode($valid_code.$email_code);
                                $activation_url = Url::fullUrlFormat("/simple/activation_user/code/$str_code");
                                $msg_content = '';
                                $site_url = Url::fullUrlFormat('/');
                                $msg_title = '账户激活--'.$this->site_name;

                                $msg_template_model = new Model("msg_template");
                                $msg_template = $msg_template_model->where('id=4')->find();
                                if($msg_template){
                                    $msg_content = str_replace(array('{$site_name}','{$activation_url}','{$site_url}','{$current_time}'), array($this->site_name,$activation_url,$site_url,date('Y-m-d H:i:s')), $msg_template['content']);
                                    $msg_title = $msg_template['title'];
                                    $mail = new Mail();
                                    $flag = $mail->send_email($email,$msg_title,$msg_content);
                                    if(!$flag){
                                        $this->redirect("/index/msg",true,array('type'=>"fail","msg"=>'邮件发送失败',"content"=>"后台还没有成功配制邮件信息!"));
                                    }
                                }
                            }

                            $mail_host = 'http://mail.'.preg_replace('/.+@/i', '', $email);
                            $args = array("user_status"=>$user_status,"mail_host"=>$mail_host,'user_name'=>$email);
                            $this->redirect("reg_result",true,$args);
                        }
                    }else{
                        $info = array('field'=>'repassword','msg'=>'两次密码输入不一致！');
                    }
                }
            }
        }else{
            $this->redirect("/index/msg",false,array('type'=>"fail","msg"=>'注册无效',"content"=>"非法进入注册页面！","redirect"=>"/simple/reg"));
            exit();
        }
        $this->assign("invalid",$info);
        $this->redirect("reg",false,Req::args());
    }
    //账户激活邮件认证
    public function activation_user()
    {
        $code =Filter::text(Req::args('code'));
        $email_code = urldecode(substr($code,32));
        $valid_code = substr($code,0,32);
        $email = Crypt::decode($email_code);
        if(Validator::email($email)){
            $model = new Model('user');
            $user = $model->where("email='".$email."'")->find();

            if($user && $user['status']==0 && md5($user['validcode'])==$valid_code){
                $model->data(array('status'=>1))->where('id='.$user['id'])->update();
                $model->table('customer')->data(array('email_verified'=>1))->where('user_id='.$user['id'])->update();
                $this->redirect("/index/msg",false,array('type'=>"success","msg"=>'账户激活成功',"content"=>"账户通过邮件成功激活。","redirect"=>"/simple/login"));
                exit();
            }
        }
        $this->redirect("/index/msg",false,array('type'=>"fail","msg"=>'账户激活失败',"content"=>"你的连接地址无效，无法进行账户激活，请核实你的连接地址无误。"));

    }
    public function login()
    {
        if($this->checkOnline()){
            $this->redirect('/ucenter/index');
        }else {
            $model = new Model('oauth');
            $oauths = $model->where('status = 1 order by `sort` desc')->findAll();
            $oauth_login = array();
            foreach ($oauths as $oauth) {
                //$tem = new $oauth['class_name']();
                //$oauth_login[$oauth['name']]['url'] = $tem->getRequestCodeURL();
                $oauth_login[$oauth['name']]['icon'] = $oauth['icon'];
                $oauth_login[$oauth['name']]['id'] = $oauth['id'];

            }
            $this->assign('oauth_login',$oauth_login);
            $this->redirect();
        }
    }

    public function login_oauth()
    {
        $id = Filter::int(Req::args('id'));
        $model = new Model('oauth');
        $oauth = $model->where('id='.$id)->find();
        if($oauth){
            $obj = new $oauth['class_name']();
            $this->redirect($obj->getRequestCodeURL());
        }

    }
    public function login_act()
    {
        if($this->getModule()->checkToken('login')){
            $redirectURL = Req::args("redirectURL");
            $this->assign("redirectURL",$redirectURL);
            $account = Filter::sql(Req::post('account'));
            $passWord = Req::post('password');
            $autologin = Req::args("autologin");
            if($autologin==null)$autologin = 0;
            $model = $this->model->table("user as us");
            $obj = $model->join("left join customer as cu on us.id = cu.user_id")->fields("us.*,cu.group_id,cu.user_id,cu.login_time,cu.mobile")->where("us.email='$account' or us.name='$account' or cu.mobile='$account'")->find();
            if($obj){
                if($obj['status']==1){
                    if($obj['password'] == CHash::md5($passWord,$obj['validcode'])){
                        $cookie = new Cookie();
                        $cookie->setSafeCode(Tiny::app()->getSafeCode());
                        if($autologin==1) {
                            $this->safebox->set('user',$obj,$this->cookie_time);

                            $cookie->set('autologin',array('account'=>$account,'password'=>$obj['password']),$this->cookie_time);
                        }
                        else {
                            $cookie->set('autologin',null,0);
                            $this->safebox->set('user',$obj, 1800);

                        }
                        $this->model->table("customer")->data(array('login_time'=>date('Y-m-d H:i:s')))->where('user_id='.$obj['id'])->update();
                        $redirectURL = Req::args("redirectURL");

                        if($redirectURL!='' && preg_match("/https?:\/\//i",$redirectURL)==0 && stripos($redirectURL, "reg")===false && stripos($redirectURL, "login_act")===false&& stripos($redirectURL, "oauth_bind")===false&& stripos($redirectURL, "activation_user")===false && stripos($redirectURL, "reset_password_act")===false)header('Location: '.$redirectURL, true, 302);
                        else $this->redirect('/ucenter/index');
                        exit;
                    }else{
                        $info = array('field'=>'password','msg'=>'密码错误！');
                    }
                }else if($obj['status']==2){
                    $info = array('field'=>'account','msg'=>'账号已经锁定，请联系管理人员！');
                }else{
                    $info = array('field'=>'account','msg'=>'账号还未激活，无法登录！');
                }

            }else{
                $info = array('field'=>'account','msg'=>'账号不存在！');
            }
        }else{
            $this->redirect("/index/msg",false,array('type'=>"fail","msg"=>'非法登录',"content"=>"非法登录！","redirect"=>"/simple/login"));
            exit();
        }
        $this->assign("invalid",$info);
        $this->redirect("login",false,Req::args());
    }
    public function forget_act(){

        $account =  Filter::sql(Req::args('account'));
        $verifyCode =  Filter::sql(Req::args('verifyCode'));
        $this->safebox = Safebox::getInstance();
        $code = $this->safebox->get($this->captchaKey);
        if($code != $verifyCode) $this->redirect('forget_password',false);
        if(Validator::email($account)){
            $email = $account;
            $model = $this->model->table('user');
            $obj = $model->where("email = '".$email."'")->find();
            if(!empty($obj)){
                $model = $this->model->table('reset_password');
                $obj = $model->where("email = '".$email."'")->find();
                $safecode = md5(md5($email).md5(CHash::random(32)));
                if(!empty($obj)){
                    $obj['safecode'] = $safecode;
                    $model->data($obj)->update();
                }
                else{
                    $model->data(array('email'=>$email,'safecode'=>$safecode))->add();
                }
                $reset_url = Url::fullUrlFormat("/simple/reset_password/safecode/$safecode");
                $msg_content = '';
                $site_url = Url::fullUrlFormat('/');
                $msg_title = '找回密码--'.$this->site_name;

                $msg_template_model = new Model("msg_template");
                $msg_template = $msg_template_model->where('id=3')->find();
                if($msg_template){
                    $msg_content = str_replace(array('{$site_name}','{$reset_url}','{$site_url}','{$current_time}'), array($this->site_name,$reset_url,$site_url,date('Y-m-d H:i:s')), $msg_template['content']);
                    $msg_title = $msg_template['title'];
                }else{
                    $msg_content .='<p>亲爱的用户:</p>';
                    $msg_content .='<p>感谢您注册'.$this->site_name.',请点击以下链接重置您的密码。<br/><br/>';
                    $msg_content .="<a href='{$reset_url}' target='_blank'>{$reset_url}</a><br/><br/>";
                    $msg_content .='愿您在'.$this->site_name.'度过愉快的时光。<br/><br/>';
                    $msg_content .="<a href='".$site_url."'>".$this->site_name."</a></p>";
                }
                $mail = new Mail();
                $flag = $mail->send_email($email,$msg_title,$msg_content);
                if($flag){
                    $this->assign('status','success');
                }
                else{
                    $this->assign('status','error');
                }
            }else{
                $this->assign('status','fail');
            }
            $this->assign('accountType','email');
            $this->redirect('forget_result',false);
        }elseif(Validator::mobi($account)){
            $mobile = $account;
            $model = $this->model->table('customer');
            $obj = $model->where("mobile = '".$mobile."'")->find();
            $this->assign('accountType','mobile');
            if(!empty($obj)){

                $sms = SMS::getInstance();
                if($sms->getStatus()){
                    $code = CHash::random('6','int');
                    $result = $sms->sendCode($mobile,$code);
                    if($result['status']=='success')
                    {
                        $model = $this->model->table('reset_password');
                        $model->data(array('email'=>$mobile,'safecode'=>$code))->insert();
                        $this->assign('status','success');
                    }else{
                        $this->assign('status','error');
                    }
                }else{
                    $this->assign('status','fail');
                }
                $this->redirect('forget_result',false);
            }else{
                $this->redirect('forget_password',false);
            }

        }else{
            $this->redirect('forget_password',false);
        }

    }
    public function reset_password()
    {
        $safecode = Filter::sql(Req::args('safecode'));
        if($safecode!=null && (strlen($safecode)==32 || strlen($safecode)==6))
        {
            $model = $this->model->table('reset_password');
            $obj = $model->where("safecode='".$safecode."'")->find();
            $this->assign('status','fail');
            $this->assign('safecode',$safecode);
            if(!empty($obj)) $this->assign('status','success');
            $this->redirect();
        }
        else
        {
            $this->redirect('index/index');
        }
    }
    public function reset_password_act(){
        $safecode = Filter::sql(Req::args('safecode'));
        $password = Req::args('password');
        $repassword = Req::args('repassword');
        if($password == $repassword)
        {
            $model = new Model('reset_password');
            $obj = $model->where("safecode='".$safecode."'")->find();
            if(!empty($obj))
            {
                $validcode = CHash::random(8);
                if(strlen($safecode)==32){
                    $umodel = $this->model->table('user');
                    $umodel->where("email='".Filter::sql($obj['email'])."'")->data(array('password'=>CHash::md5($password,$validcode),'validcode'=>$validcode))->update();
                }else{
                    $cumodel = $this->model->table('customer');
                    $mobile = $obj['email'];
                    $cuobj = $cumodel->where("mobile='$mobile'")->find();
                    $umodel = $this->model->table('user');
                    $umodel->where("id=".$cuobj['user_id']."")->data(array('password'=>CHash::md5($password,$validcode),'validcode'=>$validcode))->update();
                }
                $model->where('id='.$obj['id'])->delete();
                $this->assign('status','success');
                $this->redirect('reset_result',false);
            }
            else
            {
                $this->assign('status','fail');
                $this->redirect('reset_result',false);
            }
        }
        else
        {
            $this->assign("invalid",array('field'=>'repassword','msg'=>'两次密码不一致！'));
            $this->redirect('reset_password',false,Req::args());
        }
    }
    /**
     * 第三方登录回调地址,跳转到绑定到用户页面。
     * @return void
     */
    function callback(){

        $type = Filter::sql(Req::args('type'));
        $code = Filter::sql(Req::args('code'));
        (empty($type) || empty($code)) && die('参数错误');

        $oauth = new $type();

        //腾讯微博需传递的额外参数
        $extend = null;
        if($type == 'tencent'){
            $extend = array('openid' => $this->_get('openid'), 'openkey' => $this->_get('openkey'));
        }

        $token = $oauth->getAccessToken($code , $extend);
        $userinfo = $oauth->getUserInfo();
        if(!empty($userinfo)){
            $oauth_user = $this->model->table('oauth_user');

            if(isset($userinfo['unionid'])){
                $is_oauth = $oauth_user->fields('user_id,id')
                ->where('(open_id="'.$token['openid'].'" or union_id="'.$userinfo['unionid'].'") and oauth_type="'.$type.'"')
                ->find();
                //已注册用户，未绑定unionid的用户绑定上unionid
                if($is_oauth['union_id']==''){
                    $oauth_user->where('id='.$is_oauth['id'])->data(array('union_id'=>$userinfo['unionid']))->update();
                }
            }else{
                $is_oauth = $oauth_user->fields('user_id')
                ->where('open_id="'.$token['openid'].'" and oauth_type="'.$type.'"')
                ->find();
            }

            if($is_oauth['user_id']){
                //已绑定用户
                if($is_oauth['user_id']>0){
                    $obj = $this->model->table("user as us")->join("left join customer as cu on us.id = cu.user_id")->fields("us.*,cu.group_id,cu.login_time")->where("us.id='{$is_oauth['user_id']}'")->find();
                    $this->safebox->set('user',$obj, $this->cookie_time);
                    $this->redirect('/ucenter/index');
                    exit();
                }
            }else{
                $data = array(
                    'open_name'=>$userinfo['open_name'],
                    'oauth_type' => $type,
                    'posttime'=>time(),
                    'token' =>$token['access_token'],
                    'expires'=>$token['expires_in'],
                    'open_id'=>$token['openid']
                    );
                if(isset($userinfo['unionid'])){
                    $data['union_id'] = $userinfo['unionid'];
                }

                if($this->checkOnline()){
                    $data['user_id'] = $this->user['id'];
                    $oauth_user->data($data)->insert();
                    $this->redirect('/ucenter/union');
                    exit;
                }else{
                    $oauth_user->data($data)->insert();
                }

            }
            $oauth_info = $oauth->getConfig();
            $userinfo['type_name'] = $oauth_info['name'];
            $userinfo['open_id'] = $token['openid'];
            $userinfo['oauth_type'] = $type;
            Session::set('oauth_user_info',$userinfo);
            $this->redirect("/simple/oauth_bind");
        }
    }
    /**
     * 用户绑定Action
     * @return
     */
    public function oauth_bind()
    {
        $userinfo = Session::get('oauth_user_info');
        if($userinfo){
            $this->assign('type_name',$userinfo['type_name']);
            $this->assign('open_name',$userinfo['open_name']);
            $this->assign('head_img',$userinfo['head']);
            $this->assign("user",$this->user);
            $this->redirect("/simple/oauth_bind");
        }
        else{
            $this->redirect("/index/index");
        }
    }
    /**
     * 绑定用户Action
     */
    public function oauth_bind_act()
    {
        $userinfo = Session::get('oauth_user_info');

        if($userinfo){
            $account = Filter::sql(Req::args('account'));
            $passWord = Req::post('password');
            $rePassWord = Req::post('repassword');

            if(strlen($passWord)<6){
                $info = array('field'=>'password','msg'=>'密码长度必需大于6位！');
            }else{
                $info = null;
                $model = $this->model->table("user as us");
                $obj = $model->join("left join customer as cu on us.id = cu.user_id")->fields("us.*,cu.group_id,cu.user_id,cu.login_time,cu.mobile")->where("us.email='$account' or us.name='$account' or cu.mobile='$account'")->find();
                if($obj){
                    if($obj['password'] == CHash::md5($passWord,$obj['validcode'])){
                        if(isset($userinfo['unionid'])){
                            $this->model->table('oauth_user')->where("oauth_type='{$userinfo['oauth_type']}' and (open_id='{$userinfo['open_id']}' or union_id='{$userinfo['unionid']}')")->data(array('user_id'=>$obj['id']))->update();
                        }else{
                            $this->model->table('oauth_user')->where("oauth_type='{$userinfo['oauth_type']}' and open_id='{$userinfo['open_id']}'")->data(array('user_id'=>$obj['id']))->update();
                        }

                        $this->safebox->set('user',$obj,1800);
                        $this->redirect("/ucenter/index");
                        exit;
                    }else{
                        $info = array('exist'=>'yes','field'=>'password','msg'=>'密码与用户名是不匹配的，无法绑定!');
                    }
                }else{

                    if($passWord == $rePassWord){
                        $config = Config::getInstance();
                        $other = $config->get('other');
                        $reg_way = isset($other['other_reg_way'])?$other['other_reg_way']:0;
                        $reg_way = explode(',',$reg_way);
                        $reg_way = array_flip($reg_way);
                        $reg_able = false;
                        $reg_type = array();
                        if(isset($reg_way[0])){
                            $reg_type[] = "邮箱";
                        }
                        if(isset($reg_way[1])){
                            $reg_type[] = "手机号";
                        }
                        if(Validator::email($account)){
                            if(isset($reg_way[0])){
                                $email = $account;
                                $mobile = '';
                                $reg_able = true;
                            }
                        }elseif(Validator::mobi($account)){
                            if(isset($reg_way[1])){
                                $mobile = $account;
                                $email  = $mobile.'@no.com';
                                $reg_able = true;
                            }
                        }

                        if($reg_able){
                            $model = $this->model->table("user");
                            $validcode = CHash::random(8);
                            $last_id = $model->data(array('email'=>$email,'name'=>$userinfo['open_name'],'password'=>CHash::md5($passWord,$validcode),'validcode'=>$validcode))->insert();
                            $time = date('Y-m-d H:i:s');
                            $model->table("customer")->data(array('user_id'=>$last_id ,'reg_time'=>$time,'login_time'=>$time,'mobile'=>$mobile))->insert();
                        //记录登录信息
                            $obj = $model->table("user as us")->join("left join customer as cu on us.id = cu.user_id")->fields("us.*,cu.group_id,cu.login_time,cu.mobile")->where("us.email='$account' or cu.mobile='$account'")->find();
                            $this->safebox->set('user',$obj,1800);
                            $this->model->table('oauth_user')->where("oauth_type='{$userinfo['oauth_type']}' and open_id='{$userinfo['open_id']}'")->data(array('user_id'=>$last_id))->update();
                            $this->redirect("/ucenter/index");
                            exit;
                        }else{
                            $tmp = implode(',', $reg_type);
                            $info = array('exist'=>'no','field'=>'account','msg'=>'若绑定注册，系统仅支持以下注册方式: '.$tmp);
                        }
                    }
                    else{
                        $info = array('exist'=>'yes','field'=>'repassword','msg'=>'两次密码输入不一致！');
                    }
                }
            }
            $this->assign("invalid",$info);
            $this->redirect("/simple/oauth_bind",false,Req::args());
        }
        else{
            $this->redirect("/index/index");
        }
    }

    public function cart()
    {
        $type = Req::args('cart_type');
        $this->assign("cart_type","cart");
        if($type=='goods'){
            $cart = Cart::getCart('goods');
            $this->cart = $cart->all();
            $this->assign("cart_type","goods");
            $this->assign("cart",$this->cart);
        }
        $this->redirect();
    }

    public function order(){
        $type = Req::args('cart_type');
        if($type=='goods'){
            $cart = Cart::getCart('goods');
            $this->cart = $cart->all();
            $this->assign('cart',$this->cart);
            $this->assign('cart_type','goods');
        }
        if(!$this->cart)$this->redirect("cart");
        if($this->checkOnline()){
            $this->parserOrder();
            $this->redirect();
        }else{
            $this->redirect("login");
        }
    }
    //解析订单
    private function parserOrder(){
        $config = Config::getInstance();
        $config_other = $config->get('other');
        $open_invoice = isset($config_other['other_is_invoice'])?!!$config_other['other_is_invoice']:false;
        $tax = isset($config_other['other_tax'])?intval($config_other['other_tax']):0;

        $area_ids = array();
        $address = $this->model->table("address")->where("user_id=".$this->user['id'])->order("is_default desc")->findAll();
        foreach ($address as $add) {
            $area_ids[$add['province']] = $add['province'];
            $area_ids[$add['city']] = $add['city'];
            $area_ids[$add['county']] = $add['county'];
        }
        $area_ids = implode(",",$area_ids);
        $areas = array();
        if($area_ids!='')$areas = $this->model->table("area")->where("id in($area_ids )")->findAll();
        $parse_area = array();
        foreach ($areas as $area) {
            $parse_area[$area['id']] = $area['name'];
        }

        $model = new Model("voucher");
        $where = "user_id = ".$this->user['id']." and is_send = 1";
        $where .= " and status = 0 and '".date("Y-m-d H:i:s")."' <=end_time";
        $voucher = $model->where($where)->order("id desc")->findAll();

        $this->assign("voucher",$voucher);
        $this->assign("open_invoice",$open_invoice);
        $this->assign("tax",$tax);
        $this->assign("address",$address);
        $this->assign("parse_area",$parse_area);
        $this->assign("order_status",Session::get("order_status"));
    }
    //打包团购订单商品信息
    private function packGroupbuyProducts($item,$num=1){
        $store_nums = $item['store_nums'];
        $have_num = $item['max_num']-$item['goods_num'];
        if($have_num>$store_nums) $have_num = $store_nums;
        if($num>$have_num) $num = $have_num;
        $amount = sprintf("%01.2f",$item['price']*$num);
        $sell_total = $item['sell_price']*$num;
        $product_id = $item['product_id'];

        $product[$product_id] = array('id'=>$product_id,'goods_id'=>$item['goods_id'],'name'=>$item['name'],'img'=>$item['img'],'num'=>$num,'store_nums'=>$have_num,'price'=>$item['price'],'spec'=>unserialize($item['spec']),'amount'=>$amount,'sell_total'=>$sell_total,'weight'=>$item['weight'],'point'=>$item['point'],"prom_goods"=>array(),"sell_price"=>$item['sell_price'],"real_price"=>$item['price'],'goods_type'=>$item['goods_type'],'virtual_extend'=>$item['virtual_extend']);
        return $product;
    }
    //打包抢购订单商品信息
    private function packFlashbuyProducts($item,$num=1){
        $store_nums = $item['store_nums'];
        $quota_num = $item['quota_num'];
        $have_num = $item['max_num']-$item['goods_num'];
        if($have_num>$store_nums) $have_num = $store_nums;
        if($have_num>$quota_num) $have_num = $quota_num;
        if($num>$have_num) $num = $have_num;
        $amount = sprintf("%01.2f",$item['price']*$num);
        $sell_total = $item['sell_price']*$num;
        $product_id = $item['product_id'];

        $product[$product_id] = array('id'=>$product_id,'goods_id'=>$item['goods_id'],'name'=>$item['name'],'img'=>$item['img'],'num'=>$num,'store_nums'=>$have_num,'price'=>$item['price'],'spec'=>unserialize($item['spec']),'amount'=>$amount,'sell_total'=>$sell_total,'weight'=>$item['weight'],'point'=>$item['point'],"prom_goods"=>array(),"sell_price"=>$item['sell_price'],"real_price"=>$item['price'],'goods_type'=>$item['goods_type'],'virtual_extend'=>$item['virtual_extend']);
        return $product;
    }
    //捆绑订单商品信息
    private function packBundbuyProducts($items,$num=1){
        $max_num = $num;
        foreach ($items as $prod) if($max_num>$prod['store_nums'])$max_num = $prod['store_nums'];
        $num = $max_num;
        foreach($items as $item) {
            $store_nums = $item['store_nums'];
            $amount = sprintf("%01.2f",$item['sell_price']*$num);
            $sell_total = $item['sell_price']*$num;
            $product_id = $item['product_id'];

            $product[$product_id] = array('id'=>$product_id,'goods_id'=>$item['goods_id'],'name'=>$item['name'],'img'=>$item['img'],'num'=>$num,'store_nums'=>$item['store_nums'],'price'=>$item['sell_price'],'spec'=>unserialize($item['spec']),'amount'=>$amount,'sell_total'=>$sell_total,'weight'=>$item['weight'],'point'=>$item['point'],"prom_goods"=>array(),"sell_price"=>$item['sell_price'],"real_price"=>$item['sell_price'],'goods_type'=>$item['goods_type'],'virtual_extend'=>$item['virtual_extend']);
        }
        return $product;
    }
    //非普通促销确认订单
    public function order_info(){
        $id = Filter::int(Req::args('id'));
        $product_id = Req::args('pid');
        $type = Req::args("type");
        if($this->checkOnline()){
            if($type=='groupbuy'){
            	$product_id = Filter::int($product_id);
                $model = new Model("groupbuy as gb");
                $item = $model->join("left join goods as go on gb.goods_id=go.id left join products as pr on pr.goods_id=gb.goods_id")->fields("*,pr.id as product_id,pr.store_nums,pr.goods_type,pr.virtual_extend")->where("gb.id=$id and pr.id=$product_id")->find();
                if($item){
                    $start_diff = time()-strtotime($item['start_time']);
                    $end_diff = time()-strtotime($item['end_time']);
                    if($item['is_end']==0 && $start_diff>=0 && $end_diff<0 && $item['store_nums']>0){
                        $product = $this->packGroupbuyProducts($item);
                        $this->assign("product",$product);
                    }else{
                        $this->redirect("/index/groupbuy/id/$id");
                    }
                }else{
                    Tiny::Msg($this,"你提交的团购不存在！",404);
                    exit;
                }
            }else if($type=='flashbuy'){
                $model = new Model("flash_sale as fb");
                $product_id = Filter::int($product_id);
                $item = $model->join("left join goods as go on fb.goods_id=go.id left join products as pr on pr.goods_id=fb.goods_id")->fields("*,pr.id as product_id,pr.store_nums,pr.goods_type,pr.virtual_extend")->where("fb.id=$id and pr.id=$product_id")->find();
                if($item){
                    $start_diff = time()-strtotime($item['start_time']);
                    $end_diff = time()-strtotime($item['end_time']);
                    if($item['is_end']==0 && $start_diff>=0 && $end_diff<0 && $item['store_nums']>0){
                        $product = $this->packFlashbuyProducts($item);
                        $this->assign("product",$product);
                    }else{
                        $this->redirect("/index/flashbuy/id/$id");
                    }
                }else{
                    Tiny::Msg($this,"你提交的抢购不存在！",404);
                    exit;
                }

            }else if($type == 'bundbuy'){
                //确认捆绑存在有效且所有的商品都在其中包括个数完全正确
                $product_id = trim($product_id,"-");
                $product_id_array = explode("-",$product_id);
                foreach($product_id_array as $key=>$val){
                	$product_id_array[$key] = Filter::int($val);
                }
                $product_ids = implode(',', $product_id_array);
                $product_id = implode('-', $product_id_array);
                $model = new Model("bundling");
                $bund = $model->where("id=$id")->find();
                if($bund){
                    $goods_id_array = explode(',',$bund['goods_id']);

                    $products = $model->table("goods as go")->join("left join products as pr on pr.goods_id=go.id")->where("pr.id in ($product_ids)")->fields("*,pr.id as product_id,pr.goods_type as goods_type,pr.virtual_extend as virtual_extend")->group("go.id")->findAll();
                    //检测库存与防偷梁换柱
                    foreach ($products as  $value) {
                        if($value['store_nums']<=0 || !in_array($value['goods_id'], $goods_id_array)){
                            $this->redirect("/index/bundbuy/id/$id");
                        }
                    }
                    if(count($goods_id_array)==count($products)){
                        $product = $this->packBundbuyProducts($products);
                        $this->assign("product",$product);
                        $this->assign("bund",$bund);
                    }else{
                        $this->redirect("/index/bundbuy/id/$id");
                    }
                    $product_id = $product_id;
                }
                else{
                   $this->redirect("/index/msg",true,array('msg'=>'你提交的套餐不存在！','type'=>'error'));
               }
           }
           $this->assign("id",$id);
           $this->assign("order_type",$type);
           $this->assign("pid",$product_id);
           $this->parserOrder();
           $this->redirect();
       }else{
        $this->redirect("login");
    }
}
    //团购商品数量
public function groupbuy_num(){
    $id = Filter::int(Req::args('id'));
    $num = Filter::int(Req::args('num'));
    $address_id = Filter::int(Req::args('address_id'));
    if($num<=0)$num = 1;
    $product_id = Filter::int(Req::args('pid'));
    $model = new Model("groupbuy as gb");
    $item = $model->join("left join goods as go on gb.goods_id=go.id left join products as pr on pr.id=$product_id")->fields("*,pr.id as product_id")->where("gb.id=$id")->find();
    $product = $this->packGroupbuyProducts($item,$num);
    $weight = $product[$product_id]['weight'] * $num;
    $fare = new Fare($weight);
    $fee = $fare->calculate($address_id);
    $product[$product_id]['freight'] = $fee;
    $product[$product_id]['totalWeight'] = $weight;
    echo JSON::encode($product);
}
    //抢购商品数量
public function flashbuy_num(){
    $id = Filter::int(Req::args('id'));
    $num = Filter::int(Req::args('num'));
    $address_id = Filter::int(Req::args('address_id'));
    if($num<=0)$num = 1;
    $product_id = Filter::int(Req::args('pid'));
    $model = new Model("flash_sale as fb");
    $item = $model->join("left join goods as go on fb.goods_id=go.id left join products as pr on pr.id=$product_id")->fields("*,pr.id as product_id")->where("fb.id=$id")->find();
    $product = $this->packFlashbuyProducts($item,$num);
    $weight = $product[$product_id]['weight'] * $num;
    $fare = new Fare($weight);
    $fee = $fare->calculate($address_id);
    $product[$product_id]['freight'] = $fee;
    $product[$product_id]['totalWeight'] = $weight;
    echo JSON::encode($product);
}
    //捆绑商品数量
public function bundbuy_num(){
    $id = Filter::int(Req::args('id'));
    $num = Filter::int(Req::args('num'));
    $address_id = Filter::int(Req::args('address_id'));
    if($num<=0)$num = 1;
    $product_id = Req::args('pid');
    $id_arrary = explode('-', $product_id);
    foreach ($id_arrary as $key => $value) {
        $id_arrary[$key] = Filter::int($value);
    }
    $product_ids = implode(',', $id_arrary);
    $model = new Model("bundling");
    $bund = $model->where("id=$id")->find();
    if($bund){
        $goods_id = $bund['goods_id'];
        $products = $model->table("goods as go")->join("left join products as pr on pr.goods_id=go.id")->where("pr.id in ($product_ids)")->fields("*,pr.id as product_id")->group("go.id")->findAll();
        $products = $this->packBundbuyProducts($products);
    }
    $weight = 0;
    $max_num = $num;
    foreach ($products as $prod) {
        $weight += $prod['weight'];
        if($max_num>$prod['store_nums'])$max_num = $prod['store_nums'];
    }
    $num = $max_num;
    $amount = sprintf("%01.2f",$bund['price'] * $num);
    $product[$product_id] = array('id'=>$product_ids,'goods_id'=>'','name'=>'','img'=>'','num'=>$num,'store_nums'=>$num,'price'=>$bund['price'],'spec'=>array(),'amount'=>$amount,'sell_total'=>$amount,'weight'=>$weight,'point'=>'',"prom_goods"=>array(),"sell_price"=>$bund['price'],"real_price"=>$bund['price']);

    $weight = $weight * $num;
    $fare = new Fare($weight);
    $fee = $fare->calculate($address_id);
    $product[$product_id]['freight'] = $fee;
    $product[$product_id]['totalWeight'] = $weight;

    echo JSON::encode($product);
}
    //提交订单处理
public function order_act(){
    if($this->checkOnline()){
        $address_id = Filter::int(Req::args('address_id'));
        $payment_id = Filter::int(Req::args('payment_id'));
        $prom_id = Filter::int(Req::args('prom_id'));
        $is_invoice = Filter::int(Req::args('is_invoice'));
        $invoice_type = Filter::int(Req::args('invoice_type'));
        $invoice_title = Filter::text(Req::args('invoice_title'));
        $user_remark = Filter::txt(Req::args('user_remark'));
        $voucher_id = Filter::int(Req::args('voucher'));
        $cart_type = Req::args('cart_type');

            //非普通促销信息
        $type = Req::args("type");
        $id = Filter::int(Req::args('id'));
        $product_id = Req::args('product_id');
        $buy_num = Req::args('buy_num');

        $allVirtual = true;


        if( !$payment_id || ($is_invoice==1 && $invoice_title=='')){
            if(is_array($product_id)){
                foreach($product_id as $key=>$val){
                    $product_id[$key] = Filter::int($val);
                }
                $product_id = implode('-', $product_id);
            }
            else $product_id =  Filter::int($product_id);
            $data = Req::args();
            $data['is_invoice']=$is_invoice;
            if(!$payment_id)$data['msg'] = array('fail',"必需选择支付方式，才能确认订单。");
            else $data['msg'] = array('fail',"索要发票，必需写明发票抬头。");
            if($type==null)$this->redirect("order",false,$data);
            else {
                unset($data['act']);
                Req::args('pid',$product_id);
                Req::args('id',$id);
                unset($_GET['act']);
                Req::args('type',$type);
                Req::args('msg',$data['msg']);
                $this->redirect("/simple/order_info",true,Req::args());
            }
            exit;
        }
            //地址信息


            //if(!$payment_id)$this->redirect("order",false,Req::args());

        if($this->getModule()->checkToken('order')){

                //订单类型: 0普通订单 1团购订单 2限时抢购 3捆绑促销
            $order_type = 0;
            $model = new Model('');


                //团购处理
            if($type=="groupbuy"){
                $product_id = Filter::int($product_id[0]);
                $num = Filter::int($buy_num[0]);
                if($num<1) $num = 1;
                $item = $model->table("groupbuy as gb")->join("left join goods as go on gb.goods_id=go.id left join products as pr on pr.id=$product_id")->fields("*,pr.id as product_id,pr.spec,pr.goods_type as goods_type,pr.virtual_extend")->where("gb.id=$id")->find();

                $order_products = $this->packGroupbuyProducts($item,$num);
                if($order_products[$item['product_id']]['goods_type']==0) $allVirtual = false;

                $groupbuy = $model->table("groupbuy")->where("id=$id")->find();
                unset($groupbuy['description']);
                $data['prom'] = serialize($groupbuy);
                $data['prom_id'] = $id;
                $order_type = 1;

            }else if($type=="flashbuy"){//抢购处理
                $product_id = Filter::int($product_id[0]);
                $num = Filter::int($buy_num[0]);
                if($num<1) $num = 1;
                $item = $model->table("flash_sale as fb")->join("left join goods as go on fb.goods_id=go.id left join products as pr on pr.id=$product_id")->fields("*,pr.id as product_id,pr.spec,pr.goods_type")->where("fb.id=$id")->find();
                $order_products = $this->packFlashbuyProducts($item,$num);
                if($order_products[$item['product_id']]['goods_type']==0) $allVirtual = false;

                $flashbuy = $model->table("flash_sale")->where("id=$id")->find();
                unset($flashbuy['description']);
                $data['prom'] = serialize($flashbuy);
                $data['prom_id'] = $id;
                $order_type = 2;
            }else if($type=="bundbuy"){//捆绑销售处理

                if(is_array($product_id)){
                    foreach($product_id as $key=>$val){
                        $product_id[$key] = Filter::int($val);
                    }
                }
                else $product_id =  Filter::int($product_id);

                $product_ids = implode(',', $product_id);
                $num = Filter::int($buy_num[0]);

                $model = new Model("bundling");
                $bund = $model->where("id=$id")->find();

                if($bund){
                    $goods_id = $bund['goods_id'];
                    $products = $model->table("goods as go")->join("left join products as pr on pr.goods_id=go.id")->where("pr.id in ($product_ids)")->fields("*,pr.id as product_id,pr.spec")->group("go.id")->findAll();
                    $order_products = $this->packBundbuyProducts($products,$num);

                    foreach($order_products as $pros){
                        $tem = current($pros);
                        if($tem['goods_type']==0){
                            $allVirtual = false;

                            break;
                        }
                    }
                    reset($order_products);
                }

                $bundbuy = $model->table("bundling")->where("id=$id")->find();
                unset($bundbuy['description']);
                $data['prom'] = serialize($bundbuy);
                $data['prom_id'] = $id;
                $current = current($order_products);
                $bundbuy_amount = sprintf("%01.2f",$bund['price']) * $current['num'];

                $order_type = 3;
            }else{
                foreach ($this->cart as $cart) {
                    if($cart['goods_type']==0){
                        $allVirtual = false;
                        break;
                    }
                }
            }



                //检测商品实虚
            if(!$allVirtual){
                if(!$address_id && $allVirtual){
                    $data['msg'] = array('fail',"必需选择收货地址，才能确认订单。");
                    if($type==null)$this->redirect("order",false,$data);
                    else {
                        unset($data['act']);
                        Req::args('pid',$product_id);
                        Req::args('id',$id);
                        unset($_GET['act']);
                        Req::args('type',$type);
                        Req::args('msg',$data['msg']);
                        $this->redirect("/simple/order_info",true,Req::args());
                    }
                    exit;
                }

                $address_model = new Model('address');
                $address = $address_model->where("id=$address_id and user_id=".$this->user['id'])->find();
                if(!$address){
                    $data = Req::args();
                    $data['msg'] = array('fail',"选择的地址信息不正确！");
                    $this->redirect("order",false,$data);
                    exit;
                }
            }else{

                $address['accept_name'] = "";
                $address['phone']="";
                $address['mobile']="";
                $address['province']="";
                $address['city']="";
                $address['county']="";
                $address['addr']="";
                $address['zip']="";
            }


            if($order_type==0){

                if($cart_type == 'goods'){
                    $cart = Cart::getCart('goods');
                }else{
                    $cart = Cart::getCart();
                }
                $order_products = $cart->all();
                $data['prom_id'] = $prom_id;
            }

                //检测products 是否还有数据
            if(empty($order_products)){
                $msg = array('type'=>'fail','msg'=>'非法提交订单！');
                $this->redirect('/index/msg',false,$msg);
                return;
            }

                //商品总金额,重量,积分计算
            $payable_amount = 0.00;
            $real_amount = 0.00;
            $weight=0;
            $point = 0;
            foreach ($order_products as $item) {
                $payable_amount+=$item['sell_total'];
                $real_amount+=$item['amount'];
                $weight += $item['weight']*$item['num'];
                $point += $item['point']*$item['num'];
            }
            if($order_type == 3) $real_amount = $bundbuy_amount;

                //计算运费
            if (!$allVirtual){
                $fare = new Fare($weight);
                $payable_freight = $fare->calculate($address_id);
            }else{
                $payable_freight = 0;
            }
            $real_freight = $payable_freight;


                //计算订单优惠
            $prom_order = array();
            $discount_amount = 0;
            if($order_type ==0 ){
                if($prom_id){
                    $prom = new Prom($real_amount);
                    $prom_order = $model->table("prom_order")->where("id=$prom_id")->find();

                        //防止非法会员使用订单优惠
                    $user = $this->user;
                    $group_id = ',0,';
                    if(isset($user['group_id'])) $group_id = ','.$user['group_id'].',';

                    if(stripos(','.$prom_order['group'].',',$group_id)!==false){
                        $prom_parse = $prom->parsePorm($prom_order);
                        $discount_amount = $prom_parse['value'];
                        if($prom_order['type']==4) $discount_amount = $payable_freight;
                        else if($prom_order['type']==2){
                            $multiple = intval($prom_order['expression']);
                            $multiple = $multiple==0?1:$multiple;
                            $point = $point * $multiple;
                        }
                        $data['prom'] = serialize($prom_order);
                    }
                    else $data['prom'] = serialize(array());
                }
            }
                //税计算
            $tax_fee = 0;
            $config = Config::getInstance();
            $config_other = $config->get('other');
            $open_invoice = isset($config_other['other_is_invoice'])?!!$config_other['other_is_invoice']:false;
            $tax = isset($config_other['other_tax'])?intval($config_other['other_tax']):0;
            if($open_invoice && $is_invoice){
                $tax_fee = $real_amount*$tax/100;
            }

                //代金券处理
            $voucher_value = 0;
            $voucher = array();
            if($voucher_id){
                $voucher = $model->table("voucher")->where("id=$voucher_id and is_send=1 and user_id=".$this->user['id']." and status = 0 and '".date("Y-m-d H:i:s")."' <=end_time and '".date("Y-m-d H:i:s")."' >=start_time and money<=".$real_amount)->find();
                if($voucher){
                    $voucher_value = $voucher['value'];
                    if($voucher_value>$real_amount)$voucher_value = $real_amount;
                }
            }
                //计算订单总金额
            $order_amount = $real_amount + $payable_freight + $tax_fee - $discount_amount - $voucher_value;



                //填写订单
            $data['order_no'] = Common::createOrderNo();
            $data['user_id'] = $this->user['id'];
            $data['payment'] = $payment_id;
            $data['status'] = 2;
            $data['pay_status'] = 0;
            $data['accept_name'] = Filter::text($address['accept_name']);
            $data['phone'] = $address['phone'];
            $data['mobile'] = $address['mobile'];
            $data['province'] = $address['province'];
            $data['city'] = $address['city'];
            $data['county'] = $address['county'];
            $data['addr'] = Filter::text($address['addr']);
            $data['zip'] = $address['zip'];
            $data['payable_amount'] = $payable_amount;

            $data['payable_freight'] = $payable_freight;
            $data['real_freight'] = $real_freight;
            $data['create_time'] = date('Y-m-d H:i:s');
            $data['user_remark'] = $user_remark;
            $data['is_invoice'] = $is_invoice;
            if($is_invoice==1){
                $data['invoice_title'] = $invoice_type.':'.$invoice_title;
            }else{
                $data['invoice_title'] = '';
            }

            $data['taxes'] = $tax_fee;


            $data['discount_amount'] = $discount_amount;

            $data['order_amount'] = $order_amount;
            $data['real_amount'] = $real_amount;

            $data['point'] = $point;
            $data['type'] = $order_type;
            $data['voucher_id'] = $voucher_id;
            $data['voucher'] = serialize($voucher);


                //var_dump($order_products);exit();

                //写入订单数据
            $order_id = $model->table("order")->data($data)->insert();
                //写入订单商品
            $tem_data = array();

            foreach ($order_products as $item) {
                $tem_data['order_id'] = $order_id;
                $tem_data['goods_id'] = $item['goods_id'];
                $tem_data['product_id'] = $item['id'];
                $tem_data['goods_price'] = $item['sell_price'];
                $tem_data['real_price'] = $item['real_price'];
                $tem_data['goods_nums'] = $item['num'];
                $tem_data['goods_weight'] = $item['weight'];
                $tem_data['prom_goods'] = serialize($item['prom_goods']);
                $tem_data['spec'] = serialize($item['spec']);
                $tem_data['goods_type'] = $item['goods_type'];
                $tem_data['virtual_extend'] = $item['virtual_extend'];
                $model->table("order_goods")->data($tem_data)->insert();
            }
                //发送下单提醒
            $NoticeService = new NoticeService();
            $data['user'] = $this->user['name'];
            $data['tousers'] = $data['mobile'];
            $data['create_time'] = date('m月d日H点i分');
            $NoticeService->send('create_order',$data);
                //优惠券锁死
            if(!empty($voucher)){
                $model->table("voucher")->where("id=$voucher_id and user_id=".$this->user['id'])->data(array('status'=>2))->update();
            }
                //清空购物车与表单缓存
            if($order_type==0){
                $cart->clear();
                Session::clear("order_status");
            }
            $payment = new Payment($payment_id);
            $payment_plugin = $payment->getPaymentPlugin();
            if($payment_plugin->isOnlinePay()){
                $this->redirect("/simple/order_status/order_id/$order_id");
            }else{
                $this->redirect("/simple/order_completed/order_id/$order_id");
            }
        }
        else{
            $msg = array('type'=>'fail','msg'=>'非法提交订单！');
            $this->redirect('/index/msg',false,$msg);
        }
    }else{
        $this->redirect("login");
    }
}
public function order_status(){
    if($this->checkOnline()){
        $order_id = Filter::int(Req::get("order_id"));
        if($order_id){
            $order = $this->model->table("order as od")->join("left join payment as pa on od.payment= pa.id")->fields("od.id,od.order_no,od.payment,od.pay_status,od.order_amount,pa.pay_name as payname,od.type,od.status")->where("od.id=$order_id and od.status<=4 and od.user_id = ".$this->user['id'])->find();
            if($order){
                if($order['pay_status']==0){
                    $payment_plugin = Common::getPaymentInfo($order['payment']);
                    if($payment_plugin!=null && $payment_plugin['class_name']=='received' && $order['status']==3){
                        $this->redirect("/simple/order_completed/order_id/$order_id");
                    }
                    $this->assign("order",$order);
                    $this->redirect();
                }else if($order['pay_status']==1){
                    $this->redirect("/simple/order_completed/order_id/$order_id");
                }
            }else{
                Tiny::Msg($this,404);
            }
        }else{
            Tiny::Msg($this,404);
        }
    }else{
        $this->redirect("login");
    }
}
public function order_completed(){
    if($this->checkOnline()){
        $order_id = Filter::int(Req::args("order_id"));
        if($order_id){
            $order = $this->model->table("order as od")->join("left join payment as pa on od.payment= pa.id")->fields("od.id,od.order_no,od.payment,od.pay_status,od.order_amount,pa.pay_name as payname,od.type,od.status")->where("od.id=$order_id and od.status<=4 and od.user_id = ".$this->user['id'])->find();
            if($order){
                if($order['pay_status']==1){
                    if($order['status']==4){
                        $this->redirect("/ucenter/order_detail/id/".$order['id']);
                    }else{
                        $this->assign("order",$order);
                        $this->redirect();
                    }

                }else if($order['pay_status']==0){
                    $payment_plugin = Common::getPaymentInfo($order['payment']);
                    if($payment_plugin!=null && $payment_plugin['class_name']=='received'){
                        $this->assign("payment_type","received");
                        $this->assign("order",$order);
                        $this->redirect();
                    }else{
                        $this->redirect("/simple/order_status/order_id/$order_id");
                    }
                }
            }else{
                Tiny::Msg($this,404);
            }
        }else{
            Tiny::Msg($this,404);
        }
    }else{
        $this->redirect("login");
    }
}
public function get_voucher(){
    $page = Filter::int(Req::args("page"));
    $amount = Filter::int(Req::args("amount"));
    $where = "user_id = ".$this->user['id']." and is_send = 1";
    $where .= " and status = 0 and '".date("Y-m-d H:i:s")."' <=end_time and '".date("Y-m-d H:i:s")."' >=start_time and money<=".$amount;
    $voucher = $this->model->table("voucher")->where($where)->order("end_time")->findPage($page,10,1,true);
    $data = $voucher['data'];
    $voucher['data'] = $data;
    $voucher['status'] = "success";
    echo JSON::encode($voucher);
}
public function reg_result(){
    $this->assign("user",$this->user);
    $this->redirect();
}
public function address_other(){
    Session::set("order_status",Req::args());
    $this->layout = '';
    $id = Filter::int(Req::args("id"));
    if($id){
        $model = new Model("address");
        $data = $model->where("id = $id and user_id =".$this->user['id'])->find();
        $this->redirect("address_other",false,$data);
    }
    else $this->redirect();
}
public function address_from_ucenter(){
    $this->address_save("/ucenter/address");
}
public function address_save($redirect=null){
    $rules = array('zip:zip:邮政编码格式不正确!','addr:required:内容不能为空！','accept_name:required:收货人姓名不能为空!,mobile:mobi:手机格式不正确!,phone:phone:电话格式不正确','province:[1-9]\d*:选择地区必需完成','city:[1-9]\d*:选择地区必需完成','county:[1-9]\d*:选择地区必需完成');
    $info = Validator::check($rules);

    if(!is_array($info) && $info==true) {
        Filter::form(array('sql'=>'accept_name|mobile|phone','txt'=>'addr','int'=>'province|city|county|zip|is_default|id'));
        $is_default = Filter::int(Req::args("is_default"));
        if($is_default == 1){
            $this->model->table("address")->where("user_id=".$this->user['id'])->data(array('is_default'=>0))->update();
        }else{
            Req::args("is_default","0");
        }

        Req::args("user_id",$this->user['id']);
        $id = Filter::int(Req::args('id'));
        if($id){
            $this->model->table("address")->where("id=$id and user_id=".$this->user['id'])->update();
        }
        else{
            $obj = $this->model->table("address")->where('user_id='.$this->user['id'])->fields("count(*) as total")->find();
            if($obj && $obj['total']>=20){
                $this->assign("msg",array("error",'地址最大允许添加20个'));
                $this->redirect("address_other",false,Req::args());
                exit();
            }else{
                $address_id = $this->model->table("address")->insert();
                $order_status = Session::get("order_status");
                $order_status['address_id'] = $address_id;
                Session::set("order_status",$order_status);
            }
        }

        $this->assign("msg",array("success","地址编辑成功!"));
        Req::args("id",null);
            //$this->redirect("address_other",false);

        if($redirect==null) echo "<script>parent.location.reload();</script>";
        else $this->redirect($redirect);
        exit;
    }
    else{
        $this->assign("msg",array("error",$info['msg']));
        $this->redirect("address_other",false,Req::args());
    }
}
    //生成二维码
public function qrcode(){
    $url = urldecode(Req::args("data"));
    QRcode::png($url,false,3);
}
public function logout(){
    $this->safebox->clear('user');
    $cookie = new Cookie();
    $cookie->setSafeCode(Tiny::app()->getSafeCode());
    $cookie->set('autologin',null,0);
    $this->redirect('login');
}

public function wei_openid()
{
    if(strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false){
        $weixin_openid = Cookie::get('weixin_openid');
        if(class_exists('pay_weixin') && ($weixin_openid==null || $weixin_openid==false)){
            $pay_weixin = new pay_weixin();
            $payment = new Payment('weixin');
            $payment_info = $payment->getPayment();
            if($payment_info['status'] == 0){
                $payment_weixin = $payment->getPaymentPlugin();
                WxPayConfig::setConfig($payment_weixin->getClassConfig());
                $tools = new JsApiPay();
                $openId = $tools->GetOpenid();
                Cookie::set('weixin_openid',$openId);
            }
        }
        echo ($weixin_openid);
    }
    echo ($weixin_openid);
}
    //检测用户是否在线
private function checkOnline(){
    if(isset($this->user) && $this->user['name']!=null){
        return true;
    }else {
        return false;
    }
}
}
