<?php
/**
 * 分页类
 *
 * @author Crazy、Ly
 * @class Paging
 */
class Paging{

    public   $total_nums;    //总数据数：     必须传入该值，以数组的形式传入  用mysql_num_rows 获得该值
    public   $pagesize;      //每页显示条数 ： 必须传入该值
    private  $totalpage;     //总页数：$total_nums/$pagesize
    private  $page;          //当前的页数
    public   $pagename = 'p';      //可选："页"的名字 默认为"p"
    private  $first_row;     //必须写在select语句中的limit后
    private  $url='';           //当前页的url
    public   $plus;        //当前页与前后的"间距"
    private  $url1;          //取出page后的url 因为在select里要取得this.value的值
    private  $ajax=false;

    /**
     * 初始化数据
     *
     * @access public
     * @param array $data
     * @return mixed
     */
    public function  __construct($data=array())
    {
        $this->total_nums=$data["total_nums"];
        $this->pagesize=$data["pagesize"];
        $this->pagename=!empty($data["pagename"])?$data["pagename"]:"p";
        $this->totalpage=ceil($this->total_nums/$this->pagesize);
        $this->plus=!empty($data["plus"]) && $data["plus"]>=0 && $data["plus"]<$this->totalpage/2?intval($data["plus"]):ceil($this->totalpage/2);
        $this->page=isset($data['page'])?intval($data['page']):intval(!empty($_GET[$this->pagename])?$_GET[$this->pagename]:"1");
        $this->page=$this->page >= $this->totalpage?$this->page=$this->totalpage:$this->page;
        $this->page=$this->page<=0?"1":$this->page;
        $this->first_row=($this->page-1)*$this->pagesize;
        $this->ajax = (isset($data['ajax']) && $data['ajax']==true)?true:false;
        $this->ajaxFunction = (isset($data['ajaxFunction']) && $data['ajaxFunction']!='')?$data['ajaxFunction']:'void(0)';
        $this->url = isset($data['url'])?$data['url']:'';

    }

    public function currentPage()
    {
        return $this->page;
    }

