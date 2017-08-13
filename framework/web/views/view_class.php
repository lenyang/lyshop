<?php
/**
 * 视图类
 * 
 * @author Crazy、Ly
 * @class View
 */
class View
{
	//url中接收view文件有参数名
	private $viewParam = 'view';
	//默认的视图文件
	private $defauleView = 'index';
	//view文件
	private $view;
	//viewPath
	private $viewPath;

	private $layout;
	private $tplfile;
    /**
     * 构造函数
     * 
     * @access public
     * @param mixed $tpl
     */
	public function __construct($tpl)
	{
		$this->tplfile = Tiny::app()->getRuntimePath().$tpl.'.php';
		if(!file_exists($this->tplfile) || filemtime($this->tplfile)<filemtime($tpl))
		{
			$file = new File($this->tplfile,'w+');
			$template = $file->getContents($tpl);
			$t = new Tag();
			$tem = $t->resolve($template);
			$file->write($tem);
		}
	}
    /**
     * 运行入口
     * 
     * @access public
     * @return mixed
     */
	public function run()
	{
		$this->resolveView($this->getRequestedView());
		$controller=$this->getController();
		if($this->layout!==null)
		{
			$layout=$controller->layout;
			$controller->layout=$this->layout;
		}

		if(!$event->handled)
		{
			if($this->renderAsText)
			{
				$text=file_get_contents($controller->getViewFile($this->view));
				$controller->renderText($text);
			}
			else
				$controller->render($this->view);
		}

		if($this->layout!==null)
			$controller->layout=$layout;
	}
    /**
     * 渲染视图
     * 
     * @access protected
     * @param mixed $viewPath
     * @return mixed
     */
	protected function resolveView($viewPath)
	{
		if(preg_match('/^\w[\w\.\-]*$/',$viewPath))
		{
			$view=strtr($viewPath,'.','/');
			if(!empty($this->basePath)) $view=$this->basePath.'/'.$view;
			if($this->getController()->getViewFile($view)!==false)
			{
				$this->view=$view;
				return;
			}
		}
	}
    /**
     * 取得请求视图文件
     * 
     * @access public
     * @return mixed
     */
	public function getRequestedView()
	{
		if($this->viewPath===null)
		{
			if(!is_null(Req::args($this->viewParam)))
				$this->viewPath=Req::args($this->viewParam);
			else
				$this->viewPath=$this->defaultView;
		}
		return $this->viewPath;
	}
    /**
     * 渲染数据
     * 
     * @access public
     * @param array $data
     * @return mixed
     */
	public function render($data=array())
	{
		extract($data);
		include ($this->tplfile);
	}
}
?>