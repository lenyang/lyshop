<?php
class UnionPayServices
{
	// 签名证书路径
	const SDK_SIGN_CERT_PATH = 'certs/acp_prod_sign.pfx';
	// 签名证书密码
	static $SDK_SIGN_CERT_PWD = '000000';
	// 密码加密证书（这条一般用不到的请随便配）
	const SDK_ENCRYPT_CERT_PATH = 'certs/acp_prod_verify_sign.cer';
	// 验签证书路径（请配到文件夹，不要配到具体文件）
	const SDK_VERIFY_CERT_DIR = 'certs/';

	static function setCertPwd($cret_pwd)
	{
		self::$SDK_SIGN_CERT_PWD = $cret_pwd;
	}
	/**
	 * 签名
	 * @param req 请求要素
	 * @param resp 应答要素
	 * @return 是否成功
	 */
	static function sign(&$params)
	{
		$cert_path = self::SDK_SIGN_CERT_PATH;
		$cert_pwd = self::$SDK_SIGN_CERT_PWD;
		$params ['certId'] = self::getSignCertId ($cert_path, $cert_pwd); //证书ID
		self::_sign($params, $cert_path, $cert_pwd);
	}

	static function validate($params)
	{
		return self::verify($params);
	}

	/**
	 * 后台交易 HttpClient通信
	 *
	 * @param unknown_type $params
	 * @param unknown_type $url
	 * @return mixed
	 */
	static function post($params, $url)
	{

		$opts = self::createLinkString ( $params, false, true );
		$ch = curl_init ();
		curl_setopt ( $ch, CURLOPT_URL, $url );
		curl_setopt ( $ch, CURLOPT_POST, 1 );
		curl_setopt ( $ch, CURLOPT_SSL_VERIFYPEER, false ); // 不验证证书
		curl_setopt ( $ch, CURLOPT_SSL_VERIFYHOST, false ); // 不验证HOST
		curl_setopt ( $ch, CURLOPT_SSLVERSION, 1 );
		curl_setopt ( $ch, CURLOPT_HTTPHEADER, array (
			'Content-type:application/x-www-form-urlencoded;charset=UTF-8'
			) );
		curl_setopt ( $ch, CURLOPT_POSTFIELDS, $opts );
		curl_setopt ( $ch, CURLOPT_RETURNTRANSFER, true );
		$html = curl_exec ( $ch );

		if(curl_errno($ch)){
			$errmsg = curl_error($ch);
			curl_close ( $ch );
			return null;
		}
		if( curl_getinfo($ch, CURLINFO_HTTP_CODE) != "200"){
			$errmsg = "http状态=" . curl_getinfo($ch, CURLINFO_HTTP_CODE);
			curl_close ( $ch );
			return null;
		}
		curl_close ( $ch );
		$result_arr = self::convertStringToArray ( $html );
		return $result_arr;
	}

	/**
	 * 后台交易 HttpClient通信
	 *
	 * @param unknown_type $params
	 * @param unknown_type $url
	 * @return mixed
	 */
	static function get($params, $url)
	{

		$opts = self::createLinkString ( $params, false, true );
		$ch = curl_init ();
		curl_setopt ( $ch, CURLOPT_URL, $url );
		curl_setopt ( $ch, CURLOPT_SSL_VERIFYPEER, false ); // 不验证证书
		curl_setopt ( $ch, CURLOPT_SSL_VERIFYHOST, false ); // 不验证HOST
		curl_setopt ( $ch, CURLOPT_SSLVERSION, 1 );
		curl_setopt ( $ch, CURLOPT_HTTPHEADER, array (
			'Content-type:application/x-www-form-urlencoded;charset=UTF-8'
			) );
		curl_setopt ( $ch, CURLOPT_POSTFIELDS, $opts );
		curl_setopt ( $ch, CURLOPT_RETURNTRANSFER, true );
		$html = curl_exec ( $ch );
		if(curl_errno($ch)){
			$errmsg = curl_error($ch);
			curl_close ( $ch );
			return null;
		}
		if( curl_getinfo($ch, CURLINFO_HTTP_CODE) != "200"){
			curl_close ( $ch );
			return null;
		}
		curl_close ( $ch );
		return $html;
	}

