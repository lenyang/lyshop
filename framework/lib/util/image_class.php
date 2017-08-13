<?php
/**
 * 图像处理类
 * 
 * @author Crazy、Ly
 * @class Image
 */
class Image
{
	//存放图片的位置
	private $thumbPath;
	//是否以裁剪方式来生成缩略图
	public $cut = true;
	//缩略图的扩展名
	public $suffix = '_thumb';
	public $waterImage = null;
	public $alpha = 50;

	public $waterText;
	public $fontColor='#000000';
	public $fontSize=18;
	public $fontFile;
	/**
	 * @brief 构造方法
	 * @param string $path
	 */
	public function __construct($path='')
	{
		$this->thumbPath = $path;
		$this->fontFile = dirname(__file__).DIRECTORY_SEPARATOR.'font.ttf';
	}
	/**
	 * @brief 生成缩略图
	 * @param mixed $filename 文件名
	 * @param int $width 要生成缩略图的宽度
	 * @param int $height 要生成缩略图的高度
	 * @param int $quality 生成缩略图的质量
	 * @return String 生成
	 */
	public function thumb($filename, $width=100, $height=100, $quality=95)
	{
		if(preg_match('@http://@i',$filename)) return $filename;
		list ($imgWidth, $imgHeight, $type) = getImageSize($filename);
		$ratioX = $imgWidth / $width;
		$ratioY = $imgHeight / $height;
		if(func_num_args()!=2)
		{
			if($imgWidth > $width)
			{
				if ($ratioX <= $ratioY)
				{
					$dst_h = $height;
					$dst_w = ceil($imgWidth / $ratioY);
				} else
				{
					$dst_w = $width;
					$dst_h = ceil($imgHeight / $ratioX);
				}
			}
			else
			{
				$dst_w = $imgWidth;
				$dst_h = $imgHeight;
			}
		}
		else
		{
			if($imgWidth > $width)
			{
				$dst_w = $width;
				$dst_h = ceil($imgHeight / $ratioX);
			}
			else
			{
				$dst_w = $imgWidth;
				$dst_h = $imgHeight;
			}
		}
		$im = $this->createImage($type,$filename);
		
		if($this->cut)
		{
			//居中定位并复制
			$dst_pos = array ('d_x' => 0, 'd_y' => 0);
			($dst_w == $width) ? ( $dst_pos['d_y'] = (($height - $dst_h) / 2) ) : ($dst_pos['d_x'] = (($width - $dst_w) / 2));
			$imBox = imageCreateTrueColor($width, $height);
			$padColor = imagecolorallocate($imBox,255,255,255);
        	imagefilledrectangle($imBox,0,0,$width,$height,$padColor);
			imagecopyresampled($imBox, $im, $dst_pos['d_x'], $dst_pos['d_y'], 0, 0 ,$dst_w, $dst_h, $imgWidth, $imgHeight);
		}
		else
		{
			//等比缩放
			$imBox = imageCreateTrueColor($width, $height);
			$padColor = imagecolorallocate($imBox,255,255,255);
        	imagefilledrectangle($imBox,0,0,$width,$height,$padColor);
			imagecopyresampled($imBox, $im, 0, 0, 0, 0, $dst_w, $dst_h, $imgWidth, $imgHeight);
		}

		$ext = strtolower(strrchr($filename,'.'));
		$end = intval('-'.strlen($ext));
		
		if($this->suffix == 'w_h') $thumb = '__'.$width.'_'.$height;
		else if($this->suffix == 'f_w_h') $thumb = '__'.$width.'_'.$height;
		else if($this->suffix == 'f_w_h.jpg')$thumb = '__'.$width.'_'.$height;
		else if($this->suffix == '') $thumb = '';
		else $thumb = $this->suffix;
		
		if($this->suffix == 'f_w_h') $tofile = $this->thumbPath.$filename.$thumb.$ext;
		else if($this->suffix == 'f_w_h.jpg') $tofile = $this->thumbPath.$filename.$thumb.'.jpg';
		else $tofile = $this->thumbPath.substr($filename,0,$end).$thumb.$ext;

		switch($type)
		{
			case 1: imagegif($imBox,$tofile,$quality);break;
			case 2: imagejpeg($imBox,$tofile,$quality);break;
			case 3: {$quality = $quality>9?9:$quality; imagepng($imBox,$tofile,$quality);break;}
			default:
			{
				imagejpeg($imBox,$tofile,$quality);
			}
		}
		imagedestroy($imBox);
		imagedestroy($im);
		return $tofile;
	}
    /**
     * 图片剪切
     * 
     * @access public
     * @param mixed $dst_image
     * @param mixed $src_image
     * @param mixed $src_x
     * @param mixed $src_y
     * @param mixed $src_w
     * @param mixed $src_h
     * @param int $dst_w
     * @param int $dst_h
     * @param int $quality
     * @return mixed
     */
	public function cut($dst_image,$src_image,$src_x, $src_y, $src_w, $src_h, $dst_w=100,$dst_h=100,$quality=90)
	{
		list ($imgWidth, $imgHeight, $type) = getImageSize($src_image);
		$img_r = $this->createImage($type,$src_image);
		$dst_r = ImageCreateTrueColor( $dst_w, $dst_h);
		imagecopyresampled($dst_r,$img_r,0,0,$src_x,$src_y,$dst_w,$dst_h, $src_w, $src_h);
		switch($type)
		{
		case 1: imagegif($dst_r,$dst_image,$quality);break;
		case 2: imagejpeg($dst_r,$dst_image,$quality);break;
		case 3: {$quality = $quality>9?9:$quality; imagepng($dst_r,$dst_image,$quality);break;}
		default:
		{
			imagejpeg($dst_r,$dst_image,$quality);
		}
		}
		imagedestroy($dst_r);
		imagedestroy($img_r);
	}
    /**
     * 添加水印
     * 
     * @access public
     * @param mixed $sourcefile
     * @param int $position
     * @return mixed
     */
	public function waterMark($sourcefile,$position=0)
	{
		if($sourcefile!='' && file_exists($sourcefile))
		{
			list ($imgWidth, $imgHeight, $imgtype) = getImageSize($sourcefile);
			$sourceImage = $this->createImage($imgtype,$sourcefile);
		}
		else
		{
			return '图片文件不存在！';
		}
		$isWaterImage = false;
		if($this->waterImage!==null && file_exists($this->waterImage))
		{
			$isWaterImage = true;
			list ($waterWidth, $waterHeight, $watertype) = getImageSize($this->waterImage);
			$waterImage = $this->createImage($watertype,$this->waterImage);
		}
		//水印位置
		if($isWaterImage)
		{ //图片水印
			$w = $waterWidth;
			$h = $waterHeight;
		}
		else if(file_exists($this->fontFile))
		{  //文字水印
			$temp = imagettfbbox($this->fontSize,0,$this->fontFile,$this->waterText);//取得使用 TrueType 字体的文本的范围
			$w = $temp[2] - $temp[0];
			$h = $temp[1] - $temp[7];
			unset($temp);
			
		}
		else
		{
            if($this->fontSize>5 || $this->fontSize<1) $this->fontSize=5;
			$base = ceil($this->fontSize*2.54);//10+$this->fontSize<<2;
			$w = $base*strlen($this->waterText);
			$h = $base; //10+$this->fontSize<<1;
		}
		if( ($imgWidth<$w) || ($imgHeight<$h) )
		{
			$w = $imgWidth;
			$h = $imgHeight;
		}
		switch($position)
		{
		case 0://
			$posX = rand(0,($imgWidth - $w));
			$posY = rand(0,($imgHeight - $h));
			break;
		case 1://1为顶端居左
			$posX = 0;
			$posY = 0;
			break;
		case 2://2为顶端居中
			$posX = ($imgWidth - $w) / 2;
			$posY = 0;
			break;
		case 3://3为顶端居右
			$posX = $imgWidth - $w;
			$posY = 0;
			break;
		case 4://4为中部居左
			$posX = 0;
			$posY = ($imgHeight - $h) / 2;
			break;
		case 5://5为中部居中
			$posX = ($imgWidth - $w) / 2;
			$posY = ($imgHeight - $h) / 2;
			break;
		case 6://6为中部居右
			$posX = $imgWidth - $w;
			$posY = ($imgHeight - $h) / 2;
			break;
		case 7://7为底端居左
			$posX = 0;
			$posY = $imgHeight - $h;
			break;
		case 8://8为底端居中
			$posX = ($imgWidth - $w) / 2;
			$posY = $imgHeight - $h;
			break;
		case 9://9为底端居右
			$posX = $imgWidth - $w;
			$posY = $imgHeight - $h;
			break;
		default://随机
			$posX = rand(0,($imgWidth - $w));
			$posY = rand(0,($imgHeight - $h));
			break;
		}
		//设定图像的混色模式
		imagealphablending($sourceImage,true);

		if($isWaterImage)
		{ //图片水印
			imageCopyMerge($sourceImage, $waterImage,$posX,$posY,0,0,$waterWidth,$waterHeight,$this->alpha);
		}
		else
		{//文字水印
			if( !empty($this->fontColor) && (strlen($this->fontColor)==7) )
			{
				$R = hexdec(substr($this->fontColor,1,2));
				$G = hexdec(substr($this->fontColor,3,2));
				$B = hexdec(substr($this->fontColor,5));
			}
			else
			{
				$R = hexdec('00');
				$G = hexdec('00');
				$B = hexdec('00');
			}
			if(file_exists($this->fontFile))
			{
				imagettftext($sourceImage, $this->fontSize, 0, $posX, $h+$posY, imagecolorallocate($sourceImage, $R, $G, $B), $this->fontFile, $this->waterText);
			}
			else
			{
				imagestring ( $sourceImage, $this->fontSize, $posX, $posY-$h, $this->waterText, imagecolorallocate($sourceImage, $R, $G, $B));
			}
		}

		//生成水印后的图片
		//@unlink($sourcefile);
		switch($imgtype) {//取得背景图片的格式
		case 1:imagegif($sourceImage,$sourcefile);break;
		case 2:imagejpeg($sourceImage,$sourcefile);break;
		case 3:imagepng($sourceImage,$sourcefile);break;
		default:die($errorMsg);
		}

		//释放内存
		if(isset($waterImage))imagedestroy($waterImage);
		if(isset($sourceImage))imagedestroy($sourceImage);

	}
    /**
     * 生成图像
     * 
     * @access private
     * @param mixed $type 图片类型
     * @param mixed $filename 文件名
     * @return mixed
     */
	private function createImage($type,$filename)
	{
		//1 = GIF，2 = JPG，3 = PNG
		switch($type)
		{
		case 1: $im = imageCreateFromGif($filename);break;
		case 2: $im = imageCreateFromJpeg($filename);break;
		case 3: $im = imageCreateFromPng($filename);break;
		default:
		{
			$im = imageCreateFromJpeg($filename);break;
		}
		}
		return $im;
	}
	public function __destruct()
	{
		
	}
}

