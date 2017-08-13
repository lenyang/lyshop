<?php
/**
 * 备份处理类
 *
 * @author Crazy、Ly
 * @class BackUp
 */
class BackUp{

	private $db = null;
    /**
     * 构造函数
     *
     * @access public
     * @return mixed
     */
	public function __construct(){
		$this->db = DBFactory::getInstance();
	}
    /**
     * 备份
     *
     * @access public
     * @param array $tables
     * @param mixed $file_name
     * @return mixed
     */
	public function back($tables=array(),$file_name=null){
		//$model = new Model();
		$sql = "";
		foreach ($tables as $table) {
			$row = $this->db->doSql("show create table `{$table}` ");
			$sql .= "DROP TABLE IF EXISTS `".$row[0]['Table']."`;\n";
			$sql .= $row[0]['Create Table'].";\n";
			$rows = $this->db->doSql("select * from `{$table}`");
			if(count($rows)>0){
				$sql .= 'INSERT INTO `'.$table.'` (`';
				$fields = (array)current($rows);
				$keys = array_keys($fields);
				$sql .= implode("`,`", $keys)."`) VALUES ";
				foreach($rows as $row) {
					$values = array_values($row);
					foreach ($values as $key => $value) $values[$key] = mysql_escape_string($value);
					$sql .= "('".implode("','", $values)."'),";
				}
				$sql = rtrim($sql,",");
				$sql .= ";\n";
			}
		}
		if($file_name==null)$file_name = date('YmdH').'_'.rand(1000,9999).'_'.rand(1000,9999).'.sql';
		$database_path = Tiny::getPath('database').$file_name;
		$file = new File($database_path,'w+');
		return $file->write($sql);
	}
    /**
     * 安装
     *
     * @access public
     * @param mixed $sqls
     * @return mixed
     */
	public function install($sqls){
		$flag=true;
        if(is_array($sqls))
        {
            foreach($sqls as $sql)
            {
                if($this->db->doSql($sql) === false){ $flag = false;}
            }
        }
        return $flag;
	}
    /**
     * 解析
     *
     * @access public
     * @param mixed $filename
     * @return mixed
     */
	public function parseSql($filename){
		$lines=file($filename);
		$lines[0]=str_replace(chr(239).chr(187).chr(191),"",$lines[0]);//去除BOM头
		$flage=true;
		$sqls=array();
		$sql="";
		foreach($lines as $line)
		{
			$line=trim($line);
			$char=substr($line,0,1);
			if($char!='#' && strlen($line)>0)
			{
				$prefix=substr($line,0,2);
				switch($prefix)
				{
					case '/*':
					{
					$flage=(substr($line,-3)=='*/;'||substr($line,-2)=='*/')?true:false;
					break 1;
					}
					case '--': break 1;
					default :
					{
						if($flage)
						{
							$sql.=$line;
							if(substr($line,-1)==";")
							{
								$sqls[]=$sql;
								$sql="";
							}
						}
						if(!$flage)$flage=(substr($line,-3)=='*/;'||substr($line,-2)=='*/')?true:false;
					}
				}
			}
		}
		return $sqls;
	}
}
