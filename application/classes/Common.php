<?php
class Common
{
    //检测表达式
    private static function check_condition($condition)
    {
        return !!preg_match('/^(\S+--\S+--\S+--[\S ]+__)*(\S+--\S+--\S+--[\S ]+)$/', $condition);
    }
    //字符串转条件
    public static function str2where($condition)
    {
        if(self::check_condition($condition))
        {
            $condition = preg_replace('/^(and|or)/i', '', $condition);
            $condition = str_replace(array('--','__'), array(' ',"' "), $condition);
            $old_char=array(' ne ',' eq ',' lt ',' gt ',' le ',' ge ',' ct ',' nct ');
            $new_char=array(" != '"," = '"," < '"," > '"," <= '"," >= '", " like '%"," not like '%");
            $condition = str_replace($old_char, $new_char, $condition);
            $condition = preg_replace("/\s+(like\s+'[^']+)('|$)/i", " $1%$2", $condition);
            if($condition!='') $condition .= "'";
            return $condition;
        }
        return null;
    }
    //生成订单编号
    public static function createOrderNo()
    {
        return date('YmdHis').rand(100000,999999);
    }

    //发放代金券
    public static function paymentVoucher($voucherTemplate,$userID=null)
    {
        $model = new Model("voucher");
        do{
            $account = strtoupper(CHash::random(10,'char'));
            $password = strtoupper(CHash::random(10,'char'));
            $obj = $model->where("account = '$account'")->find();
        }while($obj);
        $start_time = date('Y-m-d H:i:s');
        $end_time = date('Y-m-d H:i:s', strtotime('+'.$voucherTemplate['valid_days'].' days'));
        $model->data(array('account'=>$account,'password'=>$password,'name'=>$voucherTemplate['name'],'value'=>$voucherTemplate['value'],'start_time'=>$start_time,'end_time'=>$end_time,'money'=>$voucherTemplate['money'],'is_send'=>1,'user_id'=>$userID))->insert();
    }

    //分类的树状化数组
    public static function treeArray($datas){
        $result = array();
        $I = array();
        foreach($datas as $val) {
            $sort = intval($val['sort']);
            if($val['parent_id'] == 0)
            {
                if(isset($result[$val['sort']])) $i = count($result[$val['sort']]);
                else $i = 0;
                $result[$sort][$i] = $val;
                $I[$val['id']] = &$result[$sort][$i];
                krsort($result);
            } else
            {
                if(isset($I[$val['parent_id']]['child'][$sort])) $i = count($I[$val['parent_id']]['child'][$sort]);
                else $i = 0;
                $I[$val['parent_id']]['child'][$sort][$i] = $val;
                krsort($I[$val['parent_id']]['child']);
                $I[$val['id']] = &$I[$val['parent_id']]['child'][$sort][$i];
            }
        }
        return self::parseTree($result);
    }
    //递归树状数组
    public static function parseTree($result,&$tree = array())
    {
        foreach ($result as $items)
        {
            if(is_array($items))
            {
                foreach ($items as $item)
                {
                    $tem = $item;
                    if(isset($item['child'])) unset($tem['child']);
                    $tree[] = $tem;
                    if(isset($item['child']))self::parseTree($item['child'],$tree);
                }
            }
        }
        return $tree;
    }
    //价格区间计算
    static function priceRange($range)
    {
        $d0 = intval($range['min'],-2);
        $d1 = intval(($range['min']+$range['avg'])/2);
        $d2 = intval($range['avg']);
        $d3 = intval(($range['max']+$range['avg'])/2);
        $d4 = intval($range['max']);

        if($d4>$d3 && $d3>$d2 && $d2>$d1 && $d1>$d0){
            $d1 = self::formatInt($d1);
            $d2 = self::formatInt($d2);
            $d3 = self::formatInt($d3);
            $d4 = self::formatInt($d4);
            $price_range[0] = '0-'.$d1;
            if($d2-$d1>2) $price_range[1] = $d1.'-'.($d2-1);
            else $price_range[1] = $d1.'-'.$d2;
            if($d3-$d2>2) $price_range[2] = $d2.'-'.($d3-1);
            else $price_range[2] = $d2.'-'.$d3;
            if($d4-$d3>2) $price_range[3] = $d3.'-'.($d4-1);
            else $price_range[3] = $d3.'-'.$d4;
            $price_range[4] = "$d4";
            return $price_range;
        }else{
            if($d2!=0){
                $d2 = self::formatInt($d2);
                if($d2>1)return array(0=>('0-'.($d2-1)),1=>"$d2");
                else return array(0=>('0-'.($d2)),1=>"$d2");
            }else if($range['min']!=0){
                return array(0=>('0-'.($range['min'])),1=>"$range[min]");
            }
            else return array();
        }
    }

