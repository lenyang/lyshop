<?php
/**
 * 一些小方法的封装
 *
 * @author Crazy、Ly
 * @class Chips
 */
class Chips
{
	/**
	 * 取得IP
	 *
	 * @access public
	 * @return String
	 */
	public static function getIP()
	{
		if (isset($_SERVER["HTTP_X_FORWARDED_FOR"]))$ip = $_SERVER["HTTP_X_FORWARDED_FOR"];
		elseif (isset($_SERVER["HTTP_CLIENT_IP"])) $ip = $_SERVER["HTTP_CLIENT_IP"];
		elseif (isset($_SERVER["REMOTE_ADDR"])) $ip = $_SERVER["REMOTE_ADDR"];
		elseif (getenv("HTTP_X_FORWARDED_FOR")) $ip = getenv("HTTP_X_FORWARDED_FOR");
		elseif (getenv("HTTP_CLIENT_IP")) $ip = getenv("HTTP_CLIENT_IP");
		elseif (getenv("REMOTE_ADDR")) $ip = getenv("REMOTE_ADDR");
		else $ip = "Unknown";
		if(!Validator::ip($ip)) $ip = 'Unknown';
		return $ip;
	}
	/**
	 * 取得整数IP
	 *
	 * @access public
	 * @param string $ip ip地址
	 * @return int
	 */
	public static function getIntIp($ip='')
	{
		if($ip=='')$ip = self::getIp();
		return sprintf("%u",ip2long($ip));
	}
	/**
	 * 10进制转其它进制
	 *
	 * @access public
	 * @param String $dec 十进制数据
	 * @param String $toRadix 要转换的进制
	 * @return String
	 */
	public static function  dec2Any($dec, $toRadix) {
		$MIN_RADIX = 2;
		$MAX_RADIX = 62;
		$num62 = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		if ($toRadix < $MIN_RADIX || $toRadix > $MAX_RADIX) {
			$toRadix = 2;
		}
		if ($toRadix == 10) {
			return $dec;
		}
		$buf = array();
		$charPos = 64;
		$isNegative = $dec < 0;
		if (!$isNegative) {
			$dec = -$dec;
		}
		while (bccomp($dec, -$toRadix) <= 0) {
			$buf[$charPos--] = $num62[-bcmod($dec, $toRadix)];
			$dec = bcdiv($dec, $toRadix);
		}
		$buf[$charPos] = $num62[-$dec];
		if ($isNegative)
		{
			$buf[--$charPos] = '-';
		}
		$_any = '';
		for ($i = $charPos; $i < 65; $i++)
		{
			$_any .= $buf[$i];
		}
		return $_any;
	}
	/**
	 * 其它进制转10进制
	 *
	 * @access public
	 * @param String 要转换的数据
	 * @param String $fromRadix 来自己那种进制
	 * @return int 十进制数据
	 */
	public static function  any2Dec($number, $fromRadix) {
		$num62 = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$dec = 0;
		$digitValue = 0;
		$len = strlen($number) - 1;
		for ($t = 0; $t <= $len; $t++) {
			$digitValue = strpos($num62, $number[$t]);
			$dec = bcadd(bcmul($dec, $fromRadix), $digitValue);
		}
		return $dec;
	}
	/**
	 * 取得客户端类型
	 * @param  String $ua 要分析的字符串数据
	 * @return String     类型 tablet 平板 mobile 手机 desktop PC机
	 */
	public static function clientType($ua=null)
	{
		if(!is_string($ua))$ua = $_SERVER['HTTP_USER_AGENT'];
		$ua = strtolower($ua);
		$mobile = strstr($ua, 'mobile');
		$android = strstr($ua, 'android');
		$windowsPhone = strstr($ua, 'phone');

		$androidTablet = $android && !$mobile;
		$ipad = strstr($ua, 'ipad');

		if($androidTablet || $ipad){
			return 'tablet';
		}
		elseif($mobile && !$ipad || $android && !$androidTablet || $windowsPhone){
			return 'mobile';
		}
		else{
			return 'desktop';
		}
	}

	/**
	 * 判定类方法是否重写
	 * @author TinyNing
	 * @date   2015-12-10
	 * @param  object     $class  类
	 * @param  string     $method 方法名
	 * @return boolean    true false -1存在此方法，父类不存在 -2 都不存在 -3 不存在父类
	 */
	public static function isReWrite($class,$method)
	{
		$parent = get_parent_class($class);
		if($parent){
			$methodes = get_class_methods($class);
			$parentMethodes = get_class_methods($parent);
			$parentIndex = array_search($method,$parentMethodes);
			if($parentIndex!==false){
				$index =  count($methodes) - count($parentMethodes) + $parentIndex;
				return !($methodes[$index] == $method);
			}else{
				$index = array_search($method,$methodes);
				if($index !== false) return -1;
				else return -2;
			}
		}else{
			return -3;
		}
	}
}
