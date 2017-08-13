<!DOCTYPE html PUBLIC
	"-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Page Not Found</title>
<style type="text/css">
/*<![CDATA[*/
table.error
{
	width:100%;
	border:#666 1px solid;background:#EDEDED;
    border-collapse:collapse;
    border-spacing:0;
}
table.error tr.top
{
	background:#F90;
	font-size:18px;
	text-align:left;
	word-break: break-all;
	font-weight: bold;
	font-family:arial,"Times New Roman",Georgia,Serif;
}
table.error tr.head
{
	font-weight: bold;
	font-size:16px;
	font-family:arial,"Times New Roman",Georgia,Serif;
	background:#0BF;
}
table.error td
{
	border:#666 1px solid;
	padding-left:1em;
}
/*]]>*/
</style>
</head>
<body>
<div style='text-align:left;line-height:1.5em'>
<table class='error' >
<tr class='top'><th colspan=4><span style='background:#F00;padding:0 5px;color:#ff0;display:inline-block'> ( ! ) </span>&nbsp;<?php echo $errorType;?>:<?php echo $message;?>! in <?php echo $file;?> on line <?php echo $line;?></th></tr>
<tr class='top' style='background:#FB0;'><td colspan=4>Details <?php echo $codes;?></td></tr>
<tr class='head'><td colspan=4>CallStack</td></tr>
<tr class='head'><td>#</td><td>Object</td><td>Function</td><td>File</td></tr>
<?php foreach($errorStack as $item){?>
<tr><td><?php echo $item['num'];?></td><td><?php echo $item['object'];?></td><td><?php echo $item['function'];?></td><td><?php echo $item['file'];?>:(<?php echo $item['line'];?>)</td></tr>
<?php }?>
</table>
</div>
</body>
</html>