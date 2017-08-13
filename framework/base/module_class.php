<?php
/**
 * 模块类
 * 
 * @author Crazy、Ly
 * @class Module
 */
abstract class Module extends Object
{
	//父模块
	private $parentModule;
	//此模块所拥有的子模块
	private $modules = array();
	//模块唯一标识
	private $id;
	//基本路径
	private $basePath;
	//构造函数
	public function __construct($id, $parent, $config=null)
	{
		$this->id = $id;
		$this->parentModule = $parent;
		if(is_string($config)) $config = require($config);
		if(isset($config['basePath']))
		{
			$this->setBasePath($config['basePath']);
			unset($config['basePath']);
		}
		$this->configure($config);
		Tiny::setPath($id,$this->getBasePath());
	}
    /**
     * 配制设置
     * 
     * @access public
     * @param mixed $config
     * @return mixed
     */
	public function configure($config)
    {
    	if(is_array($config))
    	{
    		foreach($config as $key=>$value) $this->$key=$value;
    	}
    }
    /**
     * 得到当前模块的ID
     * 
     * @access public
     * @return mixed
     */
	public function getId()
	{
		return $this->id;
	}
    /**
     * 设定当前模块的ID
     * 
     * @access public
     * @param mixed $id
     * @return mixed
     */
	public function setId($id)
	{
		$this->id = $id;
	}
	/**
     * 得到模块的基本路径
	 * 
	 * @access public
	 * @return mixed
	 */
	public function getBasePath()
	{
		return $this->basePath;
	}
    /**
     * 设定模块的基本路径
     * 
     * @access public
     * @param mixed $basePath
     * @return mixed
     */
	public function setBasePath($basePath)
	{
		$this->basePath = $basePath;
	}
    /**
     * 得到模块的父模块
     * 
     * @access public
     * @return mixed
     */
	public function getParentModule()
	{
		return $this->parentModule;
	}
    /**
     * 查询模块是否包含对应的子模块
     * 
     * @access public
     * @param mixed $id
     * @return mixed
     */
	public function hasModule($id)
	{
		return isset($this->modules[$id]);
	}
    /**
     * 根据模块id取得对应的子模块
     * 
     * @access public
     * @param mixed $id
     * @return mixed
     */
	public function getModule($id)
	{
		if($this->hasModule($id)) return $this->getModule();
		else if(isset($this->parentModule)) return $this->parentModule->__get($id);
		else false;
	}
}