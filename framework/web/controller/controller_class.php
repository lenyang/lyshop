<?php
/**
 * 控制器类
 *
 * @author Crazy、Ly
 * @class Controller
 */
class Controller extends Object
{
    //默认的action
    public $defaultAction = 'index';
    //模块
    protected $module;
    //控制器ID
    public $id;
    //渲染时的页面编码
    public $encoding='UTF-8';
    //当前正在处理的Action
    private $action;
    //布局文件
    protected $layout = 'index';
    //控制器中的数据
    public $datas=array();
    //需要验证权限的action
    protected $needRightActions=array();
    //模板文件扩展名
    private $templateExt = '.html';
    //运行文件有脚本的扩展名
    private $scriptExt = '.php';
    //自动CURD的权限
    private $autoActionRight = false;
    //验证码变量名
    protected $captchaKey = 'verifyCode';
    //安全盒子
    protected $safebox;
    //延时加载变量
    public $lazyLoadVar = false;

    //可自动处理的Action
    public  $autoActions =  array();
    /**
     * 构造函数
     *
     * @access public
     * @param mixed $id
     * @param mixed $module
     * @return mixed
     */
    public function __construct($id,$module=null)
    {
        $this->id=$id;
        $this->module=$module;
        //$this->init(); 原来位置 暂时先调到run中
    }
    //初始化处理
    protected function init(){}
    /**
     * 控制器运行时的方法
     *
     * @access public
     * @return mixed
     */
    public function run()
    {
        if(Tiny::app()->checkToken('redirect')){
            $data = Req::args();
            unset($data['con'],$data['act'],$data['tiny_token_redirect']);
            $this->setDatas($data);
        }
        $this->init();
        $id = Req::args('act');
        if($id ===null){
            $id = $this->defaultAction;
            Req::args('act',$id);
        }else if(!Validator::nameExt($id,1)){
            Tiny::Msg($this,"error");
        }

        //防止页面的循环调用
        if(!$this->module->popRequestStack($this->id.'@'.$id))$this->module->pushRequestStack($this->id.'@'.$id);
        else if($this->module->popRequestStack($this->id.'@'.$id)) {throw new Exception("Can't repeat redirect to the same position, you action is {$this->id}.",E_USER_ERROR);}
        $this->action = $this->createAction($id);
        //所有Controller处理的扩展处理
        $contExtensions = ExtensionFactory::getFactory('controllerExtension');
        if($contExtensions !== null )
        {
            $contExtensions->before($this);
            if(!is_null($this->action))$this->action->run();
            $contExtensions->after($this);
        }
        else if(!is_null($this->action))$this->action->run();
    }
    /**
     * 获得当前的模块
     *
     * @access public
     * @return mixed
     */
    public function getModule()
    {
        return $this->module;
    }
    /**
     * 取得ID
     *
     * @access public
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
    /**
     * 设置Action
     *
     * @access private
     * @param mixed $action
     * @return mixed
     */
    private function setAction($action)
    {
        if($action instanceof Action)
        {
            $this->action = $action;
        }
        else
        {
            $this->action=null;
        }
    }
    /**
     * 得到当前Action
     *
     * @access public
     * @return mixed
     */
    public function getAction()
    {
        return $this->action;
    }
    /**
     * 得到当前的视图文件
     *
     * @access public
     * @param mixed $viewName
     * @return mixed
     */
    public function getViewFile($viewName)
    {
        if(($theme = Tiny::app()->getTheme())!==null && ($viewFile=$theme->getViewFile($this,$viewName))!==null)
        {
            if(is_file($viewFile.$this->templateExt))return $viewFile;
        }

        return APP_CODE_ROOT.'views'.DIRECTORY_SEPARATOR.$this->getId().DIRECTORY_SEPARATOR.$viewName;
    }
    /**
     * 取得布局文件
     *
     * @access public
     * @return mixed
     */
    public function getLayoutFile()
    {

        $layoutName = $this->layout;

        if(($theme = Tiny::app()->getTheme())!==null && ($layoutFile = $theme->getLayoutFile($this,$layoutName))!==null)
        {
            if(file_exists($layoutFile.$this->templateExt))return $layoutFile;
        }

        return APP_CODE_ROOT.'views'.DIRECTORY_SEPARATOR.'layouts'.DIRECTORY_SEPARATOR.$layoutName;

    }
    /**
     * 提供验证码Action
     *
     * @access public
     * @return mixed
     */
    public function captcha()
    {
        ob_start();
        $this->layout = null;
        $w=Req::args('w')===null?120:intval(Req::args('w'));
        $h=Req::args('h')===null?50:intval(Req::args('h'));
        $l=Req::args('l')===null?4:intval(Req::args('l'));
        $bc=Req::args('bc')===null?array(255,255,255):'#'.Req::args('bc');
        $c=Req::args('c')===null?null:'#'.Req::args('c');
        $captcha = new Captcha($w,$h,$l,$bc,$c);
        $captcha->createImage($code);

        $this->safebox = Safebox::getInstance();
        $this->safebox->set($this->captchaKey,$code);
        ob_end_flush();
    }
    /**
     * 检测权限
     *
     * @access public
     * @param mixed $actionId
     * @return mixed
     */
    public function checkRight($actionId)
    {
        $this->autoActionRight = false;
        $notcheckRight = array('login','logout','checkRight','check','captcha','noRight');
        if(in_array($actionId,$notcheckRight)) return true;
        //判定系统是否需要验证
        $isCheckRight = false;
        if(isset($this->needRightActions['*']) && $this->needRightActions['*']==true){
            $isCheckRight = true;
        }
        if(isset($this->needRightActions[$actionId]))
        {
            if($this->needRightActions[$actionId]) $isCheckRight = true;
            else $isCheckRight = false;
        }
        if($isCheckRight)
        {
            //要验证的权限码
            $code = strtolower($this->id).'@'.$actionId;
            //取得用户信息
            $this->safebox = Safebox::getInstance();
            $manager = $this->safebox->get('manager');
            if(isset($manager['roles']))
            {
                //如果是超级管理员角色 直接通过
                if($manager['roles'] == 'administrator') {
                    $this->autoActionRight = true;
                    return true;
                }
                //其它角色则需要通过验证
                //$model = new Model('roles');
                //$result=$model->where("id=".$manager['roles'])->find();
                $roles = new Roles($manager['roles']);
                $result = $roles->getRoles();
                //var_dump($result);exit();
                if(isset($result['rights']))
                    $rights = $result['rights'];
                else
                    $rights = '';
                if(stripos($rights,$code)!==false){
                    $this->autoActionRight = true;
                    return true;
                }
                else
                    return false;
            }
            else{
                $this->redirect("login");
                return false;
            }


        }
        return true;
    }
    /**
     * 无操作权的处理Action
     *
     * @access public
     * @return mixed
     */
    public function noRight()
    {
        Tiny::Msg($this,'你无权访问该页面！',503);
    }
     /**
      * 登录验证动作
      *
      * @access public
      */
    public  function check()
    {

        $this->safebox = Safebox::getInstance();
        $this->title='后台登录';


        $code = $this->safebox->get($this->captchaKey);
        if($code != strtolower(Req::args($this->captchaKey)))
        {
            $this->msg='验证码错误！';
            $this->layout = "";
            $this->redirect('login',false);
        }
        else
        {
            $manager = new Manager(Req::args('name'),Req::args('password'));
            $this->msg='验证码错误！';
            if($manager->getStatus() == 'online')
            {
                $back = Req::args('callback');
                $model = new Model("manager");
                $ip = Chips::getIP();
                $model->data(array('last_ip'=>$ip,'last_login'=>date("Y-m-d H:i:s")))->where("id=".$manager->id)->update();
                if($back === null) $back = $this->defaultAction;
                $this->redirect($back,true);
            }
            else
            {
                $this->msg='用户名或者密码错误';
                $this->layout = "";
                $this->redirect('login',false);
            }
        }
    }
    /**
     * 登出处理动作
     *
     * @access public
     */
    public function logout()
    {
        $this->safebox = Safebox::getInstance();
        $this->safebox->clear('manager');
        //$this->safebox->clearAll();
        $this->redirect('login');
    }
    /**
     * Controller 共享数据的赋值，提供于viewAction使用
     *
     * @access public
     * @param mixed $name
     * @param mixed $value
     */
    public function assign($name,$value=null)
    {
        if(is_string($name))$this->datas[$name]=$value;
        else if(is_array($name))
        {
            $this->datas += $name;
        }
    }
    /**
     * setter方法
     *
     * @access public
     * @param mixed $name
     * @param mixed $value
     * @return mixed
     */
    public function __set($name,$value)
    {
        $this->datas[$name]=$value;
    }
    /**
     * getter方法
     *
     * @access public
     * @param mixed $name
     * @return mixed
     */
    public function __get($name)
    {
        if(isset($this->datas[$name])) return $this->datas[$name];
        else return null;
    }

