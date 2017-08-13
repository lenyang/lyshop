<?php
/**
 * 插件类
 * 
 * @author Crazy、Ly
 * @class Widget
 */
class Widget extends Object
{
    protected $encoding='UTF-8';
    public $cache;
    public $cacheTime;
    private $action;
    private $id;
    /**
     * 构造函数
     * 
     * @access public
     * @param string $id
     * @return mixed
     */
    public function __construct($id='widget')
    {
        $this->id = $id;
    }
    /**
     * 初始化
     * 
     * @access public
     * @return mixed
     */
    public function init()
    {
    }
    /**
     * 执行函数
     * 
     * @access public
     * @return mixed
     */
    public function run()
    {
        
        $method = $this->getAction();
        $args = $this->args;
        if($this->cache == "true"){
            $cache = CacheFactory::getInstance();
            $content = $cache->get($method.$args);
            if($content===null){
                ob_start();
                ob_implicit_flush(false);
                $this->doMethod($method,$args);
                $content = ob_get_clean();
                $cache->set($method.$args,$content,intval($this->cacheTime));
            }
            echo $content;
        }
        else $this->doMethod($method,$args);
            
    }
    /**
     * 执行方法
     * 
     * @access global
     * @param mixed $method
     * @param mixed $args
     * @return mixed
     */
    function doMethod($method,$args)
    {
        if(method_exists($this,$method)){
            if($args===null)$this->$method();
            else $this->$method($args);
        }
        else{
            $className = $this->id;
            $this->renderFile("$className/$method",$this->output);
        }
    }
    /**
     * 设置action
     * 
     * @access public
     * @param mixed $action
     * @return mixed
     */
    public function setAction($action)
    {
        $this->action = $action;
    }
    /**
     * 取得action
     * 
     * @access public
     * @return mixed
     */
    public function getAction()
    {
        if($this->action===null){
            $action = Req::args('act')==null?'index':Req::args('act');
            $this->setAction($action);
        }
        return $this->action;
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
     * 取得视图文件
     * 
     * @access public
     * @param mixed $viewName
     * @return mixed
     */
    public function getViewFile($viewName)
    {
        if(($theme = Tiny::app()->getTheme())!==null){
            $viewFile = $theme->getBasePath().DIRECTORY_SEPARATOR.'widgets'.DIRECTORY_SEPARATOR.$viewName.'.html';
            if(file_exists($viewFile))return $viewFile;
        }
        return APP_CODE_ROOT.'widgets/'.$viewName.'.html';
    }
    /**
     * 渲染视图
     * 
     * @access public
     * @param mixed $viewFile
     * @param bool $return
     * @return mixed
     */
    public function renderFile($viewFile,$return=false)
    {
        $content=$this->renderInternal($viewFile,$return);
        return $content;
    }
    /**
     * 渲染
     * 
     * @access public
     * @param mixed $viewFile
     * @param bool $return
     * @return mixed
     */
    public function renderInternal($viewFile,$return=false)
    {
        
        $data = $this->properties;
        if(is_array($data)){
            extract($data,EXTR_PREFIX_SAME,'data');
        }
        $tplfile  = $this->getViewFile($viewFile);
        if(file_exists($tplfile)){
            $runfile= Tiny::app()->getRuntimePath().DIRECTORY_SEPARATOR.'widgets/'.$viewFile.'.php';
            if(!file_exists($runfile) || filemtime($runfile)<filemtime($tplfile)){
                $file = new File($runfile,'w+');
                $template = $file->getContents($tplfile);
                $t = new Tag();
                $tem = $t->resolve($template);
                $file->write($tem);
            }
            header("Content-type: text/html; charset=".$this->encoding);
            if($return){
                ob_start();
                ob_implicit_flush(false);
                require($runfile);
                return ob_get_clean();
            }
            else
                require($runfile);
        }
        else
        {
            /**
            if($this->id != Tiny::app()->getId()){
                 trigger_error("{$this->id}Widget->{$this->getAction()}() not exists",E_USER_ERROR);
            }
            **/
            //Tiny::msg('','无法找到请求的页面',404);
            return ;
        }
    }
    /**
     * 创建插件
     * 
     * @access public
     * @param mixed $className
     * @return mixed
     */
    public static function createWidget($className)
    {
        
        $classWidget = ucfirst($className);
        $classWidget .='Widget';
        if(class_exists($classWidget)) return new $classWidget($className);
        else return new Widget(strtolower($className));
    }

    /**
     * 共享数据的赋值，提供于Widget视图使用
     * 
     * @access public
     * @param mixed $name
     * @param mixed $value
     */
    public function assign($name,$value=null)
    {
        if(is_string($name))$this->properties[$name]=$value;
        else if(is_array($name)){
            $this->properties += $name;
        }
    }
}
