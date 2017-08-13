<?php
/**
 * Session类
 * @author Crazy、Ly
 * @class Session
 */
session_start();
/**
 * @brief Session
 * @class Session
 * @note
 */
class Session
{
	//session前缀
	private static $per='Tiny_';
	private static $safeLave = 0;
	//设定session
	public static function set($name,$value='',$time='1800',$path='/',$domain=null)
	{
		if(self::checkSafe()==-1) $_SESSION['safecode']=self::sessionId();
		$_SESSION[self::$per.$name]=$value;
	}
	//取得session
	public static function get($name)
	{
		if(self::checkSafe()==1){
			if(isset($_SESSION[self::$per.$name])){
				$session = $_SESSION[self::$per.$name];
				return $session;
			}else{
				return null;
			}
		}
		if(self::checkSafe()==0) self::clearAll($name);//Tiny::msg('非法窃取SESSION，系统将终止工作！',0);
		else return null;
	}
	//清空某一个Session
	public static function clear($name)
	{
		unset($_SESSION[self::$per.$name]);
	}
	//清空所有Session
	public static function clearAll()
	{
		return session_destroy();
	}
	//Session的安全验证
	private static function checkSafe()
	{
		if(isset($_SESSION['safecode']))
		{
			if($_SESSION['safecode']==self::sessionId())
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
		else
		{
			return -1;
		}
	}
	//得到session安全码
	private static function sessionId()
	{
		if(self::$safeLave==0)return 1;
		if(self::$safeLave==1) return md5(Chips::getIP());
		if(self::$safeLave==2) return md5(Chips::getIP().$_SERVER["HTTP_USER_AGENT"]);
	}
}
?>
