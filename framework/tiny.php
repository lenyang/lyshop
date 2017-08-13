<?php
/**
 * 框架入口文件
 */
/**
*设置全局变量
*/

//程序运行开始计时
define('BEGIN_TIME',microtime(true));

//注册自动加载
spl_autoload_register('Tiny::autoload');

//框架路径
define('TINY_ROOT',dirname(__file__).DIRECTORY_SEPARATOR);
//应用开发路径
define('APP_CODE_ROOT',APP_ROOT.'application'.DIRECTORY_SEPARATOR);
//调式开关
define('DEBUG',true);
//日志记录开关
define('LOG',false);
//缓存开关
define('CACHE',true);
//框架错误处理
define('ERROR_HANDLER',true);
//框架异常处理
define('EXCEPTION_HANDLER',true);

 /**
  * Tiny框架主类文件
  *
  * @author Crazy、Ly
  * @class Tiny
  */
class Tiny
{
    //当前的application
    private static $_app;
    //错误处理控制器
    private static $errorsController;
    //别名路径
    private static $_paths=array('system'=>TINY_ROOT);
    //存放对应的文件是否引入
    private static $_isimports = array();
    //存放外部引入的类文件
    private static $_classes = array();
    //日志处理类变量
    private static $_logger;
    //SQL记录
    private static $_sql_log = array();
    //错误标志
    public static $_iserror = true;
    //
    private static $_classes_index = array();
    /**
     * 取得当前框架的版本号
     * @access public
     * @return string
     */
    public static function getVersion()
    {
        return '1.2';
    }
    /**
     * 设定当前的application
     * @access public
     * @return mixed
     */
    public static function app()
    {
        return self::$_app;
    }
    /**
     * 用户自己定义错误处理机制
     *
     * @access public
     * @param String $controllerName
     * @return void
     */
    public static function setErrorsController($controllerName)
    {
        $controllerClass = $controllerName.'Controller';
        if(class_exists($controllerClass)){
            self::$errorsController = new $controllerClass(strtolower($controllerName),Tiny::app());
        }else if(class_exists('ErrorsController')){
            self::$errorsController = new ErrorsController('errors',Tiny::app());
        }else{
            self::$errorsController = null;
        }

    }