    static function formatInt($value)
    {
        $len = strlen($value);
        switch ($len) {
            case 1:
                break;
            case 2:
                $value = round($value,-1);
                break;
            case 3:
            case 4:
                $value = round($value,-2);
                break;
            default:
                $value = round($value,2-$len);
                break;
        }
        return $value;
    }

    //thumb
    static function thumb($image_url,$w=200,$h=200)
    {
        if(preg_match('@http://@i',$image_url)) return $image_url;
        $access_image_size = array(
            '220_220'=>true,
            '100_100'=>true,
            '367_367'=>true
            );
        $theme_config = Tiny::app()->getTheme()->getConfigInfo();
        if($theme_config!=null && isset($theme_config['access_image_size'])){
            $access_image_size = array_merge($access_image_size,$theme_config['access_image_size']);
        }
        if(func_num_args()==2)$h = $w;
        if($image_url == '') return '';

        if(isset($access_image_size[$w.'_'.$h])){

            $ext = strtolower(strrchr($image_url,'.'));
            $result_url = $image_url.'__'.$w.'_'.$h.$ext;
            if(!file_exists(APP_ROOT.$result_url)){
                $image = new Image();
                $image->suffix = 'f_w_h';
                $result_url = $image->thumb(APP_ROOT.$image_url,$w,$h);
                $result_url = str_replace(APP_ROOT, '', $result_url);
            }
            return Url::urlFormat('@'.$result_url);
        }else{
            return Url::urlFormat('@'.$image_url);
        }

    }

    //自动登录时的用户信息
    static function autoLoginUserInfo()
    {
        $cookie = new Cookie();
        $cookie->setSafeCode(Tiny::app()->getSafeCode());
        $autologin = $cookie->get('autologin');
        $obj = null;
        if($autologin!=null){
            $account = Filter::sql($autologin['account']);
            $password = $autologin['password'];
            $model = new Model("user as us");
            $obj = $model->join("left join customer as cu on us.id = cu.user_id")->fields("us.*,cu.group_id,cu.user_id,cu.login_time,cu.mobile")->where("us.email='$account' or us.name='$account' or cu.mobile='$account'")->find();
            if($obj['password'] != $password){
                $obj = null;
            }
        }else{
            $weixin_openid = Cookie::get('weixin_openid');
            if($weixin_openid != null){
                $model = new Model('oauth_user');
                $oauth_user = $model->where("oauth_type='WeixinOAuth' and open_id='$weixin_openid'")->find();
                if($oauth_user && $oauth_user['user_id']!=''){
                    $model = new Model("user as us");
                    $obj = $model->join("left join customer as cu on us.id = cu.user_id")->fields("us.*,cu.group_id,cu.user_id,cu.login_time,cu.mobile")->where("us.id=".$oauth_user['user_id'])->find();
                }
            }
        }
        return $obj;
    }
    //取得支付方式信息
    static function getPaymentInfo($id)
    {
        $model = new Model('payment as pa');
        $payment = $model->join('left join pay_plugin as pp on pa.plugin_id = pp.id')->where("pa.id = ".$id)->find();
        return $payment;
    }
}
