<?php
class TimeTest
{
	var $begin_time,$end_time,$spend_time;
	function  __construct()
	{
		$this->begin_time=$this->getmicrotime();
	}
	function getmicrotime()
	{
		list($usec, $sec) = explode(" ",microtime());
		return ((float)$usec + (float)$sec); 
	}
	function __toString()
	{
		$this->end_time=$this->getmicrotime();
		$this->spend_time=$this->end_time-$this->begin_time;
		return strval($this->spend_time);
	}
	public function __destruct()
	{
		unset($this->begin_time,$this->end_time,$this->spend_time);
	}
}
?>