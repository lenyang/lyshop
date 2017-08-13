<?php
/**
 * 下载类
 * 
 * @author Crazy、Ly
 * @class Download
 */
class Download{
    /**
     * 压缩方法
     * 
     * @access public
     * @param mixed $files
     * @param mixed $zipfile
     * @return mixed
     */
	public function zip($files,$zipfile){
		if(class_exists('ZipArchive'))
		{
			$zip = new ZipArchive();
			$zip->open($zipfile,ZIPARCHIVE::CREATE);
			foreach($files as $file)
			{
				$zip->addFile($file,basename($file));
			}
			$zip->close();
			return true;
		}
		else
		{
			return false;
		}
	}
    /**
     * 下载
     * 
     * @access public
     * @return mixed
     */
	public function down(){
		
	}
}