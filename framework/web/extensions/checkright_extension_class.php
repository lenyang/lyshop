<?php
/**
 * 后台权限验证扩展
 * 
 * @author Crazy、Ly
 * @class CheckRightExtension
 */
class CheckRightExtension implements Extension
{
	public function before($obj=null)
	{
		$id = $obj->getAction()->getId();
		if($id !='login' && $id !='logout' && isset($obj->needRightActions[$id]))
        {
            $obj->checkRight($id);
        }
	}
	public function after($obj=null)
	{
	}
}
