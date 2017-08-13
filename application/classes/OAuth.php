<?php
/**
 * description...
 *
 * @author Crazy、Ly
 * @class OAuth
 */
abstract class OAuth{
    /**
     * 版本号
     *
     * @access protected
     * @var string
     */
    protected $version = '2.0';

    /**
     * 应用的appKey
     *
     * @access protected
     * @var string
     */
    protected $appKey = '';

    /**
     * 应用的appSecret
     *
     * @access protected
     * @var string
     */
    protected $appSecret = '';

     /**
      * 授权类型 response_type
      *
      * @access protected
      * @var string
      */
    protected $responseType = 'code';

     /**
      * grant_type 目前只能为 authorization_code
      *
      * @access protected
      * @var string
      */
    protected $grantType = 'authorization_code';

     /**
      * 回调页面URL地址
      *
      * @access protected
      * @var string
      */
    protected $callBack = '';

    /**
     * 获取request_code的额外参数 URL查询字符串格式
     * @var srting
     */
     /**
      * description...
      *
      * @access protected
      * @var unknown
      */
    protected $authorize = '';

     /**
      * request_code请求的URL
      *
      * @access protected
      * @var string
      */
    protected $requestCodeURL = '';

     /**
      * 获取access_token请求的URL
      *
      * @access protected
      * @var string
      */
    protected $accessTokenURL = '';

     /**
      * API根路径
      *
      * @access protected
      * @var string
      */
    protected $apiBase = '';

     /**
      * 授权后获取到的token信息
      *
      * @access protected
      * @var string
      */
    protected $token = null;

     /**
      * 接口类型
      *
      * @access private
      * @var string
      */
    private $type = '';
    /**
     * 配制参数
     *
     * @access private
     * @var array
     */
    private $config = array();

     /**
      * 构造方法，配置应用信息
      *
      * @access public
      * @param array $token
      * @return void
      */
    public function __construct($token = null){
        //取得OAuth的类型
        $class_name = get_class($this);

        //获取应用配置
        $model = new Model('oauth');
        $this->config = $model->where("class_name='".$class_name."'")->find();

        if(empty($this->config['app_key']) || empty($this->config['app_secret'])){
            throw new Exception('请配置您申请的APP_KEY和APP_SECRET');
        } else {
            $this->appKey    = $this->config['app_key'];
            $this->appSecret = $this->config['app_secret'];
            $this->callBack = Url::fullUrlFormat("/simple/callback/type/$class_name");
            $this->token     = $token;
        }
    }
     /**
      * 请求code URL地址
      *
      * @access public
      * @return string
      */
    public function getRequestCodeURL(){
        //Oauth 标准参数
        $params = array(
            'client_id'     => $this->appKey,
            'redirect_uri'  => $this->callBack,
            'response_type' => $this->responseType,
        );

        //获取额外参数
        if($this->authorize){
            parse_str($this->authorize, $_param);
            if(is_array($_param)){
                $params = array_merge($params, $_param);
            } else {
                throw new Exception('authorize配置不正确！');
            }
        }
        return $this->requestCodeURL . '?' . http_build_query($params);
    }

     /**
      * 获取access_token
      *
      * @access public
      * @param string $code 通过第三方获得的code
      * @param array $extend 扩展参数
      * @return Array
      */
    public function getAccessToken($code, $extend = null){

        $params = array(
                'client_id'     => $this->appKey,
                'client_secret' => $this->appSecret,
                'grant_type'    => $this->grantType,
                'code'          => $code,
                'redirect_uri'  => $this->callBack,
        );
        $data = $this->http($this->accessTokenURL, $params, 'POST');
        $this->token = $this->parsetoken($data, $extend);
        return $this->token;
    }
     /**
      * 参数合并
      *
      * @access protected
      * @param array $params  默认参数
      * @param array/string $param 额外参数
      * @return array
      */
    protected function param($params, $param){
        if(is_string($param))
            parse_str($param, $param);
        return array_merge($params, $param);
    }

     /**
      * 获取指定API请求的URL
      *
      * @access protected
      * @param string $api API名称
      * @param string $fix api后缀
      * @return string      请求的完整URL
      */
    protected function url($api, $fix = ''){
        return $this->apiBase . $api . $fix;
    }

     /**
      * 发送HTTP请求方法，目前只支持CURL发送请求
      *
      * @access protected
      * @param string $url    请求URL
      * @param array  $params 请求参数
      * @param string $method 请求方法GET/POST
      * @param array  $header 请求的头信息
      * @param bool $multi 是否传输文件
      * @return mixed
      */
    protected function http($url, $params, $method = 'GET', $header = array(), $multi = false){
        $opts = array(
            CURLOPT_TIMEOUT        => 30,
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_SSL_VERIFYPEER => false,
            CURLOPT_SSL_VERIFYHOST => false,
            CURLOPT_HTTPHEADER     => $header
        );

        /* 根据请求类型设置特定参数 */
        switch(strtoupper($method)){
            case 'GET':
                $opts[CURLOPT_URL] = $url . '?' . http_build_query($params);
                break;
            case 'POST':
                //判断是否传输文件
                $params = $multi ? $params : http_build_query($params);
                $opts[CURLOPT_URL] = $url;
                $opts[CURLOPT_POST] = 1;
                $opts[CURLOPT_POSTFIELDS] = $params;
                break;
            default:
                throw new Exception('不支持的请求方式！');
        }

        /* 初始化并执行curl请求 */
        $ch = curl_init();
        curl_setopt_array($ch, $opts);
        $data  = curl_exec($ch);
        $error = curl_error($ch);
        curl_close($ch);
        if($error) throw new Exception('请求发生错误：' . $error);
        return  $data;
    }
     /**
      * 取得配制参数
      *
      * @access public
      * @return array
      */
    public function getConfig()
    {
      return $this->config;
    }

     /**
      * 抽象方法 组装接口调用参数 并调用接口
      *
      * @access protected
      * @param mixed $api 第三方开方的API
      * @param string $param  请求参数
      * @param string $method 请求的方式 get/post
      * @param bool $multi
      * @return mixed
      */
    abstract protected function call($api, $param = '', $method = 'GET', $multi = false);

     /**
      * 抽象方法 解析access_token方法请求后的返回值
      *
      * @access protected
      * @param mixed $result token返回值
      * @param mixed $extend 扩展参数
      * @return array
      */
    abstract protected function parsetoken($result, $extend);

     /**
      *  抽象方法，用户的openID
      *
      * @access public
      * @return string
      */
    abstract public function openid();
}
