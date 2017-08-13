<?php
/**
 * 安全类 
 * @author Crazy、Ly
 * @class safebox
 */
class Safebox
{
    private static $box;
    private static $obj;

    private function __construct(){}
    private function __clone(){}

    public static function getInstance($type='session')
    {
        if(!self::$obj instanceof self)
        {
            $type = strtolower($type);
            if($type == 'session')
            {
                self::$box = new Session();
            }
            else
            {
                self::$box = new Cookie();
                self::$box->setSafeCode(Tiny::app()->getSafeCode());
            }
            self::$obj = new self();
        }
        return self::$box;
    }
}
?>