
(function($){
    $.fn.Slider = function(){
            
        return this.each(function(){
            var defaults = {
                screen_tag:'ul',
                direction:'left',
                speed:'slow',
                easing:'swing',
                stay:5000
            };
            var slider = $(this);
            var config_data = slider.attr('config-data');
            if(config_data!=undefined){
                try{
                    config_data = $.parseJSON(config_data);
                    var config = $.extend(defaults , config_data);
                }catch(e){
                    var config = defaults;
                }
            }
            var slider_w = slider.width(),
                slider_h = slider.height(),
                screen = slider.find('> '+config.screen_tag),
                total = screen.children().length,
                screen_w = slider_w * (total+1),
                screen_h = slider_h * (total+1),
                current=1;
                
                var animate = {left: -1 * slider_w * current};
                var init_location = {left:0};
                var is_float = 'left';
            if(config.direction=='top'){
                screen_w = slider_w;
                animate = {top: -1 * slider_h * current};
                init_location = {top:0};
                is_float = 'none';
            }else{
                screen_h = slider_h;
            }
                
            slider.css({position: "relative", margin: "0 auto",overflow: "hidden"});
            screen.css({position: 'absolute',display: 'block',"height":screen_h,"width":screen_w});
            screen.children().css({"background-position":"50% 0%","background-repeat":"no-repeat no-repeat","height":slider_h,"width":slider_w , "float": is_float,margin:0,padding:0});
            screen.children().find(">*").css({display: 'block', width: '100%', height: '100%'});
            screen.children().eq(0).clone().appendTo(screen);
            var tem = '<ul class="dot-nav">';
            for (var i = 1; i <= total; i++) {
                tem+='<li><a>'+i+'</a></li>';
            }
            slider.append(tem+'</ul>');
            slider.find(".dot-nav > li").removeClass('current').eq(0).addClass('current');
            //$(".dot-nav >li >  a",slider).each(function(i){
            slider.find(".dot-nav >li ").each(function(i){
                $(this).on("click", function(){
                    run(i);
                });
                $(this).on("mouseenter",function(){clearInterval(si);});
                $(this).on("mouseleave",function(){
                    si = setInterval(function(){
                    run();}, config.stay);});
            });
            var animate = {left: -1 * slider_w * current};
            var dot_nav_item = slider.find(".dot-nav > li");
            var run = function (index){
                if(index!=undefined) current=index;
                animate = {left: -1 * slider_w * current};
                if(config.direction=='top'){
                    animate = {top: -1 * slider_h * current};
                }
                screen.animate(animate,config.speed,config.easing,function(){
                    current++;
                    if(current>total){
                        current=1;
                        screen.css(init_location);
                    }
                    dot_nav_item.removeClass('current').eq(current-1).addClass('current');
                });
            }
            //run(1);
            var si = setInterval(function(){
               run();
            }, config.stay);

        });
    }
})(jQuery);