<?php
/**
 * 验证检测类
 *
 * @author Crazy、Ly
 * @class Validator
 */
class Validator
{
	/**
     * @brief Email格式验证
     * @param string $str 需要验证的字符串
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function email($str='')
    {
        return (bool)preg_match('/^\w+([-+.]\w+)*@\w+([-.]\w+)+$/i',$str);
    }
    /**
     * @brief QQ号码验证
     * @param string $str 需要验证的字符串
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function qq($str='')
    {
        return (bool)preg_match('/^[1-9][0-9]{4,}$/i',$str);
    }
    /**
     * @brief 身份证验证包括一二代身份证
     * @param string $str 需要验证的字符串
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function id($str='')
    {
        return (bool)preg_match('/^\d{15}(\d{2}[0-9x])?$/i',$str);
    }
    /**
     * @brief 此IP验证只是对IPV4进行验证。
     * @param string $str 需要验证的字符串
     * @return bool 验证通过返回 true 不通过返回 false
     * @note IPV6暂时不支持。
     */
    public static function ip($str='')
    {
        return (bool)preg_match('/^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/i',$str);
    }
    /**
     * @brief 邮政编码验证
     * @param string $str 需要验证的字符串
     * @return bool 验证通过返回 true 不通过返回 false
     * @note 此邮编验证只适合中国
     */
    public static function zip($str='')
    {
        return (bool)preg_match('/^\d{6}$/i',$str);
    }
    /**
     * @brief 验证字符串的长度，和数值的大小。$str 为字符串时，判定长度是否在给定的$min到$max之间的长度，为数值时，判定数值是否在给定的区间内。
     * @param mixed $str 要验证的内容
     * @param int $min 最小值或最小长度
     * @param int $max 最大值或最大长度
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function len($str, $min, $max)
    {
        if(is_int($str)) return $str >= $min && $str <= $max;
        if(is_string($str))return TString::getStrLen($str) >= $min && TString::getStrLen($str) <= $max;
        return false;
    }
    /**
     * @brief 电话号码验证
     * @param string $str 需要验证的字符串
     * @return  bool 验证通过返回 true 不通过返回 false
     */
    public static function phone($str='')
    {
        return (bool)preg_match('/^((\d{3,4})|\d{3,4}-)?\d{7,8}(-\d{3})*$/i',$str);
    }
    /**
     * @brief 手机号码验证
     * @param string $str
     * @return  bool 验证通过返回 true 不通过返回 false
     */
    public static function mobi($str='')
    {
        return (bool)preg_match('/^1[3-9]\d{9}$/i',$str);
    }
    /**
     * @brief 匹配帐号是否合法(字母开头，默认允许4-16字节【有效位数可自由定制】，允许字母数字下划线)
     * @param string $str 帐号字符串
     * @param int $minlen 最小长度，默认是4。
     * @param int $maxlen 最大长度，默认是16。
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function account($str, $minlen=4, $maxlen=16)
    {
        return (bool)preg_match('/^[a-zA-Z][a-zA-Z0-9_]{'.$minlen.','.$maxlen.'}$/i',$str);
    }
    /**
     * @brief Url地址验证
     * @param string $str 要检测的Url地址字符串
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function url($str='')
    {
        return (bool)preg_match('/^[a-zA-z]+:\/\/(\w+(-\w+)*)(\.(\w+(-\w+)*))+(\/?\S*)?$/i',$str);
    }
    /**
     * @brief 正则验证接口
     * @param mixed $reg 正则表达式
     * @param string $str 需要验证的字符串
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function match($reg, $str='')
    {
        return (bool)preg_match('/^'.$reg.'$/i',$str);
    }
    /**
     * 整型数据处理了，可以超出PHP支持的范围
     *
     * @access public
     * @param mixed $str 待验证的字符串
     * @return boolean
     */
    public static function int($str){
        return (bool)preg_match('/^\d+$/i',$str);
    }
    /**
     * 浮点验证
     *
     * @access public
     * @param String $str 待验证的字符串
     * @return boolean
     */
    public static function float($str){
        return (bool)preg_match('/^(-)?\d+\.?\d*$/i',$str);
    }
	/**
     * @brief 判断字符串是否为空
     * @param string $str 需要验证的字符串
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function required($str)
    {
        $str = trim($str);
         return (bool)preg_match('/\S+/i',$str);
    }
	/**
	 *@param $str 要验证的名字的格式
	 *@return bool 成功返回 true 失败返回 false
	 *@note 验证名字的正确性（以程序的命名为标准）。
	 */
	public static function name($str,$len=6)
	{
		return (bool)preg_match('/^[a-zA-Z_][a-zA-Z0-9_-]{'.($len-1).',}$/i',$str);
	}

    /**
     *@param $str 要验证的名字的格式
     *@return bool 成功返回 true 失败返回 false
     *@note 验证含点名字的正确性（以程序的命名为标准）。
     */
    public static function nameExt($str,$len=6)
    {
        return (bool)preg_match('/^[a-zA-Z_][a-zA-Z0-9._-]{'.($len-1).',}$/i',$str);
    }
	/**
	 *@param $reg 正则表达式
	 *@param $str 要验证的字符串
	 *@return bool 成功返回 true 失败返回 false
	 *@note 通过正则来验证字符串
	 */
	public static function reg($reg,$str)
	{
		return (bool)preg_match('/^'.$reg.'$/i',$str);
	}
    /**
     * 数值验证
     *
     * @access public
     * @param mixed $str 要验证的字符串
     * @return boolean
     */
	public static function number($str)
	{
		return (bool)preg_match('/^(([0-9]+)([\.,]([0-9]+))?|([\.,]([0-9]+))?)$/i',$str);
	}

    /**
     * 日期验证
     * @param  string $str 需要验证的字符串
     * @return boolean
     */
    public static function date($str)
    {
        return (bool)preg_match('/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/i',$str);
    }

    /**
     * 日期时间验证
     * @param  String  $str 需要验证的字符串
     * @return boolean
     */
    public static function datetime($str)
    {
        return (bool)preg_match('/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29) (?:(?:[0-1][0-9])|(?:2[0-3])):(?:[0-5][0-9]):(?:[0-5][0-9])$/i',$str);
    }
    /**
     * 时间验证
     * @param  String $str 需要验证的字符串
     * @return  boolean
     */
    public static function time($str)
    {
        return (bool)preg_match('/^(?:(?:[0-1][0-9])|(?:2[0-3])):(?:[0-5][0-9]):(?:[0-5][0-9])$/i',$str);
    }
    /**
     * 安规则的标尺进行验证
     *
     * @access public
     * @param array $rules 如 array('title:required|int:标题不能为空!);
     * @param mixed $data
     * @return bool
     */
	public static function check($rules,$data=null)
	{
		if($data == null) $data = Req::args();
		foreach($rules as $rule)
		{
			list($name, $reg, $msg) = explode(':',$rule);

			$info = array('name'=>$name,'msg'=>$msg);
			$field = isset($data[$name])?$data[$name]:null;
			if(strpos($reg,'|')!==false)
			{

				$regs = explode('|',$reg);
				foreach($regs as $reg)
				{
					if(method_exists('Validator',$reg))
					{
						if(!self::$reg($field)) return $info;
					}
					else
					{
						if(!self::match($reg,$field)) return $info;
					}
				}
			}
			else
			{
				if(method_exists('Validator',$reg))
				{
					if(!self::$reg($field)) return $info;
				}
				else
				{
					if(!self::match($reg,$field)) return $info;
				}

			}
		}
		return true;
	}
}