	static function createAutoFormHtml($params, $reqUrl)
	{
		$encodeType = isset ( $params ['encoding'] ) ? $params ['encoding'] : 'UTF-8';
		$html ='';
		//<<<eot
		// <html>
		// <head>
		// 	<meta http-equiv="Content-Type" content="text/html; charset={$encodeType}" />
		// </head>
		// <body onload="javascript:document.pay_form.submit();">
		// 	<form id="pay_form" name="pay_form" action="{$reqUrl}" method="post">

		// 		eot;
		// 		foreach ( $params as $key => $value ) {
		// 			$html .= "    <input type=\"hidden\" name=\"{$key}\" id=\"{$key}\" value=\"{$value}\" />\n";
		// 		}
		// 		$html .= <<<eot
		// 		<!-- <input type="submit" type="hidden">-->
		// 	</form>
		// </body>
		// </html>
		// eot;
		return $html;
	}



	static function getCustomerInfo($customerInfo)
	{
		if($customerInfo == null || count($customerInfo) == 0 ){
			return "";
		}
		return base64_encode ( "{" . self::createLinkString ( $customerInfo, false, false ) . "}" );
	}

	/**
	 * map转换string，按新规范加密
	 *
	 * @param
	 *        	$customerInfo
	 */
	static function getCustomerInfoWithEncrypt($customerInfo)
	{
		if($customerInfo == null || count($customerInfo) == 0 ){
			return "";
		}
		$encryptedInfo = array();
		foreach ( $customerInfo as $key => $value ) {
			if ($key == 'phoneNo' || $key == 'cvn2' || $key == 'expired' ) {
				$encryptedInfo [$key] = $customerInfo [$key];
				unset ( $customerInfo [$key] );
			}
		}
		if( count ($encryptedInfo) > 0 ){
			$encryptedInfo = self::createLinkString ( $encryptedInfo, false, false );
			$encryptedInfo = self::encryptData ( $encryptedInfo, self::SDK_ENCRYPT_CERT_PATH );
			$customerInfo ['encryptedInfo'] = $encryptedInfo;
		}
		return base64_encode ( "{" . self::createLinkString ( $customerInfo, false, false ) . "}" );
	}


	/**
	 * 解析customerInfo。
	 * 为方便处理，encryptedInfo下面的信息也均转换为customerInfo子域一样方式处理，
	 * @param unknown $customerInfostr
	 * @return array形式ParseCustomerInfo
	 */
	static function parseCustomerInfo($customerInfostr) {
		$customerInfostr = base64_decode($customerInfostr);
		$customerInfostr = substr($customerInfostr, 1, strlen($customerInfostr) - 2);
		$customerInfo = self::parseQString($customerInfostr);
		if(array_key_exists("encryptedInfo", $customerInfo)) {
			$encryptedInfoStr = $customerInfo["encryptedInfo"];
			unset ( $customerInfo ["encryptedInfo"] );
			$encryptedInfoStr = self::decryptData($encryptedInfoStr);
			$encryptedInfo = self::parseQString($encryptedInfoStr);
			foreach ($encryptedInfo as $key => $value){
				$customerInfo[$key] = $value;
			}
		}
		return $customerInfo;
	}


	static function getEncryptCertId() {
		return self::getCertIdByCerPath ( self::SDK_ENCRYPT_CERT_PATH );
	}

	/**
	 * 加密数据
	 * @param string $data数据
	 * @param string $cert_path 证书配置路径
	 * @return unknown
	 */
	static function encryptData($data, $cert_path=self::SDK_ENCRYPT_CERT_PATH)
	{
		$public_key = self::getPublicKey ( $cert_path );
		openssl_public_encrypt ( $data, $crypted, $public_key );
		return base64_encode ( $crypted );
	}

	/**
	 * 解密数据
	 * @param string $data数据
	 * @param string $cert_path 证书配置路径
	 * @return unknown
	 */
	static function decryptData($data, $cert_path=self::SDK_SIGN_CERT_PATH)
	{
		$data = base64_decode ( $data );
		$private_key = self::getPrivateKey ( $cert_path );
		openssl_private_decrypt ( $data, $crypted, $private_key );
		return $crypted;
	}


