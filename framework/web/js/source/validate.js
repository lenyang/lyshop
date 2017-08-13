(function( ) 
{
    if (window.addEventListener) window.addEventListener("load", init, false);
    else if (window.attachEvent) window.attachEvent("onload", init);
    function init( ) {
        for(var i = 0; i < document.forms.length; i++) {
            var f = document.forms[i]; 
            var needsValidation = false;
            for(j = 0; j < f.elements.length; j++) {
                var e = f.elements[j];
                if (e.type != "text" && e.type!="password") continue;
                var pattern = e.getAttribute("pattern");
                var required = e.getAttribute("required") != null;
                if (required && !pattern) {
                    pattern = "\\S";
                    e.setAttribute("pattern", pattern);
                }
                if (pattern) 
                {                
                    e.onchange = validateOnChange;
                    needsValidation = true;
                }
            }
            if (needsValidation) f.onsubmit = validateOnSubmit;
        }
    }
    function validateOnChange() 
    {
        var textfield = this;
        var pattern = textfield.getAttribute("pattern"); 
        var value = this.value;
        var alt = textfield.getAttribute("alt");
        
        if (value.search(pattern) == -1) 
        {
        	textfield.className=textfield.className.replace("valid-text","");
        	 if(textfield.className.indexOf("invalid-text")==-1)textfield.className += " invalid-text";
        	 msg=textfield.nextSibling;
        	 if(msg && msg.tagName=="SPAN")
        	 {
        	 	msg.className = "invalid-msg";
        	 	msg.innerHTML=alt;
        	 }
        	 else
        	 {
        	 	 msg=document.createElement("SPAN");
        	 	 msg.className = "invalid-msg";
        	 	 msg.innerHTML=alt;
        	 	 textfield.parentNode.appendChild(msg);
        	 }
        }
        else
        {
        	textfield.className=textfield.className.replace("invalid-text","");
        	if(textfield.className.indexOf("valid-text")==-1)textfield.className +=" valid-text";
        	if(textfield.nextSibling && textfield.nextSibling.tagName=="SPAN")
        	 {
        	 	msg=textfield.nextSibling;
        	 	msg.className = "valid-msg";
        	 	msg.innerHTML=alt;
        	 }
        	  else
        	 {
        	 	 msg=document.createElement("SPAN");
        	 	 msg.className = "valid-msg";
        	 	 msg.innerHTML=alt;
        	 	 textfield.parentNode.appendChild(msg);
        	 }
			if(this.type == 'password')
	        {
	        	var bind = textfield.getAttribute("bind");
		        var bind_flag = true;
		        var bind_arr = document.getElementsByName(bind);
		        var bind_arr_len = bind_arr.length;
		        for(var i=0; i<bind_arr_len; i++)
			    {
			    	if(bind_arr[i].name == bind && bind_arr[i].value != this.value && bind_arr[i].value != '')
			    	{
			    		bind_flag = false;
			    	}
			    }
			    if(!bind_flag)
			    {
			    	msg.className = "invalid-msg";
			    	textfield.className=textfield.className.replace("valid-text","");
			    	if(textfield.className.indexOf("invalid-text")==-1)this.className += ' invalid-text';
			    	msg.innerHTML = '两次输入密码不一致';
			    }
			    else
			    {
			    	msg.className = "valid-msg";
			    	textfield.className=textfield.className.replace("invalid-text","");
			    	if(textfield.className.indexOf("valid-text")==-1)this.className += ' valid-text';
			    	msg.innerHTML = alt;
			    }
			}
        }
    }
    function validateOnSubmit( ) {
        var invalid = false;
        for(var i = 0; i < this.elements.length; i++) 
        {
            var e = this.elements[i];
            if ((e.type == "text" || e.type == "password") && e.onchange == validateOnChange) {
                e.onchange( );
                if (e.className.indexOf("invalid-text")!=-1)
                {
                 invalid = true;
                 e.focus();
                 break;
                }
            }
        }
        if (invalid) {
           // alert("    你填写的字段格式不正确！\n" +
              //    "纠正后，再试一次！");
            return false;
        }
    }
})( );
