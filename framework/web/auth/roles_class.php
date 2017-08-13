<?php
/**
 * 角色类
 * 
 * @author Crazy、Ly
 * @class Roles
 */
 class Roles
 {
	 private $roles;
	 private $name = 'roles';
     /**
      * 构造角色类，考虑到角色的修改，即时有效性，暂不考虑用Session保存
      * 
      * @access public
      * @param mixed $roles
      * @return mixed
      */
	 public function __construct($roles=null)
	 {
		 if($roles!==null)
		 {
		 	$key = $this->name.'_'.$roles;
			 //if(Session::get($key)===null)
			 {
			 	$model = new Model('roles');
                $result=$model->where("id=".$roles)->find();
				$this->roles = $result;
				//Session::set($key,$this->roles);
			 }
			 /*else
			 {
				$this->roles=Session::get($key);
			 }*/
		 }
	 }
     /**
      * 取得当前的角色
      * 
      * @access public
      * @return mixed
      */
	 public function getRoles()
	 {
		 return	 $this->roles;
	 }
 }
?>