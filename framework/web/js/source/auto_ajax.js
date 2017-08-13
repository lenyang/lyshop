//Ajax类部分
function Ajax(){
    var HttpRequest = false;
    var Url = null;
    var ContentType = "text";
	var Content="";
    this.init = function()//创建XMLHttpRequest的功能函数
    {
        if (window.ActiveXObject && !window.XMLHttpRequest) {
            window.XMLHttpRequest = function(){
                var msxmls = ['Msxml2.XMLHTTP.5.0', 'Msxml2.XMLHTTP.4.0', 'Msxml2.XMLHTTP.3.0', 'Msxml2.XMLHTTP', 'Microsoft.XMLHTTP'];
                for (var i = 0; i < msxmls.length; i++) {
                    try {
                        return new ActiveXObject(msxmls[i]);
                    } 
                    catch (e) {
                    }
                }
                return null;
            };
        }
        HttpRequest = new XMLHttpRequest();
        if (!HttpRequest) {
            return false;
        }
        return HttpRequest;
    }
    this.getType = function(type)//得到请求的类型
    {
        type = type.toUpperCase();
        if (type != "HEAD" && type != "POST" && type != "GET") 
            type = "HEAD";
        return type;
    }
    this.getContentType = function(type)//要得到内容的类型XML/TEXT
    {
        type = type.toLowerCase();
        if ("xml" == type) {
            ContentType = "xml";
            return "text/xml";
        }
        else {
            ContentType = "text";
        }
        if ("text" == type) 
            return "text/plain";
        if ("app" == type) 
            return "application/x-www-form-urlencoded";
        return "text/plain";
    }
    this.getInfo = function(url, type, content, send, id)//主要的函数得到内容
    {
        HttpRequest = this.init();
        type = this.getType(type);
        HttpRequest.open(type, url, true);
        HttpRequest.onreadystatechange = function()//得到更新内容
        {
            if (HttpRequest.readyState == 4) {
                if (HttpRequest.status == 200) {
                    if (!id)return;
                    if ("HEAD" == type) {
                        if (id instanceof Function) {
                            id(HttpRequest.getAllResponseHeaders());
                        }
                        else {
                            if (document.getElementById(id)) {
                                document.getElementById(id).innerHTML = HttpRequest.getAllResponseHeaders();
                            }
                        }
                    }
                    else {
                        if ("text" == ContentType) {
                            if (id instanceof Function) {
                                id(HttpRequest.responseText);
                            }
                            else {
                                if (document.getElementById(id)) {
                                    document.getElementById(id).innerHTML = HttpRequest.responseText;
                                }
                            }
                        }
                        else {
                            if (id instanceof Function) {
                                id(HttpRequest.responseXML);
                            }
                            else {
                                if (document.getElementById(id)) {
                                    document.getElementById(id).innerHTML = HttpRequest.responseXML;
                                }
                            }
                        }
                    }
                }
                else 
                    if (HttpRequest.status == 404) {
                        alert("请求的URL地址不存在！");
                    }
                    else 
                        if (HttpRequest.status == 403) {
                            alert("请求的URL地址禁止访问！");
                        }
                        else 
                            if (HttpRequest.status == 401) {
                                alert("请求的URL地址未经受权！");
                            }
                            else {
                                alert("在请求URL的过程中，发生了如下错误：" + HttpRequest.status);
                            }
            }
        }
        HttpRequest.setRequestHeader("If-Modified-Since","0"); 
		HttpRequest.setRequestHeader("Cache-Control","no-cache")
        //HttpRequest.setRequestHeader("cache-control", "no-cache");
        if (this.getType(type) == "POST") {
            send = encodeURI(send);
            content = "app";
        }
        else {
            send = null;
        }
        HttpRequest.setRequestHeader("Content-Type", this.getContentType(content) + ";encoding=utf-8");
        HttpRequest.send(send);
    };
}
function getFormAsString(form)
{
    returnString = "";
    formElements = form.elements;
    var first = true;
    for (var i=0;i<formElements.length;i++) {
      var e = formElements[i];
      if(e.name == null || e.name==""){
        continue;
      }
      if(e.type == "radio" || e.type == "checkbox"){
        if(e.checked){//判断单选按钮是否被选中
          if(first == true){
          first = false;
           returnString += e.name + "=" + e.value;
        }else{
                 returnString += "&" + e.name + "=" + e.value;
             }
           }
        }else{
          if(first == true){
        first = false;
        returnString += e.name + "=" + e.value;
      }else{
            returnString += "&" + e.name + "=" + e.value;
          }
        }
    }
    return returnString;
}
(function ()
{
	 if (window.addEventListener) window.addEventListener("load", autoAjax, false);
	 else if (window.attachEvent) window.attachEvent("onload", autoAjax);
	function autoAjax()
	{
		var ajaxes=document.getElementsByName("ajax");
		for(var i=0;i<ajaxes.length;i++)
		{
			if(ajaxes[i].tagName=="A")
			{
				var target=ajaxes[i].getAttributeNode('target');
				var href=ajaxes[i].getAttributeNode('href');
				if(target && href)
				{
					if(undefined==ajaxes[i].onclick)
					{
						ajaxes[i].onclick=function()
						{
							var target=this.getAttributeNode('target');
							var href=this.getAttributeNode('href');
							var ajax=new Ajax();
							var mode=("function"!=eval("typeof("+target.value+")"))?(document.getElementById(target.value) ? target.value :false):eval(target.value);
							if(!mode) return true;
							/*
							var content="",method='get';
							if(href.value.indexOf("?")!=-1)
							{
								content=href.value.substring(href.value.indexOf("?")+1);
								method='post';
							}*/
							ajax.getInfo(href.value==""?window.location:href.value,"get","app","",function(content)
							{
								if(mode instanceof Function)eval(mode)(content);
								else  if(document.getElementById(mode))document.getElementById(mode).innerHTML=content;
								autoAjax();
							});
							return false;
						}
					}
				}
			}
			else if(ajaxes[i].tagName=="FORM")
			{

				var target=ajaxes[i].getAttributeNode('target');
				var action=ajaxes[i].getAttributeNode('action');
				if(target && action)
				{
					if(undefined==ajaxes[i].onclick)
					{
						ajaxes[i].onsubmit=function()
						{
							target=this.getAttributeNode('target');
							action=this.getAttributeNode('action');
							var ajax=new Ajax();
							var mode=("function"!=eval("typeof("+target.value+")"))?(document.getElementById(target.value) ? target.value :false):eval(target.value);
							if(!mode) return true;
							ajax.getInfo(action.value==""?window.location:action.value,"post","app",getFormAsString(this),function(content)
							{
								if(mode instanceof Function)mode(content);
								else if(document.getElementById(mode))document.getElementById(mode).innerHTML=content;
								autoAjax();
							});
							return false;
						}
					}
				}
			}
		}
	}
})();