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
		<?php echo JS::import('form');?>
<?php echo JS::import('date');?>
<?php echo JS::import('dialog?skin=brief');?>
<?php echo JS::import('dialogtools');?>
<h1 class="page_title">分销代理编辑</h1>
<div id="obj_form" class="form2">
    <form action="<?php echo urldecode(Url::urlFormat("/distribution/agent_save"));?>" method="post" >
        <?php if(isset($id)){?><input type="hidden" name="id" id="objId" value="<?php echo isset($id)?$id:"";?>"><?php }?>
    <dl class="lineD">
      <dt><b class="red">*</b> 用户名：</dt>
      <dd>
        <?php if(isset($id) && isset($mobile) ){?>
        <label><?php echo isset($mobile)?$mobile:"";?></label>
        <?php }else{?>
        <input name="mobile" type="text" pattern="required" value="<?php echo isset($mobile)?$mobile:"";?>" alt="手机号（必填）" />
        <label></label>
        <?php }?>
      </dd>
      </dl>
      <?php if( isset($id) && isset($password)){?>
      <dl class="lineD">
      <dt>密码：</dt>
      <dd>
        <label><a href="javascript:;" onclick="password_dialog()">修改密码</a></label>
      </dd>
      </dl>
      <?php }else{?>
      <dl class="lineD">
      <dt><b class="red">*</b>密码：</dt>
      <dd>
        <input name="password" type="password"  bind="repassword" pattern="\w{6,}" value="" alt="密码必需大于6位">
        <label></label>
      </dd>
      </dl><dl class="lineD">
      <dt><b class="red">*</b>确认密码：</dt>
      <dd>
        <input name="repassword" type="password" bind="password" pattern="\w{6,}" value="" alt="密码必需大于6位">
        <label></label>
      </dd>
      </dl>
      <?php }?>
      <dl class="lineD">
      <dt>时间：</dt>
      <dd>
        <label><b>最后一次登录：</b><?php echo isset($login_time)?$login_time:"";?></label>&nbsp;&nbsp;&nbsp;&nbsp;<label><b>注册：</b><?php echo isset($reg_time)?$reg_time:"";?></label>
      </dd>
      </dl>
      <dl class="lineD">
      <dt><b class="red">*</b>真实姓名：</dt>
      <dd>
        <input name="real_name" type="text"  pattern="required" value="<?php echo isset($real_name)?$real_name:"";?>" alt="真实姓名不能为空">
        <label></label>
      </dd>
      </dl>
      <dl class="lineD">
      <dt><b class="red">*</b>微信号：</dt>
      <dd>
        <input name="weixin" type="text" pattern="required" value="<?php echo isset($weixin)?$weixin:"";?>" alt="微信号不能为空">
        <label></label>
      </dd>
      </dl>
      <dl class="lineD">
      <dt>代理等级：</dt>
      <dd>
        <select name="level" id="level">
          <option value="0">请代理等级...</option>
          <?php $item=null; $query = new Query("level");$items = $query->find(); foreach($items as $key => $item){?>
          <option value="<?php echo isset($item['id'])?$item['id']:"";?>"><?php echo isset($item['name'])?$item['name']:"";?></option>
          <?php }?>
        </select>
        <label></label>
      </dd>
    </dl>
      <dl class="lineD">
      <dt>上级代理：</dt>
      <dd>
      <select name="parent" id="parent">
        <option value="0">请上级代理...</option>
          <?php $item=null; $query = new Query("agent");$items = $query->find(); foreach($items as $key => $item){?>
          <option value="<?php echo isset($item['id'])?$item['id']:"";?>"><?php echo isset($item['real_name'])?$item['real_name']:"";?></option>
          <?php }?>
        </select>
        <label></label>
      </dd>
      </dl>
      <dl class="lineD">
      <dt>推荐代理：</dt>
      <dd>
      <select name="recom" id="recom">
        <option value="0">请推荐代理...</option>
          <?php $item=null; $query = new Query("agent");$items = $query->find(); foreach($items as $key => $item){?>
          <option value="<?php echo isset($item['id'])?$item['id']:"";?>"><?php echo isset($item['real_name'])?$item['real_name']:"";?></option>
          <?php }?>
        </select><label></label>
      </dd> 
      </dl>
      <dl class="lineD">
      <dt>地区：</dt>
      <dd >
        <div id="area">
        <select id="province"  name="province" ><option value="0">==省份/直辖市==</option></select>
        <select id="city" name="city"><option value="0">==市==</option></select>
        <select id="county" name="county"><option value="0">==县/区==</option></select><input pattern="^\d+,\d+,\d+$" id="test" type="text" style="visibility:hidden;width:0;" value="<?php echo isset($province)?$province:"";?>,<?php echo isset($city)?$city:"";?>,<?php echo isset($county)?$county:"";?>" alt="请选择完整地区信息！"><label></label></div>
      </dd>
      </dl>
      <dl class="lineD">
      <dt>详细地址：</dt>
      <dd>
        <input name="addr" type="text" empty  pattern="required" value="<?php echo isset($addr)?$addr:"";?>">
        <label></label>
      </dd>
      </dl>
      <dl class="lineD">
      <dt>积分：</dt>
      <dd>
        <input name="point" type="text"  class="small"  pattern="int" value="<?php echo isset($point)?$point:0;?>">
        <label></label>
      </dd>
      </dl>
    <div style="text-align:center"><input type="submit" value="提交" class="button">&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="重置" class="button"></div>
    </form>
