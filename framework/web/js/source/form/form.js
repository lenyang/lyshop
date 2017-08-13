/**
* Form表单类及自动验证插件 1.5
* Date: 2016-06-24 13:29
* http://www.tinylofty.com/
* (c) 2009-2013 TinyLofty, http://www.tinylofty.com
*/
function FireEvent(elem, eventName)
{
    if(typeof(elem) == 'object')
    {
        eventName = eventName.replace(/^on/i,'');
        if (document.all)
        {
            eventName = "on"+eventName;
            elem.fireEvent(eventName);
        }
        else
        {
            var evt = document.createEvent('HTMLEvents');
            evt.initEvent(eventName,true,true);
            elem.dispatchEvent(evt);
        }
    }

}

(function ( )
{
    var formMsg = null;
    //if (window.addEventListener) window.addEventListener("load", init, false);
    //else if (window.attachEvent) window.attachEvent("onload", init);
    addEvent(window,'load',init);
    function addEvent(obj, type, fn)
    {
        if (obj.attachEvent)
        {
            obj['e'+type+fn] = fn;
            obj[type+fn] = function(){obj['e'+type+fn]( window.event );}
            obj.attachEvent('on'+type, obj[type+fn]);
        }
        else
            obj.addEventListener(type, fn, false);
    }

    function removeEvent(obj, type, fn)
    {
        if (obj.detachEvent)
        {
            obj.detachEvent('on'+type, obj[type+fn]);
            obj[type+fn] = null;
        }
        else
            obj.removeEventListener(type, fn, false);
    }
    function init( ) {
        for(var i = 0; i < document.forms.length; i++) {
            var f = document.forms[i];
            var needsValidate = f.getAttribute("needsValidate");

            var needsValidation = false;
            for(j = 0; j < f.elements.length; j++) {
                var e = f.elements[j];
                if (e.type != "text" && e.type!="password" && e.type!='select-one' && e.type!='textarea' && e.type!=undefined && e.type!=null ) continue;
                var pattern = e.getAttribute("pattern");
                e.setAttribute("inform",i);
                var autoCheck = (e.getAttribute("autoCheck") == null ||  e.getAttribute("autoCheck")!='false') ;
                var required = e.getAttribute("required") != null;
                if (required && !pattern) {
                    pattern = "\\S";
                    e.setAttribute("pattern", pattern);
                }
                if (pattern && autoCheck)
                {
                    //e.onchange = validateOnChange;
                    addEvent(e,'change',validateOnChange);
                    needsValidation = true;
                }
                addEvent(e,'focus',onFocus);
                addEvent(e,'blur',onBlur);
            }
            if(needsValidate) needsValidation = true;
            if (needsValidation){f.onsubmit = validateOnSubmit;f.setAttribute('novalidate','true');}
        }
    }

    function  onFocus(event){
        event= event || arguments.callee.caller.arguments[0]||window.event;
        var e=event.srcElement||event.target||event;
        var textfield = e;
        if(e.parentNode.className.indexOf('focus')==-1)e.parentNode.className = textfield.parentNode.className += " focus";
    }

    function  onBlur(event){
        event= event || arguments.callee.caller.arguments[0]||window.event;
        var e=event.srcElement||event.target||event;
        var textfield = e;
        if(e.parentNode.className.indexOf('focus')!=-1)e.parentNode.className = textfield.parentNode.className.replace(" focus","");
    }

    function updateFormMsg(textfield,msg)
    {
        if(textfield.getAttribute("inform")!=undefined){
            var inform = textfield.getAttribute("inform");
            formMsg = document.forms[inform].getAttribute("formMsg");
            if(formMsg)formMsg = document.getElementById(formMsg);
        }
        if(formMsg){
            if(msg.className.indexOf('invalid-msg') !=-1 ){
                formMsg.style.display = '';
            }
            else{
                formMsg.style.display = 'none';
            }
            formMsg.innerHTML = msg.innerHTML;
        }
    }
    function validateOnChange(event)
    {
        event= event || arguments.callee.caller.arguments[0]||window.event;
        var e=event.srcElement||event.target||event;
        var textfield = e;
        var pattern = textfield.getAttribute("pattern");
        switch(pattern)
        {
            case 'required': pattern = /\S+/i;break;
            case 'name': pattern = /^[a-zA-Z_][a-zA-Z0-9_-]{5,}$/i;break;
            case 'email': pattern = /^\w+([-+.]\w+)*@\w+([-.]\w+)+$/i;break;
            case 'qq':  pattern = /^[1-9][0-9]{4,}$/i;break;
            case 'id': pattern = /^\d{15}(\d{2}[0-9x])?$/i;break;
            case 'ip': pattern = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/i;break;
            case 'zip': pattern = /^\d{6}$/i;break;
            case 'phone': pattern = /^((\d{3,4})|\d{3,4}-)?\d{7,8}(-\d{3})*$/i;break;
            case 'mobi': pattern = /^1[3-9]\d{9}$/i;break;
            case 'url': pattern = /^[a-zA-z]+:\/\/(\w+(-\w+)*)(\.(\w+(-\w+)*))+(\/?\S*)?$/i;break;
            case 'date': pattern = /^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/i;break;
            case 'datetime': pattern = /^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29) (?:(?:[0-1][0-9])|(?:2[0-3])):(?:[0-5][0-9]):(?:[0-5][0-9])$/i;break;
            case 'int': pattern = /^\d+$/i;break;
            case 'float': pattern = /^(-)?\d+\.?\d*$/i;break;
            default: pattern = new RegExp('^'+pattern+'$','i');
        }
        var value = textfield.value;
        var alt = textfield.getAttribute("alt");
        var minlen = textfield.getAttribute("minlen");
        var maxlen = textfield.getAttribute("maxlen");
        var min = textfield.getAttribute("min");
        var max = textfield.getAttribute("max");
        var empty = textfield.getAttribute("empty");
        var disabled = textfield.getAttribute("disabled");
        var flag = false;

        if(disabled!=null && disabled=="disabled") return;

        if(maxlen!=null && value.length>maxlen) flag=true;
        if(minlen!=null && value.length<minlen) flag=true;
        if(min!=null && parseFloat(value)<min) flag=true;
        if(max!=null && parseFloat(value)>max) flag=true;
        var error = (flag || (empty==null && value=='') ||(value!='' && value.search(pattern) == -1));

        showMsg({error:error,id:textfield,msg:alt,empty:empty});

        if(textfield.type == 'password' && textfield.className.indexOf("invalid-text")==-1)
        {
            var bind = textfield.getAttribute("bind");
            var bind_flag = true;
            var bind_arr = document.getElementsByName(bind);
            var bind_arr_len = bind_arr.length;
            for(var i=0; i<bind_arr_len; i++)
            {
                if(bind_arr[i].name == bind && bind_arr[i].value != textfield.value && bind_arr[i].value != '')
                {
                    bind_flag = false;
                }
            }
            if(msg==undefined) msg=textfield.nextSibling;
            if(!bind_flag )
            {
                msg.className = "invalid-msg";
                textfield.className=textfield.className.replace(" valid-text","");
                textfield.parentNode.className = textfield.parentNode.className.replace(" valid","");
                if(textfield.className.indexOf("invalid-text")==-1){
                    textfield.className += ' invalid-text';
                    textfield.parentNode.className = textfield.parentNode.className += " invalid";
                }
                msg.innerHTML = '两次输入密码不一致';
                updateFormMsg(textfield,msg);
            }
            else
            {
                msg.className = "valid-msg";
                textfield.className=textfield.className.replace(" invalid-text","");
                textfield.parentNode.className = textfield.parentNode.className.replace(" invalid","");
                if(textfield.className.indexOf("valid-text")==-1){
                    textfield.className += ' valid-text';
                    textfield.parentNode.className = textfield.parentNode.className += " valid";
                }
                msg.innerHTML = '';
                updateFormMsg(textfield,msg);
                if(bind_arr_len>0 && bind_arr[0].value.length>0)showMsg({id:bind_arr[0],error:false,msg:''});
            }
        }
        if(textfield.className.indexOf("invalid-text")==-1) return true;
        else return false;
    }
    function showMsg(obj){
        if(obj['id']==undefined || obj['id']==null){
            var event=arguments.callee.caller.arguments[0]||window.event;
            var e=event.srcElement||event.target;
            var textfield = e;
        }else{
            var textfield = obj['id'];
        }
        if(obj['formMsg']!==undefined && obj['formMsg']!=null){
            formMsg = obj['formMsg'];
        }
        var error = obj['error'];
        var initmsg = null;
        var alt = (typeof(obj['msg'])=='string'&&obj['msg'].length>0)?obj['msg']:null;
        var empty = obj['empty']==undefined?null:obj['empty'];
        var initmsg_attr = textfield.getAttribute('initmsg');
        var value = textfield.value;
        initmsg = (initmsg!=null?initmsg:(initmsg_attr!=null&&initmsg_attr!=''?initmsg_attr:''));

        var old_status = (textfield.className.indexOf("invalid-text")==-1);
        if(error){

            textfield.className=textfield.className.replace(" invalid-text","");
            textfield.className=textfield.className.replace(" valid-text","");
            textfield.parentNode.className = textfield.parentNode.className.replace(" invalid","");
            textfield.parentNode.className = textfield.parentNode.className.replace(" valid","");
            if(textfield.className.indexOf("invalid-text")==-1){
                textfield.className += " invalid-text";
                textfield.parentNode.className = textfield.parentNode.className += " invalid";
            }
            msg=textfield.nextSibling;
            while(msg && msg.nodeType==3)msg=msg.nextSibling;
            if(msg && (msg.tagName=='LABEL' || msg.tagName=='SPAN'))
            {
                msg.className = "invalid-msg";
                if((initmsg_attr==null || initmsg_attr=='')){
                    if(old_status) textfield.setAttribute('initmsg', msg.innerHTML);
                    else textfield.setAttribute('initmsg','');
                }
                if(alt!=null && alt!=''){
                    msg.innerHTML=alt;
                    updateFormMsg(textfield,msg);
                }
                else{
                    msg.innerHTML = '';
                    updateFormMsg(textfield,msg);
                }
            }
            else
            {
                 var new_msg=document.createElement("LABEL");
                 new_msg.className = "invalid-msg";
                 if(initmsg_attr==null || initmsg_attr=='') textfield.setAttribute('initmsg', '');
                 if(alt!=null){
                    new_msg.innerHTML=alt;
                    updateFormMsg(textfield,new_msg);
                }
                 textfield.parentNode.insertBefore(new_msg,msg);
            }

        }
        else{
            textfield.className=textfield.className.replace(" invalid-text","");
            textfield.className=textfield.className.replace(" valid-text","");
            textfield.parentNode.className = textfield.parentNode.className.replace(" invalid","");
            textfield.parentNode.className = textfield.parentNode.className.replace(" valid","");

            if(empty!=null && value=='');
            else
            if(textfield.className.indexOf("valid-text")==-1){
                textfield.className +=" valid-text";
                textfield.parentNode.className = textfield.parentNode.className += " valid";
            }
            msg=textfield.nextSibling;
            while(msg && msg.nodeType==3)msg=msg.nextSibling;
            if(msg && (msg.tagName=='LABEL' || msg.tagName=='SPAN' ))
             {
                if(empty!=null && value=='')
                    msg.className = "";
                else
                    msg.className = "valid-msg";
                if(old_status){
                    if(initmsg=='') textfield.setAttribute('initmsg', msg.innerHTML);
                    if(initmsg!=null && initmsg != ''){
                        msg.innerHTML= initmsg;
                        updateFormMsg(textfield,msg);
                    }
                }else{
                    msg.innerHTML= initmsg;
                    updateFormMsg(textfield,msg);
                }

             }
              else
             {
                 var new_msg=document.createElement("LABEL");
                 if(empty!=null && value=='')
                    new_msg.className = "";
                else
                    new_msg.className = "valid-msg";
                textfield.setAttribute('initmsg', '');
                new_msg.innerHTML= initmsg ;
                updateFormMsg(textfield,new_msg);
                textfield.parentNode.insertBefore(new_msg,msg);
             }
        }
    }
    function validateOnSubmit() {
        var invalid = false;
        for(var i = 0; i < this.elements.length; i++)
        {
            var e = this.elements[i];

            if ((e.type == "text" || e.type == "password" || e.type == "select-one" || e.type == "textarea" || e.type==undefined || e.type==null) && e.getAttribute("pattern") && e.style.display!='none' && !e.getAttribute("disabled")) {
                //e.onchange = validateOnChange;
                var autoCheck = (e.getAttribute("autoCheck") == null ||  e.getAttribute("autoCheck")!='false') ;
                if(autoCheck)addEvent(e,'change',validateOnChange);

                if (e.className.indexOf(" invalid-text")!=-1)
                {
                    invalid = true;
                    //FireEvent(e,'focus');
                    e.focus();
                    break;
                }
                else
                {
                    FireEvent(e,'onchange');
                    if (e.className.indexOf(" invalid-text")!=-1)
                    {
                        invalid = true;
                        //FireEvent(e,'focus');
                        e.focus();
                        break;
                    }
                }
            }
        }
        var callback = this.getAttribute("callback");
        if (invalid) {
            if(callback) __callback(callback,e);
            return false;
        }
        else{
            if(callback){
                var result =  __callback(callback,null);
                if(result != undefined) return result;
            }
        }
    }
    window['autoValidate']={};
    window['autoValidate']['init']=init;
    window['autoValidate']['validate']=validateOnChange;
    window['autoValidate']['showMsg']=showMsg;
})( );
//通过函数名回调函数
 function __callback(fn){
        var args = Array.prototype.slice.apply(arguments);
        args.shift();
        if(typeof window[fn] == 'function') return window[fn].apply(this,args);
}
/**
*@author webning
*/
function Form(form)
{
    this.init = function(obj)
    {
        for(var item in obj)
        {
            this.setValue(item,obj[item]);
        }
    }
    this.clearAll = function()
    {
        var elements;
        if(form == undefined) elements = document.forms[0].elements;
        else    elements=document.forms[form].elements;
        var len = elements.length;
        for(var i=0;i<len;i++)
        {
            this.setValue(elements[i].name,null);
        }
    }
    this.getItems = function()
    {
        var obj=new Object();
        var elements;
        if(form == undefined) elements = document.forms[0].elements;
        else    elements=document.forms[form].elements;
        var len = elements.length;
        for(var i=0;i<len;i++)
        {
            if(obj[elements[i].name] == undefined) obj[elements[i].name]=this.getValue(elements[i].name);
        }
        return obj;
    }
    this.setValue=function(name,value)
    {
        var e;
        if(form == undefined) e = document.forms[0].elements[name];
        else    e=document.forms[form].elements[name];
        if(e==undefined) return;
        switch(e.type)
        {
            case 'text':
            case 'hidden':
            case 'textarea':e.value=value;break;
            case 'radio':
            case 'checkbox':
            {
                if(e.value==value)e.checked=true;
                else e.checked=false;
            }
            case undefined:
            {
                var len=e.length;
                if (len>0)
                {
                    var _value = (','+value+',');
                    for(var j=0;j<len;j++)
                    {
                        if(e[j]!=undefined)
                        {
                            if(value==e[j].value || _value.indexOf(","+e[j].value+",")!=-1)e[j].checked=true;
                            else
                            {
                                if(value==null)e[j].checked=false;
                            }
                        }
                    }
                }
                break;
            }
            case 'select-one': this.setSelected(e,value);break;
            case 'select-multiple':
            {
                var len=e.length;
                if (len>0)
                {
                    var _value = (';'+value+';');
                    for(var j=0;j<len;j++)
                    {

                        if(e[j]!=undefined)
                        {

                        if(value==e[j].value || _value.indexOf(","+e[j].value+",")!=-1 || value.indexOf(","+e[j].innerHTML+",")!=-1){e[j].selected=true;}
                    }
                    }
                }
            }
            break;
        }
    }
    this.getValue = function(name)
    {
        var e;
        if(form == undefined) e = document.forms[0].elements[name];
        else    e=document.forms[form].elements[name];
        if(e==undefined) return null;
        switch(e.type)
        {
            case 'text':
            case 'hidden':
            case 'textarea':return e.value;break;
            case 'radio':
            case 'checkbox':
            {
                if(e.checked)e.value;
                break;
            }
            case undefined:
            {
                var len=e.length;
                var tmp = '';
                if (len>0)
                {
                    for(var j=0;j<len;j++)
                    {
                        if(e[j]!=undefined)
                        {
                            if(e[j].checked)
                            {
                                if(e[j].value!='') tmp += e[j].value+',';
                                else tmp += e[j].innerText+',';
                            }
                        }
                    }
                }
                if(tmp.length>0) tmp = tmp.substring(0,(tmp.length-1));
                if(tmp!='')return tmp;
                else return null;
                break;
            }
            case 'select-one': return e.value;break;
            case 'select-multiple':
            {
                var len=e.length;
                if (len>0)
                {
                    var tmp = '';
                    for(var j=0;j<len;j++)
                    {

                        if(e[j]!=undefined)
                        {
                            if(e[j].checked)
                            {
                                if(e[j].value!='') tem += e[j].value+',';
                                else tem += e[j].innerText+',';
                            }
                        }
                    }
                }
                if(tmp.length>0) tmp = tmp.substring(0,(tmp.length-1));
                if(tmp!='')return tmp;
                else return null;
                break;
            }

        }
    }
    this.setSelected = function(obj,value)
    {
        objSelect=obj;
        for(var i=0;i<objSelect.options.length;i++)
        {
            if(objSelect.options[i].value == value || objSelect.options[i].text == value)
            {
                objSelect.options[i].selected = true;
                //break;
            }
            else
            {
                objSelect.options[i].selected = false;
            }
         }
    }
}