	/**
	 * 处理报文中的文件
	 *
	 * @param unknown_type $params
	 */
	static function deCodeFileContent($params)
	{
		if (isset ( $params ['fileContent'] )) {
			$fileContent = $params ['fileContent'];

			if (empty ( $fileContent )) {
				return false;
			} else {
			// 文件内容 解压缩
				$content = gzuncompress ( base64_decode ( $fileContent ) );
				$root = SDK_FILE_DOWN_PATH;
				$filePath = null;
				if (empty ( $params ['fileName'] )) {
					$filePath = $root . $params ['merId'] . '_' . $params ['batchNo'] . '_' . $params ['txnTime'] . '.txt';
				} else {
					$filePath = $root . $params ['fileName'];
				}
				$handle = fopen ( $filePath, "w+" );
				if (! is_writable ( $filePath )) {
					return false;
				} else {
					file_put_contents ( $filePath, $content );
				}
				fclose ( $handle );
			}
			return true;
		} else {
			return false;
		}
	}


	static function enCodeFileContent($path)
	{

		$file_content_base64 = '';
		if(!file_exists($path)){
			echo '文件没找到';
			return false;
		}

		$file_content = file_get_contents ( $path );
		//UTF8 去掉文本中的 bom头
		$BOM = chr(239).chr(187).chr(191);
		$file_content = str_replace($BOM,'',$file_content);
		$file_content_deflate = gzcompress ( $file_content );
		$file_content_base64 = base64_encode ( $file_content_deflate );
		return $file_content_base64;
	}


	/**
	 * ========== Start common =======
	 */
	static function parseQString($str, $needUrlDecode=false)
	{
		$result = array();
		$len = strlen($str);
		$temp = "";
		$curChar = "";
		$key = "";
		$isKey = true;
		$isOpen = false;
		$openName = "\0";

		for($i=0; $i<$len; $i++){
			$curChar = $str[$i];
			if($isOpen){
				if( $curChar == $openName){
					$isOpen = false;
				}
				$temp = $temp . $curChar;
			} elseif ($curChar == "{"){
				$isOpen = true;
				$openName = "}";
				$temp = $temp . $curChar;
			} elseif ($curChar == "["){
				$isOpen = true;
				$openName = "]";
				$temp = $temp . $curChar;
			} elseif ($isKey && $curChar == "="){
				$key = $temp;
				$temp = "";
				$isKey = false;
			} elseif ( $curChar == "&" && !$isOpen){
				self::putKeyValueToDictionary($temp, $isKey, $key, $result, $needUrlDecode);
				$temp = "";
				$isKey = true;
			} else {
				$temp = $temp . $curChar;
			}
		}
		self::putKeyValueToDictionary($temp, $isKey, $key, $result, $needUrlDecode);
		return $result;
	}


	static function putKeyValueToDictionary($temp, $isKey, $key, &$result, $needUrlDecode)
	{
		if ($isKey) {
			$key = $temp;
			if (strlen ( $key ) == 0) {
				return false;
			}
			$result [$key] = "";
		} else {
			if (strlen ( $key ) == 0) {
				return false;
			}
			if ($needUrlDecode)
				$result [$key] = urldecode ( $temp );
			else
				$result [$key] = $temp;
		}
	}

	/**
	 * 字符串转换为 数组
	 *
	 * @param unknown_type $str
	 * @return multitype:unknown
	 */
	static function convertStringToArray($str)
	{
		return self::parseQString($str);
	}

	/**
	 * 压缩文件 对应java deflate
	 *
	 * @param unknown_type $params
	 */
	static function deflate_file(&$params)
	{
		foreach ( $_FILES as $file ) {
			if (file_exists ( $file ['tmp_name'] )) {
				$params ['fileName'] = $file ['name'];

				$file_content = file_get_contents ( $file ['tmp_name'] );
				$file_content_deflate = gzcompress ( $file_content );

				$params ['fileContent'] = base64_encode ( $file_content_deflate );
			}
		}
	}


