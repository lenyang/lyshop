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
    <a  class="icon-remove-2" href="javascript:;" onclick="tools_submit({action:'<?php echo urldecode(Url::urlFormat("/distribution/dispro_del"));?>',msg:'删除后无法恢复，你真的删除吗？'})" title="删除"> 删除</a>
    <a href='<?php echo urldecode(Url::urlFormat("/distribution/dispro_edit"));?>'  class="icon-plus" > 添加</a>
    <a href='javascript:;' onclick="tools_submit({action:'<?php echo urldecode(Url::urlFormat("/distribution/dispro_audit/status/0"));?>'});" class="icon-point-up" > 上架</a>
    <a href='javascript:;' onclick="tools_submit({action:'<?php echo urldecode(Url::urlFormat("/distribution/dispro_audit/status/1"));?>'});" class="icon-point-down" > 下架</a>
    <a class="icon-delicious" href="<?php echo urldecode(Url::urlFormat("/distribution/dispro_list"));?>"> 全部商品</a>

    <span class="fr"><a href='javascript:;' id="condition" class="icon-search" style="" > 筛选条件</a><input id="condition_input" type="hidden" name="condition" value="<?php echo isset($condition)?$condition:"";?>"></span>
</div>
<table class="default" >
    <tr>
        <th style="width:30px;">选择</th>
        <th style="width:70px;">操作</th>
        <th style="width:80px;">商品编号</th>
        <th style="width:80px;">商品名称</th>
        <th style="width:80px;">规格</th>
        <th style="width:60px;">成本价</th>
        <th style="width:60px;">市场价</th>
        <th style="width:60px;">库存</th>
        <th style="width:60px;">状态</th>
    </tr>
    <?php $item=null; $obj = new Query("dispro");$obj->where = "$where";$obj->page = "1";$obj->order = "id desc";$items = $obj->find(); foreach($items as $key => $item){?>
        <tr ><td style="width:30px;"><input type="checkbox" name="id[]" value="<?php echo isset($item['id'])?$item['id']:"";?>"></td>
        <td style="width:70px" class="btn_min"><div class="operat hidden"><a  class="icon-cog action" href="javascript:;"> 处理</a><div class="menu_select"><ul>
                <li><a class="icon-point-up" href="<?php echo urldecode(Url::urlFormat("/distribution/dispro_audit/status/1/id/$item[id]"));?>"> 上架</a></li>
                <li><a class="icon-point-down" href="<?php echo urldecode(Url::urlFormat("/distribution/dispro_audit/status/0/id/$item[id]"));?>"> 下架</a></li>
                <li><a class="icon-pencil" href="<?php echo urldecode(Url::urlFormat("/distribution/dispro_edit/id/$item[id]"));?>"> 编辑</a></li>
                <li><a class="icon-remove-2" href="javascript:;" onclick="confirm_action('<?php echo urldecode(Url::urlFormat("/distribution/dispro_del/id/$item[id]"));?>')"> 删除</a></li>
               </ul></div></div></td>
        <td style="width:80px;"><?php echo isset($item['dispro_no'])?$item['dispro_no']:"";?></td><td><?php echo isset($item['name'])?$item['name']:"";?></td><td style="width:60px;"><?php echo isset($item['type'])?$item['type']:"";?></td><td style="width:60px;"><?php echo isset($item['cost_price'])?$item['cost_price']:"";?></td>
        <td style="width:60px;"><?php echo isset($item['market_price'])?$item['market_price']:"";?></td><td style="width:60px;" <?php if($item['store_nums']<=$item['warning_line']){?>class="red"<?php }?>><b><?php echo isset($item['store_nums'])?$item['store_nums']:"";?></b></td><td style="width:60px;"><?php if($item['status']==1){?><b class="green">在售</b><?php }else{?><b class="red">下架</b><?php }?></td></tr>
    <?php }?>
</table>
</form>
<div class="page_nav">
<?php echo $obj->pageBar();?>
</div>
<script type="text/javascript">
    var form =  new Form();
    form.setValue('s_type','<?php echo isset($s_type)?$s_type:"";?>');
    $("#condition").on("click",function(){
        $("body").Condition({input:"#condition_input",okVal:'高级搜索',callback:function(data){tools_submit({action:'<?php echo urldecode(Url::urlFormat("/distribution/dispro_list"));?>',method:'get'});},data:{name:{name:'商品名称'},store_nums:{name:'库存'},dispro_no:{name:'产品编号'},'status':{name:'状态',values:{1:'在售',0:'下架'}}
    }});
});
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

