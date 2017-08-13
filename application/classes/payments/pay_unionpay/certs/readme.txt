<商户私钥证书> 和 <银联公钥验签证书> 要以下列重命名的方式放到当前目录下

//签名证书路径 （联系运营获取两码，在CFCA网站 <cs.cfca.com.cn> 下载后配置，自行设置证书密码并配置）
商户私钥证书 : acp_prod_sign.pfx

//银联官网下载
银联公钥验签证书 : verify_sign_acp.cer

说明：
1, 根据商户代码 和 签名证书密码到 cs.cfca.com.cn 去下载 <商户私钥证书> 重命名为：acp_prod_sign.pfx;
2, 在用 acp_prod_sign.pfx 到银联的官网去下载 <银联公钥验签证书>  重命名为：acp_prod_verify_sign.cer
3，把证书放到 ./certs下即可。
