<?php
/**
 * description...
 * 
 * @author Crazy、Ly
 * @package ErrorController
 */
class ErrorController extends Controller{
    
    public $layout='index';

	public function init(){
        header("Content-type: text/html; charset=".$this->encoding);
        $this->model = new Model();
        $this->safebox =  Safebox::getInstance();
        $this->user = $this->safebox->get('user');
        $category = Category::getInstance();

        $this->category = $category->getCategory();
        $cart = Cart::getCart();
        $this->assign("cart",$cart->all());
        $this->assign("category",$this->category);
    }
}