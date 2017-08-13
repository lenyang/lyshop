<?php
/**
 * 查询类主要用于，viewAction中
 *
 * @author Crazy、Ly
 * @class Query
 */
class Query
{
    private $dbo;
    public $cache = false;
    public $cacheTime = 30;
    private $paging;
    private $tablePre='';
    private $sql=array('table'=>'','fields'=>'*','where'=>'','join'=>'','group'=>'','having'=>'','order'=>'','limit'=>'limit 500','distinct'=>'');
    /**
     * 构造方法
     *
     * @access public
     * @param mixed $name
     * @return mixed
     */
    public function __construct($name)
    {
        $dbinfo = DBFactory::getDbInfo();
        $this->tablePre = $dbinfo['tablePre'];
        $this->table = $name;
        $this->dbo=DBFactory::getInstance();
    }
    /**
     * 设置表
     *
     * @access public
     * @param mixed $name
     * @return mixed
     */
    public function setTable($name)
    {
        if(strpos($name,',') === false)
        {
            $this->sql['table']= $this->tablePre.$name;
        }
        else
        {
            $tables = explode(',',$name);
            foreach($tables as $key=>$value)
            {
                $tables[$key] = $this->tablePre.trim($value);
            }
            $this->sql['table'] = 	implode(',',$tables);
        }
    }
    /**
     * @brief 取得表前缀
     * @return String 表前缀
     */
    public function getTablePre()
    {
        return $this->tablePre;
    }
    /**
     * @brief 实现属性的直接存
     * @param string $name
     * @param string $value
     */
    private function setJoin($str)
    {
        //$this->sql['join']= preg_replace('/join\s+(\S+)\s+/i',"join {$this->tablePre}$1 ",$str);
        $this->sql['join'] = preg_replace('/(\w+)(?=\s+as\s+\w+(,|\)|\s))/i',"tiny_$1 ",$str);
    }
    public function __set($name,$value)
    {
        switch($name)
        {
            case 'table':$this->setTable($value);break;
            case 'fields':$this->sql['fields'] = $value;break;
            case 'where':$this->sql['where'] = 'where '.$value;break;
            case 'join':$this->setJoin($value);break;
            case 'group':$this->sql['group'] = 'group by '.$value;break;
            case 'having':$this->sql['having'] = 'having '.$value;break;
            case 'order':$this->sql['order'] = 'order by '.$value;break;
            case 'limit':$this->sql['limit'] = 'limit '.$value;break;
            case 'page':$this->sql['page'] =intval($value); break;
            case 'pagesize':$this->sql['pagesize'] =intval($value); break;
            case 'pagelength':$this->sql['pagelength'] =intval($value); break;
            case 'pagename':$this->sql['pagename'] =$value; break;
            case 'distinct':
            {
                if($value)$this->sql['distinct'] = 'distinct ';
                else $this->sql['distinct'] = '';
                break;
            }
        }
    }
    /**
     * @brief 实现属性的直接取
     * @param mixed $name
     * @return String
     */
    public function __get($name)
    {
        if(isset($this->sql[$name]))return $this->sql[$name];
    }
    public function __isset($name)
    {
        if(isset($this->sql[$name]))return true;
    }
    /**
     * @brief 取得查询结果
     * @return array
     */
    public function find()
    {

        if($this->page)
        {
            $sql="select $this->distinct $this->fields from $this->table $this->join $this->where $this->group $this->having $this->order";
            $pageSql = "select count(*) as total from $this->table $this->join $this->where $this->group $this->having";

            $pagesize = isset($this->pagesize)?intval($this->pagesize):10;
            $pagelength = isset($this->pagelength)?intval($this->pagelength):5;
            $pagename = isset($this->pagename)?$this->pagename:'p';

            $items = $this->dbo->doSql($pageSql);
            $total = 0;
            if(is_array($items))$total = $items[0]['total'];
            $plus = floor($pagelength/2);
            $data = Array('total_nums'=>$total,'pagesize'=>$pagesize,'plus'=>$plus,'pagename'=>$pagename);
            $this->paging = new Paging($data);
            $first = $this->paging->getFirstRow();
            $sql .= ' limit '.$first.','.$pagesize;
            return $this->dbo->doSql($sql);
        }else
        {
            $sql="select $this->distinct $this->fields from $this->table $this->join $this->where $this->group $this->having $this->order $this->limit";
            $items = array();
            if($this->cache)
            {
                $cache = CacheFactory::getInstance();
                $items = $cache->get("$sql");
                if($items===null)
                {

                    $items = $this->dbo->doSql($sql);
                    $cache->set("$sql",$items,$this->cacheTime);
                }
            }
            else
            {
                try
                {
                    $items = $this->dbo->doSql($sql);
                }catch(Exception $e)
                {
                    throw $e;
                }
            }
            return $items;
        }
    }
    /**
     * 取得分布bar
     *
     * @access public
     * @return mixed
     */
    public function pageBar($type=1)
    {
        return $this->paging->show($type);
    }
    /**
     * 取得当前的分布类
     *
     * @access public
     * @return mixed
     */
    public function getPaging()
    {
        if(isset($this->paging)) return $this->paging;
        else return null;
    }
}
?>
