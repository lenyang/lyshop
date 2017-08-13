<?php
/**
 * 文件日志处理类
 *
 * @author Crazy、Ly
 * @class FileCache
 */
class FileCache implements ICache
{
	//相对缓存目录下的路径
	private $path = '';
    /**
     * 构造类
     *
     * @access public
     * @param string $path
     * @return mixed
     */
    public function __construct($path='')
    {
		$this->setPath($path);
    }
    /**
     * @brief 存储键值内容
     * @param string $key
     * @param mixed $content
     */
    public function set($key,$content,$delay=30)
    {
        $filePath = $this->filePath($key);
        if(is_object($content) || is_array($content))
        {
            $content = serialize($content);
        }
		$time = sprintf("%-11s",$delay);
        File::putContents($filePath,$time.$content);
    }
    /**
     * @brief 取得键值对应的内容
     * @param mixed $key
     * @return mixed
     */
    public function get($key)
    {
        $filePath = $this->filePath($key);
		if(is_file($filePath))
		{
			$content = File::getContents($filePath);
			$time = intval(substr($content,0,10));
			$content = substr($content,11);
			if($time>0 && (time()-filemtime($filePath)>$time)) $this->delete($key);
            if(preg_match('/^[Oa]:\d+:/',$content)) return unserialize($content);
            else
                return $content;

		}
		else
		{
			return null;
		}
    }
    /**
     * @brief 得到Key值对应存储的文件路径
     * @param string $key 对应的key值
     */
    public function filePath($key)
    {
        $key = $this->key($key);
        $subPath  = trim($this->getPath(),'/');
        if($subPath!='') $key = $subPath.'/'.$key;
        $filePath = Tiny::getPath('cache').$key;
        return $filePath;
    }
    /**
     * @brief 计算键值
     * @param String $key 字符串内容
     * @return String 得到对应的键值
     */
    public function key($key)
    {
        //$key = md5($key);
        $key = CRC32($key);
		$key = sprintf('%u',$key);
        $key =preg_replace('/(?<=\d{3})(\d{3})/','/$1',$key);
        return $key.'.php';
    }
    /**
     * @brief 删除键值对应的内容
     * @param String $key 键值
     */
    public function delete($key)
    {
        $filePath = $this->filePath($key);
        if(file_exists($filePath)) unlink($filePath);
    }
	/**
     * @brief 设定路径
     * @param String $path 路径
     */
	public function setPath($path)
	{
		$this->path = $path;
	}
	/**
     * @brief 取得路径
     * @return String 路径
     */
	public function getPath()
	{
		return $this->path;
	}
}
