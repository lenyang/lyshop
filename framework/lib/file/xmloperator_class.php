<?php
/**
 * XML操作类
 * 
 * @author Crazy、Ly
 * @class XMLOperator
 */
class XMLOperator
{
	private $dom;
	public function __construct($xmlfile="",$encoding="UTF-8")
	{
		$this->dom=new DOMDocument(); 
		$this->dom->encoding=$encoding;
		$this->preserveWhiteSpace=false;
		$this->dom->formatOutput=true;
		if(file_exists($xmlfile))$this->dom->load($xmlfile);
	}
    /**
     * 查询节点
     * 
     * @access public
     * @param mixed $query
     * @return mixed
     */
	public function query($query)
	{
		$xpath=new DOMXpath($this->dom);
		$element = $xpath->query($query);
		if($element->length>0)
		{
			return $element;
		}
		else
		{
			return false;
		}
	}
    /**
     * 添加节点
     * 
     * @access public
     * @param mixed $query
     * @param mixed $name
     * @param string $value
     * @param string $attrs
     * @return mixed
     */
	public function addNode($query,$name,$value="",$attrs="")
	{
		$target_node=$this->query($query);
		if(is_string($name))
		{
			if($target_node)
			{
				$node=$this->dom->createElement($name,$value);
				if($attrs!="")
				{
					$tems=explode(";",$attrs);
					if(count($tems)>0)
					{
						for($i=0;$i<count($tems);$i++)
						{
							$tem=explode("=",$tems[$i]);
							$node->setAttribute($tem[0],$tem[1]);
						}
					}
				}
				$target_node->item(0)->appendChild($node);
				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			$target_node->item(0)->appendChild($name);
		}
	}
    /**
     * 添加节点属性
     * 
     * @access public
     * @param mixed $query
     * @param mixed $name
     * @param mixed $value
     * @return mixed
     */
	public function addAttr($query,$name,$value)
	{
		$node=$this->query($query);
		if($node)
		{
			$node->item(0)->setAttribute($name,$value);
			return true;
		}
		else
		{
			return false;
		}
	}
    /**
     * 删除节点
     * 
     * @access global
     * @param mixed $query
     * @return mixed
     */
	function delNode($query)
	{
		$node=$this->query($query);
		if($node)
		{
			$node->item(0)->parentNode->removeChild($node->item(0));
			return false;
		}
		else
		{
			return false;
		}
	}
    /**
     * 删除属性
     * 
     * @access global
     * @param mixed $query
     * @param mixed $name
     * @return mixed
     */
	function delAttr($query,$name)
	{
		$node=$this->query($query);
		if($node)
		{
			$node->item(0)->removeAttribute($name);
			return true;
		}
		else
		{
			return false;
		}
	}
    /**
     * 修改属性
     * 
     * @access public
     * @param mixed $query
     * @param mixed $name
     * @param mixed $value
     * @return mixed
     */
	public function updAttr($query,$name,$value)
	{
		$node=$this->query($query);
		if($node)
		{
			$node->item(0)->setAttribute($name,$value);
			return true;
		}
		else
		{
			return false;
		}
	}
    /**
     * 修改节点
     * 
     * @access public
     * @param mixed $query
     * @param mixed $value
     * @return mixed
     */
	public function updNode($query,$value)
	{
		$node=$this->query($query);
		if($node)
		{
			$node->item(0)->nodeValue=$value;
			return true;
		}
		else
		{
			return false;
		}
	}
    /**
     * 保存文件
     * 
     * @access public
     * @param mixed $file
     * @return mixed
     */
	public function save($file)
	{
		$this->dom->save($file);
	}
    /**
     * 保存XML
     * 
     * @access public
     * @return mixed
     */
	public function  toXML()
	{
		return $this->dom->saveXML();
	}
}