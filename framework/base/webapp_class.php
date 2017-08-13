<?php
/**
 * web应用类
 *
 * @author Crazy、Ly
 * @class WebApp
 */
class WebApp extends App
{
	//应用对应的控制器
	public $defaultController = 'index';
	//主要布局
	public $layout = 'index';
	//控制器明映射
	public $controllerMap=array();
	//控制器路径
	private $controllerPath;
	//视图路径
	private $viewPath;
	//布局路径
	private $layoutPath;
	//控制器
	public $controller;
	//主题
	private $theme;
	//皮肤
	private $skin;
	//共存数据
	private $datas = array();
	//请求堆栈
    private static $requestStack=array();
    /**
     * 构造函数
     *
     * @access public
     * @param mixed $config
     */
	public function __construct($config=null)
	{
		parent::__construct($config);
	}
    /**
     * 压入堆栈
     *
     * @access public
     * @param mixed $key
     * @return void
     */
	public function pushRequestStack($key)
	{
		self::$requestStack[$key] = $key;
	}
    /**
     * 取出堆栈的内容
     *
     * @access public
     * @param mixed $key
     * @return mixed
     */
	public function popRequestStack($key)
	{
		if(isset(self::$requestStack[$key])) return self::$requestStack[$key];
		else false;
	}
    /**
     * 修改当前的控制器
     *
     * @access public
     * @param mixed $controller
     * @return mixed
     */
	public function setController($controller)
	{
		$this->controller = $controller;
	}
    /**
     * 取得当前的控制器
     *
     * @access public
     * @return mixed
     */
	public function getController()
	{
		return $this->controller;
	}
    /**
     * 处理所有请求
     *
     * @access public
     * @return mixed
     */
	public function doRequest()
	{
		Url::urlReWrite();
		$this->runController();
	}
    /**
     * 创建控制器
     *
     * @access public
     * @return mixed
     */
	public function createController()
	{
		$controllerName = Req::args('con')!==null?ucfirst(Req::args('con')):$this->defaultController;
		$controllerClass = $controllerName.'Controller';
		$widgetClass = $controllerName.'Widget';

		if(class_exists($controllerClass))
		{
			return new $controllerClass(strtolower($controllerName),$this);
		}
		else if(class_exists($widgetClass))
		{
			return new $widgetClass($controllerName,$this);
		}
		else if(Tiny::getErrorsController()!==null)
		{
			$errorsController = Tiny::getErrorsController();
			return $errorsController;
		}
		else
		{
			return new Controller($controllerName,$this);
		}
	}
    /**
     * 运行控制器
     *
     * @access public
     * @return mixed
     */
	public function runController()
	{

		$this->controller = $this->createController();
		$this->controller->run();

	}
     /**
      * 取得当前主题类
      *
      * @access public
      * @return mixed
      */
	public function getTheme()
	{
		if(is_string($this->theme)) $this->theme = $this->getThemeManager()->getTheme($this->theme);
		return $this->theme;

	}
     /**
      * 设定主题的名称
      *
      * @access public
      * @param mixed $value
      * @return mixed
      */
	public function setTheme($value)
	{
		$this->theme = $value;
	}
    /**
     * 设定皮肤的名称
     *
     * @access public
     * @param mixed $skin
     * @return mixed
     */
	public function setSkin($skin)
	{
		$this->skin = $skin;
	}
    /**
     * 取得皮肤
     *
     * @access public
     * @return mixed
     */
	public function getSkin()
	{
		return $this->skin;
	}

     /**
      * 取得主题管理类
      *
      * @access public
      * @return mixed
      */
	public function getThemeManager()
	{
		return ThemeManager::getInstance();
	}
    /**
     * 得到视图路径
     *
     * @access public
     * @return mixed
     */
	public function getViewPath()
	{
		if($this->viewPath !== null) return $this->viewPath;
		else return $this->viewPath = $this->getBasePath().DIRECTORY_SEPARATOR.'views';
	}
    /**
     * 得到布局路径
     *
     * @access public
     * @return mixed
     */
	public function getLayoutPath()
	{
		$this->getViewPath().DIRECTORY_SEPARATOR.'layouts';
	}
    /**
     * 最得数据
     *
     * @access public
     * @param mixed $name
     * @return mixed
     */
	public function getDatas($name=null)
	{
		if($name ===null) return $this->datas;
		else if(isset($this->datas[$name])) return $this->datas[$name];
	}
    /**
     * 设定数据,app中可访问的
     *
     * @access public
     * @param mixed $name
     * @param string $value
     * @return mixed
     */
	public function setDatas($name,$value='')
	{
		if(is_array($name)) $this->datas = array_merge($this->datas,$name);
		else $this->datas[$name] = $value;
	}
    /**
     * 创建令牌
     *
     * @access public
     * @param string $key
     * @return mixed
     */
	public function getToken($key=''){
		$key = "tiny_token_".$key;
		$token = Session::get($key);
		if($token == null || strlen($token)!=32){
			$token = CHash::random(32,'char');
			Session::set($key,$token);
		}
		return $token;
	}

    /**
     * 验证令牌并销毁
     *
     * @access public
     * @param string $key
     * @return mixed
     */
	public function checkToken($key='')
	{
		$key = "tiny_token_".$key;
		$token = Req::args($key);
		$rel_token = Session::get($key);
		Session::clear($key);
		return ($token !=null && $token==$rel_token);
	}

}
