、<?php
//系统菜单类
class Menu
{
    private $nodes;
    private $subMenu;
    private $menu;

    private $_menu;
    private $_subMenu;
    private $link_key;

    public function __construct()
    {
        $nodes= array(
        '/admin/index'=>array('name'=>'管理首页','parent'=>'config'),
        '/admin/theme_list'=>array('name'=>'主题设置','parent'=>'config'),
        '/admin/config_globals'=>array('name'=>'站点设置','parent'=>'config'),
        '/admin/config_other'=>array('name'=>'其它配置','parent'=>'config'),
        '/admin/config_email'=>array('name'=>'邮箱配置','parent'=>'config'),
        '/admin/msg_template_list'=>array('name'=>'信息模板','parent'=>'config'),
        '/admin/msg_template_edit'=>array('name'=>'信息模板编辑','parent'=>'config'),
        '/admin/notice_template_list'=>array('name'=>'提醒管理','parent'=>'config'),
        '/admin/notice_template_edit'=>array('name'=>'提醒编辑','parent'=>'config'),
        '/admin/oauth_list'=>array('name'=>'开放登录','parent'=>'third'),
        '/admin/oauth_edit'=>array('name'=>'开放登录编辑','parent'=>'third'),
        '/admin/class_config_list'=>array('name'=>'第三方列表','parent'=>'third'),
        '/admin/class_config_edit'=>array('name'=>'第三方配制编辑','parent'=>'third'),

        '/admin/payment_list'=>array('name'=>'支付方式','parent'=>'delivery'),
        '/admin/payment_edit'=>array('name'=>'编辑支付方式','parent'=>'delivery'),
        '/admin/zoning_list'=>array('name'=>'区域划分','parent'=>'delivery'),
        '/admin/area_list'=>array('name'=>'地区管理','parent'=>'delivery'),
        '/admin/fare_list'=>array('name'=>'运费模板','parent'=>'delivery'),
        '/admin/fare_edit'=>array('name'=>'运费模板编辑','parent'=>'delivery'),
        '/admin/express_company_list'=>array('name'=>'快递公司','parent'=>'delivery'),
        '/admin/express_company_edit'=>array('name'=>'快递公司编辑','parent'=>'delivery'),

        '/admin/manager_list'=>array('name'=>'管理员','parent'=>'safe'),
        '/admin/manager_edit'=>array('name'=>'编辑管理员','parent'=>'safe'),
        '/admin/roles_list'=>array('name'=>'角色管理','parent'=>'safe'),
        '/admin/roles_edit'=>array('name'=>'角色编辑','parent'=>'safe'),
        '/admin/resources_list'=>array('name'=>'权限列表','parent'=>'safe'),
        '/admin/resources_edit'=>array('name'=>'编辑权限资源','parent'=>'safe'),
        '/admin/log_operation_list'=>array('name'=>'操作日志','parent'=>'safe'),
        '/admin/update'=>array('name'=>'版本升级','parent'=>'safe'),
        '/admin/clear'=>array('name'=>'清除缓存','parent'=>'safe'),

        '/content/article_list'=>array('name'=>'全部文章','parent'=>'article'),
        '/content/article_edit'=>array('name'=>'文章编辑','parent'=>'article'),
        '/content/category_list'=>array('name'=>'分类管理','parent'=>'article'),
        '/content/category_edit'=>array('name'=>'编辑分类','parent'=>'article'),
        '/content/help_list'=>array('name'=>'全部帮助','parent'=>'help'),
        '/content/help_edit'=>array('name'=>'帮助编辑','parent'=>'help'),
        '/content/help_category_list'=>array('name'=>'帮助分类管理','parent'=>'help'),
        '/content/help_category_edit'=>array('name'=>'编辑帮助分类','parent'=>'help'),
        '/content/ad_list'=>array('name'=>'广告管理','parent'=>'banner'),
        '/content/ad_edit'=>array('name'=>'编辑广告','parent'=>'banner'),
        '/content/tags_list'=>array('name'=>'标签管理','parent'=>'banner'),
        '/content/nav_list'=>array('name'=>'导航管理','parent'=>'banner'),
        '/content/nav_edit'=>array('name'=>'导航管理','parent'=>'banner'),


        '/admin/tables_list'=>array('name'=>'数据库备份','parent'=>'database'),
        '/admin/back_list'=>array('name'=>'数据库还原','parent'=>'database'),


        '/goods/goods_category_list'=>array('name'=>'分类管理','parent'=>'goods_config'),
        '/goods/goods_category_edit'=>array('name'=>'编辑分类','parent'=>'goods_config'),
        '/goods/goods_type_list'=>array('name'=>'类型管理','parent'=>'goods_config'),
        '/goods/goods_type_edit'=>array('name'=>'类型编辑','parent'=>'goods_config'),
        '/goods/goods_spec_list'=>array('name'=>'规格管理','parent'=>'goods_config'),
        '/goods/goods_spec_edit'=>array('name'=>'规格编辑','parent'=>'goods_config'),
        '/goods/brand_list'=>array('name'=>'品牌管理','parent'=>'goods_config'),
        '/goods/brand_edit'=>array('name'=>'品牌编辑','parent'=>'goods_config'),


        '/goods/goods_list'=>array('name'=>'商品管理','parent'=>'goods'),
        '/goods/goods_edit'=>array('name'=>'商品编辑','parent'=>'goods'),
        '/goods/virtual_template_list'=>array('name'=>'虚拟商品模板管理','parent'=>'goods'),
        '/goods/virtual_template_edit'=>array('name'=>'虚拟商品模板编辑','parent'=>'goods'),
        '/goods/virtual_goods_list'=>array('name'=>'虚拟货品管理','parent'=>'goods'),
        '/goods/virtual_goods_edit'=>array('name'=>'虚拟货品编辑','parent'=>'goods'),

        '/customer/customer_list'=>array('name'=>'会员管理','parent'=>'customer'),
        '/customer/customer_edit'=>array('name'=>'添加会员','parent'=>'customer'),
        '/customer/grade_list'=>array('name'=>'会员等级管理','parent'=>'customer'),
        '/customer/grade_edit'=>array('name'=>'添加会员等级','parent'=>'customer'),
        '/customer/withdraw_list'=>array('name'=>'提现申请','parent'=>'balance'),
        '/customer/balance_list'=>array('name'=>'资金日志','parent'=>'balance'),
        '/customer/review_list'=>array('name'=>'商品评价','parent'=>'ask_reviews'),
        '/customer/ask_list'=>array('name'=>'商品咨询','parent'=>'ask_reviews'),
        '/customer/ask_edit'=>array('name'=>'咨询回复','parent'=>'ask_reviews'),
        '/customer/message_list'=>array('name'=>'信息管理','parent'=>'ask_reviews'),
        '/customer/message_edit'=>array('name'=>'信息发送','parent'=>'ask_reviews'),
        '/customer/notify_list'=>array('name'=>'到货通知','parent'=>'ask_reviews'),
        '/order/order_list'=>array('name'=>'商品订单','parent'=>'order'),
        '/order/express_template_list'=>array('name'=>'快递单模板','parent'=>'express'),
        '/order/express_template_edit'=>array('name'=>'快递单模板编辑','parent'=>'express'),
        '/order/ship_list'=>array('name'=>'发货点管理','parent'=>'express'),
        '/order/ship_edit'=>array('name'=>'发货点编辑','parent'=>'express'),
        '/order/doc_receiving_list'=>array('name'=>'收款单','parent'=>'receipt'),
        '/order/doc_invoice_list'=>array('name'=>'发货单','parent'=>'receipt'),
        '/order/doc_refund_list'=>array('name'=>'退款单','parent'=>'receipt'),
        //'/order/doc_returns_list'=>array('name'=>'退货单','parent'=>'receipt'),

        '/count/index'=>array('name'=>'订单统计','parent'=>'count'),
        '/count/hot'=>array('name'=>'热销统计','parent'=>'count'),
        '/count/area_buy'=>array('name'=>'地区统计','parent'=>'count'),
        '/count/user_reg'=>array('name'=>'会员分布统计','parent'=>'customer_count'),


        '/marketing/voucher_template_list'=>array('name'=>'代金券模板','parent'=>'voucher'),
        '/marketing/voucher_template_edit'=>array('name'=>'代金券模板编辑','parent'=>'voucher'),
        '/marketing/voucher_list'=>array('name'=>'代金券管理','parent'=>'voucher'),
        '/marketing/voucher_edit'=>array('name'=>'代金券编辑','parent'=>'voucher'),
        '/marketing/prom_goods_list'=>array('name'=>'商品促销','parent'=>'promotions'),
        '/marketing/prom_goods_edit'=>array('name'=>'编辑商品促销','parent'=>'promotions'),
        '/marketing/prom_order_list'=>array('name'=>'订单促销','parent'=>'promotions'),
        '/marketing/prom_order_edit'=>array('name'=>'编辑订单促销','parent'=>'promotions'),
        '/marketing/bundling_list'=>array('name'=>'捆绑促销','parent'=>'promotions'),
        '/marketing/bundling_edit'=>array('name'=>'编辑捆绑促销','parent'=>'promotions'),
        '/marketing/groupbuy_list'=>array('name'=>'团购','parent'=>'promotions'),
        '/marketing/groupbuy_edit'=>array('name'=>'团购','parent'=>'promotions'),
        '/marketing/flash_sale_list'=>array('name'=>'限时抢购','parent'=>'promotions'),
        '/marketing/flash_sale_edit'=>array('name'=>'编辑限时抢购','parent'=>'promotions'),

        '/distribution/agent_list'=>array('name'=>'分销代理管理','parent'=>'agent'),
        '/distribution/agent_edit'=>array('name'=>'分销代理编辑','parent'=>'agent'),
        '/distribution/product_list'=>array('name'=>'分销商品管理','parent'=>'product'),
        '/distribution/product_edit'=>array('name'=>'分销商品编辑','parent'=>'product'),
        '/distribution/dis_level_list'=>array('name'=>'分销等级管理','parent'=>'level'),
        '/distribution/dis_level_edit'=>array('name'=>'分销等级编辑','parent'=>'level'),
        '/distribution/rebate_set'=>array('name'=>'分销返利管理','parent'=>'rebate'),
        '/distribution/rebate_list'=>array('name'=>'分销返利设置','parent'=>'rebate'),
        '/distribution/dis_order_list'=>array('name'=>'分销订单管理','parent'=>'disorder'),


        );
        //分组菜单
        $subMenu = array(
        'config'=>array('name'=>'参数设定','parent'=>'system'),
        'third'=>array('name'=>'第三方整合','parent'=>'system'),
        'delivery'=>array('name'=>'支付与配送','parent'=>'system'),
        'safe'=>array('name'=>'安全管理','parent'=>'system'),
        'database'=>array('name'=>'数据库管理','parent'=>'system'),

        'article'=>array('name'=>'文章管理','parent'=>'content'),
        'help'=>array('name'=>'帮助中心','parent'=>'content'),
        'banner'=>array('name'=>'内容管理','parent'=>'content'),
        'goods'=>array('name'=>'产品管理','parent'=>'goods'),
        'goods_config'=>array('name'=>'商品配置','parent'=>'goods'),
        'customer'=>array('name'=>'会员管理','parent'=>'customer'),
        'balance'=>array('name'=>'会员资金','parent'=>'customer'),
        'ask_reviews'=>array('name'=>'咨询与评价','parent'=>'customer'),
        'order'=>array('name'=>'订单管理','parent'=>'order'),
        'receipt'=>array('name'=>'单据管理','parent'=>'order'),
        'express'=>array('name'=>'快递单配置','parent'=>'order'),
        'count'=>array('name'=>'销售统计','parent'=>'count'),
        'customer_count'=>array('name'=>'客户统计','parent'=>'count'),
        'promotions'=>array('name'=>'促销活动','parent'=>'marketing'),
        'voucher'=>array('name'=>'代金券管理','parent'=>'marketing'),

        //分销中心
        'agent'=>array('name'=>'分销代理管理','parent'=>'distribution');
        'level'=>array('name'=>'分销等级管理','parent'=>'distribution');
        'product'=>array('name'=>'分销商品管理','parent'=>'distribution');
        'distriorder'=>array('name'=>'分销订单管理','parent'=>'distribution');
        'rebate'=>array('name'=>'分销返利管理','parent'=>'distribution');

        );
        //主菜单
        $menu =array(
        'goods'=>array('link'=>'/goods/goods_list','name'=>'商品中心'),
        'order'=>array('link'=>'/order/order_list','name'=>'订单中心'),
        'distribution'=>array('link'=>'/distribution/agent_list','name'=>'分销中心'),
        'customer'=>array('link'=>'/customer/customer_list','name'=>'客户中心'),
        'marketing'=>array('link'=>'/marketing/prom_goods_list','name'=>'营销推广'),
        'count'=>array('link'=>'/count/index','name'=>'统计报表'),
        'content'=>array('link'=>'/content/article_list','name'=>'内容管理'),
        'system'=>array('link'=>'/admin/index','name'=>'系统设置'),
        );

        $safebox = Safebox::getInstance();
        $manager = $safebox->get('manager');
        if(isset($manager['roles']) && $manager['roles'] != 'administrator'){
            $roles = new Roles($manager['roles']);
            $result = $roles->getRoles();
            if(isset($result['rights']))
                $rights = $result['rights'];
            else
                $rights = '';
            if(is_array($nodes)){
                $subMenuKey = array();
                foreach ($nodes as $key => $value) {
                    $_key = trim(strtr($key,'/','@'),'@');
                    if(stripos($rights, $_key)===false) unset($nodes[$key]);
                    else{
                        if(!isset($subMenuKey[$value['parent']]))$subMenuKey[$value['parent']] = $key;
                        else{
                            if(stristr($key,'_list'))$subMenuKey[$value['parent']] = $key;
                        }
                    }
                }
                $menuKey = array();
                foreach ($subMenu as $key => $value) {
                    if(isset($subMenuKey[$key])){
                        $menuKey[$value['parent']] = $key;
                    }else unset($subMenu[$key]);
                }
                foreach ($menu as $key => $value) {
                    if(!isset($menuKey[$key]))unset($menu[$key]);
                    else{
                        $menu[$key]['link'] = $subMenuKey[$menuKey[$key]];
                    }
                }
            }
        }
        //var_dump($subMenuKey,$menuKey,$menu);exit;
        if(is_array($nodes))$this->nodes = $nodes;
        else $this->nodes = array();
        if(is_array($subMenu))$this->subMenu = $subMenu;
        else $this->subMenu = array();
        if(is_array($menu))$this->menu = $menu;
        else $this->menu = array();

        foreach($this->nodes as $key => $nodes){
            $this->_subMenu[$nodes['parent']][] = array('link'=>$key,'name'=>$nodes['name'],'hidden'=>(isset($nodes['hidden']) && $nodes['hidden']== true)?true:false);
        }
        foreach($this->subMenu as $key => $subMenu){
            $this->_menu[$subMenu['parent']][] = array('link'=>$key,'name'=>$subMenu['name']);
        }
        $this->link_key = '/'.(Req::get('con')==null?strtolower(Tiny::app()->defaultController):Req::get('con')).'/'.(Req::get('act')==null?Tiny::app()->getController()->defaultAction:Req::get('act'));

    }
    public function current_menu($key=null)
    {
        $key = $this->link_key;
        if(isset($this->nodes[$key]))
        {
            $subMenu = $this->nodes[$key]['parent'];
            $menu = $this->subMenu[$subMenu]['parent'];
            return array('menu'=>$menu,'subMenu'=>$subMenu);
        }
        return null;
    }
    public function getMenu()
    {
        return isset($this->menu)?$this->menu:array();
    }
    public function getSubMenu($key)
    {
        return isset($this->_menu[$key])?$this->_menu[$key]:array();
    }
    public function getNodes($key)
    {
        return isset($this->_subMenu[$key])?$this->_subMenu[$key]:array();
    }
    public function currentNode()
    {

        $key = $this->link_key;
        return isset($this->nodes[$key])?$this->nodes[$key]:array();
    }
    public function getLink()
    {
        return $this->link_key;
    }
}
