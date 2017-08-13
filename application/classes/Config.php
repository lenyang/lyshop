<?php
class Config
{
	private static $system = array();
	private static $fileName = '';
	private static $change_flag = false;

	private static $obj;
	
	private function __construct(){}
	private function __clone(){}

	public static function getInstance()
	{
		if(!self::$obj instanceof self)
		{
			self::$fileName = APP_CODE_ROOT.'config/system.php';
			self::$system = require(self::$fileName);
            if(!is_array(self::$system)) self::$system = array();
			self::$obj = new self();
		}
		return self::$obj;
	}
    
    public function get($key)
    {
        if(isset(self::$system[$key])) return self::$system[$key];
        else return null;
    }
    
    public function set($key,$value)
    {
		if(!isset(self::$system[$key]) || self::$system[$key] != $value)
		{
			self::$change_flag = true;
			self::$system[$key] = $value;
		}
		
    }

	public function del($key)
	{
		if(isset(self::$system[$key])) unset(self::$system[$key]);
	}
    public function __destruct()
    {
		if(self::$change_flag)File::putContents(self::$fileName,'<?php return '.var_export(self::$system,true).';'); 
    }
}

