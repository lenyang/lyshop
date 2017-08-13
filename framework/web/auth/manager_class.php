<?php
/**
 * 管理者类，封装到系统框架内
 * 
 * @author Crazy、Ly
 * @class Manager
 */
class Manager extends Object
{
	private $status;
    /**
     * 构造函数
     * 
     * @access public
     * @param mixed $name
     * @param mixed $password
     * @return mixed
     */
	public function __construct($name,$password)
	{
		$safebox = Safebox::getInstance();
		$manager = $safebox->get('manager');
		if(!isset($manager['id']) || $manager['id']=='' || $manager['name']!=$name)
		{
			$model = new Model('manager');
			$name = Filter::sql($name);
			$user = $model->where("name='".$name."'")->find();
			if(!empty($user))
			{
				$key = md5($user['validcode']);
				$password = substr($key,0,16).$password.substr($key,16,16);
				if($user['password'] == md5($password))
				{
					$this->status='online';
					$this->properties=$user;
					$safebox->set('manager',$this->properties);
				}
				else
				{
					$this->status='offline';
					$this->properties=null;
				}
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
			$this->properties=$safebox->get('manager');
		}
	}
    /**
     * 最得管理者的状态
     * 
     * @access public
     * @return mixed
     */
	public function getStatus()
	{
		return $this->status;
	}
}