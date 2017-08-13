<?php
/**
 * 扩展集工厂类
 * 
 * @author Crazy、Ly
 * @class ExtensionFactory
 */
class ExtensionFactory
{
	private static $extFactory;
	private static $extConfig;
    /**
     * 设置配制信息
     * 
     * @access public
     * @param mixed $config
     * @return mixed
     */
	public static function setExtConfig($config)
	{
		if(is_array($config))self::$extConfig = $config;
	}
    /**
     * 取得工厂
     * 
     * @access public
     * @param mixed $name
     * @return mixed
     */
	public static function getFactory($name)
	{
		if(is_array(self::$extConfig) && isset(self::$extConfig[$name]))
		{
			if(!isset(self::$extFactory[$name]))
			{
				$Extension = new ExtensionCollection();
				if(is_array(self::$extConfig[$name]))
				{
					foreach(self::$extConfig[$name] as $ext)
					{
						if(class_exists($ext))$Extension->addExtension(new $ext());
						else throw new Exception($ext.' of '.$name.' does not exist' );
					}
				}
				else if(is_string(self::$extConfig[$name]))
				{
					$ext = self::$extConfig[$name];
					if(class_exists($ext))$Extension->addExtension(new $ext());
					else throw new Exception($ext.' of '.$name.' does not exist' );
				}
				self::$extFactory[$name]=$Extension;
				return $Extension;
			}
			else
			{
				return self::$extFactory[$name];
			}
		}
		return null;
	}
}
