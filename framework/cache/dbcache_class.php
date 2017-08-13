<?php
/**
 * 数据库缓存
 * 
 * @author Crazy、Ly
 * @class DbCache
 */
class DbCache implements ICache
{
	//相对缓存目录下的路径
	private $table = 'cache';
    private $db;
    /**
     * 构造方法
     * 
     * @access public
     * @return mixed
     */
    public function __construct()
    {
		$this->db = DBFactory::getInstance();//new Model($this->table);
        $info = DBFactory::getDbInfo();
        $this->table = $info['tablePre']."cache";
    }
    /**
     * @brief 存储键值内容
     * @param string $key
     * @param mixed $content
     */
    public function set($key,$content,$delay=30)
    {
        $key = $this->key($key);
        if(is_object($content) || is_array($content))
        {
            $content = serialize($content);
        }
        $time = time()+$delay;
        $this->db->dosql("replace into `{$this->table}` (`key`,`content`,`delay`) values('{$key}','{$content}','{$time}')");
    }
    /**
     * @brief 取得键值对应的内容
     * @param mixed $key
     * @return mixed
     */
    public function get($key)
    {
        $key = $this->key($key);
        $result = $this->db->dosql("select * from `{$this->table}` where `key`='{$key}'");
		if(!empty($result))
		{
            $result = $result[0];
			$content = $result['content'];
			$delay = intval($result['delay']);
			if((time()-$result['delay'])>0) $this->db->dosql("delete from `{$this->table}` where `key`='{$key}'");
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
     * @brief 计算键值
     * @param String $key 字符串内容
     * @return String 得到对应的键值
     */
    public function key($key)
    {
        return md5($key);
    }
    /**
     * @brief 删除键值对应的内容
     * @param String $key 键值
     */
    public function delete($key)
    {
        $key = $this->key($key);
        $this->db->dosql("delete from `{$this->table}` where `key`='{$key}'");
    }
}

