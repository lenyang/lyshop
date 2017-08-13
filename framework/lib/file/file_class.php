<?php
 /**
  * 文件处理类
  *
  * @author Crazy、Ly
  * @class File
  */
class File
{
    private $file;
    private $fileName;
    /**
     * 构造方法
     *
     * @access public
     * @param mixed $file
     * @param string $mode
     * @return mixed
     */
    public function __construct($file=null,$mode='r+')
    {
        if(!is_null($file)){
            $this->fileName = $file;
            $dir=dirname($this->fileName);
            if(!file_exists($dir))$this->mkdir($dir);
            $this->file = fopen($file,$mode);
        }
    }
    /**
     * 析构关闭成功
     *
     * @access public
     * @return mixed
     */
    public function __destruct()
    {
        if(is_resource($this->file)){
            fclose($this->file);
            unset($this->fileName);
            unset($this->file);
        }
    }
    /**
     * 写入数据
     *
     * @access public
     * @param mixed $str
     * @return mixed
     */
    public function write($str)
    {
        $falg = false;
        if(is_writeable($this->fileName) && flock($this->file, LOCK_EX | LOCK_NB)){
            if(is_object($str) || is_array($str)) $str = serialize($str);
            $flag = fwrite($this->file,$str)>0?true:false;
        }
        unset($str);
        flock($this->file, LOCK_UN | LOCK_NB);
        return $flag;
    }
    /**
     * 读取数据
     *
     * @access public
     * @return mixed
     */
    public function read()
    {
        $contents = fread($this->file, filesize($this->fileName));
        $tem = substr($contents,0,10);
        if(preg_match('/^[Oa]:\d+:.*/',$tem)){
            $contents = unserialize($contents);
        }
        return $contents;
    }
    /**
     * 读取指定的一行记录
     *
     * @access public
     * @param int $start 开始位置
     * @param int $len
     * @return mixed
     */
    public function gets($start=0,$len=1)
    {
        if($start<=0)$start = 0;
        if($len<1) $len = 1;
        $end = $start+$len;
        $contents='';
        for($i = 0; !feof($this->file) && $i<$end-1;$i++){
            if($i >= $start-1)$contents.="line: ".($i+1)." ".fgets($this->file);
            else fgets($this->file);
        }
        return $contents;
    }
    /**
     * 取得文件内容
     *
     * @access public
     * @param mixed $fileName
     * @return mixed
     */
    public static function getContents($fileName)
    {
        return file_get_contents($fileName);
    }
    /**
     * 写入文件内容
     *
     * @access public
     * @param mixed $fileName
     * @param mixed $contents
     * @return mixed
     */
    public static function putContents($fileName,$contents)
    {
        $fileName = str_replace('/',DIRECTORY_SEPARATOR, $fileName);
        if(!file_exists($fileName)) self::mkdir(dirname($fileName));
        return file_put_contents($fileName,$contents);
    }
    /**
     * 创建目录,实现多级目录的创建
     *
     * @access public
     * @param mixed $dir
     * @param int $right
     * @return mixed
     */
    public static function mkdir($dir,$right=0777)
    {
        return is_dir($dir) || (self::mkdir(dirname($dir)) && mkdir($dir, $right));
    }
    /**
     * 删除目录下的所有文件
     *
     * @access public
     * @param mixed $dir
     * @return mixed
     */
    public static function rmdir($dir)
    {
        if (!file_exists($dir)) return true;
        if (!is_dir($dir) || is_link($dir)) return unlink($dir);
        foreach (scandir($dir) as $item) {
            if ($item == '.' || $item == '..') continue;
            if (!self::rmdir($dir . "/" . $item)) {
                chmod($dir . "/" . $item, 0777);
                if (!self::rmdir($dir . "/" . $item)) return false;
            };
        }
        return rmdir($dir);
    }
    /**
     * 目录复制功能
     *
     * @access public
     * @param mixed $source 源目录
     * @param mixed $dest 目标目录
     * @param bool $oncemore
     * @return boolean
     */
    public static function xcopy($source, $dest ,$oncemore=true)
    {
        if (!file_exists($source)){
            trigger_error("$source is not exist!",E_ERROR);
        }
        if (is_dir($source)){
            if (file_exists($dest) && !is_dir($dest)){
                trigger_error("$dest is not a dir",E_ERROR);
            }
            if (!file_exists($dest)){
                self::mkdir($dest,0777);
            }
            $od = opendir($source);
            while ($one = readdir($od)){
                if ($one=="." || $one==".."){
                    continue;
                }
                $result = self::xcopy($source.DIRECTORY_SEPARATOR.$one, $dest.DIRECTORY_SEPARATOR.$one, $oncemore);
                if ($result !== true){
                    return $result;
                }
            }
            closedir($od);
        }else{
            if (file_exists($dest) || is_dir($dest) ){
                if ( func_num_args()>2 || $oncemore===true ){
                    trigger_error("$dest is not a dir",E_ERROR);
                }
                $result = self::xcopy($source, $dest.DIRECTORY_SEPARATOR.basename($source), $oncemore);
                if ( $result !== true ){
                    return $result;
                }
            }else{
                if(!file_exists(dirname($dest))) self::mkdir(dirname($dest));
                copy($source, $dest);
                touch($dest, filemtime($source));
            }
        }
        return true;
    }
    /**
     * socket 功能访问
     *
     * @access public
     * @param mixed $url
     * @param int $limit
     * @param string $post
     * @param string $cookie
     * @param string $ip
     * @param int $timeout
     * @param bool $block
     * @return mixed
     */
    public static function socket($url, $limit = 0, $post = '', $cookie = '', $ip = '', $timeout = 20, $block = TRUE)
    {
        $return = '';
        $matches = parse_url($url);
        !isset($matches['host']) && $matches['host'] = '';
        !isset($matches['path']) && $matches['path'] = '';
        !isset($matches['query']) && $matches['query'] = '';
        !isset($matches['port']) && $matches['port'] = '';
        $host = $matches['host'];
        $path = $matches['path'] ? $matches['path'].($matches['query'] ? '?'.$matches['query'] : '') : '/';
        $port = !empty($matches['port']) ? $matches['port'] : 80;
        if($post){
            $out = "POST $path HTTP/1.0\r\n";
            $out .= "Accept: */*\r\n";
            $out .= "Accept-Language: zh-cn\r\n";
            $out .= "Content-Type: application/x-www-form-urlencoded\r\n";
            $out .= "User-Agent: $_SERVER[HTTP_USER_AGENT]\r\n";
            $out .= "Host: $host\r\n";
            $out .= 'Content-Length: '.strlen($post)."\r\n";
            $out .= "Connection: Close\r\n";
            $out .= "Cache-Control: no-cache\r\n";
            $out .= "Cookie: $cookie\r\n\r\n";
            $out .= $post;
        }else{
            $out = "GET $path HTTP/1.0\r\n";
            $out .= "Accept: */*\r\n";
            $out .= "Accept-Language: zh-cn\r\n";
            $out .= "User-Agent: $_SERVER[HTTP_USER_AGENT]\r\n";
            $out .= "Host: $host\r\n";
            $out .= "Connection: Close\r\n";
            $out .= "Cookie: $cookie\r\n\r\n";
        }
        $fp = @fsockopen(($ip ? $ip : $host), $port, $errno, $errstr, $timeout);
        if(!$fp){
            return '';
        }else{
            stream_set_blocking($fp, $block);
            stream_set_timeout($fp, $timeout);
            @fwrite($fp, $out);
            $status = stream_get_meta_data($fp);
            if(!$status['timed_out']){
                while (!feof($fp)){
                    if(($header = @fgets($fp)) && ($header == "\r\n" ||  $header == "\n"))break;
                }
                $stop = false;
                while(!feof($fp) && !$stop){
                    $data = fread($fp, ($limit == 0 || $limit > 8192 ? 8192 : $limit));
                    $return .= $data;
                    if($limit){
                        $limit -= strlen($data);
                        $stop = $limit <= 0;
                    }
                }
            }
            @fclose($fp);
            return $return;
        }
    }

    /**
     * curl 功能
     *
     * @access public
     * @param mixed $url
     * @param array $conf
     * @return mixed
     */
    public static function curl_open($url, $conf = array())
    {
        if(!function_exists('curl_init') or !is_array($conf)) return FALSE;
        $post = '';
        $purl = parse_url($url);
        $arr = array(
            'post' => FALSE,
            'return' => TRUE,
            'cookie' => APP_ROOT.'data/cookie.txt',);
        $arr = array_merge($arr, $conf);
        $ch = curl_init();

        if($purl['scheme'] == 'https'){
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 1);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        }

        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, $arr['return']);
        curl_setopt($ch, CURLOPT_COOKIEJAR, $arr['cookie']);
        curl_setopt($ch, CURLOPT_COOKIEFILE, $arr['cookie']);
        if($arr['post'] != FALSE){
            curl_setopt($ch, CURL_POST, TRUE);
            if(is_array($arr['post'])){
                $post = http_build_query($arr['post']);
            } else {
                $post = $arr['post'];
            }
            curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
        }
        $result = curl_exec($ch);
        curl_close($ch);
        return $result;
    }
}