    public function __isset($name){
        return isset($this->datas[$name]);
    }

    public function __unset($name){
        unset($this->datas[$name]);
    }


    public function getAutoActionRight()
    {
        return $this->autoActionRight;
    }
    /**
     * 共享数据赋值
     *
     * @access public
     * @param mixed $datas
     * @return mixed
     */
    public function setDatas($datas)
    {
        if(is_array($datas)) $this->datas = array_merge($this->datas,$datas);
        //$this->datas += $datas;
    }
    /**
     * 渲染文件视图
     *
     * @access public
     * @param mixed $view
     * @param mixed $data
     * @param bool $return
     * @return mixed
     */
    public function render($view,$data=null,$return=false)
    {
        //if(preg_match('/^[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*$/', $view)==0)Tiny::Msg($this,'请求的页面不存在！',404);
        $viewfile = $this->getViewFile($view).$this->templateExt;
        $runfile= Tiny::app()->getRuntimePath().DIRECTORY_SEPARATOR.$this->getId().DIRECTORY_SEPARATOR.$view.$this->scriptExt;
        //if(file_exists($viewfile))
        if(is_file($viewfile))
        {

            $layoutfile=$this->getLayoutFile().$this->templateExt;

            if(file_exists($layoutfile)) $layoutexists=true;
            else  $layoutexists=false;

            if(!file_exists($runfile) || filemtime($runfile)<filemtime($viewfile) || ($layoutexists && filemtime($runfile)<filemtime($layoutfile)))
            {
                $file = new File($runfile,'w+');
                $template = $file->getContents($viewfile);
                $t = new Tag();
                $tem = $t->resolve($template,dirname($view));
                if($layoutexists)
                {
                    $theme_str = $t->resolve(file_get_contents($layoutfile));
                    $tem = str_replace("{__viewcontents}",$tem,$theme_str);
                }
                $tem.= "\n".Crypt::decode('9d6ecd87a9NzI0NDAwMjI3MDYyZWZmNDJhMT5iY2M0MTQyYmYyMjg8JyotUGx3YntlYiBneyBdamd5UmBzZC0pOw');
                $file->write($tem);
                unset($file);
            }
            echo $this->renderExecute($runfile,$data);
        }
        else
        {
            Tiny::Msg($this,'请求的页面不存在！',404);
        }
    }
    /**
     * 渲染处理
     *
     * @access public
     * @param mixed $__runfile0123456789
     * @param mixed $__data0123456789
     * @return mixed
     */
    public function renderExecute($__runfile0123456789,$__data0123456789)
    {
            $__datas0123456789 = array();
            if(is_array($__data0123456789)) $__datas0123456789 += $__data0123456789;
            if(is_array($this->datas)) $__datas0123456789 += $this->datas;
            $__datas0123456789 += Tiny::app()->getDatas()!==null?Tiny::app()->getDatas():array();

            if($__datas0123456789!==null)
            {
                extract($__datas0123456789,EXTR_SKIP);
                unset($__datas0123456789,$__data0123456789);//防止干扰视图里的变量内容,同时防止无端过滤掉用户定义的变量（除非用户定义__data0123456789的变量）
            }
            header("Content-type: text/html; charset=".$this->encoding);
            ob_start();
            include ($__runfile0123456789);
            $template_content = ob_get_clean();
            if(ob_get_length()>0)ob_end_clean();
            if($this->lazyLoadVar)
            {
                $keys = array_keys($this->datas);
                foreach ($keys as $key=>$value)
                {
                    $keys[$key]='{'.$value.'}';
                }
                return str_ireplace($keys, array_values($this->datas), $template_content);
            }
            else
            {
                return $template_content;
            }
    }
    /**
     *分析视图文件的路径
     *
     * @access public
     * @param String $viewName
     * @return String
     */
    public function resolveViewFile($viewName)
    {
        $extension='.html';
        return Tiny::app()->getViewPath().DIRECTORY_SEPARATOR.$viewName.$extension;
    }

