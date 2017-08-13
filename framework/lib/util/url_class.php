<?php
/**
 * URL操作类
 *
 * @author Crazy、Ly
 * @class Url
 */
class Url
{
    private static $_requestUri;
    private static $_baseUri;
    private static $_baseDir;
    private static $_host;
    private static $_urlFormat;
    private static $_route;
    private static $_scriptFile;

    public static function requestUri()
    {
        if (self::$_requestUri) return self::$_requestUri;
        if (isset($_SERVER['HTTP_X_REWRITE_URL']))
        {
            $uri = $_SERVER['HTTP_X_REWRITE_URL'];
        }
        elseif (isset($_SERVER['REQUEST_URI']))
        {
            $uri = $_SERVER['REQUEST_URI'];
        }
        elseif (isset($_SERVER['ORIG_PATH_INFO']))
        {
            $uri = $_SERVER['ORIG_PATH_INFO'];
            if (! empty($_SERVER['QUERY_STRING']))
            {
                $uri .= '?' . $_SERVER['QUERY_STRING'];
            }
        }
        else
        {
            $uri = '';
        }

        self::$_requestUri = $uri;
        return $uri;

    }
    //取得脚本执行
    static function scriptFile()
    {
        if(self::$_scriptFile) return self::$_scriptFile;

        $filename = basename($_SERVER['SCRIPT_FILENAME']);

        if (basename($_SERVER['SCRIPT_NAME']) === $filename)
        {
            $url = $_SERVER['SCRIPT_NAME'];
        }
        elseif (basename($_SERVER['PHP_SELF']) === $filename)
        {
            $url = $_SERVER['PHP_SELF'];
        }
        elseif (isset($_SERVER['ORIG_SCRIPT_NAME']) && basename($_SERVER['ORIG_SCRIPT_NAME']) === $filename)
        {
            $url = $_SERVER['ORIG_SCRIPT_NAME'];
        }
        else
        {
            $path = $_SERVER['PHP_SELF'];
            $segs = explode('/', trim($_SERVER['SCRIPT_FILENAME'], '/'));
            $segs = array_reverse($segs);
            $index = 0;
            $last = count($segs);
            $url = '';
            do{
                $seg = $segs[$index];
                $url = '/' . $seg . $url;
                ++ $index;
            } while (($last > $index) && (false !== ($pos = strpos($path, $url))) && (0 != $pos));
        }
        return $url;
    }
    static function  baseUri()
    {
       if (self::$_baseUri) return self::$_baseUri;
        $url = self::scriptFile();
        $request_uri = self::requestUri();

        //修正get方式下的不规范Url格式
        if (self::getUrlFormat()=='get')
        {
            self::$_baseUri = $url;
            return self::$_baseUri;
        }else if(self::getUrlFormat()=='path')
        {
            $url = rtrim(dirname($url), '/') . '/';
            self::$_baseUri = trim($url,'\\');
            return self::$_baseUri;
        }

        if (! strpos($request_uri, basename($url))) return '';

        if ((strlen($request_uri) >= strlen($url)) && ((false !== ($pos = strpos($request_uri, $url))) && ($pos !== 0)))
        {
            $url = substr($request_uri, 0, $pos + strlen($url));
        }

        self::$_baseUri = $url;
        return self::$_baseUri;
    }
    static function  baseDir()
    {
        if (self::$_baseDir) return self::$_baseDir;

        $base_uri = self::baseUri();

        if (substr($base_uri, - 1, 1) == '/')
        {
            $base_dir = $base_uri;
        }
        else
        {
            $base_dir = dirname($base_uri);
        }
        self::$_baseDir = rtrim($base_dir, '/\\') . '/';
        return self::$_baseDir;
    }
    static function  pathinfo()
    {
        if (!empty($_SERVER['PATH_INFO'])) return $_SERVER['PATH_INFO'];

        $base_url = self::baseUri();

        if (null === ($request_uri = self::requestUri())) return '';
        $pos = strpos($request_uri, '?');
        if ($pos!==false)
        {
            $request_uri = substr($request_uri, 0, $pos);
        }

        if ((null !== $base_url) && (false === ($pathinfo = substr($request_uri, strlen($base_url)))))
        {
            $pathinfo = '';
        }
        elseif (null === $base_url)
        {
            $pathinfo = $request_uri;
        }

        return $pathinfo;
    }
    /**
     *取得网站的host地址
     */
    public static function getHost($http='http')
    {
        if(isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"]=='on') $http = "https";
        if(self::$_host!==null) return self::$_host;
        if(isset($_SERVER['HTTP_HOST']))
            self::$_host = $http.'://'.$_SERVER['HTTP_HOST'];
        else
            self::$_host = $http.'://'.$_SERVER['SERVER_NAME'];

        return  self::$_host;
    }
    /**
     *取得入口文件的Url地址
     */
    public static function getEntryUrl()
    {
        return self::getHost().$_SERVER['SCRIPT_NAME'];
    }
    /**
     *取得前一页的路由地址
     */
    public static function getRefRoute()
    {
        if(isset($_SERVER['HTTP_REFERER']) && ($_SERVER['HTTP_REFERER'] & self::getEntryUrl()) == self::getEntryUrl()) return substr($_SERVER['HTTP_REFERER'],strlen(self::getEntryUrl()));
        else return '';
    }

    public static function urlReWrite()
    {
        $requestUrl = self::requestUri();
        $baseUrl = self::baseUri();
        $scriptFile = self::scriptFile();
        if(false!==stripos($requestUrl, $scriptFile)){
            $baseUrl = $scriptFile;
        }
        else if(false===stripos($requestUrl, $baseUrl))
        {
            $format = self::getUrlFormat();
            if($format=='get'){
                $baseUrl = rtrim(dirname($baseUrl), '/') . '/';
            }else{
                $baseUrl = self::scriptFile();
            }
        }
        $request = substr($requestUrl,strlen($baseUrl));
        if(strlen($request)>=1)
        {
            $first = substr($request,0,1);
            if($first != '?')
            {
                if(($index=strpos($request,'?')) !== false)
                {
                    $request = substr($request,0,$index);
                }
                $request = trim($request,'/');
                if($request!='')
                {
                    $request_Arr=explode('/',$request);
                    $len=count($request_Arr);

                    $routes  =  self::getRoute();
                    if($routes !== null)
                    {
                        $route = new Route($routes);
                        $params = $route->parseRoute('/'.$request);

                        if($params === null)
                        {
                            $_GET['con']=isset($request_Arr[0])?$request_Arr[0]:null;
                            $_GET['act']=isset($request_Arr[1])?$request_Arr[1]:null;
                        }
                        else
                        {
                            foreach($params as $key=>$param)
                            {
                                $_GET[$key]=isset($params[$key])?$params[$key]:null;
                            }
                        }
                    }
                    else
                    {
                        $_GET['con']=isset($request_Arr[0])?$request_Arr[0]:null;
                        $_GET['act']=isset($request_Arr[1])?$request_Arr[1]:null;
                    }
                    if($_GET['act']=='run') $_GET['act']='';
                    if($len>2)
                    {
                        for($i=2;$i<$len;$i++)if($i%2==1)$_GET[$request_Arr[$i-1]]=$request_Arr[$i];
                    }
                }
            }else{
                if(isset($_GET['con']) && $_GET['con']=='') $_GET['con'] = null;
                if(isset($_GET['act']) && $_GET['act']=='') $_GET['act'] = null;
            }
        }
    }
    /**
     *路径格式化处理
     */
    static function urlFormat($path)
    {
        if($path=='') return self::baseDir();
        if(preg_match('@[/\@#*!]?(https?://.+)$@i', $path,$matches)) return $matches[1];
        switch(substr($path,0,1))
        {
            case '/':
            {
                $path = self::createUrl($path);
                return rtrim(self::baseUri(),'/').$path;//解释成绝对路由地址
            }
            case '@': return self::baseDir().substr($path,1);//解析成绝对路径
            case '#': //解析成主题的绝对地址
            {
                if(Tiny::app()->getTheme()!==null)
                {
                    return Tiny::app()->getTheme()->getBaseUrl().'/'.substr($path,1);
                }
                else return self::baseDir().substr($path,1);
            }
            case '*'://解析成皮肤的路径
            {
                if(Tiny::app()->getTheme()!==null && Tiny::app()->getSkin()!==null)
                {
                    $theme = Tiny::app()->getTheme();
                    return  $theme->getBaseUrl().'/skins/'.Tiny::app()->getSkin().'/'.substr($path,1);
                }
                else if( Tiny::app()->getSkin()!==null){
                    return self::baseDir().'skins/'.Tiny::app()->getSkin().'/'.substr($path,1);
                }
                else return self::urlFormat('#'.substr($path,1));
            }
            case '!'://运行目录路径
            {
                return Tiny::app()->getRuntimeUrl().'/'.substr($path,1);
            }
            default:
            {
                $q = Req::get();
                $url = '/'.$q['con'].'/'.$q['act'];
                unset($q['con'],$q['act']);
                $query = explode('/',trim($path,'/'));
                $new_q=array();
                $len = count($query);
                for($i=0;$i<$len;$i++)if($i%2==1)$new_q[$query[$i-1]]=$query[$i];
                $q = array_merge($q,$new_q);
                foreach($q as $k=>$v)
                {
                    if(is_string($k))$url .= '/'.$k.'/'.$v;
                }
                $path = self::createUrl($url);
                return rtrim(self::baseUri(),'/').$path;//解释成绝对路由地址
            }
        }
    }
    //完整路径的format
    static function fullUrlFormat($path)
    {
        $path = trim($path);
        if(preg_match('@[/\@#*!]?(https?://.+)$@i', $path,$matches)) return $matches[1];
        return self::getHost().self::urlFormat($path);
    }
    public static function createUrl($_url)
    {
        $routes  =  self::getRoute();
        $route = new Route($routes);

        $url = $_url;
        $param_key = array();


        if(self::getUrlFormat()=='get' || $routes !== null)
        {

            $param = '';
            if(strpos($url,'?')!==false)
            {
                $url_arr = explode('?',$url);
                $url = $url_arr[0];
                $param = $url_arr[1];
            }
            $param_arr = array();
            if(substr($url,0,1)=='/')
            {
                $tem = explode('/',substr($url,1));
                $param_arr['con'] = isset($tem[0])?$tem[0]:null;
                $param_arr['act'] = isset($tem[1])?$tem[1]:null;
                $len = count($tem);

                if($len>2)
                {
                    for($i=2;$i<$len;$i=$i+2)
                    {
                        $param_arr[$tem[$i]] = isset($tem[$i+1])?$tem[$i+1]:null;
                        $param_key[$tem[$i]] = $tem[$i];
                    }
                }
            }
            else
            {

                $tem = explode('/',$url);
                $len = count($tem);
                if($len>0)
                {
                    for($i=0;$i<$len;$i=$i+2)
                    {
                        $param_arr[$tem[$i]] = isset($tem[$i+1])?$tem[$i+1]:null;
                    }
                }
            }

            if($param!=''){
                $args = explode('&', $param);
                foreach ($args as $arg) {
                    $tem = explode('=',$arg);
                    $param_arr[$tem[0]] = $tem[1];
                }
            }
            //$param_arr = array_merge($param_arr,$param);

            if(self::getUrlFormat()=='get')$url = '?'.http_build_query($param_arr);//.($param==''?'':'&'.$param);
            else
            {
                $param_key = implode("/",$param_key);
                //$param_arr = array_merge($param_arr,$param);
                $url = $route->createRoute($param_arr,$param_key);

                if($url!==null)
                {
                    // if(stripos($url,'?')!==false){
                    //     $url.=($param==''?'':'&'.$param);
                    // }
                    // else $url.=($param==''?'':'?'.$param);
                }
                else
                {
                    if(isset($param_arr['con']) && isset($param_arr['act'])){
                        $_url = "/".$param_arr['con']."/".$param_arr['act'];
                        unset($param_arr['con'],$param_arr['act']);
                       foreach ($param_arr as $key => $value) {
                           $_url .= '/'.$key.'/'.$value;
                        }
                    }
                    return $_url;
                }
            }
        }
        return $url;
    }
    //解析Url
    public function resolveUrl($url)
    {

    }
    public static function getUrlFormat()
    {
        return self::$_urlFormat;
    }
    public static function setUrlFormat($value)
    {
        if($value == 'get' || $value == 'path') self::$_urlFormat = $value;
    }
    public static function getRoute()
    {
        return self::$_route;
    }
    public static function setRoute($route)
    {
        if(is_array($route)) self::$_route = $route;
    }
}
