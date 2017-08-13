<?php
/**
 * Model类
 *
 * @author Crazy、Ly
 * @class Model
 */
class Model
{
    //标准sql参数
    private $sql=array('table'=>'','fields'=>'*','where'=>'','join'=>'','group'=>'','having'=>'','order'=>'','limit'=>'','distinct'=>'','data'=>'');

    //前缀
    private $prefix = '';
    //主键
    private $primary_key = 'id';
    //表字段信息
    private $fields = array();
    //db
    private $db;
    /**
     * 构造方法
     *
     * @access public
     * @param mixed $name
     */
    public function __construct($name=null)
    {
        $this->db = DBFactory::getInstance();
		$dbinfo = DBFactory::getDbInfo();
		$this->prefix = $dbinfo['tablePre'];
        $this->table($name);
    }
    /**
     * 字段信息
     *
     * @access public
     * @param string $arg
     * @return void
     */
    public function fields($arg)
    {
        $this->sql['fields'] = $arg;
        return $this;
    }
    /**
     * 连接信息
     *
     * @access public
     * @param string $str
     * @return void
     */
    public function join($str)
    {
        $str = strtolower($str);
        if(strpos($str,'join')===false) $this->sql['join'] = 'left join '.preg_replace('/(\w+)(?=\s+as\s+\w+(,|\)|\s))/i',"tiny_$1 ",$str);
        else $this->sql['join'] = preg_replace('/(\w+)(?=\s+as\s+\w+(,|\)|\s))/i',"tiny_$1 ",$str);
        return $this;
    }
    /**
     * 条件信息
     *
     * @access public
     * @param string $str
     * @return void
     */
    public function where($str)
    {
        $this->sql['where'] = 'where '.$str;
        return $this;
    }
    /**
     * 设置表
     *
     * @access public
     * @param string $name
     * @return void
     */
    public function table($name)
    {
        if($name!=null && $name!=""){
            $this->fields = null;
            if(strpos($name,',') === false)
            {
                $this->sql['table']= $this->prefix.$name;
                $this->initTableInfo();
            }
            else
            {
                $tables = explode(',',$name);
                foreach($tables as $key=>$value)
                {
                    $tables[$key] = $this->prefix.trim($value);
                }
                $this->sql['table'] =   implode(',',$tables);
            }

        }
        return $this;
    }
    /**
     * 分组信息
     *
     * @access public
     * @param string $name
     * @return void
     */
    public function group($str)
    {
        $this->sql['group'] = 'group by '.$str;
        return $this;
    }
    /**
     * 条件信息
     *
     * @access public
     * @param String $str
     * @return void
     */
    public function having($str)
    {
        $this->sql['having'] = 'having '.$str;
        return $this;
    }
    /**
     * 排序信息
     *
     * @access public
     * @param String $str
     * @return void
     */
    public function order($str)
    {
        $this->sql['order'] = 'order by '.$str;
        return $this;
    }
    /**
     * 限制边界信息
     *
     * @access public
     * @param String $str
     * @return void
     */
    public function limit($str)
    {
        if($str != '')$this->sql['limit'] = 'limit '.$str;
        return $this;
    }
    /**
     * 去除重复
     *
     * @access public
     * @param String $str
     * @return void
     */
    public function distinct($str='')
    {
        $this->sql['distinct'] = 'distinct '.$str;
        return $this;
    }

