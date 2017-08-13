<?php
/**
 * description...
 *
 * @author Crazy、Ly
 * @package WeixinController
 */
class WeixinController extends Controller{

    private $weixin;
    //当前Key
    private $currentKey;

    //当前公众号ID
    private $publicId;

    //当前token
    private $token;

    public function init(){

    }

    function __call($func, $args=null)
    {
        $token = Filter::sql($func);
        $wx_model = new Model('wx_public');
        $wx_obj = $wx_model->where("token='$token'")->find();
        if($wx_obj){
            $this->publicId = $wx_obj['id'];
            $this->token = $token;
            $this->weixin = new WeChat($wx_obj['app_id'],$wx_obj['app_secret'],$wx_obj['token']);
            $echostr = Req::args('echostr');
            if($echostr){
                $this->weixin->checkSign();
            }else{
                //$this->weixin->response($this->event($msg));
                $msg = $this->weixin->getMessage();
               if(isset($msg->fromUserName)){
                    $response = $this->event();
                    if($response!=null) $this->weixin->response($response);
                    exit;
                }else{
                    Tiny::Msg($this,404);
                }
            }

        }
    }

    private function event()
    {
        $object = $this->weixin->currentMessage();
        $response = new stdclass();
        $open_id = $object->fromUserName;

        if($object->msgType == 'event'){
            switch ($object->event)
            {
                case "scancode_waitmsg":
                case "scancode_push":
                case "pic_sysphoto":
                case "pic_photo_or_album":
                case "pic_weixin":
                case "location_select":
                case "click":
                    $key = $object->eventKey;
                    break;
                default:
                    $key = $object->event;
                    break;
            }
            $model = new Model('wx_response');
            if($key=='kf_create_session'){
                $KfAccount = $object->kfAccount;
                $text = new stdclass();
                $text->content = "欢迎您使用人工客服系统！";
                $customservice = new stdclass();
                $customservice->kf_account = $KfAccount;
                $response->customservice = $customservice;
                $response->msgtype = 'text';
                $response->touser = $open_id;
                $response->text = $text;
                $this->weixin->sendMessage($response);
                exit;

            }else if($key=='kf_close_session'){
                $KfAccount = $object->kfAccount;
                $text = new stdclass();
                $text->content = "感谢您使用人工客服系统，再见。";
                $customservice = new stdclass();
                $customservice->kf_account = $KfAccount;
                $response->customservice = $customservice;
                $response->msgtype = 'text';
                $response->touser = $open_id;
                $response->text = $text;
                $this->weixin->sendMessage($response);
                exit;

            }else if($key=='subscribe' || $key == 'unsubscribe'){
                $obj = $model->where("event_key='".$this->token.'-'.$key."' or event_key='$key'")->find();
            }else{
                $obj = $model->where("event_key='$key'")->find();
            }

            if($obj){
                $content = unserialize($obj['content']);
                if($obj['type']=='app'){
                    $weixinService = new WeixinService($this->weixin);
                    $response = $weixinService->response($content);

                    $context_model = new Model('wx_context');
                    $context = $context_model->where('public_id ='.$this->publicId." and open_id='$open_id'")->find();
                    if($context){
                        $context_model->data(array('current_key'=>$key,'command'=>''))->where('id='.$context['id'])->update();
                    }else{
                        $context_model->data(array('current_key'=>$key,'command'=>'','public_id' => $this->publicId,'open_id'=>$open_id))->insert();
                    }

                }else{
                    $response->msgType = $obj['type'];
                    foreach ($content as $key => $value) {
                        $response->$key = $value;
                    }
                }
            }else{
                return null;
            }
        }else{
            $context_model = new Model('wx_context');
            $context = $context_model->where("public_id = {$this->publicId} and open_id='$open_id'")->find();
            if($context){
                $this->currentKey = $context['current_key'];
            }else{
                $this->currentKey = null;
            }
            if($this->currentKey !=null){
                $model = new Model('wx_response');
                $obj = $model->where("event_key='$this->currentKey'")->find();
                if($obj){
                    $content = unserialize($obj['content']);
                    $weixinService = new WeixinService($this->weixin);
                    $response = $weixinService->command($content,$context);
                }
            }else{
                $weixinService = new WeixinService($this->weixin);
                $this->weixin->response($weixinService->searchGoods());
            }
        }
        return $response;
    }
}
