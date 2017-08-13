<?php
/**
 * Action 基类
 * 
 * @author Crazy、Ly
 * @class BaseAction
 */
class BaseAction
{
	//Action的ID
	protected $id;
	//所属控制器
	protected $controller;
	//action接收数据的接口
	private $datas = array();
    /**
     * Action类的数据共享
     * 
     * @access public
     * @param mixed $data 数据
     * @return void
     */
	public function setData($datas)
	{ 
        if(is_array($datas)) $this->datas = array_merge($this->datas,$datas);
	}
    /**
     * 取得Action的共享数据,可以在渲染的view直接使用
     * 
     * @access public
     * @return array
     */
	public function getData()
	{
		return $this->datas;
	}
    /**
     * action的构造函数
     * 
     * @access public
     * @param Controller $controller  控制器 
     * @param String $id Action ID
     */
	public function __construct($controller,$id)
	{
		$this->controller=$controller;
		if(isset($controller->layout))$controller->setLayout($controller->layout);
		$this->setData($controller->datas);
		$this->id=$id;
	}
    /**
     * 得到当前的控制器
     * 
     * @access public
     * @return Controller
     */
	public function getController()
	{
		return $this->controller;
	}
    /**
     * 取得Action的ID
     * 
     * @access public
     * @return String 
     */
	public function getId()
	{
		return $this->id;
	}
}
