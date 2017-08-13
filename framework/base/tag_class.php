<?php
/**
 * Tag类实现标签的处理
 *
 * @author Crazy、Ly
 * @class Tag
 */
class Tag
{
	private $viewPath;
	public static  $num = 0;
	//解析给定的字符串
	public function resolve($str,$path=null)
	{
		$this->viewPath = $path;
		return preg_replace_callback('/{(\/?)(\$|!|url|echo|query|widget|foreach|list|set|include|requier|if|elseif|else|while|for|token|dump|code|debug)\s*(:?)([^}]*)}/i', array(&$this,'translate'), $str);
		//return preg_replace_callback('/{(\/?)(\$|url|echo|query|widget|foreach|set|include|requier|if|elseif|else|while|for|code|debug)\s*(:?)((?:[^{}]|({$\w+}))*)}/i', array($this,'translate'), $str);
	}
    /**
     * 处理设定的每一个标签
     *
     * @access public
     * @param mixed $matches
     * @return mixed
     */
	public function translate($matches)
	{
		$suffix = '_'.self::$num++;
		if($matches[1]!=='/')
		{
			switch($matches[2].$matches[3])
			{
				case '$':
				{
					$str = trim($matches[4]);
					$data = explode('|', $str);
					if($str[0] == '.'  || $str[0] =='(') return $matches[0];
					$len = count($data);
					if($len == 1) return '<?php echo isset($'.$matches[4].')?$'.$matches[4].':"";?>';
					else if($len == 2) return '<?php echo isset($'.$data[0].')?$'.$data[0].':'.$data[1].';?>';
					else if($len > 2){
						$filter = strtolower($data[$len-1]);
						switch ($filter) {
							case 'encode':
								return '<?php echo isset($'.$data[0].')?htmlspecialchars($'.$data[0].'):'.$data[1].';?>';
							case 'int':
							case 'str':
							case 'float':
							case 'txt':
							case 'sql':
							case 'text':
								return '<?php echo isset($'.$data[0].')?Filter::'.$filter.'($'.$data[0].'):'.$data[1].';?>';
							default:
								return '<?php echo isset($'.$data[0].') && $'.$data[0].'?'.$data[1].':'.$data[2].';?>';
						}
					}
				}
				case '!':{
                    $str = trim($matches[4]);
                    $echo = '';
                    if($str[0] == '='){
                        $echo = "echo ";
                        $str = substr($str, 1);
                    }
                    $functions = explode('|', $str);
                    $funcStr = "";
                    $expressions = "";
                    $eqflag = false;
                    foreach ($functions as $key => $func) {
                    	$tem = '';
                        if($key == 0){
                            $funcStr = $func;
                        }else{
                            if(stristr($func, "!") !== FALSE ){
                            	$num = substr_count($func,"!");
                            	$eqstr = substr_count($func,"!->");
                            	if($num>1 || $eqstr>0){
                            		$expressions .= $eqflag? $funcStr.';':'$_='.$funcStr.';';
                            		$funcStr = str_ireplace("!", '$_', $func);
                            		$eqflag = !!$eqstr;
                            	}else{
                            		$funcStr = str_ireplace("!", '('.$funcStr.')', $func);
                            	}
                            }else{
                            	$func = trim($func);
                            	if(substr($func,-1)==')'){
	                                $funcStr = preg_replace("/^([^(]*)\(/", "$1($funcStr,", $func);
	                            }else{
	                                $funcStr = preg_replace("/^([^(]*)/", "$1($funcStr)", $func);
	                            }
                            }
                        }
                    }
                    return '<?php '.$expressions.$echo.$funcStr.';?>';
                }
				case 'echo:': return '<?php echo '.rtrim($matches[4],';/').';?>';
				case 'url:':return '<?php echo urldecode(Url::urlFormat("'.trim($matches[4]).'"));?>';
				case 'if:': return '<?php if('.$matches[4].'){?>';
				case 'elseif:': return '<?php }elseif('.$matches[4].'){?>';
				case 'else:': return '<?php }else{'.$matches[4].'?>';
				case 'set:': return '<?php '.rtrim($matches[4],';/').';?>';
				case 'while:': return '<?php while('.$matches[4].'){?>';
				case 'dump:':return '<pre><?php var_dump('.$matches[4].'); ?></pre>';
				case 'list:':
				case 'foreach:':
				{
					$attr = $this->getAttrs($matches[4]);
					if(!isset($attr['items'])) $attr['items'] = '$items';
					else $attr['items'] = $attr['items'];
					if(!isset($attr['key'])) $attr['key'] = '$key';
					else $attr['key'] = $attr['key'];
					if(!isset($attr['item'])) $attr['item'] = '$item';
					else $attr['item'] = $attr['item'];

					return '<?php foreach('.$attr['items'].' as '.$attr['key'].' => '.$attr['item'].'){?>';
				}
				case 'for:':
				{
					$attr = $this->getAttrs($matches[4]);
					if(!isset($attr['item'])) $attr['item'] = '$i';
					else $attr['item'] = $attr['item'];

					if(!isset($attr['from'])) $attr['from'] = 0;
					if(!isset($attr['to'])) $attr['to'] = 10;
					if(!isset($attr['step'])) $attr['step'] = 1;

					return '<?php for($total'.$suffix.' = (int) ceil(('.$attr['step'].' > 0 ? '.$attr['to'].'+1 - ('.$attr['from'].') : '.$attr['from'].'-('.$attr['to'].')+1)/abs('.$attr['step'].')),'.$attr['item'].' = '.$attr['from'].',$start'.$suffix.'=1 ; $total'.$suffix.'>0 && $start'.$suffix.'<=$total'.$suffix.' ; '.$attr['item'].' += '.$attr['step'].',$start'.$suffix.' += 1){?>';
				}
                case 'widget:':
                {
                    $attr = $this->getAttrs($matches[4]);
                    $className = isset($attr['name'])?$attr['name']:null;
                    $method = isset($attr['method'])?$attr['method']:'init';
                    $args = isset($attr['args'])?$attr['args']:null;
					$attr['cache'] = isset($attr['cache'])?"true":"false";
					//$cacheTime = isset($attr['cachetime'])?intval($attr['cachetime']):30;

                    $old_char=array(' ne ',' eq ',' lt ',' gt ',' le ',' ge ');
					$new_char=array(' != ',' = ',' < ',' > ',' <= ',' >= ');
					$tem = "<div id='widget_$className'><?php \$widget = Widget::createWidget('$className');";
					foreach($attr as $k => $v)
					{
						if($k != 'name'){
							$v = str_replace($old_char,$new_char,$v);
							if(substr($v, 0,1)=='$')$tem .= '$widget->'.$k.' = '.$v.';';
							else $tem .= '$widget->'.$k.' = "'.$v.'";';
						}
					}
                    $tem .= "\$widget->run();?></div>";
                    return $tem;
                }
				case 'query:':
				{
					$endchart=substr(trim($matches[4]),-1);
					$attrs = $this->getAttrs(rtrim($matches[4],'/'));
                    if(!isset($attrs['id'])) $id = '$query';
                    else $id = $attrs['id'];
                    if(!isset($attrs['items'])) $items = '$items';
                    else $items = $attrs['items'];
					$tem = $id.' = new Query("'.$attrs['name'].'");';
					//实现属性中符号表达式的问题
					$old_char=array(' ne ',' eq ',' lt ',' gt ',' le ',' ge ');
					$new_char=array(' != ',' = ',' < ',' > ',' <= ',' >= ');
					foreach($attrs as $k => $v)
					{
						if($k != 'name' && $k != 'id' && $k != 'items') $tem .= $id.'->'.$k.' = "'.str_replace($old_char,$new_char,$v).'";';
					}
					$tem .= $items.' = '.$id.'->find();';
					if(!isset($attrs['key'])) $attrs['key'] = '$key';
					else $attrs['key'] = $attrs['key'];
					if(!isset($attrs['item'])) $attrs['item'] = '$item';
					else $attrs['item'] = $attrs['item'];
					if($endchart=='/') return '<?php '.$tem.'?>';
					else return '<?php '.$attrs['item'].'=null; '.$tem.' foreach('.$items.' as '.$attrs['key'].' => '.$attrs['item'].'){?>';
				}
				case 'token:':
				{
					$attr = $this->getAttrs(rtrim($matches[4],'/'));
					if(isset($attr['key']) && is_string($attr['key'])) $key = $attr['key'];
					else $key = '';
					return "<input type='hidden' name='tiny_token_".$key."' value='<?php echo Tiny::app()->getToken(\"".$key."\");?>'/>";
				}
				case 'debug:':
				{
					$matches[4] = rtrim($matches[4],';/');
					if($matches[4]!='')
						return '<pre>'.$matches[4].' = <?php var_dump('.$matches[4].');?></pre>';
					else
						return '<?php $debug = new Debug(); $out = get_defined_vars(); $debug->out($out); $debug->display();?>';
				}
				case 'code:': return '<?php '.$matches[4];
				case 'require:':
				case 'include:':
				{
					$fileName=trim($matches[4]);
					$viewfile = Tiny::app()->getViewPath().DIRECTORY_SEPARATOR.$this->viewPath.DIRECTORY_SEPARATOR.$fileName;
					$runfile= Tiny::app()->getRuntimePath().DIRECTORY_SEPARATOR.$this->viewPath.DIRECTORY_SEPARATOR.$fileName;
					if(!file_exists($runfile) || filemtime($runfile)<filemtime($viewfile))
					{
						$file = new File($runfile,'w+');
						$template = $file->getContents($viewfile);
						$t = new Tag();
						$tem = $t->resolve($template,dirname($viewfile));
						$file->write($tem);
					}
					return '<?php include("'.trim($matches[4]).'")?>';
				}
				default:
				{
					 return $matches[0];
				}
			}
		}
		else
		{
			if($matches[2] =='code') return '?>';
            else if($matches[2] !='widget') return '<?php }?>';
		}
	}
    /**
     * 分析标签属性
     *
     * @access public
     * @param mixed $str
     * @return array
     */
	public function getAttrs($str)
	{
		preg_match_all('/([a-zA-Z0-9_]+)\s*=([^=]+?)(?=(\S+\s*=)|$)/i', trim($str), $attrs);
		$attr = array();
		foreach($attrs[0] as $value)
		{
			$tem = explode('=',$value);
			$attr[trim($tem[0])] = trim($tem[1]);
		}
		return $attr;
	}
}
