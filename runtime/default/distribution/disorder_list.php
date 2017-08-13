<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><?php echo isset($admin_title)?$admin_title:"";?></title>
<link rel="stylesheet" type="text/css" href="<?php echo urldecode(Url::urlFormat("@static/css/base.css"));?>" />
<link rel="stylesheet" type="text/css" href="<?php echo urldecode(Url::urlFormat("@static/css/admin.css"));?>" />
<link rel="stylesheet" type="text/css" href="<?php echo urldecode(Url::urlFormat("@static/css/font_icon.css"));?>" />
<?php echo JS::import('jquery');?>
<script type="text/javascript" src="<?php echo urldecode(Url::urlFormat("@static/js/common.js"));?>"></script>
<!--[if lte IE 7]><script src="<?php echo urldecode(Url::urlFormat("@static/css/fonts/lte-ie7.js"));?>"></script><![endif]-->
</head>
<body >
<div id="header">
	<div class="nav_sub">
			    	您好[<?php echo isset($manager['name'])?$manager['name']:"";?>]&nbsp; | <a href="<?php echo urldecode(Url::urlFormat("/index/index"));?>" target="_blank">返回前台</a> | <a href="<?php echo urldecode(Url::urlFormat("/admin/logout"));?>">退出</a>
	</div>
    <div id="Logo"><a href=""><img src="<?php echo urldecode(Url::urlFormat("@static/images/logo_min.png"));?>"></a></div>
	<ul id="main_nav" class="clearfix">
	<?php foreach($mainMenu as $key => $item){?>
		<li <?php if($key==$menu_index['menu']){?>class="active"<?php }?>><a href="<?php echo urldecode(Url::urlFormat("$item[link]"));?>"  ><?php echo isset($item['name'])?$item['name']:"";?></a></li>
	<?php }?>
	</ul>
</div>
<div id="mainContent">
	<div id="sidebar" >
		<ul class="menu" style="margin-top:15px;">
		<?php foreach($subMenu as $key => $item){?>
			<li class="submenu">
			<ul><li class="sub-index"><b><a href="javascript:;"><?php echo isset($item['name'])?$item['name']:"";?></a></b></li>
			<?php foreach($menu->getNodes($item['link']) as $key => $item){?>
			<?php if(substr($item['link'],-5)!='_edit' && !$item['hidden'] ){?>
				<li><a href='<?php echo urldecode(Url::urlFormat("$item[link]"));?>' <?php if($item['link']==$nav_link){?>class="current"<?php }?> ><?php echo isset($item['name'])?$item['name']:"";?></a></li>
				<?php }?>
			<?php }?>
			</ul>
			</li>
		<?php }?>
		</ul>
	</div>
	<div id="content" >

		<?php if(!isset($msg)){?><?php $msg=Req::post('msg');?><?php }?>
		<?php if(!isset($validator)){?><?php $validator=Req::post('validator');?><?php }?>
		<?php if(isset($msg[0])){?>
		<div id="message-bar" class="message_<?php echo isset($msg[0])?$msg[0]:"";?>"><?php echo isset($msg[1])?$msg[1]:"";?></div>
		<?php }elseif(isset($validator)){?>
		<div class="message_warning"><?php echo isset($validator['msg'])?$validator['msg']:"";?></div>
		<?php }?>
		<?php echo JS::import('dialog?skin=brief');?>
<?php echo JS::import('dialogtools');?>
<?php echo JS::import('form');?>
<form action="" method="post">
<div class="tools_bar clearfix">
    <a class="icon-checkbox-checked icon-checkbox-unchecked" href="javascript:;" onclick="tools_select('id[]',this)" title="全选" data="true"> 全选 </a>
    <a  class="icon-remove-2" href="javascript:;" onclick="tools_submit({action:'<?php echo urldecode(Url::urlFormat("/distribution/disorder_del"));?>',msg:'删除后无法恢复，你真的删除吗？'})" title="删除"> 删除</a>
    <a class="icon-delicious" href="<?php echo urldecode(Url::urlFormat("/distribution/disorder_list"));?>"> 全部记录</a>
    <span class="fr"><a href='javascript:;' id="condition" class="icon-search" style="" > 筛选条件</a><input id="condition_input" type="hidden" name="condition" value="<?php echo isset($condition)?$condition:"";?>"></span>
