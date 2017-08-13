<?php
/**
 * 时间封装类
 * 
 * @author Crazy、Ly
 * @class Date
 */
class Date
{
	private $time;
    /**
     * 初始化时区、时间设定
     * 
     * @access public
     * @param string $time
     * @param string $timezone
     * @return mixed
     */
	public function __construct($time = "now", $timezone = 'Asia/Shanghai')
	{
		date_default_timezone_set($timezone);
		$this->time = time();
		if($time != 'now')$this->time=strtotime($time);
	}
    /**
     * 时间格式化
     * 
     * @access public
     * @param mixed $format
     * @return mixed
     */
	public function format($format)
	{
		return date($format,$this->time);
	}
    /**
     * 时间相加
     * 
     * @access public
     * @param mixed $time
     * @return mixed
     */
	public function add($time)
	{
		if(is_int($time)) $this->time + $time;
		else return $this->time+strtotime($time);
	}
    /**
     * 时间差
     * 
     * @access public
     * @param mixed $time
     * @return mixed
     */
	public function diff($time)
	{
		if(is_int($time)) return $this->time - $time;
		return $this->time-strtotime($time);
	}
}
?>
