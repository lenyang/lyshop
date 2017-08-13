<?php
/**
 * 文件uploadFile类
 *
 * @author Crazy、Ly
 * @class UploadFile
 */
class UploadFile extends File
{
    const SUCCESS = 1;
    const FAILSIZE = 2;
    const FAILTYPE = 3;
    private $types=',jpg,png,gif,jpeg,rar,zip,';
    private $size;
    private $uploadPath;
    private $filename;
    private $files=null;
    private $fileNameId = '';//唯一名字上传时
    private $info;
    private $nameType;
    /**
     * 构造初始化
     *
     * @access public
     * @param mixed $fieldName
     * @param string $uploadPath
     * @param string $size
     * @param string $types
     * @param string $nameType
     * @param string $nameId
     */
    public function __construct($fieldName, $uploadPath="", $size='500k', $types='', $nameType='date',$nameId='')
    {
        if(isset($_FILES[$fieldName]))
        {
            $this->files = $_FILES[$fieldName];
            if($uploadPath=='')$this->uploadPath = Tiny::getPath('uploads');
            else $this->uploadPath = $uploadPath;
            $endchar=strtolower(substr($size,-1));
            if($endchar=='k') $this->size = substr($size,0,-1) << 10;
            else if($endchar=='m') $this->size = substr($size,0,-1) << 20;
            else $this->size = intval($size);
            if($types!='')$this->types=",$types,";
            $this->nameType = $nameType;
            $this->fileNameId = $nameId;
        }
    }
    /**
     * 保存
     *
     * @access public
     * @return mixed
     */
    public function save()
    {
        if(!is_null($this->files))
        {
            if(is_array($this->files['name']))
            {
                $num = count($this->files['name']);
                for($i=0;$i<$num;$i++)
                {
                    if($this->checkSize($this->files['size'][$i]) && $this->checkType($this->files['name'][$i]))
                    {
                        $fileName = md5_file($this->files['tmp_name'][$i]).$this->files['name'][$i];
                        $realpath=$this->getRealPath($fileName);
                        if(!file_exists(dirname($realpath)))$this->mkdir($this->getUploadPath().dirname($realpath));
                        move_uploaded_file($this->files['tmp_name'][$i],$this->getUploadPath().$realpath);
                        $this->info[]=array('name'=>$this->files['name'][$i],'path'=>$realpath,'size'=>$this->files['size'][$i],'type'=>$this->files['type'][$i],'status'=>self::SUCCESS,'msg'=>'上传成功');
                    }
                    else if(!$this->checkSize($this->files['size'][$i]))
                    {
                        $this->info[]=array('name'=>$this->files['name'][$i],'path'=>'','size'=>$this->files['size'][$i],'type'=>$this->files['type'][$i],'status'=>self::FAILSIZE,'msg'=>'超出了文件规定的大小');
                    }
                    else if(!$this->checkType($this->files['name'][$i]))
                    {
                        $this->info[]=array('name'=>$this->files['name'][$i],'path'=>'','size'=>$this->files['size'][$i],'type'=>$this->files['type'][$i],'status'=>self::FAILTYPE,'msg'=>'文件上传的类型不符合');
                    }
                }
            }
            else if(is_string($this->files['name']))
            {
                if($this->checkSize($this->files['size']) && $this->checkType($this->files['name']))
                {
                    $fileName = md5_file($this->files['tmp_name']).$this->files['name'];
                    $realpath = $this->getRealPath($fileName);
                    if(!file_exists(dirname($realpath)))$this->mkdir($this->getUploadPath().dirname($realpath));
                    $this->info[]=array('name'=>$this->files['name'],'path'=>$realpath,'size'=>$this->files['size'],'type'=>$this->files['type'],'status'=>self::SUCCESS,'msg'=>'上传成功');
                    move_uploaded_file($this->files['tmp_name'],$this->getUploadPath().$realpath);
                }
                else if(!$this->checkSize($this->files['size']))
                {
                    $this->info[]=array('name'=>$this->files['name'],'path'=>'','size'=>$this->files['size'],'type'=>$this->files['type'],'status'=>self::FAILSIZE,'msg'=>'超出了文件规定的大小');
                }
                else if(!$this->checkType($this->files['name']))
                {
                    $this->info[]=array('name'=>$this->files['name'],'path'=>'','size'=>$this->files['size'],'type'=>$this->files['type'],'status'=>self::FAILTYPE,'msg'=>'文件上传的类型不符合');
                }
            }
        }
    }
    /**
     * 设置保存目录
     *
     * @access public
     * @param mixed $uploadPath
     * @return mixed
     */
    public function setUploadPath($uploadPath)
    {
        $this->uploadPath=$uploadPath;
    }
    /**
     * 得到上传目录
     *
     * @access public
     * @return mixed
     */
    public function getUploadPath()
    {
        return $this->uploadPath;
    }
    /**
     * 设置允许的大小
     *
     * @access public
     * @param mixed $size
     * @return mixed
     */
    public function setSize($size)
    {
        $this->size=$size;
    }
    /**
     * 取得大小
     *
     * @access public
     * @return mixed
     */
    public function getSize()
    {
        $this->size;
    }
    /**
     * 设置类型
     *
     * @access public
     * @param mixed $types
     * @return mixed
     */
    public function setType($types)
    {
        $this->types=$types;
    }
    /**
     * 得到类型
     *
     * @access public
     * @return mixed
     */
    public function getType()
    {
        return $this->types;
    }
    /**
     * 取得上传后的返回信息
     *
     * @access public
     * @return mixed
     */
    public function getInfo()
    {
        return $this->info;
    }
    /**
     * 检测大小
     *
     * @access public
     * @param mixed $size
     * @return mixed
     */
    public function checkSize($size)
    {
        return ($size<=$this->size && $size>0);
    }
    /**
     * 检测类型
     *
     * @access public
     * @param mixed $name
     * @return mixed
     */
    public function checkType($name)
    {
        $fileName_array = explode(".",strtolower($name));
        return (strpos($this->types,end($fileName_array)));
    }
    /**
     * 取得文件
     *
     * @access public
     * @return mixed
     */
    public function getFiles()
    {
        return $this->files;
    }
    /**
     * 得到文件有真实路径
     *
     * @access private
     * @param mixed $name
     * @return mixed
     */
    private function getRealPath($name)
    {
        $fileName_array = explode(".",strtolower($name));
        $ext=end($fileName_array);
        if($this->nameType == 'date')
        {
            $date = new Date();
            return $date->format('Y/m/d/').Crypt::md5($name).'.'.$ext;
        }
        else if($this->nameType == 'hash')
        {
            if($this->fileNameId!='')$num=crc32($this->fileNameId);
            else $num=crc32($name.time());
            $num = sprintf('%u',$num);
            $index=($num%1024)."/".(($num>>=10)%1024)."/".($num>>=10)."/".Crypt::md5($this->fileNameId).'.'.$ext;
            return $index;
        }
        else
        {
            $date = new Date();
            return $date->format('Y/m/d/').$name;
        }
    }
}
