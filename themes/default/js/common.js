function initOperat(){
    $(".operat").each(function(){
        var operat = $(this);
        operat.find(".action").on("mouseenter DOMNodeInserted",function(){

            operat.removeClass("hidden").addClass("show_munu");
            var offset = operat.offset();
            var height = operat.find(".action").height();
            var action_width = operat.find(".action").outerWidth();
            var menu_select_width = operat.find(".menu_select").outerWidth();

            if(offset.top+operat.find(".menu_select").height()+height < $(window).height()){
                if(offset.left+menu_select_width< $(window).outerWidth()) operat.find(".menu_select").offset({left:offset.left,top:(Math.floor(offset.top)+1+height)});
                else operat.find(".menu_select").offset({left:(offset.left+action_width-menu_select_width),top:(Math.floor(offset.top)+1+height)});
                operat.find(".action").removeClass("top").addClass("bottom");
            }else{
                if(offset.left+menu_select_width< $(window).outerWidth()) operat.find(".menu_select").offset({left:offset.left,top:Math.ceil(offset.top)-1-operat.find(".menu_select").height()});
                else operat.find(".menu_select").offset({left:(offset.left+action_width-menu_select_width),top:Math.ceil(offset.top)-1-operat.find(".menu_select").height()});
                operat.find(".action").removeClass("bottom").addClass("top");
            }

        });
        operat.on("mouseleave",function(){
            operat.removeClass("show_munu").addClass("hidden");
        })
    })
}


function tabs_init(){
    $(".tab").each(function(j){
        var that = $(this);
        that.attr("index",0);
        $(">.tab-head >*",that).each(function(i){
            var index = i;

            if(i!=0)$(this).removeClass('current');
            else $(this).addClass('current');
            $(">.tab-body > *",that).css({display:'none'});
            $(">.tab-body > *:eq(0)",that).css({display:'block'});
            $(this).on("click",function(){
                $(">.tab-head >*",that).removeClass('current');
                $(this).addClass("current");
                $(">.tab-body > *",that).css({display:'none'});
                $(">.tab-body > *:eq("+index+")",that).css({display:'block'})
                that.attr("index",i);
                tab_page_nav();
            })
        });
    });
    var hash = window.location.hash;
    var re = /#tab(-(\d+))+$/i;
    if(re.test(hash)){
        var num = hash.match(/\d+/g);
        var len = num.length;
        for(var i=0;i<len;i++) tabs_select(i,num[i]);
            tab_page_nav();
    }
}