    /**
     * 取得用户的错误控制器
     *
     * @access public
     * @return Controller
     */
    public static function getErrorsController()
    {
        return self::$errorsController;
    }
    /**
     * 设定当前的application
     *
     * @access public
     * @param App $app
     * @return void
     */
    public static function setApp($app)
    {
        if(self::$_app === null || $app === null) self::$_app = $app;
    }
    /**
     * 设置路径
     *
     * @access public
     * @param mixed $name
     * @param mixed $path
     * @return void
     */
    public static function setPath($name,$path)
    {
        if(empty($path)) unset(self::$_paths[$name]);
        else self::$_paths[$name]=rtrim($path,'\/').'/';
    }
    /**
     * 得到路径
     *
     * @access public
     * @param mixed $name
     * @return mixed
     */
    public static function getPath($name)
    {
        if(isset(self::$_paths[$name])) return self::$_paths[$name];
        return false;
    }
    /**
     * 创建webapp应用
     *
     * @access public
     * @param mixed $config webapp的配制文件
     * @return mixed
     */
    public static function createWebApp($config=null)
    {
        return self::createApp('WebApp',$config);
    }
    /**
     * 创建app应用
     *
     * @access public
     * @param mixed $className
     * @param mixed $config
     * @return mixed
     */
    public static function createApp($className,$config=null)
    {
        //加载项目的时区,默认为中国
        date_default_timezone_set('Asia/Shanghai');
        //注册脚本执行完毕后调用的动作
        register_shutdown_function(array('Tiny','exitScript'));
        Tiny::initSystemHandler();
        return new $className($config);
    }
    /**
     * 记录SQL执行日志记录
     *
     * @access public
     * @param String $sql
     * @param float $useTime
     * @return void
     */
    public static function setSqlLog($sql,$useTime)
    {
        self::$_sql_log[] = array('SQL'=>$sql,'useTime'=>$useTime);
    }
    /**
     * 取出SQL执行日志记录
     *
     * @access public
     * @return Array;
     */
    public static function getSqlLog()
    {
        return self::$_sql_log;
    }
    /**
     * 初始化系统的事件处理机制
     *
     * @access public
     * @return mixed
     */
    public static function initSystemHandler()
    {
        if(DEBUG){
            ini_set("display_errors", "On");
            error_reporting(E_ALL);
            if(EXCEPTION_HANDLER) set_exception_handler(array('Tiny','handleException'));
            if(ERROR_HANDLER) set_error_handler(array('Tiny','handleError'),error_reporting());
        }else{
            error_reporting(0);
        }
    }
    /**
     * 脚本执行完毕后调用的动作
     *
     * @access public
     * @return mixed
     */
    public static function exitScript()
    {
        $xdebug = get_extension_funcs("xdebug");
        if(self::$_iserror && !is_array($xdebug)){
            //过滤掉html标签
            $error = ob_get_contents();

            if(ob_get_length()>0)ob_end_clean();

            if(preg_match('/(?P<errorType>[^:]+):\s(?P<message>.+(?=in))in\s(?P<file>.+(?=on))on\sline\s(?P<line>.+)/', $error, $matches)){
                Tiny::handleError(E_PARSE,$matches['message'],trim(strip_tags($matches['file'])),strip_tags($matches['line']),get_defined_vars());
            }else{
               echo $error;
           }
        }
    }
    /**
     * 异常处理机制
     *
     * @access public
     * @param mixed $exception
     * @return mixed
     */
    public static function handleException($exception)
    {
        //页面中正确运行的部分
        if(ob_get_length()>0)ob_end_clean();
        $errorStack = array();
        $file = $exception->getFile();
        $line = $exception->getLine();
        $code = $exception->getCode();
        $message = $exception->getMessage();
        if($code!==null){
            restore_error_handler();
            restore_exception_handler();
            $log="$message (".str_replace(TINY_ROOT,"",$file).":$line)\r\nStack trace:\r\n";
            $trace=$exception->getTrace();
            self::paseErrorTrace($trace,$log);
            $errorStack = $trace;
        }
        try{
            $errorType = 'Exception';
            Tiny::log($log,$errorType);

            $error_file = new File($file);
            $codes = $error_file->gets($line);
            $file = str_replace(TINY_ROOT,"",$file);
            $datas = array('errorType'=>$errorType,'file'=>$file,'line'=>$exception->getLine(),'codes'=>$codes,'errorStack'=>$errorStack,'errorContent'=>get_defined_vars());
            $error = new TError(Tiny::app(),$message,null,$datas);
            if($error){
                self::$_iserror = false;
                $error->handle();
            }else{
                self::displayError($code,$message,$file,$line);
            }
        }catch(Exception $e){
            self::displayException($e);
        }
    }
    /**
     * 解析错误和异常堆栈中的信息
     *
     * @access public
     * @param mixed $trace
     * @param mixed $log
     * @return mixed
     */
    public static function paseErrorTrace(&$trace,&$log)
    {
            if(count($trace)>3) $trace=array_slice($trace,3);
            foreach($trace as $i=>$t){
                $temp = array();
                if(!isset($t['file']))
                    $t['file']='unknown';
                if(!isset($t['line']))
                    $t['line']=0;
                if(!isset($t['function']))
                    $t['function']='unknown';

                $temp['num'] = $i;
                $temp['file'] = str_replace(TINY_ROOT,"",$t['file']);
                $temp['line'] = $t['line'];
                $temp['function'] = $t['function'];
                $log.="#$i {$temp['file']}({$t['line']}): ";

                if(isset($t['class'])){
                    $log.=$t['class'].'->';
                    $temp['object'] = $t['class'];
                }else if(isset($t['class'])){
                    $temp['object'] = $t['class'];
                }else{
                    $temp['object'] = 'unknown';
                }

                $log.="{$t['function']}()\n";
                $errorStack[] = $temp;
            }
            if(isset($_SERVER['REQUEST_URI'])) $log.='REQUEST_URI='.$_SERVER['REQUEST_URI'];
            $trace = $errorStack;
    }
    /**
     * 处理错误机制
     *
     * @access public
     * @param mixed $code 错误代码
     * @param mixed $message 错误信息
     * @param mixed $file 错误文件
     * @param mixed $line 行号
     * @param mixed $errContext 错误内容
     * @return void
     */
    public static function handleError($code,$message,$file,$line,$errContext)
    {
        //页面中正确运行的部分
        if(ob_get_length()>0)ob_end_clean();
        $errorStack = null;
        if($code & error_reporting()){
            restore_error_handler();
            restore_exception_handler();
            $log="$message (".str_replace(TINY_ROOT,"",$file).":$line)\r\nStack trace:\r\n";
            $trace=debug_backtrace();
            self::paseErrorTrace($trace,$log);
            $errorStack = $trace;
        }
        try{
            $errorType;
            switch($code){
                case E_ERROR:$errorType='ERROR';break;
                case E_WARNING:$errorType='WARNING';break;
                case E_NOTICE:$errorType='NOTICE';break;
                case E_USER_ERROR:$errorType='USER_ERROR';break;
                case E_USER_WARNING:$errorType='USER_WARNING';break;
                case E_USER_NOTICE:$errorType='USER_NOTICE';break;
                case E_PARSE:$errorType='PARSE_ERROR';break;
                default:$errorType='UNKNOWN';break;
            }

            if(isset($log))Tiny::log($log,$errorType);
            $error_file = new File($file);
            $codes = $error_file->gets($line);
            if(defined("APP_ROOT")) $file = str_replace(APP_ROOT,"",$file);
            $file = str_replace(TINY_ROOT,"",$file);

            $datas = array('errorType'=>$errorType,'file'=>$file,'line'=>$line,'codes'=>htmlspecialchars($codes),'errorStack'=>$errorStack,'errorContent'=>$errContext);
            $error = new TError(Tiny::app(),$message,null,$datas);

            if($error){
                self::$_iserror = false;
                $error->handle();
            }
            else self::displayError($code,$message,$file,$line);
        }catch(Exception $e){
            self::displayException($e);
        }
        exit;
    }
    /**
     * 展示错误代码
     *
     * @access public
     * @param mixed $code
     * @param mixed $message
     * @param mixed $file
     * @param mixed $line
     * @return mixed
     */
    public static function displayError($code,$message,$file,$line)
    {
        if(DEBUG){
            echo "<h1>PHP Error [$code]</h1>\n";
            echo "<p>$message ($file:$line)</p>\n";
            echo '<pre>';
            debug_print_backtrace();
            echo '</pre>';
        }else{
            echo "<h1>PHP Error [$code]</h1>\n";
            echo "<p>$message</p>\n";
        }
    }
    /**
     * 展示异常代码
     *
     * @access public
     * @param mixed $exception
     * @return mixed
     */
    public static function displayException($exception)
    {
        if(DEBUG){
            echo '<h1>'.get_class($exception)."</h1>\n";
            echo '<p>'.$exception->getMessage().' ('.$exception->getFile().':'.$exception->getLine().')</p>';
            echo '<pre>'.$exception->getTraceAsString().'</pre>';
        }else{
            echo '<h1>'.get_class($exception)."</h1>\n";
            echo '<p>'.$exception->getMessage().'</p>';
        }
    }