	/**
	 * 讲数组转换为string
	 *
	 * @param $para 数组
	 * @param $sort 是否需要排序
	 * @param $encode 是否需要URL编码
	 * @return string
	 */
	static function createLinkString($para, $sort, $encode)
	{
		if($para == NULL || !is_array($para)){
			return "";
		}

		$linkString = "";
		if ($sort) {
			$para = self::argSort ( $para );
		}
		while ( list ( $key, $value ) = each ( $para ) ) {
			if ($encode) {
				$value = urlencode ( $value );
			}
			$linkString .= $key . "=" . $value . "&";
		}
		// 去掉最后一个&字符
		$linkString = substr ( $linkString, 0, count ( $linkString ) - 2 );
		return $linkString;
	}

	/**
	 * 对数组排序
	 * @param $para 排序前的数组
	 * return 排序后的数组
	 */
	static function argSort($para)
	{
		ksort ( $para );
		reset ( $para );
		return $para;
	}

	/**
	 * ==================== secureUtil ============
	 */
	static function _sign(&$params, $cert_path, $cert_pwd)
	{
		if(isset($params['signature'])){
			unset($params['signature']);
		}
		// 转换成key=val&串
		$params_str = self::createLinkString ( $params, true, false );
		$params_sha1x16 = sha1 ( $params_str, FALSE );
		$private_key = self::getPrivateKey ( $cert_path, $cert_pwd );
		// 签名
		$sign_falg = openssl_sign ( $params_sha1x16, $signature, $private_key, OPENSSL_ALGO_SHA1 );
		if ($sign_falg) {
			$signature_base64 = base64_encode ( $signature );
			$params ['signature'] = $signature_base64;
		}
	}

	/**
	 * 验签
	 *
	 * @param String $params_str
	 * @param String $signature_str
	 */
	static function verify($params) {
		// 公钥
		$public_key = self::getPulbicKeyByCertId ( $params ['certId'] );
		// 签名串
		$signature_str = $params ['signature'];
		unset ( $params ['signature'] );
		$params_str = self::createLinkString ( $params, true, false );
		$signature = base64_decode ( $signature_str );
		$params_sha1x16 = sha1 ( $params_str, FALSE );
		$isSuccess = openssl_verify ( $params_sha1x16, $signature,$public_key, OPENSSL_ALGO_SHA1 );
		return $isSuccess;
	}

	/**
	 * 根据证书ID 加载 证书
	 *
	 * @param unknown_type $certId
	 * @return string NULL
	 */
	static function getPulbicKeyByCertId($certId) {
		// 证书目录
		$cert_dir = self::SDK_VERIFY_CERT_DIR;
		$handle = opendir ( dirname(__FILE__)."/".$cert_dir );
		if ($handle) {
			while ( $file = readdir ( $handle ) ) {
				clearstatcache ();
				$filePath = $cert_dir . '/' . $file;
				if (is_file ( dirname(__FILE__)."/".$filePath )) {
					if (pathinfo ( $file, PATHINFO_EXTENSION ) == 'cer') {
						if (self::getCertIdByCerPath ( $filePath ) == $certId) {
							closedir ( $handle );
							return self::getPublicKey ( $filePath );
						}
					}
				}
			}
		}
		closedir ( $handle );
		return null;
	}

	/**
	 * 取证书ID(.pfx)
	 *
	 * @return unknown
	 */
	static function getSignCertId($cert_path, $cert_pwd) {
		$pkcs12certdata = file_get_contents ( dirname(__FILE__).'/'. $cert_path );
		openssl_pkcs12_read ( $pkcs12certdata, $certs, $cert_pwd );
		$x509data = $certs ['cert'];
		openssl_x509_read ( $x509data );
		$certdata = openssl_x509_parse ( $x509data );
		$cert_id = $certdata ['serialNumber'];
		return $cert_id;
	}

	/**
	 * 取证书ID(.cer)
	 *
	 * @param unknown_type $cert_path
	 */
	static function getCertIdByCerPath($cert_path) {
		$x509data = file_get_contents (dirname(__FILE__).'/'.$cert_path );
		openssl_x509_read ( $x509data );
		$certdata = openssl_x509_parse ( $x509data );
		$cert_id = $certdata ['serialNumber'];
		return $cert_id;
	}

