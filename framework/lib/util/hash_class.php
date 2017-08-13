<?php
  /**
   * 实现系统中常用的散列
   *
   * @author Crazy、Ly
   * @class CHash
   */
class CHash
{
    /**
     * @brief 调用系统的CRC32系统函数
     * @param String $str
     * @return int
     * @note 此方法不利于存放散列
     */
    public static function crc($str)
    {
        return crc32($str);
    }
     /**
      * @brief 自定时间格式散列，书写与date()函数相同 当$rand 为false时生成format的散列，为true时生成format+5位随机数的散列,这也是默认方式
      * @param string $format 默认是 Y/m/d/His
      * @param bool $rand true加5位随机数，false 不加随机数 默认为true
      * @return String
      */
    public  function time($format='Y/m/d/His', $rand=true)
    {
        if($rand) return date($format).rand(10000,99999);
        else return date($format);

    }
    /**
     * @brief 随机生成字符串函数
     * @param int $len 要生成的长度
     * @param string $type 生成字符串的类型
     * @return String 随机生成字符
     */
	public static function random($len=6,$type='mix')
	{
        $len = intval($len);
		if($len >90) $len = 90;
		$str = '';
        switch ($type) {
            case 'int':
                $templet = '012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789';
                break;
            case 'lowchar':
                $templet = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijkl';
                break;
            case 'upchar':
                $templet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKL';
                break;
            case 'char':
                $templet = 'abcdefghijklmnopqrstuvwxyz0123456789abcdefghijklmnopqrstuvwxyzamwz0379bhklqdklg482156smyew';
                break;
            default:
                $templet = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*()_+-=[]{}:";<>,.?|';
                break;
        }
        $start = mt_rand(1, (90-$len));
        $string = str_shuffle($templet);
        return substr($string,$start,$len);
	}
    /**
     * @brief 调用系统的MD5散列方式
     * @param String $str
     * @return String
     */
    public  static function md5($str,$validcode=false)
    {
        if($validcode){
            $key = md5($validcode);
            $str = substr($key,0,16).$str.substr($key,16,16);
        }
        return md5($str);
    }
    /**
     * @brief 文件的MD5计算
     * @param mixed $fileName
     * @return String
     */
    public  function md5_file($fileName)
    {
        return md5_file($fileName);
    }
    /**
     * @brief 根据$str进行散列到给定的$array数组资源上;
     * @param mixed $array
     * @param String $str
     * @return mixed
     */
    public  function hash($array, $str)
    {
        $len = count($array);
        $key = abs(crc32($str)) % $len;
        return $array[$key];
    }
    public function crcPath($key)
    {
    	$num=crc32($key);
		$num = sprintf('%u',$num);
		$index=($num%1024)."/".(($num>>=10)%1024)."/".($num>>=10)."/";
		return $index;
    }
    /**
     * 生成UUID唯一值
     * @return String 格式 xxxxxxx-xxxx-xxxx-xxxxxx-xxxxxxxxxx
     */
    public function uuid()
    {
        mt_srand((double)microtime()*10000);
        $charid = strtoupper(md5(uniqid(rand(), true)));
        $linkChar = chr(45);
        $uuid = substr($charid, 0, 8).$linkChar
            .substr($charid, 8, 4).$linkChar
            .substr($charid,12, 4).$linkChar
            .substr($charid,16, 4).$linkChar
            .substr($charid,20,12);
        return $uuid;
    }
    /**
     * @brief 当你的php版本大于5.1.2时，可以调用md系列、sha系列、haval系列、tiger系列、ripemd系列、CRC系列等等的散列方法，详见PHP手册
     * @param String $method 散列名
     * @param mixed $str 需要处理的字符串
     * @return String
     * @note 注意如果PHP版本低于5.1.2时，散列将自动切换成MD5；
     */
    public function __call($method, $str)
    {
        if(strcasecmp(PHP_VERSION,'5.1.2')>=0)
        {
            $keys = array_flip(hash_algos());
            if(isset($keys[$method])) return hash($method,$str[0]);
        }
        else
        {
            return md5($str[0]);
        }
    }
}
?>
