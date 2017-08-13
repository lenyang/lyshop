<?php
/**
 * 日志处理类
 * 
 * @author Crazy、Ly
 * @class Logger
 */
class Logger
{
	const TRACE='trace';
	const WARNING='warning';
	const ERROR='error';
	const INFO='info';

	private $logs=null;
    /**
     * 写入日志信息
     * 
     * @access public
     * @param mixed $message
     * @param string $level
     * @return mixed
     */
	public function log($message,$level='info')
	{
		$this->logs[] = array($message,$level);
	}
    /**
     * 得到运行时间
     * 
     * @access public
     * @return mixed
     */
	public function getExecutionTime()
	{
		return microtime(true)-BEGIN_TIME;
	}
    /**
     * 取得内存使用信息
     * 
     * @access public
     * @return mixed
     */
	public function getMemoryUsage()
	{
		if(function_exists('memory_get_usage'))
			return memory_get_usage();
		else
		{
			$output=array();
			if(strncmp(PHP_OS,'WIN',3)===0)
			{
				exec('tasklist /FI "PID eq ' . getmypid() . '" /FO LIST',$output);
				return isset($output[5])?preg_replace('/[\D]/','',$output[5])*1024 : 0;
			}
			else
			{
				$pid=getmypid();
				exec("ps -eo%mem,rss,pid | grep $pid", $output);
				$output=explode("  ",$output[0]);
				return isset($output[1]) ? $output[1]*1024 : 0;
			}
		}
	}
    /**
     * 日志类在销毁时统计进行日志处理
     * 
     * @access public
     * @return mixed
     */
	public function __destruct()
	{
		
		if(LOG && $this->logs!==null)
		{
			$log_file_name = APP_ROOT.'logs'.DIRECTORY_SEPARATOR.date('Y-m-d').'_log.txt';
			if (is_file($log_file_name) && filesize($log_file_name) >= 2097152)
			{			
				rename($log_file_name, APP_ROOT . 'logs'.DIRECTORY_SEPARATOR.date('Y-m-d_His').'_log.txt');
			}
			$logFile = new File($log_file_name,'a+');
			foreach($this->logs as $log)
			{
				$logFile->write(date('Y-m-d H:i:s')."\t[".strtolower($log[1])."]\t".$log[0]."[time used: ".sprintf('%0.5f',$this->getExecutionTime())."s] [memory used:".number_format($this->getMemoryUsage()/1024)."kb]\r\n");
			}
			
		}
		
	}
}