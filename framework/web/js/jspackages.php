<?php
/**
 * 系统封装的一些JS框架支持
 *
 * @author Tiny
 * @class JS
 */
class JS
{
    private static $JSPackages = array(
        'autoajax'=>'auto_ajax.js',
        'dialog'=>'artdialog/artDialog.js',
        'dialogtools'=>'artdialog/plugins/iframeTools.js',
        'dialogjquery'=>'artdialog/jquery.artDialog.js',
        'jquery'=>'jquery.min.js',
        'date'=>'My97DatePicker/WdatePicker.js',
        'editor'=>array('js'=>array('editor/kindeditor-min.js','editor/lang/zh_CN.js')),
		'highcharts'=>array('js'=>array('highcharts/highcharts.js','highcharts/highcharts-more.js','highcharts/modules/exporting.js')),
        'form'=>array(
            'js'=>'form/form.js',
            'css'=>'form/style.css'
        ),
        'lazyload'=>'lazyload.js'
    );
    private static $createfiles = array();
    /**
     * 执行路径
     *
     * @access public
     * @param mixed $name
     * @return mixed
     */
    public static function path($name)
    {
        return Tiny::app()->getRuntimePath().'/systemjs/'.$name.'/';
    }
    /**
     * 引用方法
     *
     * @access public
     * @param mixed $name
     * @param string $charset
     * @return String
     */
    public static function import($name,$charset='UTF-8')
    {
        $parames = explode('?',$name);
        $name = $parames[0];
        if(isset($parames[1])) $parames = '?'.$parames[1];
        else $parames = '';
        if(isset(self::$JSPackages[$name]))
        {
            if(!isset(self::$createfiles[$name]))
            {
                $is_file = false;
                $file = null;
                if(is_string(self::$JSPackages[$name]))
                {
                    if(stripos(self::$JSPackages[$name],'/')===false)
                    {
                        $is_file = true;
                        $file = self::$JSPackages[$name];
                    }
                    else $file = dirname(self::$JSPackages[$name]);
                }
                else
                {
                    if(is_array(self::$JSPackages[$name]['js'])) $file = dirname(self::$JSPackages[$name]['js'][0]);
                    else $file = dirname(self::$JSPackages[$name]['js']);
                }
                if(!file_exists(APP_ROOT.'runtime/systemjs/'.$file))
                {
                    self::$createfiles[$name] = true;
                    File::xcopy(TINY_ROOT.'/web/js/source/'.$file,APP_ROOT.'runtime/systemjs/'.$file);
                }
            }
            $webjspath = Tiny::app()->getRuntimeUrl().'/systemjs/';
            if(is_string(self::$JSPackages[$name])) return '<script type="text/javascript" charset="'.$charset.'" src="'.$webjspath.self::$JSPackages[$name].$parames.'"></script>';
            else if(is_array(self::$JSPackages[$name]))
            {
                $str='';
                if(isset(self::$JSPackages[$name]['css']))
                {
                    if(is_string(self::$JSPackages[$name]['css'])) $str .= '<link rel="stylesheet" type="text/css" href="'.$webjspath.self::$JSPackages[$name]['css'].'"/>';
                    else if(is_array(self::$JSPackages[$name]['css']))
                    {
                        foreach(self::$JSPackages[$name]['css'] as $css)
                        {
                            $str .= '<link rel="stylesheet" type="text/css" href="'.$webjspath.$css.'"/>';
                        }
                    }
                }
                if(isset(self::$JSPackages[$name]['js']))
                {
                    if(is_array(self::$JSPackages[$name]['js']))
                    {
                        foreach(self::$JSPackages[$name]['js'] as $js)
                        {
                            $str .= '<script type="text/javascript" charset="'.$charset.'" src="'.$webjspath.$js.$parames.'"></script>';
                        }
                    }
                    else
                    {
                        $str .= '<script type="text/javascript" charset="'.$charset.'" src="'.$webjspath.self::$JSPackages[$name]['js'].$parames.'"></script>';
                    }
                }

                return $str;
            }
        }
        else return '';
    }

}
