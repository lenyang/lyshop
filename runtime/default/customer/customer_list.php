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
    <a  class="icon-remove-2" href="javascript:;" onclick="tools_submit({action:'<?php echo urldecode(Url::urlFormat("/customer/customer_del"));?>',msg:'删除后无法恢复，你真的删除吗？'})" title="删除"> 删除</a>
    <a href='<?php echo urldecode(Url::urlFormat("/customer/customer_edit"));?>' class="icon-plus" > 添加</a>
    <a class="icon-delicious" href="<?php echo urldecode(Url::urlFormat("/customer/customer_list"));?>"> 全部用户</a>
    <span class="fr"><a href='javascript:;' id="condition" class="icon-search" style="" > 筛选条件</a><input id="condition_input" type="hidden" name="condition" value="<?php echo isset($condition)?$condition:"";?>"></span>
</div>
<table class="default" >
    <tr>
        <th style="width:30px">选择</th>
        <th style="width:70px">操作</th>
        <th style="width:100px">用户名</th>
        <th style="width:100px">真实姓名</th>
        <th style="width:60px">积分</th>
        <th style="width:100px">联系电话</th>
        <th>邮箱地址</th>
        <th style="width:130px">注册时间</th>
        <th style="width:60px">状态</th>
        <th style="width:80px">会员等级</th>
        <th style="width:80px">账户余额</th>

    </tr>
    <?php $query = new Query("grade");$items = $query->find();?>
    <?php $grade_name=array();?>
    <?php foreach($items as $key => $item){?>
        <?php $grade_name[$item['id']]=$item['name'];?>
    <?php }?>
    <?php $item=null; $obj = new Query("customer as c,user as u");$obj->where = "c.user_id = u.id and $where";$obj->page = "1 desc";$items = $obj->find(); foreach($items as $key => $item){?>
        <tr><td style="width:30px"><input type="checkbox" name="id[]" value="<?php echo isset($item['id'])?$item['id']:"";?>"></td>
        <td style="width:70px" class="btn_min"><div class="operat hidden"><a  class="icon-cog action" href="javascript:;"> 处理</a><div class="menu_select"><ul>
                <li><a class="icon-coin" href="javascript:balance_op(<?php echo isset($item['user_id'])?$item['user_id']:"";?>,2);"> 充值</a></li>
                <li><a class="icon-credit" href="javascript:balance_op(<?php echo isset($item['user_id'])?$item['user_id']:"";?>,4);"> 退款</a></li>
                <li><a class="icon-pencil" href="<?php echo urldecode(Url::urlFormat("/customer/customer_edit/id/$item[id]"));?>"> 编辑</a></li>
                <li><a class="icon-remove-2" href="javascript:confirm_action('<?php echo urldecode(Url::urlFormat("/customer/customer_del/id/$item[id]"));?>')"> 删除</a></li>
            </ul></div></div> </td>
        <td style="width:100px"><?php echo isset($item['name'])?$item['name']:"";?></td><td style="width:100px"><?php echo isset($item['real_name'])?$item['real_name']:"";?></td><td style="width:60px"><?php echo isset($item['point'])?$item['point']:"";?></td><td style="width:130px"><?php echo isset($item['mobile'])?$item['mobile']:"";?></td><td ><?php echo isset($item['email'])?$item['email']:"";?></td><td style="width:100px"><?php echo isset($item['reg_time'])?$item['reg_time']:"";?></td><td style="width:60px"><?php echo $item['status']==0?"未激活":($item['status']==1?"正常":"锁定");?></td><td style="width:80px"><?php echo isset($grade_name[$item['group_id']])?$grade_name[$item['group_id']]:'默认会员';?></td>
        <td style="width:80px"><?php echo isset($item['balance'])?$item['balance']:"";?></td></tr>
    <?php }?>
</table>
</form>
<div class="page_nav">
<?php echo $obj->pageBar();?>
</div>


<div id="balance_box" style="display: none;width:420px;padding: 5px;" class="box">
    <h2 class="page_title tc" style="border:none" id="balance-title">充值</h2>
    <div class="form2">
        <form  id="export_form" action="<?php echo urldecode(Url::urlFormat("/customer/balance_act"));?>" method="post" callback="create_voucher">
          <input type="hidden" id="user_id" name="user_id" value="">
          <input type="hidden" id="type" name="type" value="">
          <dl class="lineD">
          <dt>金额：</dt>
          <dd><input id="amount" pattern="float" min="0.01"   name="amount" value=""> <label>最少金额为0.01</label></dd>
          </dl>
        <div class="tc mt10"><button class="button" id="balance-btn">充值</button></div>
        </form>
    </div>
</div>

<script type="text/javascript">
    function balance_op(user_id,type){
        $("#user_id").val(user_id);
        $("#type").val(type);
        var title = "充值";
        if(type==4) title = "退款";
        $("#balance-title").text(title);
        $("#balance-btn").text(title);
        $("#amount").val('');
        art.dialog({id:'balance_op',lock:true,opacity:0.1,title:title,width:400,height:200,padding:"15px",content:document.getElementById("balance_box")});
    }
    function create_voucher(e){
      if(e == null){
        var fields = $("#export_form").serializeArray();
        $.get("<?php echo urldecode(Url::urlFormat("/customer/balance_op"));?>",fields,function(data){
          if(data['status']=='success'){
            art.dialog({id:'balance_op'}).close();
            art.dialog.tips("<p class='"+data['status']+"'>"+data['msg']+"</p>",2);
            setTimeout("tools_reload()",2000);
          }else{
            art.dialog.tips("<p class='"+data['status']+"'>"+data['msg']+"</p>");
          }
        },'json');
      }
      return false;
    }
</script>

<script type="text/javascript">
    var form =  new Form();
    $("#condition").on("click",function(){
    $("body").Condition({input:"#condition_input",okVal:'高级搜索',callback:function(data){tools_submit({action:'<?php echo urldecode(Url::urlFormat("/customer/customer_list"));?>',method:'get'});},data:{'name':{name:'用户名'},real_name:{name:'真实姓名'},email:{name:'邮箱'},mobile:{name:'手机号码'},reg_time:{name:'注册时间'}
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

