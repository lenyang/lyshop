<?php
class NoticeService
{
    private $noticeClasses = array();

    public function send($notice_key,$datas)
    {
        $model = new Model('notice_template');
        $notices = $model->where("key_id='".$notice_key."' and status=1 ")->findAll();
        if($notices){
            foreach ($notices as $notice) {
                $style = $notice['style'];
                $obj = $this->getNotice($style);
                $tousers = null;
                if($notice['obje']==0){
                    $tousers = $notice['tousers'];
                }else{
                    if(isset($datas['tousers']))$tousers = $datas['tousers'];
                }

                if($tousers == ''){
                    $tousers = $datas['tousers'];
                }
                $tousers = explode(',', $tousers);
                $datas['template_id'] = $notice['template_id'];
                $datas['currency_unit'] = Tiny::app()->getController()->currency_unit;
                $pattern = array();
                $replacement = array();
                foreach($datas as $key => $val){
                    $pattern[] = '/__'.$key.'__/';
                    $replacement[] = $val;
                }
                $template = preg_replace($pattern, $replacement, $notice['template']);

                switch ($style) {
                   case 'weixin':
                        foreach ($tousers as $touser) {
                            $template_str = str_replace('__touser__', $touser, $template);
                            $obj->sendTemplateMessage($template_str);
                       }
                       break;
                    case 'sms':
                        foreach ($tousers as $touser) {
                            $obj->sendTemplate($touser,$notice['template_id'],$template);
                       }
                       break;

                   case 'email':
                        foreach ($tousers as $touser) {
                            $obj->send_email($touser,$notice['title'],$template);
                       }
                       break;
               }
            }
        }
    }

    public function getNotice($style){
        if(isset($this->noticeClasses[$style])){
            return $this->noticeClasses[$style];
        } else {
            $obj = null;
				switch ($style) {
					case 'weixin':
						if(class_exists("WeChat")){
							$obj = new WeChat();
							$this->noticeClasses['weixin'] = $obj;
						}
						break;
					case 'sms':
						if(class_exists('SMS')){
							$obj = SMS::getInstance();
							if($obj->getStatus()){
								$this->noticeClasses['sms'] = $obj;
							}
						}
						break;
					case 'email':
						$obj = new Mail();
						$this->noticeClasses['email'] = $obj;
						break;
				}
				if($obj == null){
					Tiny::app()->getController()->redirect('/index/msg',true,array('msg'=>'系统警告:','content'=>'你使用的版本有些提醒功能不支持，请不要开启。'));
					exit;
				}
            return $obj;
        }
    }
}
