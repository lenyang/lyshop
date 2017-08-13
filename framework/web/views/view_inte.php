<?php
 //视图接口
interface IView
{
	public $data;
	public function render($filename);
}
?>