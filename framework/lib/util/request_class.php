<?php
/**
 * 请求类
 *
 * @author Crazy、Ly
 * @class Req
 */
/**
 * 封装$_GET $_POST 的类，使$_GET $_POST 有一个统一的出入口
 * @class Req 
 * @note  
 */
class Req
{
    //对应处理$_GET
    public static function get()
    {
        $num = func_num_args();
        $args = func_get_args();
        if($num==1)
        {
            if(isset($_GET[$args[0]])){
                if(is_array($_GET[$args[0]]))return $_GET[$args[0]];
                else return trim($_GET[$args[0]]);
            }
            return null;
        }
        else if($num>=2)
        {
            if($args[1]!==null)$_GET[$args[0]] = $args[1];
            else if(isset($_GET[$args[0]])) unset($_GET[$args[0]]);
        }
        else
        {
            return $_GET;
        }
    }
    //对应处理$_POST
    public static function post()
    {
        $num = func_num_args();
        $args = func_get_args();
        if($num==1)
        {
            if(isset( $_POST[$args[0]])){
                if(is_array( $_POST[$args[0]]))return  $_POST[$args[0]];
                else return trim( $_POST[$args[0]]);
            }
            return null;
        }
        else if($num>=2)
        {
            if($args[1]!==null)	$_POST[$args[0]] = $args[1];
            else if(isset($_POST[$args[0]])) unset($_POST[$args[0]]);
        }
        else
        {
            return $_POST;
        }
    }
    //同时处理$_GET $_POST
    public static function args()
    {
        $num = func_num_args();
        $args = func_get_args();
        if($num==1)
        {
            if(isset($_POST[$args[0]])){
                if(is_array($_POST[$args[0]]))return $_POST[$args[0]];
                else return trim($_POST[$args[0]]);
            }
            else{
                if(isset($_GET[$args[0]])){
                    if(is_array($_GET[$args[0]]))return $_GET[$args[0]];
                    else return trim($_GET[$args[0]]);
                }
            }
            return null;
        }
        else if($num>=2)
        {
            if($args[1]!==null)
            {
                $_POST[$args[0]] = $args[1];
                $_GET[$args[0]] = $args[1];
            }
            else
            {
                if(isset($_GET[$args[0]])) unset($_GET[$args[0]]);
                if(isset($_POST[$args[0]])) unset($_POST[$args[0]]);
            }
        }
        else
        {
            return $_POST+$_GET;
        }
    }
    public function only()
    {
        $hash= md5(serialize($_POST));
        $safebox = Safebox::getInstance();
        $__hash__ = $safebox->get('__HASH__');
        if($hash != $__hash__)
        {
            $safebox->set('__HASH__',$hash);
            return true;
        }
        else
        {
            return false;
        }
    }
}
?>