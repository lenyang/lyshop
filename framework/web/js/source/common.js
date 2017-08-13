/*
 ============================================================
 版本：Common1.0.js
 作者：宁玉忠
 Q  Q：176574013
 版权：WWW.WEBZHU.COM
 声名：本组件为个人开发用户只有使用权，不能修改。
 =============================================================
 */
//基本函数部分
var Class = {
    create: function(){
        return function(){
            this.initialize.apply(this, arguments);
        }
    }
}
function echo(content){
    document.write(content);
}

function echoln(content){
    document.writeln(content + "<br/>");
}

function $(id){
    return document.getElementById(id);
}

function $v(id){
    return document.getElementById(id).value;
}

//request类部分
var request = {
    getParameter: function(key){
        var uri = window.location.search;
        var re = new RegExp("" + key + "\=([^\&\?]*)", "ig");
        return decodeURI((uri.match(re)) ? (uri.match(re)[0].substr(key.length + 1)) : null);
    },
    getHost: function(){
        return window.location.protocol + "//" + window.location.host;
    },
    getPerUrl: function(){
        return document.referrer;
    },
    getPort: function(){
        return window.location.port;
    },
    getUri: function(){
        return window.location.href;
    },
    getCharSet: function(){
        return document.charset || document.characterSet;
    },
    getQuery: function(key){
        var str = window.location.search;
        var re = new RegExp(".*" + key + "=(.*)&?.*");
        return decodeURI(str.replace(re, "$1"));
    },
    getFileName: function(){
        return window.location.pathname.replace(/(.*\/)/g, "");
    }
};
//session类部分
var session = {
    datetime: 1800,
    setAttribute: function(name, value){
        var cookie = new Cookie();
        cookie["session" + name] = value;
        cookie.save(this.datetime);
    },
    getAttribute: function(name){
        var cookie = new Cookie();
        var value = cookie["session" + name];
        if (value) {
            cookie.save(this.datetime);
            return value;
        }
        else {
            return null;
        }
    },
    removeAttribute: function(name){
        var cookie = new Cookie();
        var value = cookie["session" + name];
        if (value) {
            cookie["session" + name] = null;
            cookie.save(this.datetime);
            return;
        }
    },
    removeAll: function(){
        var cookie = new Cookie();
        cookie.remove();
    }
    
};
//browser类部分
var browser = {
    checkBrowser: function(){
        this.ver = navigator.appVersion;
        this.dom = document.getElementById ? true : false;
		this.ie7 = (this.ver.indexOf("MSIE 7") > -1 && this.dom) ? true : false;
        this.ie6 = (this.ver.indexOf("MSIE 6") > -1 && this.dom) ? true : false;
        this.ie5 = (this.ver.indexOf("MSIE 5") > -1 && this.dom) ? true : false;
        this.ie4 = (document.all && !this.dom) ? true : false;
        this.ns5 = (this.dom && parseInt(this.ver) >= 5) ? true : false;
        this.ns4 = (document.layers && !this.dom) ? true : false;
        this.mac = (this.ver.indexOf("Mac") > -1) ? true : false;
        this.ope = (navigator.userAgent.indexOf("Opera") > -1) ? true : false;
        this.ie = (this.ie6 || this.ie5 || this.ie4);
        this.ns = (this.ns4 || this.ns5);
        this.bw = (this.ie6 || this.ie5 || this.ie4 || this.ns5 || this.ns4 || this.mac || this.ope);
        this.nbw = (!this.bw);
        return this;
    },
    setCopy: function(Msg){
        if (window.navigator.userAgent.toLowerCase().indexOf("ie") > -1) {
            clipboardData.setData('text', Msg);
        }
        else {
            prompt("请复制网站地址:", Msg);
        }
    },
    addBookmark: function(site, url){
        if (window.navigator.userAgent.toLowerCase().indexOf("ie") > -1) {
            window.external.AddFavorite(url, site);
        }
        else 
            if (window.navigator.userAgent.toLowerCase().indexOf("opera") > -1) {
                alert("请使用Ctrl+T将本页加入收藏夹");
            }
            else {
                alert("请使用Ctrl+D将本页加入收藏夹");
            }
    },
    allowCookie: function(){
        return window.navigator.cookieEnabled
    },
    getLanguage: function(){
        return window.navigator.systemLanguage || window.navigator.language;
    },
    getUserLanguage: function(){
        return window.navigator.userLanguage || window.navigator.language;
    }
};
//字符串类
var String = {
    left: function(str, n){
        if (str.length > 0) {
            if (n > str.length) 
                n = str.length;
            return str.substr(0, n)
        }
        else {
            return;
        }
    },
    right: function(str, n){
        if (str.length > 0) {
            if (n >= str.length) 
                return str;
            return str.substr(str.length - n, n);
        }
        else {
            return;
        }
    },
    trim: function(str){
        if (typeof str == "string") 
            return str.replace(/(\s*)/g, "");
    },
    ltrim: function(str){
        if (typeof str == "string") 
            return str.replace(/(^\s*)/g, "");
    },
    rtrim: function(str){
        if (typeof str == "string") 
            return str.replace(/(\s*$)/g, "");
    },
    strip: function(str){
        if (typeof str == "string") 
            return str.replace(/^\s+/, "").replace(/(^\s*)|(\s*$)/g, "");
    },
    stripTags: function(str){
        if (typeof str == "string") 
            return str.replace(/<\/?[^>]+>/gi, "").replace(/(^\s*)|(\s*$)/g, "");
    },
    lower: function(str){
        return str.toLowerCase();
    },
    upper: function(str){
        return str.toUpperCase();
    }
}
//Validate验证类
var Validate={
	isNum: function(str)
	{
		return typeof(str)=="number";
		
	},
	isString: function(str)
	{
		return typeof(str)=="string";
	},
	isNull : function(str)
	{
		return (str==""|str==null)==1?true:false;
	}
}
//Cookie类部分
function Cookie(){
    var self = this;
    var trim = function(str){
        return str.replace(/(^\s*)|(\s*$)/g, "");
    }
    var init = function(){
        var allcookies = document.cookie;
        if (allcookies == "") 
            return;
        var cookies = allcookies.split(';');
        for (var i = 0; i < cookies.length; i++) // Break each pair into an array 
             cookies[i] = cookies[i].split('=');
        for (var i = 0; i < cookies.length; i++) {
            self[trim(cookies[i][0])] = decodeURIComponent(cookies[i][1]);
        }
    }
    init();
    this.save = function(daysToLive, path, domain, secure){
        var dt = (new Date()).getTime() + daysToLive * 24 * 60 * 60 * 1000;
        for (var prop in this) {
            if (typeof this[prop] == 'function') 
                continue;
            var cookie = "";
            cookie = prop + '=' + encodeURIComponent(this[prop]);
            if (daysToLive || daysToLive == 0) 
                cookie += ";expires=" + new Date(dt).toUTCString();
            if (path) 
                cookie += ";path=" + path;
            if (domain) 
                cookie += "; domain=" + domain;
            if (secure) 
                cookie += ";secure";
            document.cookie = cookie;
        }
    }
    this.remove = function(path, domain, secure){
        self.save(0, path, domain, secure);
        for (var prop in this) {
            if (typeof this[prop] != 'function') 
                delete this[prop];
        }
    }
}

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
        HttpRequest.setRequestHeader("cache-control", "no-cache");
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