    /**
     *引入一些函数文件
     *
     * @access public
     * @param mixed $alias
     * @return mixed
     */
    public static function import($alias)
    {
        if(isset(self::$_imports[$alias]) && !isset(self::$_isimports[$alias])){
            self::$_isimports[$alias]=$alias;
            include(TINY_ROOT.self::$_imports[$alias]);
        }
    }
    /**
     * 类的自动加载
     *
     * @access public
     * @param mixed $className
     * @return mixed
     */
    public static function autoload($className)
    {
        if(preg_match('/^[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*$/', $className)==0)return null;
        if(isset(self::$_coreClasses[$className])){
            include(TINY_ROOT.self::$_coreClasses[$className]);
        }else if(isset(self::$_classes)){
            if(isset(self::$_classes[$className])){
                $fileName = APP_CODE_ROOT.self::$_classes[$className];
                if(is_file($fileName))include($fileName);
                return true;
            }else{

                if(strrchr($className,'Controller')=='Controller'){
                    $fileName = APP_CODE_ROOT.'controllers/'.strtolower(substr($className,0,-10)).'.php';
                    if(is_file($fileName)){
                        include($fileName);
                        return true;
                    }else{
                        self::loadExtendsClass($className);
                    }
                }else if(strrchr($className,'Service')=='Service'){
                    $fileName = APP_CODE_ROOT.'services/'.strtolower(substr($className,0,-7)).'.php';
                    if(is_file($fileName)){
                        include($fileName);
                        return true;
                    }
                }else if(strrchr($className,'Widget')=='Widget'){
                    $fileName = APP_CODE_ROOT.'widgets/'.strtolower(substr($className,0,-6)).'.php';
                    $theme = self::app()->getTheme();
                    if($theme!==null){
                        $temfile = $theme->getBasePath().DIRECTORY_SEPARATOR.'widgets/'.strtolower(substr($className,0,-6)).'.php';
                        if(is_file($temfile))$fileName = $temfile;
                    }
                    if(is_file($fileName)){
                        include($fileName);
                        return true;
                    }
                }else{
                    self::loadExtendsClass($className);
                }
            }
        }
        return true;
    }
    /**
     * 加载用户自定义类
     * @param  String $className 类名
     * @return mixed   成功为true 失败为null
     */
    public static function loadExtendsClass($className)
    {
        if(isset(self::$_classes_index[$className])){
            if(is_file(self::$_classes_index[$className])) include(self::$_classes_index[$className]);
            return true;
        }else{
            foreach(self::$_classes as $classPath)
            {
                $class_base_path = APP_CODE_ROOT.strtr(trim($classPath,'*'),'.','/');
                $class_index = $class_base_path.'class_index.php';
                if(is_file($class_index)){
                    $classes_index = include($class_index);
                    foreach($classes_index as $k=>$v){
                        if(!isset(self::$_classes_index[$k])) self::$_classes_index[$k] = $class_base_path.$v;
                    }
                }
                if(isset(self::$_classes_index[$className])){
                    if(is_file(self::$_classes_index[$className]))include(self::$_classes_index[$className]);
                    return true;
                }else{
                    $fileName = $class_base_path.$className.'.php';
                    if(is_file($fileName))
                    {
                        include($fileName);
                        return true;
                    }
                }

            }
            return null;
        }
    }
    /**
     * 消息处理函数
     *
     * @access public
     * @param mixed $sender
     * @param mixed $message
     * @param int $code
     * @param array $data
     * @return mixed
     */
    public static function Msg($sender, $message, $code=404,$data=array())
    {
        $error = new TError($sender,$message,$code,$data);
        $error->handle();
    }
    /**
     * 跳转前一页
     *
     * @access public
     * @return mixed
     */
    public function perPage()
    {
        header('Location: '.$_SERVER['HTTP_REFERER'], true, 302); exit;
    }
    /**
     * 设定要引入的文件，主要是项目中用到的自己要引入的函数文件
     *
     * @access public
     * @param mixed $alias
     * @return mixed
     */
    public static function setImports($alias)
    {
        if(is_array($alias)){
            foreach($alias as $alia=>$aliaPath){
                self::$_imports[$alia]=self::$_basePath.$aliaPath;
            }
        }
    }
    /**
     * 日志记录
     *
     * @access public
     * @param mixed $msg
     * @param mixed $level
     * @return mixed
     */
    public static function log($msg,$level=Logger::INFO)
    {

        if(self::$_logger===null) self::$_logger=new Logger();
        self::$_logger->log($msg,$level);
    }
    /**
     * 得到日志处理类
     *
     * @access public
     * @return mixed
     */
    public static function getLogger(){
        if(self::$_logger===null) self::$_logger=new Logger();
        return self::$_logger;
    }
    /**
     * 主要是引入项目中用户自己写的类
     *
     * @access public
     * @param mixed $classNames
     * @return mixed
     */
    public static function setClasses($classNames)
    {
        if(is_array($classNames)){
            self::$_classes += $classNames;
        }else if(is_string($classNames)){
            self::$_classes += array($classNames);
        }
    }
    //系统中的函数文件
    private static $_imports = array(
        );
    //系统的中类文件
    private static $_coreClasses = array(
        'Filter'=>'lib/util/filter_class.php',
        'Crypt'=>'lib/util/crypt_class.php',
        'Cookie'=>'lib/util/cookie_class.php',
        'Session'=>'lib/util/session_class.php',
        'Safebox'=>'lib/util/safebox_class.php',
        'Validator'=>'lib/util/validator_class.php',
        'CHash'=>'lib/util/hash_class.php',
        'Url'=>'lib/util/url_class.php',
        'Paging'=>'lib/util/paging_class.php',
        'Req'=>'lib/util/request_class.php',
        'Chips'=>'lib/util/chips_class.php',
        'Route'=>'lib/util/route_class.php',
        'Image'=>'lib/util/image_class.php',
        'TimeTest'=>'lib/util/timetest_class.php',
        'Date'=>'lib/util/date_class.php',
        'Captcha'=>'lib/util/captcha_class.php',
        'Http'=>'lib/util/http_class.php',
        'Backup'=>'lib/db/backup_class.php',
        'DBMysql'=>'lib/db/db_mysql_class.php',
        'DBMysqli'=>'lib/db/db_mysqli_class.php',
        'DBFactory'=>'lib/db/dbfactory_class.php',
        'File'=>'lib/file/file_class.php',
        'UploadFile'=>'lib/file/uploadfile_class.php',
        'XMLOperator'=>'lib/doc/xmloperator_class.php',
        'JSON'=>'lib/doc/json_class.php',
        'Object'=>'base/object_class.php',
        'Event'=>'base/event_class.php',
        'Logger'=>'base/logger_class.php',
        'ModelEvent'=>'base/model_event_class.php',
        'Module'=>'base/module_class.php',
        'Query'=>'web/model/query_class.php',
        'Application'=>'base/interfaces.php',
        'App'=>'base/application_class.php',
        'WebApp'=>'base/webapp_class.php',
        'Controller'=>'web/controller/controller_class.php',
        'Model'=>'web/model/model_class.php',
        'Tag'=>'base/tag_class.php',
        'TError'=>'base/error_class.php',
        'BaseAction'=>'web/action/baseaction_class.php',
        'Action'=>'web/action/action_class.php',
        'InlineAction'=>'web/action/inlineaction_class.php',
        'ViewAction'=>'web/action/viewaction_class.php',
        'View'=>'web/views/view_class.php',
        'Manager'=>'web/auth/manager_class.php',
        'Roles'=>'web/auth/roles_class.php',
        'Theme'=>'web/theme_class.php',
        'ThemeManager'=>'web/thememanager_class.php',
        'JS'=>'web/js/jspackages.php',
        'Widget'=>'base/widget_class.php',
        'ICache'=>'cache/cache_inte.php',
        'CacheFactory'=>'cache/cachefactory_class.php',
        'FileCache'=>'cache/filecache_class.php',
        'DbCache'=>'cache/dbcache_class.php',
        'ExtensionCollection'=>'base/extension_collection_class.php',
        'ExtensionFactory'=>'base/extension_factory_class.php',
        'Debug'=>'lib/util/debug_class.php',
        'TString'=>'lib/util/string_class.php',
        'PHPMailer'=>'extend/phpmailer/class.phpmailer.php',
        'POP3'=>'extend/phpmailer/class.pop3.php',
        'SMTP'=>'extend/phpmailer/class.smtp.php'
    );
}
