<?php
 /**
  * Action统一接口
  */
interface IAction
{
	public function getController();
	
	public function run();
}