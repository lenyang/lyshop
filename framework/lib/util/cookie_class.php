<?php
 /**
  * Cookie封装类
  * 
  * @author Crazy、Ly
  * @class Cookie
  */
class Cookie
{
	private static $per = 'Tiny_';
	private static $safeCode;
	private static $safeLave = 0;
    /**
     * 设置安全码
     * 
     * @access public
     * @param string $scode
     * @return mixed
     */
	public static function setSafeCode($scode='')
	{
		self::$safeCode = $scode.self::cookieId();
	}
    /**
     * 取得安全码
     * 
     * @access public
     * @return mixed
     */
	public static function getSafeCode()
	{
		if(self::$safeCode == '')self::setSafeCode();
		return self::$safeCode;
	}
    /**
     * 设置cookie值
     * 
     * @access public
     * @param mixed $name
     * @param string $value
     * @param string $time
     * @param string $path
     * @param mixed $domain
     * @return mixed
     */
	public static function set($name,$value='',$time='86400',$path='/',$domain=null)
	{
		if($time<=0) $time = -3600;
		else $time = time() + $time;
		
		setCookie('safecode',self::cookieId(),$time,$path,$domain);
		
		if(is_array($value) || is_object($value)) $value=serialize($value);
		$value = Crypt::encode($value,self::getSafeCode());
		setCookie(self::$per.$name,$value,$time,$path,$domain);
	}
    /**
     * 取得cookie值
     * 
     * @access public
     * @param mixed $name
     * @return mixed
     */
	public static function get($name)
	{
		if(self::checkSafe()==1)
		{
			if(isset($_COOKIE[self::$per.$name]))
			{
				$cryptCookie = $_COOKIE[self::$per.$name];
				$cookie= Crypt::decode($cryptCookie,self::getSafeCode());
				$tem = substr($cookie,0,10);
				if(preg_match('/^[Oa]:\d+:.*/',$tem)) $cookie = unserialize($cookie);
				return $cookie;
			}
			return null;
		}
		if(self::checkSafe()==0) self::clear($name);// Tiny::msg('非法窃取COOKIE，系统将终止工作！',0);
		else return null;
	}
    /**
     * 清除cookie对应值
     * 
     * @access public
     * @param mixed $name
     * @return mixed
     */
	public static function clear($name)
	{
		self::set($name,'',0);
	}
    /**
     * 清空所有
     * 
     * @access public
     * @return mixed
     */
	public static function clearAll()
	{
	}
    /**
     * 安全码
     * 
     * @access private
     * @return mixed
     */
	private static function checkSafe()
	{

		if(isset($_COOKIE['safecode']))
		{
			if($_COOKIE['safecode']==self::cookieId())
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
    /**
     * cookie ID身份认证
     * 
     * @access private
     * @return mixed
     */
	private static function cookieId()
	{
		if(self::$safeLave==0)return 1;
		if(self::$safeLave==1) return md5(Chips::getIP());
		if(self::$safeLave==2) return md5(Chips::getIP().$_SERVER["HTTP_USER_AGENT"]);
	}
}
?>