	/**
	 * 取证书公钥 -验签
	 *
	 * @return string
	 */
	static function getPublicKey($cert_path)
	{
		return file_get_contents ( dirname(__FILE__).'/'.$cert_path );
	}
	/**
	 * 返回(签名)证书私钥 -
	 *
	 * @return unknown
	 */
	static function getPrivateKey($cert_path=self::SDK_SIGN_CERT_PATH)
	{
		$cert_pwd=self::$SDK_SIGN_CERT_PWD;
		$pkcs12 = file_get_contents ( dirname(__FILE__).'/'.$cert_path );
		openssl_pkcs12_read ( $pkcs12, $certs, $cert_pwd );
		return $certs ['pkey'];
	}

	/**
	 * Author: gu_yongkang
	 * data: 20110510
	 * 密码转PIN
	 * Enter description here ...
	 * @param $spin
	 */
	static function  Pin2PinBlock( &$sPin )
	{
		$iTemp = 1;
		$sPinLen = strlen($sPin);
		$sBuf = array();
		$sBuf[0]=intval($sPinLen, 10);
		if($sPinLen % 2 ==0){
			for ($i=0; $i<$sPinLen;){
				$tBuf = substr($sPin, $i, 2);
				$sBuf[$iTemp] = intval($tBuf, 16);
				unset($tBuf);
				if ($i == ($sPinLen - 2)){
					if ($iTemp < 7){
						$t = 0;
						for ($t=($iTemp+1); $t<8; $t++){
							$sBuf[$t] = 0xff;
						}
					}
				}
				$iTemp++;
				$i = $i + 2;
			}
		}else{
			for ($i=0; $i<$sPinLen;){
				if ($i ==($sPinLen-1)){
					$mBuf = substr($sPin, $i, 1) . "f";
					$sBuf[$iTemp] = intval($mBuf, 16);
					unset($mBuf);
					if (($iTemp)<7){
						$t = 0;
						for ($t=($iTemp+1); $t<8; $t++){
							$sBuf[$t] = 0xff;
						}
					}
				}else{
					$tBuf = substr($sPin, $i, 2);
					$sBuf[$iTemp] = intval($tBuf, 16);
					unset($tBuf);
				}
				$iTemp++;
				$i = $i + 2;
			}
		}
		return $sBuf;
	}

	/**
	 * Author: gu_yongkang
	 * data: 20110510
	 * Enter description here ...
	 * @param $sPan
	 */
	static function FormatPan(&$sPan)
	{
		$iPanLen = strlen($sPan);
		$iTemp = $iPanLen - 13;
		$sBuf = array();
		$sBuf[0] = 0x00;
		$sBuf[1] = 0x00;
		for ($i=2; $i<8; $i++){
			$tBuf = substr($sPan, $iTemp, 2);
			$sBuf[$i] = intval($tBuf, 16);
			$iTemp = $iTemp + 2;
		}
		return $sBuf;
	}
	/**
	 * [Pin2PinBlockWithCardNO description]
	 * @param [type] $sPin    [description]
	 * @param [type] $sCardNO [description]
	 */
	static function Pin2PinBlockWithCardNO(&$sPin, &$sCardNO)
	{
		$sPinBuf = self::Pin2PinBlock($sPin);
		$iCardLen = strlen($sCardNO);
		if ($iCardLen <= 10){
			return (1);
		} elseif ($iCardLen==11){
			$sCardNO = "00" . $sCardNO;
		} elseif ($iCardLen==12){
			$sCardNO = "0" . $sCardNO;
		}
		$sPanBuf = self::FormatPan($sCardNO);
		$sBuf = array();

		for ($i=0; $i<8; $i++){
			$sBuf[$i] = vsprintf("%c", ($sPinBuf[$i] ^ $sPanBuf[$i]));
		}
		unset($sPinBuf);
		unset($sPanBuf);
		$sOutput = implode("", $sBuf);	//数组转换为字符串
		return $sOutput;
	}

}

