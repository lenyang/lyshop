<?php
/**
 * description...
 * 
 * @author Crazy、Ly
 * @class ClassConfig
 */
class ClassConfig
{
    protected $config = NULL;
    protected $status = false;

    public function __construct()
    {
        $modle = new Model('class_config');
        $obj = $modle->where("class_name='".get_class($this)."'")->find();
        if($obj){
            $this->config = unserialize($obj['config']);
            if($obj['status']==1) $this->status = true;
            else
                $this->status = false;
        }
    }
    
    public function getStatus()
    {
        return $this->status;
    }
}