    /**
     * 数据信息
     *
     * @access public
     * @param String $str
     * @return void
     */
    public function data($data = array())
    {
        $this->sql['data'] = $data;
        return $this;
    }
    /**
     * select查询
     *
     * @access public
     * @param String $str
     * @return source
     */
    public function select()
    {
        return $this->query($this->createSql());
    }
    /**
     * 查询一条记录
     *
     * @access public
     * @param String $str
     * @return Obj
     */
    public function find()
    {
        $this->limit(1);
        $this->changeWhere();
        if($this->sql['where']!='')
        {
            $result = $this->query($this->createSql());
            return isset($result[0])?$result[0]:$result;
        }
        return null;
    }
    /**
     * 查询所有记录
     *
     * @access public
     * @param String $str
     * @return resouce
     */
    public function findAll()
    {
        $this->limit('');
        return $this->query($this->createSql());
    }
    /**
     * 分页查询
     *
     * @access public
     * @param mixed $page
     * @param int $list_num
     * @param int $type
     * @param bool $ajax
     * @param string $ajaxFunction
     * @return source
     */
    public function findPage($page, $list_num=20,$type=1,$ajax=false,$ajaxFunction='')
    {

        $list_num   = $list_num>0?(int)$list_num:20;
        $sql = $this->sql;

        $this->sql['limit']='';
        $alias  = preg_replace('/.+\s+as\s+(\w+)\s*/', "$1.", $this->sql['table']);
        if($alias == $this->sql['table']) $alias="";
        if($this->sql['group']!='') $this->sql['fields'] =$this->primary_key?'count(distinct('.$alias.$this->primary_key.')) as total':'count(*) as total';
        else $this->sql['fields']  =$this->primary_key?'count('.$alias.$this->primary_key.') as total':'count(*) as total';
        $this->sql['order'] = "";
        $this->sql['group'] = "";
        $result = $this->query();
        $total = isset($result[0]['total'])?$result[0]['total']:0;
        $total_page = round(($total-1)/$list_num)+1;
        if($page>$total_page) $page = $total_page;
        $option=array(
         "total_nums"=>$total,
         "pagesize"=>$list_num,
         "plus"=>3,
         "page"=>$page,
         "ajax"=>$ajax,
         "ajaxFunction"=>$ajaxFunction
        );
        $pageing = new Paging($option);
        $data['html'] = $pageing->show($type);

        $this->sql = $sql;
        $page  = $page>0?(int)$page:1;
        $start_id = $list_num * ($page - 1);
        $this->sql['limit']="limit {$start_id}, {$list_num}";
        $data['data'] = $this->query();
        $data['page'] = array('total'=>$total,'totalPage'=>$total_page,'pageSize'=>$list_num,'page'=>$page);
        return $data;
    }
    /**
     * 简单分页查询
     *
     * @access public
     * @param String $str
     * @return void
     */
    public function getPage($page, $list_num=20)
    {
        //参数分析
        $page		= (int)$page;
        $list_num	= (int)$list_num;
        $start_id = $list_num * ($page - 1);
        $sql = $this->sql;
        $this->sql['limit']="limit {$start_id}, {$list_num}";
        $data['data'] = $this->query();
        $this->sql = $sql;
        $this->sql['limit']='';
        $alias  = preg_replace('/.+\s+as\s+(\w+)\s*/', "$1.", $this->sql['table']);
        if($alias == $this->sql['table']) $alias="";
        if($this->sql['group']!='') $this->sql['fields'] =$this->primary_key?'count(distinct('.$alias.$this->primary_key.')) as total':'count(*) as total';
        else $this->sql['fields']  =$this->primary_key?'count('.$alias.$this->primary_key.') as total':'count(*) as total';
        $this->sql['order'] = "";
        $this->sql['group'] = "";
        $result = $this->query();
        $total = $result[0]['total'];
        $total_page = ceil($total/$list_num);
        $data['totalPage'] = $total_page;
        $data['total'] = $total;
        if($page < $total_page) $data['haveNext'] = true;
        else $data['haveNext'] = false;
        return $data;
    }
    /**
     * 统计
     *
     * @access public
     * @return number
     */
    public function count()
    {
        $this->sql['limit']='';
        $this->sql['fields'] =$this->primary_key?'count('.$this->primary_key.') as total':'count(*) as total';
        $result = $this->query();
        $count = $result[0]['total'];
        return $count;
    }
    /**
     * 插入记录
     *
     * @access public
     * @return void
     */
    public function insert()
    {
        $sql = $this->sql;
        if(!is_array($sql['data']) || count($sql['data'])<1)
        {
            $sql['data'] = Req::post();
        }
        $data = $sql['data'];
        $fields = "";$values ="";
        if(is_array($data))
        {
            foreach ($data as $key=>$val)
            {
                if(is_string($key) && isset($this->fields[$key]))
                {

                    if(is_null($val)){
                        $value = 'NULL';
                    }else{
                        $value = $this->formatField($this->fields[$key],$val);
                    }
                    if(is_scalar($value))
                    {
                        $fields .= '`'.$key.'`,';
                        $values .= $value.',';
                    }
                }
            }
            $fields = trim($fields,',');
            $values = trim($values,',');
        }
        $sqlStr = "insert into {$sql['table']} ({$fields}) values ($values)";
        return $this->query($sqlStr);
    }
    /**
     * 添加记录
     *
     * @access public
     * @return void
     */
    public function add()
    {
        return $this->insert();
    }
    /**
     * 更新数据
     *
     * @access public
     * @return mixed
     */
    public function update()
    {

        $sql = $this->sql;

        if(!is_array($sql['data']) || count($sql['data'])<1)
        {
            $sql['data'] = Req::post();
        }
        $set = '';

        foreach($sql['data'] as $key => $val)
        {
            if(is_string($key) && $key != $this->primary_key && isset($this->fields[$key]))
            {
                if(is_string($key))
                {
                    $value = $val;
                    if(is_null($val)){
                        $value = 'NULL';
                    }else{
                        $value = $this->formatField($this->fields[$key],$val);
                    }
                    if(is_scalar($value))
                    {
                        if(!is_array($val) && preg_match("/`$key`/i",trim($val))){
                            $set .= '`'.$key.'` = '.$val.',';
                        }
                        else  $set .= '`'.$key.'` = '.$value.',';
                    }
                }
            }
        }
        if($set!='')
        {
            $set = 'set '.trim($set,',');
            $this->fields($set);
            $this->changeWhere();
            $sql = $this->sql;
            $sqlStr = "update {$sql['table']} {$set} {$sql['where']}";

            return $this->query($sqlStr);
        }
    }
    /**
     * 保存数据，自动识别更新还是添加
     *
     * @access public
     * @return mixed
     */
    public function save()
    {
        if(!is_array($this->sql['data']) || count($this->sql['data'])<1)
        {
            $this->sql['data'] = Req::args();
        }
        if((isset($this->sql['data'][$this->primary_key]) && $this->sql['data'][$this->primary_key]) )
        {
            return $this->update();
        }
        else
        {
            if(isset($this->sql['data'][$this->primary_key]))unset($this->sql['data'][$this->primary_key]);
            return $this->insert();
        }
    }
    /**
     * 删除记录
     *
     * @access public
     * @return mixed
     */
    public function delete()
    {
        $sql = $this->sql;
        if($sql['where'] == '')
        {
            $this->changeWhere();
        }
        if($this->sql['where'] != ''){
            $sql = $this->sql;
            $sql_str = "delete from {$sql['table']} {$sql['join']} {$sql['where']}";
            return $this->query($sql_str);
        }else{
            return false;
        }
    }
    /**
     * 自由式查询
     *
     * @access public
     * @param mixed $sql
     * @return mixed
     */
    public function query($sql=null)
    {
        if($sql === null) $sql = $this->createSql();
        $this->initSql();
        //echo $sql;
        return $this->db->doSql($sql);
    }
    /**
     * 表初始化信息
     *
     * @access private
     * @return mixed
     */
    private function initTableInfo()
    {
        if(empty($this->fields))
        {
            $cache = CacheFactory::getInstance();
            $info = $cache->get('table_'.$this->sql['table']);
            if(!$info)
            {
                $info = $this->db->getTableInfo($this->sql['table']);
                $cache->set('table_'.$this->sql['table'],$info,86400);
            }
            $this->primary_key = $info['primary_key'];
            $this->fields = $info['fields'];
        }

    }
    /**
     * 恢复sql语句原状态数据
     *
     * @access private
     * @return mixed
     */
    private function initSql()
    {
        $this->sql = array('table'=>$this->sql['table'],'fields'=>'*','where'=>'','join'=>'','group'=>'','having'=>'','order'=>'','limit'=>'','distinct'=>'','data'=>'');
    }
    /**
     * 创建查询sql语句
     *
     * @access private
     * @return mixed
     */
    private function createSql()
    {
        $sql = $this->sql;
        $sqlStr = "select {$sql['distinct']} {$sql['fields']} from {$sql['table']} {$sql['join']} {$sql['where']} {$sql['group']} {$sql['having']} {$sql['order']} {$sql['limit']}";
        return $sqlStr;
    }
    /**
     * 格式化字段
     *
     * @access private
     * @param mixed $typeInfo
     * @param mixed $value
     * @return mixed
     */
    private function formatField($typeInfo,$value)
    {
        preg_match("/(\w+)(\((\d+)\))?/", $typeInfo, $matches);

        if(isset($matches[1])) $type = $matches[1];
        if(isset($matches[3])) $len = $matches[3];
        $_type = "string";
        $type = strtolower($type);
        switch ($type) {
            case 'bit':
            case 'bigbit':
            case 'bool':
            case 'boolean':
            case 'decimal':
            case 'decimal':
            case 'dec':
            case 'double':
            case 'float':
            case 'int':
            case 'bigint':
            case 'mediumint':
            case 'smallint':
            case 'tinyint':
            case 'real':{
                if(!is_numeric($value)) $value = 0;
                if($value == '' || $value == null || empty($value)) $value = 0;
                $_type = 'numeric';
                break;
            }
        }
        if(isset($len)){
            if(!is_array($value) && TString::strlen($value)>$len) $value = TString::msubstr($value, 0,$len,'utf-8','');
        }
        if(is_array($value)) $value = serialize($value);
        if($_type=='string') $value = '\''.$value.'\'';
        return $value;
    }
    /**
     * 由data修改where [data中的只有键值会影响条件，其它的一概不考虑在条件中]
     *
     * @access private
     * @return mixed
     */
    private function changeWhere()
    {
        $sql = $this->sql;$where = '';
        if(is_array($sql['data']))
        {
            $key_array 	= array_keys($sql['data']);
            if (in_array($this->primary_key, $key_array))
            {
                if(is_string($sql['data'][$this->primary_key]))
                {
                    if(strpos($sql['data'][$this->primary_key],',')!==false)
                    {
                        $where = '`'.$this->primary_key.'` in ('.trim($sql['data'][$this->primary_key],',').')';
                    }
                    else $where = '`'.$this->primary_key."`='".$sql['data'][$this->primary_key]."'";
                }
                else if(is_array($sql['data'][$this->primary_key]))
                {
                    $str = implode(',',$sql['data'][$this->primary_key]);
                    $where = '`'.$this->primary_key.'` in ('.$str.')';
                }
                else
                {
                    $where = '`'.$this->primary_key.'`='.$sql['data'][$this->primary_key];
                }
            }
        }
        if($where != '')
        {
            if($this->sql['where'] !='') $this->sql['where'] = $this->sql['where'].' and '.$where;
            else $this->sql['where'] = 'where '.$where;
        }
    }
}
