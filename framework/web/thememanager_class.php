<?php
/**
 * 主题管理类
 * 
 * @author Crazy、Ly
 * @class ThemeManager
 */
class ThemeManager
{
	const THEMES='themes';

	private static $obj;

	private $theme = 'Theme';

	private $basePath;

	private $baseUrl;

	private function __construct()
	{
	}

	private function __clone()
	{
	}
    /**
     * 取得实例
     * 
     * @access public
     * @return mixed
     */
	public static function getInstance()
	{
		if(!self::$obj instanceof self)
		{
			self::$obj = new self();
		}
		return self::$obj;
	}
    /**
     * 得到主题
     * 
     * @access public
     * @param mixed $name
     * @return mixed
     */
	public function getTheme($name)
	{
		$themePath = $this->getBasePath().DIRECTORY_SEPARATOR.$name;
		$className = $this->theme;
		if(is_dir($themePath)) return new $className($name,$themePath,$this->getBaseUrl().'/'.$name);
		else return null;
	}
    /**
     * 取得所有主题
     * 
     * @access public
     * @return mixed
     */
	public function getThemes()
	{
	}
	/**
	 * 得到主题存在的要目录
	 */
	public function getBasePath()
	{
		if($this->basePath === null) $this->setBasePath(APP_ROOT.DIRECTORY_SEPARATOR.self::THEMES);
		return $this->basePath;
	}
    /**
     * 设定主题路径
     * 
     * @access public
     * @param mixed $path
     * @return mixed
     */
	public function setBasePath($path)
	{
		$this->basePath = realpath($path);
	}
    /**
     * 获得主题路径URL
     * 
     * @access public
     * @return mixed
     */
	public function getBaseUrl()
	{
		if($this->baseUrl === null ) $this->setBaseUrl(APP_URL.self::THEMES);
		return $this->baseUrl;
	}
    /**
     * 设置主题路径URL
     * 
     * @access public
     * @param mixed $baseUrl
     * @return mixed
     */
	public function setBaseUrl($baseUrl)
	{
		$this->baseUrl = $baseUrl;
	}
}
