<?php
/**
 * 调试类
 * 
 * @author Crazy、Ly
 * @class Debug
 */
class Debug
{
    private $dbg_Enabled = true;
    private $dbg_RequestTime   	= '';
    private $dbg_FinishTime 	= '';
    private $dbg_startmen	 	= '';
    private $dbg_endmen		 	= '';
    
    private $dbg_Data  			= array();
    private $dbg_DB_Data   		= '';
    private $dbg_AllVars;
    private $dbg_Show_default 	= '';
    private $DivSets			= array();
    /**
     * 构造初始化
     * 
     * @return mixed
     */
    function __construct(){
        $this->dbg_RequestTime	=	$this->microtime_float();
        $this->dbg_startmen		= 	memory_get_usage();		

        $this->dbg_AllVars =true;
        $this->DivSets[0] = "<tr><TD style='cursor:hand;' onclick=\"javascript:if (document.getElementById('data#sectname#').style.display=='none'){document.getElementById('data#sectname#').style.display='block';}else{document.getElementById('data#sectname#').style.display='none';}\"><DIV id=sect#sectname# style=\"font-weight:bold;cursor:pointer;margin-top:4px;background:#0BF;color:white;padding:4px;\">|#title#| <DIV id=data#sectname# style=\"cursor:text;display:none; color:#000; background:#FFFFFF;padding-left:8px;\" onclick=\"window.event.cancelBubble = true;\">|#data#| </DIV>|</DIV>|";
        $this->DivSets[1] = "<tr><TD><DIV id=sect#sectname# style=\"font-weight:bold;cursor:hand;background:#7EA5D7;color:white;padding:4px;\" onclick=\"javascript:if (document.getElementById('data#sectname#').style.display=='none'){document.getElementById('data#sectname#').style.display='block';}else{document.getElementById('data#sectname#').style.display='none';}\">|#title#| <DIV id=data#sectname# style=\"cursor:text;display:block;background:#FFFFFF;padding-left:8px;\" onclick=\"window.event.cancelBubble = true;\">|#data#| </DIV>|</DIV>|" ;
        $this->DivSets[2] = "<tr><TD><DIV id=sect#sectname# style=\"background:#7EA5D7;color:lightsteelblue;padding:4px;\">|#title#| <DIV id=data#sectname# style=\"display:none;background:lightsteelblue;padding-left:8px\">|#data#| </DIV>|</DIV>|"; 
        $this->dbg_Show_default = "0,0,0,0,0,0,0,0,0,0,0";	
                
    }
    /**
     * 数据展示
     * 
     * @access global
     * @return mixed
     */
    function display()
    {
        If($this->dbg_Enabled){
            $this->dbg_FinishTime = time() ;
            $this->DivSet = preg_split("/,/",$this->dbg_Show_default);
            echo "<Table width=99% cellspacing=0 border=0 style=\"font-family:arial;font-size:9pt; margin:auto; font-weight:normal;\"><tr><TD><DIV style=\"background:#F90;color:#000;padding:4px;font-size:12pt;font-weight:bold;\">Debug-控制器:</DIV>";
            $this->PrintSummaryInfo($this->DivSet[0]);
            $this->PrintCollection("Variables", $this->dbg_Data,$this->DivSet[1],"");
            $this->PrintCollection("Querystring", $_GET, $this->DivSet[2],"");
            $this->PrintCollection("Form", $_POST, $this->DivSet[3],"");
            if(isset($_SESSION)){
                $this->PrintCollection("Session", $_SESSION, $this->DivSet[3],"");
            }
            $this->PrintCollection("Cookie", $_COOKIE,$this->DivSet[6],"");
            $this->PrintCollection("Server", $_SERVER,$this->DivSet[6],"");
            $this->PrintCollection("Request", $_REQUEST,$this->DivSet[6],"");
            $this->PrintCollection("SQL&nbsp;Info", Tiny::getSqlLog(),$this->DivSet[6],"");
            echo "</Table>"; 
        } 
    }
    
    function AddRow($t,$vars,$val)
    {
        
        if(is_object($val))
        {
            $tem = 'Class '.get_class($val); 
        }
        else if(is_array($val))
        {
            $tem = 'Array '.var_export($val,true);
        }
        else $tem = $val;
        $t .='|<tr valign=top>|<td>|'.$vars.'|<td>= '.$tem.'|</tr>'; 
        return $t; 
    }
    
    function MakeTable($tdata)
    {
        $tdata = "|<table border=0 style=\"font-size:10pt;font-weight:normal;\">" . $tdata . "</Table>|" ;
        return $tdata;
    }
    function out($out)
    {
            //foreach($out as $key=>$value){
             //   if(is_object($value))echo get_class($value)." ";
            //	else echo $value." ";
           // }
         $this->dbg_Data = $out;	 
    }

    function PrintSummaryInfo($tblDivSetNo)
    {

        $tbl='';
        $tbl = $this->AddRow($tbl,'Time of Request',$this->etime($this->dbg_RequestTime));
        $tbl = $this->AddRow($tbl,'Menory Used',$this->ememory($this->dbg_startmen));
        $tbl = $this->AddRow($tbl,'Included File Nums ',count(get_included_files()));
        $tbl = $this->MakeTable($tbl); 
        $tmp = str_replace("#sectname#","SUMMARY",$this->DivSets[$tblDivSetNo]);
        $tmp = str_replace("#title#","Summary Info",$tmp);
        $tmp = str_replace("#data#",$tbl,$tmp) ;
        echo str_replace("|", "\n",$tmp) ;
    }
    
    function PrintCollection($Name,$Collection,$DivSetNo,$ExtraInfo)
    {
        $tbl='';
        foreach($Collection as $key => $val) {
            $tbl = $this->AddRow($tbl,$key,$Collection[$key]);
        }
            $tbl = $this->MakeTable($tbl); 
        $tmp = str_replace("#sectname#",$Name,$this->DivSets[$DivSetNo]);
        if (count($Collection)==0){
            $tmp =	str_replace("#title#",'<font color=gray>'.$Name.'</font>',$tmp);	
        }else{
            $tmp =	str_replace("#title#",$Name,$tmp);	
        }
        $tbl = str_replace("#data#",$tbl,$tmp) ;
        echo str_replace("|", "\n",$tbl) ;
    }
    
    function microtime_float()
    {
        list($usec, $sec) = explode(" ", microtime());
        return ((float)$usec + (float)$sec);
    }
    function etime($tt)
    {
        //$time_end = $this->microtime_float();
        //$time = number_format(($time_end - $tt) * 1000,0);
        return sprintf('%0.5f',Tiny::getLogger()->getExecutionTime()).'S';//$time." ms";
    }
    function ememory($tt)
    {
        //$memory_end = memory_get_usage();
        //$memory = ($memory_end - $tt).'Byte;';
        return number_format(Tiny::getLogger()->getMemoryUsage()/1024).'KB';
    }
}
?>