</div>
<table class="default" >
    <tr>
        <th style="width:30px">选择</th>
        <th style="width:70px">操作</th>
        <th style="width:100px">订单编号</th>
        <th style="width:80px">用户</th>
        <th style="width:100px">商品</th>
        <th style="width:80px">数量</th>
        <th style="width:80px">总金额</th>
        <th style="width:60px">状态</th> 
        <th style="width:100px">时间</th>    
    </tr>
    <?php $item=null; $obj = new Query("disorder as wd");$obj->fields = "wd.*,us.real_name as uname,dp.name as pname";$obj->join = "left join agent as us on wd.user_id = us.id  left join dispro as dp on wd.dispro_id = dp.id";$obj->where = "$where";$obj->page = "1 desc";$items = $obj->find(); foreach($items as $key => $item){?>
        <tr><td style="width:30px"><input type="checkbox" name="id[]" value="<?php echo isset($item['id'])?$item['id']:"";?>"></td>
        <td style="width:70px" class="btn_min"><div class="operat hidden"><a  class="icon-cog action" href="javascript:;"> 处理</a><div class="menu_select"><ul>
                <?php if($item['status']==0){?>
                <li><a class="icon-pencil" href="javascript:withdrawAction(<?php echo isset($item['id'])?$item['id']:"";?>);"> 审批</a></li>
                <?php }?>
                <li> <a class="icon-remove-2" href="javascript:confirm_action('<?php echo urldecode(Url::urlFormat("/distribution/disorder_del/id/$item[id]"));?>')"> 删除</a></li>
            </ul></div></div> </td>
        <td style="width:100px"><?php echo isset($item['order_no'])?$item['order_no']:"";?></td><td style="width:80px"><?php echo isset($item['uname'])?$item['uname']:"";?></td><td style="width:100px"><?php echo isset($item['pname'])?$item['pname']:"";?></td><td style="width:80px"><?php echo isset($item['qty'])?$item['qty']:"";?></td><td ><?php echo isset($item['totalmoney'])?$item['totalmoney']:"";?></td><td style="width:60px"><?php if($item['status']==1){?><b class="green">成功</b><?php }else{?><b class="red">等待</b><?php }?></td>
        </tr>
    <?php }?>
</table>
</form>
<div class="page_nav">
<?php echo $obj->pageBar();?>
</div>
<script type="text/javascript">
    var form =  new Form();
    $("#condition").on("click",function(){
        $("body").Condition({input:"#condition_input",okVal:'高级搜索',callback:function(data){tools_submit({action:'<?php echo urldecode(Url::urlFormat("/customer/withdraw_list"));?>',method:'get'});},data:{'us.real_name':{name:'用户名'},'dp.name':{name:'商品名'},'wd.status':{name:'状态',values:{0:'等待',1:'成功'}}
        }});
    });
    function withdrawAction(id)
    {
        art.dialog.open("<?php echo urldecode(Url::urlFormat("/distribution/disorder_audit/id/"));?>"+id,{id:'withdraw-dialog',title:"审批",width:620});
    }
    function close_dialog()
    {
        art.dialog({id:"withdraw-dialog"}).close();
        tools_reload();
    }
</script>

	</div>
</div>
<script type="text/javascript">
	$(function () {
		if('<?php echo Req::args("con");?>'=='admin'){
			$(".submenu .current").parent().parent().parent().addClass('current');
		}else{
			$(".submenu").addClass('current');
		}
		$(".submenu .sub-index").on("click",function(){
			$(this).parent().parent().toggleClass('current');
		})
	})

</script>
</body>
</html>

