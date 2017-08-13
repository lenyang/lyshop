<?php
/**
 * 错误处理类
 *
 * @author Crazy、Ly
 * @class TError
 */
class TError
{
	private $data;
	private $code;
	private $sender;
	private $message;
    /**
     * 构造函数
     *
     * @access public
     * @param mixed $sender
     * @param mixed $message
     * @param mixed $code
     * @param array $data
     */
	public function __construct($sender,$message,$code,$data=array())
	{
		$this->code = $code;
		$this->sender =$sender;
		$this->message = $message;
		$this->data = $data;
		$this->data['message']=$message;
		$this->data['code']=$code;
	}
    /**
     * 句柄
     *
     * @access public
     * @return mixed
     */
	public function handle()
	{
		//if(ob_get_length()>0)ob_end_clean();
		$this->handleError();
	}
    /**
     * 错误处理句柄
     *
     * @access public
     * @return mixed
     */
	public function handleError()
	{
		$this->render();
	}
    /**
     * 渲染
     *
     * @access protected
     * @return mixed
     */
	protected function render()
	{

		$errorsController = Tiny::getErrorsController();
		if($errorsController!==null){
			//由于用户自己定义错误处理
			try{
				if($this->code!==null){
					$_GET['act'] = 'error_'.$this->code;
					$errorsController->setDatas($this->data);
					Tiny::app()->setController($errorsController);
					$errorsController->run();
				}else{
					$_GET['act'] = 'error';
					$this->sysError();
				}

			}catch(Exception $e){
				//如果系统文件有错误 那么交由系统系统错误。
				$this->sysError();
			}
		}else{
			$this->sysError();
		}
	}
    /**
     * 系统级错误处理方式
     *
     * @access protected
     * @return mixed
     */
	protected function sysError()
	{

		extract($this->data);
		$__errorFile =$this->getViewFile($this->code);
		if(is_file($__errorFile)){
            include($__errorFile);
        }
		else{
			echo $this->message;
			exit;
		}
		exit;
	}
    /**
     * 取得对应的错误处理文件
     *
     * @access protected
     * @param mixed $code
     * @return mixed
     */
	protected function getViewFile($code)
	{
		$viewPaths=array(
			Tiny::app()==null ? null :  Tiny::app()->getLayoutPath(),TINY_ROOT.'views'
		);
		foreach($viewPaths as $i=>$viewPath){
			if($viewPath!==null){
				$viewFile=$viewPath.DIRECTORY_SEPARATOR.'error_'.$code.'.php';
				 if(is_file($viewFile))return $viewFile;
				 $viewFile=$viewPath.DIRECTORY_SEPARATOR.'error.php';
				 if(is_file($viewFile))return $viewFile;
			}
		}
	}
}