    public function getFirstRow()
    {
        return $this->first_row;
    }
    /**
     * 取得url路径
     *
     * @access private
     * @param mixed $page
     * @return mixed
     */
    private function _get_url($page)
    {
        if($this->url=='')$url  =  Url::requestUri();//$_SERVER['REQUEST_URI'];
        else $url = $this->url;
        $url = urldecode($url);
        $arr = array('<'=>'','>'=>'',"'"=>'','"'=>'',' '=>'');
        $url = strtr($url,$arr);
        $parse = parse_url($url);
        $fragment = "";
        if(isset($parse['fragment']))
        {
            $fragment = '#'.$parse['fragment'];
        }

        if(isset($parse['query']))
        {
            parse_str($parse['query'],$params);//返回的$params是一个数组
            unset($params[$this->pagename]);
            $url   =  $parse['path'].'?'.http_build_query($params);
        }
        else$url .= '?';
        if(!empty($params))
        {
            $url .= '&';
        }
        $this->url1=$url.$this->pagename."=";
        $this->url = $url. $this->pagename . '=' . $page.$fragment;

        return $this->url ;
    }
    /**
     * 针对ajax方式的特殊处理
     *
     * @access private
     * @param mixed $page
     * @param mixed $text
     * @return mixed
     */
    private function _get_link($page,$text)
    {
        $url=$this->_get_url($page);
        if($this->ajax){
            $onclick = preg_replace('/#page#/',$page,$this->ajaxFunction);
            return "<a href='javascript:;' onclick='".$onclick."' page-index='".$page."'>$text</a> ";
        }
        else return "<a href=$url>$text</a> ";

    }
    /**
     * 生成连接 无效
     *
     * @access private
     * @param mixed $page
     * @param mixed $text
     * @return mixed
     */
    private function _get_link1($page,$text){
        $url=$this->_get_url($page);
        return "<span href=$url class='disabled'>$text</span> ";

    }
    /**
     * 反回第一面的连接
     *
     * @access private
     * @param string $name
     * @return mixed
     */
    private function first_page($name="第一页"){

        return $this->_get_link(1, $name);

    }
    /**
     * 有省略的第一页
     *
     * @access private
     * @return mixed
     */
    private function first_page2(){
        $plus=$this->plus;
        if($this->page - $plus <= 1){
            return "";
        }else{
            return $this->_get_link(1, 1)."<span class='pageMore'>...</span>\n";
        }


    }
    /**
     * 上一页连接
     *
     * @access private
     * @param string $name
     * @return mixed
     */
    private function up_page($name="上一页"){
        if($this->page>1){
            return $this->_get_link($this->page - 1, $name);
        }else{
            return $this->_get_link1(1, $name);
        }

    }
    /**
     * 生成下一页
     *
     * @access private
     * @param string $name
     * @return mixed
     */
    private function down_page($name="下一页"){
        if ($this->page<$this->totalpage){
            return $this->_get_link($this->page+1, $name);
        }else{
            return $this->_get_link1($this->page+1, $name);
        }
    }
    /**
     * 生成最后一页
     *
     * @access private
     * @param string $name
     * @return mixed
     */
    private function last_page($name="最后一页"){

        return $this->_get_link($this->totalpage, $name);
    }
    /**
     * 生成样式2的"最后一页"
     *
     * @access private
     * @return mixed
     */
    private function last_page2(){
        $plus=$this->plus;
        if($this->page+$plus >= $this->totalpage){
            return "";
        }else{
            return "<span class='pageMore'>...</span>\n".$this->_get_link($this->totalpage, $this->totalpage);
        }
    }
    /**
     * 生成中间的数字
     *
     * @access private
     * @return mixed
     */
    private function show_nums(){
        $plus=$this->plus;
        $content=" ";
        $begin=$this->page-$plus;
        $begin=$begin>=1?$begin:1;//开始的处理方法： 不能从负数开始
        $end=($this->page+$plus >= $this->totalpage)?$this->totalpage:($this->page+$plus);//尾部的处理方法：不能超过总页数
        if($begin>3){
             $content .= $this->_get_link(1, 1).$this->_get_link(2, 2).'...';
        }
        else if($begin>2){
            $content .= $this->_get_link(1, 1).$this->_get_link(2, 2);
        }
        else if($begin>1){
             $content .= $this->_get_link(1, 1);
        }
        for($i=$begin;$i<=$end;$i++){
            if($i==$this->page){
                $content .= "<span class='current'>$i</span>\n";
            }else{
                $content.=$this->_get_link($i, $i);
            }

        }
        if($end<$this->totalpage-1) $content .= '...'.$this->_get_link($this->totalpage, $this->totalpage);
        else if($end<$this->totalpage) $content .= $this->_get_link($this->totalpage, $this->totalpage);
        return $content;
    }
    /**
     * 第一种样式
     *
     * @access private
     * @return mixed
     */
    private function show_1(){

        //$return= $this->first_page();
        $return="";
        $return.= $this->up_page();
        $return.=$this->show_nums();
        $url1=$this->url1;
        $return.= $this->down_page();
        if($this->ajax){
            $return.= "&nbsp;&nbsp;&nbsp;&nbsp;共{$this->totalpage} 页&nbsp;&nbsp;&nbsp;&nbsp;跳到第 <input  style='width:24px;text-align:center' value='".$this->page."' onchange='$(this).next().attr(\"page-index\",this.value)'/> 页 <a href='javascript:;' page-index='".$this->page."'>确定</a>";
        }else{
            $rand = md5(time().rand(10000,99999));
            $return.= "&nbsp;&nbsp;&nbsp;&nbsp;共{$this->totalpage} 页&nbsp;&nbsp;&nbsp;&nbsp;跳到第 <input id='page_input_".$rand."' style='width:24px;text-align:center'  value='".$this->page."' /> 页 <a href='javascript:;' onclick='javascript:window.location.href=\"$url1\"+document.getElementById(\"page_input_".$rand."\").value;' >确定</a>";
        }

        //$return.= $this->last_page();

        return $return;
    }
    /**
     * 第二种样式
     *
     * @access private
     * @return mixed
     */
    private function show_2(){
        $return= $this->up_page($name="<上一页");
        $return.=" ";
        //$return.= $this->first_page2($name="1");
        $return.=" ";
        $return.=$this->show_nums();
        //$return.= $this->last_page2();
        $return.=" ";
        $return.= $this->down_page($name="下一页>");
        return $return;
    }
    /**
     * 第三种样式
     *
     * @access private
     * @return mixed
     */
    private function show_3(){
        $return="总计 $this->total_nums 条记录 $this->page ／ $this->totalpage 页";
        $return.=$this->first_page();
        $return.=$this->up_page();
        $return.=$this->down_page();
        $return.=$this->last_page();
        $url1=$this->url1;
        $return.="到第 <select id='select' onchange='window.location.href=\"$url1\"+this.value'>";
        for($i=1;$i<=$this->totalpage;$i++){
            if ($i == $this->page){
                $return.= "<option value='$i' selected>$i</option>";
            }else{
                $return.= "<option value='$i'>$i</option>";
            }
        }
        $return.= "</select> 页 ";
        return $return;
    }
    /**
     * 第四种样式
     *
     * @access private
     * @return mixed
     */
    private function show_4(){
        $return= $this->up_page($name="上一页");
        $return.=" ";
        $return.=$this->show_nums();
        $return.=" ";
        $return.= $this->down_page($name="下一页");
        return $return;
    }

    private function show_5(){
        $return= $this->up_page($name="上一页");
        $return.=" ";
        $return.="<span class='current'>".$this->page."</span>\n";
        $return.=" ";
        $return.= $this->down_page($name="下一页");
        return $return;
    }
    /**
     * 封装显示
     *
     * @access public
     * @param int $num
     * @return mixed
     */
    public function show($num=1){
        switch ($num){
        case "2":
            return $this->show_2();
            break;
        case "3":
            return $this->show_3();
            break;
        case "4":
            return $this->show_4();
            break;
        case "5":
            return $this->show_5();
            break;
        default :
            return $this->show_1();
            break;
        }
    }

}
