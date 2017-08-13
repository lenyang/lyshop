<?php
class Theme
{
	private $name;
	private $basePath;
	private $baseUrl;
	private $configInfo;

	public function __construct($name, $basePath, $baseUrl)
	{
		$this->name = $name;
		$this->basePath = $basePath;
		$this->baseUrl = $baseUrl;
	}

	public function getName()
	{
		return $this->name;
	}
	public function getBaseUrl()
	{
		return $this->baseUrl;
	}
	public function getBasePath()
	{
		return $this->basePath;
	}
	public function getViewPath()
	{
		return $this->getBasePath().DIRECTORY_SEPARATOR.'views';
	}

	public function getSkinPath()
	{
		return $this->getViewPath().DIRECTORY_SEPARATOR.'skins';
	}
	/**
	 *获得视图文件
	 */
	public function getViewFile($controller,$viewName)
	{
		return $this->getViewPath().'/'.$controller->getId().'/'.$viewName;
	}
	/**
	 *获得布展文件
	 */
	public function getLayoutFile($controller,$layoutName)
	{
		return $this->getViewPath().'/layouts/'.$layoutName;
	}

	/**
	 * 取得主题配制文件信息
	 * @return Array
	 */
	public function getConfigInfo()
	{
		if($this->configInfo!=null) return $this->configInfo;
		$theme_path = $this->getBasePath().DIRECTORY_SEPARATOR.'info.php';
        if(file_exists($theme_path)){
            $this->configInfo = include_once($theme_path);
        }else{
        	$this->configInfo = null;
        }
        return $this->configInfo;
	}
}
?>
