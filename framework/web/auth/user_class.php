<?php
/**
 * 用户类
 * 
 * @author Crazy、Ly
 * @class User
 */
class User extends Object
{
	private $status;
    /**
     * 构造方法 
     * @access public
     * @param mixed $name
     * @param mixed $password
     * @return mixed
     */
	public function __construct($name,$password)
	{
		if(Session::get('user')===null)
		{
			$model = new Model('');
			$user = $model->getObjs('*','name="'.$name.'" and password="'.md5($password).'"');
			if(isset($user[0]))
			{
				$this->properties=$user[0];
				$this->status='online';
				Session::set('user',$this->properties);
			}
			else
			{
				$this->status='offline';
				$this->properties=null;
			}
		}
		else
		{
			$this->status='online';
			$this->properties=Session::get('user');
		}
	}
    /**
     * 得到用的状态
     * 
     * @access public
     * @return mixed
     */
	public function getStatus()
	{
		return $this->status;
	}
}
?>