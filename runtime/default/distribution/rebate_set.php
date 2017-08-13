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
<?php echo JS::import('validator');?>
<h2 class="page_title"><?php echo isset($node_index['name'])?$node_index['name']:"";?></h2>
<div class="form2">
  	<form name="email_form" method="post" action="<?php echo urldecode(Url::urlFormat("/distribution/rebate_set_save/group/rebate"));?>">
    <dl class="lineD">
      <dt>返利起始金额：</dt>
      <dd>
        <input name="rebate_line" pattern="int" type="text" id="textfield" value="">
    <label>返利起始金额为开始返利的基本要求</label>
    </dd></dl>
    <dl class="lineD">
      <dt>一级返利：</dt>
      <dd>
        <input name="rebate_one" pattern="int" type="text" id="textfield" value="">
    </dd></dl>
    <dl class="lineD">
      <dt>二级返利：</dt>
      <dd>
        <input name="rebate_two" pattern="int" type="text" id="textfield" value="">
    </dd></dl>
    <dl class="lineD">
      <dt>三级返利：</dt>
      <dd>
        <input name="rebate_three" pattern="int" type="text" id="textfield" value="">
    </dd></dl>
    <dl class="lineD">
      <dt>返利等级条件：</dt>
      <dd>
		<select name="rebate_level">
			<option value="1" selected="">总代</option>
		</select>
    </dd></dl>
      <dl class="lineD">
      <dt>启用返利：</dt>
      <dd>
        <label><input type="radio" name="rebate_status" value="1" checked="checked">是</label>
        <label><input type="radio" name="rebate_status" value="0">否</label>
    </dd></dl>
    <div class="center">
      <input type="submit" name="submit" class="button action fn" value="确 定">
    </div>
	</form>
  </div>
  <pre>
        操作说明：
        1.可选择返利等级，不选择默认只要上下级为同一级别都会实行三级返利
        2.是否使用可通过是否开启选项控制
        3.此处一级为下单代理的直属上级，二级为所属代理的上级的上级，以此类推。

        执行流程：
        1.如果开启，才会进行三级返利，如果开启按钮为关闭状态，则不会进行三级返利!
        2.如果处于开启状态，系统会根据设置的返利金额进行对相应的代理返利
        3.如果设置等级条件，则代理需要达到设置的等级才会进行返利，否则，会默认只要上下级达到同一等级之后，只要是开启的三级返利，都会对相应的代理进行返利.
  </pre>
<script>
  <?php if(isset($message)){?>
  art.dialog.tips('<p class="success"><?php echo isset($message)?$message:"";?></p>');
  <?php }?>
  var form = new Form('email_form');
  <?php $config = Config::getInstance();?>
  var data = <?php echo JSON::encode($config->get('rebate'));?>;
  form.init(data);
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