</div>
<div id="password_info" style="display: none;width:520px;">
  <form class="form2" callback="changePassword">
  <dl class="lineD">
      <dt><b class="red">*</b>密码：</dt>
      <dd>
        <input name="password" type="password"  id="password" bind="repassword" pattern="\w{6,}">
        <label>密码必需大于6位</label>
      </dd>
      </dl><dl class="lineD">
      <dt><b class="red">*</b>确认密码：</dt>
      <dd>
        <input name="repassword" type="password" id="repassword" bind="password" pattern="\w{6,}" >
        <label>密码必需大于6位</label>
      </dd>
      </dl>
      <div style="text-align:center"><input type="submit" value="提交" class="button">&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="重置" class="button"></div>
      </form>
</div>
<script type="text/javascript">
var form =  new Form();
form.setValue('parent_id','<?php echo isset($parent_id)?$parent_id:"";?>');
form.setValue('type_id','<?php echo isset($type_id)?$type_id:"";?>');


  $("#area").Linkage({ url:"<?php echo urldecode(Url::urlFormat("/ajax/area_data"));?>",selected:[<?php echo isset($province)?$province:0;?>,<?php echo isset($city)?$city:0;?>,<?php echo isset($county)?$county:0;?>],callback:function(data){
    var text = new Array();
    var value = new Array();
    for(i in data[0]){
      if(data[0][i]!=0){
        text.push(data[1][i]);
        value.push(data[0][i]);
      }
    }
    $("#test").val(value.join(','));
    FireEvent(document.getElementById("test"),"change");
    }});
function password_dialog(){
  art.dialog({id:'password_dialog',title:'密码设定:',content:document.getElementById('password_info')});
}
function changePassword(e){
  var password = $("#password").val();
  var repassword = $("#repassword").val();
  var id = $("#objId").val();
  if(!e){
    $.post("<?php echo urldecode(Url::urlFormat("/distribution/agent_password"));?>",{id:id,password:password,repassword:repassword},function(data){
        if(data['status']=="success")
          art.dialog.tips("<p class='success'>密码修改成功！</p>");
        else art.dialog.tips("<p class='fail'>密码修改失败！</p>");
          art.dialog({id:"password_dialog"}).close();
    },"json");
  }
  return false;
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