function tab_page_nav(){
    var hash = '#tab';
    $(".tab").each(function(){
        hash += '-'+$(this).attr("index");
    });
    $(".page-nav a").each(function(){
        if($(this).attr('href')!='javascript:;' && $(this).attr('href')!='#'){
            var href = $(this).attr("href");
            href = href.replace(/#(.+)$/i,'')+hash;
            $(this).attr("href",href);
        }else{
            var onclick = $(this).attr("onclick");
            if(onclick!=undefined){
                onclick = onclick.replace(/(\+*\"#(.+)\")?;$/i,'+')+'\"'+hash+'\";';
                $(this).attr("onclick",onclick);
            }
        }
    })
}
//tabs插件选择
function tabs_select(num,index){
    var that = $(".tab:eq("+num+")");
    that.attr("index",index);
    $(">.tab-head >*",that).each(function(i){
        if(i!=index)$(this).removeClass('current');
        else $(this).addClass('current');
        $(">.tab-body > *",that).css({display:'none'});
        $(">.tab-body > *:eq("+index+")",that).css({display:'block'});
    });
}


//此插件必需结合Tiny系统的框架定义的Paging JQuery插件
(function($){
    //默认参数

    $.fn.Paging = function(options){
        var defaults = {url:null, params:{}, content:'',callback:function(){}};
        var o = {};
        var self = null;
        self = $(this);
        //对最原始模板的处理
        var id = self.attr("id");
        var content = $("#"+id).data("page-content-template");
        if(content){
            defaults.content = content;
        }else{
            defaults.content = self.find(".page-content").html();
            $("#"+id).data("page-content-template",defaults.content);
        }
        o = $.extend(defaults,options);
        getPage(1);

        //内部私有取得第几页
        function getPage(page){
            o.params = $.extend(o.params,{page:page});
            var data = $.data(self, "page_"+page);
            if(data){
                handle(data);
                if(typeof(o.callback)=="function") o.callback();
            }else{
                $.post(o.url,o.params,function(data){
                    $.data(self, "page_"+page, data);
                    handle(data);
                    if(typeof(o.callback)=="function") o.callback();
                },"json");
            }

        }
    //处理数据
    function handle(data){
        if(data['status']=='success'){
            self.find(".page-content").html(rander(data['data']));
            self.find(".page-nav").html(data['html']);
            self.find(".page-nav a").each(function(){
                $(this).on("click",function(){
                    var index = parseInt($(this).attr("page-index"));
                    getPage(index);
                })
            });
            if(data['data']!='')self.removeClass('js-template');
        }
    }
    //数据渲染
    function rander (data){
        var str = '';
        if(typeof data=="object"){
            var num = 1;
            for(var i in data){
                data[i]['odd-even'] = "odd";
                if(num++%2==0)data[i]['odd-even'] = "even";
                str += o.content.replace(/{\s*([^}]+)\s*}/ig,function(s0,s1){
                    var tem = s1.split("|");
                    if(tem.length==2){
                        return data[i][tem[0]] || tem[1];
                    }
                    else if(tem.length>2){
                        if(data[i][tem[0]]) return tem[1];
                        else return tem[2];
                    }
                    return data[i][s1]  || '';
                });
            }
        }
        return str;
    }
}

})(jQuery);
// 无限级连动插件
(function($){
    $.fn.Linkage = function(o){

        o = $.extend({url:'',selects:['#province','#city','#county'],initRunCallBack:false,selected:['0','0','0']}, o || {});
        var url = o.url;
        var arrNodeChild = new Array();
        var arrSelect = o.selected;
        var options = new Array();
        $.each(arrSelect,function(i){
            options[i] = '';
        });
        var len = o.selects.length;
        for(var i=0;i<len;i++) arrNodeChild[i] = new Array();
        //请求格式化后的JSON数据
    $.post(o.url,function(data){
        $.each(data, function(i, n){
            var c_id = i.substr(2);
            var selected = (c_id == arrSelect[0]) ? 'selected="selected"' : '';
            options[0] += '<option value="' + c_id + '" ' + selected + '>' + n.t + '</option>';

            n.id = c_id;
            if(n.c !== null){
                arrNodeChild[0][i] = n.c;
                parse(n,0);
            }
        });

        $.each(o.selects,function(i,em){
        	$(em).append(options[i]);
        });
        if(o.initRunCallBack)callback();
    },"json");
        //解析每一层元素
        function parse(data,num){
            if(data.c !==undefined && data.c !== null) {
                $.each(data.c, function(i, n) {
                    var c_id = i.substr(2);
                    if(data.id == arrSelect[num]) {
                        var selected = (c_id == arrSelect[num+1]) ? 'selected="selected"' : '';
                        options[num+1] += '<option value="' + c_id + '" ' + selected + '>' + n.t + '</option>';
                    }
                    n.id = c_id;
                    arrNodeChild[num+1][i] = n.c;
                    if(n.c !== null) parse(n,num+1);
                });
            }
        }
        //回调处理
        function callback()
        {
            if(typeof(o.callback) == 'function'){
                var selected =new Array(); value =new Array(); text = new Array();
                $.each(o.selects,function(i,em){
                    value[i] = $(em).val();
                    text[i] = $('option:selected',$(em)).text();
                });
                selected[0] = value;
                selected[1] = text;
                o.callback(selected);
            }
        }
        //逐级绑定连动事件
        var len = o.selects.length;
        $.each(o.selects,function(i,em){
            $(em).change(function(){
                var val = 'o_'+$(this).val();
                if(arrNodeChild[i][val] !== null && i<len-1) {

                    for(var j=i+1 ; j<len ;j++){
                        var option = $(o.selects[j]).children().first();
                        if(option.val()==0)$(o.selects[j]).empty().append(option);
                        else $(o.selects[j]).empty().append("<option value='0'>请选择</option>");
                    }
                    if(val != 0){
                        var select = '';
                        if(arrNodeChild[i][val]!==undefined){
                            $.each(arrNodeChild[i][val], function(k, n) {
                                var c_id = k.substr(2);

                                select += '<option value="' + c_id + '">' + n.t + '</option>';
                            });
                            $(o.selects[i+1]).append(select);
                        }

                    }
                }
                callback();
            });
        });
    };
})(jQuery);
//提交前咨询
function confirm_action(url,msg){
    if(msg==undefined) msg = '你确认删除操作吗？删除后无法恢复！';
    art.dialog.confirm(msg, function(){
        window.location.href = url;
    });
}
//刷新
function tools_reload(){
    location.reload();
}
//倒计时
(function($){
    $.fn.countdown = function(options){
        var self = this;
        var defaults = {id:'countdown',end_time:"2020-12-31 23:59:59",format:'{d}天 {h}小时{m}分{s}.{mi}秒',callback:function(){}};
        var o = $.extend(defaults, options);

        function runTime(){
            var endtime=new Date(o.end_time);
            var nowtime = new Date();
            var time = (endtime.getTime()-nowtime.getTime());
            var leftsecond=parseInt(time/1000);
            if(leftsecond<0){leftsecond=0;time=0;}
            __d=parseInt(leftsecond/3600/24);
            __h=parseInt((leftsecond/3600)%24);
            __m=parseInt((leftsecond/60)%60);
            __s=parseInt(leftsecond%60);
            __mi=parseInt(time/100%10);
            __d = __d<10?'0'+__d:__d;
            __h = __h<10?'0'+__h:__h;
            __m = __m<10?'0'+__m:__m;
            __s = __s<10?'0'+__s:__s;
            var date = {d:__d,h:__h,m:__m,s:__s,mi:__mi};
            var str = o.format.replace(/{\s*([^}]+)\s*}/ig,function(s0,s1){return date[s1];});
            self.html(str);
            if(leftsecond>0)setTimeout(runTime,100);
            else{o.callback();}
        }
        runTime();
    }
})(jQuery);

function getFileName()
{
    var url = this.location.href;
    var pos = url.lastIndexOf("/");
    if(pos == -1)
        pos = url.lastIndexOf("\\");
    var filename = url.substr(pos+1);
    return filename;
}

function fnLoad()
{
    with(window.document.body)
    {
        try{
            addBehavior ("#default#userData");    // 使得body元素可以支持userdate
            load("scrollState" + getFileName());    // 获取以前保存在userdate中的状态
            if (sFirstEnter=="0")
            {
                scrollLeft = getAttribute("scrollLeft");    // 滚动条左位置
                scrollTop = getAttribute("scrollTop");
            }
        }catch(e){

        }
    }
}
function fnUnload()
{
    with(window.document.body)
    {
        try{
            setAttribute("scrollLeft",scrollLeft);
            setAttribute("scrollTop",scrollTop);
            save("scrollState" + getFileName());
        }catch(e){

        }
    }
}

window.onload = fnLoad;
window.onunload = fnUnload;

$(document).ready(function(){
    tabs_init();
    initOperat();
    setTimeout(function(){
        $("#message-bar").fadeOut();
    },2000);
});