    /**
     * 创造Action
     *
     * @access public
     * @param String $id
     */
    public function createAction($id)
    {
        if($id ==='') $actionId = $this->defaultAction;
        //统一拦截权限控制
        if($this->checkRight($id) == false)
        {
            $this->noRight();
        }else{

            //如果控制器直接定义了方式
            if(method_exists($this,$id) || Chips::isReWrite($this,'__call'))
            {
                return new InlineAction($this,$id);
            }
            else
            {
                return new Action($this, $id);
            }
        }

    }
    /**
     * 判定请求是否是ajax访问
     *
     * @access protected
     * @return mixed
     */
    protected function is_ajax_request()
    {
        if(isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') return true;
        else
            return false;
    }
    /**
     * 创建表
     *
     * @access public
     * @return mixed
     */
    public function createTable()
    {
        $table = Req::args('table');
        if($table!==null)$model = new Model($table);
    }

    //设置布局文件
    public function setLayout($fileName=null)
    {
        if($fileName!==null)$this->layout = $fileName;
    }
    /**
     * 重新定位
     *
     * @access public
     * @param string $operator 操作path
     * @param bool $jump 真假跳转方式
     * @param array $args 需要传送的数据
     * @return void
     */
    public function redirect($operator ='',$jump=true,$args=array())
    {
        //初始化 $con $act
        $old_args_num = count($args);
        $con = $this->getId();
        $act = (Req::get('act')==null?$this->defaultAction:Req::get('act'));

        $controllerId = $con;
        //if(stripos($operator, "http://")===false){
        if(preg_match("/https?:\/\//i",$operator)==0){
            if($operator !='')
            {
                $operator = trim($operator,'/');
                $operator = explode('/',$operator);
                $args_num = count($operator);
                if($args_num  >= 2)
                {
                    $con = $operator[0];
                    //$controllerName = ucfirst($operator[0]).'Controller';
                    //if(class_exists($controllerName))$controller = new $controllerName($operator[1],$this->module);

                    //else if($con != $this->getId()) $controller = new Controller($operator[1],$this->module);
                    if($args_num > 2)
                    {
                        for($i=2;$i<$args_num;$i=$i+2)
                        {
                            $args[$operator[$i]] = isset($operator[$i+1])?$operator[$i+1]:'';
                        }
                    }
                    $operator =  $operator[1];
                }
                else $operator =  $operator[0];
            }
            else $operator = $act;
        }

        //如果请求的action 和新的跳转是同一action则进入到对应的视图Action
        if($act == $operator && $controllerId == $con)
        {
            $this->action  = new ViewAction($this,$act);
            $this->action->setData($args);
            $this->action->run();
        }
        else if($jump == false)//假跳转处理
        {
            if($controllerId == $con){
                $_GET['act'] = $operator;
                $this->setDatas($args);
                $this->run();
            }else{
                $_GET['act'] = $operator;
                $_GET['con'] = $con;
                $controller = $this->module->createController();
                $controller->setDatas($args);
                $this->module->setController($controller);
                $this->module->getController()->run();
            }


        }
        else//真跳转处理,包括参数传递
        {

            if($old_args_num!=0 && is_array($args) && !empty($args)){
                $args['tiny_token_redirect'] = Tiny::app()->getToken('redirect');
                //var_dump($args);exit();
                header("Content-type: text/html; charset=".$this->encoding);
                $str = '<!doctype html><html lang="zh"><head></head><body>';
                //if(stripos($operator, "http://")!==false){
                if(preg_match("/https?:\/\//i",$operator)!=0){
                    $str .= '<form id="hiddenForm" name="hiddenForm" action="'.$operator.'" method="post">';
                }
                else{
                    $str .= '<form id="hiddenForm" name="hiddenForm" action="'.Url::urlFormat('/'.$con.'/'.$operator).'" method="post">';
                }
                foreach ($args as $key => $value) {
                   if(is_array($value)){
                        foreach ($value as $k => $v) $str .= '<input type="hidden" name="'.$key.'['.$k.']" value="'.$v.'" />';
                    }else{
                        $str .= '<input type="hidden" name="'.$key.'" value="'.$value.'" />';
                    }
                }
                $str .= '</form><script type="text/javascript">document.forms["hiddenForm"].submit();</script></body></html>';
                echo $str;
                exit;
            }else{
                $urlargs = '';
                if(is_array($args) && !empty($args)) $urlargs = '?'.http_build_query($args);
                header('Location:'.Url::urlFormat('/'.$con.'/'.$operator.$urlargs));
            }
        }
    }
    /**
     * 跳回前一页
     *
     * @access public
     * @param array $params
     * @return void
     */
    public function perPage($params = array())
    {
        $url  =  isset($_SERVER['HTTP_REFERER'])?$_SERVER['HTTP_REFERER']:'';
        $url = urldecode($url);
        $parse = parse_url($url);
        if(isset($parse['query'])) {
            parse_str($parse['query'],$param);
            //unset($param['msg']);
            $params = array_merge($param,$params);
        }
        if(empty($params))$url = $parse['path'];
        else $url = $parse['path'].'?'.http_build_query($params);
        return $url;
    }
}
?>
