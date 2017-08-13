<?php
/**
 * 系统提供的CSS框架封装类
 * 
 * @author Crazy、Ly
 * @class CSS
 */
class CSS
{
    //框架设置信息
	private static $CSSPackages = array(
		'960'=>array(
		'960'=>'960/960.css',
		'960_24'=>'960/960_24_col.css',
		'reset'=>'960/reset.css',
		'fluid'=>'960/960_fluid.css'
		)
	);
	//已经创建的css文件
	private static $createfiles = array();
    /**
     * 运行时css的文件目录
     * 
     * @access public
     * @param mixed $name
     * @return mixed
     */
	public static function path($name)
	{
		return Tiny::app()->getRuntimePath().'/systemcss/'.$name.'/';
	}
    /**
     * 引入css文件有调用方法
     * 
     * @access public
     * @param mixed $package 框架包名
     * @param mixed $name 
     * @return String
     */
	public static function import($package,$name=null)
	{
		if(isset(self::$CSSPackages[$package]))
		{
			$file = null;
			$is_file = false;
			if(is_string(self::$CSSPackages[$package]))
			{
				$is_file = true;
				$file = self::$CSSPackages[$package];
			}
			else
			{
				$csspackage = self::$CSSPackages[$package];
				reset($csspackage);
				$file = current($csspackage);
			}
			if(!isset(self::$createfiles[$package]))
			{
				$file_path = $file;
				if(!$is_file)$file_path = dirname($file);
				if(!file_exists(Tiny::app()->getRuntimePath().'/systemcss/'.$file_path))
				{
					File::xcopy(TINY_ROOT.'/web/css/source/'.$file_path,Tiny::app()->getRuntimePath().'/systemcss/'.$file_path);
				}
				self::$createfiles[$package] = true;
			}
			$webcsspath = Tiny::app()->getRuntimeUrl().'/systemcss/';
			if($is_file || $name !==null)
			{
				if(isset(self::$CSSPackages[$package][$name]))return '<link rel="stylesheet" type="text/css" href="'.$webcsspath.self::$CSSPackages[$package][$name].'"/>';
				else return '';
			}
			else
			{
				$tmp = '';
				foreach(self::$CSSPackages[$package] as $file)
				{
					$tmp .= '<link rel="stylesheet" type="text/css" href="'.$webcsspath.$file.'"/>';
				}
				return $tmp;
			}
		}
		else return '';

	}
}
