<?php
/**
 * 路由处理类
 * 
 * @author  Crazy、Ly
 * @class Route
 */
class Route
{
    private static $splitChars = '::=::';
    private static $routes = array();
    private static $rules = array();
    
    public function __construct($rules=array())
    {
        if(empty(self::$routes) && is_array($rules))
        {
            foreach($rules as $pattern=>$value)
            {
                
                $routes_key = preg_replace('/<(\w+):?(.*?)?>/i','(?P<$1>$2)',$pattern);
                if(!isset(self::$routes[$routes_key]))self::$routes[$routes_key] = $value;
                
                $rules_key = preg_replace('/<(\w+):?(.*?)?>/i','<$1>',$pattern);
                $param_key = preg_replace('/(<_a>|<_c>)/i','',$rules_key);
                $param_key = preg_replace('/[^<]*(<(\w+)>)?/i','/$2',$param_key);
                $value .= rtrim($param_key,'/');
                if(!isset(self::$rules[$value])) self::$rules[$value] = $rules_key.self::$splitChars.$routes_key;
                else self::$rules[$value] = array_merge((is_string(self::$rules[$value])?array(self::$rules[$value]):self::$rules[$value]),array($rules_key.self::$splitChars.$routes_key));
            }
        }
    }
    public function getRoutes()
    {
        return self::$routes;
    }
    public function getRules()
    {
        return self::$rules;
    }
    //url解析
    public function parseRoute($url)
    {
        foreach(self::$routes as $pattern =>$value)
        {
            
            if(preg_match('/^'.str_replace('/','\/',$pattern).'$/', $url, $matches))
            {
                foreach($matches as $key => $v)
                {
                    if(is_int($key))unset($matches[$key]);
                    else
                    {
                        if($key =='_c')
                        {
                            unset($matches[$key]);
                            $matches['con'] = $v;
                        }
                        else if($key =='_a')
                        {
                            unset($matches[$key]);
                            $matches['act'] = $v;
                        }
                    }
                    
                }
                
                $ca = explode('/',$value);
                
                if(!isset($matches['con']))$matches['con'] = (isset($ca[0]) && $ca[0]!='<_c>')?$ca[0]:'index';
                if(!isset($matches['act']))$matches['act'] = (isset($ca[1]) && $ca[1]!='<_a>')?$ca[1]:'index';
                return $matches;
            }
        }
    }
    public function createRoute($params,$param_key='')
    {
        if(is_array($params))
        {
            $_c = isset($params['con'])?$params['con']:'<_c>';
            $_a = isset($params['act'])?$params['act']:'<_a>';
            
            unset($params['con']);
            unset($params['act']);
            $params['_c'] = $_c;
            $params['_a'] = $_a;
            if($param_key!='')$param_key = '/'.rtrim($param_key,'/');
            
            $rules = self::$rules;
            
            $keys = array();
            if(isset($rules[$_c .'/'.$_a.$param_key]))$keys[] = $_c .'/'.$_a.$param_key;
            if(isset($rules['<_c>/'.$_a.$param_key])) $keys[] = '<_c>/'.$_a.$param_key;
            if(isset($rules[$_c.'/<_a>'.$param_key])) $keys[] = $_c.'/<_a>'.$param_key;
            if(isset($rules['<_c>/<_a>'.$param_key])) $keys[] ='<_c>/<_a>'.$param_key;
            $url = $this->findRoute($params,$keys);
            if($url !== null) return $url;
        }
    }
    private function findRoute($params,$keys)
    {
        foreach($keys as $key)
        {
            if(isset(self::$rules[$key]))
            {
                $rule = self::$rules[$key];
                if(is_array($rule))
                {
                    foreach($rule as $rul)
                    {
                        $result = $this->getRoute($params,$rul);
                        if($result!==null) return $result;
                    }
                }
                else
                {
                    $result = $this->getRoute($params,$rule);
                    if($result!==null) return $result;
                }
            }
        }
        return null;
    }
    private function getRoute($params,$rule)
    {
        $keys = array_keys($params);
        $rule_arr =  explode(self::$splitChars,$rule);
        $rule = $rule_arr[0];
        $str = str_replace($keys,$params,$rule);
        $new_url = str_replace(array('<','>'),array('',''),$str);

        $route = $rule_arr[1];
        $matches = array();
        if(preg_match('/^'.str_replace('/','\/',$route).'$/', $new_url, $matches))
        {
           
            $parames = array_diff_key($params,$matches);
            unset($parames['_c']);
            unset($parames['_a']);

            if(!empty($parames))
            {
                $parames = http_build_query($parames);
            }
            else
            {
                $parames='';
            }
            return rtrim($new_url,'/').($parames==''?'':'?'.$parames);
        }
        return null;
    }
}
?>