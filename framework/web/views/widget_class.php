<?php
/**
 * widget类
 * 
 * @author Crazy、Ly
 * @class Widget
 */
class Widget
{
	private $controller;

	public function __construct($controller)
	{
		$this->controller=$controller;
	}
	public function __call($name,$args)
	{
		
	}
}
?>