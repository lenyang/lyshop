<?php

class SinaOAuth extends OAuth{
    /**
     * 获取requestCode的api接口
     * @var string
     */
    protected $requestCodeURL = 'https://api.weibo.com/oauth2/authorize';

    /**
     * 获取access_token的api接口
     * @var string
     */
    protected $accessTokenURL = 'https://api.weibo.com/oauth2/access_token';

    /**
     * API根路径
     * @var string
     */
    protected $apiBase = 'https://api.weibo.com/2/';

    /**
     * 组装接口调用参数 并调用接口
     * @param  string $api    微博API
     * @param  string $param  调用API的额外参数
     * @param  string $method HTTP请求方法 默认为GET
     * @return json
     */
    public function call($api, $param = '', $method = 'GET', $multi = false){
        /* 新浪微博调用公共参数 */
        $params = array(
            'access_token' => $this->token['access_token'],
        );

        $vars = $this->param($params, $param);
        $data = $this->http($this->url($api, '.json'), $vars, $method, array(), $multi);
        return json_decode($data, true);
    }

    /**
     * 解析access_token方法请求后的返回值
     * @param string $result 获取access_token的方法的返回值
     */
    protected function parseToken($result, $extend){
        $data = json_decode($result, true);
        if($data['access_token'] && $data['expires_in'] && $data['remind_in'] && $data['uid']){
            $data['openid'] = $data['uid'];
            unset($data['uid']);
            return $data;
        } else
            throw new Exception("获取新浪微博ACCESS_TOKEN出错：{$data['error']}");
    }

    /**
     * 获取当前授权应用的openid
     * @return string
     */
    public function openid(){
        $data = $this->token;
        if(isset($data['openid']))
            return $data['openid'];
        else
            throw new Exception('没有获取到新浪微博用户ID！');
    }

    public function getUserInfo(){
        $data = $this->call('users/show', "uid={$this->openid()}");

        if(!isset($data['error_code']) || $data['error_code'] == 0){
            $userInfo['type'] = 'SINA';
            $userInfo['name'] = $data['name'];
            $userInfo['open_name'] = $data['screen_name'];
            $userInfo['head'] = $data['avatar_large'];
            return $userInfo;
        } else {
            throw_exception("获取新浪微博用户信息失败：{$data['error']}");
        }
    }

}
