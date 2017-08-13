window.onload=function(){
	if(document.body.scrollHeight>500)
	{
		parent.document.all.showcontent.style.height=document.body.scrollHeight+30;
		parent.document.all.left.style.height=document.body.scrollHeight+50;
	}
	else
	{
		parent.document.all.showcontent.style.height=530;
		parent.document.all.left.style.height=550;
	}
	
}