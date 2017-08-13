/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50547
Source Host           : localhost:3306
Source Database       : lyshop

Target Server Type    : MYSQL
Target Server Version : 50547
File Encoding         : 65001

Date: 2017-05-20 17:22:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ly_ad`
-- ----------------------------
DROP TABLE IF EXISTS `ly_ad`;
CREATE TABLE `ly_ad` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `number` varchar(32) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `order` int(6) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `start_time` date DEFAULT NULL,
  `end_time` date DEFAULT NULL,
  `content` text,
  `description` varchar(255) DEFAULT NULL,
  `is_open` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_ad
-- ----------------------------
INSERT INTO `ly_ad` VALUES ('31', '首页Banner', '2', 'qgiowmka-us4k-p0up-vs3c-blkqmtb7', '', '0', '960', '448', '2014-02-26', '2022-02-28', 'a:2:{i:0;a:3:{s:4:\"path\";s:60:\"data/uploads/2017/05/17/25aa0a8ccdf624ad498dd77359500c7a.jpg\";s:3:\"url\";s:0:\"\";s:5:\"title\";s:0:\"\";}i:1;a:3:{s:4:\"path\";s:60:\"data/uploads/2017/05/17/9fd2a720440ec2286786d57172720454.jpg\";s:3:\"url\";s:0:\"\";s:5:\"title\";s:0:\"\";}}', '王', '1');

-- ----------------------------
-- Table structure for `ly_address`
-- ----------------------------
DROP TABLE IF EXISTS `ly_address`;
CREATE TABLE `ly_address` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `accept_name` varchar(20) NOT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `province` bigint(20) NOT NULL,
  `city` bigint(20) NOT NULL,
  `county` bigint(20) NOT NULL,
  `zip` varchar(6) DEFAULT NULL,
  `addr` varchar(250) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_address
-- ----------------------------
INSERT INTO `ly_address` VALUES ('1', '1', '晓飞 宁', '13589100333', '13589100475', '370000', '370100', '370102', '250000', '山东省ddddddd', '1');
INSERT INTO `ly_address` VALUES ('2', '2', '陆伟', '13100376164', '1382159712', '430000', '430900', '430902', '413002', '银城南路湖南城市学院', '1');
INSERT INTO `ly_address` VALUES ('3', '5', '陆伟', '13642779418', '13642779418', '430000', '430900', '430902', '413000', '湖南城市学院', '1');

-- ----------------------------
-- Table structure for `ly_agent`
-- ----------------------------
DROP TABLE IF EXISTS `ly_agent`;
CREATE TABLE `ly_agent` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `real_name` varchar(50) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `weixin` varchar(50) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `province` bigint(20) DEFAULT NULL,
  `city` bigint(20) DEFAULT NULL,
  `county` bigint(20) DEFAULT NULL,
  `addr` varchar(250) DEFAULT NULL,
  `parent` varchar(50) DEFAULT NULL,
  `level` varchar(50) DEFAULT NULL,
  `recom` varchar(50) DEFAULT '1',
  `point` int(11) DEFAULT '0',
  `status` tinyint(2) DEFAULT '0',
  `reg_time` datetime DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_agent
-- ----------------------------
INSERT INTO `ly_agent` VALUES ('1', '世界诱货', 'worlduhot', 'worlduhot', '6b4ad9487324fa8bdbc7a396b7034bd1', '430000', '430900', '430903', '湖南城市学院', '0', '1', '0', '100', '1', '2017-05-19 16:43:57', '2017-05-20 16:44:01');
INSERT INTO `ly_agent` VALUES ('2', '世界诱货1', 'worlduhot1', 'worlduhot1', 'e10adc3949ba59abbe56e057f20f883e', '430000', '430900', '430903', '湖南城市学院', '1', '2', '0', '0', '1', '2017-05-19 16:43:51', '2017-05-20 16:44:06');
INSERT INTO `ly_agent` VALUES ('3', '世界诱货2', 'worlduhot2', 'worlduhot2', '6af090f6fd5a60b1d33c4d7117fd0dd1', '430000', '430900', '430903', '湖南城市学院', '1', '2', '2', '0', '1', '2017-05-19 16:43:45', '2017-05-20 16:44:10');
INSERT INTO `ly_agent` VALUES ('4', '世界诱货3', 'worlduhot3', 'worlduhot3', '4f698e1e6790a4e3b4c2c6004cb42b0a', '430000', '430900', '430903', '湖南城市学院', '1', '2', '3', '0', '0', '2017-05-20 16:41:31', '2017-05-20 16:41:31');
INSERT INTO `ly_agent` VALUES ('5', '世界诱货4', 'worlduhot4', 'worlduhot4', '8de8eeccfaa37047d9dedb0cf239e024', '430000', '430900', '430903', '湖南城市学院', '1', '2', '4', '0', '0', '2017-05-20 16:43:29', '2017-05-20 16:43:29');

-- ----------------------------
-- Table structure for `ly_area`
-- ----------------------------
DROP TABLE IF EXISTS `ly_area`;
CREATE TABLE `ly_area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `parent_id` bigint(20) NOT NULL DEFAULT '0',
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=910011 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_area
-- ----------------------------
INSERT INTO `ly_area` VALUES ('110000', '北京市', '0', '1');
INSERT INTO `ly_area` VALUES ('120000', '天津市', '0', '2');
INSERT INTO `ly_area` VALUES ('130000', '河北省', '0', '3');
INSERT INTO `ly_area` VALUES ('140000', '山西省', '0', '4');
INSERT INTO `ly_area` VALUES ('150000', '内蒙古', '0', '5');
INSERT INTO `ly_area` VALUES ('210000', '辽宁省', '0', '6');
INSERT INTO `ly_area` VALUES ('220000', '吉林省', '0', '7');
INSERT INTO `ly_area` VALUES ('230000', '黑龙江', '0', '8');
INSERT INTO `ly_area` VALUES ('310000', '上海市', '0', '9');
INSERT INTO `ly_area` VALUES ('320000', '江苏省', '0', '10');
INSERT INTO `ly_area` VALUES ('330000', '浙江省', '0', '11');
INSERT INTO `ly_area` VALUES ('340000', '安徽省', '0', '12');
INSERT INTO `ly_area` VALUES ('350000', '福建省', '0', '13');
INSERT INTO `ly_area` VALUES ('360000', '江西省', '0', '14');
INSERT INTO `ly_area` VALUES ('370000', '山东省', '0', '15');
INSERT INTO `ly_area` VALUES ('410000', '河南省', '0', '16');
INSERT INTO `ly_area` VALUES ('420000', '湖北省', '0', '17');
INSERT INTO `ly_area` VALUES ('430000', '湖南省', '0', '18');
INSERT INTO `ly_area` VALUES ('440000', '广东省', '0', '19');
INSERT INTO `ly_area` VALUES ('450000', '广西省', '0', '20');
INSERT INTO `ly_area` VALUES ('460000', '海南省', '0', '21');
INSERT INTO `ly_area` VALUES ('500000', '重庆市', '0', '22');
INSERT INTO `ly_area` VALUES ('510000', '四川省', '0', '23');
INSERT INTO `ly_area` VALUES ('520000', '贵州省', '0', '24');
INSERT INTO `ly_area` VALUES ('530000', '云南省', '0', '25');
INSERT INTO `ly_area` VALUES ('540000', '西　藏', '0', '26');
INSERT INTO `ly_area` VALUES ('610000', '陕西省', '0', '27');
INSERT INTO `ly_area` VALUES ('620000', '甘肃省', '0', '28');
INSERT INTO `ly_area` VALUES ('630000', '青海省', '0', '29');
INSERT INTO `ly_area` VALUES ('640000', '宁　夏', '0', '30');
INSERT INTO `ly_area` VALUES ('650000', '新　疆', '0', '31');
INSERT INTO `ly_area` VALUES ('710000', '台湾省', '0', '32');
INSERT INTO `ly_area` VALUES ('810000', '香　港', '0', '33');
INSERT INTO `ly_area` VALUES ('820000', '澳　门', '0', '34');
INSERT INTO `ly_area` VALUES ('110100', '北京市', '110000', '1');
INSERT INTO `ly_area` VALUES ('110200', '县', '110000', '2');
INSERT INTO `ly_area` VALUES ('120100', '市辖区', '120000', '1');
INSERT INTO `ly_area` VALUES ('120200', '县', '120000', '2');
INSERT INTO `ly_area` VALUES ('130100', '石家庄市', '130000', '1');
INSERT INTO `ly_area` VALUES ('130200', '唐山市', '130000', '2');
INSERT INTO `ly_area` VALUES ('130300', '秦皇岛市', '130000', '3');
INSERT INTO `ly_area` VALUES ('130400', '邯郸市', '130000', '4');
INSERT INTO `ly_area` VALUES ('130500', '邢台市', '130000', '5');
INSERT INTO `ly_area` VALUES ('130600', '保定市', '130000', '6');
INSERT INTO `ly_area` VALUES ('130700', '张家口市', '130000', '7');
INSERT INTO `ly_area` VALUES ('130800', '承德市', '130000', '8');
INSERT INTO `ly_area` VALUES ('130900', '沧州市', '130000', '9');
INSERT INTO `ly_area` VALUES ('131000', '廊坊市', '130000', '10');
INSERT INTO `ly_area` VALUES ('131100', '衡水市', '130000', '11');
INSERT INTO `ly_area` VALUES ('140100', '太原市', '140000', '1');
INSERT INTO `ly_area` VALUES ('140200', '大同市', '140000', '2');
INSERT INTO `ly_area` VALUES ('140300', '阳泉市', '140000', '3');
INSERT INTO `ly_area` VALUES ('140400', '长治市', '140000', '4');
INSERT INTO `ly_area` VALUES ('140500', '晋城市', '140000', '5');
INSERT INTO `ly_area` VALUES ('140600', '朔州市', '140000', '6');
INSERT INTO `ly_area` VALUES ('140700', '晋中市', '140000', '7');
INSERT INTO `ly_area` VALUES ('140800', '运城市', '140000', '8');
INSERT INTO `ly_area` VALUES ('140900', '忻州市', '140000', '9');
INSERT INTO `ly_area` VALUES ('141000', '临汾市', '140000', '10');
INSERT INTO `ly_area` VALUES ('141100', '吕梁市', '140000', '11');
INSERT INTO `ly_area` VALUES ('150100', '呼和浩特市', '150000', '1');
INSERT INTO `ly_area` VALUES ('150200', '包头市', '150000', '2');
INSERT INTO `ly_area` VALUES ('150300', '乌海市', '150000', '3');
INSERT INTO `ly_area` VALUES ('150400', '赤峰市', '150000', '4');
INSERT INTO `ly_area` VALUES ('150500', '通辽市', '150000', '5');
INSERT INTO `ly_area` VALUES ('150600', '鄂尔多斯市', '150000', '6');
INSERT INTO `ly_area` VALUES ('150700', '呼伦贝尔市', '150000', '7');
INSERT INTO `ly_area` VALUES ('150800', '巴彦淖尔市', '150000', '8');
INSERT INTO `ly_area` VALUES ('150900', '乌兰察布市', '150000', '9');
INSERT INTO `ly_area` VALUES ('152200', '兴安盟', '150000', '10');
INSERT INTO `ly_area` VALUES ('152500', '锡林郭勒盟', '150000', '11');
INSERT INTO `ly_area` VALUES ('152900', '阿拉善盟', '150000', '12');
INSERT INTO `ly_area` VALUES ('210100', '沈阳市', '210000', '1');
INSERT INTO `ly_area` VALUES ('210200', '大连市', '210000', '2');
INSERT INTO `ly_area` VALUES ('210300', '鞍山市', '210000', '3');
INSERT INTO `ly_area` VALUES ('210400', '抚顺市', '210000', '4');
INSERT INTO `ly_area` VALUES ('210500', '本溪市', '210000', '5');
INSERT INTO `ly_area` VALUES ('210600', '丹东市', '210000', '6');
INSERT INTO `ly_area` VALUES ('210700', '锦州市', '210000', '7');
INSERT INTO `ly_area` VALUES ('210800', '营口市', '210000', '8');
INSERT INTO `ly_area` VALUES ('210900', '阜新市', '210000', '9');
INSERT INTO `ly_area` VALUES ('211000', '辽阳市', '210000', '10');
INSERT INTO `ly_area` VALUES ('211100', '盘锦市', '210000', '11');
INSERT INTO `ly_area` VALUES ('211200', '铁岭市', '210000', '12');
INSERT INTO `ly_area` VALUES ('211300', '朝阳市', '210000', '13');
INSERT INTO `ly_area` VALUES ('211400', '葫芦岛市', '210000', '14');
INSERT INTO `ly_area` VALUES ('220100', '长春市', '220000', '1');
INSERT INTO `ly_area` VALUES ('220200', '吉林市', '220000', '2');
INSERT INTO `ly_area` VALUES ('220300', '四平市', '220000', '3');
INSERT INTO `ly_area` VALUES ('220400', '辽源市', '220000', '4');
INSERT INTO `ly_area` VALUES ('220500', '通化市', '220000', '5');
INSERT INTO `ly_area` VALUES ('220600', '白山市', '220000', '6');
INSERT INTO `ly_area` VALUES ('220700', '松原市', '220000', '7');
INSERT INTO `ly_area` VALUES ('220800', '白城市', '220000', '8');
INSERT INTO `ly_area` VALUES ('222400', '延边朝鲜族自治州', '220000', '9');
INSERT INTO `ly_area` VALUES ('230100', '哈尔滨市', '230000', '1');
INSERT INTO `ly_area` VALUES ('230200', '齐齐哈尔市', '230000', '2');
INSERT INTO `ly_area` VALUES ('230300', '鸡西市', '230000', '3');
INSERT INTO `ly_area` VALUES ('230400', '鹤岗市', '230000', '4');
INSERT INTO `ly_area` VALUES ('230500', '双鸭山市', '230000', '5');
INSERT INTO `ly_area` VALUES ('230600', '大庆市', '230000', '6');
INSERT INTO `ly_area` VALUES ('230700', '伊春市', '230000', '7');
INSERT INTO `ly_area` VALUES ('230800', '佳木斯市', '230000', '8');
INSERT INTO `ly_area` VALUES ('230900', '七台河市', '230000', '9');
INSERT INTO `ly_area` VALUES ('231000', '牡丹江市', '230000', '10');
INSERT INTO `ly_area` VALUES ('231100', '黑河市', '230000', '11');
INSERT INTO `ly_area` VALUES ('231200', '绥化市', '230000', '12');
INSERT INTO `ly_area` VALUES ('232700', '大兴安岭地区', '230000', '13');
INSERT INTO `ly_area` VALUES ('310100', '市辖区', '310000', '1');
INSERT INTO `ly_area` VALUES ('310200', '县', '310000', '2');
INSERT INTO `ly_area` VALUES ('320100', '南京市', '320000', '1');
INSERT INTO `ly_area` VALUES ('320200', '无锡市', '320000', '2');
INSERT INTO `ly_area` VALUES ('320300', '徐州市', '320000', '3');
INSERT INTO `ly_area` VALUES ('320400', '常州市', '320000', '4');
INSERT INTO `ly_area` VALUES ('320500', '苏州市', '320000', '5');
INSERT INTO `ly_area` VALUES ('320600', '南通市', '320000', '6');
INSERT INTO `ly_area` VALUES ('320700', '连云港市', '320000', '7');
INSERT INTO `ly_area` VALUES ('320800', '淮安市', '320000', '8');
INSERT INTO `ly_area` VALUES ('320900', '盐城市', '320000', '9');
INSERT INTO `ly_area` VALUES ('321000', '扬州市', '320000', '10');
INSERT INTO `ly_area` VALUES ('321100', '镇江市', '320000', '11');
INSERT INTO `ly_area` VALUES ('321200', '泰州市', '320000', '12');
INSERT INTO `ly_area` VALUES ('321300', '宿迁市', '320000', '13');
INSERT INTO `ly_area` VALUES ('330100', '杭州市', '330000', '1');
INSERT INTO `ly_area` VALUES ('330200', '宁波市', '330000', '2');
INSERT INTO `ly_area` VALUES ('330300', '温州市', '330000', '3');
INSERT INTO `ly_area` VALUES ('330400', '嘉兴市', '330000', '4');
INSERT INTO `ly_area` VALUES ('330500', '湖州市', '330000', '5');
INSERT INTO `ly_area` VALUES ('330600', '绍兴市', '330000', '6');
INSERT INTO `ly_area` VALUES ('330700', '金华市', '330000', '7');
INSERT INTO `ly_area` VALUES ('330800', '衢州市', '330000', '8');
INSERT INTO `ly_area` VALUES ('330900', '舟山市', '330000', '9');
INSERT INTO `ly_area` VALUES ('331000', '台州市', '330000', '10');
INSERT INTO `ly_area` VALUES ('331100', '丽水市', '330000', '11');
INSERT INTO `ly_area` VALUES ('340100', '合肥市', '340000', '1');
INSERT INTO `ly_area` VALUES ('340200', '芜湖市', '340000', '2');
INSERT INTO `ly_area` VALUES ('340300', '蚌埠市', '340000', '3');
INSERT INTO `ly_area` VALUES ('340400', '淮南市', '340000', '4');
INSERT INTO `ly_area` VALUES ('340500', '马鞍山市', '340000', '5');
INSERT INTO `ly_area` VALUES ('340600', '淮北市', '340000', '6');
INSERT INTO `ly_area` VALUES ('340700', '铜陵市', '340000', '7');
INSERT INTO `ly_area` VALUES ('340800', '安庆市', '340000', '8');
INSERT INTO `ly_area` VALUES ('341000', '黄山市', '340000', '9');
INSERT INTO `ly_area` VALUES ('341100', '滁州市', '340000', '10');
INSERT INTO `ly_area` VALUES ('341200', '阜阳市', '340000', '11');
INSERT INTO `ly_area` VALUES ('341300', '宿州市', '340000', '12');
INSERT INTO `ly_area` VALUES ('341500', '六安市', '340000', '13');
INSERT INTO `ly_area` VALUES ('341600', '亳州市', '340000', '14');
INSERT INTO `ly_area` VALUES ('341700', '池州市', '340000', '15');
INSERT INTO `ly_area` VALUES ('341800', '宣城市', '340000', '16');
INSERT INTO `ly_area` VALUES ('350100', '福州市', '350000', '1');
INSERT INTO `ly_area` VALUES ('350200', '厦门市', '350000', '2');
INSERT INTO `ly_area` VALUES ('350300', '莆田市', '350000', '3');
INSERT INTO `ly_area` VALUES ('350400', '三明市', '350000', '4');
INSERT INTO `ly_area` VALUES ('350500', '泉州市', '350000', '5');
INSERT INTO `ly_area` VALUES ('350600', '漳州市', '350000', '6');
INSERT INTO `ly_area` VALUES ('350700', '南平市', '350000', '7');
INSERT INTO `ly_area` VALUES ('350800', '龙岩市', '350000', '8');
INSERT INTO `ly_area` VALUES ('350900', '宁德市', '350000', '9');
INSERT INTO `ly_area` VALUES ('360100', '南昌市', '360000', '1');
INSERT INTO `ly_area` VALUES ('360200', '景德镇市', '360000', '2');
INSERT INTO `ly_area` VALUES ('360300', '萍乡市', '360000', '3');
INSERT INTO `ly_area` VALUES ('360400', '九江市', '360000', '4');
INSERT INTO `ly_area` VALUES ('360500', '新余市', '360000', '5');
INSERT INTO `ly_area` VALUES ('360600', '鹰潭市', '360000', '6');
INSERT INTO `ly_area` VALUES ('360700', '赣州市', '360000', '7');
INSERT INTO `ly_area` VALUES ('360800', '吉安市', '360000', '8');
INSERT INTO `ly_area` VALUES ('360900', '宜春市', '360000', '9');
INSERT INTO `ly_area` VALUES ('361000', '抚州市', '360000', '10');
INSERT INTO `ly_area` VALUES ('361100', '上饶市', '360000', '11');
INSERT INTO `ly_area` VALUES ('370100', '济南市', '370000', '1');
INSERT INTO `ly_area` VALUES ('370200', '青岛市', '370000', '2');
INSERT INTO `ly_area` VALUES ('370300', '淄博市', '370000', '3');
INSERT INTO `ly_area` VALUES ('370400', '枣庄市', '370000', '4');
INSERT INTO `ly_area` VALUES ('370500', '东营市', '370000', '5');
INSERT INTO `ly_area` VALUES ('370600', '烟台市', '370000', '6');
INSERT INTO `ly_area` VALUES ('370700', '潍坊市', '370000', '7');
INSERT INTO `ly_area` VALUES ('370800', '济宁市', '370000', '8');
INSERT INTO `ly_area` VALUES ('370900', '泰安市', '370000', '9');
INSERT INTO `ly_area` VALUES ('371000', '威海市', '370000', '10');
INSERT INTO `ly_area` VALUES ('371100', '日照市', '370000', '11');
INSERT INTO `ly_area` VALUES ('371200', '莱芜市', '370000', '12');
INSERT INTO `ly_area` VALUES ('371300', '临沂市', '370000', '13');
INSERT INTO `ly_area` VALUES ('371400', '德州市', '370000', '14');
INSERT INTO `ly_area` VALUES ('371500', '聊城市', '370000', '15');
INSERT INTO `ly_area` VALUES ('371600', '滨州市', '370000', '16');
INSERT INTO `ly_area` VALUES ('371700', '菏泽市', '370000', '17');
INSERT INTO `ly_area` VALUES ('410100', '郑州市', '410000', '1');
INSERT INTO `ly_area` VALUES ('410200', '开封市', '410000', '2');
INSERT INTO `ly_area` VALUES ('410300', '洛阳市', '410000', '3');
INSERT INTO `ly_area` VALUES ('410400', '平顶山市', '410000', '4');
INSERT INTO `ly_area` VALUES ('410500', '安阳市', '410000', '5');
INSERT INTO `ly_area` VALUES ('410600', '鹤壁市', '410000', '6');
INSERT INTO `ly_area` VALUES ('410700', '新乡市', '410000', '7');
INSERT INTO `ly_area` VALUES ('410800', '焦作市', '410000', '8');
INSERT INTO `ly_area` VALUES ('410900', '濮阳市', '410000', '9');
INSERT INTO `ly_area` VALUES ('411000', '许昌市', '410000', '10');
INSERT INTO `ly_area` VALUES ('411100', '漯河市', '410000', '11');
INSERT INTO `ly_area` VALUES ('411200', '三门峡市', '410000', '12');
INSERT INTO `ly_area` VALUES ('411300', '南阳市', '410000', '13');
INSERT INTO `ly_area` VALUES ('411400', '商丘市', '410000', '14');
INSERT INTO `ly_area` VALUES ('411500', '信阳市', '410000', '15');
INSERT INTO `ly_area` VALUES ('411600', '周口市', '410000', '16');
INSERT INTO `ly_area` VALUES ('411700', '驻马店市', '410000', '17');
INSERT INTO `ly_area` VALUES ('420100', '武汉市', '420000', '1');
INSERT INTO `ly_area` VALUES ('420200', '黄石市', '420000', '2');
INSERT INTO `ly_area` VALUES ('420300', '十堰市', '420000', '3');
INSERT INTO `ly_area` VALUES ('420500', '宜昌市', '420000', '4');
INSERT INTO `ly_area` VALUES ('420600', '襄樊市', '420000', '5');
INSERT INTO `ly_area` VALUES ('420700', '鄂州市', '420000', '6');
INSERT INTO `ly_area` VALUES ('420800', '荆门市', '420000', '7');
INSERT INTO `ly_area` VALUES ('420900', '孝感市', '420000', '8');
INSERT INTO `ly_area` VALUES ('421000', '荆州市', '420000', '9');
INSERT INTO `ly_area` VALUES ('421100', '黄冈市', '420000', '10');
INSERT INTO `ly_area` VALUES ('421200', '咸宁市', '420000', '11');
INSERT INTO `ly_area` VALUES ('421300', '随州市', '420000', '12');
INSERT INTO `ly_area` VALUES ('422800', '恩施土家族苗族自治州', '420000', '13');
INSERT INTO `ly_area` VALUES ('429000', '省直辖行政单位', '420000', '14');
INSERT INTO `ly_area` VALUES ('430100', '长沙市', '430000', '1');
INSERT INTO `ly_area` VALUES ('430200', '株洲市', '430000', '2');
INSERT INTO `ly_area` VALUES ('430300', '湘潭市', '430000', '3');
INSERT INTO `ly_area` VALUES ('430400', '衡阳市', '430000', '4');
INSERT INTO `ly_area` VALUES ('430500', '邵阳市', '430000', '5');
INSERT INTO `ly_area` VALUES ('430600', '岳阳市', '430000', '6');
INSERT INTO `ly_area` VALUES ('430700', '常德市', '430000', '7');
INSERT INTO `ly_area` VALUES ('430800', '张家界市', '430000', '8');
INSERT INTO `ly_area` VALUES ('430900', '益阳市', '430000', '9');
INSERT INTO `ly_area` VALUES ('431000', '郴州市', '430000', '10');
INSERT INTO `ly_area` VALUES ('431100', '永州市', '430000', '11');
INSERT INTO `ly_area` VALUES ('431200', '怀化市', '430000', '12');
INSERT INTO `ly_area` VALUES ('431300', '娄底市', '430000', '13');
INSERT INTO `ly_area` VALUES ('433100', '湘西土家族苗族自治州', '430000', '14');
INSERT INTO `ly_area` VALUES ('440100', '广州市', '440000', '1');
INSERT INTO `ly_area` VALUES ('440200', '韶关市', '440000', '2');
INSERT INTO `ly_area` VALUES ('440300', '深圳市', '440000', '3');
INSERT INTO `ly_area` VALUES ('440400', '珠海市', '440000', '4');
INSERT INTO `ly_area` VALUES ('440500', '汕头市', '440000', '5');
INSERT INTO `ly_area` VALUES ('440600', '佛山市', '440000', '6');
INSERT INTO `ly_area` VALUES ('440700', '江门市', '440000', '7');
INSERT INTO `ly_area` VALUES ('440800', '湛江市', '440000', '8');
INSERT INTO `ly_area` VALUES ('440900', '茂名市', '440000', '9');
INSERT INTO `ly_area` VALUES ('441200', '肇庆市', '440000', '10');
INSERT INTO `ly_area` VALUES ('441300', '惠州市', '440000', '11');
INSERT INTO `ly_area` VALUES ('441400', '梅州市', '440000', '12');
INSERT INTO `ly_area` VALUES ('441500', '汕尾市', '440000', '13');
INSERT INTO `ly_area` VALUES ('441600', '河源市', '440000', '14');
INSERT INTO `ly_area` VALUES ('441700', '阳江市', '440000', '15');
INSERT INTO `ly_area` VALUES ('441800', '清远市', '440000', '16');
INSERT INTO `ly_area` VALUES ('441900', '东莞市', '440000', '17');
INSERT INTO `ly_area` VALUES ('442000', '中山市', '440000', '18');
INSERT INTO `ly_area` VALUES ('445100', '潮州市', '440000', '19');
INSERT INTO `ly_area` VALUES ('445200', '揭阳市', '440000', '20');
INSERT INTO `ly_area` VALUES ('445300', '云浮市', '440000', '21');
INSERT INTO `ly_area` VALUES ('450100', '南宁市', '450000', '1');
INSERT INTO `ly_area` VALUES ('450200', '柳州市', '450000', '2');
INSERT INTO `ly_area` VALUES ('450300', '桂林市', '450000', '3');
INSERT INTO `ly_area` VALUES ('450400', '梧州市', '450000', '4');
INSERT INTO `ly_area` VALUES ('450500', '北海市', '450000', '5');
INSERT INTO `ly_area` VALUES ('450600', '防城港市', '450000', '6');
INSERT INTO `ly_area` VALUES ('450700', '钦州市', '450000', '7');
INSERT INTO `ly_area` VALUES ('450800', '贵港市', '450000', '8');
INSERT INTO `ly_area` VALUES ('450900', '玉林市', '450000', '9');
INSERT INTO `ly_area` VALUES ('451000', '百色市', '450000', '10');
INSERT INTO `ly_area` VALUES ('451100', '贺州市', '450000', '11');
INSERT INTO `ly_area` VALUES ('451200', '河池市', '450000', '12');
INSERT INTO `ly_area` VALUES ('451300', '来宾市', '450000', '13');
INSERT INTO `ly_area` VALUES ('451400', '崇左市', '450000', '14');
INSERT INTO `ly_area` VALUES ('460100', '海口市', '460000', '1');
INSERT INTO `ly_area` VALUES ('460200', '三亚市', '460000', '2');
INSERT INTO `ly_area` VALUES ('469000', '省直辖县级行政单位', '460000', '3');
INSERT INTO `ly_area` VALUES ('500100', '市辖区', '500000', '1');
INSERT INTO `ly_area` VALUES ('500200', '县', '500000', '2');
INSERT INTO `ly_area` VALUES ('500300', '市', '500000', '3');
INSERT INTO `ly_area` VALUES ('510100', '成都市', '510000', '1');
INSERT INTO `ly_area` VALUES ('510300', '自贡市', '510000', '2');
INSERT INTO `ly_area` VALUES ('510400', '攀枝花市', '510000', '3');
INSERT INTO `ly_area` VALUES ('510500', '泸州市', '510000', '4');
INSERT INTO `ly_area` VALUES ('510600', '德阳市', '510000', '5');
INSERT INTO `ly_area` VALUES ('510700', '绵阳市', '510000', '6');
INSERT INTO `ly_area` VALUES ('510800', '广元市', '510000', '7');
INSERT INTO `ly_area` VALUES ('510900', '遂宁市', '510000', '8');
INSERT INTO `ly_area` VALUES ('511000', '内江市', '510000', '9');
INSERT INTO `ly_area` VALUES ('511100', '乐山市', '510000', '10');
INSERT INTO `ly_area` VALUES ('511300', '南充市', '510000', '11');
INSERT INTO `ly_area` VALUES ('511400', '眉山市', '510000', '12');
INSERT INTO `ly_area` VALUES ('511500', '宜宾市', '510000', '13');
INSERT INTO `ly_area` VALUES ('511600', '广安市', '510000', '14');
INSERT INTO `ly_area` VALUES ('511700', '达州市', '510000', '15');
INSERT INTO `ly_area` VALUES ('511800', '雅安市', '510000', '16');
INSERT INTO `ly_area` VALUES ('511900', '巴中市', '510000', '17');
INSERT INTO `ly_area` VALUES ('512000', '资阳市', '510000', '18');
INSERT INTO `ly_area` VALUES ('513200', '阿坝藏族羌族自治州', '510000', '19');
INSERT INTO `ly_area` VALUES ('513300', '甘孜藏族自治州', '510000', '20');
INSERT INTO `ly_area` VALUES ('513400', '凉山彝族自治州', '510000', '21');
INSERT INTO `ly_area` VALUES ('520100', '贵阳市', '520000', '1');
INSERT INTO `ly_area` VALUES ('520200', '六盘水市', '520000', '2');
INSERT INTO `ly_area` VALUES ('520300', '遵义市', '520000', '3');
INSERT INTO `ly_area` VALUES ('520400', '安顺市', '520000', '4');
INSERT INTO `ly_area` VALUES ('522200', '铜仁地区', '520000', '5');
INSERT INTO `ly_area` VALUES ('522300', '黔西南布依族苗族自治州', '520000', '6');
INSERT INTO `ly_area` VALUES ('522400', '毕节地区', '520000', '7');
INSERT INTO `ly_area` VALUES ('522600', '黔东南苗族侗族自治州', '520000', '8');
INSERT INTO `ly_area` VALUES ('522700', '黔南布依族苗族自治州', '520000', '9');
INSERT INTO `ly_area` VALUES ('530100', '昆明市', '530000', '1');
INSERT INTO `ly_area` VALUES ('530300', '曲靖市', '530000', '2');
INSERT INTO `ly_area` VALUES ('530400', '玉溪市', '530000', '3');
INSERT INTO `ly_area` VALUES ('530500', '保山市', '530000', '4');
INSERT INTO `ly_area` VALUES ('530600', '昭通市', '530000', '5');
INSERT INTO `ly_area` VALUES ('530700', '丽江市', '530000', '6');
INSERT INTO `ly_area` VALUES ('530800', '思茅市', '530000', '7');
INSERT INTO `ly_area` VALUES ('530900', '临沧市', '530000', '8');
INSERT INTO `ly_area` VALUES ('532300', '楚雄彝族自治州', '530000', '9');
INSERT INTO `ly_area` VALUES ('532500', '红河哈尼族彝族自治州', '530000', '10');
INSERT INTO `ly_area` VALUES ('532600', '文山壮族苗族自治州', '530000', '11');
INSERT INTO `ly_area` VALUES ('532800', '西双版纳傣族自治州', '530000', '12');
INSERT INTO `ly_area` VALUES ('532900', '大理白族自治州', '530000', '13');
INSERT INTO `ly_area` VALUES ('533100', '德宏傣族景颇族自治州', '530000', '14');
INSERT INTO `ly_area` VALUES ('533300', '怒江傈僳族自治州', '530000', '15');
INSERT INTO `ly_area` VALUES ('533400', '迪庆藏族自治州', '530000', '16');
INSERT INTO `ly_area` VALUES ('540100', '拉萨市', '540000', '1');
INSERT INTO `ly_area` VALUES ('542100', '昌都地区', '540000', '2');
INSERT INTO `ly_area` VALUES ('542200', '山南地区', '540000', '3');
INSERT INTO `ly_area` VALUES ('542300', '日喀则地区', '540000', '4');
INSERT INTO `ly_area` VALUES ('542400', '那曲地区', '540000', '5');
INSERT INTO `ly_area` VALUES ('542500', '阿里地区', '540000', '6');
INSERT INTO `ly_area` VALUES ('542600', '林芝地区', '540000', '7');
INSERT INTO `ly_area` VALUES ('610100', '西安市', '610000', '1');
INSERT INTO `ly_area` VALUES ('610200', '铜川市', '610000', '2');
INSERT INTO `ly_area` VALUES ('610300', '宝鸡市', '610000', '3');
INSERT INTO `ly_area` VALUES ('610400', '咸阳市', '610000', '4');
INSERT INTO `ly_area` VALUES ('610500', '渭南市', '610000', '5');
INSERT INTO `ly_area` VALUES ('610600', '延安市', '610000', '6');
INSERT INTO `ly_area` VALUES ('610700', '汉中市', '610000', '7');
INSERT INTO `ly_area` VALUES ('610800', '榆林市', '610000', '8');
INSERT INTO `ly_area` VALUES ('610900', '安康市', '610000', '9');
INSERT INTO `ly_area` VALUES ('611000', '商洛市', '610000', '10');
INSERT INTO `ly_area` VALUES ('620100', '兰州市', '620000', '1');
INSERT INTO `ly_area` VALUES ('620200', '嘉峪关市', '620000', '2');
INSERT INTO `ly_area` VALUES ('620300', '金昌市', '620000', '3');
INSERT INTO `ly_area` VALUES ('620400', '白银市', '620000', '4');
INSERT INTO `ly_area` VALUES ('620500', '天水市', '620000', '5');
INSERT INTO `ly_area` VALUES ('620600', '武威市', '620000', '6');
INSERT INTO `ly_area` VALUES ('620700', '张掖市', '620000', '7');
INSERT INTO `ly_area` VALUES ('620800', '平凉市', '620000', '8');
INSERT INTO `ly_area` VALUES ('620900', '酒泉市', '620000', '9');
INSERT INTO `ly_area` VALUES ('621000', '庆阳市', '620000', '10');
INSERT INTO `ly_area` VALUES ('621100', '定西市', '620000', '11');
INSERT INTO `ly_area` VALUES ('621200', '陇南市', '620000', '12');
INSERT INTO `ly_area` VALUES ('622900', '临夏回族自治州', '620000', '13');
INSERT INTO `ly_area` VALUES ('623000', '甘南藏族自治州', '620000', '14');
INSERT INTO `ly_area` VALUES ('630100', '西宁市', '630000', '1');
INSERT INTO `ly_area` VALUES ('632100', '海东地区', '630000', '2');
INSERT INTO `ly_area` VALUES ('632200', '海北藏族自治州', '630000', '3');
INSERT INTO `ly_area` VALUES ('632300', '黄南藏族自治州', '630000', '4');
INSERT INTO `ly_area` VALUES ('632500', '海南藏族自治州', '630000', '5');
INSERT INTO `ly_area` VALUES ('632600', '果洛藏族自治州', '630000', '6');
INSERT INTO `ly_area` VALUES ('632700', '玉树藏族自治州', '630000', '7');
INSERT INTO `ly_area` VALUES ('632800', '海西蒙古族藏族自治州', '630000', '8');
INSERT INTO `ly_area` VALUES ('640100', '银川市', '640000', '1');
INSERT INTO `ly_area` VALUES ('640200', '石嘴山市', '640000', '2');
INSERT INTO `ly_area` VALUES ('640300', '吴忠市', '640000', '3');
INSERT INTO `ly_area` VALUES ('640400', '固原市', '640000', '4');
INSERT INTO `ly_area` VALUES ('640500', '中卫市', '640000', '5');
INSERT INTO `ly_area` VALUES ('650100', '乌鲁木齐市', '650000', '1');
INSERT INTO `ly_area` VALUES ('650200', '克拉玛依市', '650000', '2');
INSERT INTO `ly_area` VALUES ('652100', '吐鲁番地区', '650000', '3');
INSERT INTO `ly_area` VALUES ('652200', '哈密地区', '650000', '4');
INSERT INTO `ly_area` VALUES ('652300', '昌吉回族自治州', '650000', '5');
INSERT INTO `ly_area` VALUES ('652700', '博尔塔拉蒙古自治州', '650000', '6');
INSERT INTO `ly_area` VALUES ('652800', '巴音郭楞蒙古自治州', '650000', '7');
INSERT INTO `ly_area` VALUES ('652900', '阿克苏地区', '650000', '8');
INSERT INTO `ly_area` VALUES ('653000', '克孜勒苏柯尔克孜自治州', '650000', '9');
INSERT INTO `ly_area` VALUES ('653100', '喀什地区', '650000', '10');
INSERT INTO `ly_area` VALUES ('653200', '和田地区', '650000', '11');
INSERT INTO `ly_area` VALUES ('654000', '伊犁哈萨克自治州', '650000', '12');
INSERT INTO `ly_area` VALUES ('654200', '塔城地区', '650000', '13');
INSERT INTO `ly_area` VALUES ('654300', '阿勒泰地区', '650000', '14');
INSERT INTO `ly_area` VALUES ('659000', '省直辖行政单位', '650000', '15');
INSERT INTO `ly_area` VALUES ('110101', '东城区', '110100', '1');
INSERT INTO `ly_area` VALUES ('110102', '西城区', '110100', '2');
INSERT INTO `ly_area` VALUES ('110103', '崇文区', '110100', '3');
INSERT INTO `ly_area` VALUES ('110104', '宣武区', '110100', '4');
INSERT INTO `ly_area` VALUES ('110105', '朝阳区', '110100', '5');
INSERT INTO `ly_area` VALUES ('110106', '丰台区', '110100', '6');
INSERT INTO `ly_area` VALUES ('110107', '石景山区', '110100', '7');
INSERT INTO `ly_area` VALUES ('110108', '海淀区', '110100', '8');
INSERT INTO `ly_area` VALUES ('110109', '门头沟区', '110100', '9');
INSERT INTO `ly_area` VALUES ('110111', '房山区', '110100', '10');
INSERT INTO `ly_area` VALUES ('110112', '通州区', '110100', '11');
INSERT INTO `ly_area` VALUES ('110113', '顺义区', '110100', '12');
INSERT INTO `ly_area` VALUES ('110114', '昌平区', '110100', '13');
INSERT INTO `ly_area` VALUES ('110115', '大兴区', '110100', '14');
INSERT INTO `ly_area` VALUES ('110116', '怀柔区', '110100', '15');
INSERT INTO `ly_area` VALUES ('110117', '平谷区', '110100', '16');
INSERT INTO `ly_area` VALUES ('110228', '密云县', '110200', '1');
INSERT INTO `ly_area` VALUES ('110229', '延庆县', '110200', '2');
INSERT INTO `ly_area` VALUES ('120101', '和平区', '120100', '1');
INSERT INTO `ly_area` VALUES ('120102', '河东区', '120100', '2');
INSERT INTO `ly_area` VALUES ('120103', '河西区', '120100', '3');
INSERT INTO `ly_area` VALUES ('120104', '南开区', '120100', '4');
INSERT INTO `ly_area` VALUES ('120105', '河北区', '120100', '5');
INSERT INTO `ly_area` VALUES ('120106', '红桥区', '120100', '6');
INSERT INTO `ly_area` VALUES ('120107', '塘沽区', '120100', '7');
INSERT INTO `ly_area` VALUES ('120108', '汉沽区', '120100', '8');
INSERT INTO `ly_area` VALUES ('120109', '大港区', '120100', '9');
INSERT INTO `ly_area` VALUES ('120110', '东丽区', '120100', '10');
INSERT INTO `ly_area` VALUES ('120111', '西青区', '120100', '11');
INSERT INTO `ly_area` VALUES ('120112', '津南区', '120100', '12');
INSERT INTO `ly_area` VALUES ('120113', '北辰区', '120100', '13');
INSERT INTO `ly_area` VALUES ('120114', '武清区', '120100', '14');
INSERT INTO `ly_area` VALUES ('120115', '宝坻区', '120100', '15');
INSERT INTO `ly_area` VALUES ('120221', '宁河县', '120200', '1');
INSERT INTO `ly_area` VALUES ('120223', '静海县', '120200', '2');
INSERT INTO `ly_area` VALUES ('120225', '蓟　县', '120200', '3');
INSERT INTO `ly_area` VALUES ('130101', '市辖区', '130100', '1');
INSERT INTO `ly_area` VALUES ('130102', '长安区', '130100', '2');
INSERT INTO `ly_area` VALUES ('130103', '桥东区', '130100', '3');
INSERT INTO `ly_area` VALUES ('130104', '桥西区', '130100', '4');
INSERT INTO `ly_area` VALUES ('130105', '新华区', '130100', '5');
INSERT INTO `ly_area` VALUES ('130107', '井陉矿区', '130100', '6');
INSERT INTO `ly_area` VALUES ('130108', '裕华区', '130100', '7');
INSERT INTO `ly_area` VALUES ('130121', '井陉县', '130100', '8');
INSERT INTO `ly_area` VALUES ('130123', '正定县', '130100', '9');
INSERT INTO `ly_area` VALUES ('130124', '栾城县', '130100', '10');
INSERT INTO `ly_area` VALUES ('130125', '行唐县', '130100', '11');
INSERT INTO `ly_area` VALUES ('130126', '灵寿县', '130100', '12');
INSERT INTO `ly_area` VALUES ('130127', '高邑县', '130100', '13');
INSERT INTO `ly_area` VALUES ('130128', '深泽县', '130100', '14');
INSERT INTO `ly_area` VALUES ('130129', '赞皇县', '130100', '15');
INSERT INTO `ly_area` VALUES ('130130', '无极县', '130100', '16');
INSERT INTO `ly_area` VALUES ('130131', '平山县', '130100', '17');
INSERT INTO `ly_area` VALUES ('130132', '元氏县', '130100', '18');
INSERT INTO `ly_area` VALUES ('130133', '赵　县', '130100', '19');
INSERT INTO `ly_area` VALUES ('130181', '辛集市', '130100', '20');
INSERT INTO `ly_area` VALUES ('130182', '藁城市', '130100', '21');
INSERT INTO `ly_area` VALUES ('130183', '晋州市', '130100', '22');
INSERT INTO `ly_area` VALUES ('130184', '新乐市', '130100', '23');
INSERT INTO `ly_area` VALUES ('130185', '鹿泉市', '130100', '24');
INSERT INTO `ly_area` VALUES ('130201', '市辖区', '130200', '1');
INSERT INTO `ly_area` VALUES ('130202', '路南区', '130200', '2');
INSERT INTO `ly_area` VALUES ('130203', '路北区', '130200', '3');
INSERT INTO `ly_area` VALUES ('130204', '古冶区', '130200', '4');
INSERT INTO `ly_area` VALUES ('130205', '开平区', '130200', '5');
INSERT INTO `ly_area` VALUES ('130207', '丰南区', '130200', '6');
INSERT INTO `ly_area` VALUES ('130208', '丰润区', '130200', '7');
INSERT INTO `ly_area` VALUES ('130223', '滦　县', '130200', '8');
INSERT INTO `ly_area` VALUES ('130224', '滦南县', '130200', '9');
INSERT INTO `ly_area` VALUES ('130225', '乐亭县', '130200', '10');
INSERT INTO `ly_area` VALUES ('130227', '迁西县', '130200', '11');
INSERT INTO `ly_area` VALUES ('130229', '玉田县', '130200', '12');
INSERT INTO `ly_area` VALUES ('130230', '唐海县', '130200', '13');
INSERT INTO `ly_area` VALUES ('130281', '遵化市', '130200', '14');
INSERT INTO `ly_area` VALUES ('130283', '迁安市', '130200', '15');
INSERT INTO `ly_area` VALUES ('130301', '市辖区', '130300', '1');
INSERT INTO `ly_area` VALUES ('130302', '海港区', '130300', '2');
INSERT INTO `ly_area` VALUES ('130303', '山海关区', '130300', '3');
INSERT INTO `ly_area` VALUES ('130304', '北戴河区', '130300', '4');
INSERT INTO `ly_area` VALUES ('130321', '青龙满族自治县', '130300', '5');
INSERT INTO `ly_area` VALUES ('130322', '昌黎县', '130300', '6');
INSERT INTO `ly_area` VALUES ('130323', '抚宁县', '130300', '7');
INSERT INTO `ly_area` VALUES ('130324', '卢龙县', '130300', '8');
INSERT INTO `ly_area` VALUES ('130401', '市辖区', '130400', '1');
INSERT INTO `ly_area` VALUES ('130402', '邯山区', '130400', '2');
INSERT INTO `ly_area` VALUES ('130403', '丛台区', '130400', '3');
INSERT INTO `ly_area` VALUES ('130404', '复兴区', '130400', '4');
INSERT INTO `ly_area` VALUES ('130406', '峰峰矿区', '130400', '5');
INSERT INTO `ly_area` VALUES ('130421', '邯郸县', '130400', '6');
INSERT INTO `ly_area` VALUES ('130423', '临漳县', '130400', '7');
INSERT INTO `ly_area` VALUES ('130424', '成安县', '130400', '8');
INSERT INTO `ly_area` VALUES ('130425', '大名县', '130400', '9');
INSERT INTO `ly_area` VALUES ('130426', '涉　县', '130400', '10');
INSERT INTO `ly_area` VALUES ('130427', '磁　县', '130400', '11');
INSERT INTO `ly_area` VALUES ('130428', '肥乡县', '130400', '12');
INSERT INTO `ly_area` VALUES ('130429', '永年县', '130400', '13');
INSERT INTO `ly_area` VALUES ('130430', '邱　县', '130400', '14');
INSERT INTO `ly_area` VALUES ('130431', '鸡泽县', '130400', '15');
INSERT INTO `ly_area` VALUES ('130432', '广平县', '130400', '16');
INSERT INTO `ly_area` VALUES ('130433', '馆陶县', '130400', '17');
INSERT INTO `ly_area` VALUES ('130434', '魏　县', '130400', '18');
INSERT INTO `ly_area` VALUES ('130435', '曲周县', '130400', '19');
INSERT INTO `ly_area` VALUES ('130481', '武安市', '130400', '20');
INSERT INTO `ly_area` VALUES ('130501', '市辖区', '130500', '1');
INSERT INTO `ly_area` VALUES ('130502', '桥东区', '130500', '2');
INSERT INTO `ly_area` VALUES ('130503', '桥西区', '130500', '3');
INSERT INTO `ly_area` VALUES ('130521', '邢台县', '130500', '4');
INSERT INTO `ly_area` VALUES ('130522', '临城县', '130500', '5');
INSERT INTO `ly_area` VALUES ('130523', '内丘县', '130500', '6');
INSERT INTO `ly_area` VALUES ('130524', '柏乡县', '130500', '7');
INSERT INTO `ly_area` VALUES ('130525', '隆尧县', '130500', '8');
INSERT INTO `ly_area` VALUES ('130526', '任　县', '130500', '9');
INSERT INTO `ly_area` VALUES ('130527', '南和县', '130500', '10');
INSERT INTO `ly_area` VALUES ('130528', '宁晋县', '130500', '11');
INSERT INTO `ly_area` VALUES ('130529', '巨鹿县', '130500', '12');
INSERT INTO `ly_area` VALUES ('130530', '新河县', '130500', '13');
INSERT INTO `ly_area` VALUES ('130531', '广宗县', '130500', '14');
INSERT INTO `ly_area` VALUES ('130532', '平乡县', '130500', '15');
INSERT INTO `ly_area` VALUES ('130533', '威　县', '130500', '16');
INSERT INTO `ly_area` VALUES ('130534', '清河县', '130500', '17');
INSERT INTO `ly_area` VALUES ('130535', '临西县', '130500', '18');
INSERT INTO `ly_area` VALUES ('130581', '南宫市', '130500', '19');
INSERT INTO `ly_area` VALUES ('130582', '沙河市', '130500', '20');
INSERT INTO `ly_area` VALUES ('130601', '市辖区', '130600', '1');
INSERT INTO `ly_area` VALUES ('130602', '新市区', '130600', '2');
INSERT INTO `ly_area` VALUES ('130603', '北市区', '130600', '3');
INSERT INTO `ly_area` VALUES ('130604', '南市区', '130600', '4');
INSERT INTO `ly_area` VALUES ('130621', '满城县', '130600', '5');
INSERT INTO `ly_area` VALUES ('130622', '清苑县', '130600', '6');
INSERT INTO `ly_area` VALUES ('130623', '涞水县', '130600', '7');
INSERT INTO `ly_area` VALUES ('130624', '阜平县', '130600', '8');
INSERT INTO `ly_area` VALUES ('130625', '徐水县', '130600', '9');
INSERT INTO `ly_area` VALUES ('130626', '定兴县', '130600', '10');
INSERT INTO `ly_area` VALUES ('130627', '唐　县', '130600', '11');
INSERT INTO `ly_area` VALUES ('130628', '高阳县', '130600', '12');
INSERT INTO `ly_area` VALUES ('130629', '容城县', '130600', '13');
INSERT INTO `ly_area` VALUES ('130630', '涞源县', '130600', '14');
INSERT INTO `ly_area` VALUES ('130631', '望都县', '130600', '15');
INSERT INTO `ly_area` VALUES ('130632', '安新县', '130600', '16');
INSERT INTO `ly_area` VALUES ('130633', '易　县', '130600', '17');
INSERT INTO `ly_area` VALUES ('130634', '曲阳县', '130600', '18');
INSERT INTO `ly_area` VALUES ('130635', '蠡　县', '130600', '19');
INSERT INTO `ly_area` VALUES ('130636', '顺平县', '130600', '20');
INSERT INTO `ly_area` VALUES ('130637', '博野县', '130600', '21');
INSERT INTO `ly_area` VALUES ('130638', '雄　县', '130600', '22');
INSERT INTO `ly_area` VALUES ('130681', '涿州市', '130600', '23');
INSERT INTO `ly_area` VALUES ('130682', '定州市', '130600', '24');
INSERT INTO `ly_area` VALUES ('130683', '安国市', '130600', '25');
INSERT INTO `ly_area` VALUES ('130684', '高碑店市', '130600', '26');
INSERT INTO `ly_area` VALUES ('130701', '市辖区', '130700', '1');
INSERT INTO `ly_area` VALUES ('130702', '桥东区', '130700', '2');
INSERT INTO `ly_area` VALUES ('130703', '桥西区', '130700', '3');
INSERT INTO `ly_area` VALUES ('130705', '宣化区', '130700', '4');
INSERT INTO `ly_area` VALUES ('130706', '下花园区', '130700', '5');
INSERT INTO `ly_area` VALUES ('130721', '宣化县', '130700', '6');
INSERT INTO `ly_area` VALUES ('130722', '张北县', '130700', '7');
INSERT INTO `ly_area` VALUES ('130723', '康保县', '130700', '8');
INSERT INTO `ly_area` VALUES ('130724', '沽源县', '130700', '9');
INSERT INTO `ly_area` VALUES ('130725', '尚义县', '130700', '10');
INSERT INTO `ly_area` VALUES ('130726', '蔚　县', '130700', '11');
INSERT INTO `ly_area` VALUES ('130727', '阳原县', '130700', '12');
INSERT INTO `ly_area` VALUES ('130728', '怀安县', '130700', '13');
INSERT INTO `ly_area` VALUES ('130729', '万全县', '130700', '14');
INSERT INTO `ly_area` VALUES ('130730', '怀来县', '130700', '15');
INSERT INTO `ly_area` VALUES ('130731', '涿鹿县', '130700', '16');
INSERT INTO `ly_area` VALUES ('130732', '赤城县', '130700', '17');
INSERT INTO `ly_area` VALUES ('130733', '崇礼县', '130700', '18');
INSERT INTO `ly_area` VALUES ('130801', '市辖区', '130800', '1');
INSERT INTO `ly_area` VALUES ('130802', '双桥区', '130800', '2');
INSERT INTO `ly_area` VALUES ('130803', '双滦区', '130800', '3');
INSERT INTO `ly_area` VALUES ('130804', '鹰手营子矿区', '130800', '4');
INSERT INTO `ly_area` VALUES ('130821', '承德县', '130800', '5');
INSERT INTO `ly_area` VALUES ('130822', '兴隆县', '130800', '6');
INSERT INTO `ly_area` VALUES ('130823', '平泉县', '130800', '7');
INSERT INTO `ly_area` VALUES ('130824', '滦平县', '130800', '8');
INSERT INTO `ly_area` VALUES ('130825', '隆化县', '130800', '9');
INSERT INTO `ly_area` VALUES ('130826', '丰宁满族自治县', '130800', '10');
INSERT INTO `ly_area` VALUES ('130827', '宽城满族自治县', '130800', '11');
INSERT INTO `ly_area` VALUES ('130828', '围场满族蒙古族自治县', '130800', '12');
INSERT INTO `ly_area` VALUES ('130901', '市辖区', '130900', '1');
INSERT INTO `ly_area` VALUES ('130902', '新华区', '130900', '2');
INSERT INTO `ly_area` VALUES ('130903', '运河区', '130900', '3');
INSERT INTO `ly_area` VALUES ('130921', '沧　县', '130900', '4');
INSERT INTO `ly_area` VALUES ('130922', '青　县', '130900', '5');
INSERT INTO `ly_area` VALUES ('130923', '东光县', '130900', '6');
INSERT INTO `ly_area` VALUES ('130924', '海兴县', '130900', '7');
INSERT INTO `ly_area` VALUES ('130925', '盐山县', '130900', '8');
INSERT INTO `ly_area` VALUES ('130926', '肃宁县', '130900', '9');
INSERT INTO `ly_area` VALUES ('130927', '南皮县', '130900', '10');
INSERT INTO `ly_area` VALUES ('130928', '吴桥县', '130900', '11');
INSERT INTO `ly_area` VALUES ('130929', '献　县', '130900', '12');
INSERT INTO `ly_area` VALUES ('130930', '孟村回族自治县', '130900', '13');
INSERT INTO `ly_area` VALUES ('130981', '泊头市', '130900', '14');
INSERT INTO `ly_area` VALUES ('130982', '任丘市', '130900', '15');
INSERT INTO `ly_area` VALUES ('130983', '黄骅市', '130900', '16');
INSERT INTO `ly_area` VALUES ('130984', '河间市', '130900', '17');
INSERT INTO `ly_area` VALUES ('131001', '市辖区', '131000', '1');
INSERT INTO `ly_area` VALUES ('131002', '安次区', '131000', '2');
INSERT INTO `ly_area` VALUES ('131003', '广阳区', '131000', '3');
INSERT INTO `ly_area` VALUES ('131022', '固安县', '131000', '4');
INSERT INTO `ly_area` VALUES ('131023', '永清县', '131000', '5');
INSERT INTO `ly_area` VALUES ('131024', '香河县', '131000', '6');
INSERT INTO `ly_area` VALUES ('131025', '大城县', '131000', '7');
INSERT INTO `ly_area` VALUES ('131026', '文安县', '131000', '8');
INSERT INTO `ly_area` VALUES ('131028', '大厂回族自治县', '131000', '9');
INSERT INTO `ly_area` VALUES ('131081', '霸州市', '131000', '10');
INSERT INTO `ly_area` VALUES ('131082', '三河市', '131000', '11');
INSERT INTO `ly_area` VALUES ('131101', '市辖区', '131100', '1');
INSERT INTO `ly_area` VALUES ('131102', '桃城区', '131100', '2');
INSERT INTO `ly_area` VALUES ('131121', '枣强县', '131100', '3');
INSERT INTO `ly_area` VALUES ('131122', '武邑县', '131100', '4');
INSERT INTO `ly_area` VALUES ('131123', '武强县', '131100', '5');
INSERT INTO `ly_area` VALUES ('131124', '饶阳县', '131100', '6');
INSERT INTO `ly_area` VALUES ('131125', '安平县', '131100', '7');
INSERT INTO `ly_area` VALUES ('131126', '故城县', '131100', '8');
INSERT INTO `ly_area` VALUES ('131127', '景　县', '131100', '9');
INSERT INTO `ly_area` VALUES ('131128', '阜城县', '131100', '10');
INSERT INTO `ly_area` VALUES ('131181', '冀州市', '131100', '11');
INSERT INTO `ly_area` VALUES ('131182', '深州市', '131100', '12');
INSERT INTO `ly_area` VALUES ('140101', '市辖区', '140100', '1');
INSERT INTO `ly_area` VALUES ('140105', '小店区', '140100', '2');
INSERT INTO `ly_area` VALUES ('140106', '迎泽区', '140100', '3');
INSERT INTO `ly_area` VALUES ('140107', '杏花岭区', '140100', '4');
INSERT INTO `ly_area` VALUES ('140108', '尖草坪区', '140100', '5');
INSERT INTO `ly_area` VALUES ('140109', '万柏林区', '140100', '6');
INSERT INTO `ly_area` VALUES ('140110', '晋源区', '140100', '7');
INSERT INTO `ly_area` VALUES ('140121', '清徐县', '140100', '8');
INSERT INTO `ly_area` VALUES ('140122', '阳曲县', '140100', '9');
INSERT INTO `ly_area` VALUES ('140123', '娄烦县', '140100', '10');
INSERT INTO `ly_area` VALUES ('140181', '古交市', '140100', '11');
INSERT INTO `ly_area` VALUES ('140201', '市辖区', '140200', '1');
INSERT INTO `ly_area` VALUES ('140202', '城　区', '140200', '2');
INSERT INTO `ly_area` VALUES ('140203', '矿　区', '140200', '3');
INSERT INTO `ly_area` VALUES ('140211', '南郊区', '140200', '4');
INSERT INTO `ly_area` VALUES ('140212', '新荣区', '140200', '5');
INSERT INTO `ly_area` VALUES ('140221', '阳高县', '140200', '6');
INSERT INTO `ly_area` VALUES ('140222', '天镇县', '140200', '7');
INSERT INTO `ly_area` VALUES ('140223', '广灵县', '140200', '8');
INSERT INTO `ly_area` VALUES ('140224', '灵丘县', '140200', '9');
INSERT INTO `ly_area` VALUES ('140225', '浑源县', '140200', '10');
INSERT INTO `ly_area` VALUES ('140226', '左云县', '140200', '11');
INSERT INTO `ly_area` VALUES ('140227', '大同县', '140200', '12');
INSERT INTO `ly_area` VALUES ('140301', '市辖区', '140300', '1');
INSERT INTO `ly_area` VALUES ('140302', '城　区', '140300', '2');
INSERT INTO `ly_area` VALUES ('140303', '矿　区', '140300', '3');
INSERT INTO `ly_area` VALUES ('140311', '郊　区', '140300', '4');
INSERT INTO `ly_area` VALUES ('140321', '平定县', '140300', '5');
INSERT INTO `ly_area` VALUES ('140322', '盂　县', '140300', '6');
INSERT INTO `ly_area` VALUES ('140401', '市辖区', '140400', '1');
INSERT INTO `ly_area` VALUES ('140402', '城　区', '140400', '2');
INSERT INTO `ly_area` VALUES ('140411', '郊　区', '140400', '3');
INSERT INTO `ly_area` VALUES ('140421', '长治县', '140400', '4');
INSERT INTO `ly_area` VALUES ('140423', '襄垣县', '140400', '5');
INSERT INTO `ly_area` VALUES ('140424', '屯留县', '140400', '6');
INSERT INTO `ly_area` VALUES ('140425', '平顺县', '140400', '7');
INSERT INTO `ly_area` VALUES ('140426', '黎城县', '140400', '8');
INSERT INTO `ly_area` VALUES ('140427', '壶关县', '140400', '9');
INSERT INTO `ly_area` VALUES ('140428', '长子县', '140400', '10');
INSERT INTO `ly_area` VALUES ('140429', '武乡县', '140400', '11');
INSERT INTO `ly_area` VALUES ('140430', '沁　县', '140400', '12');
INSERT INTO `ly_area` VALUES ('140431', '沁源县', '140400', '13');
INSERT INTO `ly_area` VALUES ('140481', '潞城市', '140400', '14');
INSERT INTO `ly_area` VALUES ('140501', '市辖区', '140500', '1');
INSERT INTO `ly_area` VALUES ('140502', '城　区', '140500', '2');
INSERT INTO `ly_area` VALUES ('140521', '沁水县', '140500', '3');
INSERT INTO `ly_area` VALUES ('140522', '阳城县', '140500', '4');
INSERT INTO `ly_area` VALUES ('140524', '陵川县', '140500', '5');
INSERT INTO `ly_area` VALUES ('140525', '泽州县', '140500', '6');
INSERT INTO `ly_area` VALUES ('140581', '高平市', '140500', '7');
INSERT INTO `ly_area` VALUES ('140601', '市辖区', '140600', '1');
INSERT INTO `ly_area` VALUES ('140602', '朔城区', '140600', '2');
INSERT INTO `ly_area` VALUES ('140603', '平鲁区', '140600', '3');
INSERT INTO `ly_area` VALUES ('140621', '山阴县', '140600', '4');
INSERT INTO `ly_area` VALUES ('140622', '应　县', '140600', '5');
INSERT INTO `ly_area` VALUES ('140623', '右玉县', '140600', '6');
INSERT INTO `ly_area` VALUES ('140624', '怀仁县', '140600', '7');
INSERT INTO `ly_area` VALUES ('140701', '市辖区', '140700', '1');
INSERT INTO `ly_area` VALUES ('140702', '榆次区', '140700', '2');
INSERT INTO `ly_area` VALUES ('140721', '榆社县', '140700', '3');
INSERT INTO `ly_area` VALUES ('140722', '左权县', '140700', '4');
INSERT INTO `ly_area` VALUES ('140723', '和顺县', '140700', '5');
INSERT INTO `ly_area` VALUES ('140724', '昔阳县', '140700', '6');
INSERT INTO `ly_area` VALUES ('140725', '寿阳县', '140700', '7');
INSERT INTO `ly_area` VALUES ('140726', '太谷县', '140700', '8');
INSERT INTO `ly_area` VALUES ('140727', '祁　县', '140700', '9');
INSERT INTO `ly_area` VALUES ('140728', '平遥县', '140700', '10');
INSERT INTO `ly_area` VALUES ('140729', '灵石县', '140700', '11');
INSERT INTO `ly_area` VALUES ('140781', '介休市', '140700', '12');
INSERT INTO `ly_area` VALUES ('140801', '市辖区', '140800', '1');
INSERT INTO `ly_area` VALUES ('140802', '盐湖区', '140800', '2');
INSERT INTO `ly_area` VALUES ('140821', '临猗县', '140800', '3');
INSERT INTO `ly_area` VALUES ('140822', '万荣县', '140800', '4');
INSERT INTO `ly_area` VALUES ('140823', '闻喜县', '140800', '5');
INSERT INTO `ly_area` VALUES ('140824', '稷山县', '140800', '6');
INSERT INTO `ly_area` VALUES ('140825', '新绛县', '140800', '7');
INSERT INTO `ly_area` VALUES ('140826', '绛　县', '140800', '8');
INSERT INTO `ly_area` VALUES ('140827', '垣曲县', '140800', '9');
INSERT INTO `ly_area` VALUES ('140828', '夏　县', '140800', '10');
INSERT INTO `ly_area` VALUES ('140829', '平陆县', '140800', '11');
INSERT INTO `ly_area` VALUES ('140830', '芮城县', '140800', '12');
INSERT INTO `ly_area` VALUES ('140881', '永济市', '140800', '13');
INSERT INTO `ly_area` VALUES ('140882', '河津市', '140800', '14');
INSERT INTO `ly_area` VALUES ('140901', '市辖区', '140900', '1');
INSERT INTO `ly_area` VALUES ('140902', '忻府区', '140900', '2');
INSERT INTO `ly_area` VALUES ('140921', '定襄县', '140900', '3');
INSERT INTO `ly_area` VALUES ('140922', '五台县', '140900', '4');
INSERT INTO `ly_area` VALUES ('140923', '代　县', '140900', '5');
INSERT INTO `ly_area` VALUES ('140924', '繁峙县', '140900', '6');
INSERT INTO `ly_area` VALUES ('140925', '宁武县', '140900', '7');
INSERT INTO `ly_area` VALUES ('140926', '静乐县', '140900', '8');
INSERT INTO `ly_area` VALUES ('140927', '神池县', '140900', '9');
INSERT INTO `ly_area` VALUES ('140928', '五寨县', '140900', '10');
INSERT INTO `ly_area` VALUES ('140929', '岢岚县', '140900', '11');
INSERT INTO `ly_area` VALUES ('140930', '河曲县', '140900', '12');
INSERT INTO `ly_area` VALUES ('140931', '保德县', '140900', '13');
INSERT INTO `ly_area` VALUES ('140932', '偏关县', '140900', '14');
INSERT INTO `ly_area` VALUES ('140981', '原平市', '140900', '15');
INSERT INTO `ly_area` VALUES ('141001', '市辖区', '141000', '1');
INSERT INTO `ly_area` VALUES ('141002', '尧都区', '141000', '2');
INSERT INTO `ly_area` VALUES ('141021', '曲沃县', '141000', '3');
INSERT INTO `ly_area` VALUES ('141022', '翼城县', '141000', '4');
INSERT INTO `ly_area` VALUES ('141023', '襄汾县', '141000', '5');
INSERT INTO `ly_area` VALUES ('141024', '洪洞县', '141000', '6');
INSERT INTO `ly_area` VALUES ('141025', '古　县', '141000', '7');
INSERT INTO `ly_area` VALUES ('141026', '安泽县', '141000', '8');
INSERT INTO `ly_area` VALUES ('141027', '浮山县', '141000', '9');
INSERT INTO `ly_area` VALUES ('141028', '吉　县', '141000', '10');
INSERT INTO `ly_area` VALUES ('141029', '乡宁县', '141000', '11');
INSERT INTO `ly_area` VALUES ('141030', '大宁县', '141000', '12');
INSERT INTO `ly_area` VALUES ('141031', '隰　县', '141000', '13');
INSERT INTO `ly_area` VALUES ('141032', '永和县', '141000', '14');
INSERT INTO `ly_area` VALUES ('141033', '蒲　县', '141000', '15');
INSERT INTO `ly_area` VALUES ('141034', '汾西县', '141000', '16');
INSERT INTO `ly_area` VALUES ('141081', '侯马市', '141000', '17');
INSERT INTO `ly_area` VALUES ('141082', '霍州市', '141000', '18');
INSERT INTO `ly_area` VALUES ('141101', '市辖区', '141100', '1');
INSERT INTO `ly_area` VALUES ('141102', '离石区', '141100', '2');
INSERT INTO `ly_area` VALUES ('141121', '文水县', '141100', '3');
INSERT INTO `ly_area` VALUES ('141122', '交城县', '141100', '4');
INSERT INTO `ly_area` VALUES ('141123', '兴　县', '141100', '5');
INSERT INTO `ly_area` VALUES ('141124', '临　县', '141100', '6');
INSERT INTO `ly_area` VALUES ('141125', '柳林县', '141100', '7');
INSERT INTO `ly_area` VALUES ('141126', '石楼县', '141100', '8');
INSERT INTO `ly_area` VALUES ('141127', '岚　县', '141100', '9');
INSERT INTO `ly_area` VALUES ('141128', '方山县', '141100', '10');
INSERT INTO `ly_area` VALUES ('141129', '中阳县', '141100', '11');
INSERT INTO `ly_area` VALUES ('141130', '交口县', '141100', '12');
INSERT INTO `ly_area` VALUES ('141181', '孝义市', '141100', '13');
INSERT INTO `ly_area` VALUES ('141182', '汾阳市', '141100', '14');
INSERT INTO `ly_area` VALUES ('150101', '市辖区', '150100', '1');
INSERT INTO `ly_area` VALUES ('150102', '新城区', '150100', '2');
INSERT INTO `ly_area` VALUES ('150103', '回民区', '150100', '3');
INSERT INTO `ly_area` VALUES ('150104', '玉泉区', '150100', '4');
INSERT INTO `ly_area` VALUES ('150105', '赛罕区', '150100', '5');
INSERT INTO `ly_area` VALUES ('150121', '土默特左旗', '150100', '6');
INSERT INTO `ly_area` VALUES ('150122', '托克托县', '150100', '7');
INSERT INTO `ly_area` VALUES ('150123', '和林格尔县', '150100', '8');
INSERT INTO `ly_area` VALUES ('150124', '清水河县', '150100', '9');
INSERT INTO `ly_area` VALUES ('150125', '武川县', '150100', '10');
INSERT INTO `ly_area` VALUES ('150201', '市辖区', '150200', '1');
INSERT INTO `ly_area` VALUES ('150202', '东河区', '150200', '2');
INSERT INTO `ly_area` VALUES ('150203', '昆都仑区', '150200', '3');
INSERT INTO `ly_area` VALUES ('150204', '青山区', '150200', '4');
INSERT INTO `ly_area` VALUES ('150205', '石拐区', '150200', '5');
INSERT INTO `ly_area` VALUES ('150206', '白云矿区', '150200', '6');
INSERT INTO `ly_area` VALUES ('150207', '九原区', '150200', '7');
INSERT INTO `ly_area` VALUES ('150221', '土默特右旗', '150200', '8');
INSERT INTO `ly_area` VALUES ('150222', '固阳县', '150200', '9');
INSERT INTO `ly_area` VALUES ('150223', '达尔罕茂明安联合旗', '150200', '10');
INSERT INTO `ly_area` VALUES ('150301', '市辖区', '150300', '1');
INSERT INTO `ly_area` VALUES ('150302', '海勃湾区', '150300', '2');
INSERT INTO `ly_area` VALUES ('150303', '海南区', '150300', '3');
INSERT INTO `ly_area` VALUES ('150304', '乌达区', '150300', '4');
INSERT INTO `ly_area` VALUES ('150401', '市辖区', '150400', '1');
INSERT INTO `ly_area` VALUES ('150402', '红山区', '150400', '2');
INSERT INTO `ly_area` VALUES ('150403', '元宝山区', '150400', '3');
INSERT INTO `ly_area` VALUES ('150404', '松山区', '150400', '4');
INSERT INTO `ly_area` VALUES ('150421', '阿鲁科尔沁旗', '150400', '5');
INSERT INTO `ly_area` VALUES ('150422', '巴林左旗', '150400', '6');
INSERT INTO `ly_area` VALUES ('150423', '巴林右旗', '150400', '7');
INSERT INTO `ly_area` VALUES ('150424', '林西县', '150400', '8');
INSERT INTO `ly_area` VALUES ('150425', '克什克腾旗', '150400', '9');
INSERT INTO `ly_area` VALUES ('150426', '翁牛特旗', '150400', '10');
INSERT INTO `ly_area` VALUES ('150428', '喀喇沁旗', '150400', '11');
INSERT INTO `ly_area` VALUES ('150429', '宁城县', '150400', '12');
INSERT INTO `ly_area` VALUES ('150430', '敖汉旗', '150400', '13');
INSERT INTO `ly_area` VALUES ('150501', '市辖区', '150500', '1');
INSERT INTO `ly_area` VALUES ('150502', '科尔沁区', '150500', '2');
INSERT INTO `ly_area` VALUES ('150521', '科尔沁左翼中旗', '150500', '3');
INSERT INTO `ly_area` VALUES ('150522', '科尔沁左翼后旗', '150500', '4');
INSERT INTO `ly_area` VALUES ('150523', '开鲁县', '150500', '5');
INSERT INTO `ly_area` VALUES ('150524', '库伦旗', '150500', '6');
INSERT INTO `ly_area` VALUES ('150525', '奈曼旗', '150500', '7');
INSERT INTO `ly_area` VALUES ('150526', '扎鲁特旗', '150500', '8');
INSERT INTO `ly_area` VALUES ('150581', '霍林郭勒市', '150500', '9');
INSERT INTO `ly_area` VALUES ('150602', '东胜区', '150600', '1');
INSERT INTO `ly_area` VALUES ('150621', '达拉特旗', '150600', '2');
INSERT INTO `ly_area` VALUES ('150622', '准格尔旗', '150600', '3');
INSERT INTO `ly_area` VALUES ('150623', '鄂托克前旗', '150600', '4');
INSERT INTO `ly_area` VALUES ('150624', '鄂托克旗', '150600', '5');
INSERT INTO `ly_area` VALUES ('150625', '杭锦旗', '150600', '6');
INSERT INTO `ly_area` VALUES ('150626', '乌审旗', '150600', '7');
INSERT INTO `ly_area` VALUES ('150627', '伊金霍洛旗', '150600', '8');
INSERT INTO `ly_area` VALUES ('150701', '市辖区', '150700', '1');
INSERT INTO `ly_area` VALUES ('150702', '海拉尔区', '150700', '2');
INSERT INTO `ly_area` VALUES ('150721', '阿荣旗', '150700', '3');
INSERT INTO `ly_area` VALUES ('150722', '莫力达瓦达斡尔族自治旗', '150700', '4');
INSERT INTO `ly_area` VALUES ('150723', '鄂伦春自治旗', '150700', '5');
INSERT INTO `ly_area` VALUES ('150724', '鄂温克族自治旗', '150700', '6');
INSERT INTO `ly_area` VALUES ('150725', '陈巴尔虎旗', '150700', '7');
INSERT INTO `ly_area` VALUES ('150726', '新巴尔虎左旗', '150700', '8');
INSERT INTO `ly_area` VALUES ('150727', '新巴尔虎右旗', '150700', '9');
INSERT INTO `ly_area` VALUES ('150781', '满洲里市', '150700', '10');
INSERT INTO `ly_area` VALUES ('150782', '牙克石市', '150700', '11');
INSERT INTO `ly_area` VALUES ('150783', '扎兰屯市', '150700', '12');
INSERT INTO `ly_area` VALUES ('150784', '额尔古纳市', '150700', '13');
INSERT INTO `ly_area` VALUES ('150785', '根河市', '150700', '14');
INSERT INTO `ly_area` VALUES ('150801', '市辖区', '150800', '1');
INSERT INTO `ly_area` VALUES ('150802', '临河区', '150800', '2');
INSERT INTO `ly_area` VALUES ('150821', '五原县', '150800', '3');
INSERT INTO `ly_area` VALUES ('150822', '磴口县', '150800', '4');
INSERT INTO `ly_area` VALUES ('150823', '乌拉特前旗', '150800', '5');
INSERT INTO `ly_area` VALUES ('150824', '乌拉特中旗', '150800', '6');
INSERT INTO `ly_area` VALUES ('150825', '乌拉特后旗', '150800', '7');
INSERT INTO `ly_area` VALUES ('150826', '杭锦后旗', '150800', '8');
INSERT INTO `ly_area` VALUES ('150901', '市辖区', '150900', '1');
INSERT INTO `ly_area` VALUES ('150902', '集宁区', '150900', '2');
INSERT INTO `ly_area` VALUES ('150921', '卓资县', '150900', '3');
INSERT INTO `ly_area` VALUES ('150922', '化德县', '150900', '4');
INSERT INTO `ly_area` VALUES ('150923', '商都县', '150900', '5');
INSERT INTO `ly_area` VALUES ('150924', '兴和县', '150900', '6');
INSERT INTO `ly_area` VALUES ('150925', '凉城县', '150900', '7');
INSERT INTO `ly_area` VALUES ('150926', '察哈尔右翼前旗', '150900', '8');
INSERT INTO `ly_area` VALUES ('150927', '察哈尔右翼中旗', '150900', '9');
INSERT INTO `ly_area` VALUES ('150928', '察哈尔右翼后旗', '150900', '10');
INSERT INTO `ly_area` VALUES ('150929', '四子王旗', '150900', '11');
INSERT INTO `ly_area` VALUES ('150981', '丰镇市', '150900', '12');
INSERT INTO `ly_area` VALUES ('152201', '乌兰浩特市', '152200', '1');
INSERT INTO `ly_area` VALUES ('152202', '阿尔山市', '152200', '2');
INSERT INTO `ly_area` VALUES ('152221', '科尔沁右翼前旗', '152200', '3');
INSERT INTO `ly_area` VALUES ('152222', '科尔沁右翼中旗', '152200', '4');
INSERT INTO `ly_area` VALUES ('152223', '扎赉特旗', '152200', '5');
INSERT INTO `ly_area` VALUES ('152224', '突泉县', '152200', '6');
INSERT INTO `ly_area` VALUES ('152501', '二连浩特市', '152500', '1');
INSERT INTO `ly_area` VALUES ('152502', '锡林浩特市', '152500', '2');
INSERT INTO `ly_area` VALUES ('152522', '阿巴嘎旗', '152500', '3');
INSERT INTO `ly_area` VALUES ('152523', '苏尼特左旗', '152500', '4');
INSERT INTO `ly_area` VALUES ('152524', '苏尼特右旗', '152500', '5');
INSERT INTO `ly_area` VALUES ('152525', '东乌珠穆沁旗', '152500', '6');
INSERT INTO `ly_area` VALUES ('152526', '西乌珠穆沁旗', '152500', '7');
INSERT INTO `ly_area` VALUES ('152527', '太仆寺旗', '152500', '8');
INSERT INTO `ly_area` VALUES ('152528', '镶黄旗', '152500', '9');
INSERT INTO `ly_area` VALUES ('152529', '正镶白旗', '152500', '10');
INSERT INTO `ly_area` VALUES ('152530', '正蓝旗', '152500', '11');
INSERT INTO `ly_area` VALUES ('152531', '多伦县', '152500', '12');
INSERT INTO `ly_area` VALUES ('152921', '阿拉善左旗', '152900', '1');
INSERT INTO `ly_area` VALUES ('152922', '阿拉善右旗', '152900', '2');
INSERT INTO `ly_area` VALUES ('152923', '额济纳旗', '152900', '3');
INSERT INTO `ly_area` VALUES ('210101', '市辖区', '210100', '1');
INSERT INTO `ly_area` VALUES ('210102', '和平区', '210100', '2');
INSERT INTO `ly_area` VALUES ('210103', '沈河区', '210100', '3');
INSERT INTO `ly_area` VALUES ('210104', '大东区', '210100', '4');
INSERT INTO `ly_area` VALUES ('210105', '皇姑区', '210100', '5');
INSERT INTO `ly_area` VALUES ('210106', '铁西区', '210100', '6');
INSERT INTO `ly_area` VALUES ('210111', '苏家屯区', '210100', '7');
INSERT INTO `ly_area` VALUES ('210112', '东陵区', '210100', '8');
INSERT INTO `ly_area` VALUES ('210113', '新城子区', '210100', '9');
INSERT INTO `ly_area` VALUES ('210114', '于洪区', '210100', '10');
INSERT INTO `ly_area` VALUES ('210122', '辽中县', '210100', '11');
INSERT INTO `ly_area` VALUES ('210123', '康平县', '210100', '12');
INSERT INTO `ly_area` VALUES ('210124', '法库县', '210100', '13');
INSERT INTO `ly_area` VALUES ('210181', '新民市', '210100', '14');
INSERT INTO `ly_area` VALUES ('210201', '市辖区', '210200', '1');
INSERT INTO `ly_area` VALUES ('210202', '中山区', '210200', '2');
INSERT INTO `ly_area` VALUES ('210203', '西岗区', '210200', '3');
INSERT INTO `ly_area` VALUES ('210204', '沙河口区', '210200', '4');
INSERT INTO `ly_area` VALUES ('210211', '甘井子区', '210200', '5');
INSERT INTO `ly_area` VALUES ('210212', '旅顺口区', '210200', '6');
INSERT INTO `ly_area` VALUES ('210213', '金州区', '210200', '7');
INSERT INTO `ly_area` VALUES ('210224', '长海县', '210200', '8');
INSERT INTO `ly_area` VALUES ('210281', '瓦房店市', '210200', '9');
INSERT INTO `ly_area` VALUES ('210282', '普兰店市', '210200', '10');
INSERT INTO `ly_area` VALUES ('210283', '庄河市', '210200', '11');
INSERT INTO `ly_area` VALUES ('210301', '市辖区', '210300', '1');
INSERT INTO `ly_area` VALUES ('210302', '铁东区', '210300', '2');
INSERT INTO `ly_area` VALUES ('210303', '铁西区', '210300', '3');
INSERT INTO `ly_area` VALUES ('210304', '立山区', '210300', '4');
INSERT INTO `ly_area` VALUES ('210311', '千山区', '210300', '5');
INSERT INTO `ly_area` VALUES ('210321', '台安县', '210300', '6');
INSERT INTO `ly_area` VALUES ('210323', '岫岩满族自治县', '210300', '7');
INSERT INTO `ly_area` VALUES ('210381', '海城市', '210300', '8');
INSERT INTO `ly_area` VALUES ('210401', '市辖区', '210400', '1');
INSERT INTO `ly_area` VALUES ('210402', '新抚区', '210400', '2');
INSERT INTO `ly_area` VALUES ('210403', '东洲区', '210400', '3');
INSERT INTO `ly_area` VALUES ('210404', '望花区', '210400', '4');
INSERT INTO `ly_area` VALUES ('210411', '顺城区', '210400', '5');
INSERT INTO `ly_area` VALUES ('210421', '抚顺县', '210400', '6');
INSERT INTO `ly_area` VALUES ('210422', '新宾满族自治县', '210400', '7');
INSERT INTO `ly_area` VALUES ('210423', '清原满族自治县', '210400', '8');
INSERT INTO `ly_area` VALUES ('210501', '市辖区', '210500', '1');
INSERT INTO `ly_area` VALUES ('210502', '平山区', '210500', '2');
INSERT INTO `ly_area` VALUES ('210503', '溪湖区', '210500', '3');
INSERT INTO `ly_area` VALUES ('210504', '明山区', '210500', '4');
INSERT INTO `ly_area` VALUES ('210505', '南芬区', '210500', '5');
INSERT INTO `ly_area` VALUES ('210521', '本溪满族自治县', '210500', '6');
INSERT INTO `ly_area` VALUES ('210522', '桓仁满族自治县', '210500', '7');
INSERT INTO `ly_area` VALUES ('210601', '市辖区', '210600', '1');
INSERT INTO `ly_area` VALUES ('210602', '元宝区', '210600', '2');
INSERT INTO `ly_area` VALUES ('210603', '振兴区', '210600', '3');
INSERT INTO `ly_area` VALUES ('210604', '振安区', '210600', '4');
INSERT INTO `ly_area` VALUES ('210624', '宽甸满族自治县', '210600', '5');
INSERT INTO `ly_area` VALUES ('210681', '东港市', '210600', '6');
INSERT INTO `ly_area` VALUES ('210682', '凤城市', '210600', '7');
INSERT INTO `ly_area` VALUES ('210701', '市辖区', '210700', '1');
INSERT INTO `ly_area` VALUES ('210702', '古塔区', '210700', '2');
INSERT INTO `ly_area` VALUES ('210703', '凌河区', '210700', '3');
INSERT INTO `ly_area` VALUES ('210711', '太和区', '210700', '4');
INSERT INTO `ly_area` VALUES ('210726', '黑山县', '210700', '5');
INSERT INTO `ly_area` VALUES ('210727', '义　县', '210700', '6');
INSERT INTO `ly_area` VALUES ('210781', '凌海市', '210700', '7');
INSERT INTO `ly_area` VALUES ('210782', '北宁市', '210700', '8');
INSERT INTO `ly_area` VALUES ('210801', '市辖区', '210800', '1');
INSERT INTO `ly_area` VALUES ('210802', '站前区', '210800', '2');
INSERT INTO `ly_area` VALUES ('210803', '西市区', '210800', '3');
INSERT INTO `ly_area` VALUES ('210804', '鲅鱼圈区', '210800', '4');
INSERT INTO `ly_area` VALUES ('210811', '老边区', '210800', '5');
INSERT INTO `ly_area` VALUES ('210881', '盖州市', '210800', '6');
INSERT INTO `ly_area` VALUES ('210882', '大石桥市', '210800', '7');
INSERT INTO `ly_area` VALUES ('210901', '市辖区', '210900', '1');
INSERT INTO `ly_area` VALUES ('210902', '海州区', '210900', '2');
INSERT INTO `ly_area` VALUES ('210903', '新邱区', '210900', '3');
INSERT INTO `ly_area` VALUES ('210904', '太平区', '210900', '4');
INSERT INTO `ly_area` VALUES ('210905', '清河门区', '210900', '5');
INSERT INTO `ly_area` VALUES ('210911', '细河区', '210900', '6');
INSERT INTO `ly_area` VALUES ('210921', '阜新蒙古族自治县', '210900', '7');
INSERT INTO `ly_area` VALUES ('210922', '彰武县', '210900', '8');
INSERT INTO `ly_area` VALUES ('211001', '市辖区', '211000', '1');
INSERT INTO `ly_area` VALUES ('211002', '白塔区', '211000', '2');
INSERT INTO `ly_area` VALUES ('211003', '文圣区', '211000', '3');
INSERT INTO `ly_area` VALUES ('211004', '宏伟区', '211000', '4');
INSERT INTO `ly_area` VALUES ('211005', '弓长岭区', '211000', '5');
INSERT INTO `ly_area` VALUES ('211011', '太子河区', '211000', '6');
INSERT INTO `ly_area` VALUES ('211021', '辽阳县', '211000', '7');
INSERT INTO `ly_area` VALUES ('211081', '灯塔市', '211000', '8');
INSERT INTO `ly_area` VALUES ('211101', '市辖区', '211100', '1');
INSERT INTO `ly_area` VALUES ('211102', '双台子区', '211100', '2');
INSERT INTO `ly_area` VALUES ('211103', '兴隆台区', '211100', '3');
INSERT INTO `ly_area` VALUES ('211121', '大洼县', '211100', '4');
INSERT INTO `ly_area` VALUES ('211122', '盘山县', '211100', '5');
INSERT INTO `ly_area` VALUES ('211201', '市辖区', '211200', '1');
INSERT INTO `ly_area` VALUES ('211202', '银州区', '211200', '2');
INSERT INTO `ly_area` VALUES ('211204', '清河区', '211200', '3');
INSERT INTO `ly_area` VALUES ('211221', '铁岭县', '211200', '4');
INSERT INTO `ly_area` VALUES ('211223', '西丰县', '211200', '5');
INSERT INTO `ly_area` VALUES ('211224', '昌图县', '211200', '6');
INSERT INTO `ly_area` VALUES ('211281', '调兵山市', '211200', '7');
INSERT INTO `ly_area` VALUES ('211282', '开原市', '211200', '8');
INSERT INTO `ly_area` VALUES ('211301', '市辖区', '211300', '1');
INSERT INTO `ly_area` VALUES ('211302', '双塔区', '211300', '2');
INSERT INTO `ly_area` VALUES ('211303', '龙城区', '211300', '3');
INSERT INTO `ly_area` VALUES ('211321', '朝阳县', '211300', '4');
INSERT INTO `ly_area` VALUES ('211322', '建平县', '211300', '5');
INSERT INTO `ly_area` VALUES ('211324', '喀喇沁左翼蒙古族自治县', '211300', '6');
INSERT INTO `ly_area` VALUES ('211381', '北票市', '211300', '7');
INSERT INTO `ly_area` VALUES ('211382', '凌源市', '211300', '8');
INSERT INTO `ly_area` VALUES ('211401', '市辖区', '211400', '1');
INSERT INTO `ly_area` VALUES ('211402', '连山区', '211400', '2');
INSERT INTO `ly_area` VALUES ('211403', '龙港区', '211400', '3');
INSERT INTO `ly_area` VALUES ('211404', '南票区', '211400', '4');
INSERT INTO `ly_area` VALUES ('211421', '绥中县', '211400', '5');
INSERT INTO `ly_area` VALUES ('211422', '建昌县', '211400', '6');
INSERT INTO `ly_area` VALUES ('211481', '兴城市', '211400', '7');
INSERT INTO `ly_area` VALUES ('220101', '市辖区', '220100', '1');
INSERT INTO `ly_area` VALUES ('220102', '南关区', '220100', '2');
INSERT INTO `ly_area` VALUES ('220103', '宽城区', '220100', '3');
INSERT INTO `ly_area` VALUES ('220104', '朝阳区', '220100', '4');
INSERT INTO `ly_area` VALUES ('220105', '二道区', '220100', '5');
INSERT INTO `ly_area` VALUES ('220106', '绿园区', '220100', '6');
INSERT INTO `ly_area` VALUES ('220112', '双阳区', '220100', '7');
INSERT INTO `ly_area` VALUES ('220122', '农安县', '220100', '8');
INSERT INTO `ly_area` VALUES ('220181', '九台市', '220100', '9');
INSERT INTO `ly_area` VALUES ('220182', '榆树市', '220100', '10');
INSERT INTO `ly_area` VALUES ('220183', '德惠市', '220100', '11');
INSERT INTO `ly_area` VALUES ('220201', '市辖区', '220200', '1');
INSERT INTO `ly_area` VALUES ('220202', '昌邑区', '220200', '2');
INSERT INTO `ly_area` VALUES ('220203', '龙潭区', '220200', '3');
INSERT INTO `ly_area` VALUES ('220204', '船营区', '220200', '4');
INSERT INTO `ly_area` VALUES ('220211', '丰满区', '220200', '5');
INSERT INTO `ly_area` VALUES ('220221', '永吉县', '220200', '6');
INSERT INTO `ly_area` VALUES ('220281', '蛟河市', '220200', '7');
INSERT INTO `ly_area` VALUES ('220282', '桦甸市', '220200', '8');
INSERT INTO `ly_area` VALUES ('220283', '舒兰市', '220200', '9');
INSERT INTO `ly_area` VALUES ('220284', '磐石市', '220200', '10');
INSERT INTO `ly_area` VALUES ('220301', '市辖区', '220300', '1');
INSERT INTO `ly_area` VALUES ('220302', '铁西区', '220300', '2');
INSERT INTO `ly_area` VALUES ('220303', '铁东区', '220300', '3');
INSERT INTO `ly_area` VALUES ('220322', '梨树县', '220300', '4');
INSERT INTO `ly_area` VALUES ('220323', '伊通满族自治县', '220300', '5');
INSERT INTO `ly_area` VALUES ('220381', '公主岭市', '220300', '6');
INSERT INTO `ly_area` VALUES ('220382', '双辽市', '220300', '7');
INSERT INTO `ly_area` VALUES ('220401', '市辖区', '220400', '1');
INSERT INTO `ly_area` VALUES ('220402', '龙山区', '220400', '2');
INSERT INTO `ly_area` VALUES ('220403', '西安区', '220400', '3');
INSERT INTO `ly_area` VALUES ('220421', '东丰县', '220400', '4');
INSERT INTO `ly_area` VALUES ('220422', '东辽县', '220400', '5');
INSERT INTO `ly_area` VALUES ('220501', '市辖区', '220500', '1');
INSERT INTO `ly_area` VALUES ('220502', '东昌区', '220500', '2');
INSERT INTO `ly_area` VALUES ('220503', '二道江区', '220500', '3');
INSERT INTO `ly_area` VALUES ('220521', '通化县', '220500', '4');
INSERT INTO `ly_area` VALUES ('220523', '辉南县', '220500', '5');
INSERT INTO `ly_area` VALUES ('220524', '柳河县', '220500', '6');
INSERT INTO `ly_area` VALUES ('220581', '梅河口市', '220500', '7');
INSERT INTO `ly_area` VALUES ('220582', '集安市', '220500', '8');
INSERT INTO `ly_area` VALUES ('220601', '市辖区', '220600', '1');
INSERT INTO `ly_area` VALUES ('220602', '八道江区', '220600', '2');
INSERT INTO `ly_area` VALUES ('220621', '抚松县', '220600', '3');
INSERT INTO `ly_area` VALUES ('220622', '靖宇县', '220600', '4');
INSERT INTO `ly_area` VALUES ('220623', '长白朝鲜族自治县', '220600', '5');
INSERT INTO `ly_area` VALUES ('220625', '江源县', '220600', '6');
INSERT INTO `ly_area` VALUES ('220681', '临江市', '220600', '7');
INSERT INTO `ly_area` VALUES ('220701', '市辖区', '220700', '1');
INSERT INTO `ly_area` VALUES ('220702', '宁江区', '220700', '2');
INSERT INTO `ly_area` VALUES ('220721', '前郭尔罗斯蒙古族自治县', '220700', '3');
INSERT INTO `ly_area` VALUES ('220722', '长岭县', '220700', '4');
INSERT INTO `ly_area` VALUES ('220723', '乾安县', '220700', '5');
INSERT INTO `ly_area` VALUES ('220724', '扶余县', '220700', '6');
INSERT INTO `ly_area` VALUES ('220801', '市辖区', '220800', '1');
INSERT INTO `ly_area` VALUES ('220802', '洮北区', '220800', '2');
INSERT INTO `ly_area` VALUES ('220821', '镇赉县', '220800', '3');
INSERT INTO `ly_area` VALUES ('220822', '通榆县', '220800', '4');
INSERT INTO `ly_area` VALUES ('220881', '洮南市', '220800', '5');
INSERT INTO `ly_area` VALUES ('220882', '大安市', '220800', '6');
INSERT INTO `ly_area` VALUES ('222401', '延吉市', '222400', '1');
INSERT INTO `ly_area` VALUES ('222402', '图们市', '222400', '2');
INSERT INTO `ly_area` VALUES ('222403', '敦化市', '222400', '3');
INSERT INTO `ly_area` VALUES ('222404', '珲春市', '222400', '4');
INSERT INTO `ly_area` VALUES ('222405', '龙井市', '222400', '5');
INSERT INTO `ly_area` VALUES ('222406', '和龙市', '222400', '6');
INSERT INTO `ly_area` VALUES ('222424', '汪清县', '222400', '7');
INSERT INTO `ly_area` VALUES ('222426', '安图县', '222400', '8');
INSERT INTO `ly_area` VALUES ('230101', '市辖区', '230100', '1');
INSERT INTO `ly_area` VALUES ('230102', '道里区', '230100', '2');
INSERT INTO `ly_area` VALUES ('230103', '南岗区', '230100', '3');
INSERT INTO `ly_area` VALUES ('230104', '道外区', '230100', '4');
INSERT INTO `ly_area` VALUES ('230106', '香坊区', '230100', '5');
INSERT INTO `ly_area` VALUES ('230107', '动力区', '230100', '6');
INSERT INTO `ly_area` VALUES ('230108', '平房区', '230100', '7');
INSERT INTO `ly_area` VALUES ('230109', '松北区', '230100', '8');
INSERT INTO `ly_area` VALUES ('230111', '呼兰区', '230100', '9');
INSERT INTO `ly_area` VALUES ('230123', '依兰县', '230100', '10');
INSERT INTO `ly_area` VALUES ('230124', '方正县', '230100', '11');
INSERT INTO `ly_area` VALUES ('230125', '宾　县', '230100', '12');
INSERT INTO `ly_area` VALUES ('230126', '巴彦县', '230100', '13');
INSERT INTO `ly_area` VALUES ('230127', '木兰县', '230100', '14');
INSERT INTO `ly_area` VALUES ('230128', '通河县', '230100', '15');
INSERT INTO `ly_area` VALUES ('230129', '延寿县', '230100', '16');
INSERT INTO `ly_area` VALUES ('230181', '阿城市', '230100', '17');
INSERT INTO `ly_area` VALUES ('230182', '双城市', '230100', '18');
INSERT INTO `ly_area` VALUES ('230183', '尚志市', '230100', '19');
INSERT INTO `ly_area` VALUES ('230184', '五常市', '230100', '20');
INSERT INTO `ly_area` VALUES ('230201', '市辖区', '230200', '1');
INSERT INTO `ly_area` VALUES ('230202', '龙沙区', '230200', '2');
INSERT INTO `ly_area` VALUES ('230203', '建华区', '230200', '3');
INSERT INTO `ly_area` VALUES ('230204', '铁锋区', '230200', '4');
INSERT INTO `ly_area` VALUES ('230205', '昂昂溪区', '230200', '5');
INSERT INTO `ly_area` VALUES ('230206', '富拉尔基区', '230200', '6');
INSERT INTO `ly_area` VALUES ('230207', '碾子山区', '230200', '7');
INSERT INTO `ly_area` VALUES ('230208', '梅里斯达斡尔族区', '230200', '8');
INSERT INTO `ly_area` VALUES ('230221', '龙江县', '230200', '9');
INSERT INTO `ly_area` VALUES ('230223', '依安县', '230200', '10');
INSERT INTO `ly_area` VALUES ('230224', '泰来县', '230200', '11');
INSERT INTO `ly_area` VALUES ('230225', '甘南县', '230200', '12');
INSERT INTO `ly_area` VALUES ('230227', '富裕县', '230200', '13');
INSERT INTO `ly_area` VALUES ('230229', '克山县', '230200', '14');
INSERT INTO `ly_area` VALUES ('230230', '克东县', '230200', '15');
INSERT INTO `ly_area` VALUES ('230231', '拜泉县', '230200', '16');
INSERT INTO `ly_area` VALUES ('230281', '讷河市', '230200', '17');
INSERT INTO `ly_area` VALUES ('230301', '市辖区', '230300', '1');
INSERT INTO `ly_area` VALUES ('230302', '鸡冠区', '230300', '2');
INSERT INTO `ly_area` VALUES ('230303', '恒山区', '230300', '3');
INSERT INTO `ly_area` VALUES ('230304', '滴道区', '230300', '4');
INSERT INTO `ly_area` VALUES ('230305', '梨树区', '230300', '5');
INSERT INTO `ly_area` VALUES ('230306', '城子河区', '230300', '6');
INSERT INTO `ly_area` VALUES ('230307', '麻山区', '230300', '7');
INSERT INTO `ly_area` VALUES ('230321', '鸡东县', '230300', '8');
INSERT INTO `ly_area` VALUES ('230381', '虎林市', '230300', '9');
INSERT INTO `ly_area` VALUES ('230382', '密山市', '230300', '10');
INSERT INTO `ly_area` VALUES ('230401', '市辖区', '230400', '1');
INSERT INTO `ly_area` VALUES ('230402', '向阳区', '230400', '2');
INSERT INTO `ly_area` VALUES ('230403', '工农区', '230400', '3');
INSERT INTO `ly_area` VALUES ('230404', '南山区', '230400', '4');
INSERT INTO `ly_area` VALUES ('230405', '兴安区', '230400', '5');
INSERT INTO `ly_area` VALUES ('230406', '东山区', '230400', '6');
INSERT INTO `ly_area` VALUES ('230407', '兴山区', '230400', '7');
INSERT INTO `ly_area` VALUES ('230421', '萝北县', '230400', '8');
INSERT INTO `ly_area` VALUES ('230422', '绥滨县', '230400', '9');
INSERT INTO `ly_area` VALUES ('230501', '市辖区', '230500', '1');
INSERT INTO `ly_area` VALUES ('230502', '尖山区', '230500', '2');
INSERT INTO `ly_area` VALUES ('230503', '岭东区', '230500', '3');
INSERT INTO `ly_area` VALUES ('230505', '四方台区', '230500', '4');
INSERT INTO `ly_area` VALUES ('230506', '宝山区', '230500', '5');
INSERT INTO `ly_area` VALUES ('230521', '集贤县', '230500', '6');
INSERT INTO `ly_area` VALUES ('230522', '友谊县', '230500', '7');
INSERT INTO `ly_area` VALUES ('230523', '宝清县', '230500', '8');
INSERT INTO `ly_area` VALUES ('230524', '饶河县', '230500', '9');
INSERT INTO `ly_area` VALUES ('230601', '市辖区', '230600', '1');
INSERT INTO `ly_area` VALUES ('230602', '萨尔图区', '230600', '2');
INSERT INTO `ly_area` VALUES ('230603', '龙凤区', '230600', '3');
INSERT INTO `ly_area` VALUES ('230604', '让胡路区', '230600', '4');
INSERT INTO `ly_area` VALUES ('230605', '红岗区', '230600', '5');
INSERT INTO `ly_area` VALUES ('230606', '大同区', '230600', '6');
INSERT INTO `ly_area` VALUES ('230621', '肇州县', '230600', '7');
INSERT INTO `ly_area` VALUES ('230622', '肇源县', '230600', '8');
INSERT INTO `ly_area` VALUES ('230623', '林甸县', '230600', '9');
INSERT INTO `ly_area` VALUES ('230624', '杜尔伯特蒙古族自治县', '230600', '10');
INSERT INTO `ly_area` VALUES ('230701', '市辖区', '230700', '1');
INSERT INTO `ly_area` VALUES ('230702', '伊春区', '230700', '2');
INSERT INTO `ly_area` VALUES ('230703', '南岔区', '230700', '3');
INSERT INTO `ly_area` VALUES ('230704', '友好区', '230700', '4');
INSERT INTO `ly_area` VALUES ('230705', '西林区', '230700', '5');
INSERT INTO `ly_area` VALUES ('230706', '翠峦区', '230700', '6');
INSERT INTO `ly_area` VALUES ('230707', '新青区', '230700', '7');
INSERT INTO `ly_area` VALUES ('230708', '美溪区', '230700', '8');
INSERT INTO `ly_area` VALUES ('230709', '金山屯区', '230700', '9');
INSERT INTO `ly_area` VALUES ('230710', '五营区', '230700', '10');
INSERT INTO `ly_area` VALUES ('230711', '乌马河区', '230700', '11');
INSERT INTO `ly_area` VALUES ('230712', '汤旺河区', '230700', '12');
INSERT INTO `ly_area` VALUES ('230713', '带岭区', '230700', '13');
INSERT INTO `ly_area` VALUES ('230714', '乌伊岭区', '230700', '14');
INSERT INTO `ly_area` VALUES ('230715', '红星区', '230700', '15');
INSERT INTO `ly_area` VALUES ('230716', '上甘岭区', '230700', '16');
INSERT INTO `ly_area` VALUES ('230722', '嘉荫县', '230700', '17');
INSERT INTO `ly_area` VALUES ('230781', '铁力市', '230700', '18');
INSERT INTO `ly_area` VALUES ('230801', '市辖区', '230800', '1');
INSERT INTO `ly_area` VALUES ('230802', '永红区', '230800', '2');
INSERT INTO `ly_area` VALUES ('230803', '向阳区', '230800', '3');
INSERT INTO `ly_area` VALUES ('230804', '前进区', '230800', '4');
INSERT INTO `ly_area` VALUES ('230805', '东风区', '230800', '5');
INSERT INTO `ly_area` VALUES ('230811', '郊　区', '230800', '6');
INSERT INTO `ly_area` VALUES ('230822', '桦南县', '230800', '7');
INSERT INTO `ly_area` VALUES ('230826', '桦川县', '230800', '8');
INSERT INTO `ly_area` VALUES ('230828', '汤原县', '230800', '9');
INSERT INTO `ly_area` VALUES ('230833', '抚远县', '230800', '10');
INSERT INTO `ly_area` VALUES ('230881', '同江市', '230800', '11');
INSERT INTO `ly_area` VALUES ('230882', '富锦市', '230800', '12');
INSERT INTO `ly_area` VALUES ('230901', '市辖区', '230900', '1');
INSERT INTO `ly_area` VALUES ('230902', '新兴区', '230900', '2');
INSERT INTO `ly_area` VALUES ('230903', '桃山区', '230900', '3');
INSERT INTO `ly_area` VALUES ('230904', '茄子河区', '230900', '4');
INSERT INTO `ly_area` VALUES ('230921', '勃利县', '230900', '5');
INSERT INTO `ly_area` VALUES ('231001', '市辖区', '231000', '1');
INSERT INTO `ly_area` VALUES ('231002', '东安区', '231000', '2');
INSERT INTO `ly_area` VALUES ('231003', '阳明区', '231000', '3');
INSERT INTO `ly_area` VALUES ('231004', '爱民区', '231000', '4');
INSERT INTO `ly_area` VALUES ('231005', '西安区', '231000', '5');
INSERT INTO `ly_area` VALUES ('231024', '东宁县', '231000', '6');
INSERT INTO `ly_area` VALUES ('231025', '林口县', '231000', '7');
INSERT INTO `ly_area` VALUES ('231081', '绥芬河市', '231000', '8');
INSERT INTO `ly_area` VALUES ('231083', '海林市', '231000', '9');
INSERT INTO `ly_area` VALUES ('231084', '宁安市', '231000', '10');
INSERT INTO `ly_area` VALUES ('231085', '穆棱市', '231000', '11');
INSERT INTO `ly_area` VALUES ('231101', '市辖区', '231100', '1');
INSERT INTO `ly_area` VALUES ('231102', '爱辉区', '231100', '2');
INSERT INTO `ly_area` VALUES ('231121', '嫩江县', '231100', '3');
INSERT INTO `ly_area` VALUES ('231123', '逊克县', '231100', '4');
INSERT INTO `ly_area` VALUES ('231124', '孙吴县', '231100', '5');
INSERT INTO `ly_area` VALUES ('231181', '北安市', '231100', '6');
INSERT INTO `ly_area` VALUES ('231182', '五大连池市', '231100', '7');
INSERT INTO `ly_area` VALUES ('231201', '市辖区', '231200', '1');
INSERT INTO `ly_area` VALUES ('231202', '北林区', '231200', '2');
INSERT INTO `ly_area` VALUES ('231221', '望奎县', '231200', '3');
INSERT INTO `ly_area` VALUES ('231222', '兰西县', '231200', '4');
INSERT INTO `ly_area` VALUES ('231223', '青冈县', '231200', '5');
INSERT INTO `ly_area` VALUES ('231224', '庆安县', '231200', '6');
INSERT INTO `ly_area` VALUES ('231225', '明水县', '231200', '7');
INSERT INTO `ly_area` VALUES ('231226', '绥棱县', '231200', '8');
INSERT INTO `ly_area` VALUES ('231281', '安达市', '231200', '9');
INSERT INTO `ly_area` VALUES ('231282', '肇东市', '231200', '10');
INSERT INTO `ly_area` VALUES ('231283', '海伦市', '231200', '11');
INSERT INTO `ly_area` VALUES ('232721', '呼玛县', '232700', '1');
INSERT INTO `ly_area` VALUES ('232722', '塔河县', '232700', '2');
INSERT INTO `ly_area` VALUES ('232723', '漠河县', '232700', '3');
INSERT INTO `ly_area` VALUES ('310101', '黄浦区', '310100', '1');
INSERT INTO `ly_area` VALUES ('310103', '卢湾区', '310100', '2');
INSERT INTO `ly_area` VALUES ('310104', '徐汇区', '310100', '3');
INSERT INTO `ly_area` VALUES ('310105', '长宁区', '310100', '4');
INSERT INTO `ly_area` VALUES ('310106', '静安区', '310100', '5');
INSERT INTO `ly_area` VALUES ('310107', '普陀区', '310100', '6');
INSERT INTO `ly_area` VALUES ('310108', '闸北区', '310100', '7');
INSERT INTO `ly_area` VALUES ('310109', '虹口区', '310100', '8');
INSERT INTO `ly_area` VALUES ('310110', '杨浦区', '310100', '9');
INSERT INTO `ly_area` VALUES ('310112', '闵行区', '310100', '10');
INSERT INTO `ly_area` VALUES ('310113', '宝山区', '310100', '11');
INSERT INTO `ly_area` VALUES ('310114', '嘉定区', '310100', '12');
INSERT INTO `ly_area` VALUES ('310115', '浦东新区', '310100', '13');
INSERT INTO `ly_area` VALUES ('310116', '金山区', '310100', '14');
INSERT INTO `ly_area` VALUES ('310117', '松江区', '310100', '15');
INSERT INTO `ly_area` VALUES ('310118', '青浦区', '310100', '16');
INSERT INTO `ly_area` VALUES ('310119', '南汇区', '310100', '17');
INSERT INTO `ly_area` VALUES ('310120', '奉贤区', '310100', '18');
INSERT INTO `ly_area` VALUES ('310230', '崇明县', '310200', '1');
INSERT INTO `ly_area` VALUES ('320101', '市辖区', '320100', '1');
INSERT INTO `ly_area` VALUES ('320102', '玄武区', '320100', '2');
INSERT INTO `ly_area` VALUES ('320103', '白下区', '320100', '3');
INSERT INTO `ly_area` VALUES ('320104', '秦淮区', '320100', '4');
INSERT INTO `ly_area` VALUES ('320105', '建邺区', '320100', '5');
INSERT INTO `ly_area` VALUES ('320106', '鼓楼区', '320100', '6');
INSERT INTO `ly_area` VALUES ('320107', '下关区', '320100', '7');
INSERT INTO `ly_area` VALUES ('320111', '浦口区', '320100', '8');
INSERT INTO `ly_area` VALUES ('320113', '栖霞区', '320100', '9');
INSERT INTO `ly_area` VALUES ('320114', '雨花台区', '320100', '10');
INSERT INTO `ly_area` VALUES ('320115', '江宁区', '320100', '11');
INSERT INTO `ly_area` VALUES ('320116', '六合区', '320100', '12');
INSERT INTO `ly_area` VALUES ('320124', '溧水县', '320100', '13');
INSERT INTO `ly_area` VALUES ('320125', '高淳县', '320100', '14');
INSERT INTO `ly_area` VALUES ('320201', '市辖区', '320200', '1');
INSERT INTO `ly_area` VALUES ('320202', '崇安区', '320200', '2');
INSERT INTO `ly_area` VALUES ('320203', '南长区', '320200', '3');
INSERT INTO `ly_area` VALUES ('320204', '北塘区', '320200', '4');
INSERT INTO `ly_area` VALUES ('320205', '锡山区', '320200', '5');
INSERT INTO `ly_area` VALUES ('320206', '惠山区', '320200', '6');
INSERT INTO `ly_area` VALUES ('320211', '滨湖区', '320200', '7');
INSERT INTO `ly_area` VALUES ('320281', '江阴市', '320200', '8');
INSERT INTO `ly_area` VALUES ('320282', '宜兴市', '320200', '9');
INSERT INTO `ly_area` VALUES ('320301', '市辖区', '320300', '1');
INSERT INTO `ly_area` VALUES ('320302', '鼓楼区', '320300', '2');
INSERT INTO `ly_area` VALUES ('320303', '云龙区', '320300', '3');
INSERT INTO `ly_area` VALUES ('320304', '九里区', '320300', '4');
INSERT INTO `ly_area` VALUES ('320305', '贾汪区', '320300', '5');
INSERT INTO `ly_area` VALUES ('320311', '泉山区', '320300', '6');
INSERT INTO `ly_area` VALUES ('320321', '丰　县', '320300', '7');
INSERT INTO `ly_area` VALUES ('320322', '沛　县', '320300', '8');
INSERT INTO `ly_area` VALUES ('320323', '铜山县', '320300', '9');
INSERT INTO `ly_area` VALUES ('320324', '睢宁县', '320300', '10');
INSERT INTO `ly_area` VALUES ('320381', '新沂市', '320300', '11');
INSERT INTO `ly_area` VALUES ('320382', '邳州市', '320300', '12');
INSERT INTO `ly_area` VALUES ('320401', '市辖区', '320400', '1');
INSERT INTO `ly_area` VALUES ('320402', '天宁区', '320400', '2');
INSERT INTO `ly_area` VALUES ('320404', '钟楼区', '320400', '3');
INSERT INTO `ly_area` VALUES ('320405', '戚墅堰区', '320400', '4');
INSERT INTO `ly_area` VALUES ('320411', '新北区', '320400', '5');
INSERT INTO `ly_area` VALUES ('320412', '武进区', '320400', '6');
INSERT INTO `ly_area` VALUES ('320481', '溧阳市', '320400', '7');
INSERT INTO `ly_area` VALUES ('320482', '金坛市', '320400', '8');
INSERT INTO `ly_area` VALUES ('320501', '市辖区', '320500', '1');
INSERT INTO `ly_area` VALUES ('320502', '沧浪区', '320500', '2');
INSERT INTO `ly_area` VALUES ('320503', '平江区', '320500', '3');
INSERT INTO `ly_area` VALUES ('320504', '金阊区', '320500', '4');
INSERT INTO `ly_area` VALUES ('320505', '虎丘区', '320500', '5');
INSERT INTO `ly_area` VALUES ('320506', '吴中区', '320500', '6');
INSERT INTO `ly_area` VALUES ('320507', '相城区', '320500', '7');
INSERT INTO `ly_area` VALUES ('320581', '常熟市', '320500', '8');
INSERT INTO `ly_area` VALUES ('320582', '张家港市', '320500', '9');
INSERT INTO `ly_area` VALUES ('320583', '昆山市', '320500', '10');
INSERT INTO `ly_area` VALUES ('320584', '吴江市', '320500', '11');
INSERT INTO `ly_area` VALUES ('320585', '太仓市', '320500', '12');
INSERT INTO `ly_area` VALUES ('320601', '市辖区', '320600', '1');
INSERT INTO `ly_area` VALUES ('320602', '崇川区', '320600', '2');
INSERT INTO `ly_area` VALUES ('320611', '港闸区', '320600', '3');
INSERT INTO `ly_area` VALUES ('320621', '海安县', '320600', '4');
INSERT INTO `ly_area` VALUES ('320623', '如东县', '320600', '5');
INSERT INTO `ly_area` VALUES ('320681', '启东市', '320600', '6');
INSERT INTO `ly_area` VALUES ('320682', '如皋市', '320600', '7');
INSERT INTO `ly_area` VALUES ('320683', '通州市', '320600', '8');
INSERT INTO `ly_area` VALUES ('320684', '海门市', '320600', '9');
INSERT INTO `ly_area` VALUES ('320701', '市辖区', '320700', '1');
INSERT INTO `ly_area` VALUES ('320703', '连云区', '320700', '2');
INSERT INTO `ly_area` VALUES ('320705', '新浦区', '320700', '3');
INSERT INTO `ly_area` VALUES ('320706', '海州区', '320700', '4');
INSERT INTO `ly_area` VALUES ('320721', '赣榆县', '320700', '5');
INSERT INTO `ly_area` VALUES ('320722', '东海县', '320700', '6');
INSERT INTO `ly_area` VALUES ('320723', '灌云县', '320700', '7');
INSERT INTO `ly_area` VALUES ('320724', '灌南县', '320700', '8');
INSERT INTO `ly_area` VALUES ('320801', '市辖区', '320800', '1');
INSERT INTO `ly_area` VALUES ('320802', '清河区', '320800', '2');
INSERT INTO `ly_area` VALUES ('320803', '楚州区', '320800', '3');
INSERT INTO `ly_area` VALUES ('320804', '淮阴区', '320800', '4');
INSERT INTO `ly_area` VALUES ('320811', '清浦区', '320800', '5');
INSERT INTO `ly_area` VALUES ('320826', '涟水县', '320800', '6');
INSERT INTO `ly_area` VALUES ('320829', '洪泽县', '320800', '7');
INSERT INTO `ly_area` VALUES ('320830', '盱眙县', '320800', '8');
INSERT INTO `ly_area` VALUES ('320831', '金湖县', '320800', '9');
INSERT INTO `ly_area` VALUES ('320901', '市辖区', '320900', '1');
INSERT INTO `ly_area` VALUES ('320902', '亭湖区', '320900', '2');
INSERT INTO `ly_area` VALUES ('320903', '盐都区', '320900', '3');
INSERT INTO `ly_area` VALUES ('320921', '响水县', '320900', '4');
INSERT INTO `ly_area` VALUES ('320922', '滨海县', '320900', '5');
INSERT INTO `ly_area` VALUES ('320923', '阜宁县', '320900', '6');
INSERT INTO `ly_area` VALUES ('320924', '射阳县', '320900', '7');
INSERT INTO `ly_area` VALUES ('320925', '建湖县', '320900', '8');
INSERT INTO `ly_area` VALUES ('320981', '东台市', '320900', '9');
INSERT INTO `ly_area` VALUES ('320982', '大丰市', '320900', '10');
INSERT INTO `ly_area` VALUES ('321001', '市辖区', '321000', '1');
INSERT INTO `ly_area` VALUES ('321002', '广陵区', '321000', '2');
INSERT INTO `ly_area` VALUES ('321003', '邗江区', '321000', '3');
INSERT INTO `ly_area` VALUES ('321011', '郊　区', '321000', '4');
INSERT INTO `ly_area` VALUES ('321023', '宝应县', '321000', '5');
INSERT INTO `ly_area` VALUES ('321081', '仪征市', '321000', '6');
INSERT INTO `ly_area` VALUES ('321084', '高邮市', '321000', '7');
INSERT INTO `ly_area` VALUES ('321088', '江都市', '321000', '8');
INSERT INTO `ly_area` VALUES ('321101', '市辖区', '321100', '1');
INSERT INTO `ly_area` VALUES ('321102', '京口区', '321100', '2');
INSERT INTO `ly_area` VALUES ('321111', '润州区', '321100', '3');
INSERT INTO `ly_area` VALUES ('321112', '丹徒区', '321100', '4');
INSERT INTO `ly_area` VALUES ('321181', '丹阳市', '321100', '5');
INSERT INTO `ly_area` VALUES ('321182', '扬中市', '321100', '6');
INSERT INTO `ly_area` VALUES ('321183', '句容市', '321100', '7');
INSERT INTO `ly_area` VALUES ('321201', '市辖区', '321200', '1');
INSERT INTO `ly_area` VALUES ('321202', '海陵区', '321200', '2');
INSERT INTO `ly_area` VALUES ('321203', '高港区', '321200', '3');
INSERT INTO `ly_area` VALUES ('321281', '兴化市', '321200', '4');
INSERT INTO `ly_area` VALUES ('321282', '靖江市', '321200', '5');
INSERT INTO `ly_area` VALUES ('321283', '泰兴市', '321200', '6');
INSERT INTO `ly_area` VALUES ('321284', '姜堰市', '321200', '7');
INSERT INTO `ly_area` VALUES ('321301', '市辖区', '321300', '1');
INSERT INTO `ly_area` VALUES ('321302', '宿城区', '321300', '2');
INSERT INTO `ly_area` VALUES ('321311', '宿豫区', '321300', '3');
INSERT INTO `ly_area` VALUES ('321322', '沭阳县', '321300', '4');
INSERT INTO `ly_area` VALUES ('321323', '泗阳县', '321300', '5');
INSERT INTO `ly_area` VALUES ('321324', '泗洪县', '321300', '6');
INSERT INTO `ly_area` VALUES ('330101', '市辖区', '330100', '1');
INSERT INTO `ly_area` VALUES ('330102', '上城区', '330100', '2');
INSERT INTO `ly_area` VALUES ('330103', '下城区', '330100', '3');
INSERT INTO `ly_area` VALUES ('330104', '江干区', '330100', '4');
INSERT INTO `ly_area` VALUES ('330105', '拱墅区', '330100', '5');
INSERT INTO `ly_area` VALUES ('330106', '西湖区', '330100', '6');
INSERT INTO `ly_area` VALUES ('330108', '滨江区', '330100', '7');
INSERT INTO `ly_area` VALUES ('330109', '萧山区', '330100', '8');
INSERT INTO `ly_area` VALUES ('330110', '余杭区', '330100', '9');
INSERT INTO `ly_area` VALUES ('330122', '桐庐县', '330100', '10');
INSERT INTO `ly_area` VALUES ('330127', '淳安县', '330100', '11');
INSERT INTO `ly_area` VALUES ('330182', '建德市', '330100', '12');
INSERT INTO `ly_area` VALUES ('330183', '富阳市', '330100', '13');
INSERT INTO `ly_area` VALUES ('330185', '临安市', '330100', '14');
INSERT INTO `ly_area` VALUES ('330201', '市辖区', '330200', '1');
INSERT INTO `ly_area` VALUES ('330203', '海曙区', '330200', '2');
INSERT INTO `ly_area` VALUES ('330204', '江东区', '330200', '3');
INSERT INTO `ly_area` VALUES ('330205', '江北区', '330200', '4');
INSERT INTO `ly_area` VALUES ('330206', '北仑区', '330200', '5');
INSERT INTO `ly_area` VALUES ('330211', '镇海区', '330200', '6');
INSERT INTO `ly_area` VALUES ('330212', '鄞州区', '330200', '7');
INSERT INTO `ly_area` VALUES ('330225', '象山县', '330200', '8');
INSERT INTO `ly_area` VALUES ('330226', '宁海县', '330200', '9');
INSERT INTO `ly_area` VALUES ('330281', '余姚市', '330200', '10');
INSERT INTO `ly_area` VALUES ('330282', '慈溪市', '330200', '11');
INSERT INTO `ly_area` VALUES ('330283', '奉化市', '330200', '12');
INSERT INTO `ly_area` VALUES ('330301', '市辖区', '330300', '1');
INSERT INTO `ly_area` VALUES ('330302', '鹿城区', '330300', '2');
INSERT INTO `ly_area` VALUES ('330303', '龙湾区', '330300', '3');
INSERT INTO `ly_area` VALUES ('330304', '瓯海区', '330300', '4');
INSERT INTO `ly_area` VALUES ('330322', '洞头县', '330300', '5');
INSERT INTO `ly_area` VALUES ('330324', '永嘉县', '330300', '6');
INSERT INTO `ly_area` VALUES ('330326', '平阳县', '330300', '7');
INSERT INTO `ly_area` VALUES ('330327', '苍南县', '330300', '8');
INSERT INTO `ly_area` VALUES ('330328', '文成县', '330300', '9');
INSERT INTO `ly_area` VALUES ('330329', '泰顺县', '330300', '10');
INSERT INTO `ly_area` VALUES ('330381', '瑞安市', '330300', '11');
INSERT INTO `ly_area` VALUES ('330382', '乐清市', '330300', '12');
INSERT INTO `ly_area` VALUES ('330401', '市辖区', '330400', '1');
INSERT INTO `ly_area` VALUES ('330402', '秀城区', '330400', '2');
INSERT INTO `ly_area` VALUES ('330411', '秀洲区', '330400', '3');
INSERT INTO `ly_area` VALUES ('330421', '嘉善县', '330400', '4');
INSERT INTO `ly_area` VALUES ('330424', '海盐县', '330400', '5');
INSERT INTO `ly_area` VALUES ('330481', '海宁市', '330400', '6');
INSERT INTO `ly_area` VALUES ('330482', '平湖市', '330400', '7');
INSERT INTO `ly_area` VALUES ('330483', '桐乡市', '330400', '8');
INSERT INTO `ly_area` VALUES ('330501', '市辖区', '330500', '1');
INSERT INTO `ly_area` VALUES ('330502', '吴兴区', '330500', '2');
INSERT INTO `ly_area` VALUES ('330503', '南浔区', '330500', '3');
INSERT INTO `ly_area` VALUES ('330521', '德清县', '330500', '4');
INSERT INTO `ly_area` VALUES ('330522', '长兴县', '330500', '5');
INSERT INTO `ly_area` VALUES ('330523', '安吉县', '330500', '6');
INSERT INTO `ly_area` VALUES ('330601', '市辖区', '330600', '1');
INSERT INTO `ly_area` VALUES ('330602', '越城区', '330600', '2');
INSERT INTO `ly_area` VALUES ('330621', '绍兴县', '330600', '3');
INSERT INTO `ly_area` VALUES ('330624', '新昌县', '330600', '4');
INSERT INTO `ly_area` VALUES ('330681', '诸暨市', '330600', '5');
INSERT INTO `ly_area` VALUES ('330682', '上虞市', '330600', '6');
INSERT INTO `ly_area` VALUES ('330683', '嵊州市', '330600', '7');
INSERT INTO `ly_area` VALUES ('330701', '市辖区', '330700', '1');
INSERT INTO `ly_area` VALUES ('330702', '婺城区', '330700', '2');
INSERT INTO `ly_area` VALUES ('330703', '金东区', '330700', '3');
INSERT INTO `ly_area` VALUES ('330723', '武义县', '330700', '4');
INSERT INTO `ly_area` VALUES ('330726', '浦江县', '330700', '5');
INSERT INTO `ly_area` VALUES ('330727', '磐安县', '330700', '6');
INSERT INTO `ly_area` VALUES ('330781', '兰溪市', '330700', '7');
INSERT INTO `ly_area` VALUES ('330782', '义乌市', '330700', '8');
INSERT INTO `ly_area` VALUES ('330783', '东阳市', '330700', '9');
INSERT INTO `ly_area` VALUES ('330784', '永康市', '330700', '10');
INSERT INTO `ly_area` VALUES ('330801', '市辖区', '330800', '1');
INSERT INTO `ly_area` VALUES ('330802', '柯城区', '330800', '2');
INSERT INTO `ly_area` VALUES ('330803', '衢江区', '330800', '3');
INSERT INTO `ly_area` VALUES ('330822', '常山县', '330800', '4');
INSERT INTO `ly_area` VALUES ('330824', '开化县', '330800', '5');
INSERT INTO `ly_area` VALUES ('330825', '龙游县', '330800', '6');
INSERT INTO `ly_area` VALUES ('330881', '江山市', '330800', '7');
INSERT INTO `ly_area` VALUES ('330901', '市辖区', '330900', '1');
INSERT INTO `ly_area` VALUES ('330902', '定海区', '330900', '2');
INSERT INTO `ly_area` VALUES ('330903', '普陀区', '330900', '3');
INSERT INTO `ly_area` VALUES ('330921', '岱山县', '330900', '4');
INSERT INTO `ly_area` VALUES ('330922', '嵊泗县', '330900', '5');
INSERT INTO `ly_area` VALUES ('331001', '市辖区', '331000', '1');
INSERT INTO `ly_area` VALUES ('331002', '椒江区', '331000', '2');
INSERT INTO `ly_area` VALUES ('331003', '黄岩区', '331000', '3');
INSERT INTO `ly_area` VALUES ('331004', '路桥区', '331000', '4');
INSERT INTO `ly_area` VALUES ('331021', '玉环县', '331000', '5');
INSERT INTO `ly_area` VALUES ('331022', '三门县', '331000', '6');
INSERT INTO `ly_area` VALUES ('331023', '天台县', '331000', '7');
INSERT INTO `ly_area` VALUES ('331024', '仙居县', '331000', '8');
INSERT INTO `ly_area` VALUES ('331081', '温岭市', '331000', '9');
INSERT INTO `ly_area` VALUES ('331082', '临海市', '331000', '10');
INSERT INTO `ly_area` VALUES ('331101', '市辖区', '331100', '1');
INSERT INTO `ly_area` VALUES ('331102', '莲都区', '331100', '2');
INSERT INTO `ly_area` VALUES ('331121', '青田县', '331100', '3');
INSERT INTO `ly_area` VALUES ('331122', '缙云县', '331100', '4');
INSERT INTO `ly_area` VALUES ('331123', '遂昌县', '331100', '5');
INSERT INTO `ly_area` VALUES ('331124', '松阳县', '331100', '6');
INSERT INTO `ly_area` VALUES ('331125', '云和县', '331100', '7');
INSERT INTO `ly_area` VALUES ('331126', '庆元县', '331100', '8');
INSERT INTO `ly_area` VALUES ('331127', '景宁畲族自治县', '331100', '9');
INSERT INTO `ly_area` VALUES ('331181', '龙泉市', '331100', '10');
INSERT INTO `ly_area` VALUES ('340101', '市辖区', '340100', '1');
INSERT INTO `ly_area` VALUES ('340102', '瑶海区', '340100', '2');
INSERT INTO `ly_area` VALUES ('340103', '庐阳区', '340100', '3');
INSERT INTO `ly_area` VALUES ('340104', '蜀山区', '340100', '4');
INSERT INTO `ly_area` VALUES ('340111', '包河区', '340100', '5');
INSERT INTO `ly_area` VALUES ('340121', '长丰县', '340100', '6');
INSERT INTO `ly_area` VALUES ('340122', '肥东县', '340100', '7');
INSERT INTO `ly_area` VALUES ('340123', '肥西县', '340100', '8');
INSERT INTO `ly_area` VALUES ('340201', '市辖区', '340200', '1');
INSERT INTO `ly_area` VALUES ('340202', '镜湖区', '340200', '2');
INSERT INTO `ly_area` VALUES ('340203', '马塘区', '340200', '3');
INSERT INTO `ly_area` VALUES ('340204', '新芜区', '340200', '4');
INSERT INTO `ly_area` VALUES ('340207', '鸠江区', '340200', '5');
INSERT INTO `ly_area` VALUES ('340221', '芜湖县', '340200', '6');
INSERT INTO `ly_area` VALUES ('340222', '繁昌县', '340200', '7');
INSERT INTO `ly_area` VALUES ('340223', '南陵县', '340200', '8');
INSERT INTO `ly_area` VALUES ('340301', '市辖区', '340300', '1');
INSERT INTO `ly_area` VALUES ('340302', '龙子湖区', '340300', '2');
INSERT INTO `ly_area` VALUES ('340303', '蚌山区', '340300', '3');
INSERT INTO `ly_area` VALUES ('340304', '禹会区', '340300', '4');
INSERT INTO `ly_area` VALUES ('340311', '淮上区', '340300', '5');
INSERT INTO `ly_area` VALUES ('340321', '怀远县', '340300', '6');
INSERT INTO `ly_area` VALUES ('340322', '五河县', '340300', '7');
INSERT INTO `ly_area` VALUES ('340323', '固镇县', '340300', '8');
INSERT INTO `ly_area` VALUES ('340401', '市辖区', '340400', '1');
INSERT INTO `ly_area` VALUES ('340402', '大通区', '340400', '2');
INSERT INTO `ly_area` VALUES ('340403', '田家庵区', '340400', '3');
INSERT INTO `ly_area` VALUES ('340404', '谢家集区', '340400', '4');
INSERT INTO `ly_area` VALUES ('340405', '八公山区', '340400', '5');
INSERT INTO `ly_area` VALUES ('340406', '潘集区', '340400', '6');
INSERT INTO `ly_area` VALUES ('340421', '凤台县', '340400', '7');
INSERT INTO `ly_area` VALUES ('340501', '市辖区', '340500', '1');
INSERT INTO `ly_area` VALUES ('340502', '金家庄区', '340500', '2');
INSERT INTO `ly_area` VALUES ('340503', '花山区', '340500', '3');
INSERT INTO `ly_area` VALUES ('340504', '雨山区', '340500', '4');
INSERT INTO `ly_area` VALUES ('340521', '当涂县', '340500', '5');
INSERT INTO `ly_area` VALUES ('340601', '市辖区', '340600', '1');
INSERT INTO `ly_area` VALUES ('340602', '杜集区', '340600', '2');
INSERT INTO `ly_area` VALUES ('340603', '相山区', '340600', '3');
INSERT INTO `ly_area` VALUES ('340604', '烈山区', '340600', '4');
INSERT INTO `ly_area` VALUES ('340621', '濉溪县', '340600', '5');
INSERT INTO `ly_area` VALUES ('340701', '市辖区', '340700', '1');
INSERT INTO `ly_area` VALUES ('340702', '铜官山区', '340700', '2');
INSERT INTO `ly_area` VALUES ('340703', '狮子山区', '340700', '3');
INSERT INTO `ly_area` VALUES ('340711', '郊　区', '340700', '4');
INSERT INTO `ly_area` VALUES ('340721', '铜陵县', '340700', '5');
INSERT INTO `ly_area` VALUES ('340801', '市辖区', '340800', '1');
INSERT INTO `ly_area` VALUES ('340802', '迎江区', '340800', '2');
INSERT INTO `ly_area` VALUES ('340803', '大观区', '340800', '3');
INSERT INTO `ly_area` VALUES ('340811', '郊　区', '340800', '4');
INSERT INTO `ly_area` VALUES ('340822', '怀宁县', '340800', '5');
INSERT INTO `ly_area` VALUES ('340823', '枞阳县', '340800', '6');
INSERT INTO `ly_area` VALUES ('340824', '潜山县', '340800', '7');
INSERT INTO `ly_area` VALUES ('340825', '太湖县', '340800', '8');
INSERT INTO `ly_area` VALUES ('340826', '宿松县', '340800', '9');
INSERT INTO `ly_area` VALUES ('340827', '望江县', '340800', '10');
INSERT INTO `ly_area` VALUES ('340828', '岳西县', '340800', '11');
INSERT INTO `ly_area` VALUES ('340881', '桐城市', '340800', '12');
INSERT INTO `ly_area` VALUES ('341001', '市辖区', '341000', '1');
INSERT INTO `ly_area` VALUES ('341002', '屯溪区', '341000', '2');
INSERT INTO `ly_area` VALUES ('341003', '黄山区', '341000', '3');
INSERT INTO `ly_area` VALUES ('341004', '徽州区', '341000', '4');
INSERT INTO `ly_area` VALUES ('341021', '歙　县', '341000', '5');
INSERT INTO `ly_area` VALUES ('341022', '休宁县', '341000', '6');
INSERT INTO `ly_area` VALUES ('341023', '黟　县', '341000', '7');
INSERT INTO `ly_area` VALUES ('341024', '祁门县', '341000', '8');
INSERT INTO `ly_area` VALUES ('341101', '市辖区', '341100', '1');
INSERT INTO `ly_area` VALUES ('341102', '琅琊区', '341100', '2');
INSERT INTO `ly_area` VALUES ('341103', '南谯区', '341100', '3');
INSERT INTO `ly_area` VALUES ('341122', '来安县', '341100', '4');
INSERT INTO `ly_area` VALUES ('341124', '全椒县', '341100', '5');
INSERT INTO `ly_area` VALUES ('341125', '定远县', '341100', '6');
INSERT INTO `ly_area` VALUES ('341126', '凤阳县', '341100', '7');
INSERT INTO `ly_area` VALUES ('341181', '天长市', '341100', '8');
INSERT INTO `ly_area` VALUES ('341182', '明光市', '341100', '9');
INSERT INTO `ly_area` VALUES ('341201', '市辖区', '341200', '1');
INSERT INTO `ly_area` VALUES ('341202', '颍州区', '341200', '2');
INSERT INTO `ly_area` VALUES ('341203', '颍东区', '341200', '3');
INSERT INTO `ly_area` VALUES ('341204', '颍泉区', '341200', '4');
INSERT INTO `ly_area` VALUES ('341221', '临泉县', '341200', '5');
INSERT INTO `ly_area` VALUES ('341222', '太和县', '341200', '6');
INSERT INTO `ly_area` VALUES ('341225', '阜南县', '341200', '7');
INSERT INTO `ly_area` VALUES ('341226', '颍上县', '341200', '8');
INSERT INTO `ly_area` VALUES ('341282', '界首市', '341200', '9');
INSERT INTO `ly_area` VALUES ('341301', '市辖区', '341300', '1');
INSERT INTO `ly_area` VALUES ('341302', '墉桥区', '341300', '2');
INSERT INTO `ly_area` VALUES ('341321', '砀山县', '341300', '3');
INSERT INTO `ly_area` VALUES ('341322', '萧　县', '341300', '4');
INSERT INTO `ly_area` VALUES ('341323', '灵璧县', '341300', '5');
INSERT INTO `ly_area` VALUES ('341324', '泗　县', '341300', '6');
INSERT INTO `ly_area` VALUES ('341401', '庐江县', '340100', '9');
INSERT INTO `ly_area` VALUES ('341402', '巢湖市', '340100', '10');
INSERT INTO `ly_area` VALUES ('341422', '无为县', '340200', '9');
INSERT INTO `ly_area` VALUES ('341423', '含山县', '340500', '6');
INSERT INTO `ly_area` VALUES ('341424', '和　县', '340500', '7');
INSERT INTO `ly_area` VALUES ('341501', '市辖区', '341500', '1');
INSERT INTO `ly_area` VALUES ('341502', '金安区', '341500', '2');
INSERT INTO `ly_area` VALUES ('341503', '裕安区', '341500', '3');
INSERT INTO `ly_area` VALUES ('341521', '寿　县', '341500', '4');
INSERT INTO `ly_area` VALUES ('341522', '霍邱县', '341500', '5');
INSERT INTO `ly_area` VALUES ('341523', '舒城县', '341500', '6');
INSERT INTO `ly_area` VALUES ('341524', '金寨县', '341500', '7');
INSERT INTO `ly_area` VALUES ('341525', '霍山县', '341500', '8');
INSERT INTO `ly_area` VALUES ('341601', '市辖区', '341600', '1');
INSERT INTO `ly_area` VALUES ('341602', '谯城区', '341600', '2');
INSERT INTO `ly_area` VALUES ('341621', '涡阳县', '341600', '3');
INSERT INTO `ly_area` VALUES ('341622', '蒙城县', '341600', '4');
INSERT INTO `ly_area` VALUES ('341623', '利辛县', '341600', '5');
INSERT INTO `ly_area` VALUES ('341701', '市辖区', '341700', '1');
INSERT INTO `ly_area` VALUES ('341702', '贵池区', '341700', '2');
INSERT INTO `ly_area` VALUES ('341721', '东至县', '341700', '3');
INSERT INTO `ly_area` VALUES ('341722', '石台县', '341700', '4');
INSERT INTO `ly_area` VALUES ('341723', '青阳县', '341700', '5');
INSERT INTO `ly_area` VALUES ('341801', '市辖区', '341800', '1');
INSERT INTO `ly_area` VALUES ('341802', '宣州区', '341800', '2');
INSERT INTO `ly_area` VALUES ('341821', '郎溪县', '341800', '3');
INSERT INTO `ly_area` VALUES ('341822', '广德县', '341800', '4');
INSERT INTO `ly_area` VALUES ('341823', '泾　县', '341800', '5');
INSERT INTO `ly_area` VALUES ('341824', '绩溪县', '341800', '6');
INSERT INTO `ly_area` VALUES ('341825', '旌德县', '341800', '7');
INSERT INTO `ly_area` VALUES ('341881', '宁国市', '341800', '8');
INSERT INTO `ly_area` VALUES ('350101', '市辖区', '350100', '1');
INSERT INTO `ly_area` VALUES ('350102', '鼓楼区', '350100', '2');
INSERT INTO `ly_area` VALUES ('350103', '台江区', '350100', '3');
INSERT INTO `ly_area` VALUES ('350104', '仓山区', '350100', '4');
INSERT INTO `ly_area` VALUES ('350105', '马尾区', '350100', '5');
INSERT INTO `ly_area` VALUES ('350111', '晋安区', '350100', '6');
INSERT INTO `ly_area` VALUES ('350121', '闽侯县', '350100', '7');
INSERT INTO `ly_area` VALUES ('350122', '连江县', '350100', '8');
INSERT INTO `ly_area` VALUES ('350123', '罗源县', '350100', '9');
INSERT INTO `ly_area` VALUES ('350124', '闽清县', '350100', '10');
INSERT INTO `ly_area` VALUES ('350125', '永泰县', '350100', '11');
INSERT INTO `ly_area` VALUES ('350128', '平潭县', '350100', '12');
INSERT INTO `ly_area` VALUES ('350181', '福清市', '350100', '13');
INSERT INTO `ly_area` VALUES ('350182', '长乐市', '350100', '14');
INSERT INTO `ly_area` VALUES ('350201', '市辖区', '350200', '1');
INSERT INTO `ly_area` VALUES ('350203', '思明区', '350200', '2');
INSERT INTO `ly_area` VALUES ('350205', '海沧区', '350200', '3');
INSERT INTO `ly_area` VALUES ('350206', '湖里区', '350200', '4');
INSERT INTO `ly_area` VALUES ('350211', '集美区', '350200', '5');
INSERT INTO `ly_area` VALUES ('350212', '同安区', '350200', '6');
INSERT INTO `ly_area` VALUES ('350213', '翔安区', '350200', '7');
INSERT INTO `ly_area` VALUES ('350301', '市辖区', '350300', '1');
INSERT INTO `ly_area` VALUES ('350302', '城厢区', '350300', '2');
INSERT INTO `ly_area` VALUES ('350303', '涵江区', '350300', '3');
INSERT INTO `ly_area` VALUES ('350304', '荔城区', '350300', '4');
INSERT INTO `ly_area` VALUES ('350305', '秀屿区', '350300', '5');
INSERT INTO `ly_area` VALUES ('350322', '仙游县', '350300', '6');
INSERT INTO `ly_area` VALUES ('350401', '市辖区', '350400', '1');
INSERT INTO `ly_area` VALUES ('350402', '梅列区', '350400', '2');
INSERT INTO `ly_area` VALUES ('350403', '三元区', '350400', '3');
INSERT INTO `ly_area` VALUES ('350421', '明溪县', '350400', '4');
INSERT INTO `ly_area` VALUES ('350423', '清流县', '350400', '5');
INSERT INTO `ly_area` VALUES ('350424', '宁化县', '350400', '6');
INSERT INTO `ly_area` VALUES ('350425', '大田县', '350400', '7');
INSERT INTO `ly_area` VALUES ('350426', '尤溪县', '350400', '8');
INSERT INTO `ly_area` VALUES ('350427', '沙　县', '350400', '9');
INSERT INTO `ly_area` VALUES ('350428', '将乐县', '350400', '10');
INSERT INTO `ly_area` VALUES ('350429', '泰宁县', '350400', '11');
INSERT INTO `ly_area` VALUES ('350430', '建宁县', '350400', '12');
INSERT INTO `ly_area` VALUES ('350481', '永安市', '350400', '13');
INSERT INTO `ly_area` VALUES ('350501', '市辖区', '350500', '1');
INSERT INTO `ly_area` VALUES ('350502', '鲤城区', '350500', '2');
INSERT INTO `ly_area` VALUES ('350503', '丰泽区', '350500', '3');
INSERT INTO `ly_area` VALUES ('350504', '洛江区', '350500', '4');
INSERT INTO `ly_area` VALUES ('350505', '泉港区', '350500', '5');
INSERT INTO `ly_area` VALUES ('350521', '惠安县', '350500', '6');
INSERT INTO `ly_area` VALUES ('350524', '安溪县', '350500', '7');
INSERT INTO `ly_area` VALUES ('350525', '永春县', '350500', '8');
INSERT INTO `ly_area` VALUES ('350526', '德化县', '350500', '9');
INSERT INTO `ly_area` VALUES ('350527', '金门县', '350500', '10');
INSERT INTO `ly_area` VALUES ('350581', '石狮市', '350500', '11');
INSERT INTO `ly_area` VALUES ('350582', '晋江市', '350500', '12');
INSERT INTO `ly_area` VALUES ('350583', '南安市', '350500', '13');
INSERT INTO `ly_area` VALUES ('350601', '市辖区', '350600', '1');
INSERT INTO `ly_area` VALUES ('350602', '芗城区', '350600', '2');
INSERT INTO `ly_area` VALUES ('350603', '龙文区', '350600', '3');
INSERT INTO `ly_area` VALUES ('350622', '云霄县', '350600', '4');
INSERT INTO `ly_area` VALUES ('350623', '漳浦县', '350600', '5');
INSERT INTO `ly_area` VALUES ('350624', '诏安县', '350600', '6');
INSERT INTO `ly_area` VALUES ('350625', '长泰县', '350600', '7');
INSERT INTO `ly_area` VALUES ('350626', '东山县', '350600', '8');
INSERT INTO `ly_area` VALUES ('350627', '南靖县', '350600', '9');
INSERT INTO `ly_area` VALUES ('350628', '平和县', '350600', '10');
INSERT INTO `ly_area` VALUES ('350629', '华安县', '350600', '11');
INSERT INTO `ly_area` VALUES ('350681', '龙海市', '350600', '12');
INSERT INTO `ly_area` VALUES ('350701', '市辖区', '350700', '1');
INSERT INTO `ly_area` VALUES ('350702', '延平区', '350700', '2');
INSERT INTO `ly_area` VALUES ('350721', '顺昌县', '350700', '3');
INSERT INTO `ly_area` VALUES ('350722', '浦城县', '350700', '4');
INSERT INTO `ly_area` VALUES ('350723', '光泽县', '350700', '5');
INSERT INTO `ly_area` VALUES ('350724', '松溪县', '350700', '6');
INSERT INTO `ly_area` VALUES ('350725', '政和县', '350700', '7');
INSERT INTO `ly_area` VALUES ('350781', '邵武市', '350700', '8');
INSERT INTO `ly_area` VALUES ('350782', '武夷山市', '350700', '9');
INSERT INTO `ly_area` VALUES ('350783', '建瓯市', '350700', '10');
INSERT INTO `ly_area` VALUES ('350784', '建阳市', '350700', '11');
INSERT INTO `ly_area` VALUES ('350801', '市辖区', '350800', '1');
INSERT INTO `ly_area` VALUES ('350802', '新罗区', '350800', '2');
INSERT INTO `ly_area` VALUES ('350821', '长汀县', '350800', '3');
INSERT INTO `ly_area` VALUES ('350822', '永定县', '350800', '4');
INSERT INTO `ly_area` VALUES ('350823', '上杭县', '350800', '5');
INSERT INTO `ly_area` VALUES ('350824', '武平县', '350800', '6');
INSERT INTO `ly_area` VALUES ('350825', '连城县', '350800', '7');
INSERT INTO `ly_area` VALUES ('350881', '漳平市', '350800', '8');
INSERT INTO `ly_area` VALUES ('350901', '市辖区', '350900', '1');
INSERT INTO `ly_area` VALUES ('350902', '蕉城区', '350900', '2');
INSERT INTO `ly_area` VALUES ('350921', '霞浦县', '350900', '3');
INSERT INTO `ly_area` VALUES ('350922', '古田县', '350900', '4');
INSERT INTO `ly_area` VALUES ('350923', '屏南县', '350900', '5');
INSERT INTO `ly_area` VALUES ('350924', '寿宁县', '350900', '6');
INSERT INTO `ly_area` VALUES ('350925', '周宁县', '350900', '7');
INSERT INTO `ly_area` VALUES ('350926', '柘荣县', '350900', '8');
INSERT INTO `ly_area` VALUES ('350981', '福安市', '350900', '9');
INSERT INTO `ly_area` VALUES ('350982', '福鼎市', '350900', '10');
INSERT INTO `ly_area` VALUES ('360101', '市辖区', '360100', '1');
INSERT INTO `ly_area` VALUES ('360102', '东湖区', '360100', '2');
INSERT INTO `ly_area` VALUES ('360103', '西湖区', '360100', '3');
INSERT INTO `ly_area` VALUES ('360104', '青云谱区', '360100', '4');
INSERT INTO `ly_area` VALUES ('360105', '湾里区', '360100', '5');
INSERT INTO `ly_area` VALUES ('360111', '青山湖区', '360100', '6');
INSERT INTO `ly_area` VALUES ('360121', '南昌县', '360100', '7');
INSERT INTO `ly_area` VALUES ('360122', '新建县', '360100', '8');
INSERT INTO `ly_area` VALUES ('360123', '安义县', '360100', '9');
INSERT INTO `ly_area` VALUES ('360124', '进贤县', '360100', '10');
INSERT INTO `ly_area` VALUES ('360201', '市辖区', '360200', '1');
INSERT INTO `ly_area` VALUES ('360202', '昌江区', '360200', '2');
INSERT INTO `ly_area` VALUES ('360203', '珠山区', '360200', '3');
INSERT INTO `ly_area` VALUES ('360222', '浮梁县', '360200', '4');
INSERT INTO `ly_area` VALUES ('360281', '乐平市', '360200', '5');
INSERT INTO `ly_area` VALUES ('360301', '市辖区', '360300', '1');
INSERT INTO `ly_area` VALUES ('360302', '安源区', '360300', '2');
INSERT INTO `ly_area` VALUES ('360313', '湘东区', '360300', '3');
INSERT INTO `ly_area` VALUES ('360321', '莲花县', '360300', '4');
INSERT INTO `ly_area` VALUES ('360322', '上栗县', '360300', '5');
INSERT INTO `ly_area` VALUES ('360323', '芦溪县', '360300', '6');
INSERT INTO `ly_area` VALUES ('360401', '市辖区', '360400', '1');
INSERT INTO `ly_area` VALUES ('360402', '庐山区', '360400', '2');
INSERT INTO `ly_area` VALUES ('360403', '浔阳区', '360400', '3');
INSERT INTO `ly_area` VALUES ('360421', '九江县', '360400', '4');
INSERT INTO `ly_area` VALUES ('360423', '武宁县', '360400', '5');
INSERT INTO `ly_area` VALUES ('360424', '修水县', '360400', '6');
INSERT INTO `ly_area` VALUES ('360425', '永修县', '360400', '7');
INSERT INTO `ly_area` VALUES ('360426', '德安县', '360400', '8');
INSERT INTO `ly_area` VALUES ('360427', '星子县', '360400', '9');
INSERT INTO `ly_area` VALUES ('360428', '都昌县', '360400', '10');
INSERT INTO `ly_area` VALUES ('360429', '湖口县', '360400', '11');
INSERT INTO `ly_area` VALUES ('360430', '彭泽县', '360400', '12');
INSERT INTO `ly_area` VALUES ('360481', '瑞昌市', '360400', '13');
INSERT INTO `ly_area` VALUES ('360501', '市辖区', '360500', '1');
INSERT INTO `ly_area` VALUES ('360502', '渝水区', '360500', '2');
INSERT INTO `ly_area` VALUES ('360521', '分宜县', '360500', '3');
INSERT INTO `ly_area` VALUES ('360601', '市辖区', '360600', '1');
INSERT INTO `ly_area` VALUES ('360602', '月湖区', '360600', '2');
INSERT INTO `ly_area` VALUES ('360622', '余江县', '360600', '3');
INSERT INTO `ly_area` VALUES ('360681', '贵溪市', '360600', '4');
INSERT INTO `ly_area` VALUES ('360701', '市辖区', '360700', '1');
INSERT INTO `ly_area` VALUES ('360702', '章贡区', '360700', '2');
INSERT INTO `ly_area` VALUES ('360721', '赣　县', '360700', '3');
INSERT INTO `ly_area` VALUES ('360722', '信丰县', '360700', '4');
INSERT INTO `ly_area` VALUES ('360723', '大余县', '360700', '5');
INSERT INTO `ly_area` VALUES ('360724', '上犹县', '360700', '6');
INSERT INTO `ly_area` VALUES ('360725', '崇义县', '360700', '7');
INSERT INTO `ly_area` VALUES ('360726', '安远县', '360700', '8');
INSERT INTO `ly_area` VALUES ('360727', '龙南县', '360700', '9');
INSERT INTO `ly_area` VALUES ('360728', '定南县', '360700', '10');
INSERT INTO `ly_area` VALUES ('360729', '全南县', '360700', '11');
INSERT INTO `ly_area` VALUES ('360730', '宁都县', '360700', '12');
INSERT INTO `ly_area` VALUES ('360731', '于都县', '360700', '13');
INSERT INTO `ly_area` VALUES ('360732', '兴国县', '360700', '14');
INSERT INTO `ly_area` VALUES ('360733', '会昌县', '360700', '15');
INSERT INTO `ly_area` VALUES ('360734', '寻乌县', '360700', '16');
INSERT INTO `ly_area` VALUES ('360735', '石城县', '360700', '17');
INSERT INTO `ly_area` VALUES ('360781', '瑞金市', '360700', '18');
INSERT INTO `ly_area` VALUES ('360782', '南康市', '360700', '19');
INSERT INTO `ly_area` VALUES ('360801', '市辖区', '360800', '1');
INSERT INTO `ly_area` VALUES ('360802', '吉州区', '360800', '2');
INSERT INTO `ly_area` VALUES ('360803', '青原区', '360800', '3');
INSERT INTO `ly_area` VALUES ('360821', '吉安县', '360800', '4');
INSERT INTO `ly_area` VALUES ('360822', '吉水县', '360800', '5');
INSERT INTO `ly_area` VALUES ('360823', '峡江县', '360800', '6');
INSERT INTO `ly_area` VALUES ('360824', '新干县', '360800', '7');
INSERT INTO `ly_area` VALUES ('360825', '永丰县', '360800', '8');
INSERT INTO `ly_area` VALUES ('360826', '泰和县', '360800', '9');
INSERT INTO `ly_area` VALUES ('360827', '遂川县', '360800', '10');
INSERT INTO `ly_area` VALUES ('360828', '万安县', '360800', '11');
INSERT INTO `ly_area` VALUES ('360829', '安福县', '360800', '12');
INSERT INTO `ly_area` VALUES ('360830', '永新县', '360800', '13');
INSERT INTO `ly_area` VALUES ('360881', '井冈山市', '360800', '14');
INSERT INTO `ly_area` VALUES ('360901', '市辖区', '360900', '1');
INSERT INTO `ly_area` VALUES ('360902', '袁州区', '360900', '2');
INSERT INTO `ly_area` VALUES ('360921', '奉新县', '360900', '3');
INSERT INTO `ly_area` VALUES ('360922', '万载县', '360900', '4');
INSERT INTO `ly_area` VALUES ('360923', '上高县', '360900', '5');
INSERT INTO `ly_area` VALUES ('360924', '宜丰县', '360900', '6');
INSERT INTO `ly_area` VALUES ('360925', '靖安县', '360900', '7');
INSERT INTO `ly_area` VALUES ('360926', '铜鼓县', '360900', '8');
INSERT INTO `ly_area` VALUES ('360981', '丰城市', '360900', '9');
INSERT INTO `ly_area` VALUES ('360982', '樟树市', '360900', '10');
INSERT INTO `ly_area` VALUES ('360983', '高安市', '360900', '11');
INSERT INTO `ly_area` VALUES ('361001', '市辖区', '361000', '1');
INSERT INTO `ly_area` VALUES ('361002', '临川区', '361000', '2');
INSERT INTO `ly_area` VALUES ('361021', '南城县', '361000', '3');
INSERT INTO `ly_area` VALUES ('361022', '黎川县', '361000', '4');
INSERT INTO `ly_area` VALUES ('361023', '南丰县', '361000', '5');
INSERT INTO `ly_area` VALUES ('361024', '崇仁县', '361000', '6');
INSERT INTO `ly_area` VALUES ('361025', '乐安县', '361000', '7');
INSERT INTO `ly_area` VALUES ('361026', '宜黄县', '361000', '8');
INSERT INTO `ly_area` VALUES ('361027', '金溪县', '361000', '9');
INSERT INTO `ly_area` VALUES ('361028', '资溪县', '361000', '10');
INSERT INTO `ly_area` VALUES ('361029', '东乡县', '361000', '11');
INSERT INTO `ly_area` VALUES ('361030', '广昌县', '361000', '12');
INSERT INTO `ly_area` VALUES ('361101', '市辖区', '361100', '1');
INSERT INTO `ly_area` VALUES ('361102', '信州区', '361100', '2');
INSERT INTO `ly_area` VALUES ('361121', '上饶县', '361100', '3');
INSERT INTO `ly_area` VALUES ('361122', '广丰县', '361100', '4');
INSERT INTO `ly_area` VALUES ('361123', '玉山县', '361100', '5');
INSERT INTO `ly_area` VALUES ('361124', '铅山县', '361100', '6');
INSERT INTO `ly_area` VALUES ('361125', '横峰县', '361100', '7');
INSERT INTO `ly_area` VALUES ('361126', '弋阳县', '361100', '8');
INSERT INTO `ly_area` VALUES ('361127', '余干县', '361100', '9');
INSERT INTO `ly_area` VALUES ('361128', '鄱阳县', '361100', '10');
INSERT INTO `ly_area` VALUES ('361129', '万年县', '361100', '11');
INSERT INTO `ly_area` VALUES ('361130', '婺源县', '361100', '12');
INSERT INTO `ly_area` VALUES ('361181', '德兴市', '361100', '13');
INSERT INTO `ly_area` VALUES ('370101', '市辖区', '370100', '1');
INSERT INTO `ly_area` VALUES ('370102', '历下区', '370100', '2');
INSERT INTO `ly_area` VALUES ('370103', '市中区', '370100', '3');
INSERT INTO `ly_area` VALUES ('370104', '槐荫区', '370100', '4');
INSERT INTO `ly_area` VALUES ('370105', '天桥区', '370100', '5');
INSERT INTO `ly_area` VALUES ('370112', '历城区', '370100', '6');
INSERT INTO `ly_area` VALUES ('370113', '长清区', '370100', '7');
INSERT INTO `ly_area` VALUES ('370124', '平阴县', '370100', '8');
INSERT INTO `ly_area` VALUES ('370125', '济阳县', '370100', '9');
INSERT INTO `ly_area` VALUES ('370126', '商河县', '370100', '10');
INSERT INTO `ly_area` VALUES ('370181', '章丘市', '370100', '11');
INSERT INTO `ly_area` VALUES ('370201', '市辖区', '370200', '1');
INSERT INTO `ly_area` VALUES ('370202', '市南区', '370200', '2');
INSERT INTO `ly_area` VALUES ('370203', '市北区', '370200', '3');
INSERT INTO `ly_area` VALUES ('370205', '四方区', '370200', '4');
INSERT INTO `ly_area` VALUES ('370211', '黄岛区', '370200', '5');
INSERT INTO `ly_area` VALUES ('370212', '崂山区', '370200', '6');
INSERT INTO `ly_area` VALUES ('370213', '李沧区', '370200', '7');
INSERT INTO `ly_area` VALUES ('370214', '城阳区', '370200', '8');
INSERT INTO `ly_area` VALUES ('370281', '胶州市', '370200', '9');
INSERT INTO `ly_area` VALUES ('370282', '即墨市', '370200', '10');
INSERT INTO `ly_area` VALUES ('370283', '平度市', '370200', '11');
INSERT INTO `ly_area` VALUES ('370284', '胶南市', '370200', '12');
INSERT INTO `ly_area` VALUES ('370285', '莱西市', '370200', '13');
INSERT INTO `ly_area` VALUES ('370301', '市辖区', '370300', '1');
INSERT INTO `ly_area` VALUES ('370302', '淄川区', '370300', '2');
INSERT INTO `ly_area` VALUES ('370303', '张店区', '370300', '3');
INSERT INTO `ly_area` VALUES ('370304', '博山区', '370300', '4');
INSERT INTO `ly_area` VALUES ('370305', '临淄区', '370300', '5');
INSERT INTO `ly_area` VALUES ('370306', '周村区', '370300', '6');
INSERT INTO `ly_area` VALUES ('370321', '桓台县', '370300', '7');
INSERT INTO `ly_area` VALUES ('370322', '高青县', '370300', '8');
INSERT INTO `ly_area` VALUES ('370323', '沂源县', '370300', '9');
INSERT INTO `ly_area` VALUES ('370401', '市辖区', '370400', '1');
INSERT INTO `ly_area` VALUES ('370402', '市中区', '370400', '2');
INSERT INTO `ly_area` VALUES ('370403', '薛城区', '370400', '3');
INSERT INTO `ly_area` VALUES ('370404', '峄城区', '370400', '4');
INSERT INTO `ly_area` VALUES ('370405', '台儿庄区', '370400', '5');
INSERT INTO `ly_area` VALUES ('370406', '山亭区', '370400', '6');
INSERT INTO `ly_area` VALUES ('370481', '滕州市', '370400', '7');
INSERT INTO `ly_area` VALUES ('370501', '市辖区', '370500', '1');
INSERT INTO `ly_area` VALUES ('370502', '东营区', '370500', '2');
INSERT INTO `ly_area` VALUES ('370503', '河口区', '370500', '3');
INSERT INTO `ly_area` VALUES ('370521', '垦利县', '370500', '4');
INSERT INTO `ly_area` VALUES ('370522', '利津县', '370500', '5');
INSERT INTO `ly_area` VALUES ('370523', '广饶县', '370500', '6');
INSERT INTO `ly_area` VALUES ('370601', '市辖区', '370600', '1');
INSERT INTO `ly_area` VALUES ('370602', '芝罘区', '370600', '2');
INSERT INTO `ly_area` VALUES ('370611', '福山区', '370600', '3');
INSERT INTO `ly_area` VALUES ('370612', '牟平区', '370600', '4');
INSERT INTO `ly_area` VALUES ('370613', '莱山区', '370600', '5');
INSERT INTO `ly_area` VALUES ('370634', '长岛县', '370600', '6');
INSERT INTO `ly_area` VALUES ('370681', '龙口市', '370600', '7');
INSERT INTO `ly_area` VALUES ('370682', '莱阳市', '370600', '8');
INSERT INTO `ly_area` VALUES ('370683', '莱州市', '370600', '9');
INSERT INTO `ly_area` VALUES ('370684', '蓬莱市', '370600', '10');
INSERT INTO `ly_area` VALUES ('370685', '招远市', '370600', '11');
INSERT INTO `ly_area` VALUES ('370686', '栖霞市', '370600', '12');
INSERT INTO `ly_area` VALUES ('370687', '海阳市', '370600', '13');
INSERT INTO `ly_area` VALUES ('370701', '市辖区', '370700', '1');
INSERT INTO `ly_area` VALUES ('370702', '潍城区', '370700', '2');
INSERT INTO `ly_area` VALUES ('370703', '寒亭区', '370700', '3');
INSERT INTO `ly_area` VALUES ('370704', '坊子区', '370700', '4');
INSERT INTO `ly_area` VALUES ('370705', '奎文区', '370700', '5');
INSERT INTO `ly_area` VALUES ('370724', '临朐县', '370700', '6');
INSERT INTO `ly_area` VALUES ('370725', '昌乐县', '370700', '7');
INSERT INTO `ly_area` VALUES ('370781', '青州市', '370700', '8');
INSERT INTO `ly_area` VALUES ('370782', '诸城市', '370700', '9');
INSERT INTO `ly_area` VALUES ('370783', '寿光市', '370700', '10');
INSERT INTO `ly_area` VALUES ('370784', '安丘市', '370700', '11');
INSERT INTO `ly_area` VALUES ('370785', '高密市', '370700', '12');
INSERT INTO `ly_area` VALUES ('370786', '昌邑市', '370700', '13');
INSERT INTO `ly_area` VALUES ('370801', '市辖区', '370800', '1');
INSERT INTO `ly_area` VALUES ('370802', '市中区', '370800', '2');
INSERT INTO `ly_area` VALUES ('370811', '任城区', '370800', '3');
INSERT INTO `ly_area` VALUES ('370826', '微山县', '370800', '4');
INSERT INTO `ly_area` VALUES ('370827', '鱼台县', '370800', '5');
INSERT INTO `ly_area` VALUES ('370828', '金乡县', '370800', '6');
INSERT INTO `ly_area` VALUES ('370829', '嘉祥县', '370800', '7');
INSERT INTO `ly_area` VALUES ('370830', '汶上县', '370800', '8');
INSERT INTO `ly_area` VALUES ('370831', '泗水县', '370800', '9');
INSERT INTO `ly_area` VALUES ('370832', '梁山县', '370800', '10');
INSERT INTO `ly_area` VALUES ('370881', '曲阜市', '370800', '11');
INSERT INTO `ly_area` VALUES ('370882', '兖州市', '370800', '12');
INSERT INTO `ly_area` VALUES ('370883', '邹城市', '370800', '13');
INSERT INTO `ly_area` VALUES ('370901', '市辖区', '370900', '1');
INSERT INTO `ly_area` VALUES ('370902', '泰山区', '370900', '2');
INSERT INTO `ly_area` VALUES ('370903', '岱岳区', '370900', '3');
INSERT INTO `ly_area` VALUES ('370921', '宁阳县', '370900', '4');
INSERT INTO `ly_area` VALUES ('370923', '东平县', '370900', '5');
INSERT INTO `ly_area` VALUES ('370982', '新泰市', '370900', '6');
INSERT INTO `ly_area` VALUES ('370983', '肥城市', '370900', '7');
INSERT INTO `ly_area` VALUES ('371001', '市辖区', '371000', '1');
INSERT INTO `ly_area` VALUES ('371002', '环翠区', '371000', '2');
INSERT INTO `ly_area` VALUES ('371081', '文登市', '371000', '3');
INSERT INTO `ly_area` VALUES ('371082', '荣成市', '371000', '4');
INSERT INTO `ly_area` VALUES ('371083', '乳山市', '371000', '5');
INSERT INTO `ly_area` VALUES ('371101', '市辖区', '371100', '1');
INSERT INTO `ly_area` VALUES ('371102', '东港区', '371100', '2');
INSERT INTO `ly_area` VALUES ('371103', '岚山区', '371100', '3');
INSERT INTO `ly_area` VALUES ('371121', '五莲县', '371100', '4');
INSERT INTO `ly_area` VALUES ('371122', '莒　县', '371100', '5');
INSERT INTO `ly_area` VALUES ('371201', '市辖区', '371200', '1');
INSERT INTO `ly_area` VALUES ('371202', '莱城区', '371200', '2');
INSERT INTO `ly_area` VALUES ('371203', '钢城区', '371200', '3');
INSERT INTO `ly_area` VALUES ('371301', '市辖区', '371300', '1');
INSERT INTO `ly_area` VALUES ('371302', '兰山区', '371300', '2');
INSERT INTO `ly_area` VALUES ('371311', '罗庄区', '371300', '3');
INSERT INTO `ly_area` VALUES ('371312', '河东区', '371300', '4');
INSERT INTO `ly_area` VALUES ('371321', '沂南县', '371300', '5');
INSERT INTO `ly_area` VALUES ('371322', '郯城县', '371300', '6');
INSERT INTO `ly_area` VALUES ('371323', '沂水县', '371300', '7');
INSERT INTO `ly_area` VALUES ('371324', '苍山县', '371300', '8');
INSERT INTO `ly_area` VALUES ('371325', '费　县', '371300', '9');
INSERT INTO `ly_area` VALUES ('371326', '平邑县', '371300', '10');
INSERT INTO `ly_area` VALUES ('371327', '莒南县', '371300', '11');
INSERT INTO `ly_area` VALUES ('371328', '蒙阴县', '371300', '12');
INSERT INTO `ly_area` VALUES ('371329', '临沭县', '371300', '13');
INSERT INTO `ly_area` VALUES ('371401', '市辖区', '371400', '1');
INSERT INTO `ly_area` VALUES ('371402', '德城区', '371400', '2');
INSERT INTO `ly_area` VALUES ('371421', '陵　县', '371400', '3');
INSERT INTO `ly_area` VALUES ('371422', '宁津县', '371400', '4');
INSERT INTO `ly_area` VALUES ('371423', '庆云县', '371400', '5');
INSERT INTO `ly_area` VALUES ('371424', '临邑县', '371400', '6');
INSERT INTO `ly_area` VALUES ('371425', '齐河县', '371400', '7');
INSERT INTO `ly_area` VALUES ('371426', '平原县', '371400', '8');
INSERT INTO `ly_area` VALUES ('371427', '夏津县', '371400', '9');
INSERT INTO `ly_area` VALUES ('371428', '武城县', '371400', '10');
INSERT INTO `ly_area` VALUES ('371481', '乐陵市', '371400', '11');
INSERT INTO `ly_area` VALUES ('371482', '禹城市', '371400', '12');
INSERT INTO `ly_area` VALUES ('371501', '市辖区', '371500', '1');
INSERT INTO `ly_area` VALUES ('371502', '东昌府区', '371500', '2');
INSERT INTO `ly_area` VALUES ('371521', '阳谷县', '371500', '3');
INSERT INTO `ly_area` VALUES ('371522', '莘　县', '371500', '4');
INSERT INTO `ly_area` VALUES ('371523', '茌平县', '371500', '5');
INSERT INTO `ly_area` VALUES ('371524', '东阿县', '371500', '6');
INSERT INTO `ly_area` VALUES ('371525', '冠　县', '371500', '7');
INSERT INTO `ly_area` VALUES ('371526', '高唐县', '371500', '8');
INSERT INTO `ly_area` VALUES ('371581', '临清市', '371500', '9');
INSERT INTO `ly_area` VALUES ('371601', '市辖区', '371600', '1');
INSERT INTO `ly_area` VALUES ('371602', '滨城区', '371600', '2');
INSERT INTO `ly_area` VALUES ('371621', '惠民县', '371600', '3');
INSERT INTO `ly_area` VALUES ('371622', '阳信县', '371600', '4');
INSERT INTO `ly_area` VALUES ('371623', '无棣县', '371600', '5');
INSERT INTO `ly_area` VALUES ('371624', '沾化县', '371600', '6');
INSERT INTO `ly_area` VALUES ('371625', '博兴县', '371600', '7');
INSERT INTO `ly_area` VALUES ('371626', '邹平县', '371600', '8');
INSERT INTO `ly_area` VALUES ('371701', '市辖区', '371700', '1');
INSERT INTO `ly_area` VALUES ('371702', '牡丹区', '371700', '2');
INSERT INTO `ly_area` VALUES ('371721', '曹　县', '371700', '3');
INSERT INTO `ly_area` VALUES ('371722', '单　县', '371700', '4');
INSERT INTO `ly_area` VALUES ('371723', '成武县', '371700', '5');
INSERT INTO `ly_area` VALUES ('371724', '巨野县', '371700', '6');
INSERT INTO `ly_area` VALUES ('371725', '郓城县', '371700', '7');
INSERT INTO `ly_area` VALUES ('371726', '鄄城县', '371700', '8');
INSERT INTO `ly_area` VALUES ('371727', '定陶县', '371700', '9');
INSERT INTO `ly_area` VALUES ('371728', '东明县', '371700', '10');
INSERT INTO `ly_area` VALUES ('410101', '市辖区', '410100', '1');
INSERT INTO `ly_area` VALUES ('410102', '中原区', '410100', '2');
INSERT INTO `ly_area` VALUES ('410103', '二七区', '410100', '3');
INSERT INTO `ly_area` VALUES ('410104', '管城回族区', '410100', '4');
INSERT INTO `ly_area` VALUES ('410105', '金水区', '410100', '5');
INSERT INTO `ly_area` VALUES ('410106', '上街区', '410100', '6');
INSERT INTO `ly_area` VALUES ('410108', '邙山区', '410100', '7');
INSERT INTO `ly_area` VALUES ('410122', '中牟县', '410100', '8');
INSERT INTO `ly_area` VALUES ('410181', '巩义市', '410100', '9');
INSERT INTO `ly_area` VALUES ('410182', '荥阳市', '410100', '10');
INSERT INTO `ly_area` VALUES ('410183', '新密市', '410100', '11');
INSERT INTO `ly_area` VALUES ('410184', '新郑市', '410100', '12');
INSERT INTO `ly_area` VALUES ('410185', '登封市', '410100', '13');
INSERT INTO `ly_area` VALUES ('410201', '市辖区', '410200', '1');
INSERT INTO `ly_area` VALUES ('410202', '龙亭区', '410200', '2');
INSERT INTO `ly_area` VALUES ('410203', '顺河回族区', '410200', '3');
INSERT INTO `ly_area` VALUES ('410204', '鼓楼区', '410200', '4');
INSERT INTO `ly_area` VALUES ('410205', '南关区', '410200', '5');
INSERT INTO `ly_area` VALUES ('410211', '郊　区', '410200', '6');
INSERT INTO `ly_area` VALUES ('410221', '杞　县', '410200', '7');
INSERT INTO `ly_area` VALUES ('410222', '通许县', '410200', '8');
INSERT INTO `ly_area` VALUES ('410223', '尉氏县', '410200', '9');
INSERT INTO `ly_area` VALUES ('410224', '开封县', '410200', '10');
INSERT INTO `ly_area` VALUES ('410225', '兰考县', '410200', '11');
INSERT INTO `ly_area` VALUES ('410301', '市辖区', '410300', '1');
INSERT INTO `ly_area` VALUES ('410302', '老城区', '410300', '2');
INSERT INTO `ly_area` VALUES ('410303', '西工区', '410300', '3');
INSERT INTO `ly_area` VALUES ('410304', '廛河回族区', '410300', '4');
INSERT INTO `ly_area` VALUES ('410305', '涧西区', '410300', '5');
INSERT INTO `ly_area` VALUES ('410306', '吉利区', '410300', '6');
INSERT INTO `ly_area` VALUES ('410307', '洛龙区', '410300', '7');
INSERT INTO `ly_area` VALUES ('410322', '孟津县', '410300', '8');
INSERT INTO `ly_area` VALUES ('410323', '新安县', '410300', '9');
INSERT INTO `ly_area` VALUES ('410324', '栾川县', '410300', '10');
INSERT INTO `ly_area` VALUES ('410325', '嵩　县', '410300', '11');
INSERT INTO `ly_area` VALUES ('410326', '汝阳县', '410300', '12');
INSERT INTO `ly_area` VALUES ('410327', '宜阳县', '410300', '13');
INSERT INTO `ly_area` VALUES ('410328', '洛宁县', '410300', '14');
INSERT INTO `ly_area` VALUES ('410329', '伊川县', '410300', '15');
INSERT INTO `ly_area` VALUES ('410381', '偃师市', '410300', '16');
INSERT INTO `ly_area` VALUES ('410401', '市辖区', '410400', '1');
INSERT INTO `ly_area` VALUES ('410402', '新华区', '410400', '2');
INSERT INTO `ly_area` VALUES ('410403', '卫东区', '410400', '3');
INSERT INTO `ly_area` VALUES ('410404', '石龙区', '410400', '4');
INSERT INTO `ly_area` VALUES ('410411', '湛河区', '410400', '5');
INSERT INTO `ly_area` VALUES ('410421', '宝丰县', '410400', '6');
INSERT INTO `ly_area` VALUES ('410422', '叶　县', '410400', '7');
INSERT INTO `ly_area` VALUES ('410423', '鲁山县', '410400', '8');
INSERT INTO `ly_area` VALUES ('410425', '郏　县', '410400', '9');
INSERT INTO `ly_area` VALUES ('410481', '舞钢市', '410400', '10');
INSERT INTO `ly_area` VALUES ('410482', '汝州市', '410400', '11');
INSERT INTO `ly_area` VALUES ('410501', '市辖区', '410500', '1');
INSERT INTO `ly_area` VALUES ('410502', '文峰区', '410500', '2');
INSERT INTO `ly_area` VALUES ('410503', '北关区', '410500', '3');
INSERT INTO `ly_area` VALUES ('410505', '殷都区', '410500', '4');
INSERT INTO `ly_area` VALUES ('410506', '龙安区', '410500', '5');
INSERT INTO `ly_area` VALUES ('410522', '安阳县', '410500', '6');
INSERT INTO `ly_area` VALUES ('410523', '汤阴县', '410500', '7');
INSERT INTO `ly_area` VALUES ('410526', '滑　县', '410500', '8');
INSERT INTO `ly_area` VALUES ('410527', '内黄县', '410500', '9');
INSERT INTO `ly_area` VALUES ('410581', '林州市', '410500', '10');
INSERT INTO `ly_area` VALUES ('410601', '市辖区', '410600', '1');
INSERT INTO `ly_area` VALUES ('410602', '鹤山区', '410600', '2');
INSERT INTO `ly_area` VALUES ('410603', '山城区', '410600', '3');
INSERT INTO `ly_area` VALUES ('410611', '淇滨区', '410600', '4');
INSERT INTO `ly_area` VALUES ('410621', '浚　县', '410600', '5');
INSERT INTO `ly_area` VALUES ('410622', '淇　县', '410600', '6');
INSERT INTO `ly_area` VALUES ('410701', '市辖区', '410700', '1');
INSERT INTO `ly_area` VALUES ('410702', '红旗区', '410700', '2');
INSERT INTO `ly_area` VALUES ('410703', '卫滨区', '410700', '3');
INSERT INTO `ly_area` VALUES ('410704', '凤泉区', '410700', '4');
INSERT INTO `ly_area` VALUES ('410711', '牧野区', '410700', '5');
INSERT INTO `ly_area` VALUES ('410721', '新乡县', '410700', '6');
INSERT INTO `ly_area` VALUES ('410724', '获嘉县', '410700', '7');
INSERT INTO `ly_area` VALUES ('410725', '原阳县', '410700', '8');
INSERT INTO `ly_area` VALUES ('410726', '延津县', '410700', '9');
INSERT INTO `ly_area` VALUES ('410727', '封丘县', '410700', '10');
INSERT INTO `ly_area` VALUES ('410728', '长垣县', '410700', '11');
INSERT INTO `ly_area` VALUES ('410781', '卫辉市', '410700', '12');
INSERT INTO `ly_area` VALUES ('410782', '辉县市', '410700', '13');
INSERT INTO `ly_area` VALUES ('410801', '市辖区', '410800', '1');
INSERT INTO `ly_area` VALUES ('410802', '解放区', '410800', '2');
INSERT INTO `ly_area` VALUES ('410803', '中站区', '410800', '3');
INSERT INTO `ly_area` VALUES ('410804', '马村区', '410800', '4');
INSERT INTO `ly_area` VALUES ('410811', '山阳区', '410800', '5');
INSERT INTO `ly_area` VALUES ('410821', '修武县', '410800', '6');
INSERT INTO `ly_area` VALUES ('410822', '博爱县', '410800', '7');
INSERT INTO `ly_area` VALUES ('410823', '武陟县', '410800', '8');
INSERT INTO `ly_area` VALUES ('410825', '温　县', '410800', '9');
INSERT INTO `ly_area` VALUES ('410881', '济源市', '410800', '10');
INSERT INTO `ly_area` VALUES ('410882', '沁阳市', '410800', '11');
INSERT INTO `ly_area` VALUES ('410883', '孟州市', '410800', '12');
INSERT INTO `ly_area` VALUES ('410901', '市辖区', '410900', '1');
INSERT INTO `ly_area` VALUES ('410902', '华龙区', '410900', '2');
INSERT INTO `ly_area` VALUES ('410922', '清丰县', '410900', '3');
INSERT INTO `ly_area` VALUES ('410923', '南乐县', '410900', '4');
INSERT INTO `ly_area` VALUES ('410926', '范　县', '410900', '5');
INSERT INTO `ly_area` VALUES ('410927', '台前县', '410900', '6');
INSERT INTO `ly_area` VALUES ('410928', '濮阳县', '410900', '7');
INSERT INTO `ly_area` VALUES ('411001', '市辖区', '411000', '1');
INSERT INTO `ly_area` VALUES ('411002', '魏都区', '411000', '2');
INSERT INTO `ly_area` VALUES ('411023', '许昌县', '411000', '3');
INSERT INTO `ly_area` VALUES ('411024', '鄢陵县', '411000', '4');
INSERT INTO `ly_area` VALUES ('411025', '襄城县', '411000', '5');
INSERT INTO `ly_area` VALUES ('411081', '禹州市', '411000', '6');
INSERT INTO `ly_area` VALUES ('411082', '长葛市', '411000', '7');
INSERT INTO `ly_area` VALUES ('411101', '市辖区', '411100', '1');
INSERT INTO `ly_area` VALUES ('411102', '源汇区', '411100', '2');
INSERT INTO `ly_area` VALUES ('411103', '郾城区', '411100', '3');
INSERT INTO `ly_area` VALUES ('411104', '召陵区', '411100', '4');
INSERT INTO `ly_area` VALUES ('411121', '舞阳县', '411100', '5');
INSERT INTO `ly_area` VALUES ('411122', '临颍县', '411100', '6');
INSERT INTO `ly_area` VALUES ('411201', '市辖区', '411200', '1');
INSERT INTO `ly_area` VALUES ('411202', '湖滨区', '411200', '2');
INSERT INTO `ly_area` VALUES ('411221', '渑池县', '411200', '3');
INSERT INTO `ly_area` VALUES ('411222', '陕　县', '411200', '4');
INSERT INTO `ly_area` VALUES ('411224', '卢氏县', '411200', '5');
INSERT INTO `ly_area` VALUES ('411281', '义马市', '411200', '6');
INSERT INTO `ly_area` VALUES ('411282', '灵宝市', '411200', '7');
INSERT INTO `ly_area` VALUES ('411301', '市辖区', '411300', '1');
INSERT INTO `ly_area` VALUES ('411302', '宛城区', '411300', '2');
INSERT INTO `ly_area` VALUES ('411303', '卧龙区', '411300', '3');
INSERT INTO `ly_area` VALUES ('411321', '南召县', '411300', '4');
INSERT INTO `ly_area` VALUES ('411322', '方城县', '411300', '5');
INSERT INTO `ly_area` VALUES ('411323', '西峡县', '411300', '6');
INSERT INTO `ly_area` VALUES ('411324', '镇平县', '411300', '7');
INSERT INTO `ly_area` VALUES ('411325', '内乡县', '411300', '8');
INSERT INTO `ly_area` VALUES ('411326', '淅川县', '411300', '9');
INSERT INTO `ly_area` VALUES ('411327', '社旗县', '411300', '10');
INSERT INTO `ly_area` VALUES ('411328', '唐河县', '411300', '11');
INSERT INTO `ly_area` VALUES ('411329', '新野县', '411300', '12');
INSERT INTO `ly_area` VALUES ('411330', '桐柏县', '411300', '13');
INSERT INTO `ly_area` VALUES ('411381', '邓州市', '411300', '14');
INSERT INTO `ly_area` VALUES ('411401', '市辖区', '411400', '1');
INSERT INTO `ly_area` VALUES ('411402', '梁园区', '411400', '2');
INSERT INTO `ly_area` VALUES ('411403', '睢阳区', '411400', '3');
INSERT INTO `ly_area` VALUES ('411421', '民权县', '411400', '4');
INSERT INTO `ly_area` VALUES ('411422', '睢　县', '411400', '5');
INSERT INTO `ly_area` VALUES ('411423', '宁陵县', '411400', '6');
INSERT INTO `ly_area` VALUES ('411424', '柘城县', '411400', '7');
INSERT INTO `ly_area` VALUES ('411425', '虞城县', '411400', '8');
INSERT INTO `ly_area` VALUES ('411426', '夏邑县', '411400', '9');
INSERT INTO `ly_area` VALUES ('411481', '永城市', '411400', '10');
INSERT INTO `ly_area` VALUES ('411501', '市辖区', '411500', '1');
INSERT INTO `ly_area` VALUES ('411502', '师河区', '411500', '2');
INSERT INTO `ly_area` VALUES ('411503', '平桥区', '411500', '3');
INSERT INTO `ly_area` VALUES ('411521', '罗山县', '411500', '4');
INSERT INTO `ly_area` VALUES ('411522', '光山县', '411500', '5');
INSERT INTO `ly_area` VALUES ('411523', '新　县', '411500', '6');
INSERT INTO `ly_area` VALUES ('411524', '商城县', '411500', '7');
INSERT INTO `ly_area` VALUES ('411525', '固始县', '411500', '8');
INSERT INTO `ly_area` VALUES ('411526', '潢川县', '411500', '9');
INSERT INTO `ly_area` VALUES ('411527', '淮滨县', '411500', '10');
INSERT INTO `ly_area` VALUES ('411528', '息　县', '411500', '11');
INSERT INTO `ly_area` VALUES ('411601', '市辖区', '411600', '1');
INSERT INTO `ly_area` VALUES ('411602', '川汇区', '411600', '2');
INSERT INTO `ly_area` VALUES ('411621', '扶沟县', '411600', '3');
INSERT INTO `ly_area` VALUES ('411622', '西华县', '411600', '4');
INSERT INTO `ly_area` VALUES ('411623', '商水县', '411600', '5');
INSERT INTO `ly_area` VALUES ('411624', '沈丘县', '411600', '6');
INSERT INTO `ly_area` VALUES ('411625', '郸城县', '411600', '7');
INSERT INTO `ly_area` VALUES ('411626', '淮阳县', '411600', '8');
INSERT INTO `ly_area` VALUES ('411627', '太康县', '411600', '9');
INSERT INTO `ly_area` VALUES ('411628', '鹿邑县', '411600', '10');
INSERT INTO `ly_area` VALUES ('411681', '项城市', '411600', '11');
INSERT INTO `ly_area` VALUES ('411701', '市辖区', '411700', '1');
INSERT INTO `ly_area` VALUES ('411702', '驿城区', '411700', '2');
INSERT INTO `ly_area` VALUES ('411721', '西平县', '411700', '3');
INSERT INTO `ly_area` VALUES ('411722', '上蔡县', '411700', '4');
INSERT INTO `ly_area` VALUES ('411723', '平舆县', '411700', '5');
INSERT INTO `ly_area` VALUES ('411724', '正阳县', '411700', '6');
INSERT INTO `ly_area` VALUES ('411725', '确山县', '411700', '7');
INSERT INTO `ly_area` VALUES ('411726', '泌阳县', '411700', '8');
INSERT INTO `ly_area` VALUES ('411727', '汝南县', '411700', '9');
INSERT INTO `ly_area` VALUES ('411728', '遂平县', '411700', '10');
INSERT INTO `ly_area` VALUES ('411729', '新蔡县', '411700', '11');
INSERT INTO `ly_area` VALUES ('420101', '市辖区', '420100', '1');
INSERT INTO `ly_area` VALUES ('420102', '江岸区', '420100', '2');
INSERT INTO `ly_area` VALUES ('420103', '江汉区', '420100', '3');
INSERT INTO `ly_area` VALUES ('420104', '乔口区', '420100', '4');
INSERT INTO `ly_area` VALUES ('420105', '汉阳区', '420100', '5');
INSERT INTO `ly_area` VALUES ('420106', '武昌区', '420100', '6');
INSERT INTO `ly_area` VALUES ('420107', '青山区', '420100', '7');
INSERT INTO `ly_area` VALUES ('420111', '洪山区', '420100', '8');
INSERT INTO `ly_area` VALUES ('420112', '东西湖区', '420100', '9');
INSERT INTO `ly_area` VALUES ('420113', '汉南区', '420100', '10');
INSERT INTO `ly_area` VALUES ('420114', '蔡甸区', '420100', '11');
INSERT INTO `ly_area` VALUES ('420115', '江夏区', '420100', '12');
INSERT INTO `ly_area` VALUES ('420116', '黄陂区', '420100', '13');
INSERT INTO `ly_area` VALUES ('420117', '新洲区', '420100', '14');
INSERT INTO `ly_area` VALUES ('420201', '市辖区', '420200', '1');
INSERT INTO `ly_area` VALUES ('420202', '黄石港区', '420200', '2');
INSERT INTO `ly_area` VALUES ('420203', '西塞山区', '420200', '3');
INSERT INTO `ly_area` VALUES ('420204', '下陆区', '420200', '4');
INSERT INTO `ly_area` VALUES ('420205', '铁山区', '420200', '5');
INSERT INTO `ly_area` VALUES ('420222', '阳新县', '420200', '6');
INSERT INTO `ly_area` VALUES ('420281', '大冶市', '420200', '7');
INSERT INTO `ly_area` VALUES ('420301', '市辖区', '420300', '1');
INSERT INTO `ly_area` VALUES ('420302', '茅箭区', '420300', '2');
INSERT INTO `ly_area` VALUES ('420303', '张湾区', '420300', '3');
INSERT INTO `ly_area` VALUES ('420321', '郧　县', '420300', '4');
INSERT INTO `ly_area` VALUES ('420322', '郧西县', '420300', '5');
INSERT INTO `ly_area` VALUES ('420323', '竹山县', '420300', '6');
INSERT INTO `ly_area` VALUES ('420324', '竹溪县', '420300', '7');
INSERT INTO `ly_area` VALUES ('420325', '房　县', '420300', '8');
INSERT INTO `ly_area` VALUES ('420381', '丹江口市', '420300', '9');
INSERT INTO `ly_area` VALUES ('420501', '市辖区', '420500', '1');
INSERT INTO `ly_area` VALUES ('420502', '西陵区', '420500', '2');
INSERT INTO `ly_area` VALUES ('420503', '伍家岗区', '420500', '3');
INSERT INTO `ly_area` VALUES ('420504', '点军区', '420500', '4');
INSERT INTO `ly_area` VALUES ('420505', '猇亭区', '420500', '5');
INSERT INTO `ly_area` VALUES ('420506', '夷陵区', '420500', '6');
INSERT INTO `ly_area` VALUES ('420525', '远安县', '420500', '7');
INSERT INTO `ly_area` VALUES ('420526', '兴山县', '420500', '8');
INSERT INTO `ly_area` VALUES ('420527', '秭归县', '420500', '9');
INSERT INTO `ly_area` VALUES ('420528', '长阳土家族自治县', '420500', '10');
INSERT INTO `ly_area` VALUES ('420529', '五峰土家族自治县', '420500', '11');
INSERT INTO `ly_area` VALUES ('420581', '宜都市', '420500', '12');
INSERT INTO `ly_area` VALUES ('420582', '当阳市', '420500', '13');
INSERT INTO `ly_area` VALUES ('420583', '枝江市', '420500', '14');
INSERT INTO `ly_area` VALUES ('420601', '市辖区', '420600', '1');
INSERT INTO `ly_area` VALUES ('420602', '襄城区', '420600', '2');
INSERT INTO `ly_area` VALUES ('420606', '樊城区', '420600', '3');
INSERT INTO `ly_area` VALUES ('420607', '襄阳区', '420600', '4');
INSERT INTO `ly_area` VALUES ('420624', '南漳县', '420600', '5');
INSERT INTO `ly_area` VALUES ('420625', '谷城县', '420600', '6');
INSERT INTO `ly_area` VALUES ('420626', '保康县', '420600', '7');
INSERT INTO `ly_area` VALUES ('420682', '老河口市', '420600', '8');
INSERT INTO `ly_area` VALUES ('420683', '枣阳市', '420600', '9');
INSERT INTO `ly_area` VALUES ('420684', '宜城市', '420600', '10');
INSERT INTO `ly_area` VALUES ('420701', '市辖区', '420700', '1');
INSERT INTO `ly_area` VALUES ('420702', '梁子湖区', '420700', '2');
INSERT INTO `ly_area` VALUES ('420703', '华容区', '420700', '3');
INSERT INTO `ly_area` VALUES ('420704', '鄂城区', '420700', '4');
INSERT INTO `ly_area` VALUES ('420801', '市辖区', '420800', '1');
INSERT INTO `ly_area` VALUES ('420802', '东宝区', '420800', '2');
INSERT INTO `ly_area` VALUES ('420804', '掇刀区', '420800', '3');
INSERT INTO `ly_area` VALUES ('420821', '京山县', '420800', '4');
INSERT INTO `ly_area` VALUES ('420822', '沙洋县', '420800', '5');
INSERT INTO `ly_area` VALUES ('420881', '钟祥市', '420800', '6');
INSERT INTO `ly_area` VALUES ('420901', '市辖区', '420900', '1');
INSERT INTO `ly_area` VALUES ('420902', '孝南区', '420900', '2');
INSERT INTO `ly_area` VALUES ('420921', '孝昌县', '420900', '3');
INSERT INTO `ly_area` VALUES ('420922', '大悟县', '420900', '4');
INSERT INTO `ly_area` VALUES ('420923', '云梦县', '420900', '5');
INSERT INTO `ly_area` VALUES ('420981', '应城市', '420900', '6');
INSERT INTO `ly_area` VALUES ('420982', '安陆市', '420900', '7');
INSERT INTO `ly_area` VALUES ('420984', '汉川市', '420900', '8');
INSERT INTO `ly_area` VALUES ('421001', '市辖区', '421000', '1');
INSERT INTO `ly_area` VALUES ('421002', '沙市区', '421000', '2');
INSERT INTO `ly_area` VALUES ('421003', '荆州区', '421000', '3');
INSERT INTO `ly_area` VALUES ('421022', '公安县', '421000', '4');
INSERT INTO `ly_area` VALUES ('421023', '监利县', '421000', '5');
INSERT INTO `ly_area` VALUES ('421024', '江陵县', '421000', '6');
INSERT INTO `ly_area` VALUES ('421081', '石首市', '421000', '7');
INSERT INTO `ly_area` VALUES ('421083', '洪湖市', '421000', '8');
INSERT INTO `ly_area` VALUES ('421087', '松滋市', '421000', '9');
INSERT INTO `ly_area` VALUES ('421101', '市辖区', '421100', '1');
INSERT INTO `ly_area` VALUES ('421102', '黄州区', '421100', '2');
INSERT INTO `ly_area` VALUES ('421121', '团风县', '421100', '3');
INSERT INTO `ly_area` VALUES ('421122', '红安县', '421100', '4');
INSERT INTO `ly_area` VALUES ('421123', '罗田县', '421100', '5');
INSERT INTO `ly_area` VALUES ('421124', '英山县', '421100', '6');
INSERT INTO `ly_area` VALUES ('421125', '浠水县', '421100', '7');
INSERT INTO `ly_area` VALUES ('421126', '蕲春县', '421100', '8');
INSERT INTO `ly_area` VALUES ('421127', '黄梅县', '421100', '9');
INSERT INTO `ly_area` VALUES ('421181', '麻城市', '421100', '10');
INSERT INTO `ly_area` VALUES ('421182', '武穴市', '421100', '11');
INSERT INTO `ly_area` VALUES ('421201', '市辖区', '421200', '1');
INSERT INTO `ly_area` VALUES ('421202', '咸安区', '421200', '2');
INSERT INTO `ly_area` VALUES ('421221', '嘉鱼县', '421200', '3');
INSERT INTO `ly_area` VALUES ('421222', '通城县', '421200', '4');
INSERT INTO `ly_area` VALUES ('421223', '崇阳县', '421200', '5');
INSERT INTO `ly_area` VALUES ('421224', '通山县', '421200', '6');
INSERT INTO `ly_area` VALUES ('421281', '赤壁市', '421200', '7');
INSERT INTO `ly_area` VALUES ('421301', '市辖区', '421300', '1');
INSERT INTO `ly_area` VALUES ('421302', '曾都区', '421300', '2');
INSERT INTO `ly_area` VALUES ('421381', '广水市', '421300', '3');
INSERT INTO `ly_area` VALUES ('422801', '恩施市', '422800', '1');
INSERT INTO `ly_area` VALUES ('422802', '利川市', '422800', '2');
INSERT INTO `ly_area` VALUES ('422822', '建始县', '422800', '3');
INSERT INTO `ly_area` VALUES ('422823', '巴东县', '422800', '4');
INSERT INTO `ly_area` VALUES ('422825', '宣恩县', '422800', '5');
INSERT INTO `ly_area` VALUES ('422826', '咸丰县', '422800', '6');
INSERT INTO `ly_area` VALUES ('422827', '来凤县', '422800', '7');
INSERT INTO `ly_area` VALUES ('422828', '鹤峰县', '422800', '8');
INSERT INTO `ly_area` VALUES ('429004', '仙桃市', '429000', '1');
INSERT INTO `ly_area` VALUES ('429005', '潜江市', '429000', '2');
INSERT INTO `ly_area` VALUES ('429006', '天门市', '429000', '3');
INSERT INTO `ly_area` VALUES ('429021', '神农架林区', '429000', '4');
INSERT INTO `ly_area` VALUES ('430101', '市辖区', '430100', '1');
INSERT INTO `ly_area` VALUES ('430102', '芙蓉区', '430100', '2');
INSERT INTO `ly_area` VALUES ('430103', '天心区', '430100', '3');
INSERT INTO `ly_area` VALUES ('430104', '岳麓区', '430100', '4');
INSERT INTO `ly_area` VALUES ('430105', '开福区', '430100', '5');
INSERT INTO `ly_area` VALUES ('430111', '雨花区', '430100', '6');
INSERT INTO `ly_area` VALUES ('430121', '长沙县', '430100', '7');
INSERT INTO `ly_area` VALUES ('430122', '望城县', '430100', '8');
INSERT INTO `ly_area` VALUES ('430124', '宁乡县', '430100', '9');
INSERT INTO `ly_area` VALUES ('430181', '浏阳市', '430100', '10');
INSERT INTO `ly_area` VALUES ('430201', '市辖区', '430200', '1');
INSERT INTO `ly_area` VALUES ('430202', '荷塘区', '430200', '2');
INSERT INTO `ly_area` VALUES ('430203', '芦淞区', '430200', '3');
INSERT INTO `ly_area` VALUES ('430204', '石峰区', '430200', '4');
INSERT INTO `ly_area` VALUES ('430211', '天元区', '430200', '5');
INSERT INTO `ly_area` VALUES ('430221', '株洲县', '430200', '6');
INSERT INTO `ly_area` VALUES ('430223', '攸　县', '430200', '7');
INSERT INTO `ly_area` VALUES ('430224', '茶陵县', '430200', '8');
INSERT INTO `ly_area` VALUES ('430225', '炎陵县', '430200', '9');
INSERT INTO `ly_area` VALUES ('430281', '醴陵市', '430200', '10');
INSERT INTO `ly_area` VALUES ('430301', '市辖区', '430300', '1');
INSERT INTO `ly_area` VALUES ('430302', '雨湖区', '430300', '2');
INSERT INTO `ly_area` VALUES ('430304', '岳塘区', '430300', '3');
INSERT INTO `ly_area` VALUES ('430321', '湘潭县', '430300', '4');
INSERT INTO `ly_area` VALUES ('430381', '湘乡市', '430300', '5');
INSERT INTO `ly_area` VALUES ('430382', '韶山市', '430300', '6');
INSERT INTO `ly_area` VALUES ('430401', '市辖区', '430400', '1');
INSERT INTO `ly_area` VALUES ('430405', '珠晖区', '430400', '2');
INSERT INTO `ly_area` VALUES ('430406', '雁峰区', '430400', '3');
INSERT INTO `ly_area` VALUES ('430407', '石鼓区', '430400', '4');
INSERT INTO `ly_area` VALUES ('430408', '蒸湘区', '430400', '5');
INSERT INTO `ly_area` VALUES ('430412', '南岳区', '430400', '6');
INSERT INTO `ly_area` VALUES ('430421', '衡阳县', '430400', '7');
INSERT INTO `ly_area` VALUES ('430422', '衡南县', '430400', '8');
INSERT INTO `ly_area` VALUES ('430423', '衡山县', '430400', '9');
INSERT INTO `ly_area` VALUES ('430424', '衡东县', '430400', '10');
INSERT INTO `ly_area` VALUES ('430426', '祁东县', '430400', '11');
INSERT INTO `ly_area` VALUES ('430481', '耒阳市', '430400', '12');
INSERT INTO `ly_area` VALUES ('430482', '常宁市', '430400', '13');
INSERT INTO `ly_area` VALUES ('430501', '市辖区', '430500', '1');
INSERT INTO `ly_area` VALUES ('430502', '双清区', '430500', '2');
INSERT INTO `ly_area` VALUES ('430503', '大祥区', '430500', '3');
INSERT INTO `ly_area` VALUES ('430511', '北塔区', '430500', '4');
INSERT INTO `ly_area` VALUES ('430521', '邵东县', '430500', '5');
INSERT INTO `ly_area` VALUES ('430522', '新邵县', '430500', '6');
INSERT INTO `ly_area` VALUES ('430523', '邵阳县', '430500', '7');
INSERT INTO `ly_area` VALUES ('430524', '隆回县', '430500', '8');
INSERT INTO `ly_area` VALUES ('430525', '洞口县', '430500', '9');
INSERT INTO `ly_area` VALUES ('430527', '绥宁县', '430500', '10');
INSERT INTO `ly_area` VALUES ('430528', '新宁县', '430500', '11');
INSERT INTO `ly_area` VALUES ('430529', '城步苗族自治县', '430500', '12');
INSERT INTO `ly_area` VALUES ('430581', '武冈市', '430500', '13');
INSERT INTO `ly_area` VALUES ('430601', '市辖区', '430600', '1');
INSERT INTO `ly_area` VALUES ('430602', '岳阳楼区', '430600', '2');
INSERT INTO `ly_area` VALUES ('430603', '云溪区', '430600', '3');
INSERT INTO `ly_area` VALUES ('430611', '君山区', '430600', '4');
INSERT INTO `ly_area` VALUES ('430621', '岳阳县', '430600', '5');
INSERT INTO `ly_area` VALUES ('430623', '华容县', '430600', '6');
INSERT INTO `ly_area` VALUES ('430624', '湘阴县', '430600', '7');
INSERT INTO `ly_area` VALUES ('430626', '平江县', '430600', '8');
INSERT INTO `ly_area` VALUES ('430681', '汨罗市', '430600', '9');
INSERT INTO `ly_area` VALUES ('430682', '临湘市', '430600', '10');
INSERT INTO `ly_area` VALUES ('430701', '市辖区', '430700', '1');
INSERT INTO `ly_area` VALUES ('430702', '武陵区', '430700', '2');
INSERT INTO `ly_area` VALUES ('430703', '鼎城区', '430700', '3');
INSERT INTO `ly_area` VALUES ('430721', '安乡县', '430700', '4');
INSERT INTO `ly_area` VALUES ('430722', '汉寿县', '430700', '5');
INSERT INTO `ly_area` VALUES ('430723', '澧　县', '430700', '6');
INSERT INTO `ly_area` VALUES ('430724', '临澧县', '430700', '7');
INSERT INTO `ly_area` VALUES ('430725', '桃源县', '430700', '8');
INSERT INTO `ly_area` VALUES ('430726', '石门县', '430700', '9');
INSERT INTO `ly_area` VALUES ('430781', '津市市', '430700', '10');
INSERT INTO `ly_area` VALUES ('430801', '市辖区', '430800', '1');
INSERT INTO `ly_area` VALUES ('430802', '永定区', '430800', '2');
INSERT INTO `ly_area` VALUES ('430811', '武陵源区', '430800', '3');
INSERT INTO `ly_area` VALUES ('430821', '慈利县', '430800', '4');
INSERT INTO `ly_area` VALUES ('430822', '桑植县', '430800', '5');
INSERT INTO `ly_area` VALUES ('430901', '市辖区', '430900', '1');
INSERT INTO `ly_area` VALUES ('430902', '资阳区', '430900', '2');
INSERT INTO `ly_area` VALUES ('430903', '赫山区', '430900', '3');
INSERT INTO `ly_area` VALUES ('430921', '南　县', '430900', '4');
INSERT INTO `ly_area` VALUES ('430922', '桃江县', '430900', '5');
INSERT INTO `ly_area` VALUES ('430923', '安化县', '430900', '6');
INSERT INTO `ly_area` VALUES ('430981', '沅江市', '430900', '7');
INSERT INTO `ly_area` VALUES ('431001', '市辖区', '431000', '1');
INSERT INTO `ly_area` VALUES ('431002', '北湖区', '431000', '2');
INSERT INTO `ly_area` VALUES ('431003', '苏仙区', '431000', '3');
INSERT INTO `ly_area` VALUES ('431021', '桂阳县', '431000', '4');
INSERT INTO `ly_area` VALUES ('431022', '宜章县', '431000', '5');
INSERT INTO `ly_area` VALUES ('431023', '永兴县', '431000', '6');
INSERT INTO `ly_area` VALUES ('431024', '嘉禾县', '431000', '7');
INSERT INTO `ly_area` VALUES ('431025', '临武县', '431000', '8');
INSERT INTO `ly_area` VALUES ('431026', '汝城县', '431000', '9');
INSERT INTO `ly_area` VALUES ('431027', '桂东县', '431000', '10');
INSERT INTO `ly_area` VALUES ('431028', '安仁县', '431000', '11');
INSERT INTO `ly_area` VALUES ('431081', '资兴市', '431000', '12');
INSERT INTO `ly_area` VALUES ('431101', '市辖区', '431100', '1');
INSERT INTO `ly_area` VALUES ('431102', '芝山区', '431100', '2');
INSERT INTO `ly_area` VALUES ('431103', '冷水滩区', '431100', '3');
INSERT INTO `ly_area` VALUES ('431121', '祁阳县', '431100', '4');
INSERT INTO `ly_area` VALUES ('431122', '东安县', '431100', '5');
INSERT INTO `ly_area` VALUES ('431123', '双牌县', '431100', '6');
INSERT INTO `ly_area` VALUES ('431124', '道　县', '431100', '7');
INSERT INTO `ly_area` VALUES ('431125', '江永县', '431100', '8');
INSERT INTO `ly_area` VALUES ('431126', '宁远县', '431100', '9');
INSERT INTO `ly_area` VALUES ('431127', '蓝山县', '431100', '10');
INSERT INTO `ly_area` VALUES ('431128', '新田县', '431100', '11');
INSERT INTO `ly_area` VALUES ('431129', '江华瑶族自治县', '431100', '12');
INSERT INTO `ly_area` VALUES ('431201', '市辖区', '431200', '1');
INSERT INTO `ly_area` VALUES ('431202', '鹤城区', '431200', '2');
INSERT INTO `ly_area` VALUES ('431221', '中方县', '431200', '3');
INSERT INTO `ly_area` VALUES ('431222', '沅陵县', '431200', '4');
INSERT INTO `ly_area` VALUES ('431223', '辰溪县', '431200', '5');
INSERT INTO `ly_area` VALUES ('431224', '溆浦县', '431200', '6');
INSERT INTO `ly_area` VALUES ('431225', '会同县', '431200', '7');
INSERT INTO `ly_area` VALUES ('431226', '麻阳苗族自治县', '431200', '8');
INSERT INTO `ly_area` VALUES ('431227', '新晃侗族自治县', '431200', '9');
INSERT INTO `ly_area` VALUES ('431228', '芷江侗族自治县', '431200', '10');
INSERT INTO `ly_area` VALUES ('431229', '靖州苗族侗族自治县', '431200', '11');
INSERT INTO `ly_area` VALUES ('431230', '通道侗族自治县', '431200', '12');
INSERT INTO `ly_area` VALUES ('431281', '洪江市', '431200', '13');
INSERT INTO `ly_area` VALUES ('431301', '市辖区', '431300', '1');
INSERT INTO `ly_area` VALUES ('431302', '娄星区', '431300', '2');
INSERT INTO `ly_area` VALUES ('431321', '双峰县', '431300', '3');
INSERT INTO `ly_area` VALUES ('431322', '新化县', '431300', '4');
INSERT INTO `ly_area` VALUES ('431381', '冷水江市', '431300', '5');
INSERT INTO `ly_area` VALUES ('431382', '涟源市', '431300', '6');
INSERT INTO `ly_area` VALUES ('433101', '吉首市', '433100', '1');
INSERT INTO `ly_area` VALUES ('433122', '泸溪县', '433100', '2');
INSERT INTO `ly_area` VALUES ('433123', '凤凰县', '433100', '3');
INSERT INTO `ly_area` VALUES ('433124', '花垣县', '433100', '4');
INSERT INTO `ly_area` VALUES ('433125', '保靖县', '433100', '5');
INSERT INTO `ly_area` VALUES ('433126', '古丈县', '433100', '6');
INSERT INTO `ly_area` VALUES ('433127', '永顺县', '433100', '7');
INSERT INTO `ly_area` VALUES ('433130', '龙山县', '433100', '8');
INSERT INTO `ly_area` VALUES ('440101', '市辖区', '440100', '1');
INSERT INTO `ly_area` VALUES ('440102', '东山区', '440100', '2');
INSERT INTO `ly_area` VALUES ('440103', '荔湾区', '440100', '3');
INSERT INTO `ly_area` VALUES ('440104', '越秀区', '440100', '4');
INSERT INTO `ly_area` VALUES ('440105', '海珠区', '440100', '5');
INSERT INTO `ly_area` VALUES ('440106', '天河区', '440100', '6');
INSERT INTO `ly_area` VALUES ('440107', '芳村区', '440100', '7');
INSERT INTO `ly_area` VALUES ('440111', '白云区', '440100', '8');
INSERT INTO `ly_area` VALUES ('440112', '黄埔区', '440100', '9');
INSERT INTO `ly_area` VALUES ('440113', '番禺区', '440100', '10');
INSERT INTO `ly_area` VALUES ('440114', '花都区', '440100', '11');
INSERT INTO `ly_area` VALUES ('440183', '增城市', '440100', '12');
INSERT INTO `ly_area` VALUES ('440184', '从化市', '440100', '13');
INSERT INTO `ly_area` VALUES ('440201', '市辖区', '440200', '1');
INSERT INTO `ly_area` VALUES ('440203', '武江区', '440200', '2');
INSERT INTO `ly_area` VALUES ('440204', '浈江区', '440200', '3');
INSERT INTO `ly_area` VALUES ('440205', '曲江区', '440200', '4');
INSERT INTO `ly_area` VALUES ('440222', '始兴县', '440200', '5');
INSERT INTO `ly_area` VALUES ('440224', '仁化县', '440200', '6');
INSERT INTO `ly_area` VALUES ('440229', '翁源县', '440200', '7');
INSERT INTO `ly_area` VALUES ('440232', '乳源瑶族自治县', '440200', '8');
INSERT INTO `ly_area` VALUES ('440233', '新丰县', '440200', '9');
INSERT INTO `ly_area` VALUES ('440281', '乐昌市', '440200', '10');
INSERT INTO `ly_area` VALUES ('440282', '南雄市', '440200', '11');
INSERT INTO `ly_area` VALUES ('440301', '市辖区', '440300', '1');
INSERT INTO `ly_area` VALUES ('440303', '罗湖区', '440300', '2');
INSERT INTO `ly_area` VALUES ('440304', '福田区', '440300', '3');
INSERT INTO `ly_area` VALUES ('440305', '南山区', '440300', '4');
INSERT INTO `ly_area` VALUES ('440306', '宝安区', '440300', '5');
INSERT INTO `ly_area` VALUES ('440307', '龙岗区', '440300', '6');
INSERT INTO `ly_area` VALUES ('440308', '盐田区', '440300', '7');
INSERT INTO `ly_area` VALUES ('440401', '市辖区', '440400', '1');
INSERT INTO `ly_area` VALUES ('440402', '香洲区', '440400', '2');
INSERT INTO `ly_area` VALUES ('440403', '斗门区', '440400', '3');
INSERT INTO `ly_area` VALUES ('440404', '金湾区', '440400', '4');
INSERT INTO `ly_area` VALUES ('440501', '市辖区', '440500', '1');
INSERT INTO `ly_area` VALUES ('440507', '龙湖区', '440500', '2');
INSERT INTO `ly_area` VALUES ('440511', '金平区', '440500', '3');
INSERT INTO `ly_area` VALUES ('440512', '濠江区', '440500', '4');
INSERT INTO `ly_area` VALUES ('440513', '潮阳区', '440500', '5');
INSERT INTO `ly_area` VALUES ('440514', '潮南区', '440500', '6');
INSERT INTO `ly_area` VALUES ('440515', '澄海区', '440500', '7');
INSERT INTO `ly_area` VALUES ('440523', '南澳县', '440500', '8');
INSERT INTO `ly_area` VALUES ('440601', '市辖区', '440600', '1');
INSERT INTO `ly_area` VALUES ('440604', '禅城区', '440600', '2');
INSERT INTO `ly_area` VALUES ('440605', '南海区', '440600', '3');
INSERT INTO `ly_area` VALUES ('440606', '顺德区', '440600', '4');
INSERT INTO `ly_area` VALUES ('440607', '三水区', '440600', '5');
INSERT INTO `ly_area` VALUES ('440608', '高明区', '440600', '6');
INSERT INTO `ly_area` VALUES ('440701', '市辖区', '440700', '1');
INSERT INTO `ly_area` VALUES ('440703', '蓬江区', '440700', '2');
INSERT INTO `ly_area` VALUES ('440704', '江海区', '440700', '3');
INSERT INTO `ly_area` VALUES ('440705', '新会区', '440700', '4');
INSERT INTO `ly_area` VALUES ('440781', '台山市', '440700', '5');
INSERT INTO `ly_area` VALUES ('440783', '开平市', '440700', '6');
INSERT INTO `ly_area` VALUES ('440784', '鹤山市', '440700', '7');
INSERT INTO `ly_area` VALUES ('440785', '恩平市', '440700', '8');
INSERT INTO `ly_area` VALUES ('440801', '市辖区', '440800', '1');
INSERT INTO `ly_area` VALUES ('440802', '赤坎区', '440800', '2');
INSERT INTO `ly_area` VALUES ('440803', '霞山区', '440800', '3');
INSERT INTO `ly_area` VALUES ('440804', '坡头区', '440800', '4');
INSERT INTO `ly_area` VALUES ('440811', '麻章区', '440800', '5');
INSERT INTO `ly_area` VALUES ('440823', '遂溪县', '440800', '6');
INSERT INTO `ly_area` VALUES ('440825', '徐闻县', '440800', '7');
INSERT INTO `ly_area` VALUES ('440881', '廉江市', '440800', '8');
INSERT INTO `ly_area` VALUES ('440882', '雷州市', '440800', '9');
INSERT INTO `ly_area` VALUES ('440883', '吴川市', '440800', '10');
INSERT INTO `ly_area` VALUES ('440901', '市辖区', '440900', '1');
INSERT INTO `ly_area` VALUES ('440902', '茂南区', '440900', '2');
INSERT INTO `ly_area` VALUES ('440903', '茂港区', '440900', '3');
INSERT INTO `ly_area` VALUES ('440923', '电白县', '440900', '4');
INSERT INTO `ly_area` VALUES ('440981', '高州市', '440900', '5');
INSERT INTO `ly_area` VALUES ('440982', '化州市', '440900', '6');
INSERT INTO `ly_area` VALUES ('440983', '信宜市', '440900', '7');
INSERT INTO `ly_area` VALUES ('441201', '市辖区', '441200', '1');
INSERT INTO `ly_area` VALUES ('441202', '端州区', '441200', '2');
INSERT INTO `ly_area` VALUES ('441203', '鼎湖区', '441200', '3');
INSERT INTO `ly_area` VALUES ('441223', '广宁县', '441200', '4');
INSERT INTO `ly_area` VALUES ('441224', '怀集县', '441200', '5');
INSERT INTO `ly_area` VALUES ('441225', '封开县', '441200', '6');
INSERT INTO `ly_area` VALUES ('441226', '德庆县', '441200', '7');
INSERT INTO `ly_area` VALUES ('441283', '高要市', '441200', '8');
INSERT INTO `ly_area` VALUES ('441284', '四会市', '441200', '9');
INSERT INTO `ly_area` VALUES ('441301', '市辖区', '441300', '1');
INSERT INTO `ly_area` VALUES ('441302', '惠城区', '441300', '2');
INSERT INTO `ly_area` VALUES ('441303', '惠阳区', '441300', '3');
INSERT INTO `ly_area` VALUES ('441322', '博罗县', '441300', '4');
INSERT INTO `ly_area` VALUES ('441323', '惠东县', '441300', '5');
INSERT INTO `ly_area` VALUES ('441324', '龙门县', '441300', '6');
INSERT INTO `ly_area` VALUES ('441401', '市辖区', '441400', '1');
INSERT INTO `ly_area` VALUES ('441402', '梅江区', '441400', '2');
INSERT INTO `ly_area` VALUES ('441421', '梅　县', '441400', '3');
INSERT INTO `ly_area` VALUES ('441422', '大埔县', '441400', '4');
INSERT INTO `ly_area` VALUES ('441423', '丰顺县', '441400', '5');
INSERT INTO `ly_area` VALUES ('441424', '五华县', '441400', '6');
INSERT INTO `ly_area` VALUES ('441426', '平远县', '441400', '7');
INSERT INTO `ly_area` VALUES ('441427', '蕉岭县', '441400', '8');
INSERT INTO `ly_area` VALUES ('441481', '兴宁市', '441400', '9');
INSERT INTO `ly_area` VALUES ('441501', '市辖区', '441500', '1');
INSERT INTO `ly_area` VALUES ('441502', '城　区', '441500', '2');
INSERT INTO `ly_area` VALUES ('441521', '海丰县', '441500', '3');
INSERT INTO `ly_area` VALUES ('441523', '陆河县', '441500', '4');
INSERT INTO `ly_area` VALUES ('441581', '陆丰市', '441500', '5');
INSERT INTO `ly_area` VALUES ('441601', '市辖区', '441600', '1');
INSERT INTO `ly_area` VALUES ('441602', '源城区', '441600', '2');
INSERT INTO `ly_area` VALUES ('441621', '紫金县', '441600', '3');
INSERT INTO `ly_area` VALUES ('441622', '龙川县', '441600', '4');
INSERT INTO `ly_area` VALUES ('441623', '连平县', '441600', '5');
INSERT INTO `ly_area` VALUES ('441624', '和平县', '441600', '6');
INSERT INTO `ly_area` VALUES ('441625', '东源县', '441600', '7');
INSERT INTO `ly_area` VALUES ('441701', '市辖区', '441700', '1');
INSERT INTO `ly_area` VALUES ('441702', '江城区', '441700', '2');
INSERT INTO `ly_area` VALUES ('441721', '阳西县', '441700', '3');
INSERT INTO `ly_area` VALUES ('441723', '阳东县', '441700', '4');
INSERT INTO `ly_area` VALUES ('441781', '阳春市', '441700', '5');
INSERT INTO `ly_area` VALUES ('441801', '市辖区', '441800', '1');
INSERT INTO `ly_area` VALUES ('441802', '清城区', '441800', '2');
INSERT INTO `ly_area` VALUES ('441821', '佛冈县', '441800', '3');
INSERT INTO `ly_area` VALUES ('441823', '阳山县', '441800', '4');
INSERT INTO `ly_area` VALUES ('441825', '连山壮族瑶族自治县', '441800', '5');
INSERT INTO `ly_area` VALUES ('441826', '连南瑶族自治县', '441800', '6');
INSERT INTO `ly_area` VALUES ('441827', '清新县', '441800', '7');
INSERT INTO `ly_area` VALUES ('441881', '英德市', '441800', '8');
INSERT INTO `ly_area` VALUES ('441882', '连州市', '441800', '9');
INSERT INTO `ly_area` VALUES ('445101', '市辖区', '445100', '1');
INSERT INTO `ly_area` VALUES ('445102', '湘桥区', '445100', '2');
INSERT INTO `ly_area` VALUES ('445121', '潮安县', '445100', '3');
INSERT INTO `ly_area` VALUES ('445122', '饶平县', '445100', '4');
INSERT INTO `ly_area` VALUES ('445201', '市辖区', '445200', '1');
INSERT INTO `ly_area` VALUES ('445202', '榕城区', '445200', '2');
INSERT INTO `ly_area` VALUES ('445221', '揭东县', '445200', '3');
INSERT INTO `ly_area` VALUES ('445222', '揭西县', '445200', '4');
INSERT INTO `ly_area` VALUES ('445224', '惠来县', '445200', '5');
INSERT INTO `ly_area` VALUES ('445281', '普宁市', '445200', '6');
INSERT INTO `ly_area` VALUES ('445301', '市辖区', '445300', '1');
INSERT INTO `ly_area` VALUES ('445302', '云城区', '445300', '2');
INSERT INTO `ly_area` VALUES ('445321', '新兴县', '445300', '3');
INSERT INTO `ly_area` VALUES ('445322', '郁南县', '445300', '4');
INSERT INTO `ly_area` VALUES ('445323', '云安县', '445300', '5');
INSERT INTO `ly_area` VALUES ('445381', '罗定市', '445300', '6');
INSERT INTO `ly_area` VALUES ('450101', '市辖区', '450100', '1');
INSERT INTO `ly_area` VALUES ('450102', '兴宁区', '450100', '2');
INSERT INTO `ly_area` VALUES ('450103', '青秀区', '450100', '3');
INSERT INTO `ly_area` VALUES ('450105', '江南区', '450100', '4');
INSERT INTO `ly_area` VALUES ('450107', '西乡塘区', '450100', '5');
INSERT INTO `ly_area` VALUES ('450108', '良庆区', '450100', '6');
INSERT INTO `ly_area` VALUES ('450109', '邕宁区', '450100', '7');
INSERT INTO `ly_area` VALUES ('450122', '武鸣县', '450100', '8');
INSERT INTO `ly_area` VALUES ('450123', '隆安县', '450100', '9');
INSERT INTO `ly_area` VALUES ('450124', '马山县', '450100', '10');
INSERT INTO `ly_area` VALUES ('450125', '上林县', '450100', '11');
INSERT INTO `ly_area` VALUES ('450126', '宾阳县', '450100', '12');
INSERT INTO `ly_area` VALUES ('450127', '横　县', '450100', '13');
INSERT INTO `ly_area` VALUES ('450201', '市辖区', '450200', '1');
INSERT INTO `ly_area` VALUES ('450202', '城中区', '450200', '2');
INSERT INTO `ly_area` VALUES ('450203', '鱼峰区', '450200', '3');
INSERT INTO `ly_area` VALUES ('450204', '柳南区', '450200', '4');
INSERT INTO `ly_area` VALUES ('450205', '柳北区', '450200', '5');
INSERT INTO `ly_area` VALUES ('450221', '柳江县', '450200', '6');
INSERT INTO `ly_area` VALUES ('450222', '柳城县', '450200', '7');
INSERT INTO `ly_area` VALUES ('450223', '鹿寨县', '450200', '8');
INSERT INTO `ly_area` VALUES ('450224', '融安县', '450200', '9');
INSERT INTO `ly_area` VALUES ('450225', '融水苗族自治县', '450200', '10');
INSERT INTO `ly_area` VALUES ('450226', '三江侗族自治县', '450200', '11');
INSERT INTO `ly_area` VALUES ('450301', '市辖区', '450300', '1');
INSERT INTO `ly_area` VALUES ('450302', '秀峰区', '450300', '2');
INSERT INTO `ly_area` VALUES ('450303', '叠彩区', '450300', '3');
INSERT INTO `ly_area` VALUES ('450304', '象山区', '450300', '4');
INSERT INTO `ly_area` VALUES ('450305', '七星区', '450300', '5');
INSERT INTO `ly_area` VALUES ('450311', '雁山区', '450300', '6');
INSERT INTO `ly_area` VALUES ('450321', '阳朔县', '450300', '7');
INSERT INTO `ly_area` VALUES ('450322', '临桂县', '450300', '8');
INSERT INTO `ly_area` VALUES ('450323', '灵川县', '450300', '9');
INSERT INTO `ly_area` VALUES ('450324', '全州县', '450300', '10');
INSERT INTO `ly_area` VALUES ('450325', '兴安县', '450300', '11');
INSERT INTO `ly_area` VALUES ('450326', '永福县', '450300', '12');
INSERT INTO `ly_area` VALUES ('450327', '灌阳县', '450300', '13');
INSERT INTO `ly_area` VALUES ('450328', '龙胜各族自治县', '450300', '14');
INSERT INTO `ly_area` VALUES ('450329', '资源县', '450300', '15');
INSERT INTO `ly_area` VALUES ('450330', '平乐县', '450300', '16');
INSERT INTO `ly_area` VALUES ('450331', '荔蒲县', '450300', '17');
INSERT INTO `ly_area` VALUES ('450332', '恭城瑶族自治县', '450300', '18');
INSERT INTO `ly_area` VALUES ('450401', '市辖区', '450400', '1');
INSERT INTO `ly_area` VALUES ('450403', '万秀区', '450400', '2');
INSERT INTO `ly_area` VALUES ('450404', '蝶山区', '450400', '3');
INSERT INTO `ly_area` VALUES ('450405', '长洲区', '450400', '4');
INSERT INTO `ly_area` VALUES ('450421', '苍梧县', '450400', '5');
INSERT INTO `ly_area` VALUES ('450422', '藤　县', '450400', '6');
INSERT INTO `ly_area` VALUES ('450423', '蒙山县', '450400', '7');
INSERT INTO `ly_area` VALUES ('450481', '岑溪市', '450400', '8');
INSERT INTO `ly_area` VALUES ('450501', '市辖区', '450500', '1');
INSERT INTO `ly_area` VALUES ('450502', '海城区', '450500', '2');
INSERT INTO `ly_area` VALUES ('450503', '银海区', '450500', '3');
INSERT INTO `ly_area` VALUES ('450512', '铁山港区', '450500', '4');
INSERT INTO `ly_area` VALUES ('450521', '合浦县', '450500', '5');
INSERT INTO `ly_area` VALUES ('450601', '市辖区', '450600', '1');
INSERT INTO `ly_area` VALUES ('450602', '港口区', '450600', '2');
INSERT INTO `ly_area` VALUES ('450603', '防城区', '450600', '3');
INSERT INTO `ly_area` VALUES ('450621', '上思县', '450600', '4');
INSERT INTO `ly_area` VALUES ('450681', '东兴市', '450600', '5');
INSERT INTO `ly_area` VALUES ('450701', '市辖区', '450700', '1');
INSERT INTO `ly_area` VALUES ('450702', '钦南区', '450700', '2');
INSERT INTO `ly_area` VALUES ('450703', '钦北区', '450700', '3');
INSERT INTO `ly_area` VALUES ('450721', '灵山县', '450700', '4');
INSERT INTO `ly_area` VALUES ('450722', '浦北县', '450700', '5');
INSERT INTO `ly_area` VALUES ('450801', '市辖区', '450800', '1');
INSERT INTO `ly_area` VALUES ('450802', '港北区', '450800', '2');
INSERT INTO `ly_area` VALUES ('450803', '港南区', '450800', '3');
INSERT INTO `ly_area` VALUES ('450804', '覃塘区', '450800', '4');
INSERT INTO `ly_area` VALUES ('450821', '平南县', '450800', '5');
INSERT INTO `ly_area` VALUES ('450881', '桂平市', '450800', '6');
INSERT INTO `ly_area` VALUES ('450901', '市辖区', '450900', '1');
INSERT INTO `ly_area` VALUES ('450902', '玉州区', '450900', '2');
INSERT INTO `ly_area` VALUES ('450921', '容　县', '450900', '3');
INSERT INTO `ly_area` VALUES ('450922', '陆川县', '450900', '4');
INSERT INTO `ly_area` VALUES ('450923', '博白县', '450900', '5');
INSERT INTO `ly_area` VALUES ('450924', '兴业县', '450900', '6');
INSERT INTO `ly_area` VALUES ('450981', '北流市', '450900', '7');
INSERT INTO `ly_area` VALUES ('451001', '市辖区', '451000', '1');
INSERT INTO `ly_area` VALUES ('451002', '右江区', '451000', '2');
INSERT INTO `ly_area` VALUES ('451021', '田阳县', '451000', '3');
INSERT INTO `ly_area` VALUES ('451022', '田东县', '451000', '4');
INSERT INTO `ly_area` VALUES ('451023', '平果县', '451000', '5');
INSERT INTO `ly_area` VALUES ('451024', '德保县', '451000', '6');
INSERT INTO `ly_area` VALUES ('451025', '靖西县', '451000', '7');
INSERT INTO `ly_area` VALUES ('451026', '那坡县', '451000', '8');
INSERT INTO `ly_area` VALUES ('451027', '凌云县', '451000', '9');
INSERT INTO `ly_area` VALUES ('451028', '乐业县', '451000', '10');
INSERT INTO `ly_area` VALUES ('451029', '田林县', '451000', '11');
INSERT INTO `ly_area` VALUES ('451030', '西林县', '451000', '12');
INSERT INTO `ly_area` VALUES ('451031', '隆林各族自治县', '451000', '13');
INSERT INTO `ly_area` VALUES ('451101', '市辖区', '451100', '1');
INSERT INTO `ly_area` VALUES ('451102', '八步区', '451100', '2');
INSERT INTO `ly_area` VALUES ('451121', '昭平县', '451100', '3');
INSERT INTO `ly_area` VALUES ('451122', '钟山县', '451100', '4');
INSERT INTO `ly_area` VALUES ('451123', '富川瑶族自治县', '451100', '5');
INSERT INTO `ly_area` VALUES ('451201', '市辖区', '451200', '1');
INSERT INTO `ly_area` VALUES ('451202', '金城江区', '451200', '2');
INSERT INTO `ly_area` VALUES ('451221', '南丹县', '451200', '3');
INSERT INTO `ly_area` VALUES ('451222', '天峨县', '451200', '4');
INSERT INTO `ly_area` VALUES ('451223', '凤山县', '451200', '5');
INSERT INTO `ly_area` VALUES ('451224', '东兰县', '451200', '6');
INSERT INTO `ly_area` VALUES ('451225', '罗城仫佬族自治县', '451200', '7');
INSERT INTO `ly_area` VALUES ('451226', '环江毛南族自治县', '451200', '8');
INSERT INTO `ly_area` VALUES ('451227', '巴马瑶族自治县', '451200', '9');
INSERT INTO `ly_area` VALUES ('451228', '都安瑶族自治县', '451200', '10');
INSERT INTO `ly_area` VALUES ('451229', '大化瑶族自治县', '451200', '11');
INSERT INTO `ly_area` VALUES ('451281', '宜州市', '451200', '12');
INSERT INTO `ly_area` VALUES ('451301', '市辖区', '451300', '1');
INSERT INTO `ly_area` VALUES ('451302', '兴宾区', '451300', '2');
INSERT INTO `ly_area` VALUES ('451321', '忻城县', '451300', '3');
INSERT INTO `ly_area` VALUES ('451322', '象州县', '451300', '4');
INSERT INTO `ly_area` VALUES ('451323', '武宣县', '451300', '5');
INSERT INTO `ly_area` VALUES ('451324', '金秀瑶族自治县', '451300', '6');
INSERT INTO `ly_area` VALUES ('451381', '合山市', '451300', '7');
INSERT INTO `ly_area` VALUES ('451401', '市辖区', '451400', '1');
INSERT INTO `ly_area` VALUES ('451402', '江洲区', '451400', '2');
INSERT INTO `ly_area` VALUES ('451421', '扶绥县', '451400', '3');
INSERT INTO `ly_area` VALUES ('451422', '宁明县', '451400', '4');
INSERT INTO `ly_area` VALUES ('451423', '龙州县', '451400', '5');
INSERT INTO `ly_area` VALUES ('451424', '大新县', '451400', '6');
INSERT INTO `ly_area` VALUES ('451425', '天等县', '451400', '7');
INSERT INTO `ly_area` VALUES ('451481', '凭祥市', '451400', '8');
INSERT INTO `ly_area` VALUES ('460101', '市辖区', '460100', '1');
INSERT INTO `ly_area` VALUES ('460105', '秀英区', '460100', '2');
INSERT INTO `ly_area` VALUES ('460106', '龙华区', '460100', '3');
INSERT INTO `ly_area` VALUES ('460107', '琼山区', '460100', '4');
INSERT INTO `ly_area` VALUES ('460108', '美兰区', '460100', '5');
INSERT INTO `ly_area` VALUES ('460201', '市辖区', '460200', '1');
INSERT INTO `ly_area` VALUES ('469001', '五指山市', '469000', '1');
INSERT INTO `ly_area` VALUES ('469002', '琼海市', '469000', '2');
INSERT INTO `ly_area` VALUES ('469003', '儋州市', '469000', '3');
INSERT INTO `ly_area` VALUES ('469005', '文昌市', '469000', '4');
INSERT INTO `ly_area` VALUES ('469006', '万宁市', '469000', '5');
INSERT INTO `ly_area` VALUES ('469007', '东方市', '469000', '6');
INSERT INTO `ly_area` VALUES ('469025', '定安县', '469000', '7');
INSERT INTO `ly_area` VALUES ('469026', '屯昌县', '469000', '8');
INSERT INTO `ly_area` VALUES ('469027', '澄迈县', '469000', '9');
INSERT INTO `ly_area` VALUES ('469028', '临高县', '469000', '10');
INSERT INTO `ly_area` VALUES ('469030', '白沙黎族自治县', '469000', '11');
INSERT INTO `ly_area` VALUES ('469031', '昌江黎族自治县', '469000', '12');
INSERT INTO `ly_area` VALUES ('469033', '乐东黎族自治县', '469000', '13');
INSERT INTO `ly_area` VALUES ('469034', '陵水黎族自治县', '469000', '14');
INSERT INTO `ly_area` VALUES ('469035', '保亭黎族苗族自治县', '469000', '15');
INSERT INTO `ly_area` VALUES ('469036', '琼中黎族苗族自治县', '469000', '16');
INSERT INTO `ly_area` VALUES ('469037', '西沙群岛', '469000', '17');
INSERT INTO `ly_area` VALUES ('469038', '南沙群岛', '469000', '18');
INSERT INTO `ly_area` VALUES ('469039', '中沙群岛的岛礁及其海域', '469000', '19');
INSERT INTO `ly_area` VALUES ('500101', '万州区', '500100', '1');
INSERT INTO `ly_area` VALUES ('500102', '涪陵区', '500100', '2');
INSERT INTO `ly_area` VALUES ('500103', '渝中区', '500100', '3');
INSERT INTO `ly_area` VALUES ('500104', '大渡口区', '500100', '4');
INSERT INTO `ly_area` VALUES ('500105', '江北区', '500100', '5');
INSERT INTO `ly_area` VALUES ('500106', '沙坪坝区', '500100', '6');
INSERT INTO `ly_area` VALUES ('500107', '九龙坡区', '500100', '7');
INSERT INTO `ly_area` VALUES ('500108', '南岸区', '500100', '8');
INSERT INTO `ly_area` VALUES ('500109', '北碚区', '500100', '9');
INSERT INTO `ly_area` VALUES ('500110', '万盛区', '500100', '10');
INSERT INTO `ly_area` VALUES ('500111', '双桥区', '500100', '11');
INSERT INTO `ly_area` VALUES ('500112', '渝北区', '500100', '12');
INSERT INTO `ly_area` VALUES ('500113', '巴南区', '500100', '13');
INSERT INTO `ly_area` VALUES ('500114', '黔江区', '500100', '14');
INSERT INTO `ly_area` VALUES ('500115', '长寿区', '500100', '15');
INSERT INTO `ly_area` VALUES ('500222', '綦江县', '500200', '1');
INSERT INTO `ly_area` VALUES ('500223', '潼南县', '500200', '2');
INSERT INTO `ly_area` VALUES ('500224', '铜梁县', '500200', '3');
INSERT INTO `ly_area` VALUES ('500225', '大足县', '500200', '4');
INSERT INTO `ly_area` VALUES ('500226', '荣昌县', '500200', '5');
INSERT INTO `ly_area` VALUES ('500227', '璧山县', '500200', '6');
INSERT INTO `ly_area` VALUES ('500228', '梁平县', '500200', '7');
INSERT INTO `ly_area` VALUES ('500229', '城口县', '500200', '8');
INSERT INTO `ly_area` VALUES ('500230', '丰都县', '500200', '9');
INSERT INTO `ly_area` VALUES ('500231', '垫江县', '500200', '10');
INSERT INTO `ly_area` VALUES ('500232', '武隆县', '500200', '11');
INSERT INTO `ly_area` VALUES ('500233', '忠　县', '500200', '12');
INSERT INTO `ly_area` VALUES ('500234', '开　县', '500200', '13');
INSERT INTO `ly_area` VALUES ('500235', '云阳县', '500200', '14');
INSERT INTO `ly_area` VALUES ('500236', '奉节县', '500200', '15');
INSERT INTO `ly_area` VALUES ('500237', '巫山县', '500200', '16');
INSERT INTO `ly_area` VALUES ('500238', '巫溪县', '500200', '17');
INSERT INTO `ly_area` VALUES ('500240', '石柱土家族自治县', '500200', '18');
INSERT INTO `ly_area` VALUES ('500241', '秀山土家族苗族自治县', '500200', '19');
INSERT INTO `ly_area` VALUES ('500242', '酉阳土家族苗族自治县', '500200', '20');
INSERT INTO `ly_area` VALUES ('500243', '彭水苗族土家族自治县', '500200', '21');
INSERT INTO `ly_area` VALUES ('500381', '江津市', '500300', '1');
INSERT INTO `ly_area` VALUES ('500382', '合川市', '500300', '2');
INSERT INTO `ly_area` VALUES ('500383', '永川市', '500300', '3');
INSERT INTO `ly_area` VALUES ('500384', '南川市', '500300', '4');
INSERT INTO `ly_area` VALUES ('510101', '市辖区', '510100', '1');
INSERT INTO `ly_area` VALUES ('510104', '锦江区', '510100', '2');
INSERT INTO `ly_area` VALUES ('510105', '青羊区', '510100', '3');
INSERT INTO `ly_area` VALUES ('510106', '金牛区', '510100', '4');
INSERT INTO `ly_area` VALUES ('510107', '武侯区', '510100', '5');
INSERT INTO `ly_area` VALUES ('510108', '成华区', '510100', '6');
INSERT INTO `ly_area` VALUES ('510112', '龙泉驿区', '510100', '7');
INSERT INTO `ly_area` VALUES ('510113', '青白江区', '510100', '8');
INSERT INTO `ly_area` VALUES ('510114', '新都区', '510100', '9');
INSERT INTO `ly_area` VALUES ('510115', '温江区', '510100', '10');
INSERT INTO `ly_area` VALUES ('510121', '金堂县', '510100', '11');
INSERT INTO `ly_area` VALUES ('510122', '双流县', '510100', '12');
INSERT INTO `ly_area` VALUES ('510124', '郫　县', '510100', '13');
INSERT INTO `ly_area` VALUES ('510129', '大邑县', '510100', '14');
INSERT INTO `ly_area` VALUES ('510131', '蒲江县', '510100', '15');
INSERT INTO `ly_area` VALUES ('510132', '新津县', '510100', '16');
INSERT INTO `ly_area` VALUES ('510181', '都江堰市', '510100', '17');
INSERT INTO `ly_area` VALUES ('510182', '彭州市', '510100', '18');
INSERT INTO `ly_area` VALUES ('510183', '邛崃市', '510100', '19');
INSERT INTO `ly_area` VALUES ('510184', '崇州市', '510100', '20');
INSERT INTO `ly_area` VALUES ('510301', '市辖区', '510300', '1');
INSERT INTO `ly_area` VALUES ('510302', '自流井区', '510300', '2');
INSERT INTO `ly_area` VALUES ('510303', '贡井区', '510300', '3');
INSERT INTO `ly_area` VALUES ('510304', '大安区', '510300', '4');
INSERT INTO `ly_area` VALUES ('510311', '沿滩区', '510300', '5');
INSERT INTO `ly_area` VALUES ('510321', '荣　县', '510300', '6');
INSERT INTO `ly_area` VALUES ('510322', '富顺县', '510300', '7');
INSERT INTO `ly_area` VALUES ('510401', '市辖区', '510400', '1');
INSERT INTO `ly_area` VALUES ('510402', '东　区', '510400', '2');
INSERT INTO `ly_area` VALUES ('510403', '西　区', '510400', '3');
INSERT INTO `ly_area` VALUES ('510411', '仁和区', '510400', '4');
INSERT INTO `ly_area` VALUES ('510421', '米易县', '510400', '5');
INSERT INTO `ly_area` VALUES ('510422', '盐边县', '510400', '6');
INSERT INTO `ly_area` VALUES ('510501', '市辖区', '510500', '1');
INSERT INTO `ly_area` VALUES ('510502', '江阳区', '510500', '2');
INSERT INTO `ly_area` VALUES ('510503', '纳溪区', '510500', '3');
INSERT INTO `ly_area` VALUES ('510504', '龙马潭区', '510500', '4');
INSERT INTO `ly_area` VALUES ('510521', '泸　县', '510500', '5');
INSERT INTO `ly_area` VALUES ('510522', '合江县', '510500', '6');
INSERT INTO `ly_area` VALUES ('510524', '叙永县', '510500', '7');
INSERT INTO `ly_area` VALUES ('510525', '古蔺县', '510500', '8');
INSERT INTO `ly_area` VALUES ('510601', '市辖区', '510600', '1');
INSERT INTO `ly_area` VALUES ('510603', '旌阳区', '510600', '2');
INSERT INTO `ly_area` VALUES ('510623', '中江县', '510600', '3');
INSERT INTO `ly_area` VALUES ('510626', '罗江县', '510600', '4');
INSERT INTO `ly_area` VALUES ('510681', '广汉市', '510600', '5');
INSERT INTO `ly_area` VALUES ('510682', '什邡市', '510600', '6');
INSERT INTO `ly_area` VALUES ('510683', '绵竹市', '510600', '7');
INSERT INTO `ly_area` VALUES ('510701', '市辖区', '510700', '1');
INSERT INTO `ly_area` VALUES ('510703', '涪城区', '510700', '2');
INSERT INTO `ly_area` VALUES ('510704', '游仙区', '510700', '3');
INSERT INTO `ly_area` VALUES ('510722', '三台县', '510700', '4');
INSERT INTO `ly_area` VALUES ('510723', '盐亭县', '510700', '5');
INSERT INTO `ly_area` VALUES ('510724', '安　县', '510700', '6');
INSERT INTO `ly_area` VALUES ('510725', '梓潼县', '510700', '7');
INSERT INTO `ly_area` VALUES ('510726', '北川羌族自治县', '510700', '8');
INSERT INTO `ly_area` VALUES ('510727', '平武县', '510700', '9');
INSERT INTO `ly_area` VALUES ('510781', '江油市', '510700', '10');
INSERT INTO `ly_area` VALUES ('510801', '市辖区', '510800', '1');
INSERT INTO `ly_area` VALUES ('510802', '市中区', '510800', '2');
INSERT INTO `ly_area` VALUES ('510811', '元坝区', '510800', '3');
INSERT INTO `ly_area` VALUES ('510812', '朝天区', '510800', '4');
INSERT INTO `ly_area` VALUES ('510821', '旺苍县', '510800', '5');
INSERT INTO `ly_area` VALUES ('510822', '青川县', '510800', '6');
INSERT INTO `ly_area` VALUES ('510823', '剑阁县', '510800', '7');
INSERT INTO `ly_area` VALUES ('510824', '苍溪县', '510800', '8');
INSERT INTO `ly_area` VALUES ('510901', '市辖区', '510900', '1');
INSERT INTO `ly_area` VALUES ('510903', '船山区', '510900', '2');
INSERT INTO `ly_area` VALUES ('510904', '安居区', '510900', '3');
INSERT INTO `ly_area` VALUES ('510921', '蓬溪县', '510900', '4');
INSERT INTO `ly_area` VALUES ('510922', '射洪县', '510900', '5');
INSERT INTO `ly_area` VALUES ('510923', '大英县', '510900', '6');
INSERT INTO `ly_area` VALUES ('511001', '市辖区', '511000', '1');
INSERT INTO `ly_area` VALUES ('511002', '市中区', '511000', '2');
INSERT INTO `ly_area` VALUES ('511011', '东兴区', '511000', '3');
INSERT INTO `ly_area` VALUES ('511024', '威远县', '511000', '4');
INSERT INTO `ly_area` VALUES ('511025', '资中县', '511000', '5');
INSERT INTO `ly_area` VALUES ('511028', '隆昌县', '511000', '6');
INSERT INTO `ly_area` VALUES ('511101', '市辖区', '511100', '1');
INSERT INTO `ly_area` VALUES ('511102', '市中区', '511100', '2');
INSERT INTO `ly_area` VALUES ('511111', '沙湾区', '511100', '3');
INSERT INTO `ly_area` VALUES ('511112', '五通桥区', '511100', '4');
INSERT INTO `ly_area` VALUES ('511113', '金口河区', '511100', '5');
INSERT INTO `ly_area` VALUES ('511123', '犍为县', '511100', '6');
INSERT INTO `ly_area` VALUES ('511124', '井研县', '511100', '7');
INSERT INTO `ly_area` VALUES ('511126', '夹江县', '511100', '8');
INSERT INTO `ly_area` VALUES ('511129', '沐川县', '511100', '9');
INSERT INTO `ly_area` VALUES ('511132', '峨边彝族自治县', '511100', '10');
INSERT INTO `ly_area` VALUES ('511133', '马边彝族自治县', '511100', '11');
INSERT INTO `ly_area` VALUES ('511181', '峨眉山市', '511100', '12');
INSERT INTO `ly_area` VALUES ('511301', '市辖区', '511300', '1');
INSERT INTO `ly_area` VALUES ('511302', '顺庆区', '511300', '2');
INSERT INTO `ly_area` VALUES ('511303', '高坪区', '511300', '3');
INSERT INTO `ly_area` VALUES ('511304', '嘉陵区', '511300', '4');
INSERT INTO `ly_area` VALUES ('511321', '南部县', '511300', '5');
INSERT INTO `ly_area` VALUES ('511322', '营山县', '511300', '6');
INSERT INTO `ly_area` VALUES ('511323', '蓬安县', '511300', '7');
INSERT INTO `ly_area` VALUES ('511324', '仪陇县', '511300', '8');
INSERT INTO `ly_area` VALUES ('511325', '西充县', '511300', '9');
INSERT INTO `ly_area` VALUES ('511381', '阆中市', '511300', '10');
INSERT INTO `ly_area` VALUES ('511401', '市辖区', '511400', '1');
INSERT INTO `ly_area` VALUES ('511402', '东坡区', '511400', '2');
INSERT INTO `ly_area` VALUES ('511421', '仁寿县', '511400', '3');
INSERT INTO `ly_area` VALUES ('511422', '彭山县', '511400', '4');
INSERT INTO `ly_area` VALUES ('511423', '洪雅县', '511400', '5');
INSERT INTO `ly_area` VALUES ('511424', '丹棱县', '511400', '6');
INSERT INTO `ly_area` VALUES ('511425', '青神县', '511400', '7');
INSERT INTO `ly_area` VALUES ('511501', '市辖区', '511500', '1');
INSERT INTO `ly_area` VALUES ('511502', '翠屏区', '511500', '2');
INSERT INTO `ly_area` VALUES ('511521', '宜宾县', '511500', '3');
INSERT INTO `ly_area` VALUES ('511522', '南溪县', '511500', '4');
INSERT INTO `ly_area` VALUES ('511523', '江安县', '511500', '5');
INSERT INTO `ly_area` VALUES ('511524', '长宁县', '511500', '6');
INSERT INTO `ly_area` VALUES ('511525', '高　县', '511500', '7');
INSERT INTO `ly_area` VALUES ('511526', '珙　县', '511500', '8');
INSERT INTO `ly_area` VALUES ('511527', '筠连县', '511500', '9');
INSERT INTO `ly_area` VALUES ('511528', '兴文县', '511500', '10');
INSERT INTO `ly_area` VALUES ('511529', '屏山县', '511500', '11');
INSERT INTO `ly_area` VALUES ('511601', '市辖区', '511600', '1');
INSERT INTO `ly_area` VALUES ('511602', '广安区', '511600', '2');
INSERT INTO `ly_area` VALUES ('511621', '岳池县', '511600', '3');
INSERT INTO `ly_area` VALUES ('511622', '武胜县', '511600', '4');
INSERT INTO `ly_area` VALUES ('511623', '邻水县', '511600', '5');
INSERT INTO `ly_area` VALUES ('511681', '华莹市', '511600', '6');
INSERT INTO `ly_area` VALUES ('511701', '市辖区', '511700', '1');
INSERT INTO `ly_area` VALUES ('511702', '通川区', '511700', '2');
INSERT INTO `ly_area` VALUES ('511721', '达　县', '511700', '3');
INSERT INTO `ly_area` VALUES ('511722', '宣汉县', '511700', '4');
INSERT INTO `ly_area` VALUES ('511723', '开江县', '511700', '5');
INSERT INTO `ly_area` VALUES ('511724', '大竹县', '511700', '6');
INSERT INTO `ly_area` VALUES ('511725', '渠　县', '511700', '7');
INSERT INTO `ly_area` VALUES ('511781', '万源市', '511700', '8');
INSERT INTO `ly_area` VALUES ('511801', '市辖区', '511800', '1');
INSERT INTO `ly_area` VALUES ('511802', '雨城区', '511800', '2');
INSERT INTO `ly_area` VALUES ('511821', '名山县', '511800', '3');
INSERT INTO `ly_area` VALUES ('511822', '荥经县', '511800', '4');
INSERT INTO `ly_area` VALUES ('511823', '汉源县', '511800', '5');
INSERT INTO `ly_area` VALUES ('511824', '石棉县', '511800', '6');
INSERT INTO `ly_area` VALUES ('511825', '天全县', '511800', '7');
INSERT INTO `ly_area` VALUES ('511826', '芦山县', '511800', '8');
INSERT INTO `ly_area` VALUES ('511827', '宝兴县', '511800', '9');
INSERT INTO `ly_area` VALUES ('511901', '市辖区', '511900', '1');
INSERT INTO `ly_area` VALUES ('511902', '巴州区', '511900', '2');
INSERT INTO `ly_area` VALUES ('511921', '通江县', '511900', '3');
INSERT INTO `ly_area` VALUES ('511922', '南江县', '511900', '4');
INSERT INTO `ly_area` VALUES ('511923', '平昌县', '511900', '5');
INSERT INTO `ly_area` VALUES ('512001', '市辖区', '512000', '1');
INSERT INTO `ly_area` VALUES ('512002', '雁江区', '512000', '2');
INSERT INTO `ly_area` VALUES ('512021', '安岳县', '512000', '3');
INSERT INTO `ly_area` VALUES ('512022', '乐至县', '512000', '4');
INSERT INTO `ly_area` VALUES ('512081', '简阳市', '512000', '5');
INSERT INTO `ly_area` VALUES ('513221', '汶川县', '513200', '1');
INSERT INTO `ly_area` VALUES ('513222', '理　县', '513200', '2');
INSERT INTO `ly_area` VALUES ('513223', '茂　县', '513200', '3');
INSERT INTO `ly_area` VALUES ('513224', '松潘县', '513200', '4');
INSERT INTO `ly_area` VALUES ('513225', '九寨沟县', '513200', '5');
INSERT INTO `ly_area` VALUES ('513226', '金川县', '513200', '6');
INSERT INTO `ly_area` VALUES ('513227', '小金县', '513200', '7');
INSERT INTO `ly_area` VALUES ('513228', '黑水县', '513200', '8');
INSERT INTO `ly_area` VALUES ('513229', '马尔康县', '513200', '9');
INSERT INTO `ly_area` VALUES ('513230', '壤塘县', '513200', '10');
INSERT INTO `ly_area` VALUES ('513231', '阿坝县', '513200', '11');
INSERT INTO `ly_area` VALUES ('513232', '若尔盖县', '513200', '12');
INSERT INTO `ly_area` VALUES ('513233', '红原县', '513200', '13');
INSERT INTO `ly_area` VALUES ('513321', '康定县', '513300', '1');
INSERT INTO `ly_area` VALUES ('513322', '泸定县', '513300', '2');
INSERT INTO `ly_area` VALUES ('513323', '丹巴县', '513300', '3');
INSERT INTO `ly_area` VALUES ('513324', '九龙县', '513300', '4');
INSERT INTO `ly_area` VALUES ('513325', '雅江县', '513300', '5');
INSERT INTO `ly_area` VALUES ('513326', '道孚县', '513300', '6');
INSERT INTO `ly_area` VALUES ('513327', '炉霍县', '513300', '7');
INSERT INTO `ly_area` VALUES ('513328', '甘孜县', '513300', '8');
INSERT INTO `ly_area` VALUES ('513329', '新龙县', '513300', '9');
INSERT INTO `ly_area` VALUES ('513330', '德格县', '513300', '10');
INSERT INTO `ly_area` VALUES ('513331', '白玉县', '513300', '11');
INSERT INTO `ly_area` VALUES ('513332', '石渠县', '513300', '12');
INSERT INTO `ly_area` VALUES ('513333', '色达县', '513300', '13');
INSERT INTO `ly_area` VALUES ('513334', '理塘县', '513300', '14');
INSERT INTO `ly_area` VALUES ('513335', '巴塘县', '513300', '15');
INSERT INTO `ly_area` VALUES ('513336', '乡城县', '513300', '16');
INSERT INTO `ly_area` VALUES ('513337', '稻城县', '513300', '17');
INSERT INTO `ly_area` VALUES ('513338', '得荣县', '513300', '18');
INSERT INTO `ly_area` VALUES ('513401', '西昌市', '513400', '1');
INSERT INTO `ly_area` VALUES ('513422', '木里藏族自治县', '513400', '2');
INSERT INTO `ly_area` VALUES ('513423', '盐源县', '513400', '3');
INSERT INTO `ly_area` VALUES ('513424', '德昌县', '513400', '4');
INSERT INTO `ly_area` VALUES ('513425', '会理县', '513400', '5');
INSERT INTO `ly_area` VALUES ('513426', '会东县', '513400', '6');
INSERT INTO `ly_area` VALUES ('513427', '宁南县', '513400', '7');
INSERT INTO `ly_area` VALUES ('513428', '普格县', '513400', '8');
INSERT INTO `ly_area` VALUES ('513429', '布拖县', '513400', '9');
INSERT INTO `ly_area` VALUES ('513430', '金阳县', '513400', '10');
INSERT INTO `ly_area` VALUES ('513431', '昭觉县', '513400', '11');
INSERT INTO `ly_area` VALUES ('513432', '喜德县', '513400', '12');
INSERT INTO `ly_area` VALUES ('513433', '冕宁县', '513400', '13');
INSERT INTO `ly_area` VALUES ('513434', '越西县', '513400', '14');
INSERT INTO `ly_area` VALUES ('513435', '甘洛县', '513400', '15');
INSERT INTO `ly_area` VALUES ('513436', '美姑县', '513400', '16');
INSERT INTO `ly_area` VALUES ('513437', '雷波县', '513400', '17');
INSERT INTO `ly_area` VALUES ('520101', '市辖区', '520100', '1');
INSERT INTO `ly_area` VALUES ('520102', '南明区', '520100', '2');
INSERT INTO `ly_area` VALUES ('520103', '云岩区', '520100', '3');
INSERT INTO `ly_area` VALUES ('520111', '花溪区', '520100', '4');
INSERT INTO `ly_area` VALUES ('520112', '乌当区', '520100', '5');
INSERT INTO `ly_area` VALUES ('520113', '白云区', '520100', '6');
INSERT INTO `ly_area` VALUES ('520114', '小河区', '520100', '7');
INSERT INTO `ly_area` VALUES ('520121', '开阳县', '520100', '8');
INSERT INTO `ly_area` VALUES ('520122', '息烽县', '520100', '9');
INSERT INTO `ly_area` VALUES ('520123', '修文县', '520100', '10');
INSERT INTO `ly_area` VALUES ('520181', '清镇市', '520100', '11');
INSERT INTO `ly_area` VALUES ('520201', '钟山区', '520200', '1');
INSERT INTO `ly_area` VALUES ('520203', '六枝特区', '520200', '2');
INSERT INTO `ly_area` VALUES ('520221', '水城县', '520200', '3');
INSERT INTO `ly_area` VALUES ('520222', '盘　县', '520200', '4');
INSERT INTO `ly_area` VALUES ('520301', '市辖区', '520300', '1');
INSERT INTO `ly_area` VALUES ('520302', '红花岗区', '520300', '2');
INSERT INTO `ly_area` VALUES ('520303', '汇川区', '520300', '3');
INSERT INTO `ly_area` VALUES ('520321', '遵义县', '520300', '4');
INSERT INTO `ly_area` VALUES ('520322', '桐梓县', '520300', '5');
INSERT INTO `ly_area` VALUES ('520323', '绥阳县', '520300', '6');
INSERT INTO `ly_area` VALUES ('520324', '正安县', '520300', '7');
INSERT INTO `ly_area` VALUES ('520325', '道真仡佬族苗族自治县', '520300', '8');
INSERT INTO `ly_area` VALUES ('520326', '务川仡佬族苗族自治县', '520300', '9');
INSERT INTO `ly_area` VALUES ('520327', '凤冈县', '520300', '10');
INSERT INTO `ly_area` VALUES ('520328', '湄潭县', '520300', '11');
INSERT INTO `ly_area` VALUES ('520329', '余庆县', '520300', '12');
INSERT INTO `ly_area` VALUES ('520330', '习水县', '520300', '13');
INSERT INTO `ly_area` VALUES ('520381', '赤水市', '520300', '14');
INSERT INTO `ly_area` VALUES ('520382', '仁怀市', '520300', '15');
INSERT INTO `ly_area` VALUES ('520401', '市辖区', '520400', '1');
INSERT INTO `ly_area` VALUES ('520402', '西秀区', '520400', '2');
INSERT INTO `ly_area` VALUES ('520421', '平坝县', '520400', '3');
INSERT INTO `ly_area` VALUES ('520422', '普定县', '520400', '4');
INSERT INTO `ly_area` VALUES ('520423', '镇宁布依族苗族自治县', '520400', '5');
INSERT INTO `ly_area` VALUES ('520424', '关岭布依族苗族自治县', '520400', '6');
INSERT INTO `ly_area` VALUES ('520425', '紫云苗族布依族自治县', '520400', '7');
INSERT INTO `ly_area` VALUES ('522201', '铜仁市', '522200', '1');
INSERT INTO `ly_area` VALUES ('522222', '江口县', '522200', '2');
INSERT INTO `ly_area` VALUES ('522223', '玉屏侗族自治县', '522200', '3');
INSERT INTO `ly_area` VALUES ('522224', '石阡县', '522200', '4');
INSERT INTO `ly_area` VALUES ('522225', '思南县', '522200', '5');
INSERT INTO `ly_area` VALUES ('522226', '印江土家族苗族自治县', '522200', '6');
INSERT INTO `ly_area` VALUES ('522227', '德江县', '522200', '7');
INSERT INTO `ly_area` VALUES ('522228', '沿河土家族自治县', '522200', '8');
INSERT INTO `ly_area` VALUES ('522229', '松桃苗族自治县', '522200', '9');
INSERT INTO `ly_area` VALUES ('522230', '万山特区', '522200', '10');
INSERT INTO `ly_area` VALUES ('522301', '兴义市', '522300', '1');
INSERT INTO `ly_area` VALUES ('522322', '兴仁县', '522300', '2');
INSERT INTO `ly_area` VALUES ('522323', '普安县', '522300', '3');
INSERT INTO `ly_area` VALUES ('522324', '晴隆县', '522300', '4');
INSERT INTO `ly_area` VALUES ('522325', '贞丰县', '522300', '5');
INSERT INTO `ly_area` VALUES ('522326', '望谟县', '522300', '6');
INSERT INTO `ly_area` VALUES ('522327', '册亨县', '522300', '7');
INSERT INTO `ly_area` VALUES ('522328', '安龙县', '522300', '8');
INSERT INTO `ly_area` VALUES ('522401', '毕节市', '522400', '1');
INSERT INTO `ly_area` VALUES ('522422', '大方县', '522400', '2');
INSERT INTO `ly_area` VALUES ('522423', '黔西县', '522400', '3');
INSERT INTO `ly_area` VALUES ('522424', '金沙县', '522400', '4');
INSERT INTO `ly_area` VALUES ('522425', '织金县', '522400', '5');
INSERT INTO `ly_area` VALUES ('522426', '纳雍县', '522400', '6');
INSERT INTO `ly_area` VALUES ('522427', '威宁彝族回族苗族自治县', '522400', '7');
INSERT INTO `ly_area` VALUES ('522428', '赫章县', '522400', '8');
INSERT INTO `ly_area` VALUES ('522601', '凯里市', '522600', '1');
INSERT INTO `ly_area` VALUES ('522622', '黄平县', '522600', '2');
INSERT INTO `ly_area` VALUES ('522623', '施秉县', '522600', '3');
INSERT INTO `ly_area` VALUES ('522624', '三穗县', '522600', '4');
INSERT INTO `ly_area` VALUES ('522625', '镇远县', '522600', '5');
INSERT INTO `ly_area` VALUES ('522626', '岑巩县', '522600', '6');
INSERT INTO `ly_area` VALUES ('522627', '天柱县', '522600', '7');
INSERT INTO `ly_area` VALUES ('522628', '锦屏县', '522600', '8');
INSERT INTO `ly_area` VALUES ('522629', '剑河县', '522600', '9');
INSERT INTO `ly_area` VALUES ('522630', '台江县', '522600', '10');
INSERT INTO `ly_area` VALUES ('522631', '黎平县', '522600', '11');
INSERT INTO `ly_area` VALUES ('522632', '榕江县', '522600', '12');
INSERT INTO `ly_area` VALUES ('522633', '从江县', '522600', '13');
INSERT INTO `ly_area` VALUES ('522634', '雷山县', '522600', '14');
INSERT INTO `ly_area` VALUES ('522635', '麻江县', '522600', '15');
INSERT INTO `ly_area` VALUES ('522636', '丹寨县', '522600', '16');
INSERT INTO `ly_area` VALUES ('522701', '都匀市', '522700', '1');
INSERT INTO `ly_area` VALUES ('522702', '福泉市', '522700', '2');
INSERT INTO `ly_area` VALUES ('522722', '荔波县', '522700', '3');
INSERT INTO `ly_area` VALUES ('522723', '贵定县', '522700', '4');
INSERT INTO `ly_area` VALUES ('522725', '瓮安县', '522700', '5');
INSERT INTO `ly_area` VALUES ('522726', '独山县', '522700', '6');
INSERT INTO `ly_area` VALUES ('522727', '平塘县', '522700', '7');
INSERT INTO `ly_area` VALUES ('522728', '罗甸县', '522700', '8');
INSERT INTO `ly_area` VALUES ('522729', '长顺县', '522700', '9');
INSERT INTO `ly_area` VALUES ('522730', '龙里县', '522700', '10');
INSERT INTO `ly_area` VALUES ('522731', '惠水县', '522700', '11');
INSERT INTO `ly_area` VALUES ('522732', '三都水族自治县', '522700', '12');
INSERT INTO `ly_area` VALUES ('530101', '市辖区', '530100', '1');
INSERT INTO `ly_area` VALUES ('530102', '五华区', '530100', '2');
INSERT INTO `ly_area` VALUES ('530103', '盘龙区', '530100', '3');
INSERT INTO `ly_area` VALUES ('530111', '官渡区', '530100', '4');
INSERT INTO `ly_area` VALUES ('530112', '西山区', '530100', '5');
INSERT INTO `ly_area` VALUES ('530113', '东川区', '530100', '6');
INSERT INTO `ly_area` VALUES ('530121', '呈贡县', '530100', '7');
INSERT INTO `ly_area` VALUES ('530122', '晋宁县', '530100', '8');
INSERT INTO `ly_area` VALUES ('530124', '富民县', '530100', '9');
INSERT INTO `ly_area` VALUES ('530125', '宜良县', '530100', '10');
INSERT INTO `ly_area` VALUES ('530126', '石林彝族自治县', '530100', '11');
INSERT INTO `ly_area` VALUES ('530127', '嵩明县', '530100', '12');
INSERT INTO `ly_area` VALUES ('530128', '禄劝彝族苗族自治县', '530100', '13');
INSERT INTO `ly_area` VALUES ('530129', '寻甸回族彝族自治县', '530100', '14');
INSERT INTO `ly_area` VALUES ('530181', '安宁市', '530100', '15');
INSERT INTO `ly_area` VALUES ('530301', '市辖区', '530300', '1');
INSERT INTO `ly_area` VALUES ('530302', '麒麟区', '530300', '2');
INSERT INTO `ly_area` VALUES ('530321', '马龙县', '530300', '3');
INSERT INTO `ly_area` VALUES ('530322', '陆良县', '530300', '4');
INSERT INTO `ly_area` VALUES ('530323', '师宗县', '530300', '5');
INSERT INTO `ly_area` VALUES ('530324', '罗平县', '530300', '6');
INSERT INTO `ly_area` VALUES ('530325', '富源县', '530300', '7');
INSERT INTO `ly_area` VALUES ('530326', '会泽县', '530300', '8');
INSERT INTO `ly_area` VALUES ('530328', '沾益县', '530300', '9');
INSERT INTO `ly_area` VALUES ('530381', '宣威市', '530300', '10');
INSERT INTO `ly_area` VALUES ('530401', '市辖区', '530400', '1');
INSERT INTO `ly_area` VALUES ('530402', '红塔区', '530400', '2');
INSERT INTO `ly_area` VALUES ('530421', '江川县', '530400', '3');
INSERT INTO `ly_area` VALUES ('530422', '澄江县', '530400', '4');
INSERT INTO `ly_area` VALUES ('530423', '通海县', '530400', '5');
INSERT INTO `ly_area` VALUES ('530424', '华宁县', '530400', '6');
INSERT INTO `ly_area` VALUES ('530425', '易门县', '530400', '7');
INSERT INTO `ly_area` VALUES ('530426', '峨山彝族自治县', '530400', '8');
INSERT INTO `ly_area` VALUES ('530427', '新平彝族傣族自治县', '530400', '9');
INSERT INTO `ly_area` VALUES ('530428', '元江哈尼族彝族傣族自治县', '530400', '10');
INSERT INTO `ly_area` VALUES ('530501', '市辖区', '530500', '1');
INSERT INTO `ly_area` VALUES ('530502', '隆阳区', '530500', '2');
INSERT INTO `ly_area` VALUES ('530521', '施甸县', '530500', '3');
INSERT INTO `ly_area` VALUES ('530522', '腾冲县', '530500', '4');
INSERT INTO `ly_area` VALUES ('530523', '龙陵县', '530500', '5');
INSERT INTO `ly_area` VALUES ('530524', '昌宁县', '530500', '6');
INSERT INTO `ly_area` VALUES ('530601', '市辖区', '530600', '1');
INSERT INTO `ly_area` VALUES ('530602', '昭阳区', '530600', '2');
INSERT INTO `ly_area` VALUES ('530621', '鲁甸县', '530600', '3');
INSERT INTO `ly_area` VALUES ('530622', '巧家县', '530600', '4');
INSERT INTO `ly_area` VALUES ('530623', '盐津县', '530600', '5');
INSERT INTO `ly_area` VALUES ('530624', '大关县', '530600', '6');
INSERT INTO `ly_area` VALUES ('530625', '永善县', '530600', '7');
INSERT INTO `ly_area` VALUES ('530626', '绥江县', '530600', '8');
INSERT INTO `ly_area` VALUES ('530627', '镇雄县', '530600', '9');
INSERT INTO `ly_area` VALUES ('530628', '彝良县', '530600', '10');
INSERT INTO `ly_area` VALUES ('530629', '威信县', '530600', '11');
INSERT INTO `ly_area` VALUES ('530630', '水富县', '530600', '12');
INSERT INTO `ly_area` VALUES ('530701', '市辖区', '530700', '1');
INSERT INTO `ly_area` VALUES ('530702', '古城区', '530700', '2');
INSERT INTO `ly_area` VALUES ('530721', '玉龙纳西族自治县', '530700', '3');
INSERT INTO `ly_area` VALUES ('530722', '永胜县', '530700', '4');
INSERT INTO `ly_area` VALUES ('530723', '华坪县', '530700', '5');
INSERT INTO `ly_area` VALUES ('530724', '宁蒗彝族自治县', '530700', '6');
INSERT INTO `ly_area` VALUES ('530801', '市辖区', '530800', '1');
INSERT INTO `ly_area` VALUES ('530802', '翠云区', '530800', '2');
INSERT INTO `ly_area` VALUES ('530821', '普洱哈尼族彝族自治县', '530800', '3');
INSERT INTO `ly_area` VALUES ('530822', '墨江哈尼族自治县', '530800', '4');
INSERT INTO `ly_area` VALUES ('530823', '景东彝族自治县', '530800', '5');
INSERT INTO `ly_area` VALUES ('530824', '景谷傣族彝族自治县', '530800', '6');
INSERT INTO `ly_area` VALUES ('530825', '镇沅彝族哈尼族拉祜族自治县', '530800', '7');
INSERT INTO `ly_area` VALUES ('530826', '江城哈尼族彝族自治县', '530800', '8');
INSERT INTO `ly_area` VALUES ('530827', '孟连傣族拉祜族佤族自治县', '530800', '9');
INSERT INTO `ly_area` VALUES ('530828', '澜沧拉祜族自治县', '530800', '10');
INSERT INTO `ly_area` VALUES ('530829', '西盟佤族自治县', '530800', '11');
INSERT INTO `ly_area` VALUES ('530901', '市辖区', '530900', '1');
INSERT INTO `ly_area` VALUES ('530902', '临翔区', '530900', '2');
INSERT INTO `ly_area` VALUES ('530921', '凤庆县', '530900', '3');
INSERT INTO `ly_area` VALUES ('530922', '云　县', '530900', '4');
INSERT INTO `ly_area` VALUES ('530923', '永德县', '530900', '5');
INSERT INTO `ly_area` VALUES ('530924', '镇康县', '530900', '6');
INSERT INTO `ly_area` VALUES ('530925', '双江拉祜族佤族布朗族傣族自治县', '530900', '7');
INSERT INTO `ly_area` VALUES ('530926', '耿马傣族佤族自治县', '530900', '8');
INSERT INTO `ly_area` VALUES ('530927', '沧源佤族自治县', '530900', '9');
INSERT INTO `ly_area` VALUES ('532301', '楚雄市', '532300', '1');
INSERT INTO `ly_area` VALUES ('532322', '双柏县', '532300', '2');
INSERT INTO `ly_area` VALUES ('532323', '牟定县', '532300', '3');
INSERT INTO `ly_area` VALUES ('532324', '南华县', '532300', '4');
INSERT INTO `ly_area` VALUES ('532325', '姚安县', '532300', '5');
INSERT INTO `ly_area` VALUES ('532326', '大姚县', '532300', '6');
INSERT INTO `ly_area` VALUES ('532327', '永仁县', '532300', '7');
INSERT INTO `ly_area` VALUES ('532328', '元谋县', '532300', '8');
INSERT INTO `ly_area` VALUES ('532329', '武定县', '532300', '9');
INSERT INTO `ly_area` VALUES ('532331', '禄丰县', '532300', '10');
INSERT INTO `ly_area` VALUES ('532501', '个旧市', '532500', '1');
INSERT INTO `ly_area` VALUES ('532502', '开远市', '532500', '2');
INSERT INTO `ly_area` VALUES ('532522', '蒙自县', '532500', '3');
INSERT INTO `ly_area` VALUES ('532523', '屏边苗族自治县', '532500', '4');
INSERT INTO `ly_area` VALUES ('532524', '建水县', '532500', '5');
INSERT INTO `ly_area` VALUES ('532525', '石屏县', '532500', '6');
INSERT INTO `ly_area` VALUES ('532526', '弥勒县', '532500', '7');
INSERT INTO `ly_area` VALUES ('532527', '泸西县', '532500', '8');
INSERT INTO `ly_area` VALUES ('532528', '元阳县', '532500', '9');
INSERT INTO `ly_area` VALUES ('532529', '红河县', '532500', '10');
INSERT INTO `ly_area` VALUES ('532530', '金平苗族瑶族傣族自治县', '532500', '11');
INSERT INTO `ly_area` VALUES ('532531', '绿春县', '532500', '12');
INSERT INTO `ly_area` VALUES ('532532', '河口瑶族自治县', '532500', '13');
INSERT INTO `ly_area` VALUES ('532621', '文山县', '532600', '1');
INSERT INTO `ly_area` VALUES ('532622', '砚山县', '532600', '2');
INSERT INTO `ly_area` VALUES ('532623', '西畴县', '532600', '3');
INSERT INTO `ly_area` VALUES ('532624', '麻栗坡县', '532600', '4');
INSERT INTO `ly_area` VALUES ('532625', '马关县', '532600', '5');
INSERT INTO `ly_area` VALUES ('532626', '丘北县', '532600', '6');
INSERT INTO `ly_area` VALUES ('532627', '广南县', '532600', '7');
INSERT INTO `ly_area` VALUES ('532628', '富宁县', '532600', '8');
INSERT INTO `ly_area` VALUES ('532801', '景洪市', '532800', '1');
INSERT INTO `ly_area` VALUES ('532822', '勐海县', '532800', '2');
INSERT INTO `ly_area` VALUES ('532823', '勐腊县', '532800', '3');
INSERT INTO `ly_area` VALUES ('532901', '大理市', '532900', '1');
INSERT INTO `ly_area` VALUES ('532922', '漾濞彝族自治县', '532900', '2');
INSERT INTO `ly_area` VALUES ('532923', '祥云县', '532900', '3');
INSERT INTO `ly_area` VALUES ('532924', '宾川县', '532900', '4');
INSERT INTO `ly_area` VALUES ('532925', '弥渡县', '532900', '5');
INSERT INTO `ly_area` VALUES ('532926', '南涧彝族自治县', '532900', '6');
INSERT INTO `ly_area` VALUES ('532927', '巍山彝族回族自治县', '532900', '7');
INSERT INTO `ly_area` VALUES ('532928', '永平县', '532900', '8');
INSERT INTO `ly_area` VALUES ('532929', '云龙县', '532900', '9');
INSERT INTO `ly_area` VALUES ('532930', '洱源县', '532900', '10');
INSERT INTO `ly_area` VALUES ('532931', '剑川县', '532900', '11');
INSERT INTO `ly_area` VALUES ('532932', '鹤庆县', '532900', '12');
INSERT INTO `ly_area` VALUES ('533102', '瑞丽市', '533100', '1');
INSERT INTO `ly_area` VALUES ('533103', '潞西市', '533100', '2');
INSERT INTO `ly_area` VALUES ('533122', '梁河县', '533100', '3');
INSERT INTO `ly_area` VALUES ('533123', '盈江县', '533100', '4');
INSERT INTO `ly_area` VALUES ('533124', '陇川县', '533100', '5');
INSERT INTO `ly_area` VALUES ('533321', '泸水县', '533300', '1');
INSERT INTO `ly_area` VALUES ('533323', '福贡县', '533300', '2');
INSERT INTO `ly_area` VALUES ('533324', '贡山独龙族怒族自治县', '533300', '3');
INSERT INTO `ly_area` VALUES ('533325', '兰坪白族普米族自治县', '533300', '4');
INSERT INTO `ly_area` VALUES ('533421', '香格里拉县', '533400', '1');
INSERT INTO `ly_area` VALUES ('533422', '德钦县', '533400', '2');
INSERT INTO `ly_area` VALUES ('533423', '维西傈僳族自治县', '533400', '3');
INSERT INTO `ly_area` VALUES ('540101', '市辖区', '540100', '1');
INSERT INTO `ly_area` VALUES ('540102', '城关区', '540100', '2');
INSERT INTO `ly_area` VALUES ('540121', '林周县', '540100', '3');
INSERT INTO `ly_area` VALUES ('540122', '当雄县', '540100', '4');
INSERT INTO `ly_area` VALUES ('540123', '尼木县', '540100', '5');
INSERT INTO `ly_area` VALUES ('540124', '曲水县', '540100', '6');
INSERT INTO `ly_area` VALUES ('540125', '堆龙德庆县', '540100', '7');
INSERT INTO `ly_area` VALUES ('540126', '达孜县', '540100', '8');
INSERT INTO `ly_area` VALUES ('540127', '墨竹工卡县', '540100', '9');
INSERT INTO `ly_area` VALUES ('542121', '昌都县', '542100', '1');
INSERT INTO `ly_area` VALUES ('542122', '江达县', '542100', '2');
INSERT INTO `ly_area` VALUES ('542123', '贡觉县', '542100', '3');
INSERT INTO `ly_area` VALUES ('542124', '类乌齐县', '542100', '4');
INSERT INTO `ly_area` VALUES ('542125', '丁青县', '542100', '5');
INSERT INTO `ly_area` VALUES ('542126', '察雅县', '542100', '6');
INSERT INTO `ly_area` VALUES ('542127', '八宿县', '542100', '7');
INSERT INTO `ly_area` VALUES ('542128', '左贡县', '542100', '8');
INSERT INTO `ly_area` VALUES ('542129', '芒康县', '542100', '9');
INSERT INTO `ly_area` VALUES ('542132', '洛隆县', '542100', '10');
INSERT INTO `ly_area` VALUES ('542133', '边坝县', '542100', '11');
INSERT INTO `ly_area` VALUES ('542221', '乃东县', '542200', '1');
INSERT INTO `ly_area` VALUES ('542222', '扎囊县', '542200', '2');
INSERT INTO `ly_area` VALUES ('542223', '贡嘎县', '542200', '3');
INSERT INTO `ly_area` VALUES ('542224', '桑日县', '542200', '4');
INSERT INTO `ly_area` VALUES ('542225', '琼结县', '542200', '5');
INSERT INTO `ly_area` VALUES ('542226', '曲松县', '542200', '6');
INSERT INTO `ly_area` VALUES ('542227', '措美县', '542200', '7');
INSERT INTO `ly_area` VALUES ('542228', '洛扎县', '542200', '8');
INSERT INTO `ly_area` VALUES ('542229', '加查县', '542200', '9');
INSERT INTO `ly_area` VALUES ('542231', '隆子县', '542200', '10');
INSERT INTO `ly_area` VALUES ('542232', '错那县', '542200', '11');
INSERT INTO `ly_area` VALUES ('542233', '浪卡子县', '542200', '12');
INSERT INTO `ly_area` VALUES ('542301', '日喀则市', '542300', '1');
INSERT INTO `ly_area` VALUES ('542322', '南木林县', '542300', '2');
INSERT INTO `ly_area` VALUES ('542323', '江孜县', '542300', '3');
INSERT INTO `ly_area` VALUES ('542324', '定日县', '542300', '4');
INSERT INTO `ly_area` VALUES ('542325', '萨迦县', '542300', '5');
INSERT INTO `ly_area` VALUES ('542326', '拉孜县', '542300', '6');
INSERT INTO `ly_area` VALUES ('542327', '昂仁县', '542300', '7');
INSERT INTO `ly_area` VALUES ('542328', '谢通门县', '542300', '8');
INSERT INTO `ly_area` VALUES ('542329', '白朗县', '542300', '9');
INSERT INTO `ly_area` VALUES ('542330', '仁布县', '542300', '10');
INSERT INTO `ly_area` VALUES ('542331', '康马县', '542300', '11');
INSERT INTO `ly_area` VALUES ('542332', '定结县', '542300', '12');
INSERT INTO `ly_area` VALUES ('542333', '仲巴县', '542300', '13');
INSERT INTO `ly_area` VALUES ('542334', '亚东县', '542300', '14');
INSERT INTO `ly_area` VALUES ('542335', '吉隆县', '542300', '15');
INSERT INTO `ly_area` VALUES ('542336', '聂拉木县', '542300', '16');
INSERT INTO `ly_area` VALUES ('542337', '萨嘎县', '542300', '17');
INSERT INTO `ly_area` VALUES ('542338', '岗巴县', '542300', '18');
INSERT INTO `ly_area` VALUES ('542421', '那曲县', '542400', '1');
INSERT INTO `ly_area` VALUES ('542422', '嘉黎县', '542400', '2');
INSERT INTO `ly_area` VALUES ('542423', '比如县', '542400', '3');
INSERT INTO `ly_area` VALUES ('542424', '聂荣县', '542400', '4');
INSERT INTO `ly_area` VALUES ('542425', '安多县', '542400', '5');
INSERT INTO `ly_area` VALUES ('542426', '申扎县', '542400', '6');
INSERT INTO `ly_area` VALUES ('542427', '索　县', '542400', '7');
INSERT INTO `ly_area` VALUES ('542428', '班戈县', '542400', '8');
INSERT INTO `ly_area` VALUES ('542429', '巴青县', '542400', '9');
INSERT INTO `ly_area` VALUES ('542430', '尼玛县', '542400', '10');
INSERT INTO `ly_area` VALUES ('542521', '普兰县', '542500', '1');
INSERT INTO `ly_area` VALUES ('542522', '札达县', '542500', '2');
INSERT INTO `ly_area` VALUES ('542523', '噶尔县', '542500', '3');
INSERT INTO `ly_area` VALUES ('542524', '日土县', '542500', '4');
INSERT INTO `ly_area` VALUES ('542525', '革吉县', '542500', '5');
INSERT INTO `ly_area` VALUES ('542526', '改则县', '542500', '6');
INSERT INTO `ly_area` VALUES ('542527', '措勤县', '542500', '7');
INSERT INTO `ly_area` VALUES ('542621', '林芝县', '542600', '1');
INSERT INTO `ly_area` VALUES ('542622', '工布江达县', '542600', '2');
INSERT INTO `ly_area` VALUES ('542623', '米林县', '542600', '3');
INSERT INTO `ly_area` VALUES ('542624', '墨脱县', '542600', '4');
INSERT INTO `ly_area` VALUES ('542625', '波密县', '542600', '5');
INSERT INTO `ly_area` VALUES ('542626', '察隅县', '542600', '6');
INSERT INTO `ly_area` VALUES ('542627', '朗　县', '542600', '7');
INSERT INTO `ly_area` VALUES ('610101', '市辖区', '610100', '1');
INSERT INTO `ly_area` VALUES ('610102', '新城区', '610100', '2');
INSERT INTO `ly_area` VALUES ('610103', '碑林区', '610100', '3');
INSERT INTO `ly_area` VALUES ('610104', '莲湖区', '610100', '4');
INSERT INTO `ly_area` VALUES ('610111', '灞桥区', '610100', '5');
INSERT INTO `ly_area` VALUES ('610112', '未央区', '610100', '6');
INSERT INTO `ly_area` VALUES ('610113', '雁塔区', '610100', '7');
INSERT INTO `ly_area` VALUES ('610114', '阎良区', '610100', '8');
INSERT INTO `ly_area` VALUES ('610115', '临潼区', '610100', '9');
INSERT INTO `ly_area` VALUES ('610116', '长安区', '610100', '10');
INSERT INTO `ly_area` VALUES ('610122', '蓝田县', '610100', '11');
INSERT INTO `ly_area` VALUES ('610124', '周至县', '610100', '12');
INSERT INTO `ly_area` VALUES ('610125', '户　县', '610100', '13');
INSERT INTO `ly_area` VALUES ('610126', '高陵县', '610100', '14');
INSERT INTO `ly_area` VALUES ('610201', '市辖区', '610200', '1');
INSERT INTO `ly_area` VALUES ('610202', '王益区', '610200', '2');
INSERT INTO `ly_area` VALUES ('610203', '印台区', '610200', '3');
INSERT INTO `ly_area` VALUES ('610204', '耀州区', '610200', '4');
INSERT INTO `ly_area` VALUES ('610222', '宜君县', '610200', '5');
INSERT INTO `ly_area` VALUES ('610301', '市辖区', '610300', '1');
INSERT INTO `ly_area` VALUES ('610302', '渭滨区', '610300', '2');
INSERT INTO `ly_area` VALUES ('610303', '金台区', '610300', '3');
INSERT INTO `ly_area` VALUES ('610304', '陈仓区', '610300', '4');
INSERT INTO `ly_area` VALUES ('610322', '凤翔县', '610300', '5');
INSERT INTO `ly_area` VALUES ('610323', '岐山县', '610300', '6');
INSERT INTO `ly_area` VALUES ('610324', '扶风县', '610300', '7');
INSERT INTO `ly_area` VALUES ('610326', '眉　县', '610300', '8');
INSERT INTO `ly_area` VALUES ('610327', '陇　县', '610300', '9');
INSERT INTO `ly_area` VALUES ('610328', '千阳县', '610300', '10');
INSERT INTO `ly_area` VALUES ('610329', '麟游县', '610300', '11');
INSERT INTO `ly_area` VALUES ('610330', '凤　县', '610300', '12');
INSERT INTO `ly_area` VALUES ('610331', '太白县', '610300', '13');
INSERT INTO `ly_area` VALUES ('610401', '市辖区', '610400', '1');
INSERT INTO `ly_area` VALUES ('610402', '秦都区', '610400', '2');
INSERT INTO `ly_area` VALUES ('610403', '杨凌区', '610400', '3');
INSERT INTO `ly_area` VALUES ('610404', '渭城区', '610400', '4');
INSERT INTO `ly_area` VALUES ('610422', '三原县', '610400', '5');
INSERT INTO `ly_area` VALUES ('610423', '泾阳县', '610400', '6');
INSERT INTO `ly_area` VALUES ('610424', '乾　县', '610400', '7');
INSERT INTO `ly_area` VALUES ('610425', '礼泉县', '610400', '8');
INSERT INTO `ly_area` VALUES ('610426', '永寿县', '610400', '9');
INSERT INTO `ly_area` VALUES ('610427', '彬　县', '610400', '10');
INSERT INTO `ly_area` VALUES ('610428', '长武县', '610400', '11');
INSERT INTO `ly_area` VALUES ('610429', '旬邑县', '610400', '12');
INSERT INTO `ly_area` VALUES ('610430', '淳化县', '610400', '13');
INSERT INTO `ly_area` VALUES ('610431', '武功县', '610400', '14');
INSERT INTO `ly_area` VALUES ('610481', '兴平市', '610400', '15');
INSERT INTO `ly_area` VALUES ('610501', '市辖区', '610500', '1');
INSERT INTO `ly_area` VALUES ('610502', '临渭区', '610500', '2');
INSERT INTO `ly_area` VALUES ('610521', '华　县', '610500', '3');
INSERT INTO `ly_area` VALUES ('610522', '潼关县', '610500', '4');
INSERT INTO `ly_area` VALUES ('610523', '大荔县', '610500', '5');
INSERT INTO `ly_area` VALUES ('610524', '合阳县', '610500', '6');
INSERT INTO `ly_area` VALUES ('610525', '澄城县', '610500', '7');
INSERT INTO `ly_area` VALUES ('610526', '蒲城县', '610500', '8');
INSERT INTO `ly_area` VALUES ('610527', '白水县', '610500', '9');
INSERT INTO `ly_area` VALUES ('610528', '富平县', '610500', '10');
INSERT INTO `ly_area` VALUES ('610581', '韩城市', '610500', '11');
INSERT INTO `ly_area` VALUES ('610582', '华阴市', '610500', '12');
INSERT INTO `ly_area` VALUES ('610601', '市辖区', '610600', '1');
INSERT INTO `ly_area` VALUES ('610602', '宝塔区', '610600', '2');
INSERT INTO `ly_area` VALUES ('610621', '延长县', '610600', '3');
INSERT INTO `ly_area` VALUES ('610622', '延川县', '610600', '4');
INSERT INTO `ly_area` VALUES ('610623', '子长县', '610600', '5');
INSERT INTO `ly_area` VALUES ('610624', '安塞县', '610600', '6');
INSERT INTO `ly_area` VALUES ('610625', '志丹县', '610600', '7');
INSERT INTO `ly_area` VALUES ('610626', '吴旗县', '610600', '8');
INSERT INTO `ly_area` VALUES ('610627', '甘泉县', '610600', '9');
INSERT INTO `ly_area` VALUES ('610628', '富　县', '610600', '10');
INSERT INTO `ly_area` VALUES ('610629', '洛川县', '610600', '11');
INSERT INTO `ly_area` VALUES ('610630', '宜川县', '610600', '12');
INSERT INTO `ly_area` VALUES ('610631', '黄龙县', '610600', '13');
INSERT INTO `ly_area` VALUES ('610632', '黄陵县', '610600', '14');
INSERT INTO `ly_area` VALUES ('610701', '市辖区', '610700', '1');
INSERT INTO `ly_area` VALUES ('610702', '汉台区', '610700', '2');
INSERT INTO `ly_area` VALUES ('610721', '南郑县', '610700', '3');
INSERT INTO `ly_area` VALUES ('610722', '城固县', '610700', '4');
INSERT INTO `ly_area` VALUES ('610723', '洋　县', '610700', '5');
INSERT INTO `ly_area` VALUES ('610724', '西乡县', '610700', '6');
INSERT INTO `ly_area` VALUES ('610725', '勉　县', '610700', '7');
INSERT INTO `ly_area` VALUES ('610726', '宁强县', '610700', '8');
INSERT INTO `ly_area` VALUES ('610727', '略阳县', '610700', '9');
INSERT INTO `ly_area` VALUES ('610728', '镇巴县', '610700', '10');
INSERT INTO `ly_area` VALUES ('610729', '留坝县', '610700', '11');
INSERT INTO `ly_area` VALUES ('610730', '佛坪县', '610700', '12');
INSERT INTO `ly_area` VALUES ('610801', '市辖区', '610800', '1');
INSERT INTO `ly_area` VALUES ('610802', '榆阳区', '610800', '2');
INSERT INTO `ly_area` VALUES ('610821', '神木县', '610800', '3');
INSERT INTO `ly_area` VALUES ('610822', '府谷县', '610800', '4');
INSERT INTO `ly_area` VALUES ('610823', '横山县', '610800', '5');
INSERT INTO `ly_area` VALUES ('610824', '靖边县', '610800', '6');
INSERT INTO `ly_area` VALUES ('610825', '定边县', '610800', '7');
INSERT INTO `ly_area` VALUES ('610826', '绥德县', '610800', '8');
INSERT INTO `ly_area` VALUES ('610827', '米脂县', '610800', '9');
INSERT INTO `ly_area` VALUES ('610828', '佳　县', '610800', '10');
INSERT INTO `ly_area` VALUES ('610829', '吴堡县', '610800', '11');
INSERT INTO `ly_area` VALUES ('610830', '清涧县', '610800', '12');
INSERT INTO `ly_area` VALUES ('610831', '子洲县', '610800', '13');
INSERT INTO `ly_area` VALUES ('610901', '市辖区', '610900', '1');
INSERT INTO `ly_area` VALUES ('610902', '汉滨区', '610900', '2');
INSERT INTO `ly_area` VALUES ('610921', '汉阴县', '610900', '3');
INSERT INTO `ly_area` VALUES ('610922', '石泉县', '610900', '4');
INSERT INTO `ly_area` VALUES ('610923', '宁陕县', '610900', '5');
INSERT INTO `ly_area` VALUES ('610924', '紫阳县', '610900', '6');
INSERT INTO `ly_area` VALUES ('610925', '岚皋县', '610900', '7');
INSERT INTO `ly_area` VALUES ('610926', '平利县', '610900', '8');
INSERT INTO `ly_area` VALUES ('610927', '镇坪县', '610900', '9');
INSERT INTO `ly_area` VALUES ('610928', '旬阳县', '610900', '10');
INSERT INTO `ly_area` VALUES ('610929', '白河县', '610900', '11');
INSERT INTO `ly_area` VALUES ('611001', '市辖区', '611000', '1');
INSERT INTO `ly_area` VALUES ('611002', '商州区', '611000', '2');
INSERT INTO `ly_area` VALUES ('611021', '洛南县', '611000', '3');
INSERT INTO `ly_area` VALUES ('611022', '丹凤县', '611000', '4');
INSERT INTO `ly_area` VALUES ('611023', '商南县', '611000', '5');
INSERT INTO `ly_area` VALUES ('611024', '山阳县', '611000', '6');
INSERT INTO `ly_area` VALUES ('611025', '镇安县', '611000', '7');
INSERT INTO `ly_area` VALUES ('611026', '柞水县', '611000', '8');
INSERT INTO `ly_area` VALUES ('620101', '市辖区', '620100', '1');
INSERT INTO `ly_area` VALUES ('620102', '城关区', '620100', '2');
INSERT INTO `ly_area` VALUES ('620103', '七里河区', '620100', '3');
INSERT INTO `ly_area` VALUES ('620104', '西固区', '620100', '4');
INSERT INTO `ly_area` VALUES ('620105', '安宁区', '620100', '5');
INSERT INTO `ly_area` VALUES ('620111', '红古区', '620100', '6');
INSERT INTO `ly_area` VALUES ('620121', '永登县', '620100', '7');
INSERT INTO `ly_area` VALUES ('620122', '皋兰县', '620100', '8');
INSERT INTO `ly_area` VALUES ('620123', '榆中县', '620100', '9');
INSERT INTO `ly_area` VALUES ('620201', '市辖区', '620200', '1');
INSERT INTO `ly_area` VALUES ('620301', '市辖区', '620300', '1');
INSERT INTO `ly_area` VALUES ('620302', '金川区', '620300', '2');
INSERT INTO `ly_area` VALUES ('620321', '永昌县', '620300', '3');
INSERT INTO `ly_area` VALUES ('620401', '市辖区', '620400', '1');
INSERT INTO `ly_area` VALUES ('620402', '白银区', '620400', '2');
INSERT INTO `ly_area` VALUES ('620403', '平川区', '620400', '3');
INSERT INTO `ly_area` VALUES ('620421', '靖远县', '620400', '4');
INSERT INTO `ly_area` VALUES ('620422', '会宁县', '620400', '5');
INSERT INTO `ly_area` VALUES ('620423', '景泰县', '620400', '6');
INSERT INTO `ly_area` VALUES ('620501', '市辖区', '620500', '1');
INSERT INTO `ly_area` VALUES ('620502', '秦城区', '620500', '2');
INSERT INTO `ly_area` VALUES ('620503', '北道区', '620500', '3');
INSERT INTO `ly_area` VALUES ('620521', '清水县', '620500', '4');
INSERT INTO `ly_area` VALUES ('620522', '秦安县', '620500', '5');
INSERT INTO `ly_area` VALUES ('620523', '甘谷县', '620500', '6');
INSERT INTO `ly_area` VALUES ('620524', '武山县', '620500', '7');
INSERT INTO `ly_area` VALUES ('620525', '张家川回族自治县', '620500', '8');
INSERT INTO `ly_area` VALUES ('620601', '市辖区', '620600', '1');
INSERT INTO `ly_area` VALUES ('620602', '凉州区', '620600', '2');
INSERT INTO `ly_area` VALUES ('620621', '民勤县', '620600', '3');
INSERT INTO `ly_area` VALUES ('620622', '古浪县', '620600', '4');
INSERT INTO `ly_area` VALUES ('620623', '天祝藏族自治县', '620600', '5');
INSERT INTO `ly_area` VALUES ('620701', '市辖区', '620700', '1');
INSERT INTO `ly_area` VALUES ('620702', '甘州区', '620700', '2');
INSERT INTO `ly_area` VALUES ('620721', '肃南裕固族自治县', '620700', '3');
INSERT INTO `ly_area` VALUES ('620722', '民乐县', '620700', '4');
INSERT INTO `ly_area` VALUES ('620723', '临泽县', '620700', '5');
INSERT INTO `ly_area` VALUES ('620724', '高台县', '620700', '6');
INSERT INTO `ly_area` VALUES ('620725', '山丹县', '620700', '7');
INSERT INTO `ly_area` VALUES ('620801', '市辖区', '620800', '1');
INSERT INTO `ly_area` VALUES ('620802', '崆峒区', '620800', '2');
INSERT INTO `ly_area` VALUES ('620821', '泾川县', '620800', '3');
INSERT INTO `ly_area` VALUES ('620822', '灵台县', '620800', '4');
INSERT INTO `ly_area` VALUES ('620823', '崇信县', '620800', '5');
INSERT INTO `ly_area` VALUES ('620824', '华亭县', '620800', '6');
INSERT INTO `ly_area` VALUES ('620825', '庄浪县', '620800', '7');
INSERT INTO `ly_area` VALUES ('620826', '静宁县', '620800', '8');
INSERT INTO `ly_area` VALUES ('620901', '市辖区', '620900', '1');
INSERT INTO `ly_area` VALUES ('620902', '肃州区', '620900', '2');
INSERT INTO `ly_area` VALUES ('620921', '金塔县', '620900', '3');
INSERT INTO `ly_area` VALUES ('620922', '安西县', '620900', '4');
INSERT INTO `ly_area` VALUES ('620923', '肃北蒙古族自治县', '620900', '5');
INSERT INTO `ly_area` VALUES ('620924', '阿克塞哈萨克族自治县', '620900', '6');
INSERT INTO `ly_area` VALUES ('620981', '玉门市', '620900', '7');
INSERT INTO `ly_area` VALUES ('620982', '敦煌市', '620900', '8');
INSERT INTO `ly_area` VALUES ('621001', '市辖区', '621000', '1');
INSERT INTO `ly_area` VALUES ('621002', '西峰区', '621000', '2');
INSERT INTO `ly_area` VALUES ('621021', '庆城县', '621000', '3');
INSERT INTO `ly_area` VALUES ('621022', '环　县', '621000', '4');
INSERT INTO `ly_area` VALUES ('621023', '华池县', '621000', '5');
INSERT INTO `ly_area` VALUES ('621024', '合水县', '621000', '6');
INSERT INTO `ly_area` VALUES ('621025', '正宁县', '621000', '7');
INSERT INTO `ly_area` VALUES ('621026', '宁　县', '621000', '8');
INSERT INTO `ly_area` VALUES ('621027', '镇原县', '621000', '9');
INSERT INTO `ly_area` VALUES ('621101', '市辖区', '621100', '1');
INSERT INTO `ly_area` VALUES ('621102', '安定区', '621100', '2');
INSERT INTO `ly_area` VALUES ('621121', '通渭县', '621100', '3');
INSERT INTO `ly_area` VALUES ('621122', '陇西县', '621100', '4');
INSERT INTO `ly_area` VALUES ('621123', '渭源县', '621100', '5');
INSERT INTO `ly_area` VALUES ('621124', '临洮县', '621100', '6');
INSERT INTO `ly_area` VALUES ('621125', '漳　县', '621100', '7');
INSERT INTO `ly_area` VALUES ('621126', '岷　县', '621100', '8');
INSERT INTO `ly_area` VALUES ('621201', '市辖区', '621200', '1');
INSERT INTO `ly_area` VALUES ('621202', '武都区', '621200', '2');
INSERT INTO `ly_area` VALUES ('621221', '成　县', '621200', '3');
INSERT INTO `ly_area` VALUES ('621222', '文　县', '621200', '4');
INSERT INTO `ly_area` VALUES ('621223', '宕昌县', '621200', '5');
INSERT INTO `ly_area` VALUES ('621224', '康　县', '621200', '6');
INSERT INTO `ly_area` VALUES ('621225', '西和县', '621200', '7');
INSERT INTO `ly_area` VALUES ('621226', '礼　县', '621200', '8');
INSERT INTO `ly_area` VALUES ('621227', '徽　县', '621200', '9');
INSERT INTO `ly_area` VALUES ('621228', '两当县', '621200', '10');
INSERT INTO `ly_area` VALUES ('622901', '临夏市', '622900', '1');
INSERT INTO `ly_area` VALUES ('622921', '临夏县', '622900', '2');
INSERT INTO `ly_area` VALUES ('622922', '康乐县', '622900', '3');
INSERT INTO `ly_area` VALUES ('622923', '永靖县', '622900', '4');
INSERT INTO `ly_area` VALUES ('622924', '广河县', '622900', '5');
INSERT INTO `ly_area` VALUES ('622925', '和政县', '622900', '6');
INSERT INTO `ly_area` VALUES ('622926', '东乡族自治县', '622900', '7');
INSERT INTO `ly_area` VALUES ('622927', '积石山保安族东乡族撒拉族自治县', '622900', '8');
INSERT INTO `ly_area` VALUES ('623001', '合作市', '623000', '1');
INSERT INTO `ly_area` VALUES ('623021', '临潭县', '623000', '2');
INSERT INTO `ly_area` VALUES ('623022', '卓尼县', '623000', '3');
INSERT INTO `ly_area` VALUES ('623023', '舟曲县', '623000', '4');
INSERT INTO `ly_area` VALUES ('623024', '迭部县', '623000', '5');
INSERT INTO `ly_area` VALUES ('623025', '玛曲县', '623000', '6');
INSERT INTO `ly_area` VALUES ('623026', '碌曲县', '623000', '7');
INSERT INTO `ly_area` VALUES ('623027', '夏河县', '623000', '8');
INSERT INTO `ly_area` VALUES ('630101', '市辖区', '630100', '1');
INSERT INTO `ly_area` VALUES ('630102', '城东区', '630100', '2');
INSERT INTO `ly_area` VALUES ('630103', '城中区', '630100', '3');
INSERT INTO `ly_area` VALUES ('630104', '城西区', '630100', '4');
INSERT INTO `ly_area` VALUES ('630105', '城北区', '630100', '5');
INSERT INTO `ly_area` VALUES ('630121', '大通回族土族自治县', '630100', '6');
INSERT INTO `ly_area` VALUES ('630122', '湟中县', '630100', '7');
INSERT INTO `ly_area` VALUES ('630123', '湟源县', '630100', '8');
INSERT INTO `ly_area` VALUES ('632121', '平安县', '632100', '1');
INSERT INTO `ly_area` VALUES ('632122', '民和回族土族自治县', '632100', '2');
INSERT INTO `ly_area` VALUES ('632123', '乐都县', '632100', '3');
INSERT INTO `ly_area` VALUES ('632126', '互助土族自治县', '632100', '4');
INSERT INTO `ly_area` VALUES ('632127', '化隆回族自治县', '632100', '5');
INSERT INTO `ly_area` VALUES ('632128', '循化撒拉族自治县', '632100', '6');
INSERT INTO `ly_area` VALUES ('632221', '门源回族自治县', '632200', '1');
INSERT INTO `ly_area` VALUES ('632222', '祁连县', '632200', '2');
INSERT INTO `ly_area` VALUES ('632223', '海晏县', '632200', '3');
INSERT INTO `ly_area` VALUES ('632224', '刚察县', '632200', '4');
INSERT INTO `ly_area` VALUES ('632321', '同仁县', '632300', '1');
INSERT INTO `ly_area` VALUES ('632322', '尖扎县', '632300', '2');
INSERT INTO `ly_area` VALUES ('632323', '泽库县', '632300', '3');
INSERT INTO `ly_area` VALUES ('632324', '河南蒙古族自治县', '632300', '4');
INSERT INTO `ly_area` VALUES ('632521', '共和县', '632500', '1');
INSERT INTO `ly_area` VALUES ('632522', '同德县', '632500', '2');
INSERT INTO `ly_area` VALUES ('632523', '贵德县', '632500', '3');
INSERT INTO `ly_area` VALUES ('632524', '兴海县', '632500', '4');
INSERT INTO `ly_area` VALUES ('632525', '贵南县', '632500', '5');
INSERT INTO `ly_area` VALUES ('632621', '玛沁县', '632600', '1');
INSERT INTO `ly_area` VALUES ('632622', '班玛县', '632600', '2');
INSERT INTO `ly_area` VALUES ('632623', '甘德县', '632600', '3');
INSERT INTO `ly_area` VALUES ('632624', '达日县', '632600', '4');
INSERT INTO `ly_area` VALUES ('632625', '久治县', '632600', '5');
INSERT INTO `ly_area` VALUES ('632626', '玛多县', '632600', '6');
INSERT INTO `ly_area` VALUES ('632721', '玉树县', '632700', '1');
INSERT INTO `ly_area` VALUES ('632722', '杂多县', '632700', '2');
INSERT INTO `ly_area` VALUES ('632723', '称多县', '632700', '3');
INSERT INTO `ly_area` VALUES ('632724', '治多县', '632700', '4');
INSERT INTO `ly_area` VALUES ('632725', '囊谦县', '632700', '5');
INSERT INTO `ly_area` VALUES ('632726', '曲麻莱县', '632700', '6');
INSERT INTO `ly_area` VALUES ('632801', '格尔木市', '632800', '1');
INSERT INTO `ly_area` VALUES ('632802', '德令哈市', '632800', '2');
INSERT INTO `ly_area` VALUES ('632821', '乌兰县', '632800', '3');
INSERT INTO `ly_area` VALUES ('632822', '都兰县', '632800', '4');
INSERT INTO `ly_area` VALUES ('632823', '天峻县', '632800', '5');
INSERT INTO `ly_area` VALUES ('640101', '市辖区', '640100', '1');
INSERT INTO `ly_area` VALUES ('640104', '兴庆区', '640100', '2');
INSERT INTO `ly_area` VALUES ('640105', '西夏区', '640100', '3');
INSERT INTO `ly_area` VALUES ('640106', '金凤区', '640100', '4');
INSERT INTO `ly_area` VALUES ('640121', '永宁县', '640100', '5');
INSERT INTO `ly_area` VALUES ('640122', '贺兰县', '640100', '6');
INSERT INTO `ly_area` VALUES ('640181', '灵武市', '640100', '7');
INSERT INTO `ly_area` VALUES ('640201', '市辖区', '640200', '1');
INSERT INTO `ly_area` VALUES ('640202', '大武口区', '640200', '2');
INSERT INTO `ly_area` VALUES ('640205', '惠农区', '640200', '3');
INSERT INTO `ly_area` VALUES ('640221', '平罗县', '640200', '4');
INSERT INTO `ly_area` VALUES ('640301', '市辖区', '640300', '1');
INSERT INTO `ly_area` VALUES ('640302', '利通区', '640300', '2');
INSERT INTO `ly_area` VALUES ('640323', '盐池县', '640300', '3');
INSERT INTO `ly_area` VALUES ('640324', '同心县', '640300', '4');
INSERT INTO `ly_area` VALUES ('640381', '青铜峡市', '640300', '5');
INSERT INTO `ly_area` VALUES ('640401', '市辖区', '640400', '1');
INSERT INTO `ly_area` VALUES ('640402', '原州区', '640400', '2');
INSERT INTO `ly_area` VALUES ('640422', '西吉县', '640400', '3');
INSERT INTO `ly_area` VALUES ('640423', '隆德县', '640400', '4');
INSERT INTO `ly_area` VALUES ('640424', '泾源县', '640400', '5');
INSERT INTO `ly_area` VALUES ('640425', '彭阳县', '640400', '6');
INSERT INTO `ly_area` VALUES ('640501', '市辖区', '640500', '1');
INSERT INTO `ly_area` VALUES ('640502', '沙坡头区', '640500', '2');
INSERT INTO `ly_area` VALUES ('640521', '中宁县', '640500', '3');
INSERT INTO `ly_area` VALUES ('640522', '海原县', '640500', '4');
INSERT INTO `ly_area` VALUES ('650101', '市辖区', '650100', '1');
INSERT INTO `ly_area` VALUES ('650102', '天山区', '650100', '2');
INSERT INTO `ly_area` VALUES ('650103', '沙依巴克区', '650100', '3');
INSERT INTO `ly_area` VALUES ('650104', '新市区', '650100', '4');
INSERT INTO `ly_area` VALUES ('650105', '水磨沟区', '650100', '5');
INSERT INTO `ly_area` VALUES ('650106', '头屯河区', '650100', '6');
INSERT INTO `ly_area` VALUES ('650107', '达坂城区', '650100', '7');
INSERT INTO `ly_area` VALUES ('650108', '东山区', '650100', '8');
INSERT INTO `ly_area` VALUES ('650121', '乌鲁木齐县', '650100', '9');
INSERT INTO `ly_area` VALUES ('650201', '市辖区', '650200', '1');
INSERT INTO `ly_area` VALUES ('650202', '独山子区', '650200', '2');
INSERT INTO `ly_area` VALUES ('650203', '克拉玛依区', '650200', '3');
INSERT INTO `ly_area` VALUES ('650204', '白碱滩区', '650200', '4');
INSERT INTO `ly_area` VALUES ('650205', '乌尔禾区', '650200', '5');
INSERT INTO `ly_area` VALUES ('652101', '吐鲁番市', '652100', '1');
INSERT INTO `ly_area` VALUES ('652122', '鄯善县', '652100', '2');
INSERT INTO `ly_area` VALUES ('652123', '托克逊县', '652100', '3');
INSERT INTO `ly_area` VALUES ('652201', '哈密市', '652200', '1');
INSERT INTO `ly_area` VALUES ('652222', '巴里坤哈萨克自治县', '652200', '2');
INSERT INTO `ly_area` VALUES ('652223', '伊吾县', '652200', '3');
INSERT INTO `ly_area` VALUES ('652301', '昌吉市', '652300', '1');
INSERT INTO `ly_area` VALUES ('652302', '阜康市', '652300', '2');
INSERT INTO `ly_area` VALUES ('652303', '米泉市', '652300', '3');
INSERT INTO `ly_area` VALUES ('652323', '呼图壁县', '652300', '4');
INSERT INTO `ly_area` VALUES ('652324', '玛纳斯县', '652300', '5');
INSERT INTO `ly_area` VALUES ('652325', '奇台县', '652300', '6');
INSERT INTO `ly_area` VALUES ('652327', '吉木萨尔县', '652300', '7');
INSERT INTO `ly_area` VALUES ('652328', '木垒哈萨克自治县', '652300', '8');
INSERT INTO `ly_area` VALUES ('652701', '博乐市', '652700', '1');
INSERT INTO `ly_area` VALUES ('652722', '精河县', '652700', '2');
INSERT INTO `ly_area` VALUES ('652723', '温泉县', '652700', '3');
INSERT INTO `ly_area` VALUES ('652801', '库尔勒市', '652800', '1');
INSERT INTO `ly_area` VALUES ('652822', '轮台县', '652800', '2');
INSERT INTO `ly_area` VALUES ('652823', '尉犁县', '652800', '3');
INSERT INTO `ly_area` VALUES ('652824', '若羌县', '652800', '4');
INSERT INTO `ly_area` VALUES ('652825', '且末县', '652800', '5');
INSERT INTO `ly_area` VALUES ('652826', '焉耆回族自治县', '652800', '6');
INSERT INTO `ly_area` VALUES ('652827', '和静县', '652800', '7');
INSERT INTO `ly_area` VALUES ('652828', '和硕县', '652800', '8');
INSERT INTO `ly_area` VALUES ('652829', '博湖县', '652800', '9');
INSERT INTO `ly_area` VALUES ('652901', '阿克苏市', '652900', '1');
INSERT INTO `ly_area` VALUES ('652922', '温宿县', '652900', '2');
INSERT INTO `ly_area` VALUES ('652923', '库车县', '652900', '3');
INSERT INTO `ly_area` VALUES ('652924', '沙雅县', '652900', '4');
INSERT INTO `ly_area` VALUES ('652925', '新和县', '652900', '5');
INSERT INTO `ly_area` VALUES ('652926', '拜城县', '652900', '6');
INSERT INTO `ly_area` VALUES ('652927', '乌什县', '652900', '7');
INSERT INTO `ly_area` VALUES ('652928', '阿瓦提县', '652900', '8');
INSERT INTO `ly_area` VALUES ('652929', '柯坪县', '652900', '9');
INSERT INTO `ly_area` VALUES ('653001', '阿图什市', '653000', '1');
INSERT INTO `ly_area` VALUES ('653022', '阿克陶县', '653000', '2');
INSERT INTO `ly_area` VALUES ('653023', '阿合奇县', '653000', '3');
INSERT INTO `ly_area` VALUES ('653024', '乌恰县', '653000', '4');
INSERT INTO `ly_area` VALUES ('653101', '喀什市', '653100', '1');
INSERT INTO `ly_area` VALUES ('653121', '疏附县', '653100', '2');
INSERT INTO `ly_area` VALUES ('653122', '疏勒县', '653100', '3');
INSERT INTO `ly_area` VALUES ('653123', '英吉沙县', '653100', '4');
INSERT INTO `ly_area` VALUES ('653124', '泽普县', '653100', '5');
INSERT INTO `ly_area` VALUES ('653125', '莎车县', '653100', '6');
INSERT INTO `ly_area` VALUES ('653126', '叶城县', '653100', '7');
INSERT INTO `ly_area` VALUES ('653127', '麦盖提县', '653100', '8');
INSERT INTO `ly_area` VALUES ('653128', '岳普湖县', '653100', '9');
INSERT INTO `ly_area` VALUES ('653129', '伽师县', '653100', '10');
INSERT INTO `ly_area` VALUES ('653130', '巴楚县', '653100', '11');
INSERT INTO `ly_area` VALUES ('653131', '塔什库尔干塔吉克自治县', '653100', '12');
INSERT INTO `ly_area` VALUES ('653201', '和田市', '653200', '1');
INSERT INTO `ly_area` VALUES ('653221', '和田县', '653200', '2');
INSERT INTO `ly_area` VALUES ('653222', '墨玉县', '653200', '3');
INSERT INTO `ly_area` VALUES ('653223', '皮山县', '653200', '4');
INSERT INTO `ly_area` VALUES ('653224', '洛浦县', '653200', '5');
INSERT INTO `ly_area` VALUES ('653225', '策勒县', '653200', '6');
INSERT INTO `ly_area` VALUES ('653226', '于田县', '653200', '7');
INSERT INTO `ly_area` VALUES ('653227', '民丰县', '653200', '8');
INSERT INTO `ly_area` VALUES ('654002', '伊宁市', '654000', '1');
INSERT INTO `ly_area` VALUES ('654003', '奎屯市', '654000', '2');
INSERT INTO `ly_area` VALUES ('654021', '伊宁县', '654000', '3');
INSERT INTO `ly_area` VALUES ('654022', '察布查尔锡伯自治县', '654000', '4');
INSERT INTO `ly_area` VALUES ('654023', '霍城县', '654000', '5');
INSERT INTO `ly_area` VALUES ('654024', '巩留县', '654000', '6');
INSERT INTO `ly_area` VALUES ('654025', '新源县', '654000', '7');
INSERT INTO `ly_area` VALUES ('654026', '昭苏县', '654000', '8');
INSERT INTO `ly_area` VALUES ('654027', '特克斯县', '654000', '9');
INSERT INTO `ly_area` VALUES ('654028', '尼勒克县', '654000', '10');
INSERT INTO `ly_area` VALUES ('654201', '塔城市', '654200', '1');
INSERT INTO `ly_area` VALUES ('654202', '乌苏市', '654200', '2');
INSERT INTO `ly_area` VALUES ('654221', '额敏县', '654200', '3');
INSERT INTO `ly_area` VALUES ('654223', '沙湾县', '654200', '4');
INSERT INTO `ly_area` VALUES ('654224', '托里县', '654200', '5');
INSERT INTO `ly_area` VALUES ('654225', '裕民县', '654200', '6');
INSERT INTO `ly_area` VALUES ('654226', '和布克赛尔蒙古自治县', '654200', '7');
INSERT INTO `ly_area` VALUES ('654301', '阿勒泰市', '654300', '1');
INSERT INTO `ly_area` VALUES ('654321', '布尔津县', '654300', '2');
INSERT INTO `ly_area` VALUES ('654322', '富蕴县', '654300', '3');
INSERT INTO `ly_area` VALUES ('654323', '福海县', '654300', '4');
INSERT INTO `ly_area` VALUES ('654324', '哈巴河县', '654300', '5');
INSERT INTO `ly_area` VALUES ('654325', '青河县', '654300', '6');
INSERT INTO `ly_area` VALUES ('654326', '吉木乃县', '654300', '7');
INSERT INTO `ly_area` VALUES ('659001', '石河子市', '659000', '1');
INSERT INTO `ly_area` VALUES ('659002', '阿拉尔市', '659000', '2');
INSERT INTO `ly_area` VALUES ('659003', '图木舒克市', '659000', '3');
INSERT INTO `ly_area` VALUES ('659004', '五家渠市', '659000', '4');
INSERT INTO `ly_area` VALUES ('810001', '香港', '810000', '1');
INSERT INTO `ly_area` VALUES ('810002', '中西区', '810001', '1');
INSERT INTO `ly_area` VALUES ('810003', '九龙城区', '810001', '2');
INSERT INTO `ly_area` VALUES ('810004', '南区', '810001', '3');
INSERT INTO `ly_area` VALUES ('810005', '黄大仙区', '810001', '4');
INSERT INTO `ly_area` VALUES ('810006', '油尖旺区', '810001', '5');
INSERT INTO `ly_area` VALUES ('810007', '葵青区', '810001', '6');
INSERT INTO `ly_area` VALUES ('810008', '西贡区', '810001', '7');
INSERT INTO `ly_area` VALUES ('810009', '屯门区', '810001', '8');
INSERT INTO `ly_area` VALUES ('810010', '荃湾区', '810001', '9');
INSERT INTO `ly_area` VALUES ('810011', '东区', '810001', '10');
INSERT INTO `ly_area` VALUES ('810012', '观塘区', '810001', '11');
INSERT INTO `ly_area` VALUES ('810013', '深水步区', '810001', '12');
INSERT INTO `ly_area` VALUES ('810014', '湾仔区', '810001', '13');
INSERT INTO `ly_area` VALUES ('810015', '离岛区', '810001', '14');
INSERT INTO `ly_area` VALUES ('810016', '北区', '810001', '15');
INSERT INTO `ly_area` VALUES ('810017', '沙田区', '810001', '16');
INSERT INTO `ly_area` VALUES ('810018', '大埔区', '810001', '17');
INSERT INTO `ly_area` VALUES ('810019', '元朗区', '810001', '18');
INSERT INTO `ly_area` VALUES ('820001', '澳门', '820000', '1');
INSERT INTO `ly_area` VALUES ('820002', '澳门', '820001', '1');
INSERT INTO `ly_area` VALUES ('710001', '台北市', '710000', '1');
INSERT INTO `ly_area` VALUES ('710002', '台北县', '710001', '1');
INSERT INTO `ly_area` VALUES ('710003', '基隆市', '710000', '2');
INSERT INTO `ly_area` VALUES ('910005', '中山市', '442000', '1');
INSERT INTO `ly_area` VALUES ('710004', '花莲县', '710003', '1');
INSERT INTO `ly_area` VALUES ('910006', '东莞市', '441900', '1');
INSERT INTO `ly_area` VALUES ('910010', '1111', '910007', '1');

-- ----------------------------
-- Table structure for `ly_article`
-- ----------------------------
DROP TABLE IF EXISTS `ly_article`;
CREATE TABLE `ly_article` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL DEFAULT '',
  `content` longtext NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `summary` varchar(255) DEFAULT '',
  `status` int(2) DEFAULT '0',
  `top` int(1) DEFAULT '0',
  `publish_time` datetime DEFAULT '2000-01-01 00:00:00',
  `count` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_article
-- ----------------------------
INSERT INTO `ly_article` VALUES ('1', 'WorldUhot毕业设计萌萌哒', '<p>\r\n	毕业设计萌萌哒。\r\n</p>\r\n<div>\r\n	<br /></div>', '1', '', '0', '0', '2014-05-04 17:12:41', '0');

-- ----------------------------
-- Table structure for `ly_ask`
-- ----------------------------
DROP TABLE IF EXISTS `ly_ask`;
CREATE TABLE `ly_ask` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `question` varchar(255) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `goods_id` bigint(20) DEFAULT NULL,
  `admin_id` bigint(20) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `ask_time` datetime DEFAULT NULL,
  `reply_time` datetime DEFAULT NULL,
  `type` int(3) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_ask
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_attention`
-- ----------------------------
DROP TABLE IF EXISTS `ly_attention`;
CREATE TABLE `ly_attention` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(11) NOT NULL,
  `goods_id` bigint(11) NOT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_attention
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_attr_value`
-- ----------------------------
DROP TABLE IF EXISTS `ly_attr_value`;
CREATE TABLE `ly_attr_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `attr_id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sort` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID_NAME` (`attr_id`,`name`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_attr_value
-- ----------------------------
INSERT INTO `ly_attr_value` VALUES ('1', '1073741824', '5.6英寸及以上', '0');
INSERT INTO `ly_attr_value` VALUES ('2', '1073741824', '5.5-5.0英寸', '1');
INSERT INTO `ly_attr_value` VALUES ('3', '1073741824', '4.9-4.1英寸', '2');
INSERT INTO `ly_attr_value` VALUES ('4', '1073741824', '4.0-3.1英寸', '3');
INSERT INTO `ly_attr_value` VALUES ('5', '1073741824', '3.0英寸及以下', '4');
INSERT INTO `ly_attr_value` VALUES ('6', '1073741825', '10.1英寸及以下', '0');
INSERT INTO `ly_attr_value` VALUES ('7', '1073741825', '11英寸', '1');
INSERT INTO `ly_attr_value` VALUES ('8', '1073741825', '12英寸', '2');
INSERT INTO `ly_attr_value` VALUES ('9', '1073741825', '13英寸', '3');
INSERT INTO `ly_attr_value` VALUES ('10', '1073741825', '14英寸', '4');
INSERT INTO `ly_attr_value` VALUES ('11', '1073741825', '15英寸', '5');
INSERT INTO `ly_attr_value` VALUES ('12', '1073741825', '16英寸-17英寸', '6');
INSERT INTO `ly_attr_value` VALUES ('13', '1073741825', '17英寸以上', '7');
INSERT INTO `ly_attr_value` VALUES ('14', '1073741826', '普通触控', '0');
INSERT INTO `ly_attr_value` VALUES ('15', '1073741826', '变形触控', '1');
INSERT INTO `ly_attr_value` VALUES ('16', '1073741826', '非触控', '2');
INSERT INTO `ly_attr_value` VALUES ('17', '1073741827', 'i3Intel', '0');
INSERT INTO `ly_attr_value` VALUES ('18', '1073741827', 'i5Intel', '1');
INSERT INTO `ly_attr_value` VALUES ('19', '1073741827', 'i7Intel', '2');
INSERT INTO `ly_attr_value` VALUES ('20', '1073741827', 'A6AMD', '3');
INSERT INTO `ly_attr_value` VALUES ('21', '1073741827', 'A8AMD', '4');
INSERT INTO `ly_attr_value` VALUES ('22', '1073741827', 'A10AMD', '5');
INSERT INTO `ly_attr_value` VALUES ('23', '1073741828', '性能级独显', '0');
INSERT INTO `ly_attr_value` VALUES ('24', '1073741828', '玩家级独显', '1');
INSERT INTO `ly_attr_value` VALUES ('25', '1073741829', '长袖', '0');
INSERT INTO `ly_attr_value` VALUES ('26', '1073741829', '短袖', '1');
INSERT INTO `ly_attr_value` VALUES ('27', '1073741829', '七分袖', '2');
INSERT INTO `ly_attr_value` VALUES ('28', '1073741829', '无袖', '3');
INSERT INTO `ly_attr_value` VALUES ('29', '1073741829', '九分袖', '4');
INSERT INTO `ly_attr_value` VALUES ('30', '1073741829', '五分袖/中袖', '5');
INSERT INTO `ly_attr_value` VALUES ('31', '1073741829', '其它', '6');
INSERT INTO `ly_attr_value` VALUES ('32', '1073741830', '棉', '0');
INSERT INTO `ly_attr_value` VALUES ('33', '1073741830', '涤纶', '1');
INSERT INTO `ly_attr_value` VALUES ('34', '1073741830', '真丝', '2');
INSERT INTO `ly_attr_value` VALUES ('35', '1073741830', '绸缎', '3');
INSERT INTO `ly_attr_value` VALUES ('36', '1073741830', ' 雪纺', '4');
INSERT INTO `ly_attr_value` VALUES ('37', '1073741830', '亚麻/大麻/汉麻', '5');
INSERT INTO `ly_attr_value` VALUES ('38', '1073741830', ' 腈纶/化纤', '6');
INSERT INTO `ly_attr_value` VALUES ('39', '1073741830', '莫代尔', '7');
INSERT INTO `ly_attr_value` VALUES ('40', '1073741830', ' 锦纶', '8');
INSERT INTO `ly_attr_value` VALUES ('41', '1073741830', '其它', '9');
INSERT INTO `ly_attr_value` VALUES ('42', '1073741831', '长袖', '0');
INSERT INTO `ly_attr_value` VALUES ('43', '1073741831', '短袖', '1');
INSERT INTO `ly_attr_value` VALUES ('44', '1073741831', '五分袖', '2');
INSERT INTO `ly_attr_value` VALUES ('45', '1073741831', '七分袖', '3');
INSERT INTO `ly_attr_value` VALUES ('46', '1073741831', '无袖', '4');
INSERT INTO `ly_attr_value` VALUES ('47', '1073741832', '立领', '0');
INSERT INTO `ly_attr_value` VALUES ('48', '1073741832', '圆领', '1');
INSERT INTO `ly_attr_value` VALUES ('49', '1073741832', '心领', '2');
INSERT INTO `ly_attr_value` VALUES ('50', '1073741832', '无领', '3');
INSERT INTO `ly_attr_value` VALUES ('51', '1073741832', '常规', '4');

-- ----------------------------
-- Table structure for `ly_balance_log`
-- ----------------------------
DROP TABLE IF EXISTS `ly_balance_log`;
CREATE TABLE `ly_balance_log` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(11) DEFAULT '0',
  `user_id` bigint(11) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `time` datetime DEFAULT NULL,
  `amount` float(10,2) NOT NULL,
  `amount_log` float(10,2) NOT NULL,
  `note` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_balance_log
-- ----------------------------
INSERT INTO `ly_balance_log` VALUES ('4', '3', '2', '2', '2017-05-17 19:09:29', '100000.00', '100000.00', '管理员为您充值,充值的金额为：100000');
INSERT INTO `ly_balance_log` VALUES ('5', '3', '5', '2', '2017-05-18 21:46:33', '100000.00', '100000.00', '管理员为您充值,充值的金额为：100000');
INSERT INTO `ly_balance_log` VALUES ('6', '0', '5', '0', '2017-05-18 21:49:08', '-65.00', '99935.00', '通过余额支付方式进行商品购买,订单编号：20170518214859824246');

-- ----------------------------
-- Table structure for `ly_brand`
-- ----------------------------
DROP TABLE IF EXISTS `ly_brand`;
CREATE TABLE `ly_brand` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `url` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `content` text,
  `sort` int(11) DEFAULT '1',
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_keywords` varchar(255) DEFAULT NULL,
  `seo_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_brand
-- ----------------------------
INSERT INTO `ly_brand` VALUES ('1', '三星', 'http://www.samsung.com/', 'data/uploads/2017/04/28/38bfb11bf48fc2f56d2ca2d796d0b0af.gif', '', '1', '', '', '');
INSERT INTO `ly_brand` VALUES ('2', '苹果', 'http://www.apple.com/', 'data/uploads/2017/04/29/f2eaba12529e00081c4ed5832713a946.png', '', '1', '', '', '');
INSERT INTO `ly_brand` VALUES ('3', '小米', 'http://www.mi.com/', 'data/uploads/2017/04/28/2897d450bec860604e70007a9511c99d.png', '', '2', '', '', '');
INSERT INTO `ly_brand` VALUES ('4', '联想', 'http://www.lenovo.com.cn/', 'data/uploads/2017/04/29/a691d4112f465f542c99ac8239982627.gif', '', '2', '', '', '');

-- ----------------------------
-- Table structure for `ly_bundling`
-- ----------------------------
DROP TABLE IF EXISTS `ly_bundling`;
CREATE TABLE `ly_bundling` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(120) DEFAULT NULL,
  `price` float(10,2) NOT NULL DEFAULT '0.00',
  `description` text,
  `goods_id` varchar(255) NOT NULL,
  `status` int(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_bundling
-- ----------------------------
INSERT INTO `ly_bundling` VALUES ('1', '男式风经典', '105.00', '', '25,24', '1');
INSERT INTO `ly_bundling` VALUES ('2', '男式风采系统', '180.00', '', '23,22,21', '1');
INSERT INTO `ly_bundling` VALUES ('3', '女式潮', '240.00', '', '20,19,18,17,16', '1');

-- ----------------------------
-- Table structure for `ly_cache`
-- ----------------------------
DROP TABLE IF EXISTS `ly_cache`;
CREATE TABLE `ly_cache` (
  `key` varchar(40) NOT NULL,
  `content` text NOT NULL,
  `delay` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_cache
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_cart`
-- ----------------------------
DROP TABLE IF EXISTS `ly_cart`;
CREATE TABLE `ly_cart` (
  `user_id` bigint(20) NOT NULL,
  `cart` text,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_cart
-- ----------------------------
INSERT INTO `ly_cart` VALUES ('2', 'O:4:\"Cart\":1:{s:11:\"\0Cart\0items\";a:1:{i:105;i:1;}}');
INSERT INTO `ly_cart` VALUES ('5', 'O:4:\"Cart\":1:{s:11:\"\0Cart\0items\";a:1:{i:117;i:1;}}');

-- ----------------------------
-- Table structure for `ly_category`
-- ----------------------------
DROP TABLE IF EXISTS `ly_category`;
CREATE TABLE `ly_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `alias` varchar(200) DEFAULT '',
  `parent_id` bigint(20) NOT NULL,
  `count` bigint(20) DEFAULT '0',
  `path` varchar(20000) DEFAULT NULL,
  `sort` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `alias` (`alias`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_category
-- ----------------------------
INSERT INTO `ly_category` VALUES ('1', '公告', 'common', '0', '0', ',1,', '1');

-- ----------------------------
-- Table structure for `ly_class_config`
-- ----------------------------
DROP TABLE IF EXISTS `ly_class_config`;
CREATE TABLE `ly_class_config` (
  `class_name` varchar(40) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `config` text,
  `status` int(1) DEFAULT '0',
  PRIMARY KEY (`class_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_class_config
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_customer`
-- ----------------------------
DROP TABLE IF EXISTS `ly_customer`;
CREATE TABLE `ly_customer` (
  `user_id` bigint(20) NOT NULL,
  `real_name` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `province` bigint(20) DEFAULT NULL,
  `city` bigint(20) DEFAULT NULL,
  `county` bigint(20) DEFAULT NULL,
  `addr` varchar(250) DEFAULT NULL,
  `qq` varchar(15) DEFAULT NULL,
  `sex` tinyint(1) DEFAULT '1',
  `birthday` date DEFAULT NULL,
  `group_id` int(6) DEFAULT '0',
  `point` int(11) DEFAULT '0',
  `message_ids` text,
  `prop` text,
  `balance` float(10,2) DEFAULT '0.00',
  `custom` varchar(255) DEFAULT NULL,
  `reg_time` datetime DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  `checkin_time` date DEFAULT NULL,
  `mobile_verified` int(1) DEFAULT '0',
  `email_verified` int(1) DEFAULT '0',
  `pay_password_open` int(1) DEFAULT '0',
  `pay_password` varchar(32) DEFAULT NULL,
  `pay_validcode` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_customer
-- ----------------------------
INSERT INTO `ly_customer` VALUES ('2', '世界诱货', '2008800', '13100376164', '440000', '440100', '440106', 'crazyly', null, '1', '2017-05-16', '0', '10000', null, null, '100000.00', null, null, '2017-05-18 21:28:24', null, '0', '0', '0', null, null);
INSERT INTO `ly_customer` VALUES ('3', null, null, '0', null, null, null, null, null, '1', null, '0', '0', null, null, '0.00', null, '2017-05-17 18:53:02', '2017-05-17 18:53:02', null, '0', '0', '0', null, null);
INSERT INTO `ly_customer` VALUES ('5', '小路', '13642779418', '0', '440000', '440100', '440106', '东圃镇黄村达维商务中心3106', null, '0', '1995-06-29', '0', '0', null, null, '99935.00', null, '2017-05-18 21:45:12', '2017-05-19 19:08:22', null, '0', '1', '0', null, null);

-- ----------------------------
-- Table structure for `ly_disorder`
-- ----------------------------
DROP TABLE IF EXISTS `ly_disorder`;
CREATE TABLE `ly_disorder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `dispro_id` bigint(20) NOT NULL,
  `totalmoney` float(10,2) NOT NULL,
  `qty` int(8) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_disorder
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_dispro`
-- ----------------------------
DROP TABLE IF EXISTS `ly_dispro`;
CREATE TABLE `ly_dispro` (
  `id` bigint(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `dispro_no` varchar(20) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `content` text,
  `img` varchar(255) DEFAULT NULL,
  `imgs` text,
  `market_price` float(10,2) NOT NULL,
  `cost_price` float(10,2) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `store_nums` int(11) DEFAULT '0',
  `warning_line` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_dispro
-- ----------------------------
INSERT INTO `ly_dispro` VALUES ('1', '测试', 'FX0001', '100g', '我是一个分销测试商品请，多多光照', 'data/uploads/2017/05/17/b307f4e32b513d412ed99991d1315229.png', 'a:1:{i:0;s:60:\"data/uploads/2017/05/17/b307f4e32b513d412ed99991d1315229.png\";}', '300.00', '100.00', '2017-05-17 21:53:03', '1000', '10', '1');
INSERT INTO `ly_dispro` VALUES ('2', '测试2', 'XF0002', '200g', '我是测试分销产品2，多多关注', 'data/uploads/2017/05/17/cdac154b7aa92c5907fbf7e7215ed5b4.png', 'a:1:{i:0;s:60:\"data/uploads/2017/05/17/cdac154b7aa92c5907fbf7e7215ed5b4.png\";}', '400.00', '200.00', '2017-05-17 22:07:43', '1000', '20', '1');

-- ----------------------------
-- Table structure for `ly_doc_invoice`
-- ----------------------------
DROP TABLE IF EXISTS `ly_doc_invoice`;
CREATE TABLE `ly_doc_invoice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `invoice_no` varchar(50) DEFAULT NULL,
  `order_id` bigint(20) NOT NULL,
  `order_no` varchar(50) NOT NULL,
  `admin` varchar(20) DEFAULT NULL,
  `accept_name` varchar(50) DEFAULT NULL,
  `province` bigint(20) DEFAULT NULL,
  `city` bigint(20) DEFAULT NULL,
  `county` bigint(20) DEFAULT NULL,
  `zip` varchar(6) DEFAULT NULL,
  `addr` varchar(250) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `express_no` varchar(50) DEFAULT NULL,
  `express_company_id` bigint(20) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_doc_invoice
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_doc_receiving`
-- ----------------------------
DROP TABLE IF EXISTS `ly_doc_receiving`;
CREATE TABLE `ly_doc_receiving` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `admin_id` bigint(20) DEFAULT NULL,
  `amount` float(10,2) DEFAULT '0.00',
  `create_time` datetime DEFAULT NULL,
  `payment_time` datetime DEFAULT NULL,
  `doc_type` tinyint(1) DEFAULT NULL,
  `payment_id` bigint(20) DEFAULT NULL,
  `pay_status` tinyint(1) DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_doc_receiving
-- ----------------------------
INSERT INTO `ly_doc_receiving` VALUES ('3', '3', '5', null, '65.00', '2017-05-18 21:49:08', '2017-05-18 21:49:08', '0', '1', '1', null);

-- ----------------------------
-- Table structure for `ly_doc_refund`
-- ----------------------------
DROP TABLE IF EXISTS `ly_doc_refund`;
CREATE TABLE `ly_doc_refund` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `order_no` varchar(20) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `refund_type` tinyint(3) DEFAULT '0',
  `account_bank` varchar(100) DEFAULT NULL,
  `account_name` varchar(30) DEFAULT NULL,
  `refund_account` varchar(50) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `pay_status` tinyint(3) DEFAULT '0',
  `content` text,
  `handling_idea` text,
  `handling_time` datetime DEFAULT NULL,
  `channel` varchar(50) DEFAULT NULL,
  `bank_account` varchar(255) DEFAULT NULL,
  `amount` float(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_doc_refund
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_doc_returns`
-- ----------------------------
DROP TABLE IF EXISTS `ly_doc_returns`;
CREATE TABLE `ly_doc_returns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `order_no` varchar(50) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `province` bigint(20) DEFAULT NULL,
  `city` bigint(20) DEFAULT NULL,
  `county` binary(1) DEFAULT NULL,
  `zip` varchar(6) DEFAULT NULL,
  `addr` varchar(250) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `express_no` varchar(255) DEFAULT NULL,
  `express` varchar(255) DEFAULT NULL,
  `handling_idea` varchar(255) DEFAULT NULL,
  `status` tinyint(3) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_doc_returns
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_express`
-- ----------------------------
DROP TABLE IF EXISTS `ly_express`;
CREATE TABLE `ly_express` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `area` text,
  `area_groupid` text,
  `firstprice` text,
  `secondprice` text,
  `type` tinyint(1) DEFAULT NULL,
  `first_weight` int(11) DEFAULT NULL,
  `second_weight` int(11) DEFAULT NULL,
  `first_price` float(10,2) DEFAULT '0.00',
  `second_price` float(10,2) DEFAULT '0.00',
  `status` tinyint(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `is_save_price` tinyint(1) DEFAULT '0',
  `save_rate` int(11) DEFAULT NULL,
  `low_price` float(10,2) DEFAULT '0.00',
  `price_type` tinyint(1) DEFAULT '0',
  `open_default` tinyint(1) DEFAULT '1',
  `is_delete` tinyint(1) DEFAULT '0',
  `express_company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_express
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_express_company`
-- ----------------------------
DROP TABLE IF EXISTS `ly_express_company`;
CREATE TABLE `ly_express_company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `alias` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `sort` tinyint(3) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_express_company
-- ----------------------------
INSERT INTO `ly_express_company` VALUES ('1', 'CNEMS', 'ems', '中国邮政', 'http://www.ems.com.cn', '0');
INSERT INTO `ly_express_company` VALUES ('2', 'CNST', 'shentong', '申通快递', 'http://www.sto.cn', '0');
INSERT INTO `ly_express_company` VALUES ('3', 'CNTT', 'tiantian', '天天快递', 'http://www.ttkd.cn', '0');
INSERT INTO `ly_express_company` VALUES ('4', 'CNYT', 'yuantong', '圆通速递', 'http://www.yto.net.cn', '0');
INSERT INTO `ly_express_company` VALUES ('5', 'CNSF', 'shunfeng', '顺丰速运', 'http://www.sf-express.com', '0');
INSERT INTO `ly_express_company` VALUES ('6', 'CNYD', 'yunda', '韵达快递', 'http://www.yundaex.com', '0');
INSERT INTO `ly_express_company` VALUES ('7', 'CNZT', 'zhongtong', '中通速递', 'http://www.zto.cn', '0');
INSERT INTO `ly_express_company` VALUES ('8', 'CNLB', 'longbanwuliu', '龙邦物流', 'http://www.lbex.com.cn', '0');
INSERT INTO `ly_express_company` VALUES ('9', 'CNZJS', 'zhaijisong', '宅急送', 'http://www.zjs.com.cn', '0');
INSERT INTO `ly_express_company` VALUES ('10', 'CNQY', 'quanyikuaidi', '全一快递', 'http://www.apex100.com', '0');
INSERT INTO `ly_express_company` VALUES ('11', 'CNHT', 'huitongkuaidi', '汇通速递', 'http://www.htky365.com', '0');
INSERT INTO `ly_express_company` VALUES ('12', 'CNMH', 'minghangkuaidi', '民航快递', 'http://www.cae.com.cn', '0');
INSERT INTO `ly_express_company` VALUES ('13', 'CNYF', 'yafengsudi', '亚风速递', 'http://www.airfex.cn', '0');
INSERT INTO `ly_express_company` VALUES ('14', 'CNKJ', 'kuaijiesudi', '快捷速递', 'http://www.fastexpress.com.cn', '0');
INSERT INTO `ly_express_company` VALUES ('15', 'DDS', 'dsukuaidi', 'DDS快递', 'http://www.qc-dds.net', '0');
INSERT INTO `ly_express_company` VALUES ('16', 'CNHY', 'tiandihuayu', '华宇物流', 'http://www.hoau.net', '0');
INSERT INTO `ly_express_company` VALUES ('17', 'CNZY', 'zhongtiewuliu', '中铁快运', 'http://www.cre.cn', '0');
INSERT INTO `ly_express_company` VALUES ('18', 'FEDEX', 'fedex', 'FedEx', 'http://www.fedex.com/cn', '0');
INSERT INTO `ly_express_company` VALUES ('19', 'UPS', 'ups', 'UPS', 'http://www.ups.com', '0');
INSERT INTO `ly_express_company` VALUES ('20', 'DHL', 'dhl', 'DHL', 'http://www.cn.dhl.com', '0');

-- ----------------------------
-- Table structure for `ly_express_template`
-- ----------------------------
DROP TABLE IF EXISTS `ly_express_template`;
CREATE TABLE `ly_express_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `content` text,
  `background` varchar(255) DEFAULT NULL,
  `width` int(5) DEFAULT '900',
  `height` int(5) DEFAULT '600',
  `offset_x` int(5) DEFAULT '0',
  `offset_y` int(5) DEFAULT '0',
  `is_default` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_express_template
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_fare`
-- ----------------------------
DROP TABLE IF EXISTS `ly_fare`;
CREATE TABLE `ly_fare` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `first_weight` int(11) NOT NULL,
  `second_weight` int(11) NOT NULL,
  `first_price` float(10,2) NOT NULL,
  `second_price` float(10,2) DEFAULT NULL,
  `zoning` text,
  `is_default` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_fare
-- ----------------------------
INSERT INTO `ly_fare` VALUES ('1', '最新标准运费', '1000', '1000', '10.00', '5.00', 'a:2:{i:0;a:6:{s:4:\"area\";s:370:\"310100,310200,320100,320200,320300,320400,320500,320600,320700,320800,320900,321000,321100,321200,321300,330100,330200,330300,330400,330500,330600,330700,330800,330900,331000,331100,340100,340200,340300,340400,340500,340600,340700,340800,341000,341100,341200,341300,341500,341600,341700,341800,360100,360200,360300,360400,360500,360600,360700,360800,360900,361000,361100\";s:8:\"f_weight\";s:4:\"1000\";s:7:\"f_price\";s:1:\"8\";s:8:\"s_weight\";s:4:\"1000\";s:7:\"s_price\";s:1:\"5\";s:5:\"names\";s:49:\"上海市,江苏省,浙江省,安徽省,江西省\";}i:1;a:6:{s:4:\"area\";s:41:\"110100,110200,120100,120200,130200,130600\";s:8:\"f_weight\";s:4:\"1000\";s:7:\"f_price\";s:2:\"12\";s:8:\"s_weight\";s:4:\"1000\";s:7:\"s_price\";s:1:\"6\";s:5:\"names\";s:39:\"北京市,天津市,唐山市,保定市\";}}', '1');

-- ----------------------------
-- Table structure for `ly_flash_sale`
-- ----------------------------
DROP TABLE IF EXISTS `ly_flash_sale`;
CREATE TABLE `ly_flash_sale` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `max_num` int(11) NOT NULL,
  `quota_num` int(11) NOT NULL DEFAULT '1',
  `price` float(10,2) NOT NULL,
  `goods_id` bigint(20) NOT NULL,
  `description` text,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `goods_num` bigint(20) DEFAULT '0',
  `order_num` bigint(20) DEFAULT '0',
  `is_end` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_flash_sale
-- ----------------------------
INSERT INTO `ly_flash_sale` VALUES ('1', '2017夏装长袖男士格子衬衣拼接波点修身休闲衬衫衫青春百搭潮热卖', '30', '1', '70.00', '22', '', '2014-05-04 10:23:00', '2014-06-30 10:23:00', '0', '0', '1');
INSERT INTO `ly_flash_sale` VALUES ('2', '白衬衫女短袖2017新款夏装女衬衣大码工作服工装 只限10件了', '10', '1', '50.00', '17', '', '2014-05-04 10:24:00', '2014-06-27 10:24:00', '1', '1', '1');
INSERT INTO `ly_flash_sale` VALUES ('3', '小米手机6 热抢中', '100', '1', '1600.00', '7', '', '2017-05-19 19:21:00', '2017-05-31 19:21:00', '0', '0', '0');
INSERT INTO `ly_flash_sale` VALUES ('5', '抢购抢购', '10', '1', '1999.00', '10', '', '2017-05-19 19:23:00', '2017-05-31 19:23:00', '0', '0', '0');

-- ----------------------------
-- Table structure for `ly_gallery`
-- ----------------------------
DROP TABLE IF EXISTS `ly_gallery`;
CREATE TABLE `ly_gallery` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(2) DEFAULT '0',
  `key` char(40) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_gallery
-- ----------------------------
INSERT INTO `ly_gallery` VALUES ('1', '2', 'dfc1f156cb696a415fa67299c8c8accc', 'data/uploads/2017/04/28/38bfb11bf48fc2f56d2ca2d796d0b0af.gif');
INSERT INTO `ly_gallery` VALUES ('2', '2', 'da41e56a98e03b3b916c645971d05efe', 'data/uploads/2017/04/28/2897d450bec860604e70007a9511c99d.png');
INSERT INTO `ly_gallery` VALUES ('3', '2', '624baf6475a02bfea089b456bb1e5bdb', 'data/uploads/2017/04/29/f2eaba12529e00081c4ed5832713a946.png');
INSERT INTO `ly_gallery` VALUES ('4', '0', '1678f030ef2f09c6f91b598d5a5a0b85', 'data/uploads/2017/04/29/7a18d229142972a45f19d34dd1bbc3bb.jpg');
INSERT INTO `ly_gallery` VALUES ('5', '0', '320d84617a232dbeafdc2aa81d850b31', 'data/uploads/2017/04/29/bee3fc7f0746b54f51fc5f1a2e7a38e3.jpg');
INSERT INTO `ly_gallery` VALUES ('6', '0', '314de642d88ab425090209c625c6e274', 'data/uploads/2017/04/29/ef93ee15ca9544b261513dd76bb56fae.jpg');
INSERT INTO `ly_gallery` VALUES ('7', '0', 'd8026864eeba235a98cb222bb5c9c329', 'data/uploads/2017/04/29/d6e93371fdcfae0890fe519fdeb50129.jpg');
INSERT INTO `ly_gallery` VALUES ('8', '0', 'e808b7c4c0f49e1a5a5f4362042a34cb', 'data/uploads/2017/04/29/519ecfe92a47cf2b98d6504dd875c211.png');
INSERT INTO `ly_gallery` VALUES ('9', '0', 'c76c6c743f75aedd49bc288442248b45', 'data/uploads/2017/04/29/870c43499b99862429287c2d4119fef6.jpg');
INSERT INTO `ly_gallery` VALUES ('10', '0', 'd2eb7bd9279d220c68d09a583702711d', 'data/uploads/2017/04/29/6b33dafad4bb8752240cf2d3ab066be8.jpg');
INSERT INTO `ly_gallery` VALUES ('11', '0', '653bb4fb012302df0afa03e5be685dcb', 'data/uploads/2017/04/29/4e7afbf5508fb11769950c397b67c03b.png');
INSERT INTO `ly_gallery` VALUES ('12', '2', '73f6e69ace2a06a08944a202998b2454', 'data/uploads/2017/04/29/a691d4112f465f542c99ac8239982627.gif');
INSERT INTO `ly_gallery` VALUES ('13', '0', '69751baae52c2b3b1e0cc559f3f9abc1', 'data/uploads/2017/04/29/8f551833e1ab9568186641fe4b5b0101.jpg');
INSERT INTO `ly_gallery` VALUES ('14', '0', 'e4d71c8d4aaf71d82529676484b186ba', 'data/uploads/2017/04/30/b8f4125b967911e08f7115f8d2b3f684.jpg');
INSERT INTO `ly_gallery` VALUES ('15', '0', '49c20ee2651aae7496e1f80947e7f334', 'data/uploads/2017/04/30/eab91d30be1f31560db64cc14c277d32.jpg');
INSERT INTO `ly_gallery` VALUES ('16', '0', '132d6b46fe7ef222ada4f99fe736795d', 'data/uploads/2017/04/30/62527b26f1afbe204f247b72d1f20c2d.jpg');
INSERT INTO `ly_gallery` VALUES ('17', '0', '776939f2048bdc7b09fdd55d98580bc7', 'data/uploads/2017/04/30/bfe7319f2b2387bcd20dca7e92b83325.jpg');
INSERT INTO `ly_gallery` VALUES ('18', '0', '98041acacfcb43d12ba78227b16f24b4', 'data/uploads/2017/04/30/f31a00b4e0f6617378095a8c1bfb00c9.jpg');
INSERT INTO `ly_gallery` VALUES ('19', '0', '1fda76d3056b46ba4c0547c0d5bb17ff', 'data/uploads/2017/04/30/f16151cf9685b0e3653e8287bfed2b0d.jpg');
INSERT INTO `ly_gallery` VALUES ('20', '0', '5fa43753e18ce31bda5010a9ba9032ba', 'data/uploads/2017/04/30/f3ccdd27d2000e3f9255a7e3e2c48800.jpg');
INSERT INTO `ly_gallery` VALUES ('21', '0', 'c1ab64673cf731e5936d880c8a3c1321', 'data/uploads/2017/04/30/fe5df232cafa4c4e0f1a0294418e5660.jpg');
INSERT INTO `ly_gallery` VALUES ('22', '0', '5000c012db2b2e0ba05e2ab1110f2ad8', 'data/uploads/2017/04/30/95fc43a276b4706c1eb6be35a460dcc9.jpg');
INSERT INTO `ly_gallery` VALUES ('23', '0', '0814690944a93562f29f23b7c66fafa2', 'data/uploads/2017/04/30/b6d8ff9b2b918ddde6585cba4c82bf72.jpg');
INSERT INTO `ly_gallery` VALUES ('24', '0', '66a90b7ceb166e0828cc87b6281c2f4f', 'data/uploads/2017/05/04/6a63f7365e4430b5d07791fd32c66500.jpg');
INSERT INTO `ly_gallery` VALUES ('25', '0', '8dac84c75059c033deef31b81cff7407', 'data/uploads/2017/05/04/f81d28ad7c32504c0af3a8c44eec681e.jpg');
INSERT INTO `ly_gallery` VALUES ('26', '0', 'b244261cafcfc167d06741944f4660e4', 'data/uploads/2017/05/04/ef5a1ccdd16137f07139fe972f8be244.jpg');
INSERT INTO `ly_gallery` VALUES ('27', '0', 'bf256e0c84db9df7078fa70e51f25112', 'data/uploads/2017/05/04/fb84a52b8da8869e478a236ed10172b8.jpg');
INSERT INTO `ly_gallery` VALUES ('28', '0', '39908687efde23ffc5a9d522e926099c', 'data/uploads/2017/05/04/fc518b7ed40e2e80188331149c9a8d5e.jpg');
INSERT INTO `ly_gallery` VALUES ('29', '0', '94cc3e24f660dc3d3de3624e1a25eb99', 'data/uploads/2017/05/04/da175403c79047247a25e76ec8c4913a.jpg');
INSERT INTO `ly_gallery` VALUES ('30', '0', 'c94e6353fe07cb04dc924837d43f5b84', 'data/uploads/2017/05/04/364ed7cdfd1e19f1d2aed3aefa46145d.jpg');
INSERT INTO `ly_gallery` VALUES ('31', '0', '3a0cbf90373b11d1304285d2843198fd', 'data/uploads/2017/05/04/b1dcd910f2d270c11d91668ecfbf7302.jpg');
INSERT INTO `ly_gallery` VALUES ('32', '0', 'fff62e0a7f7ebea6a32965f26951949f', 'data/uploads/2017/05/04/19579466f48282ec37548040b0c69bb3.jpg');
INSERT INTO `ly_gallery` VALUES ('33', '0', '109ed7d42c91e34c460dcc8443b6d6af', 'data/uploads/2017/05/04/a56ab48abdf9aefdef5fd16abb44d02c.jpg');
INSERT INTO `ly_gallery` VALUES ('34', '0', '12d0beb07614e67093829e14e24f6d6e', 'data/uploads/2017/05/04/16615175a6eff3846c20d4e68100ed70.jpg');
INSERT INTO `ly_gallery` VALUES ('35', '0', '849e216bbcc913b9c1b66213b3c19b0f', 'data/uploads/2017/05/04/9bd757b51fc75afd17475b667a042599.jpg');
INSERT INTO `ly_gallery` VALUES ('36', '0', '9b1dabbb04c92bad947371c2b322aeba', 'data/uploads/2017/05/04/451b95af03616fd150e78fdc84a22378.jpg');
INSERT INTO `ly_gallery` VALUES ('37', '4', '0267896585ade545b695c21062d03ff4', 'data/uploads/2017/05/13/b5cf5e20eda87a3ff77e4a2d33828947.jpg');
INSERT INTO `ly_gallery` VALUES ('38', '4', 'e67ad91921d2ab7137f1813f0a5c7deb', 'data/uploads/2017/05/13/9670df531a008c75e7bed5b8967efd66.gif');
INSERT INTO `ly_gallery` VALUES ('39', '0', 'dfec144e21f83346cb0229d4dbefcb7a', 'data/uploads/2017/05/13/9359c86ef905712427d3435d230990f2.jpg');
INSERT INTO `ly_gallery` VALUES ('40', '0', '62f7096426f2186a2f5157ed0ff1b80f', 'data/uploads/2017/05/13/761d03b10a807e017101ba984da121cb.jpg');
INSERT INTO `ly_gallery` VALUES ('41', '0', '9635a0b4303fb9c507be7e19c5ef956e', 'data/uploads/2017/05/16/85448ed6736c30c6d347908a9fb563e6.jpg');
INSERT INTO `ly_gallery` VALUES ('42', '0', 'b6f9fd2a44383e14e0dbdc806d0fa685', 'data/uploads/2017/05/16/8c442244ae43b5d708135659863f0f21.jpg');
INSERT INTO `ly_gallery` VALUES ('43', '0', 'd55f25fb534158f2a02288fdde21f3d8', 'data/uploads/2017/05/17/32e90fcddb7f78a740a8dc251ad67769.png');
INSERT INTO `ly_gallery` VALUES ('44', '0', 'e8371070df04331285c343e4a359d251', 'data/uploads/2017/05/17/9f9872471c3aa4c25a87277566e1073d.jpg');
INSERT INTO `ly_gallery` VALUES ('45', '0', '1cb54e571b3b55a25e1be53516ccba8e', 'data/uploads/2017/05/17/d6e52d50066a3196cf3d4c81f8a70a6c.jpg');
INSERT INTO `ly_gallery` VALUES ('46', '0', '439226c02f8b0bfd869f132f67015161', 'data/uploads/2017/05/17/f17cd603499d5c423fb01cdd31d5e1da.jpg');
INSERT INTO `ly_gallery` VALUES ('47', '0', '10d03809b4fc53b58bc074a1eef04337', 'data/uploads/2017/05/17/a9813bff8c629d0fee20003991fd4e80.jpg');
INSERT INTO `ly_gallery` VALUES ('48', '0', '3fd74f9fccdf2981e8fe948d729a723e', 'data/uploads/2017/05/17/3248247751dc716bcad8c2e3a5979774.jpg');
INSERT INTO `ly_gallery` VALUES ('49', '0', 'c063a4e4288bd22ab039cbfcb60e30c4', 'data/uploads/2017/05/17/d005a25b64172b8d0426dcc1b5e58dae.jpg');
INSERT INTO `ly_gallery` VALUES ('50', '0', 'a77ba3a65b2722847f9b9febf37cec15', 'data/uploads/2017/05/17/c88c9d0f78814f06a7e2b3015d2a2e15.jpg');
INSERT INTO `ly_gallery` VALUES ('51', '0', 'c892992eed2db3be800402489af79796', 'data/uploads/2017/05/17/25aa0a8ccdf624ad498dd77359500c7a.jpg');
INSERT INTO `ly_gallery` VALUES ('52', '0', '720f20eeeabe5e706764e77416430970', 'data/uploads/2017/05/17/9fd2a720440ec2286786d57172720454.jpg');
INSERT INTO `ly_gallery` VALUES ('53', '0', '0ec1d1d875c51eabbc793ba5518f653b', 'data/uploads/2017/05/17/b307f4e32b513d412ed99991d1315229.png');
INSERT INTO `ly_gallery` VALUES ('54', '0', '56c8eaf6eb3a3e5d640fd51b33997a63', 'data/uploads/2017/05/17/cdac154b7aa92c5907fbf7e7215ed5b4.png');

-- ----------------------------
-- Table structure for `ly_goods`
-- ----------------------------
DROP TABLE IF EXISTS `ly_goods`;
CREATE TABLE `ly_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `category_id` bigint(20) NOT NULL,
  `goods_no` varchar(20) NOT NULL,
  `pro_no` varchar(20) NOT NULL,
  `type_id` bigint(20) NOT NULL,
  `brand_id` bigint(20) DEFAULT NULL,
  `unit` varchar(10) NOT NULL,
  `content` text,
  `img` varchar(255) DEFAULT NULL,
  `imgs` text,
  `tag_ids` varchar(255) DEFAULT NULL,
  `sell_price` float(10,2) NOT NULL,
  `market_price` float(10,2) NOT NULL,
  `cost_price` float(10,2) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `store_nums` int(11) DEFAULT '0',
  `warning_line` int(11) DEFAULT '0',
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_keywords` varchar(255) DEFAULT NULL,
  `seo_description` varchar(255) DEFAULT NULL,
  `weight` int(11) DEFAULT '0',
  `point` int(11) DEFAULT '0',
  `visit` int(11) DEFAULT '0',
  `favorite` int(11) DEFAULT '0',
  `sort` int(11) DEFAULT '1',
  `specs` text,
  `attrs` text,
  `prom_id` bigint(20) DEFAULT '0',
  `is_online` tinyint(1) DEFAULT '0',
  `sale_protection` text,
  `goods_type` int(2) DEFAULT '0',
  `virtual_extend` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_goods
-- ----------------------------
INSERT INTO `ly_goods` VALUES ('6', '【原封正品 移动4G公开版特价】Apple/苹果 iPhone 5S 苹果5S手机', null, '2', 'AG0012320', 'AG0012320_1', '1', '2', '件', '<p>\r\n	</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<div>\r\n	<p>\r\n		首款 iPhone 的问世，向人们展示了 \"触摸\" 这一人与智能手机极为自然的交互方式。欣赏音乐、浏览网页、拍摄照片，都在指尖轻触间即可完成。这一切皆源自极为简单的一点，那就是你的手指。今天，我们更顺其自然，将 Touch ID 指纹识别传感器带到你的指尖。你的指纹就是完美的密码，与你形影不离，而且根本没有人能够猜出它的样子。除此之外，我们认为你的手机应该认识你，记住你，而无需你记忆并输入密码才能使用它。我们还认为，那个你与 iPhone 自然而然频频接触的地方，就是放置传感器的绝佳位置：主屏幕按钮。但问题是，该如何在如此狭小的空间内集成传感器所需的全套技术元件呢？\r\n	</p>\r\n</div>\r\n<div>\r\n	<p>\r\n		这需要生物特征识别专家和硬件工程师来重新思考传感器技术的工作方式，并重新设计 iPhone 标志性的主屏幕按钮。按钮表面由激光切割的蓝宝石水晶制成，可将指纹图像传至电容式触摸传感器，该传感器会读取你的表层皮肤以获得清晰详尽的指纹。按钮周围是不锈钢环，用于监测你的手指，激活传感器和改善信噪比。随后，软件将读取你的指纹脊线，并查找匹配的指纹来为你解锁手机。于是在你的轻触之间，一整套高度先进的技术臻于无形。你甚至可能察觉不到它们的存在，但你一定会发现：解锁 iPhone 的方式一瞬间变得多么轻而易举。\r\n	</p>\r\n</div>\r\n<p>\r\n	</p>', 'data/uploads/2017/04/29/870c43499b99862429287c2d4119fef6.jpg', 'a:3:{i:0;s:60:\"data/uploads/2017/04/29/870c43499b99862429287c2d4119fef6.jpg\";i:1;s:60:\"data/uploads/2014/04/29/519ecfe92a47cf2b98d6504dd875c211.png\";i:2;s:60:\"data/uploads/2014/04/29/7a18d229142972a45f19d34dd1bbc3bb.jpg\";}', 'iphone', '4898.00', '5000.00', '4700.00', '2014-05-04 20:46:15', '36', '2', '', '', '', '300', '20', '0', '0', '1', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:1:{i:3;a:5:{s:2:\"id\";s:1:\"3\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:18:\"苹果（IOS）16G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:3:{i:5;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:7;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:8;a:5:{s:2:\"id\";s:1:\"8\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"金色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', 'a:1:{i:1073741824;s:1:\"3\";}', '2', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('7', '小米手机6国内性价比最强机', null, '2', 'X20140120567', 'X20140120567_1', '1', '3', '件', '', 'data/uploads/2017/04/29/bee3fc7f0746b54f51fc5f1a2e7a38e3.jpg', 'a:2:{i:0;s:60:\"data/uploads/2017/04/29/bee3fc7f0746b54f51fc5f1a2e7a38e3.jpg\";i:1;s:60:\"data/uploads/2014/04/29/ef93ee15ca9544b261513dd76bb56fae.jpg\";}', '', '1799.00', '1999.00', '1799.00', '2014-05-04 20:46:15', '36', '2', '', '', '', '300', '0', '0', '0', '1', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:1:{i:1;a:5:{s:2:\"id\";s:1:\"1\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:19:\"安卓（Android）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:3:{i:5;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:6;a:5:{s:2:\"id\";s:1:\"6\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黑色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:11;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', 'a:1:{i:1073741824;s:1:\"2\";}', '2', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('9', 'MacBook Air', null, '3', 'M20140102654', 'M20140102654_1', '2', '2', '件', '', 'data/uploads/2017/04/29/6b33dafad4bb8752240cf2d3ab066be8.jpg', 'a:2:{i:0;s:60:\"data/uploads/2017/04/29/6b33dafad4bb8752240cf2d3ab066be8.jpg\";i:1;s:60:\"data/uploads/2014/04/29/4e7afbf5508fb11769950c397b67c03b.png\";}', '', '6288.00', '6388.00', '6200.00', '2014-05-04 20:46:15', '24', '2', '', '', '', '1080', '0', '0', '0', '1', 'a:1:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:2:{i:5;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:7;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', 'a:4:{i:1073741825;s:1:\"9\";i:1073741826;s:2:\"14\";i:1073741827;s:2:\"18\";i:1073741828;s:2:\"23\";}', '2', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('8', 'Samsung GALAXY S5 4G 联通定制版 G9006V', null, '2', 'SX201401023465', 'SX201401023465_1', '1', '1', '件', '', 'data/uploads/2017/04/29/d6e93371fdcfae0890fe519fdeb50129.jpg', 'a:1:{i:0;s:60:\"data/uploads/2017/04/29/d6e93371fdcfae0890fe519fdeb50129.jpg\";}', '', '5299.00', '5399.00', '5200.00', '2014-05-04 20:46:15', '24', '2', '', '', '', '300', '0', '0', '0', '1', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:1:{i:1;a:5:{s:2:\"id\";s:1:\"1\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:19:\"安卓（Android）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:2:{i:5;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:6;a:5:{s:2:\"id\";s:1:\"6\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黑色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', 'a:1:{i:1073741824;s:1:\"2\";}', '2', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('10', '联想 ThinkPad X1 Carbon X1 Carbon 3443-1N1 i7 4G 笔记本', null, '3', 'L20140203432', 'L20140203432', '2', '4', '件', '', 'data/uploads/2017/04/29/8f551833e1ab9568186641fe4b5b0101.jpg', 'a:1:{i:0;s:60:\"data/uploads/2017/04/29/8f551833e1ab9568186641fe4b5b0101.jpg\";}', '', '16699.00', '16799.00', '16000.00', '2014-05-04 20:46:15', '23', '3', '', '', '', '3405', '0', '0', '0', '1', 'a:0:{}', 'a:4:{i:1073741825;s:2:\"10\";i:1073741826;s:2:\"14\";i:1073741827;s:2:\"19\";i:1073741828;s:2:\"23\";}', '2', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('11', 'Apple/苹果 配备 Retina 显示屏的 MacBook Pro ME865CH/A笔电脑 1', null, '3', 'AP20140101787', 'AP20140101787_1', '2', '2', '件', '', 'data/uploads/2017/04/30/b8f4125b967911e08f7115f8d2b3f684.jpg', 'a:2:{i:0;s:60:\"data/uploads/2017/04/30/b8f4125b967911e08f7115f8d2b3f684.jpg\";i:1;s:60:\"data/uploads/2014/04/30/eab91d30be1f31560db64cc14c277d32.jpg\";}', '', '9288.00', '9298.00', '9200.00', '2014-05-04 20:46:15', '24', '2', '', '', '', '1570', '0', '0', '0', '1', 'a:1:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:2:{i:5;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:7;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', 'a:4:{i:1073741825;s:1:\"9\";i:1073741826;s:2:\"14\";i:1073741827;s:2:\"18\";i:1073741828;s:2:\"23\";}', '2', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('12', 'Apple/苹果 iPhone7 苹果7 正品行货', null, '2', 'AP20140101788', 'AP20140101788_1', '1', '2', '件', '', 'data/uploads/2017/04/30/62527b26f1afbe204f247b72d1f20c2d.jpg', 'a:2:{i:0;s:60:\"data/uploads/2017/04/30/62527b26f1afbe204f247b72d1f20c2d.jpg\";i:1;s:60:\"data/uploads/2014/04/30/bfe7319f2b2387bcd20dca7e92b83325.jpg\";}', '', '3367.00', '3899.00', '3367.00', '2014-05-04 20:46:15', '72', '2', '', '', '', '300', '0', '0', '0', '1', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:1:{i:3;a:5:{s:2:\"id\";s:1:\"3\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:18:\"苹果（IOS）16G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:6:{i:5;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:10;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:11;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:12;a:5:{s:2:\"id\";s:2:\"12\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"粉色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:13;a:5:{s:2:\"id\";s:2:\"13\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黄色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:14;a:5:{s:2:\"id\";s:2:\"14\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"绿色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', 'a:1:{i:1073741824;s:1:\"3\";}', '2', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('13', ' Apple/苹果 iPhone 7s 64G 苹果4S手机', null, '2', 'AP20140101786', 'AP20140101786_1', '1', '2', '件', '', 'data/uploads/2017/04/30/f31a00b4e0f6617378095a8c1bfb00c9.jpg', 'a:2:{i:0;s:60:\"data/uploads/2017/04/30/f31a00b4e0f6617378095a8c1bfb00c9.jpg\";i:1;s:60:\"data/uploads/2014/04/30/f16151cf9685b0e3653e8287bfed2b0d.jpg\";}', '', '2479.00', '3488.00', '2479.00', '2014-05-04 20:46:15', '24', '2', '', '', '', '400', '0', '0', '0', '1', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:1:{i:3;a:5:{s:2:\"id\";s:1:\"3\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:17:\"苹果（IOS）8G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:2:{i:5;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:6;a:5:{s:2:\"id\";s:1:\"6\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黑色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', 'a:1:{i:1073741824;s:1:\"3\";}', '2', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('14', '小米手机5S', null, '2', 'X20140120566', 'X20140120566_1', '1', '3', '件', '', 'data/uploads/2017/04/30/f3ccdd27d2000e3f9255a7e3e2c48800.jpg', 'a:2:{i:0;s:60:\"data/uploads/2017/04/30/f3ccdd27d2000e3f9255a7e3e2c48800.jpg\";i:1;s:60:\"data/uploads/2014/04/30/fe5df232cafa4c4e0f1a0294418e5660.jpg\";}', '', '1299.00', '1499.00', '1299.00', '2014-05-04 20:46:15', '60', '2', '', '', '', '400', '0', '0', '0', '1', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:1:{i:1;a:5:{s:2:\"id\";s:1:\"1\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:19:\"安卓（Android）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:5:{i:5;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:10;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:11;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:14;a:5:{s:2:\"id\";s:2:\"14\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"绿色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:16;a:5:{s:2:\"id\";s:2:\"16\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"紫色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', 'a:1:{i:1073741824;s:1:\"3\";}', '2', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('15', 'Apple/苹果 ipad air  WIFI iPad Air平板黑预售白现货', null, '4', 'AP20140101785', 'AP20140101785_1', '3', '2', '件', '', 'data/uploads/2017/04/30/95fc43a276b4706c1eb6be35a460dcc9.jpg', 'a:2:{i:0;s:60:\"data/uploads/2017/04/30/95fc43a276b4706c1eb6be35a460dcc9.jpg\";i:1;s:60:\"data/uploads/2014/04/30/b6d8ff9b2b918ddde6585cba4c82bf72.jpg\";}', '', '3399.00', '4900.00', '3999.00', '2014-05-04 20:46:15', '48', '2', '', '', '', '700', '50', '0', '0', '1', 'a:4:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:2:{i:5;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:7;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:3;a:6:{s:2:\"id\";s:1:\"3\";s:4:\"name\";s:6:\"硬盘\";s:5:\"value\";a:2:{i:20;a:5:{s:2:\"id\";s:2:\"20\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:3:\"16G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:21;a:5:{s:2:\"id\";s:2:\"21\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:3:\"32G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"平板\";s:6:\"is_del\";s:1:\"0\";}i:4;a:6:{s:2:\"id\";s:1:\"4\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:1:{i:27;a:5:{s:2:\"id\";s:2:\"27\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:9:\"ios系统\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"常用\";s:6:\"is_del\";s:1:\"0\";}i:5;a:6:{s:2:\"id\";s:1:\"5\";s:4:\"name\";s:6:\"尺寸\";s:5:\"value\";a:1:{i:37;a:5:{s:2:\"id\";s:2:\"37\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:9:\"9.7英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"平台\";s:6:\"is_del\";s:1:\"0\";}}', 'a:0:{}', '2', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('16', 'BRIOSO格子衬衫 女 长袖2017春装新款女装修身韩版大码百搭衬衣潮', '', '7', 'NS20140504123', 'NS20140504123_1', '4', '0', '件', '', 'data/uploads/2017/05/04/6a63f7365e4430b5d07791fd32c66500.jpg', 'a:1:{i:0;s:60:\"data/uploads/2017/05/04/6a63f7365e4430b5d07791fd32c66500.jpg\";}', '', '49.00', '199.00', '40.00', '2014-05-04 20:46:15', '191', '2', '', '', '', '200', '0', '0', '0', '1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:10;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:12;a:5:{s:2:\"id\";s:2:\"12\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"粉色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:14;a:5:{s:2:\"id\";s:2:\"14\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"绿色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:16;a:5:{s:2:\"id\";s:2:\"16\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"紫色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:43;a:5:{s:2:\"id\";s:2:\"43\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"S\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:46;a:5:{s:2:\"id\";s:2:\"46\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:2:\"XL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:47;a:5:{s:2:\"id\";s:2:\"47\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:3:\"XXL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:48;a:5:{s:2:\"id\";s:2:\"48\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:4:\"XXXL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', 'a:2:{i:1073741829;s:2:\"25\";i:1073741830;s:2:\"32\";}', '1', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('17', '白衬衫女短袖2017新款夏装女衬衣大码工作服工装韩版女士衬衫职业', '', '7', 'NS20140504121', 'NS20140504121_1', '4', '0', '件', '', 'data/uploads/2017/05/04/f81d28ad7c32504c0af3a8c44eec681e.jpg', 'a:2:{i:0;s:60:\"data/uploads/2017/05/04/f81d28ad7c32504c0af3a8c44eec681e.jpg\";i:1;s:60:\"data/uploads/2014/05/04/ef5a1ccdd16137f07139fe972f8be244.jpg\";}', '', '55.00', '110.00', '50.00', '2014-05-04 20:46:15', '218', '2', '', '', '', '200', '0', '0', '0', '1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:2:{i:5;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:7;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:5:{i:43;a:5:{s:2:\"id\";s:2:\"43\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"S\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:45;a:5:{s:2:\"id\";s:2:\"45\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"L\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:46;a:5:{s:2:\"id\";s:2:\"46\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:2:\"XL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:47;a:5:{s:2:\"id\";s:2:\"47\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:3:\"XXL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:48;a:5:{s:2:\"id\";s:2:\"48\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:4:\"XXXL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', 'a:2:{i:1073741829;s:2:\"26\";i:1073741830;s:2:\"32\";}', '1', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('18', '春夏装新款2017长袖白衬衫女短袖雪纺韩版大码女装打底衫职业衬衣', '', '7', 'NS20140504122', 'NS20140504122_1', '4', '0', '件', '', 'data/uploads/2017/05/04/fb84a52b8da8869e478a236ed10172b8.jpg', 'a:2:{i:0;s:60:\"data/uploads/2017/05/04/fb84a52b8da8869e478a236ed10172b8.jpg\";i:1;s:60:\"data/uploads/2014/05/04/fc518b7ed40e2e80188331149c9a8d5e.jpg\";}', '', '79.00', '238.00', '70.00', '2014-05-04 20:46:15', '616', '2', '', '', '', '200', '0', '0', '0', '1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:5;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:6;a:5:{s:2:\"id\";s:1:\"6\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黑色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:7;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:10;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:7:{i:42;a:5:{s:2:\"id\";s:2:\"42\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:2:\"XS\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:43;a:5:{s:2:\"id\";s:2:\"43\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"S\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:44;a:5:{s:2:\"id\";s:2:\"44\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"M\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:45;a:5:{s:2:\"id\";s:2:\"45\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"L\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:46;a:5:{s:2:\"id\";s:2:\"46\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:2:\"XL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:47;a:5:{s:2:\"id\";s:2:\"47\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:3:\"XXL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:48;a:5:{s:2:\"id\";s:2:\"48\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:4:\"XXXL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', 'a:2:{i:1073741829;s:2:\"27\";i:1073741830;s:2:\"32\";}', '1', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('19', '夏天职业衬衫女装正装短袖衬衫工装女寸衫韩版白领工作服白衬衣女', null, '7', 'NS20140504120', 'NS20140504120_1', '4', '0', '件', '', 'data/uploads/2017/05/04/da175403c79047247a25e76ec8c4913a.jpg', 'a:2:{i:0;s:60:\"data/uploads/2017/05/04/da175403c79047247a25e76ec8c4913a.jpg\";i:1;s:60:\"data/uploads/2014/05/04/364ed7cdfd1e19f1d2aed3aefa46145d.jpg\";}', '', '49.00', '108.00', '40.00', '2014-05-04 20:46:15', '264', '2', '', '', '', '200', '0', '0', '0', '1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:2:{i:5;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:11;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:6:{i:42;a:5:{s:2:\"id\";s:2:\"42\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:2:\"XS\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:43;a:5:{s:2:\"id\";s:2:\"43\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"S\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:44;a:5:{s:2:\"id\";s:2:\"44\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"M\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:45;a:5:{s:2:\"id\";s:2:\"45\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"L\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:46;a:5:{s:2:\"id\";s:2:\"46\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:2:\"XL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:47;a:5:{s:2:\"id\";s:2:\"47\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:3:\"XXL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', 'a:2:{i:1073741829;s:2:\"25\";i:1073741830;s:2:\"32\";}', '1', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('20', '职业女装纯棉内搭白色寸衫水钻领子带钻翻领衬衫搭配小西装打底衫', null, '7', 'NS20140504124', 'NS20140504124_1', '4', '0', '件', '', 'data/uploads/2017/05/04/b1dcd910f2d270c11d91668ecfbf7302.jpg', 'a:1:{i:0;s:60:\"data/uploads/2017/05/04/b1dcd910f2d270c11d91668ecfbf7302.jpg\";}', '', '45.00', '68.00', '40.00', '2014-05-04 20:46:15', '88', '2', '', '', '', '200', '0', '0', '0', '1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:1:{i:5;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:43;a:5:{s:2:\"id\";s:2:\"43\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"S\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:44;a:5:{s:2:\"id\";s:2:\"44\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"M\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:45;a:5:{s:2:\"id\";s:2:\"45\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"L\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:47;a:5:{s:2:\"id\";s:2:\"47\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:3:\"XXL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', 'a:2:{i:1073741829;s:2:\"27\";i:1073741830;s:2:\"32\";}', '1', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('21', '时尚潮流 牛仔衬衫 男 长袖韩版时尚复古磨白衬衫男春夏外套包邮', null, '9', 'MS20140504120', 'MS20140504120_1', '5', '0', '件', '', 'data/uploads/2017/05/04/19579466f48282ec37548040b0c69bb3.jpg', 'a:1:{i:0;s:60:\"data/uploads/2017/05/04/19579466f48282ec37548040b0c69bb3.jpg\";}', '', '58.00', '199.00', '50.00', '2014-05-04 20:46:15', '110', '2', '', '', '', '200', '0', '0', '0', '1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:1:{i:11;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:5:{i:59;a:5:{s:2:\"id\";s:2:\"59\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"38\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:60;a:5:{s:2:\"id\";s:2:\"60\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"39\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:61;a:5:{s:2:\"id\";s:2:\"61\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"40\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:62;a:5:{s:2:\"id\";s:2:\"62\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"41\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:63;a:5:{s:2:\"id\";s:2:\"63\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"42\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', 'a:2:{i:1073741831;s:2:\"43\";i:1073741832;s:2:\"51\";}', '1', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('22', '2017夏装长袖男士格子衬衣拼接波点修身休闲衬衫衫青春百搭潮热卖', '', '9', 'MS20140504121', 'MS20140504121_1', '5', '0', '件', '', 'data/uploads/2017/05/04/a56ab48abdf9aefdef5fd16abb44d02c.jpg', 'a:1:{i:0;s:60:\"data/uploads/2017/05/04/a56ab48abdf9aefdef5fd16abb44d02c.jpg\";}', '', '78.00', '278.00', '70.00', '2014-05-04 20:46:15', '264', '2', '', '', '', '200', '0', '0', '0', '1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:2:{i:10;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:11;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:6:{i:60;a:5:{s:2:\"id\";s:2:\"60\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"39\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:61;a:5:{s:2:\"id\";s:2:\"61\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"40\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:62;a:5:{s:2:\"id\";s:2:\"62\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"41\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:63;a:5:{s:2:\"id\";s:2:\"63\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"42\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}i:64;a:5:{s:2:\"id\";s:2:\"64\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"43\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"13\";}i:65;a:5:{s:2:\"id\";s:2:\"65\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"44\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"14\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', 'a:2:{i:1073741831;s:2:\"42\";i:1073741832;s:2:\"51\";}', '1', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('23', '2017春装新款长袖衬衫男 韩版修身灯芯绒波点衬衫男士衬衫上衣潮', '', '9', 'MS20140504122', 'MS20140504122_1', '5', '0', '件', '', 'data/uploads/2017/05/04/16615175a6eff3846c20d4e68100ed70.jpg', 'a:1:{i:0;s:60:\"data/uploads/2017/05/04/16615175a6eff3846c20d4e68100ed70.jpg\";}', '', '65.00', '198.00', '60.00', '2014-05-04 20:46:15', '66', '2', '', '', '', '200', '0', '0', '0', '1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:1:{i:10;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:3:{i:52;a:5:{s:2:\"id\";s:2:\"52\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:7:\"170/92A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:53;a:5:{s:2:\"id\";s:2:\"53\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:7:\"175/96A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:54;a:5:{s:2:\"id\";s:2:\"54\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:8:\"180/100A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', 'a:2:{i:1073741831;s:2:\"42\";i:1073741832;s:2:\"51\";}', '1', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('24', '2017春装男款格子长袖男衬衫 休闲衬衣潮', '', '9', 'MS20140504123', 'MS20140504123_1', '5', '0', '件', '', 'data/uploads/2017/05/04/9bd757b51fc75afd17475b667a042599.jpg', 'a:1:{i:0;s:60:\"data/uploads/2017/05/04/9bd757b51fc75afd17475b667a042599.jpg\";}', '', '35.00', '75.00', '30.00', '2014-05-04 20:46:15', '220', '2', '', '', '', '200', '0', '0', '0', '1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:2:{i:10;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:11;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:5:{i:61;a:5:{s:2:\"id\";s:2:\"61\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"40\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:62;a:5:{s:2:\"id\";s:2:\"62\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"41\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:63;a:5:{s:2:\"id\";s:2:\"63\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"42\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}i:64;a:5:{s:2:\"id\";s:2:\"64\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"43\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"13\";}i:65;a:5:{s:2:\"id\";s:2:\"65\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"44\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"14\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', 'a:2:{i:1073741831;s:2:\"42\";i:1073741832;s:2:\"51\";}', '1', '0', '', '0', null);
INSERT INTO `ly_goods` VALUES ('25', '复古风唐装男士长袖衬衫 韩版修身灯芯绒盘扣莲花秀男式休闲衬衣', null, '9', 'MS20140504124', 'MS20140504124_1', '5', '0', '件', '', 'data/uploads/2017/05/04/451b95af03616fd150e78fdc84a22378.jpg', 'a:1:{i:0;s:60:\"data/uploads/2017/05/04/451b95af03616fd150e78fdc84a22378.jpg\";}', '', '76.00', '126.00', '70.00', '2014-05-04 20:46:15', '96', '2', '', '', '', '200', '0', '0', '0', '1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:2:{i:10;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:11;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:58;a:5:{s:2:\"id\";s:2:\"58\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"37\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:59;a:5:{s:2:\"id\";s:2:\"59\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"38\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:60;a:5:{s:2:\"id\";s:2:\"60\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"39\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:61;a:5:{s:2:\"id\";s:2:\"61\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"40\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', 'a:2:{i:1073741831;s:2:\"42\";i:1073741832;s:2:\"51\";}', '1', '0', '', '0', null);

-- ----------------------------
-- Table structure for `ly_goods_attr`
-- ----------------------------
DROP TABLE IF EXISTS `ly_goods_attr`;
CREATE TABLE `ly_goods_attr` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `show_type` int(11) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1073741833 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_goods_attr
-- ----------------------------
INSERT INTO `ly_goods_attr` VALUES ('1073741824', '1', '屏幕尺寸', '1', '0');
INSERT INTO `ly_goods_attr` VALUES ('1073741825', '2', '尺寸', '1', '0');
INSERT INTO `ly_goods_attr` VALUES ('1073741826', '2', '触控', '1', '1');
INSERT INTO `ly_goods_attr` VALUES ('1073741827', '2', ' 处理器', '1', '2');
INSERT INTO `ly_goods_attr` VALUES ('1073741828', '2', '显卡', '1', '3');
INSERT INTO `ly_goods_attr` VALUES ('1073741829', '4', '袖长', '1', '0');
INSERT INTO `ly_goods_attr` VALUES ('1073741830', '4', '面料', '1', '1');
INSERT INTO `ly_goods_attr` VALUES ('1073741831', '5', '袖长', '1', '0');
INSERT INTO `ly_goods_attr` VALUES ('1073741832', '5', '领子', '1', '1');

-- ----------------------------
-- Table structure for `ly_goods_category`
-- ----------------------------
DROP TABLE IF EXISTS `ly_goods_category`;
CREATE TABLE `ly_goods_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `alias` varchar(200) NOT NULL DEFAULT '',
  `parent_id` bigint(20) DEFAULT '0',
  `type_id` bigint(20) DEFAULT NULL,
  `count` bigint(20) DEFAULT '0',
  `path` text,
  `img` varchar(255) DEFAULT NULL,
  `imgs` text,
  `sort` int(11) DEFAULT NULL,
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_keywords` varchar(255) DEFAULT NULL,
  `seo_description` varchar(255) DEFAULT NULL,
  `nav_show` int(1) DEFAULT '1',
  `list_show` int(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `alias` (`alias`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_goods_category
-- ----------------------------
INSERT INTO `ly_goods_category` VALUES ('1', '电脑、手机', 'pc_phone', '0', '0', '0', ',1,', 'data/uploads/2014/05/13/761d03b10a807e017101ba984da121cb.jpg', 'a:1:{i:0;a:2:{s:3:\"img\";s:60:\"data/uploads/2014/05/13/761d03b10a807e017101ba984da121cb.jpg\";s:4:\"link\";s:0:\"\";}}', '2', '电脑、手机、笔记本', '电脑、手机', '电脑、笔记本、手机最新动态', '1', '1');
INSERT INTO `ly_goods_category` VALUES ('3', '笔记本', 'computer', '1', '2', '0', ',1,3,', null, null, '2', '', '', '', '1', '1');
INSERT INTO `ly_goods_category` VALUES ('2', '手机', 'phone', '1', '1', '0', ',1,2,', null, null, '2', '', '', '', '1', '1');
INSERT INTO `ly_goods_category` VALUES ('4', '平板', 'tache', '1', '3', '0', ',1,4,', null, null, '1', '', '', '', '1', '1');
INSERT INTO `ly_goods_category` VALUES ('5', '服饰', 'apparel', '0', '0', '0', ',5,', 'data/uploads/2014/05/13/9359c86ef905712427d3435d230990f2.jpg', 'a:1:{i:0;a:2:{s:3:\"img\";s:60:\"data/uploads/2014/05/13/9359c86ef905712427d3435d230990f2.jpg\";s:4:\"link\";s:0:\"\";}}', '3', '', '', '', '1', '1');
INSERT INTO `ly_goods_category` VALUES ('6', '女装', 'women', '5', '0', '0', ',5,6,', null, null, '1', '', '', '', '1', '1');
INSERT INTO `ly_goods_category` VALUES ('7', '衬衫', 'shrit', '6', '4', '0', ',5,6,7,', null, null, '1', '', '', '', '1', '1');
INSERT INTO `ly_goods_category` VALUES ('8', '男式', 'men', '5', '0', '0', ',5,8,', null, null, '1', '男式服装', '男式', '让服装显示男儿本色', '1', '1');
INSERT INTO `ly_goods_category` VALUES ('9', '衬衫', 'men_shrit', '8', '5', '0', ',5,8,9,', null, null, '1', '男式衬衫', '男式衬衫，男式风采', '男式衬衫，穿出男人的风度', '1', '1');

-- ----------------------------
-- Table structure for `ly_goods_spec`
-- ----------------------------
DROP TABLE IF EXISTS `ly_goods_spec`;
CREATE TABLE `ly_goods_spec` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `value` text NOT NULL,
  `type` tinyint(1) DEFAULT '1',
  `note` varchar(255) DEFAULT NULL,
  `is_del` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_goods_spec
-- ----------------------------
INSERT INTO `ly_goods_spec` VALUES ('1', '系统', 'a:4:{i:0;a:5:{s:2:\"id\";s:1:\"4\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:1;a:5:{s:2:\"id\";s:1:\"1\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:19:\"安卓（Android）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:2;a:5:{s:2:\"id\";s:1:\"2\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:19:\"微软（Windows）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:3;a:5:{s:2:\"id\";s:1:\"3\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:15:\"苹果（IOS）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}', '1', '手机', '0');
INSERT INTO `ly_goods_spec` VALUES ('2', '颜色', 'a:13:{i:0;a:5:{s:2:\"id\";s:2:\"17\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}i:1;a:5:{s:2:\"id\";s:2:\"15\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"橙色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:2;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:3;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:4;a:5:{s:2:\"id\";s:2:\"12\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"粉色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:5;a:5:{s:2:\"id\";s:2:\"16\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"紫色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:6;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:7;a:5:{s:2:\"id\";s:2:\"14\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"绿色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:8;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:9;a:5:{s:2:\"id\";s:1:\"8\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"金色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:10;a:5:{s:2:\"id\";s:1:\"9\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"银色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:11;a:5:{s:2:\"id\";s:2:\"13\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黄色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:12;a:5:{s:2:\"id\";s:1:\"6\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黑色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}', '1', '基本颜色', '0');
INSERT INTO `ly_goods_spec` VALUES ('3', '硬盘', 'a:8:{i:0;a:5:{s:2:\"id\";s:2:\"23\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:4:\"128G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:1;a:5:{s:2:\"id\";s:2:\"20\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:3:\"16G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:2;a:5:{s:2:\"id\";s:2:\"24\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:4:\"256G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:3;a:5:{s:2:\"id\";s:2:\"21\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:3:\"32G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:4;a:5:{s:2:\"id\";s:2:\"18\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:2:\"4G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:5;a:5:{s:2:\"id\";s:2:\"25\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:4:\"512G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:6;a:5:{s:2:\"id\";s:2:\"22\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:3:\"64G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:7;a:5:{s:2:\"id\";s:2:\"19\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:2:\"8G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}', '1', '平板', '0');
INSERT INTO `ly_goods_spec` VALUES ('4', '系统', 'a:5:{i:0;a:5:{s:2:\"id\";s:2:\"26\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:7:\"Android\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:1;a:5:{s:2:\"id\";s:2:\"27\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:9:\"ios系统\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:2;a:5:{s:2:\"id\";s:2:\"29\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:5:\"Linux\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:3;a:5:{s:2:\"id\";s:2:\"30\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:4:\"Unix\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:4;a:5:{s:2:\"id\";s:2:\"28\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:7:\"windows\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}', '1', '常用', '0');
INSERT INTO `ly_goods_spec` VALUES ('5', '尺寸', 'a:11:{i:0;a:5:{s:2:\"id\";s:2:\"38\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:10:\"10.1英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:1;a:5:{s:2:\"id\";s:2:\"39\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:10:\"11.6英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:2;a:5:{s:2:\"id\";s:2:\"40\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:10:\"12.1英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:3;a:5:{s:2:\"id\";s:2:\"41\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:17:\"13英寸及以上\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:4;a:5:{s:2:\"id\";s:2:\"31\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:16:\"6英寸及以下\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:5;a:5:{s:2:\"id\";s:2:\"33\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:10:\"7.85英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:6;a:5:{s:2:\"id\";s:2:\"34\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:9:\"7.9英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:7;a:5:{s:2:\"id\";s:2:\"32\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:7:\"7英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:8;a:5:{s:2:\"id\";s:2:\"36\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:9:\"8.3英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:9;a:5:{s:2:\"id\";s:2:\"35\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:7:\"8英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:10;a:5:{s:2:\"id\";s:2:\"37\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:9:\"9.7英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}}', '1', '平台', '0');
INSERT INTO `ly_goods_spec` VALUES ('6', '尺码', 'a:9:{i:0;a:5:{s:2:\"id\";s:2:\"45\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"L\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:1;a:5:{s:2:\"id\";s:2:\"44\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"M\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:2;a:5:{s:2:\"id\";s:2:\"43\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"S\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:3;a:5:{s:2:\"id\";s:2:\"46\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:2:\"XL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:4;a:5:{s:2:\"id\";s:2:\"42\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:2:\"XS\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:5;a:5:{s:2:\"id\";s:2:\"47\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:3:\"XXL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:6;a:5:{s:2:\"id\";s:2:\"48\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:4:\"XXXL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:7;a:5:{s:2:\"id\";s:2:\"50\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:8;a:5:{s:2:\"id\";s:2:\"49\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:6:\"均码\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}}', '1', '女式', '0');
INSERT INTO `ly_goods_spec` VALUES ('7', '尺码', 'a:18:{i:0;a:5:{s:2:\"id\";s:2:\"51\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:7:\"165/88A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:1;a:5:{s:2:\"id\";s:2:\"52\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:7:\"170/92A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:2;a:5:{s:2:\"id\";s:2:\"53\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:7:\"175/96A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:3;a:5:{s:2:\"id\";s:2:\"54\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:8:\"180/100A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:4;a:5:{s:2:\"id\";s:2:\"55\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:8:\"185/104A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:5;a:5:{s:2:\"id\";s:2:\"56\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:7:\"190/104\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:6;a:5:{s:2:\"id\";s:2:\"57\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"36\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:7;a:5:{s:2:\"id\";s:2:\"58\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"37\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:8;a:5:{s:2:\"id\";s:2:\"59\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"38\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:9;a:5:{s:2:\"id\";s:2:\"60\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"39\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:10;a:5:{s:2:\"id\";s:2:\"61\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"40\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:11;a:5:{s:2:\"id\";s:2:\"62\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"41\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:12;a:5:{s:2:\"id\";s:2:\"63\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"42\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}i:13;a:5:{s:2:\"id\";s:2:\"64\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"43\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"13\";}i:14;a:5:{s:2:\"id\";s:2:\"65\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"44\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"14\";}i:15;a:5:{s:2:\"id\";s:2:\"66\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"45\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"15\";}i:16;a:5:{s:2:\"id\";s:2:\"67\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"46\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"16\";}i:17;a:5:{s:2:\"id\";s:2:\"68\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"47\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"17\";}}', '1', '男式', '0');

-- ----------------------------
-- Table structure for `ly_goods_type`
-- ----------------------------
DROP TABLE IF EXISTS `ly_goods_type`;
CREATE TABLE `ly_goods_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `attr` text,
  `spec` text,
  `brand` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_goods_type
-- ----------------------------
INSERT INTO `ly_goods_type` VALUES ('1', '手机产品', 'a:1:{i:0;a:6:{s:2:\"id\";s:10:\"1073741824\";s:7:\"type_id\";s:1:\"1\";s:4:\"name\";s:12:\"屏幕尺寸\";s:9:\"show_type\";s:1:\"1\";s:4:\"sort\";s:1:\"0\";s:6:\"values\";a:5:{i:0;a:4:{s:2:\"id\";s:1:\"1\";s:7:\"attr_id\";s:10:\"1073741824\";s:4:\"name\";s:18:\"5.6英寸及以上\";s:4:\"sort\";s:1:\"0\";}i:1;a:4:{s:2:\"id\";s:1:\"2\";s:7:\"attr_id\";s:10:\"1073741824\";s:4:\"name\";s:13:\"5.5-5.0英寸\";s:4:\"sort\";s:1:\"1\";}i:2;a:4:{s:2:\"id\";s:1:\"3\";s:7:\"attr_id\";s:10:\"1073741824\";s:4:\"name\";s:13:\"4.9-4.1英寸\";s:4:\"sort\";s:1:\"2\";}i:3;a:4:{s:2:\"id\";s:1:\"4\";s:7:\"attr_id\";s:10:\"1073741824\";s:4:\"name\";s:13:\"4.0-3.1英寸\";s:4:\"sort\";s:1:\"3\";}i:4;a:4:{s:2:\"id\";s:1:\"5\";s:7:\"attr_id\";s:10:\"1073741824\";s:4:\"name\";s:18:\"3.0英寸及以下\";s:4:\"sort\";s:1:\"4\";}}}}', 'a:2:{i:0;a:8:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";s:485:\"a:4:{i:0;a:5:{s:2:\"id\";s:1:\"4\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:1;a:5:{s:2:\"id\";s:1:\"1\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:19:\"安卓（Android）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:2;a:5:{s:2:\"id\";s:1:\"2\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:24:\"微软（WindowsPhone）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:3;a:5:{s:2:\"id\";s:1:\"3\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:15:\"苹果（IOS）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}\";s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";s:4:\"spec\";a:4:{i:0;a:5:{s:2:\"id\";s:1:\"4\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:1;a:5:{s:2:\"id\";s:1:\"1\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:19:\"安卓（Android）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:2;a:5:{s:2:\"id\";s:1:\"2\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:24:\"微软（WindowsPhone）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:3;a:5:{s:2:\"id\";s:1:\"3\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:15:\"苹果（IOS）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}s:9:\"show_type\";s:1:\"1\";}i:1;a:8:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";s:1438:\"a:13:{i:0;a:5:{s:2:\"id\";s:2:\"17\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}i:1;a:5:{s:2:\"id\";s:2:\"15\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"橙色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:2;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:3;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:4;a:5:{s:2:\"id\";s:2:\"12\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"粉色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:5;a:5:{s:2:\"id\";s:2:\"16\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"紫色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:6;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:7;a:5:{s:2:\"id\";s:2:\"14\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"绿色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:8;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:9;a:5:{s:2:\"id\";s:1:\"8\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"金色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:10;a:5:{s:2:\"id\";s:1:\"9\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"银色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:11;a:5:{s:2:\"id\";s:2:\"13\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黄色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:12;a:5:{s:2:\"id\";s:1:\"6\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黑色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}\";s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";s:4:\"spec\";a:13:{i:0;a:5:{s:2:\"id\";s:2:\"17\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}i:1;a:5:{s:2:\"id\";s:2:\"15\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"橙色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:2;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:3;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:4;a:5:{s:2:\"id\";s:2:\"12\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"粉色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:5;a:5:{s:2:\"id\";s:2:\"16\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"紫色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:6;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:7;a:5:{s:2:\"id\";s:2:\"14\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"绿色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:8;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:9;a:5:{s:2:\"id\";s:1:\"8\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"金色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:10;a:5:{s:2:\"id\";s:1:\"9\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"银色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:11;a:5:{s:2:\"id\";s:2:\"13\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黄色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:12;a:5:{s:2:\"id\";s:1:\"6\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黑色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}s:9:\"show_type\";s:1:\"1\";}}', '1,2,3');
INSERT INTO `ly_goods_type` VALUES ('2', '笔记本产品', 'a:4:{i:0;a:6:{s:2:\"id\";s:10:\"1073741825\";s:7:\"type_id\";s:1:\"2\";s:4:\"name\";s:6:\"尺寸\";s:9:\"show_type\";s:1:\"1\";s:4:\"sort\";s:1:\"0\";s:6:\"values\";a:8:{i:0;a:4:{s:2:\"id\";s:1:\"6\";s:7:\"attr_id\";s:10:\"1073741825\";s:4:\"name\";s:19:\"10.1英寸及以下\";s:4:\"sort\";s:1:\"0\";}i:1;a:4:{s:2:\"id\";s:1:\"7\";s:7:\"attr_id\";s:10:\"1073741825\";s:4:\"name\";s:8:\"11英寸\";s:4:\"sort\";s:1:\"1\";}i:2;a:4:{s:2:\"id\";s:1:\"8\";s:7:\"attr_id\";s:10:\"1073741825\";s:4:\"name\";s:8:\"12英寸\";s:4:\"sort\";s:1:\"2\";}i:3;a:4:{s:2:\"id\";s:1:\"9\";s:7:\"attr_id\";s:10:\"1073741825\";s:4:\"name\";s:8:\"13英寸\";s:4:\"sort\";s:1:\"3\";}i:4;a:4:{s:2:\"id\";s:2:\"10\";s:7:\"attr_id\";s:10:\"1073741825\";s:4:\"name\";s:8:\"14英寸\";s:4:\"sort\";s:1:\"4\";}i:5;a:4:{s:2:\"id\";s:2:\"11\";s:7:\"attr_id\";s:10:\"1073741825\";s:4:\"name\";s:8:\"15英寸\";s:4:\"sort\";s:1:\"5\";}i:6;a:4:{s:2:\"id\";s:2:\"12\";s:7:\"attr_id\";s:10:\"1073741825\";s:4:\"name\";s:17:\"16英寸-17英寸\";s:4:\"sort\";s:1:\"6\";}i:7;a:4:{s:2:\"id\";s:2:\"13\";s:7:\"attr_id\";s:10:\"1073741825\";s:4:\"name\";s:14:\"17英寸以上\";s:4:\"sort\";s:1:\"7\";}}}i:1;a:6:{s:2:\"id\";s:10:\"1073741826\";s:7:\"type_id\";s:1:\"2\";s:4:\"name\";s:6:\"触控\";s:9:\"show_type\";s:1:\"1\";s:4:\"sort\";s:1:\"1\";s:6:\"values\";a:3:{i:0;a:4:{s:2:\"id\";s:2:\"14\";s:7:\"attr_id\";s:10:\"1073741826\";s:4:\"name\";s:12:\"普通触控\";s:4:\"sort\";s:1:\"0\";}i:1;a:4:{s:2:\"id\";s:2:\"15\";s:7:\"attr_id\";s:10:\"1073741826\";s:4:\"name\";s:12:\"变形触控\";s:4:\"sort\";s:1:\"1\";}i:2;a:4:{s:2:\"id\";s:2:\"16\";s:7:\"attr_id\";s:10:\"1073741826\";s:4:\"name\";s:9:\"非触控\";s:4:\"sort\";s:1:\"2\";}}}i:2;a:6:{s:2:\"id\";s:10:\"1073741827\";s:7:\"type_id\";s:1:\"2\";s:4:\"name\";s:10:\" 处理器\";s:9:\"show_type\";s:1:\"1\";s:4:\"sort\";s:1:\"2\";s:6:\"values\";a:6:{i:0;a:4:{s:2:\"id\";s:2:\"17\";s:7:\"attr_id\";s:10:\"1073741827\";s:4:\"name\";s:7:\"i3Intel\";s:4:\"sort\";s:1:\"0\";}i:1;a:4:{s:2:\"id\";s:2:\"18\";s:7:\"attr_id\";s:10:\"1073741827\";s:4:\"name\";s:7:\"i5Intel\";s:4:\"sort\";s:1:\"1\";}i:2;a:4:{s:2:\"id\";s:2:\"19\";s:7:\"attr_id\";s:10:\"1073741827\";s:4:\"name\";s:7:\"i7Intel\";s:4:\"sort\";s:1:\"2\";}i:3;a:4:{s:2:\"id\";s:2:\"20\";s:7:\"attr_id\";s:10:\"1073741827\";s:4:\"name\";s:5:\"A6AMD\";s:4:\"sort\";s:1:\"3\";}i:4;a:4:{s:2:\"id\";s:2:\"21\";s:7:\"attr_id\";s:10:\"1073741827\";s:4:\"name\";s:5:\"A8AMD\";s:4:\"sort\";s:1:\"4\";}i:5;a:4:{s:2:\"id\";s:2:\"22\";s:7:\"attr_id\";s:10:\"1073741827\";s:4:\"name\";s:6:\"A10AMD\";s:4:\"sort\";s:1:\"5\";}}}i:3;a:6:{s:2:\"id\";s:10:\"1073741828\";s:7:\"type_id\";s:1:\"2\";s:4:\"name\";s:6:\"显卡\";s:9:\"show_type\";s:1:\"1\";s:4:\"sort\";s:1:\"3\";s:6:\"values\";a:2:{i:0;a:4:{s:2:\"id\";s:2:\"23\";s:7:\"attr_id\";s:10:\"1073741828\";s:4:\"name\";s:15:\"性能级独显\";s:4:\"sort\";s:1:\"0\";}i:1;a:4:{s:2:\"id\";s:2:\"24\";s:7:\"attr_id\";s:10:\"1073741828\";s:4:\"name\";s:15:\"玩家级独显\";s:4:\"sort\";s:1:\"1\";}}}}', 'a:2:{i:0;a:8:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";s:480:\"a:4:{i:0;a:5:{s:2:\"id\";s:1:\"4\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:1;a:5:{s:2:\"id\";s:1:\"1\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:19:\"安卓（Android）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:2;a:5:{s:2:\"id\";s:1:\"2\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:19:\"微软（Windows）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:3;a:5:{s:2:\"id\";s:1:\"3\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:15:\"苹果（IOS）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}\";s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";s:4:\"spec\";a:4:{i:0;a:5:{s:2:\"id\";s:1:\"4\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:1;a:5:{s:2:\"id\";s:1:\"1\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:19:\"安卓（Android）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:2;a:5:{s:2:\"id\";s:1:\"2\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:19:\"微软（Windows）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:3;a:5:{s:2:\"id\";s:1:\"3\";s:7:\"spec_id\";s:1:\"1\";s:4:\"name\";s:15:\"苹果（IOS）\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}s:9:\"show_type\";s:1:\"1\";}i:1;a:8:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";s:1438:\"a:13:{i:0;a:5:{s:2:\"id\";s:2:\"17\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}i:1;a:5:{s:2:\"id\";s:2:\"15\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"橙色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:2;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:3;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:4;a:5:{s:2:\"id\";s:2:\"12\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"粉色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:5;a:5:{s:2:\"id\";s:2:\"16\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"紫色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:6;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:7;a:5:{s:2:\"id\";s:2:\"14\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"绿色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:8;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:9;a:5:{s:2:\"id\";s:1:\"8\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"金色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:10;a:5:{s:2:\"id\";s:1:\"9\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"银色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:11;a:5:{s:2:\"id\";s:2:\"13\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黄色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:12;a:5:{s:2:\"id\";s:1:\"6\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黑色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}\";s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";s:4:\"spec\";a:13:{i:0;a:5:{s:2:\"id\";s:2:\"17\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}i:1;a:5:{s:2:\"id\";s:2:\"15\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"橙色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:2;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:3;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:4;a:5:{s:2:\"id\";s:2:\"12\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"粉色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:5;a:5:{s:2:\"id\";s:2:\"16\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"紫色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:6;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:7;a:5:{s:2:\"id\";s:2:\"14\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"绿色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:8;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:9;a:5:{s:2:\"id\";s:1:\"8\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"金色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:10;a:5:{s:2:\"id\";s:1:\"9\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"银色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:11;a:5:{s:2:\"id\";s:2:\"13\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黄色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:12;a:5:{s:2:\"id\";s:1:\"6\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黑色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}s:9:\"show_type\";s:1:\"1\";}}', '2');
INSERT INTO `ly_goods_type` VALUES ('3', '平板', '', 'a:3:{i:0;a:8:{s:2:\"id\";s:1:\"4\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";s:558:\"a:5:{i:0;a:5:{s:2:\"id\";s:2:\"26\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:7:\"Android\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:1;a:5:{s:2:\"id\";s:2:\"27\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:9:\"ios系统\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:2;a:5:{s:2:\"id\";s:2:\"29\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:5:\"Linux\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:3;a:5:{s:2:\"id\";s:2:\"30\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:4:\"Unix\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:4;a:5:{s:2:\"id\";s:2:\"28\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:7:\"windows\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}\";s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"常用\";s:6:\"is_del\";s:1:\"0\";s:4:\"spec\";a:5:{i:0;a:5:{s:2:\"id\";s:2:\"26\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:7:\"Android\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:1;a:5:{s:2:\"id\";s:2:\"27\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:9:\"ios系统\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:2;a:5:{s:2:\"id\";s:2:\"29\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:5:\"Linux\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:3;a:5:{s:2:\"id\";s:2:\"30\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:4:\"Unix\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:4;a:5:{s:2:\"id\";s:2:\"28\";s:7:\"spec_id\";s:1:\"4\";s:4:\"name\";s:7:\"windows\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}}s:9:\"show_type\";s:1:\"1\";}i:1;a:8:{s:2:\"id\";s:1:\"5\";s:4:\"name\";s:6:\"尺寸\";s:5:\"value\";s:1273:\"a:11:{i:0;a:5:{s:2:\"id\";s:2:\"38\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:10:\"10.1英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:1;a:5:{s:2:\"id\";s:2:\"39\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:10:\"11.6英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:2;a:5:{s:2:\"id\";s:2:\"40\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:10:\"12.1英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:3;a:5:{s:2:\"id\";s:2:\"41\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:17:\"13英寸及以上\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:4;a:5:{s:2:\"id\";s:2:\"31\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:16:\"6英寸及以下\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:5;a:5:{s:2:\"id\";s:2:\"33\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:10:\"7.85英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:6;a:5:{s:2:\"id\";s:2:\"34\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:9:\"7.9英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:7;a:5:{s:2:\"id\";s:2:\"32\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:7:\"7英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:8;a:5:{s:2:\"id\";s:2:\"36\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:9:\"8.3英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:9;a:5:{s:2:\"id\";s:2:\"35\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:7:\"8英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:10;a:5:{s:2:\"id\";s:2:\"37\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:9:\"9.7英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}}\";s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"平台\";s:6:\"is_del\";s:1:\"0\";s:4:\"spec\";a:11:{i:0;a:5:{s:2:\"id\";s:2:\"38\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:10:\"10.1英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:1;a:5:{s:2:\"id\";s:2:\"39\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:10:\"11.6英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:2;a:5:{s:2:\"id\";s:2:\"40\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:10:\"12.1英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:3;a:5:{s:2:\"id\";s:2:\"41\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:17:\"13英寸及以上\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:4;a:5:{s:2:\"id\";s:2:\"31\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:16:\"6英寸及以下\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:5;a:5:{s:2:\"id\";s:2:\"33\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:10:\"7.85英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:6;a:5:{s:2:\"id\";s:2:\"34\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:9:\"7.9英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:7;a:5:{s:2:\"id\";s:2:\"32\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:7:\"7英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:8;a:5:{s:2:\"id\";s:2:\"36\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:9:\"8.3英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:9;a:5:{s:2:\"id\";s:2:\"35\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:7:\"8英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:10;a:5:{s:2:\"id\";s:2:\"37\";s:7:\"spec_id\";s:1:\"5\";s:4:\"name\";s:9:\"9.7英寸\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}}s:9:\"show_type\";s:1:\"1\";}i:2;a:8:{s:2:\"id\";s:1:\"3\";s:4:\"name\";s:6:\"硬盘\";s:5:\"value\";s:863:\"a:8:{i:0;a:5:{s:2:\"id\";s:2:\"23\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:4:\"128G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:1;a:5:{s:2:\"id\";s:2:\"20\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:3:\"16G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:2;a:5:{s:2:\"id\";s:2:\"24\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:4:\"256G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:3;a:5:{s:2:\"id\";s:2:\"21\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:3:\"32G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:4;a:5:{s:2:\"id\";s:2:\"18\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:2:\"4G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:5;a:5:{s:2:\"id\";s:2:\"25\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:4:\"512G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:6;a:5:{s:2:\"id\";s:2:\"22\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:3:\"64G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:7;a:5:{s:2:\"id\";s:2:\"19\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:2:\"8G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}\";s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"平板\";s:6:\"is_del\";s:1:\"0\";s:4:\"spec\";a:8:{i:0;a:5:{s:2:\"id\";s:2:\"23\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:4:\"128G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:1;a:5:{s:2:\"id\";s:2:\"20\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:3:\"16G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:2;a:5:{s:2:\"id\";s:2:\"24\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:4:\"256G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:3;a:5:{s:2:\"id\";s:2:\"21\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:3:\"32G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:4;a:5:{s:2:\"id\";s:2:\"18\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:2:\"4G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:5;a:5:{s:2:\"id\";s:2:\"25\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:4:\"512G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:6;a:5:{s:2:\"id\";s:2:\"22\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:3:\"64G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:7;a:5:{s:2:\"id\";s:2:\"19\";s:7:\"spec_id\";s:1:\"3\";s:4:\"name\";s:2:\"8G\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}s:9:\"show_type\";s:1:\"1\";}}', '1,2');
INSERT INTO `ly_goods_type` VALUES ('4', '女式衬衫', 'a:2:{i:0;a:6:{s:2:\"id\";s:10:\"1073741829\";s:7:\"type_id\";s:1:\"4\";s:4:\"name\";s:6:\"袖长\";s:9:\"show_type\";s:1:\"1\";s:4:\"sort\";s:1:\"0\";s:6:\"values\";a:7:{i:0;a:4:{s:2:\"id\";s:2:\"25\";s:7:\"attr_id\";s:10:\"1073741829\";s:4:\"name\";s:6:\"长袖\";s:4:\"sort\";s:1:\"0\";}i:1;a:4:{s:2:\"id\";s:2:\"26\";s:7:\"attr_id\";s:10:\"1073741829\";s:4:\"name\";s:6:\"短袖\";s:4:\"sort\";s:1:\"1\";}i:2;a:4:{s:2:\"id\";s:2:\"27\";s:7:\"attr_id\";s:10:\"1073741829\";s:4:\"name\";s:9:\"七分袖\";s:4:\"sort\";s:1:\"2\";}i:3;a:4:{s:2:\"id\";s:2:\"28\";s:7:\"attr_id\";s:10:\"1073741829\";s:4:\"name\";s:6:\"无袖\";s:4:\"sort\";s:1:\"3\";}i:4;a:4:{s:2:\"id\";s:2:\"29\";s:7:\"attr_id\";s:10:\"1073741829\";s:4:\"name\";s:9:\"九分袖\";s:4:\"sort\";s:1:\"4\";}i:5;a:4:{s:2:\"id\";s:2:\"30\";s:7:\"attr_id\";s:10:\"1073741829\";s:4:\"name\";s:16:\"五分袖/中袖\";s:4:\"sort\";s:1:\"5\";}i:6;a:4:{s:2:\"id\";s:2:\"31\";s:7:\"attr_id\";s:10:\"1073741829\";s:4:\"name\";s:6:\"其它\";s:4:\"sort\";s:1:\"6\";}}}i:1;a:6:{s:2:\"id\";s:10:\"1073741830\";s:7:\"type_id\";s:1:\"4\";s:4:\"name\";s:6:\"面料\";s:9:\"show_type\";s:1:\"1\";s:4:\"sort\";s:1:\"1\";s:6:\"values\";a:10:{i:0;a:4:{s:2:\"id\";s:2:\"32\";s:7:\"attr_id\";s:10:\"1073741830\";s:4:\"name\";s:3:\"棉\";s:4:\"sort\";s:1:\"0\";}i:1;a:4:{s:2:\"id\";s:2:\"33\";s:7:\"attr_id\";s:10:\"1073741830\";s:4:\"name\";s:6:\"涤纶\";s:4:\"sort\";s:1:\"1\";}i:2;a:4:{s:2:\"id\";s:2:\"34\";s:7:\"attr_id\";s:10:\"1073741830\";s:4:\"name\";s:6:\"真丝\";s:4:\"sort\";s:1:\"2\";}i:3;a:4:{s:2:\"id\";s:2:\"35\";s:7:\"attr_id\";s:10:\"1073741830\";s:4:\"name\";s:6:\"绸缎\";s:4:\"sort\";s:1:\"3\";}i:4;a:4:{s:2:\"id\";s:2:\"36\";s:7:\"attr_id\";s:10:\"1073741830\";s:4:\"name\";s:7:\" 雪纺\";s:4:\"sort\";s:1:\"4\";}i:5;a:4:{s:2:\"id\";s:2:\"37\";s:7:\"attr_id\";s:10:\"1073741830\";s:4:\"name\";s:20:\"亚麻/大麻/汉麻\";s:4:\"sort\";s:1:\"5\";}i:6;a:4:{s:2:\"id\";s:2:\"38\";s:7:\"attr_id\";s:10:\"1073741830\";s:4:\"name\";s:14:\" 腈纶/化纤\";s:4:\"sort\";s:1:\"6\";}i:7;a:4:{s:2:\"id\";s:2:\"39\";s:7:\"attr_id\";s:10:\"1073741830\";s:4:\"name\";s:9:\"莫代尔\";s:4:\"sort\";s:1:\"7\";}i:8;a:4:{s:2:\"id\";s:2:\"40\";s:7:\"attr_id\";s:10:\"1073741830\";s:4:\"name\";s:7:\" 锦纶\";s:4:\"sort\";s:1:\"8\";}i:9;a:4:{s:2:\"id\";s:2:\"41\";s:7:\"attr_id\";s:10:\"1073741830\";s:4:\"name\";s:6:\"其它\";s:4:\"sort\";s:1:\"9\";}}}}', 'a:2:{i:0;a:8:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";s:968:\"a:9:{i:0;a:5:{s:2:\"id\";s:2:\"45\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"L\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:1;a:5:{s:2:\"id\";s:2:\"44\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"M\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:2;a:5:{s:2:\"id\";s:2:\"43\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"S\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:3;a:5:{s:2:\"id\";s:2:\"46\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:2:\"XL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:4;a:5:{s:2:\"id\";s:2:\"42\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:2:\"XS\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:5;a:5:{s:2:\"id\";s:2:\"47\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:3:\"XXL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:6;a:5:{s:2:\"id\";s:2:\"48\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:4:\"XXXL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:7;a:5:{s:2:\"id\";s:2:\"50\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:8;a:5:{s:2:\"id\";s:2:\"49\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:6:\"均码\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}}\";s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";s:4:\"spec\";a:9:{i:0;a:5:{s:2:\"id\";s:2:\"45\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"L\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:1;a:5:{s:2:\"id\";s:2:\"44\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"M\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:2;a:5:{s:2:\"id\";s:2:\"43\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:1:\"S\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:3;a:5:{s:2:\"id\";s:2:\"46\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:2:\"XL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:4;a:5:{s:2:\"id\";s:2:\"42\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:2:\"XS\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:5;a:5:{s:2:\"id\";s:2:\"47\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:3:\"XXL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:6;a:5:{s:2:\"id\";s:2:\"48\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:4:\"XXXL\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:7;a:5:{s:2:\"id\";s:2:\"50\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:8;a:5:{s:2:\"id\";s:2:\"49\";s:7:\"spec_id\";s:1:\"6\";s:4:\"name\";s:6:\"均码\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}}s:9:\"show_type\";s:1:\"1\";}i:1;a:8:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";s:1438:\"a:13:{i:0;a:5:{s:2:\"id\";s:2:\"17\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}i:1;a:5:{s:2:\"id\";s:2:\"15\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"橙色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:2;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:3;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:4;a:5:{s:2:\"id\";s:2:\"12\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"粉色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:5;a:5:{s:2:\"id\";s:2:\"16\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"紫色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:6;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:7;a:5:{s:2:\"id\";s:2:\"14\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"绿色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:8;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:9;a:5:{s:2:\"id\";s:1:\"8\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"金色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:10;a:5:{s:2:\"id\";s:1:\"9\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"银色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:11;a:5:{s:2:\"id\";s:2:\"13\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黄色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:12;a:5:{s:2:\"id\";s:1:\"6\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黑色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}\";s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";s:4:\"spec\";a:13:{i:0;a:5:{s:2:\"id\";s:2:\"17\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}i:1;a:5:{s:2:\"id\";s:2:\"15\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"橙色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:2;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:3;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:4;a:5:{s:2:\"id\";s:2:\"12\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"粉色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:5;a:5:{s:2:\"id\";s:2:\"16\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"紫色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:6;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:7;a:5:{s:2:\"id\";s:2:\"14\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"绿色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:8;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:9;a:5:{s:2:\"id\";s:1:\"8\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"金色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:10;a:5:{s:2:\"id\";s:1:\"9\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"银色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:11;a:5:{s:2:\"id\";s:2:\"13\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黄色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:12;a:5:{s:2:\"id\";s:1:\"6\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黑色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}s:9:\"show_type\";s:1:\"1\";}}', '');
INSERT INTO `ly_goods_type` VALUES ('5', '男式衬衫', 'a:2:{i:0;a:6:{s:2:\"id\";s:10:\"1073741831\";s:7:\"type_id\";s:1:\"5\";s:4:\"name\";s:6:\"袖长\";s:9:\"show_type\";s:1:\"1\";s:4:\"sort\";s:1:\"0\";s:6:\"values\";a:5:{i:0;a:4:{s:2:\"id\";s:2:\"42\";s:7:\"attr_id\";s:10:\"1073741831\";s:4:\"name\";s:6:\"长袖\";s:4:\"sort\";s:1:\"0\";}i:1;a:4:{s:2:\"id\";s:2:\"43\";s:7:\"attr_id\";s:10:\"1073741831\";s:4:\"name\";s:6:\"短袖\";s:4:\"sort\";s:1:\"1\";}i:2;a:4:{s:2:\"id\";s:2:\"44\";s:7:\"attr_id\";s:10:\"1073741831\";s:4:\"name\";s:9:\"五分袖\";s:4:\"sort\";s:1:\"2\";}i:3;a:4:{s:2:\"id\";s:2:\"45\";s:7:\"attr_id\";s:10:\"1073741831\";s:4:\"name\";s:9:\"七分袖\";s:4:\"sort\";s:1:\"3\";}i:4;a:4:{s:2:\"id\";s:2:\"46\";s:7:\"attr_id\";s:10:\"1073741831\";s:4:\"name\";s:6:\"无袖\";s:4:\"sort\";s:1:\"4\";}}}i:1;a:6:{s:2:\"id\";s:10:\"1073741832\";s:7:\"type_id\";s:1:\"5\";s:4:\"name\";s:6:\"领子\";s:9:\"show_type\";s:1:\"1\";s:4:\"sort\";s:1:\"1\";s:6:\"values\";a:5:{i:0;a:4:{s:2:\"id\";s:2:\"47\";s:7:\"attr_id\";s:10:\"1073741832\";s:4:\"name\";s:6:\"立领\";s:4:\"sort\";s:1:\"0\";}i:1;a:4:{s:2:\"id\";s:2:\"48\";s:7:\"attr_id\";s:10:\"1073741832\";s:4:\"name\";s:6:\"圆领\";s:4:\"sort\";s:1:\"1\";}i:2;a:4:{s:2:\"id\";s:2:\"49\";s:7:\"attr_id\";s:10:\"1073741832\";s:4:\"name\";s:6:\"心领\";s:4:\"sort\";s:1:\"2\";}i:3;a:4:{s:2:\"id\";s:2:\"50\";s:7:\"attr_id\";s:10:\"1073741832\";s:4:\"name\";s:6:\"无领\";s:4:\"sort\";s:1:\"3\";}i:4;a:4:{s:2:\"id\";s:2:\"51\";s:7:\"attr_id\";s:10:\"1073741832\";s:4:\"name\";s:6:\"常规\";s:4:\"sort\";s:1:\"4\";}}}}', 'a:2:{i:0;a:8:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";s:1963:\"a:18:{i:0;a:5:{s:2:\"id\";s:2:\"51\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:7:\"165/88A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:1;a:5:{s:2:\"id\";s:2:\"52\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:7:\"170/92A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:2;a:5:{s:2:\"id\";s:2:\"53\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:7:\"175/96A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:3;a:5:{s:2:\"id\";s:2:\"54\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:8:\"180/100A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:4;a:5:{s:2:\"id\";s:2:\"55\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:8:\"185/104A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:5;a:5:{s:2:\"id\";s:2:\"56\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:7:\"190/104\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:6;a:5:{s:2:\"id\";s:2:\"57\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"36\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:7;a:5:{s:2:\"id\";s:2:\"58\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"37\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:8;a:5:{s:2:\"id\";s:2:\"59\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"38\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:9;a:5:{s:2:\"id\";s:2:\"60\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"39\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:10;a:5:{s:2:\"id\";s:2:\"61\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"40\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:11;a:5:{s:2:\"id\";s:2:\"62\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"41\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:12;a:5:{s:2:\"id\";s:2:\"63\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"42\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}i:13;a:5:{s:2:\"id\";s:2:\"64\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"43\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"13\";}i:14;a:5:{s:2:\"id\";s:2:\"65\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"44\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"14\";}i:15;a:5:{s:2:\"id\";s:2:\"66\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"45\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"15\";}i:16;a:5:{s:2:\"id\";s:2:\"67\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"46\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"16\";}i:17;a:5:{s:2:\"id\";s:2:\"68\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"47\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"17\";}}\";s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";s:4:\"spec\";a:18:{i:0;a:5:{s:2:\"id\";s:2:\"51\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:7:\"165/88A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:1;a:5:{s:2:\"id\";s:2:\"52\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:7:\"170/92A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}i:2;a:5:{s:2:\"id\";s:2:\"53\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:7:\"175/96A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:3;a:5:{s:2:\"id\";s:2:\"54\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:8:\"180/100A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:4;a:5:{s:2:\"id\";s:2:\"55\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:8:\"185/104A\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:5;a:5:{s:2:\"id\";s:2:\"56\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:7:\"190/104\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:6;a:5:{s:2:\"id\";s:2:\"57\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"36\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:7;a:5:{s:2:\"id\";s:2:\"58\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"37\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:8;a:5:{s:2:\"id\";s:2:\"59\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"38\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:9;a:5:{s:2:\"id\";s:2:\"60\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"39\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:10;a:5:{s:2:\"id\";s:2:\"61\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"40\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:11;a:5:{s:2:\"id\";s:2:\"62\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"41\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:12;a:5:{s:2:\"id\";s:2:\"63\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"42\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}i:13;a:5:{s:2:\"id\";s:2:\"64\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"43\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"13\";}i:14;a:5:{s:2:\"id\";s:2:\"65\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"44\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"14\";}i:15;a:5:{s:2:\"id\";s:2:\"66\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"45\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"15\";}i:16;a:5:{s:2:\"id\";s:2:\"67\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"46\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"16\";}i:17;a:5:{s:2:\"id\";s:2:\"68\";s:7:\"spec_id\";s:1:\"7\";s:4:\"name\";s:2:\"47\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"17\";}}s:9:\"show_type\";s:1:\"1\";}i:1;a:8:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";s:1438:\"a:13:{i:0;a:5:{s:2:\"id\";s:2:\"17\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}i:1;a:5:{s:2:\"id\";s:2:\"15\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"橙色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:2;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:3;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:4;a:5:{s:2:\"id\";s:2:\"12\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"粉色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:5;a:5:{s:2:\"id\";s:2:\"16\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"紫色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:6;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:7;a:5:{s:2:\"id\";s:2:\"14\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"绿色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:8;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:9;a:5:{s:2:\"id\";s:1:\"8\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"金色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:10;a:5:{s:2:\"id\";s:1:\"9\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"银色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:11;a:5:{s:2:\"id\";s:2:\"13\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黄色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:12;a:5:{s:2:\"id\";s:1:\"6\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黑色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}\";s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";s:4:\"spec\";a:13:{i:0;a:5:{s:2:\"id\";s:2:\"17\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"其它\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"12\";}i:1;a:5:{s:2:\"id\";s:2:\"15\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"橙色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"10\";}i:2;a:5:{s:2:\"id\";s:1:\"7\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"灰色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"2\";}i:3;a:5:{s:2:\"id\";s:1:\"5\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"白色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"0\";}i:4;a:5:{s:2:\"id\";s:2:\"12\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"粉色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"7\";}i:5;a:5:{s:2:\"id\";s:2:\"16\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"紫色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:2:\"11\";}i:6;a:5:{s:2:\"id\";s:2:\"10\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"红色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"5\";}i:7;a:5:{s:2:\"id\";s:2:\"14\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"绿色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"9\";}i:8;a:5:{s:2:\"id\";s:2:\"11\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"蓝色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"6\";}i:9;a:5:{s:2:\"id\";s:1:\"8\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"金色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"3\";}i:10;a:5:{s:2:\"id\";s:1:\"9\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"银色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"4\";}i:11;a:5:{s:2:\"id\";s:2:\"13\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黄色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"8\";}i:12;a:5:{s:2:\"id\";s:1:\"6\";s:7:\"spec_id\";s:1:\"2\";s:4:\"name\";s:6:\"黑色\";s:3:\"img\";s:0:\"\";s:4:\"sort\";s:1:\"1\";}}s:9:\"show_type\";s:1:\"1\";}}', '');

-- ----------------------------
-- Table structure for `ly_grade`
-- ----------------------------
DROP TABLE IF EXISTS `ly_grade`;
CREATE TABLE `ly_grade` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `money` bigint(20) NOT NULL,
  `message_ids` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_grade
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_groupbuy`
-- ----------------------------
DROP TABLE IF EXISTS `ly_groupbuy`;
CREATE TABLE `ly_groupbuy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(20) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `max_num` int(11) NOT NULL,
  `min_num` int(11) DEFAULT '1',
  `price` float(10,2) NOT NULL,
  `description` text,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `goods_num` bigint(20) DEFAULT NULL,
  `order_num` bigint(20) DEFAULT '0',
  `is_end` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_groupbuy
-- ----------------------------
INSERT INTO `ly_groupbuy` VALUES ('2', '24', '2017春装男款格子长袖男衬衫大型团购', '50', '1', '30.00', '', '2017-05-18 00:19:00', '2017-05-31 00:19:00', '0', '0', '0');
INSERT INTO `ly_groupbuy` VALUES ('3', '16', 'BRIOSO格子衬衫开心团', '20', '1', '40.00', '', '2017-05-18 00:19:00', '2017-05-31 00:19:00', '0', '0', '0');
INSERT INTO `ly_groupbuy` VALUES ('4', '15', 'Apple/苹果 ipad air WIFI iPad Air平板黑', '20', '1', '3300.00', '', '2017-05-18 00:20:00', '2017-05-31 00:20:00', '0', '0', '0');

-- ----------------------------
-- Table structure for `ly_help`
-- ----------------------------
DROP TABLE IF EXISTS `ly_help`;
CREATE TABLE `ly_help` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL DEFAULT '',
  `content` longtext,
  `category_id` bigint(20) NOT NULL,
  `summary` varchar(255) DEFAULT '',
  `status` int(2) DEFAULT '0',
  `top` int(1) DEFAULT '0',
  `publish_time` datetime DEFAULT '2000-01-01 00:00:00',
  `count` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_help
-- ----------------------------
INSERT INTO `ly_help` VALUES ('3', '账户注册', '<h5 style=\"color:#666666;font-family:Tahoma;\">\r\n	<br /></h5>', '1', '', '0', '0', '2014-02-10 22:36:35', '0');
INSERT INTO `ly_help` VALUES ('5', '购物流程', '', '1', '', '0', '0', '2014-03-07 14:36:45', '0');
INSERT INTO `ly_help` VALUES ('6', '积分制度', '<h5 style=\"font-size:14px;color:#666666;font-family:Tahoma, simsun;background-color:#FFFFFF;\">\r\n	一、积分制度\r\n</h5>\r\n<p class=\"pl20\" style=\"font-size:14px;color:#666666;font-family:Tahoma, simsun;background-color:#FFFFFF;\">\r\n	您在TinyShop商城购物消费，或参加活动等，即可获得<span style=\"color:#666666;font-family:Tahoma, simsun;font-size:14px;line-height:21px;background-color:#FFFFFF;\">TinyShop商城</span>的积分。积分可以兑换TinyShop商城的代金卷，在购买商品进行确认订单的时候，可能使用满足条件的代金卷。\r\n</p>\r\n<h5 style=\"font-size:14px;color:#666666;font-family:Tahoma, simsun;background-color:#FFFFFF;\">\r\n	二、积分获取\r\n</h5>\r\n<p class=\"pl20\" style=\"font-size:14px;color:#666666;font-family:Tahoma, simsun;background-color:#FFFFFF;\">\r\n	您可以通过以下几种方式，获取积分：\r\n</p>\r\n<p class=\"pl20\" style=\"font-size:14px;color:#666666;font-family:Tahoma, simsun;background-color:#FFFFFF;\">\r\n	a)每个商品都有不同的对应积分，购买后都可以得到对应的积分。<br />\r\nb)当满足了订单促销活动时，如果是积分N倍活动，则可以得到，商品总分N倍的积分。\r\n</p>\r\n<h5 style=\"font-size:14px;color:#666666;font-family:Tahoma, simsun;background-color:#FFFFFF;\">\r\n	三、积分的使用\r\n</h5>\r\n<p class=\"pl20\" style=\"font-size:14px;color:#666666;font-family:Tahoma, simsun;background-color:#FFFFFF;\">\r\n	您可以采取以下几种方式，使用积分：\r\n</p>\r\n<p class=\"pl20\" style=\"font-size:14px;color:#666666;font-family:Tahoma, simsun;background-color:#FFFFFF;\">\r\n	<b class=\"bor_tl\">兑换代金卷</b><br />\r\n积分可用来兑换TinyShop商城的代金卷。\r\n</p>\r\n<p class=\"pl20\" style=\"font-size:14px;color:#666666;font-family:Tahoma, simsun;background-color:#FFFFFF;\">\r\n	<b class=\"bor_tl\">会员升级</b><br />\r\n积分累计和新增积分到特定数额，即可自动提升会员等级。不同等级会员，可以享受不同优惠。\r\n</p>', '1', '', '0', '0', '2014-03-07 14:38:30', '0');
INSERT INTO `ly_help` VALUES ('7', '配送范围', '', '3', '', '0', '0', '2014-03-07 15:25:41', '0');
INSERT INTO `ly_help` VALUES ('8', '余额支付', '', '5', '', '0', '0', '2014-03-07 15:34:36', '0');
INSERT INTO `ly_help` VALUES ('9', '退款说明', '', '6', '', '0', '0', '2014-03-07 15:35:07', '0');
INSERT INTO `ly_help` VALUES ('10', '联系客服', '', '7', '', '0', '0', '2014-03-07 15:35:33', '0');
INSERT INTO `ly_help` VALUES ('11', '找回密码', '', '7', '', '0', '0', '2014-03-07 15:35:46', '0');
INSERT INTO `ly_help` VALUES ('12', '常见问题', '', '7', '', '0', '0', '2014-03-07 15:35:58', '0');
INSERT INTO `ly_help` VALUES ('13', '售后保障', '<div style=\"color:#666666;font-family:Arial;\">\r\n	<strong>服务承诺：</strong><br />\r\n商城向您保证所售商品均为正品行货，自营商品开具机打发票或电子发票。凭质保证书及商城发票，可享受全国联保服务（奢侈品、钟表除外；奢侈品、钟表由联系保修，享受法定三包售后服务），与您亲临商场选购的商品享受相同的质量保证。商城还为您提供具有竞争力的商品价格和运费政策，请您放心购买！ <br />\r\n注：因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！并且保证与当时市场上同样主流新品一致。若本商城没有及时更新，请大家谅解！\r\n</div>\r\n<div style=\"color:#666666;font-family:Arial;\">\r\n	<strong>权利声明：</strong><br />\r\n商城上的所有商品信息、客户评价、商品咨询、网友讨论等内容，是商城重要的经营资源，未经许可，禁止非法转载使用。\r\n	<p>\r\n		<b>注：</b>本站商品信息均来自于厂商，其真实性、准确性和合法性由信息拥有者（厂商）负责。本站不提供任何保证，并不承担任何法律责任。\r\n	</p>\r\n</div>', '6', '', '0', '0', '2014-05-04 10:38:55', '0');
INSERT INTO `ly_help` VALUES ('14', '用户注册协议', '<p>\r\n	演示内容，请尽快完善用户注册协议。\r\n</p>', '7', '', '0', '0', '2015-04-02 14:25:42', '0');

-- ----------------------------
-- Table structure for `ly_help_category`
-- ----------------------------
DROP TABLE IF EXISTS `ly_help_category`;
CREATE TABLE `ly_help_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `alias` varchar(200) DEFAULT '',
  `parent_id` bigint(20) NOT NULL,
  `count` bigint(20) DEFAULT '0',
  `path` varchar(20000) DEFAULT NULL,
  `sort` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `alias` (`alias`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_help_category
-- ----------------------------
INSERT INTO `ly_help_category` VALUES ('1', '购物指南', 'guide', '0', '0', ',1,', '10');
INSERT INTO `ly_help_category` VALUES ('3', '配送方式', 'distribution', '0', '0', ',3,', '2');
INSERT INTO `ly_help_category` VALUES ('5', '支付方式', 'payment', '0', '0', ',5,', '1');
INSERT INTO `ly_help_category` VALUES ('6', '售后服务', 'aftermarket', '0', '0', ',6,', '1');
INSERT INTO `ly_help_category` VALUES ('7', '帮助信息', 'helpinfo', '0', '0', ',7,', '1');

-- ----------------------------
-- Table structure for `ly_level`
-- ----------------------------
DROP TABLE IF EXISTS `ly_level`;
CREATE TABLE `ly_level` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT '分销等级名称',
  `prize_percent` int(8) DEFAULT NULL,
  `qty` int(8) NOT NULL DEFAULT '0' COMMENT '升级数量要求',
  `person` int(8) NOT NULL DEFAULT '0' COMMENT '升级人数要求',
  `is_alow` tinyint(2) NOT NULL DEFAULT '1' COMMENT '是否允许升级1（允许）0不允许',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_level
-- ----------------------------
INSERT INTO `ly_level` VALUES ('1', '执行总裁', '110', '100000', '10000', '1');
INSERT INTO `ly_level` VALUES ('2', '区域总监', '120', '10000', '1000', '1');
INSERT INTO `ly_level` VALUES ('3', '品牌总代', '130', '1000', '100', '1');
INSERT INTO `ly_level` VALUES ('4', '金牌代理', '140', '100', '10', '1');

-- ----------------------------
-- Table structure for `ly_log_operation`
-- ----------------------------
DROP TABLE IF EXISTS `ly_log_operation`;
CREATE TABLE `ly_log_operation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `manager_id` bigint(20) NOT NULL,
  `action` varchar(50) NOT NULL,
  `content` varchar(255) NOT NULL,
  `ip` varchar(80) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=185 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_log_operation
-- ----------------------------
INSERT INTO `ly_log_operation` VALUES ('143', '3', '添加代理', '管理员[admin]:添加了会员 131111112222 的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-16 16:59:57');
INSERT INTO `ly_log_operation` VALUES ('144', '3', '添加代理', '管理员[admin]:添加了会员  的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-16 17:16:28');
INSERT INTO `ly_log_operation` VALUES ('145', '3', '添加会员', '管理员[admin]:添加了会员 crazyly 的信息', '127.0.0.1', '/index.php?con=customer&act=customer_save', '2017-05-16 17:21:06');
INSERT INTO `ly_log_operation` VALUES ('146', '3', '添加代理', '管理员[admin]:添加了会员 crazyly 的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-16 17:22:37');
INSERT INTO `ly_log_operation` VALUES ('147', '3', '添加代理', '管理员[admin]:添加了会员 crazyly 的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-16 17:23:14');
INSERT INTO `ly_log_operation` VALUES ('148', '3', '添加代理', '管理员[admin]:添加了会员 crazyly 的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-16 17:27:37');
INSERT INTO `ly_log_operation` VALUES ('149', '3', '修改代理', '管理员[admin]:修改了代理的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-16 17:33:23');
INSERT INTO `ly_log_operation` VALUES ('150', '3', '添加代理', '管理员[admin]:添加了会员 123456 的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-16 17:35:56');
INSERT INTO `ly_log_operation` VALUES ('151', '3', '添加代理', '管理员[admin]:添加了会员 worlduhot 的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-16 17:42:14');
INSERT INTO `ly_log_operation` VALUES ('152', '3', '修改商品', '管理员[admin]:修改了商品 2017春装男款格子长袖男衬衫 休闲衬衣潮', '127.0.0.1', '/index.php?con=goods&act=goods_save', '2017-05-17 13:36:10');
INSERT INTO `ly_log_operation` VALUES ('153', '3', '修改商品', '管理员[admin]:修改了商品 2017春装新款长袖衬衫男 韩版修身灯芯绒波点衬衫男士衬衫上衣潮', '127.0.0.1', '/index.php?con=goods&act=goods_save', '2017-05-17 13:36:27');
INSERT INTO `ly_log_operation` VALUES ('154', '3', '修改商品', '管理员[admin]:修改了商品 2017夏装长袖男士格子衬衣拼接波点修身休闲衬衫衫青春百搭潮热卖', '127.0.0.1', '/index.php?con=goods&act=goods_save', '2017-05-17 13:36:36');
INSERT INTO `ly_log_operation` VALUES ('155', '3', '修改商品', '管理员[admin]:修改了商品 春夏装新款2017长袖白衬衫女短袖雪纺韩版大码女装打底衫职业衬衣', '127.0.0.1', '/index.php?con=goods&act=goods_save', '2017-05-17 13:36:56');
INSERT INTO `ly_log_operation` VALUES ('156', '3', '修改商品', '管理员[admin]:修改了商品 白衬衫女短袖2017新款夏装女衬衣大码工作服工装韩版女士衬衫职业', '127.0.0.1', '/index.php?con=goods&act=goods_save', '2017-05-17 13:37:09');
INSERT INTO `ly_log_operation` VALUES ('157', '3', '修改商品', '管理员[admin]:修改了商品 BRIOSO格子衬衫 女 长袖2017春装新款女装修身韩版大码百搭衬衣潮', '127.0.0.1', '/index.php?con=goods&act=goods_save', '2017-05-17 13:37:24');
INSERT INTO `ly_log_operation` VALUES ('158', '3', '修改了分销代理等级', '管理员[admin]:修改了分销代理等级执行总裁的信息', '127.0.0.1', '/index.php?con=distribution&act=level_save', '2017-05-17 17:15:55');
INSERT INTO `ly_log_operation` VALUES ('159', '3', '修改了分销代理等级', '管理员[admin]:修改了分销代理等级执行总裁的信息', '127.0.0.1', '/index.php?con=distribution&act=level_save', '2017-05-17 17:44:25');
INSERT INTO `ly_log_operation` VALUES ('160', '3', '修改了分销代理等级', '管理员[admin]:修改了分销代理等级执行总裁的信息', '127.0.0.1', '/index.php?con=distribution&act=level_save', '2017-05-17 17:45:35');
INSERT INTO `ly_log_operation` VALUES ('161', '3', '修改了分销代理等级', '管理员[admin]:修改了分销代理等级区域总监的信息', '127.0.0.1', '/index.php?con=distribution&act=level_save', '2017-05-17 17:45:43');
INSERT INTO `ly_log_operation` VALUES ('162', '3', '修改了分销代理等级', '管理员[admin]:修改了分销代理等级品牌总代的信息', '127.0.0.1', '/index.php?con=distribution&act=level_save', '2017-05-17 17:45:52');
INSERT INTO `ly_log_operation` VALUES ('163', '3', '修改了分销代理等级', '管理员[admin]:修改了分销代理等级金牌代理的信息', '127.0.0.1', '/index.php?con=distribution&act=level_save', '2017-05-17 17:45:59');
INSERT INTO `ly_log_operation` VALUES ('164', '3', '修改会员', '管理员[admin]:修改了会员 crazyly 的信息', '127.0.0.1', '/index.php?con=customer&act=customer_save', '2017-05-17 19:09:18');
INSERT INTO `ly_log_operation` VALUES ('165', '3', '修改会员', '管理员[admin]:修改了会员 crazyly 的信息', '127.0.0.1', '/index.php?con=customer&act=customer_save', '2017-05-17 19:10:03');
INSERT INTO `ly_log_operation` VALUES ('166', '3', '修改会员', '管理员[admin]:修改了会员 crazyly 的信息', '127.0.0.1', '/index.php?con=customer&act=customer_save', '2017-05-17 19:10:15');
INSERT INTO `ly_log_operation` VALUES ('167', '3', '添加分销商品', '管理员[admin]:添加了分销商品测试的信息', '127.0.0.1', '/index.php?con=distribution&act=dispro_save', '2017-05-17 21:53:03');
INSERT INTO `ly_log_operation` VALUES ('168', '3', '修改了分销商品', '管理员[admin]:修改了分销商品测试的信息', '127.0.0.1', '/index.php?con=distribution&act=dispro_save', '2017-05-17 21:57:14');
INSERT INTO `ly_log_operation` VALUES ('169', '3', '添加分销商品', '管理员[admin]:添加了分销商品测试2的信息', '127.0.0.1', '/index.php?con=distribution&act=dispro_save', '2017-05-17 22:07:43');
INSERT INTO `ly_log_operation` VALUES ('170', '3', '修改了分销商品', '管理员[admin]:修改了分销商品测试2的信息', '127.0.0.1', '/index.php?con=distribution&act=dispro_save', '2017-05-17 22:10:05');
INSERT INTO `ly_log_operation` VALUES ('171', '3', '修改了分销商品', '管理员[admin]:修改了分销商品测试2的信息', '127.0.0.1', '/index.php?con=distribution&act=dispro_save', '2017-05-17 22:16:44');
INSERT INTO `ly_log_operation` VALUES ('172', '3', '修改了分销商品', '管理员[admin]:修改了分销商品测试2的信息', '127.0.0.1', '/index.php?con=distribution&act=dispro_save', '2017-05-17 22:19:24');
INSERT INTO `ly_log_operation` VALUES ('173', '3', '修改了分销商品', '管理员[admin]:修改了分销商品测试2的信息', '127.0.0.1', '/index.php?con=distribution&act=dispro_save', '2017-05-17 22:20:19');
INSERT INTO `ly_log_operation` VALUES ('174', '3', '修改了分销商品', '管理员[admin]:修改了分销商品测试的信息', '127.0.0.1', '/index.php?con=distribution&act=dispro_save', '2017-05-17 22:20:31');
INSERT INTO `ly_log_operation` VALUES ('175', '3', '修改文章', '管理员[admin]:修改了文章 WorldUhot毕业设计萌萌哒', '127.0.0.1', '/index.php?con=content&act=article_save', '2017-05-18 21:27:39');
INSERT INTO `ly_log_operation` VALUES ('176', '3', '修改会员', '管理员[admin]:修改了会员 crazyly 的信息', '127.0.0.1', '/index.php?con=customer&act=customer_save', '2017-05-18 21:43:52');
INSERT INTO `ly_log_operation` VALUES ('177', '3', '删除会员', '管理员[admin]:删除了会员 653541412@qq.com', '127.0.0.1', '/index.php?con=customer&act=customer_del&id=4', '2017-05-18 21:44:41');
INSERT INTO `ly_log_operation` VALUES ('178', '3', '添加代理', '管理员[admin]:添加了会员 worlduhot1 的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-20 16:33:05');
INSERT INTO `ly_log_operation` VALUES ('179', '3', '添加代理', '管理员[admin]:添加了会员 worlduhot2 的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-20 16:35:37');
INSERT INTO `ly_log_operation` VALUES ('180', '3', '修改代理', '管理员[admin]:修改了代理的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-20 16:37:40');
INSERT INTO `ly_log_operation` VALUES ('181', '3', '修改代理', '管理员[admin]:修改了代理的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-20 16:38:04');
INSERT INTO `ly_log_operation` VALUES ('182', '3', '修改代理', '管理员[admin]:修改了代理的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-20 16:38:35');
INSERT INTO `ly_log_operation` VALUES ('183', '3', '添加代理', '管理员[admin]:添加了会员 worlduhot3 的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-20 16:41:31');
INSERT INTO `ly_log_operation` VALUES ('184', '3', '添加代理', '管理员[admin]:添加了会员 worlduhot4 的信息', '127.0.0.1', '/index.php?con=distribution&act=agent_save', '2017-05-20 16:43:29');

-- ----------------------------
-- Table structure for `ly_manager`
-- ----------------------------
DROP TABLE IF EXISTS `ly_manager`;
CREATE TABLE `ly_manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `roles` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `validcode` varchar(10) NOT NULL,
  `last_ip` varchar(40) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_lock` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_manager
-- ----------------------------
INSERT INTO `ly_manager` VALUES ('3', 'admin', 'administrator', 'b16ea2ff9ee7fbef1c2c669575f72fdc', 'chuP-+?|', '127.0.0.1', '2017-05-20 16:00:53', '0');

-- ----------------------------
-- Table structure for `ly_message`
-- ----------------------------
DROP TABLE IF EXISTS `ly_message`;
CREATE TABLE `ly_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_message
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_mobile_code`
-- ----------------------------
DROP TABLE IF EXISTS `ly_mobile_code`;
CREATE TABLE `ly_mobile_code` (
  `mobile` varchar(20) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `send_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`mobile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_mobile_code
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_msg_template`
-- ----------------------------
DROP TABLE IF EXISTS `ly_msg_template`;
CREATE TABLE `ly_msg_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `variable` varchar(255) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_msg_template
-- ----------------------------
INSERT INTO `ly_msg_template` VALUES ('1', '到货通知', '最近到货通知', '用户名:{$user_name} 商品名:{$goods_name}', '<p>\r\n	尊敬用户：{$user_name}您关注的商品：{$goods_name}已到货，由于此商品近期销售火爆，请及时购买！\r\n</p>');
INSERT INTO `ly_msg_template` VALUES ('3', '找回密码', '密码找回', '站点名称:{$site_name} 重置密码地址:{$reset_url} 站点地址:{$site_url} 当前时间:{$current_time}', '<p>\r\n	尊敬的用户您好：\r\n</p>\r\n<p>\r\n	感谢您注册<span style=\"color:#333333;font-family:Tahoma, Helvetica, 宋体, san-serif;line-height:32px;\">{$site_name}，以下操作将帮助您重置密码，</span>请点击以下链接重置您的密码\r\n</p>\r\n<p>\r\n	<span style=\"color:#333333;font-family:Tahoma, Helvetica, 宋体, san-serif;line-height:32px;\"><a href=\"{$reset_url}\" target=\"_blank\">{$reset_url}</a></span> \r\n</p>\r\n愿您在<a href=\"{$site_url}\" target=\"_blank\">{$site_name}</a>度过愉快的时光。<br />');
INSERT INTO `ly_msg_template` VALUES ('4', '用户注册邮箱认证', '注册邮箱认证', '激活地址:{$activation_url} 站点名称:{$site_name} 站点地址:{$site_url} 当前时间:{$current_time}', '<p>\r\n	尊敬的用户您好：\r\n</p>\r\n<p>\r\n	感谢你在{$site_name}的注册，通过以下连接可以激活你的账户。\r\n</p>\r\n<p>\r\n	<span style=\"color:#333333;font-family:Tahoma, Helvetica, 宋体, san-serif;line-height:32px;\"><a href=\"{$activation_url}\" target=\"_blank\">{$activation_url}</a></span> \r\n</p>\r\n<span>愿您在</span><a href=\"{$site_url}\" target=\"_blank\">{$site_name}</a><span>度过愉快的时光。</span>');

-- ----------------------------
-- Table structure for `ly_nav`
-- ----------------------------
DROP TABLE IF EXISTS `ly_nav`;
CREATE TABLE `ly_nav` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `type` varchar(20) DEFAULT 'main',
  `enable` int(1) DEFAULT '1',
  `sort` int(11) DEFAULT NULL,
  `open_type` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_nav
-- ----------------------------
INSERT INTO `ly_nav` VALUES ('3', '手机商城', '/index/category/cid/2', 'main', '1', '1', '0');
INSERT INTO `ly_nav` VALUES ('2', '服装', '/index/category/cid/5', 'main', '1', '2', '0');
INSERT INTO `ly_nav` VALUES ('4', '团购', '/index/group', 'main', '1', '3', '0');
INSERT INTO `ly_nav` VALUES ('5', '限时抢购', '/index/flash', 'main', '1', '4', '0');
INSERT INTO `ly_nav` VALUES ('6', '一元抢购', 'http://tinyrise.com', 'main', '1', '1', '1');

-- ----------------------------
-- Table structure for `ly_notice_template`
-- ----------------------------
DROP TABLE IF EXISTS `ly_notice_template`;
CREATE TABLE `ly_notice_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `key_id` varchar(50) DEFAULT NULL,
  `style` varchar(20) DEFAULT NULL,
  `template_id` varchar(64) DEFAULT NULL,
  `template` text,
  `tousers` varchar(255) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `note` text,
  `obje` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_notice_template
-- ----------------------------
INSERT INTO `ly_notice_template` VALUES ('1', '下单提醒', 'create_order', 'weixin', '', '{\"touser\":\"__touser__\",\"template_id\":\"__template_id__\",\"topcolor\":\"#0067A6\",\"data\":{\"first\":{\"value\":\"贺喜，商城有人下单了！\",\"color\":\"#00ABD8\"},\"keyword1\":{\"value\":\"订单(__order_no__)\",\"color\":\"#008972\"},\"keyword2\":{\"value\":\"__user__\",\"color\":\"#008972\"},\"keyword3\":{\"value\":\"__order_amount____currency_unit__\",\"color\":\"#EFC028\"},\"keyword4\":{\"value\":\"__order_amount____currency_unit__\",\"color\":\"#EFC028\"},\"keyword5\":{\"value\":\"__create_time__\",\"color\":\"#EFC028\"},\"remark\":{\"value\":\"济南泰创软件科技有限公司--祝你生意兴隆!\",\"color\":\"#F2572D\"}}}', '', '0', '在微信模板搜索中搜索“下单通知”，对应的模板编号为：OPENTM207350184', '0');
INSERT INTO `ly_notice_template` VALUES ('2', '下单提醒', 'create_order', 'email', '', '<h1>贺喜，商城有人下单了！</h1>\r\n订单编号：__order_no__<br/>\r\n下单者：__user__ <br/>\r\n订单金额：__order_amount____currency_unit__ <br/>\r\n下单时间：__create_time__ <br/>\r\n济南泰创软件科技公司--祝您生意兴隆！', '', '0', '以下变量可以使用</br>\r\n订单编号：__order_no__\r\n下单者：__user__ \r\n订单金额：__order_amount__\r\n货币单位：__currency_unit__ \r\n下单时间：__create_time__ ', '0');
INSERT INTO `ly_notice_template` VALUES ('3', '下单提醒', 'create_order', 'sms', '', '{\"order_no\":\"__order_no__\",\"user\":\"__user__\",\"order_amount\":\"__order_amount____currency_unit__\",\"time\":\"__create_time__\"}', '', '0', '请务必注意短信下发字数的限制<br/>\r\n订单编号{order_no} 长度20位\r\n用户:{user}\r\n订单金额:{order_amount}\r\n下单时间{time}', '0');
INSERT INTO `ly_notice_template` VALUES ('4', '发货提醒', 'payment_order', 'weixin', '', '{\"touser\":\"__touser__\",\"template_id\":\"__template_id__\",\"topcolor\":\"#0067A6\",\"data\":{\"first\":{\"value\":\"客户已完成支付，请及时发货！\",\"color\":\"#00ABD8\"},\"keyword1\":{\"value\":\"__order_amount____currency_unit__\",\"color\":\"#008972\"},\"keyword2\":{\"value\":\"订单编号(__order_no__)\",\"color\":\"#008972\"},\"keyword3\":{\"value\":\"__accept_name__,__mobile__,__address__\",\"color\":\"#EFC028\"},\"remark\":{\"value\":\"济南泰创软件科技有限公司--祝你生意兴隆!\",\"color\":\"#F2572D\"}}}', '', '0', '在微信模板搜索中搜索“发货提醒”，对应的模板编号为：OPENTM203331384', '0');
INSERT INTO `ly_notice_template` VALUES ('5', '发货提醒', 'payment_order', 'email', '', '<h1>客户已完成付款，请及时发货！</h1>\r\n订单金额：__order_amount____currency_unit__ <br/>\r\n订单编号：__order_no__<br/>\r\n收货信息：__accept_name__,__mobile__,__address__<br/>\r\n济南泰创软件科技公司--祝您生意兴隆！', '', '0', '以下变量可以使用</br>\r\n订单编号：__order_no__\r\n订单金额：__order_amount__\r\n货币单位：__currency_unit__ \r\n收货地址：__address__\r\n收货人：__accept_name__\r\n收货人电话：__mobile__', '0');
INSERT INTO `ly_notice_template` VALUES ('7', '用户咨询提醒', 'user_ask', 'weixin', '', '{\"touser\":\"__touser__\",\"template_id\":\"__template_id__\",\"topcolor\":\"#0067A6\",\"data\":{\"first\":{\"value\":\"你好，你有一条用户咨询待解决!\",\"color\":\"#00ABD8\"},\"keyword1\":{\"value\":\"__user__\",\"color\":\"#008972\"},\"keyword2\":{\"value\":\"__content__\",\"color\":\"#008972\"},\"remark\":{\"value\":\"请尽快处理，提高公司信誉!\",\"color\":\"#F2572D\"}}}', '', '0', '在微信模板搜索中搜索“用户咨询提醒”，对应的模板编号为：OPENTM202119578', '0');
INSERT INTO `ly_notice_template` VALUES ('6', '发货提醒', 'payment_order', 'sms', '', '{\"order_no\":\"__order_no__\",\"order_amount\":\"__order_amount____currency_unit__\",\"time\":\"__pay_time__\"}', '', '0', '请务必注意短信下发字数的限制<br/>\r\n订单编号{order_no} 长度20位\r\n订单金额:{order_amount}\r\n付款时间{time}', '0');
INSERT INTO `ly_notice_template` VALUES ('8', '用户咨询提醒', 'user_ask', 'email', '', '<h1>你好，你有一条用户咨询待解决！</h1>\r\n用户：__user__ <br/>\r\n咨询内容：__content__<br/>\r\n请尽快处理，提高公司信誉!', '', '0', '以下变量可以使用</br>\r\n用户：__user__\r\n咨询内容：__content__\r\n', '0');
INSERT INTO `ly_notice_template` VALUES ('9', '用户咨询提醒', 'user_ask', 'sms', '', '{\"user\":\"__user__\",\"content\":\"__content__\"}', '', '0', '请务必注意短信下发字数的限制<br/>\r\n用户:{user}\r\n咨询内容:{content}', '0');
INSERT INTO `ly_notice_template` VALUES ('10', '后台登录通知', 'admin_login', 'weixin', '', '{\"touser\":\"__touser__\",\"template_id\":\"__template_id__\",\"topcolor\":\"#0067A6\",\"data\":{\"first\":{\"value\":\"帐号__manager__已登录后台\",\"color\":\"#00ABD8\"},\"keyword1\":{\"value\":\"__time__\",\"color\":\"#008972\"},\"keyword2\":{\"value\":\"__login_type__\",\"color\":\"#008972\"},\"keyword3\":{\"value\":\"__ip__\",\"color\":\"#EFC028\"},\"remark\":{\"value\":\"如非公司管理人员操作，请立即访问桌面版修改密码\",\"color\":\"#F2572D\"}}}', '', '0', '在微信模板搜索中搜索“登录通知”，对应的模板编号为：OPENTM217116132', '0');
INSERT INTO `ly_notice_template` VALUES ('11', '后台登录通知', 'admin_login', 'email', '', '<h1>帐号__manager__已登录后台</h1>\r\n登录时间：__time__ <br/>\r\n登录设备：__login_type__<br/>\r\n登录IP：__ip__<br/>\r\n如非公司管理人员操作，请立即访问桌面版修改密码', '', '0', '以下变量可以使用</br>\r\n登录时间：__time__ \r\n登录设备：__login_type__\r\n登录IP：__ip__', '0');
INSERT INTO `ly_notice_template` VALUES ('12', '后台登录通知', 'admin_login', 'sms', '', '{\"manager\":\"__manager__\",\"time\":\"__time__\",\"login_type\":\"__login_type__\",\"ip\":\"__ip__\"}', '', '0', '请务必注意短信下发字数的限制<br/>\r\n管理员:{manager}\r\n登录时间:{time}\r\n登录设备:{login_type}\r\n登录IP:{ip}', '0');
INSERT INTO `ly_notice_template` VALUES ('13', '退款/退货申请提醒', 'refund_application', 'weixin', '', '{\"touser\":\"__touser__\",\"template_id\":\"__template_id__\",\"topcolor\":\"#0067A6\",\"data\":{\"first\":{\"value\":\"买家__user__申请退货\",\"color\":\"#00ABD8\"},\"keyword1\":{\"value\":\"__order_no__\",\"color\":\"#008972\"},\"keyword2\":{\"value\":\"__goods_name__\",\"color\":\"#008972\"},\"keyword3\":{\"value\":\"__order_amount__\",\"color\":\"#EFC028\"},\"remark\":{\"value\":\"请尽快处理用户的退款/退货的申请，提高公司信誉！\",\"color\":\"#F2572D\"}}}', '', '0', '在微信模板搜索中搜索“退货申请提醒”，对应的模板编号为：OPENTM204146731', '0');
INSERT INTO `ly_notice_template` VALUES ('14', '退款/退货申请提醒', 'refund_application', 'email', '', '<h1>买家__user__申请退货</h1>\r\n订单编号：__order_no__ <br/>\r\n商品名称：__goods_name__<br/>\r\n订单金额：__order_amount__<br/>\r\n请尽快处理用户的退款/退货的申请，提高公司信誉！', '', '0', '以下变量可以使用</br>\r\n用户：__user__\r\n订单编号：__order_no__\r\n商品名称：__goods_name__\r\n商品金额：__order_amount__', '0');
INSERT INTO `ly_notice_template` VALUES ('15', '退款/退货申请提醒', 'refund_application', 'sms', '', '{\"user\":\"__user__\",\"order_no\":\"__order_no__\",\"goods_name\":\"__goods_name__\",\"order_amount\":\"__order_amount__\"}', '', '0', '请务必注意短信下发字数的限制<br/>\r\n客户:{user}\r\n订单编号:{order_no}\r\n商品名称:{goods_name}\r\n订单金额:{order_amount}', '0');
INSERT INTO `ly_notice_template` VALUES ('16', '提现申请通知', 'withdrawal_application', 'weixin', '', '{\"touser\":\"__touser__\",\"template_id\":\"__template_id__\",\"topcolor\":\"#0067A6\",\"data\":{\"first\":{\"value\":\"用户申请提现！\",\"color\":\"#00ABD8\"},\"keyword1\":{\"value\":\"__user__\",\"color\":\"#008972\"},\"keyword2\":{\"value\":\"__amount____currency_unit__\",\"color\":\"#008972\"},\"keyword3\":{\"value\":\"__account__\",\"color\":\"#EFC028\"},\"keyword4\":{\"value\":\"账户名/开户名(__name__)\",\"color\":\"#EFC028\"},\"remark\":{\"value\":\"请尽快进行处理!\",\"color\":\"#F2572D\"}}}', '', '0', '在微信模板搜索中搜索“提现申请通知”，对应的模板编号为：OPENTM207277133', '0');
INSERT INTO `ly_notice_template` VALUES ('17', '提现申请通知', 'withdrawal_application', 'email', '', '<h1>用户提现申请！</h1>\r\n用户：__user__ <br/>\r\n申请金额：__amount____currency_unit__<br/>\r\n银行卡号：__account__<br/>\r\n商户号：__name__<br/>\r\n请尽快处理用户的退款/退货的申请，提高公司信誉！', '', '0', '以下变量可以使用</br>\r\n用户：__user__\r\n银行卡号：__account__\r\n商户号：__name__\r\n申请金额：__amount__', '0');
INSERT INTO `ly_notice_template` VALUES ('18', '提现申请通知', 'withdrawal_application', 'sms', '', '{\"user\":\"__user__\",\"amount\":\"__amount__\",\"account\":\"__account__\",\"name\":\"__name__\"}', '', '0', '请务必注意短信下发字数的限制<br/>\r\n客户:{user}\r\n商户号:{name}\r\n银行卡号:{account}\r\n申请金额:{amount}', '0');
INSERT INTO `ly_notice_template` VALUES ('19', '下单提醒', 'create_order', 'sms', '', '{\"order_no\":\"__order_no__\",\"order_amount\":\"__order_amount____currency_unit__\",\"time\":\"__create_time__\"}', null, '0', '订单编号{order_no} 长度20位 订单金额:{order_amount} 下单时间{time}', '1');
INSERT INTO `ly_notice_template` VALUES ('20', '发货提醒', 'order_send', 'sms', '', '{\"order_no\":\"__order_no__\",\"express_name\":\"__express_name__\",\"express_number\":\"__express_number__\"}', null, '0', '请务必注意短信下发字数的限制<br/>\r\n订单编号{order_no} 长度20位\r\n快递公司:{express_name}\r\n快递单号{express_number}\r\n', '1');
INSERT INTO `ly_notice_template` VALUES ('21', '退款/退货处理提醒', 'refund_action', 'sms', '', '{\"order_no\":\"__order_no__\",\"status\":\"__status__\"}', null, '0', '请务必注意短信下发字数的限制<br/>\r\n申请提现的金额{amount} \r\n处理状态(通过，未通过):{status}\r\n', '1');
INSERT INTO `ly_notice_template` VALUES ('22', '提现处理提醒', 'withdrawal_action', 'sms', '', '{\"amount\":\"__amount__\",\"status\":\"__status__\"}', null, '0', '请务必注意短信下发字数的限制<br/>\r\n申请提现的金额{amount} \r\n处理状态(通过，未通过):{status}\r\n', '1');

-- ----------------------------
-- Table structure for `ly_notify`
-- ----------------------------
DROP TABLE IF EXISTS `ly_notify`;
CREATE TABLE `ly_notify` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `register_time` datetime DEFAULT NULL,
  `notify_time` datetime DEFAULT NULL,
  `notify_status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_notify
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_oauth`
-- ----------------------------
DROP TABLE IF EXISTS `ly_oauth`;
CREATE TABLE `ly_oauth` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `class_name` varchar(20) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `app_key` varchar(32) DEFAULT NULL,
  `app_secret` varchar(50) DEFAULT NULL,
  `authorize` varchar(255) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_oauth
-- ----------------------------
INSERT INTO `ly_oauth` VALUES ('1', 'QQ', 'QqOAuth', 'qq.png', '', '', 'scope=get_user_info,add_share', '0', '5');
INSERT INTO `ly_oauth` VALUES ('2', '人人', 'RenrenOAuth', 'renren.png', '', '', null, '0', '0');
INSERT INTO `ly_oauth` VALUES ('3', '微博', 'SinaOAuth', 'weibo.png', '', '', null, '0', '3');
INSERT INTO `ly_oauth` VALUES ('5', '微信', 'WeixinOAuth', 'weixin.png', '', '', null, '0', '4');
INSERT INTO `ly_oauth` VALUES ('6', '豆瓣', 'DoubanOAuth', 'douban.png', '', '', null, '0', '2');

-- ----------------------------
-- Table structure for `ly_oauth_user`
-- ----------------------------
DROP TABLE IF EXISTS `ly_oauth_user`;
CREATE TABLE `ly_oauth_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `oauth_type` enum('QqOAuth','SinaOAuth','RenrenOAuth','WeixinOAuth','DoubanOAuth') DEFAULT NULL,
  `open_id` varchar(32) DEFAULT NULL,
  `union_id` varchar(32) DEFAULT NULL,
  `open_name` varchar(20) DEFAULT NULL,
  `token` varchar(128) DEFAULT NULL,
  `post_time` varchar(10) DEFAULT NULL,
  `expires` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_oauth_user
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_order`
-- ----------------------------
DROP TABLE IF EXISTS `ly_order`;
CREATE TABLE `ly_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `pay_code` varchar(255) DEFAULT NULL,
  `payment` bigint(20) NOT NULL,
  `express` bigint(20) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `pay_status` tinyint(1) DEFAULT '0',
  `delivery_status` tinyint(1) DEFAULT '0',
  `accept_name` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `province` bigint(20) DEFAULT NULL,
  `city` bigint(20) DEFAULT NULL,
  `county` bigint(20) DEFAULT NULL,
  `addr` varchar(250) DEFAULT NULL,
  `zip` varchar(6) DEFAULT NULL,
  `payable_amount` float(10,2) DEFAULT NULL,
  `real_amount` float(10,2) DEFAULT '0.00',
  `payable_freight` float(10,2) DEFAULT '0.00',
  `real_freight` float(10,2) DEFAULT '0.00',
  `pay_time` datetime DEFAULT NULL,
  `send_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `completion_time` datetime DEFAULT NULL,
  `user_remark` varchar(255) DEFAULT NULL,
  `admin_remark` varchar(255) DEFAULT NULL,
  `handling_fee` float(10,2) DEFAULT '0.00',
  `is_invoice` tinyint(1) DEFAULT '0',
  `invoice_title` varchar(100) DEFAULT NULL,
  `taxes` float(10,2) DEFAULT '0.00',
  `prom_id` bigint(20) DEFAULT '0',
  `prom` text,
  `discount_amount` float(10,2) DEFAULT '0.00',
  `adjust_amount` float(10,2) DEFAULT '0.00',
  `adjust_note` varchar(255) DEFAULT NULL,
  `order_amount` float(10,2) DEFAULT '0.00',
  `is_print` varchar(255) DEFAULT NULL,
  `accept_time` varchar(80) DEFAULT NULL,
  `point` int(5) unsigned DEFAULT '0',
  `voucher_id` bigint(20) DEFAULT '0',
  `voucher` text,
  `type` int(4) unsigned DEFAULT '0',
  `trading_info` varchar(255) DEFAULT NULL,
  `is_del` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_order
-- ----------------------------
INSERT INTO `ly_order` VALUES ('3', '20170518214859824246', '5', null, '1', null, '3', '1', '0', '陆伟', '13642779418', '13642779418', '430000', '430900', '430902', '湖南城市学院', '413000', '55.00', '55.00', '10.00', '10.00', '2017-05-18 21:49:08', null, '2017-05-18 21:48:59', null, '', null, '0.00', '0', '', '0.00', '0', null, '0.00', '0.00', null, '65.00', null, null, '0', '0', 'a:0:{}', '0', '', '0');

-- ----------------------------
-- Table structure for `ly_order_goods`
-- ----------------------------
DROP TABLE IF EXISTS `ly_order_goods`;
CREATE TABLE `ly_order_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) DEFAULT NULL,
  `goods_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `goods_price` float(10,2) DEFAULT '0.00',
  `real_price` float(10,2) DEFAULT '0.00',
  `goods_nums` int(11) DEFAULT '1',
  `goods_weight` float DEFAULT '0',
  `shipments` int(11) DEFAULT '0',
  `prom_goods` text,
  `spec` text,
  `goods_type` int(2) DEFAULT '0',
  `virtual_extend` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_order_goods
-- ----------------------------
INSERT INTO `ly_order_goods` VALUES ('3', '3', '17', '68', '55.00', '55.00', '1', '200', '0', 'a:3:{s:10:\"real_price\";s:5:\"55.00\";s:4:\"note\";s:0:\"\";s:5:\"minus\";s:2:\"-0\";}', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"45\";i:1;s:1:\"L\";i:2;s:1:\"L\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '0', '');

-- ----------------------------
-- Table structure for `ly_order_log`
-- ----------------------------
DROP TABLE IF EXISTS `ly_order_log`;
CREATE TABLE `ly_order_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `user` varchar(20) DEFAULT NULL,
  `action` varchar(20) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `result` varchar(10) DEFAULT NULL,
  `note` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_order_log
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_payment`
-- ----------------------------
DROP TABLE IF EXISTS `ly_payment`;
CREATE TABLE `ly_payment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `plugin_id` varchar(32) NOT NULL,
  `pay_name` varchar(100) NOT NULL,
  `config` text,
  `client_type` int(1) DEFAULT '0',
  `description` text,
  `note` text,
  `pay_fee` float(10,2) DEFAULT '0.00',
  `fee_type` tinyint(1) DEFAULT '0',
  `sort` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_payment
-- ----------------------------
INSERT INTO `ly_payment` VALUES ('1', '1', '预存款支付', 'a:2:{s:10:\"partner_id\";s:8:\"12312312\";s:11:\"partner_key\";s:9:\"213213213\";}', '0', '预存款是客户在您网站上的虚拟资金帐户。', '', '0.05', '1', '1', '0');

-- ----------------------------
-- Table structure for `ly_pay_plugin`
-- ----------------------------
DROP TABLE IF EXISTS `ly_pay_plugin`;
CREATE TABLE `ly_pay_plugin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `class_name` varchar(30) NOT NULL,
  `description` text,
  `logo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_pay_plugin
-- ----------------------------
INSERT INTO `ly_pay_plugin` VALUES ('1', '预存款支付', 'balance', '预存款是客户在您网站上的虚拟资金帐户。', '/payments/logos/pay_deposit.gif');
INSERT INTO `ly_pay_plugin` VALUES ('5', '腾讯财付通', 'tenpay', '费率最低至<span style=\"color: #FF0000;font-weight: bold;\">0.61%</span>，并赠送价值千元企业QQ <a style=\"color:blue\" href=\"http://union.tenpay.com/mch/mch_register.shtml\" target=\"_blank\">立即申请</a>', '/payments/logos/pay_tenpay.gif');
INSERT INTO `ly_pay_plugin` VALUES ('2', '支付宝[担保交易]', 'alipaytrad', '淘宝买家最熟悉的付款方式：买家先将交易资金存入支付宝并通知卖家发货，买家确认收货后资金自动进入卖家支付宝账户，完成交易 <a style=\"color:blue\" href=\"https://b.alipay.com/order/productDetail.htm?productId=2012111200373121\" target=\"_blank\">立即申请</a>', '/payments/logos/pay_alipaytrad.gif');
INSERT INTO `ly_pay_plugin` VALUES ('3', '支付宝[双向接口]', 'alipay', '买家付款时，可选择担保交易或即时到账中的任一支付方式进行付款，完成交易。<a style=\"color:blue\" href=\"https://b.alipay.com/order/productDetail.htm?productId=2012111300373136\" target=\"_blank\">立即申请</a>', '/payments/logos/pay_alipay.gif');
INSERT INTO `ly_pay_plugin` VALUES ('6', 'PayPal', 'paypal', 'PayPal 是全球最大的在线支付平台，同时也是目前全球贸易网上支付标准。', '/payments/logos/pay_paypal.gif');
INSERT INTO `ly_pay_plugin` VALUES ('4', '支付宝[即时到帐]', 'alipaydirect', '网上交易时，买家的交易资金直接打入卖家支付宝账户，快速回笼交易资金。 <a style=\"color:blue\" href=\"https://b.alipay.com/order/productDetail.htm?productId=2012111200373124\" target=\"_blank\">立即申请</a>', '/payments/logos/pay_alipay.gif');
INSERT INTO `ly_pay_plugin` VALUES ('7', '货到付款', 'received', '客户收到商品时，再进行付款，让客户更放心。', '/payments/logos/pay_received.gif');
INSERT INTO `ly_pay_plugin` VALUES ('8', '支付宝[银行支付]', 'alipaygateway', null, '/payments/logos/pay_alipay.gif');
INSERT INTO `ly_pay_plugin` VALUES ('11', '银联支付', 'unionpay', '银联在线支付网关是中国银联联合各商业银行为持卡人提供的集成化、综合性互联网支付工具，主要支持输入卡号付款、用户登录支付、网银支付、迷你付（IC卡支付）等多种支付方式，为持卡人提供境内外网上购物、水电煤缴费、商旅预订等支付服务。\r\n<a style=\"color:red\" href=\"https://open.unionpay.com\" target=\"_blank\">立即申请</a>', '/payments/logos/pay_unionpay.png');

-- ----------------------------
-- Table structure for `ly_point_log`
-- ----------------------------
DROP TABLE IF EXISTS `ly_point_log`;
CREATE TABLE `ly_point_log` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `value` int(11) NOT NULL,
  `point` int(11) DEFAULT NULL,
  `note` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_point_log
-- ----------------------------
INSERT INTO `ly_point_log` VALUES ('1', '1', '2014-05-07 08:17:14', '0', '0', '购买商品，订单：20140507081045407397 赠送0积分');
INSERT INTO `ly_point_log` VALUES ('2', '1', '2014-05-07 08:21:12', '0', '0', '购买商品，订单：20140507082103484548 赠送0积分');

-- ----------------------------
-- Table structure for `ly_products`
-- ----------------------------
DROP TABLE IF EXISTS `ly_products`;
CREATE TABLE `ly_products` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(20) NOT NULL,
  `pro_no` varchar(20) DEFAULT NULL,
  `spec` text,
  `store_nums` int(11) DEFAULT '0',
  `warning_line` int(11) DEFAULT '0',
  `market_price` float(10,2) DEFAULT '0.00',
  `sell_price` float(10,2) DEFAULT '0.00',
  `cost_price` float(10,2) DEFAULT '0.00',
  `weight` int(11) DEFAULT NULL,
  `specs_key` varchar(255) DEFAULT NULL,
  `goods_type` int(2) DEFAULT NULL,
  `virtual_extend` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `GOODS_ID` (`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=155 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_products
-- ----------------------------
INSERT INTO `ly_products` VALUES ('19', '7', 'X20140120567_1', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"1\";i:1;s:19:\"安卓（Android）\";i:2;s:19:\"安卓（Android）\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '1999.00', '1799.00', '1799.00', '300', ';1:1;2:5;', null, null);
INSERT INTO `ly_products` VALUES ('18', '6', 'AG0012320_3', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"3\";i:1;s:15:\"苹果（IOS）\";i:2;s:18:\"苹果（IOS）16G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"8\";i:1;s:6:\"金色\";i:2;s:6:\"金色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '5000.00', '4898.00', '4700.00', '300', ';1:3;2:8;', null, null);
INSERT INTO `ly_products` VALUES ('17', '6', 'AG0012320_2', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"3\";i:1;s:15:\"苹果（IOS）\";i:2;s:18:\"苹果（IOS）16G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '5000.00', '4898.00', '4700.00', '300', ';1:3;2:5;', null, null);
INSERT INTO `ly_products` VALUES ('16', '6', 'AG0012320_1', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"3\";i:1;s:15:\"苹果（IOS）\";i:2;s:18:\"苹果（IOS）16G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '5000.00', '4898.00', '4700.00', '300', ';1:3;2:7;', null, null);
INSERT INTO `ly_products` VALUES ('20', '7', 'X20140120567_2', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"1\";i:1;s:19:\"安卓（Android）\";i:2;s:19:\"安卓（Android）\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '1999.00', '1799.00', '1799.00', '300', ';1:1;2:11;', null, null);
INSERT INTO `ly_products` VALUES ('21', '7', 'X20140120567_3', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"1\";i:1;s:19:\"安卓（Android）\";i:2;s:19:\"安卓（Android）\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"6\";i:1;s:6:\"黑色\";i:2;s:6:\"黑色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '1999.00', '1799.00', '1799.00', '300', ';1:1;2:6;', null, null);
INSERT INTO `ly_products` VALUES ('22', '8', 'SX201401023465_1', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"1\";i:1;s:19:\"安卓（Android）\";i:2;s:19:\"安卓（Android）\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '5399.00', '5299.00', '5200.00', '300', ';1:1;2:5;', null, null);
INSERT INTO `ly_products` VALUES ('23', '8', 'SX201401023465_2', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"1\";i:1;s:19:\"安卓（Android）\";i:2;s:19:\"安卓（Android）\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"6\";i:1;s:6:\"黑色\";i:2;s:6:\"黑色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '5399.00', '5299.00', '5200.00', '300', ';1:1;2:6;', null, null);
INSERT INTO `ly_products` VALUES ('27', '10', 'L20140203432', 'a:0:{}', '23', '3', '16799.00', '16699.00', '16000.00', '3405', '', null, null);
INSERT INTO `ly_products` VALUES ('25', '9', 'M20140102654_1', 'a:1:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '6388.00', '6288.00', '6200.00', '1080', ';2:7;', null, null);
INSERT INTO `ly_products` VALUES ('26', '9', 'M20140102654_2', 'a:1:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '6388.00', '6288.00', '6200.00', '1080', ';2:5;', null, null);
INSERT INTO `ly_products` VALUES ('28', '11', 'AP20140101787_1', 'a:1:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '9298.00', '9288.00', '9200.00', '1570', ';2:7;', null, null);
INSERT INTO `ly_products` VALUES ('29', '11', 'AP20140101787_2', 'a:1:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '9298.00', '9288.00', '9200.00', '1570', ';2:5;', null, null);
INSERT INTO `ly_products` VALUES ('30', '12', 'AP20140101788_1', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"3\";i:1;s:15:\"苹果（IOS）\";i:2;s:18:\"苹果（IOS）16G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '3899.00', '3367.00', '3367.00', '300', ';1:3;2:5;', null, null);
INSERT INTO `ly_products` VALUES ('31', '12', 'AP20140101788_2', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"3\";i:1;s:15:\"苹果（IOS）\";i:2;s:18:\"苹果（IOS）16G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"12\";i:1;s:6:\"粉色\";i:2;s:6:\"粉色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '3899.00', '3367.00', '3367.00', '300', ';1:3;2:12;', null, null);
INSERT INTO `ly_products` VALUES ('32', '12', 'AP20140101788_3', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"3\";i:1;s:15:\"苹果（IOS）\";i:2;s:18:\"苹果（IOS）16G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '3899.00', '3367.00', '3367.00', '300', ';1:3;2:10;', null, null);
INSERT INTO `ly_products` VALUES ('33', '12', 'AP20140101788_4', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"3\";i:1;s:15:\"苹果（IOS）\";i:2;s:18:\"苹果（IOS）16G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"14\";i:1;s:6:\"绿色\";i:2;s:6:\"绿色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '3899.00', '3367.00', '3367.00', '300', ';1:3;2:14;', null, null);
INSERT INTO `ly_products` VALUES ('34', '12', 'AP20140101788_5', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"3\";i:1;s:15:\"苹果（IOS）\";i:2;s:18:\"苹果（IOS）16G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '3899.00', '3367.00', '3367.00', '300', ';1:3;2:11;', null, null);
INSERT INTO `ly_products` VALUES ('35', '12', 'AP20140101788_6', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"3\";i:1;s:15:\"苹果（IOS）\";i:2;s:18:\"苹果（IOS）16G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"13\";i:1;s:6:\"黄色\";i:2;s:6:\"黄色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '3899.00', '3367.00', '3367.00', '300', ';1:3;2:13;', null, null);
INSERT INTO `ly_products` VALUES ('36', '13', 'AP20140101786_1', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"3\";i:1;s:15:\"苹果（IOS）\";i:2;s:17:\"苹果（IOS）8G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '3488.00', '2479.00', '2479.00', '400', ';1:3;2:5;', null, null);
INSERT INTO `ly_products` VALUES ('37', '13', 'AP20140101786_2', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"3\";i:1;s:15:\"苹果（IOS）\";i:2;s:17:\"苹果（IOS）8G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"6\";i:1;s:6:\"黑色\";i:2;s:6:\"黑色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '3488.00', '2479.00', '2479.00', '400', ';1:3;2:6;', null, null);
INSERT INTO `ly_products` VALUES ('38', '14', 'X20140120566_1', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"1\";i:1;s:19:\"安卓（Android）\";i:2;s:19:\"安卓（Android）\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '1499.00', '1299.00', '1299.00', '400', ';1:1;2:5;', null, null);
INSERT INTO `ly_products` VALUES ('39', '14', 'X20140120566_2', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"1\";i:1;s:19:\"安卓（Android）\";i:2;s:19:\"安卓（Android）\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"16\";i:1;s:6:\"紫色\";i:2;s:6:\"紫色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '1499.00', '1299.00', '1299.00', '400', ';1:1;2:16;', null, null);
INSERT INTO `ly_products` VALUES ('40', '14', 'X20140120566_3', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"1\";i:1;s:19:\"安卓（Android）\";i:2;s:19:\"安卓（Android）\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '1499.00', '1299.00', '1299.00', '400', ';1:1;2:10;', null, null);
INSERT INTO `ly_products` VALUES ('41', '14', 'X20140120566_4', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"1\";i:1;s:19:\"安卓（Android）\";i:2;s:19:\"安卓（Android）\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"14\";i:1;s:6:\"绿色\";i:2;s:6:\"绿色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '1499.00', '1299.00', '1299.00', '400', ';1:1;2:14;', null, null);
INSERT INTO `ly_products` VALUES ('42', '14', 'X20140120566_5', 'a:2:{i:1;a:6:{s:2:\"id\";s:1:\"1\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:1:\"1\";i:1;s:19:\"安卓（Android）\";i:2;s:19:\"安卓（Android）\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"手机\";s:6:\"is_del\";s:1:\"0\";}i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '1499.00', '1299.00', '1299.00', '400', ';1:1;2:11;', null, null);
INSERT INTO `ly_products` VALUES ('43', '15', 'AP20140101785_1', 'a:4:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:3;a:6:{s:2:\"id\";s:1:\"3\";s:4:\"name\";s:6:\"硬盘\";s:5:\"value\";a:4:{i:0;s:2:\"20\";i:1;s:3:\"16G\";i:2;s:3:\"16G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"平板\";s:6:\"is_del\";s:1:\"0\";}i:4;a:6:{s:2:\"id\";s:1:\"4\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:2:\"27\";i:1;s:9:\"ios系统\";i:2;s:9:\"ios系统\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"常用\";s:6:\"is_del\";s:1:\"0\";}i:5;a:6:{s:2:\"id\";s:1:\"5\";s:4:\"name\";s:6:\"尺寸\";s:5:\"value\";a:4:{i:0;s:2:\"37\";i:1;s:9:\"9.7英寸\";i:2;s:9:\"9.7英寸\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"平台\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '3900.00', '3399.00', '3399.00', '700', ';2:7;3:20;4:27;5:37;', null, null);
INSERT INTO `ly_products` VALUES ('44', '15', 'AP20140101785_2', 'a:4:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:3;a:6:{s:2:\"id\";s:1:\"3\";s:4:\"name\";s:6:\"硬盘\";s:5:\"value\";a:4:{i:0;s:2:\"21\";i:1;s:3:\"32G\";i:2;s:3:\"32G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"平板\";s:6:\"is_del\";s:1:\"0\";}i:4;a:6:{s:2:\"id\";s:1:\"4\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:2:\"27\";i:1;s:9:\"ios系统\";i:2;s:9:\"ios系统\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"常用\";s:6:\"is_del\";s:1:\"0\";}i:5;a:6:{s:2:\"id\";s:1:\"5\";s:4:\"name\";s:6:\"尺寸\";s:5:\"value\";a:4:{i:0;s:2:\"37\";i:1;s:9:\"9.7英寸\";i:2;s:9:\"9.7英寸\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"平台\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '4900.00', '3999.00', '3999.00', '700', ';2:7;3:21;4:27;5:37;', null, null);
INSERT INTO `ly_products` VALUES ('45', '15', 'AP20140101785_3', 'a:4:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:3;a:6:{s:2:\"id\";s:1:\"3\";s:4:\"name\";s:6:\"硬盘\";s:5:\"value\";a:4:{i:0;s:2:\"20\";i:1;s:3:\"16G\";i:2;s:3:\"16G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"平板\";s:6:\"is_del\";s:1:\"0\";}i:4;a:6:{s:2:\"id\";s:1:\"4\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:2:\"27\";i:1;s:9:\"ios系统\";i:2;s:9:\"ios系统\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"常用\";s:6:\"is_del\";s:1:\"0\";}i:5;a:6:{s:2:\"id\";s:1:\"5\";s:4:\"name\";s:6:\"尺寸\";s:5:\"value\";a:4:{i:0;s:2:\"37\";i:1;s:9:\"9.7英寸\";i:2;s:9:\"9.7英寸\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"平台\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '3900.00', '3399.00', '3399.00', '700', ';2:5;3:20;4:27;5:37;', null, null);
INSERT INTO `ly_products` VALUES ('46', '15', 'AP20140101785_4', 'a:4:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:3;a:6:{s:2:\"id\";s:1:\"3\";s:4:\"name\";s:6:\"硬盘\";s:5:\"value\";a:4:{i:0;s:2:\"21\";i:1;s:3:\"32G\";i:2;s:3:\"32G\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"平板\";s:6:\"is_del\";s:1:\"0\";}i:4;a:6:{s:2:\"id\";s:1:\"4\";s:4:\"name\";s:6:\"系统\";s:5:\"value\";a:4:{i:0;s:2:\"27\";i:1;s:9:\"ios系统\";i:2;s:9:\"ios系统\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"常用\";s:6:\"is_del\";s:1:\"0\";}i:5;a:6:{s:2:\"id\";s:1:\"5\";s:4:\"name\";s:6:\"尺寸\";s:5:\"value\";a:4:{i:0;s:2:\"37\";i:1;s:9:\"9.7英寸\";i:2;s:9:\"9.7英寸\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"平台\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '4900.00', '3999.00', '3999.00', '700', ';2:5;3:21;4:27;5:37;', null, null);
INSERT INTO `ly_products` VALUES ('47', '16', 'NS20140504123_1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"12\";i:1;s:6:\"粉色\";i:2;s:6:\"粉色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"43\";i:1;s:1:\"S\";i:2;s:1:\"S\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:12;6:43;', '0', '');
INSERT INTO `ly_products` VALUES ('48', '16', 'NS20140504123_2', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"12\";i:1;s:6:\"粉色\";i:2;s:6:\"粉色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"46\";i:1;s:2:\"XL\";i:2;s:2:\"XL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:12;6:46;', '0', '');
INSERT INTO `ly_products` VALUES ('49', '16', 'NS20140504123_3', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"12\";i:1;s:6:\"粉色\";i:2;s:6:\"粉色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"47\";i:1;s:3:\"XXL\";i:2;s:3:\"XXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:12;6:47;', '0', '');
INSERT INTO `ly_products` VALUES ('50', '16', 'NS20140504123_4', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"12\";i:1;s:6:\"粉色\";i:2;s:6:\"粉色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"48\";i:1;s:4:\"XXXL\";i:2;s:4:\"XXXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:12;6:48;', '0', '');
INSERT INTO `ly_products` VALUES ('51', '16', 'NS20140504123_5', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"16\";i:1;s:6:\"紫色\";i:2;s:6:\"紫色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"43\";i:1;s:1:\"S\";i:2;s:1:\"S\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:16;6:43;', '0', '');
INSERT INTO `ly_products` VALUES ('52', '16', 'NS20140504123_6', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"16\";i:1;s:6:\"紫色\";i:2;s:6:\"紫色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"46\";i:1;s:2:\"XL\";i:2;s:2:\"XL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:16;6:46;', '0', '');
INSERT INTO `ly_products` VALUES ('53', '16', 'NS20140504123_7', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"16\";i:1;s:6:\"紫色\";i:2;s:6:\"紫色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"47\";i:1;s:3:\"XXL\";i:2;s:3:\"XXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:16;6:47;', '0', '');
INSERT INTO `ly_products` VALUES ('54', '16', 'NS20140504123_8', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"16\";i:1;s:6:\"紫色\";i:2;s:6:\"紫色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"48\";i:1;s:4:\"XXXL\";i:2;s:4:\"XXXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:16;6:48;', '0', '');
INSERT INTO `ly_products` VALUES ('55', '16', 'NS20140504123_9', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"43\";i:1;s:1:\"S\";i:2;s:1:\"S\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '11', '2', '199.00', '49.00', '40.00', '200', ';2:10;6:43;', '0', '');
INSERT INTO `ly_products` VALUES ('56', '16', 'NS20140504123_10', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"46\";i:1;s:2:\"XL\";i:2;s:2:\"XL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:10;6:46;', '0', '');
INSERT INTO `ly_products` VALUES ('57', '16', 'NS20140504123_11', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"47\";i:1;s:3:\"XXL\";i:2;s:3:\"XXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:10;6:47;', '0', '');
INSERT INTO `ly_products` VALUES ('58', '16', 'NS20140504123_12', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"48\";i:1;s:4:\"XXXL\";i:2;s:4:\"XXXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:10;6:48;', '0', '');
INSERT INTO `ly_products` VALUES ('59', '16', 'NS20140504123_13', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"14\";i:1;s:6:\"绿色\";i:2;s:6:\"绿色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"43\";i:1;s:1:\"S\";i:2;s:1:\"S\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:14;6:43;', '0', '');
INSERT INTO `ly_products` VALUES ('60', '16', 'NS20140504123_14', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"14\";i:1;s:6:\"绿色\";i:2;s:6:\"绿色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"46\";i:1;s:2:\"XL\";i:2;s:2:\"XL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:14;6:46;', '0', '');
INSERT INTO `ly_products` VALUES ('61', '16', 'NS20140504123_15', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"14\";i:1;s:6:\"绿色\";i:2;s:6:\"绿色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"47\";i:1;s:3:\"XXL\";i:2;s:3:\"XXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:14;6:47;', '0', '');
INSERT INTO `ly_products` VALUES ('62', '16', 'NS20140504123_16', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"14\";i:1;s:6:\"绿色\";i:2;s:6:\"绿色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"48\";i:1;s:4:\"XXXL\";i:2;s:4:\"XXXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '199.00', '49.00', '40.00', '200', ';2:14;6:48;', '0', '');
INSERT INTO `ly_products` VALUES ('63', '17', 'NS20140504121_1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"45\";i:1;s:1:\"L\";i:2;s:1:\"L\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '21', '2', '110.00', '55.00', '50.00', '200', ';2:7;6:45;', '0', '');
INSERT INTO `ly_products` VALUES ('64', '17', 'NS20140504121_2', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"43\";i:1;s:1:\"S\";i:2;s:1:\"S\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '110.00', '55.00', '50.00', '200', ';2:7;6:43;', '0', '');
INSERT INTO `ly_products` VALUES ('65', '17', 'NS20140504121_3', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"46\";i:1;s:2:\"XL\";i:2;s:2:\"XL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '110.00', '55.00', '50.00', '200', ';2:7;6:46;', '0', '');
INSERT INTO `ly_products` VALUES ('66', '17', 'NS20140504121_4', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"47\";i:1;s:3:\"XXL\";i:2;s:3:\"XXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '110.00', '55.00', '50.00', '200', ';2:7;6:47;', '0', '');
INSERT INTO `ly_products` VALUES ('67', '17', 'NS20140504121_5', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"48\";i:1;s:4:\"XXXL\";i:2;s:4:\"XXXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '110.00', '55.00', '50.00', '200', ';2:7;6:48;', '0', '');
INSERT INTO `ly_products` VALUES ('68', '17', 'NS20140504121_6', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"45\";i:1;s:1:\"L\";i:2;s:1:\"L\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '21', '2', '110.00', '55.00', '50.00', '200', ';2:5;6:45;', '0', '');
INSERT INTO `ly_products` VALUES ('69', '17', 'NS20140504121_7', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"43\";i:1;s:1:\"S\";i:2;s:1:\"S\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '110.00', '55.00', '50.00', '200', ';2:5;6:43;', '0', '');
INSERT INTO `ly_products` VALUES ('70', '17', 'NS20140504121_8', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"46\";i:1;s:2:\"XL\";i:2;s:2:\"XL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '110.00', '55.00', '50.00', '200', ';2:5;6:46;', '0', '');
INSERT INTO `ly_products` VALUES ('71', '17', 'NS20140504121_9', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"47\";i:1;s:3:\"XXL\";i:2;s:3:\"XXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '110.00', '55.00', '50.00', '200', ';2:5;6:47;', '0', '');
INSERT INTO `ly_products` VALUES ('72', '17', 'NS20140504121_10', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"48\";i:1;s:4:\"XXXL\";i:2;s:4:\"XXXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '110.00', '55.00', '50.00', '200', ';2:5;6:48;', '0', '');
INSERT INTO `ly_products` VALUES ('73', '18', 'NS20140504122_1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"45\";i:1;s:1:\"L\";i:2;s:1:\"L\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:7;6:45;', '0', '');
INSERT INTO `ly_products` VALUES ('74', '18', 'NS20140504122_2', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"44\";i:1;s:1:\"M\";i:2;s:1:\"M\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:7;6:44;', '0', '');
INSERT INTO `ly_products` VALUES ('75', '18', 'NS20140504122_3', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"43\";i:1;s:1:\"S\";i:2;s:1:\"S\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:7;6:43;', '0', '');
INSERT INTO `ly_products` VALUES ('76', '18', 'NS20140504122_4', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"46\";i:1;s:2:\"XL\";i:2;s:2:\"XL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:7;6:46;', '0', '');
INSERT INTO `ly_products` VALUES ('77', '18', 'NS20140504122_5', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"42\";i:1;s:2:\"XS\";i:2;s:2:\"XS\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:7;6:42;', '0', '');
INSERT INTO `ly_products` VALUES ('78', '18', 'NS20140504122_6', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"47\";i:1;s:3:\"XXL\";i:2;s:3:\"XXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:7;6:47;', '0', '');
INSERT INTO `ly_products` VALUES ('79', '18', 'NS20140504122_7', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"7\";i:1;s:6:\"灰色\";i:2;s:6:\"灰色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"48\";i:1;s:4:\"XXXL\";i:2;s:4:\"XXXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:7;6:48;', '0', '');
INSERT INTO `ly_products` VALUES ('80', '18', 'NS20140504122_8', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"45\";i:1;s:1:\"L\";i:2;s:1:\"L\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:5;6:45;', '0', '');
INSERT INTO `ly_products` VALUES ('81', '18', 'NS20140504122_9', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"44\";i:1;s:1:\"M\";i:2;s:1:\"M\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:5;6:44;', '0', '');
INSERT INTO `ly_products` VALUES ('82', '18', 'NS20140504122_10', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"43\";i:1;s:1:\"S\";i:2;s:1:\"S\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:5;6:43;', '0', '');
INSERT INTO `ly_products` VALUES ('83', '18', 'NS20140504122_11', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"46\";i:1;s:2:\"XL\";i:2;s:2:\"XL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:5;6:46;', '0', '');
INSERT INTO `ly_products` VALUES ('84', '18', 'NS20140504122_12', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"42\";i:1;s:2:\"XS\";i:2;s:2:\"XS\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:5;6:42;', '0', '');
INSERT INTO `ly_products` VALUES ('85', '18', 'NS20140504122_13', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"47\";i:1;s:3:\"XXL\";i:2;s:3:\"XXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:5;6:47;', '0', '');
INSERT INTO `ly_products` VALUES ('86', '18', 'NS20140504122_14', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"48\";i:1;s:4:\"XXXL\";i:2;s:4:\"XXXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:5;6:48;', '0', '');
INSERT INTO `ly_products` VALUES ('87', '18', 'NS20140504122_15', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"45\";i:1;s:1:\"L\";i:2;s:1:\"L\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:10;6:45;', '0', '');
INSERT INTO `ly_products` VALUES ('88', '18', 'NS20140504122_16', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"44\";i:1;s:1:\"M\";i:2;s:1:\"M\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:10;6:44;', '0', '');
INSERT INTO `ly_products` VALUES ('89', '18', 'NS20140504122_17', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"43\";i:1;s:1:\"S\";i:2;s:1:\"S\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:10;6:43;', '0', '');
INSERT INTO `ly_products` VALUES ('90', '18', 'NS20140504122_18', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"46\";i:1;s:2:\"XL\";i:2;s:2:\"XL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:10;6:46;', '0', '');
INSERT INTO `ly_products` VALUES ('91', '18', 'NS20140504122_19', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"42\";i:1;s:2:\"XS\";i:2;s:2:\"XS\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:10;6:42;', '0', '');
INSERT INTO `ly_products` VALUES ('92', '18', 'NS20140504122_20', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"47\";i:1;s:3:\"XXL\";i:2;s:3:\"XXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:10;6:47;', '0', '');
INSERT INTO `ly_products` VALUES ('93', '18', 'NS20140504122_21', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"48\";i:1;s:4:\"XXXL\";i:2;s:4:\"XXXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:10;6:48;', '0', '');
INSERT INTO `ly_products` VALUES ('94', '18', 'NS20140504122_22', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"6\";i:1;s:6:\"黑色\";i:2;s:6:\"黑色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"45\";i:1;s:1:\"L\";i:2;s:1:\"L\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:6;6:45;', '0', '');
INSERT INTO `ly_products` VALUES ('95', '18', 'NS20140504122_23', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"6\";i:1;s:6:\"黑色\";i:2;s:6:\"黑色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"44\";i:1;s:1:\"M\";i:2;s:1:\"M\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:6;6:44;', '0', '');
INSERT INTO `ly_products` VALUES ('96', '18', 'NS20140504122_24', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"6\";i:1;s:6:\"黑色\";i:2;s:6:\"黑色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"43\";i:1;s:1:\"S\";i:2;s:1:\"S\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:6;6:43;', '0', '');
INSERT INTO `ly_products` VALUES ('97', '18', 'NS20140504122_25', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"6\";i:1;s:6:\"黑色\";i:2;s:6:\"黑色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"46\";i:1;s:2:\"XL\";i:2;s:2:\"XL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:6;6:46;', '0', '');
INSERT INTO `ly_products` VALUES ('98', '18', 'NS20140504122_26', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"6\";i:1;s:6:\"黑色\";i:2;s:6:\"黑色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"42\";i:1;s:2:\"XS\";i:2;s:2:\"XS\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:6;6:42;', '0', '');
INSERT INTO `ly_products` VALUES ('99', '18', 'NS20140504122_27', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"6\";i:1;s:6:\"黑色\";i:2;s:6:\"黑色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"47\";i:1;s:3:\"XXL\";i:2;s:3:\"XXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:6;6:47;', '0', '');
INSERT INTO `ly_products` VALUES ('100', '18', 'NS20140504122_28', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"6\";i:1;s:6:\"黑色\";i:2;s:6:\"黑色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"48\";i:1;s:4:\"XXXL\";i:2;s:4:\"XXXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '238.00', '79.00', '70.00', '200', ';2:6;6:48;', '0', '');
INSERT INTO `ly_products` VALUES ('101', '19', 'NS20140504120_1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"45\";i:1;s:1:\"L\";i:2;s:1:\"L\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '108.00', '49.00', '40.00', '200', ';2:5;6:45;', null, null);
INSERT INTO `ly_products` VALUES ('102', '19', 'NS20140504120_2', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"44\";i:1;s:1:\"M\";i:2;s:1:\"M\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '108.00', '49.00', '40.00', '200', ';2:5;6:44;', null, null);
INSERT INTO `ly_products` VALUES ('103', '19', 'NS20140504120_3', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"43\";i:1;s:1:\"S\";i:2;s:1:\"S\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '108.00', '49.00', '40.00', '200', ';2:5;6:43;', null, null);
INSERT INTO `ly_products` VALUES ('104', '19', 'NS20140504120_4', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"46\";i:1;s:2:\"XL\";i:2;s:2:\"XL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '108.00', '49.00', '40.00', '200', ';2:5;6:46;', null, null);
INSERT INTO `ly_products` VALUES ('105', '19', 'NS20140504120_5', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"42\";i:1;s:2:\"XS\";i:2;s:2:\"XS\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '108.00', '49.00', '40.00', '200', ';2:5;6:42;', null, null);
INSERT INTO `ly_products` VALUES ('106', '19', 'NS20140504120_6', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"47\";i:1;s:3:\"XXL\";i:2;s:3:\"XXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '108.00', '49.00', '40.00', '200', ';2:5;6:47;', null, null);
INSERT INTO `ly_products` VALUES ('107', '19', 'NS20140504120_7', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"45\";i:1;s:1:\"L\";i:2;s:1:\"L\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '108.00', '49.00', '40.00', '200', ';2:11;6:45;', null, null);
INSERT INTO `ly_products` VALUES ('108', '19', 'NS20140504120_8', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"44\";i:1;s:1:\"M\";i:2;s:1:\"M\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '108.00', '49.00', '40.00', '200', ';2:11;6:44;', null, null);
INSERT INTO `ly_products` VALUES ('109', '19', 'NS20140504120_9', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"43\";i:1;s:1:\"S\";i:2;s:1:\"S\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '108.00', '49.00', '40.00', '200', ';2:11;6:43;', null, null);
INSERT INTO `ly_products` VALUES ('110', '19', 'NS20140504120_10', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"46\";i:1;s:2:\"XL\";i:2;s:2:\"XL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '108.00', '49.00', '40.00', '200', ';2:11;6:46;', null, null);
INSERT INTO `ly_products` VALUES ('111', '19', 'NS20140504120_11', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"42\";i:1;s:2:\"XS\";i:2;s:2:\"XS\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '108.00', '49.00', '40.00', '200', ';2:11;6:42;', null, null);
INSERT INTO `ly_products` VALUES ('112', '19', 'NS20140504120_12', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"47\";i:1;s:3:\"XXL\";i:2;s:3:\"XXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '108.00', '49.00', '40.00', '200', ';2:11;6:47;', null, null);
INSERT INTO `ly_products` VALUES ('113', '20', 'NS20140504124_1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"45\";i:1;s:1:\"L\";i:2;s:1:\"L\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '68.00', '45.00', '40.00', '200', ';2:5;6:45;', null, null);
INSERT INTO `ly_products` VALUES ('114', '20', 'NS20140504124_2', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"44\";i:1;s:1:\"M\";i:2;s:1:\"M\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '68.00', '45.00', '40.00', '200', ';2:5;6:44;', null, null);
INSERT INTO `ly_products` VALUES ('115', '20', 'NS20140504124_3', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"43\";i:1;s:1:\"S\";i:2;s:1:\"S\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '68.00', '45.00', '40.00', '200', ';2:5;6:43;', null, null);
INSERT INTO `ly_products` VALUES ('116', '20', 'NS20140504124_4', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:1:\"5\";i:1;s:6:\"白色\";i:2;s:6:\"白色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:6;a:6:{s:2:\"id\";s:1:\"6\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"47\";i:1;s:3:\"XXL\";i:2;s:3:\"XXL\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"女式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '68.00', '45.00', '40.00', '200', ';2:5;6:47;', null, null);
INSERT INTO `ly_products` VALUES ('117', '21', 'MS20140504120_1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"59\";i:1;s:2:\"38\";i:2;s:2:\"38\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '199.00', '58.00', '50.00', '200', ';2:11;7:59;', null, null);
INSERT INTO `ly_products` VALUES ('118', '21', 'MS20140504120_2', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"60\";i:1;s:2:\"39\";i:2;s:2:\"39\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '199.00', '58.00', '50.00', '200', ';2:11;7:60;', null, null);
INSERT INTO `ly_products` VALUES ('119', '21', 'MS20140504120_3', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"61\";i:1;s:2:\"40\";i:2;s:2:\"40\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '199.00', '58.00', '50.00', '200', ';2:11;7:61;', null, null);
INSERT INTO `ly_products` VALUES ('120', '21', 'MS20140504120_4', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"62\";i:1;s:2:\"41\";i:2;s:2:\"41\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '199.00', '58.00', '50.00', '200', ';2:11;7:62;', null, null);
INSERT INTO `ly_products` VALUES ('121', '21', 'MS20140504120_5', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"63\";i:1;s:2:\"42\";i:2;s:2:\"42\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '199.00', '58.00', '50.00', '200', ';2:11;7:63;', null, null);
INSERT INTO `ly_products` VALUES ('122', '22', 'MS20140504121_1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"60\";i:1;s:2:\"39\";i:2;s:2:\"39\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '278.00', '78.00', '70.00', '200', ';2:10;7:60;', '0', '');
INSERT INTO `ly_products` VALUES ('123', '22', 'MS20140504121_2', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"61\";i:1;s:2:\"40\";i:2;s:2:\"40\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '278.00', '78.00', '70.00', '200', ';2:10;7:61;', '0', '');
INSERT INTO `ly_products` VALUES ('124', '22', 'MS20140504121_3', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"62\";i:1;s:2:\"41\";i:2;s:2:\"41\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '278.00', '78.00', '70.00', '200', ';2:10;7:62;', '0', '');
INSERT INTO `ly_products` VALUES ('125', '22', 'MS20140504121_4', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"63\";i:1;s:2:\"42\";i:2;s:2:\"42\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '278.00', '78.00', '70.00', '200', ';2:10;7:63;', '0', '');
INSERT INTO `ly_products` VALUES ('126', '22', 'MS20140504121_5', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"64\";i:1;s:2:\"43\";i:2;s:2:\"43\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '278.00', '78.00', '70.00', '200', ';2:10;7:64;', '0', '');
INSERT INTO `ly_products` VALUES ('127', '22', 'MS20140504121_6', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"65\";i:1;s:2:\"44\";i:2;s:2:\"44\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '278.00', '78.00', '70.00', '200', ';2:10;7:65;', '0', '');
INSERT INTO `ly_products` VALUES ('128', '22', 'MS20140504121_7', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"60\";i:1;s:2:\"39\";i:2;s:2:\"39\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '278.00', '78.00', '70.00', '200', ';2:11;7:60;', '0', '');
INSERT INTO `ly_products` VALUES ('129', '22', 'MS20140504121_8', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"61\";i:1;s:2:\"40\";i:2;s:2:\"40\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '278.00', '78.00', '70.00', '200', ';2:11;7:61;', '0', '');
INSERT INTO `ly_products` VALUES ('130', '22', 'MS20140504121_9', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"62\";i:1;s:2:\"41\";i:2;s:2:\"41\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '278.00', '78.00', '70.00', '200', ';2:11;7:62;', '0', '');
INSERT INTO `ly_products` VALUES ('131', '22', 'MS20140504121_10', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"63\";i:1;s:2:\"42\";i:2;s:2:\"42\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '278.00', '78.00', '70.00', '200', ';2:11;7:63;', '0', '');
INSERT INTO `ly_products` VALUES ('132', '22', 'MS20140504121_11', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"64\";i:1;s:2:\"43\";i:2;s:2:\"43\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '278.00', '78.00', '70.00', '200', ';2:11;7:64;', '0', '');
INSERT INTO `ly_products` VALUES ('133', '22', 'MS20140504121_12', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"65\";i:1;s:2:\"44\";i:2;s:2:\"44\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '278.00', '78.00', '70.00', '200', ';2:11;7:65;', '0', '');
INSERT INTO `ly_products` VALUES ('134', '23', 'MS20140504122_1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"52\";i:1;s:7:\"170/92A\";i:2;s:7:\"170/92A\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '198.00', '65.00', '60.00', '200', ';2:10;7:52;', '0', '');
INSERT INTO `ly_products` VALUES ('135', '23', 'MS20140504122_2', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"53\";i:1;s:7:\"175/96A\";i:2;s:7:\"175/96A\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '198.00', '65.00', '60.00', '200', ';2:10;7:53;', '0', '');
INSERT INTO `ly_products` VALUES ('136', '23', 'MS20140504122_3', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"54\";i:1;s:8:\"180/100A\";i:2;s:8:\"180/100A\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '198.00', '65.00', '60.00', '200', ';2:10;7:54;', '0', '');
INSERT INTO `ly_products` VALUES ('137', '24', 'MS20140504123_1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"61\";i:1;s:2:\"40\";i:2;s:2:\"40\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '75.00', '35.00', '30.00', '200', ';2:10;7:61;', '0', '');
INSERT INTO `ly_products` VALUES ('138', '24', 'MS20140504123_2', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"62\";i:1;s:2:\"41\";i:2;s:2:\"41\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '75.00', '35.00', '30.00', '200', ';2:10;7:62;', '0', '');
INSERT INTO `ly_products` VALUES ('139', '24', 'MS20140504123_3', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"63\";i:1;s:2:\"42\";i:2;s:2:\"42\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '75.00', '35.00', '30.00', '200', ';2:10;7:63;', '0', '');
INSERT INTO `ly_products` VALUES ('140', '24', 'MS20140504123_4', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"64\";i:1;s:2:\"43\";i:2;s:2:\"43\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '75.00', '35.00', '30.00', '200', ';2:10;7:64;', '0', '');
INSERT INTO `ly_products` VALUES ('141', '24', 'MS20140504123_5', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"65\";i:1;s:2:\"44\";i:2;s:2:\"44\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '75.00', '35.00', '30.00', '200', ';2:10;7:65;', '0', '');
INSERT INTO `ly_products` VALUES ('142', '24', 'MS20140504123_6', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"61\";i:1;s:2:\"40\";i:2;s:2:\"40\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '75.00', '35.00', '30.00', '200', ';2:11;7:61;', '0', '');
INSERT INTO `ly_products` VALUES ('143', '24', 'MS20140504123_7', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"62\";i:1;s:2:\"41\";i:2;s:2:\"41\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '75.00', '35.00', '30.00', '200', ';2:11;7:62;', '0', '');
INSERT INTO `ly_products` VALUES ('144', '24', 'MS20140504123_8', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"63\";i:1;s:2:\"42\";i:2;s:2:\"42\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '75.00', '35.00', '30.00', '200', ';2:11;7:63;', '0', '');
INSERT INTO `ly_products` VALUES ('145', '24', 'MS20140504123_9', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"64\";i:1;s:2:\"43\";i:2;s:2:\"43\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '75.00', '35.00', '30.00', '200', ';2:11;7:64;', '0', '');
INSERT INTO `ly_products` VALUES ('146', '24', 'MS20140504123_10', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"65\";i:1;s:2:\"44\";i:2;s:2:\"44\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '22', '2', '75.00', '35.00', '30.00', '200', ';2:11;7:65;', '0', '');
INSERT INTO `ly_products` VALUES ('147', '25', 'MS20140504124_1', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"58\";i:1;s:2:\"37\";i:2;s:2:\"37\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '126.00', '76.00', '70.00', '200', ';2:10;7:58;', null, null);
INSERT INTO `ly_products` VALUES ('148', '25', 'MS20140504124_2', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"59\";i:1;s:2:\"38\";i:2;s:2:\"38\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '126.00', '76.00', '70.00', '200', ';2:10;7:59;', null, null);
INSERT INTO `ly_products` VALUES ('149', '25', 'MS20140504124_3', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"60\";i:1;s:2:\"39\";i:2;s:2:\"39\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '126.00', '76.00', '70.00', '200', ';2:10;7:60;', null, null);
INSERT INTO `ly_products` VALUES ('150', '25', 'MS20140504124_4', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"10\";i:1;s:6:\"红色\";i:2;s:6:\"红色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"61\";i:1;s:2:\"40\";i:2;s:2:\"40\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '126.00', '76.00', '70.00', '200', ';2:10;7:61;', null, null);
INSERT INTO `ly_products` VALUES ('151', '25', 'MS20140504124_5', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"58\";i:1;s:2:\"37\";i:2;s:2:\"37\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '126.00', '76.00', '70.00', '200', ';2:11;7:58;', null, null);
INSERT INTO `ly_products` VALUES ('152', '25', 'MS20140504124_6', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"59\";i:1;s:2:\"38\";i:2;s:2:\"38\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '126.00', '76.00', '70.00', '200', ';2:11;7:59;', null, null);
INSERT INTO `ly_products` VALUES ('153', '25', 'MS20140504124_7', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"60\";i:1;s:2:\"39\";i:2;s:2:\"39\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '126.00', '76.00', '70.00', '200', ';2:11;7:60;', null, null);
INSERT INTO `ly_products` VALUES ('154', '25', 'MS20140504124_8', 'a:2:{i:2;a:6:{s:2:\"id\";s:1:\"2\";s:4:\"name\";s:6:\"颜色\";s:5:\"value\";a:4:{i:0;s:2:\"11\";i:1;s:6:\"蓝色\";i:2;s:6:\"蓝色\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:12:\"基本颜色\";s:6:\"is_del\";s:1:\"0\";}i:7;a:6:{s:2:\"id\";s:1:\"7\";s:4:\"name\";s:6:\"尺码\";s:5:\"value\";a:4:{i:0;s:2:\"61\";i:1;s:2:\"40\";i:2;s:2:\"40\";i:3;s:0:\"\";}s:4:\"type\";s:1:\"1\";s:4:\"note\";s:6:\"男式\";s:6:\"is_del\";s:1:\"0\";}}', '12', '2', '126.00', '76.00', '70.00', '200', ';2:11;7:61;', null, null);

-- ----------------------------
-- Table structure for `ly_prom_goods`
-- ----------------------------
DROP TABLE IF EXISTS `ly_prom_goods`;
CREATE TABLE `ly_prom_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `type` int(2) NOT NULL DEFAULT '0',
  `expression` varchar(100) NOT NULL,
  `description` text,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `goods_id` bigint(20) DEFAULT NULL,
  `is_close` tinyint(1) DEFAULT '0',
  `group` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_prom_goods
-- ----------------------------
INSERT INTO `ly_prom_goods` VALUES ('1', '开业庆典', '1', '5', '', '2014-05-04 10:05:05', '2014-12-31 10:05:08', '0', '0', '0');
INSERT INTO `ly_prom_goods` VALUES ('2', '送代金券', '3', '1', '', '2014-05-04 10:08:01', '2014-12-31 10:08:03', '0', '0', '0');

-- ----------------------------
-- Table structure for `ly_prom_order`
-- ----------------------------
DROP TABLE IF EXISTS `ly_prom_order`;
CREATE TABLE `ly_prom_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `type` int(2) NOT NULL DEFAULT '0',
  `money` float(10,2) DEFAULT '0.00',
  `expression` varchar(100) DEFAULT NULL,
  `description` text,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `is_close` tinyint(1) DEFAULT '0',
  `group` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_prom_order
-- ----------------------------
INSERT INTO `ly_prom_order` VALUES ('1', '免运费', '4', '100.00', '', 'dddddddddddddddd', '2014-04-22 20:18:20', '2014-12-31 20:18:21', '0', '0');
INSERT INTO `ly_prom_order` VALUES ('2', '打折优惠', '0', '1000.00', '98', '', '2014-05-04 10:10:26', '2015-05-04 10:10:41', '0', '0');

-- ----------------------------
-- Table structure for `ly_rebate`
-- ----------------------------
DROP TABLE IF EXISTS `ly_rebate`;
CREATE TABLE `ly_rebate` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `rebate_no` varchar(50) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `dispro_id` bigint(20) NOT NULL,
  `lower_id` varchar(50) NOT NULL,
  `disorder_no` bigint(50) NOT NULL,
  `qty` int(8) NOT NULL,
  `money` int(10) NOT NULL,
  `create_time` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_rebate
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_recharge`
-- ----------------------------
DROP TABLE IF EXISTS `ly_recharge`;
CREATE TABLE `ly_recharge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `recharge_no` varchar(20) NOT NULL,
  `account` float(10,2) DEFAULT '0.00',
  `time` datetime DEFAULT NULL,
  `payment_name` varchar(80) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_recharge
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_reset_password`
-- ----------------------------
DROP TABLE IF EXISTS `ly_reset_password`;
CREATE TABLE `ly_reset_password` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `safecode` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_reset_password
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_resources`
-- ----------------------------
DROP TABLE IF EXISTS `ly_resources`;
CREATE TABLE `ly_resources` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `group` varchar(30) NOT NULL,
  `right` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=182 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_resources
-- ----------------------------
INSERT INTO `ly_resources` VALUES ('1', '商品编辑', 'goods', 'Goods@goods_save,Goods@goods_edit,Goods@show_spec_select');
INSERT INTO `ly_resources` VALUES ('2', '商品列表', 'goods', 'Goods@goods_list');
INSERT INTO `ly_resources` VALUES ('3', '商品上下架', 'goods', 'Goods@set_online');
INSERT INTO `ly_resources` VALUES ('4', '商品删除', 'goods', 'Goods@goods_del');
INSERT INTO `ly_resources` VALUES ('5', '商品分类列表', 'goods', 'Goods@goods_category_list');
INSERT INTO `ly_resources` VALUES ('6', '商品分类编辑', 'goods', 'Goods@goods_category_edit,Goods@goods_category_save');
INSERT INTO `ly_resources` VALUES ('7', '商品分类删除', 'goods', 'Goods@goods_category_del');
INSERT INTO `ly_resources` VALUES ('8', '商品类型列表', 'goods', 'Goods@goods_type_list');
INSERT INTO `ly_resources` VALUES ('9', '商品类型编辑', 'goods', 'Goods@goods_type_save,Goods@goods_type_edit,Goods@goods_spec_show,Goods@attr_values');
INSERT INTO `ly_resources` VALUES ('10', '商品类型删除', 'goods', 'Goods@goods_type_del');
INSERT INTO `ly_resources` VALUES ('11', '商品规格列表', 'goods', 'Goods@goods_spec_list');
INSERT INTO `ly_resources` VALUES ('12', '商品规格编辑', 'goods', 'Goods@goods_spec_edit,Goods@goods_spec_save');
INSERT INTO `ly_resources` VALUES ('13', '商品规格删除', 'goods', 'Goods@goods_spec_del');
INSERT INTO `ly_resources` VALUES ('14', '品牌列表', 'goods', 'Goods@brand_list');
INSERT INTO `ly_resources` VALUES ('15', '品牌编辑', 'goods', 'Goods@brand_edit,Goods@brand_save');
INSERT INTO `ly_resources` VALUES ('16', '品牌删除', 'goods', 'Goods@brand_del');
INSERT INTO `ly_resources` VALUES ('17', '订单列表', 'order', 'Order@order_list');
INSERT INTO `ly_resources` VALUES ('18', '订单编辑', 'order', 'Order@order_edit,Order@order_save');
INSERT INTO `ly_resources` VALUES ('19', '订单详情', 'order', 'Order@order_view');
INSERT INTO `ly_resources` VALUES ('20', '订单发货', 'order', 'Order@order_send,Order@doc_invoice_save');
INSERT INTO `ly_resources` VALUES ('21', '后台首页', 'system', 'Admin@index');
INSERT INTO `ly_resources` VALUES ('22', '订单审核、作废、备注', 'order', 'Order@order_status');
INSERT INTO `ly_resources` VALUES ('23', '打印订单', 'order', 'Order@print_order');
INSERT INTO `ly_resources` VALUES ('24', '打印购物单', 'order', 'Order@print_product');
INSERT INTO `ly_resources` VALUES ('25', '打印配送单', 'order', 'Order@print_picking');
INSERT INTO `ly_resources` VALUES ('26', '打印快递单', 'order', 'Order@print_express');
INSERT INTO `ly_resources` VALUES ('27', '收款单', 'order', 'Order@doc_receiving_list,Order@doc_receiving_view');
INSERT INTO `ly_resources` VALUES ('28', '发货单子', 'order', 'Order@doc_invoice_list,Order@doc_invoice_view');
INSERT INTO `ly_resources` VALUES ('29', '退款单查看', 'order', 'Order@doc_refund_list,Order@doc_refund_view');
INSERT INTO `ly_resources` VALUES ('30', '退款单处理', 'order', 'Order@doc_refund_edit,Order@doc_refund_save');
INSERT INTO `ly_resources` VALUES ('31', '快递单模板列表', 'order', 'Order@express_template_list,Order@express_template_edit');
INSERT INTO `ly_resources` VALUES ('32', '快递单模板编辑', 'order', 'Order@express_template_edit,Order@express_template_save');
INSERT INTO `ly_resources` VALUES ('33', ' 发货点列表', 'order', 'Order@ship_list');
INSERT INTO `ly_resources` VALUES ('34', '发货点编辑', 'order', 'Order@ship_edit,Order@ship_save');
INSERT INTO `ly_resources` VALUES ('35', '发货点删除', 'order', 'Order@ship_del');
INSERT INTO `ly_resources` VALUES ('36', '快递单模板删除', 'order', 'Order@express_template_del');
INSERT INTO `ly_resources` VALUES ('37', '会员列表', 'customer', 'Customer@customer_list');
INSERT INTO `ly_resources` VALUES ('38', '会员编辑', 'customer', 'Customer@customer_edit,Customer@customer_save');
INSERT INTO `ly_resources` VALUES ('39', '会员删除', 'customer', 'Customer@customer_del');
INSERT INTO `ly_resources` VALUES ('40', '会员充值、退款', 'customer', 'Customer@balance_op');
INSERT INTO `ly_resources` VALUES ('41', '会员等级列表', 'customer', 'Customer@grade_list');
INSERT INTO `ly_resources` VALUES ('42', '会员等级编辑', 'customer', 'Customer@grade_edit,Customer@grade_save');
INSERT INTO `ly_resources` VALUES ('43', '会员等级删除', 'customer', 'Customer@grade_del');
INSERT INTO `ly_resources` VALUES ('44', '提现申请列表', 'customer', 'Customer@withdraw_list');
INSERT INTO `ly_resources` VALUES ('45', '提现申请审核', 'customer', 'Customer@withdraw_view,Customer@withdraw_act');
INSERT INTO `ly_resources` VALUES ('46', '提现申请删除', 'customer', 'Customer@withdraw_del');
INSERT INTO `ly_resources` VALUES ('47', '资金日志', 'customer', 'Customer@balance_list');
INSERT INTO `ly_resources` VALUES ('48', '商品评价列表', 'customer', 'Customer@review_list');
INSERT INTO `ly_resources` VALUES ('49', '商品评价删除', 'customer', 'Customer@review_del');
INSERT INTO `ly_resources` VALUES ('50', '商品咨询列表', 'customer', 'Customer@ask_list');
INSERT INTO `ly_resources` VALUES ('51', '商品咨询回复', 'customer', 'Customer@ask_edit,Customer@ask_save');
INSERT INTO `ly_resources` VALUES ('52', '商品咨询删除', 'customer', 'Customer@ask_del');
INSERT INTO `ly_resources` VALUES ('53', '信息管理列表', 'customer', 'Customer@message_list');
INSERT INTO `ly_resources` VALUES ('54', '信息发送', 'customer', 'Customer@message_edit,Customer@message_send');
INSERT INTO `ly_resources` VALUES ('55', '信息删除', 'customer', 'Customer@message_del');
INSERT INTO `ly_resources` VALUES ('56', '到货通知列表', 'customer', 'Customer@notify_list');
INSERT INTO `ly_resources` VALUES ('57', '到货通知导出', 'customer', 'Customer@export_excel');
INSERT INTO `ly_resources` VALUES ('58', '到货通知发送', 'customer', 'Customer@send_notify');
INSERT INTO `ly_resources` VALUES ('59', '到货通知删除', 'customer', 'Customer@notify_del');
INSERT INTO `ly_resources` VALUES ('60', '商品促销列表', 'marketing', 'Marketing@prom_goods_list');
INSERT INTO `ly_resources` VALUES ('61', '商品促销编辑', 'marketing', 'Marketing@prom_goods_save,Marketing@prom_goods_edit,Marketing@goods_select');
INSERT INTO `ly_resources` VALUES ('62', '商品促销删除', 'marketing', 'Marketing@radio_goods_del');
INSERT INTO `ly_resources` VALUES ('63', '订单促销列表', 'marketing', 'Marketing@prom_order_list');
INSERT INTO `ly_resources` VALUES ('64', '订单促销编辑', 'marketing', 'Marketing@prom_order_edit,Marketing@prom_order_save');
INSERT INTO `ly_resources` VALUES ('65', '订单促销删除', 'marketing', 'Marketing@prom_order_del');
INSERT INTO `ly_resources` VALUES ('66', '捆绑促销列表', 'marketing', 'Marketing@bundling_list');
INSERT INTO `ly_resources` VALUES ('67', '捆绑促销编辑', 'marketing', 'Marketing@bundling_edit,Marketing@bundling_save,Marketing@bundling_goods_select');
INSERT INTO `ly_resources` VALUES ('68', '捆绑促销删除', 'marketing', 'Marketing@bundling_del');
INSERT INTO `ly_resources` VALUES ('69', '团购列表', 'marketing', 'Marketing@groupbuy_list');
INSERT INTO `ly_resources` VALUES ('70', '团购编辑', 'marketing', 'Marketing@radio_goods_select,Marketing@groupbuy_edit,Marketing@groupbuy_save');
INSERT INTO `ly_resources` VALUES ('71', '团购删除', 'marketing', 'Marketing@groupbuy_del');
INSERT INTO `ly_resources` VALUES ('72', '抢购列表', 'marketing', 'Marketing@flash_sale_list');
INSERT INTO `ly_resources` VALUES ('73', '抢购编辑', 'marketing', 'Marketing@flash_sale_edit,Marketing@flash_sale_save,Marketing@radio_goods_select');
INSERT INTO `ly_resources` VALUES ('74', '抢购删除', 'marketing', 'Marketing@flash_sale_del');
INSERT INTO `ly_resources` VALUES ('75', '代金卷模板列表', 'marketing', 'Marketing@voucher_template_list');
INSERT INTO `ly_resources` VALUES ('76', '代金卷模板编辑', 'marketing', 'Marketing@voucher_template_edit,Marketing@voucher_template_save');
INSERT INTO `ly_resources` VALUES ('77', '生成代金卷', 'marketing', 'Marketing@voucher_create');
INSERT INTO `ly_resources` VALUES ('78', '代金卷模板删除', 'marketing', 'Marketing@voucher_template_del');
INSERT INTO `ly_resources` VALUES ('79', '代金卷列表', 'marketing', 'Marketing@voucher_list');
INSERT INTO `ly_resources` VALUES ('80', '代金卷发放', 'marketing', 'Marketing@voucher_send');
INSERT INTO `ly_resources` VALUES ('81', '代金卷禁用', 'marketing', 'Marketing@voucher_disabled');
INSERT INTO `ly_resources` VALUES ('82', '代金卷删除', 'marketing', 'Marketing@voucher_del');
INSERT INTO `ly_resources` VALUES ('83', '订单统计', 'count', 'Count@index');
INSERT INTO `ly_resources` VALUES ('84', '热销统计', 'count', 'Count@hot');
INSERT INTO `ly_resources` VALUES ('85', '地区销售统计', 'count', 'Count@area_buy');
INSERT INTO `ly_resources` VALUES ('86', '会员分布统计', 'count', 'Count@user_reg');
INSERT INTO `ly_resources` VALUES ('87', '文章列表', 'content', 'Content@article_list');
INSERT INTO `ly_resources` VALUES ('88', '文章编辑', 'content', 'Content@article_save,Content@article_edit');
INSERT INTO `ly_resources` VALUES ('89', '文章删除', 'content', 'Content@article_del');
INSERT INTO `ly_resources` VALUES ('90', '文章分类列表', 'content', 'Content@category_list');
INSERT INTO `ly_resources` VALUES ('91', '文章分类编辑', 'content', 'Content@category_save,Content@category_edit');
INSERT INTO `ly_resources` VALUES ('92', '文章分类删除', 'content', 'Content@category_del');
INSERT INTO `ly_resources` VALUES ('93', '帮助列表', 'content', 'Content@help_list');
INSERT INTO `ly_resources` VALUES ('94', '帮助编辑', 'content', 'Content@help_save,Content@help_edit');
INSERT INTO `ly_resources` VALUES ('95', '帮助删除', 'content', 'Content@help_del');
INSERT INTO `ly_resources` VALUES ('96', '帮助分类列表', 'content', 'Content@help_category_list');
INSERT INTO `ly_resources` VALUES ('97', '帮助分类编辑', 'content', 'Content@help_category_save,Content@help_category_edit');
INSERT INTO `ly_resources` VALUES ('98', '帮助分类删除', 'content', 'Content@help_category_del');
INSERT INTO `ly_resources` VALUES ('99', '广告列表', 'content', 'Content@ad_list');
INSERT INTO `ly_resources` VALUES ('100', '广告编辑', 'content', 'Content@ad_save,Content@ad_edit');
INSERT INTO `ly_resources` VALUES ('101', '广告预览', 'content', 'Content@ad_show');
INSERT INTO `ly_resources` VALUES ('102', '广告删除', 'content', 'Content@ad_del');
INSERT INTO `ly_resources` VALUES ('103', '标签列表', 'content', 'Content@tags_list');
INSERT INTO `ly_resources` VALUES ('104', '标签删除', 'content', 'Content@tags_del');
INSERT INTO `ly_resources` VALUES ('105', '标签置顶、排序', 'content', 'Content@tags_update');
INSERT INTO `ly_resources` VALUES ('106', '站点设置', 'system', 'Admin@config_globals,Admin@config');
INSERT INTO `ly_resources` VALUES ('107', '其它设置', 'system', 'Admin@config,Admin@config_other');
INSERT INTO `ly_resources` VALUES ('108', '邮箱配制', 'system', 'Admin@config,Admin@config_email,Admin@send_email_test');
INSERT INTO `ly_resources` VALUES ('109', '信息模板列表', 'system', 'Admin@msg_template_list');
INSERT INTO `ly_resources` VALUES ('110', '信息模板编辑', 'system', 'Admin@msg_template_edit,Admin@msg_template_save');
INSERT INTO `ly_resources` VALUES ('111', '支付方式列表', 'system', 'Admin@payment_list');
INSERT INTO `ly_resources` VALUES ('112', '支付方式编辑', 'system', 'Admin@payment_edit,Admin@payment_save');
INSERT INTO `ly_resources` VALUES ('113', '支付方式删除', 'system', 'Admin@payment_del');
INSERT INTO `ly_resources` VALUES ('114', '区域列表', 'system', 'Admin@zoning_list');
INSERT INTO `ly_resources` VALUES ('115', '区域编辑', 'system', 'Admin@zoning_edit,Admin@zoning_save');
INSERT INTO `ly_resources` VALUES ('116', '区域删除', 'system', 'Admin@zoning_del');
INSERT INTO `ly_resources` VALUES ('117', '地区列表', 'system', 'Admin@area_list');
INSERT INTO `ly_resources` VALUES ('118', '地区编辑', 'system', 'Admin@area_op');
INSERT INTO `ly_resources` VALUES ('119', '运费模板列表', 'system', 'Admin@fare_list');
INSERT INTO `ly_resources` VALUES ('120', '运费模板编辑', 'system', 'Admin@fare_save,Admin@fare_edit,Admin@fare_show_area,Admin@fare_use');
INSERT INTO `ly_resources` VALUES ('121', '运费模板删除', 'system', 'Admin@fare_del');
INSERT INTO `ly_resources` VALUES ('122', '快递公司列表', 'system', 'Admin@express_company_list');
INSERT INTO `ly_resources` VALUES ('123', '快递公司编辑', 'system', 'Admin@express_company_edit,Admin@express_company_save');
INSERT INTO `ly_resources` VALUES ('124', '快递公司删除', 'system', 'Admin@express_company_del');
INSERT INTO `ly_resources` VALUES ('125', '管理员列表', 'system', 'Admin@manager_list');
INSERT INTO `ly_resources` VALUES ('126', '管理员编辑', 'system', 'Admin@manager_edit,Admin@manager_save');
INSERT INTO `ly_resources` VALUES ('127', '管理员修改密码', 'system', 'Admin@manager_password');
INSERT INTO `ly_resources` VALUES ('128', '管理员删除', 'system', 'Admin@manager_del');
INSERT INTO `ly_resources` VALUES ('129', '角色列表', 'system', 'Admin@roles_list');
INSERT INTO `ly_resources` VALUES ('130', '角色编辑', 'system', 'Admin@roles_edit,Admin@roles_save');
INSERT INTO `ly_resources` VALUES ('131', '角色删除', 'system', 'Admin@roles_del');
INSERT INTO `ly_resources` VALUES ('132', '操作日志列表', 'system', 'Admin@log_operation_list');
INSERT INTO `ly_resources` VALUES ('133', '操作日志删除', 'system', 'Admin@log_operation_del');
INSERT INTO `ly_resources` VALUES ('134', '系统缓存清理', 'system', 'Admin@clear');
INSERT INTO `ly_resources` VALUES ('135', '数据库表格列表', 'system', 'Admin@tables_list');
INSERT INTO `ly_resources` VALUES ('136', '数据库备份', 'system', 'Admin@tables_back');
INSERT INTO `ly_resources` VALUES ('137', '备份列表', 'system', 'Admin@back_list');
INSERT INTO `ly_resources` VALUES ('138', '备份下载', 'system', 'Admin@down');
INSERT INTO `ly_resources` VALUES ('139', '备份还原', 'system', 'Admin@back_recover');
INSERT INTO `ly_resources` VALUES ('140', '备份导入还原', 'system', 'Admin@upload_recover');
INSERT INTO `ly_resources` VALUES ('141', '备份删除', 'system', 'Admin@back_del');
INSERT INTO `ly_resources` VALUES ('142', '图片上传与图库', 'system', 'Admin@photoshop,Admin@photoshop_upload');
INSERT INTO `ly_resources` VALUES ('143', '编辑器图片上传功能', 'system', 'Admin@upload_image');
INSERT INTO `ly_resources` VALUES ('144', '订单删除', 'order', 'Order@order_del');
INSERT INTO `ly_resources` VALUES ('145', '广告开户与关闭', 'content', 'Content@change_open');
INSERT INTO `ly_resources` VALUES ('146', '导航列表', 'content', 'Content@nav_list');
INSERT INTO `ly_resources` VALUES ('147', '导航修改', 'content', 'Content@nav_edit');
INSERT INTO `ly_resources` VALUES ('148', '导航删除', 'content', 'Content@nav_del');
INSERT INTO `ly_resources` VALUES ('149', '分销代理列表', 'distribution', 'distribution@agent_list');
INSERT INTO `ly_resources` VALUES ('150', '分销代理编辑', 'distribution', 'distribution@agent_edit,distribution@agent_save');
INSERT INTO `ly_resources` VALUES ('152', '分销代理删除', 'distribution', 'distribution@agent_del');
INSERT INTO `ly_resources` VALUES ('153', '分销商品列表', 'distribution', 'distribution@dispro_list');
INSERT INTO `ly_resources` VALUES ('154', '分销商品编辑', 'distribution', 'distribution@dispro_edit,distribution@dispro_save');
INSERT INTO `ly_resources` VALUES ('155', '分销商品审核', 'distribution', 'distribution@dispro_audit');
INSERT INTO `ly_resources` VALUES ('161', '分销返利列表', 'distribution', 'distribution@reebate_list');
INSERT INTO `ly_resources` VALUES ('162', '分销返利审核', 'distribution', 'distribution@rebate_audit');
INSERT INTO `ly_resources` VALUES ('163', '分销返利删除', 'distribution', 'distribution@rebate_del');
INSERT INTO `ly_resources` VALUES ('164', '分销订单列表', 'distribution', 'distribution@disorder_list');
INSERT INTO `ly_resources` VALUES ('165', '分销订单审核', 'distribution', 'distribution@disorder_audit');
INSERT INTO `ly_resources` VALUES ('156', '分销商品删除', 'distribution', 'distribution@disprot_del');
INSERT INTO `ly_resources` VALUES ('157', '分销等级列表', 'distribution', 'distribution@level_list');
INSERT INTO `ly_resources` VALUES ('158', '分销等级编辑', 'distribution', 'distribution@level_edit,distribution@level_save');
INSERT INTO `ly_resources` VALUES ('159', '分销等级删除', 'distribution', 'distribution@level_del');
INSERT INTO `ly_resources` VALUES ('160', '分销返利设置', 'distribution', 'distribution@rebate_set');
INSERT INTO `ly_resources` VALUES ('166', '分销订单删除', 'distribution', 'distribution@disorder_del');
INSERT INTO `ly_resources` VALUES ('151', '分销代理审核', 'distribution', 'distribution@agent_audit');

-- ----------------------------
-- Table structure for `ly_review`
-- ----------------------------
DROP TABLE IF EXISTS `ly_review`;
CREATE TABLE `ly_review` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(20) NOT NULL,
  `order_no` varchar(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `content` text,
  `point` tinyint(1) DEFAULT '5',
  `status` tinyint(1) DEFAULT '0',
  `buy_time` datetime DEFAULT NULL,
  `comment_time` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_review
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_roles`
-- ----------------------------
DROP TABLE IF EXISTS `ly_roles`;
CREATE TABLE `ly_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `rights` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_roles
-- ----------------------------
INSERT INTO `ly_roles` VALUES ('2', '总裁', 'Goods@goods_save,Goods@goods_edit,Goods@show_spec_select,Goods@goods_list,Goods@set_online,Goods@goods_del,Goods@goods_category_list,Goods@goods_category_edit,Goods@goods_category_save,Goods@goods_category_del,Goods@goods_type_list,Goods@goods_type_save,Goods@goods_type_edit,Goods@goods_spec_show,Goods@attr_values,Goods@goods_type_del,Goods@goods_spec_list,Goods@goods_spec_edit,Goods@goods_spec_save,Goods@goods_spec_del,Goods@brand_list,Goods@brand_edit,Goods@brand_save,Goods@brand_del,Order@order_list,Order@order_edit,Order@order_save,Order@order_view,Order@order_send,Order@doc_invoice_save,Admin@index,Order@order_status,Order@print_order,Order@print_product,Order@print_picking,Order@print_express,Order@doc_receiving_list,Order@doc_receiving_view,Order@doc_invoice_list,Order@doc_invoice_view,Order@doc_refund_list,Order@doc_refund_view,Order@doc_refund_edit,Order@doc_refund_save,Order@express_template_list,Order@express_template_edit,Order@express_template_save,Order@ship_list,Order@ship_edit,Order@ship_save,Order@ship_del,Order@express_template_del,Customer@customer_list,Customer@customer_edit,Customer@customer_save,Customer@customer_del,Customer@balance_op,Customer@grade_list,Customer@grade_edit,Customer@grade_save,Customer@grade_del,Customer@withdraw_list,Customer@withdraw_view,Customer@withdraw_act,Customer@withdraw_del,Customer@balance_list,Customer@review_list,Customer@review_del,Customer@ask_list,Customer@ask_edit,Customer@ask_save,Customer@ask_del,Customer@message_list,Customer@message_edit,Customer@message_send,Customer@message_del,Customer@notify_list,Customer@export_excel,Customer@send_notify,Customer@notify_del,Marketing@prom_goods_list,Marketing@prom_goods_save,Marketing@prom_goods_edit,Marketing@goods_select,Marketing@radio_goods_del,Marketing@prom_order_list,Marketing@prom_order_edit,Marketing@prom_order_save,Marketing@prom_order_del,Marketing@bundling_list,Marketing@bundling_edit,Marketing@bundling_save,Marketing@bundling_goods_select,Marketing@bundling_del,Marketing@groupbuy_list,Marketing@radio_goods_select,Marketing@groupbuy_edit,Marketing@groupbuy_save,Marketing@groupbuy_del,Marketing@flash_sale_list,Marketing@flash_sale_edit,Marketing@flash_sale_save,Marketing@flash_sale_del,Marketing@voucher_template_list,Marketing@voucher_template_edit,Marketing@voucher_template_save,Marketing@voucher_create,Marketing@voucher_template_del,Marketing@voucher_list,Marketing@voucher_send,Marketing@voucher_disabled,Marketing@voucher_del,Count@index,Count@hot,Count@area_buy,Count@user_reg,Content@article_list,Content@article_save,Content@article_edit,Content@article_del,Content@category_list,Content@category_save,Content@category_edit,Content@category_del,Content@help_list,Content@help_save,Content@help_edit,Content@help_del,Content@help_category_list,Content@help_category_save,Content@help_category_edit,Content@help_category_del,Content@ad_list,Content@ad_save,Content@ad_edit,Content@ad_show,Content@ad_del,Content@tags_list,Content@tags_del,Content@tags_update,Admin@config_globals,Admin@config,Admin@config_other,Admin@config_email,Admin@send_email_test,Admin@msg_template_list,Admin@msg_template_edit,Admin@msg_template_save,Admin@payment_list,Admin@payment_edit,Admin@payment_save,Admin@payment_del,Admin@zoning_list,Admin@zoning_edit,Admin@zoning_save,Admin@zoning_del,Admin@area_list,Admin@area_op,Admin@fare_list,Admin@fare_save,Admin@fare_edit,Admin@fare_show_area,Admin@fare_use,Admin@fare_del,Admin@express_company_list,Admin@express_company_edit,Admin@express_company_save,Admin@express_company_del,Admin@manager_list,Admin@manager_edit,Admin@manager_save,Admin@manager_password,Admin@manager_del,Admin@roles_list,Admin@roles_edit,Admin@roles_save,Admin@roles_del,Admin@log_operation_list,Admin@log_operation_del,Admin@clear,Admin@tables_list,Admin@tables_back,Admin@back_list,Admin@down,Admin@back_recover,Admin@upload_recover,Admin@back_del,Admin@photoshop,Admin@photoshop_upload,Admin@upload_image,Order@order_del,Content@change_open,Content@nav_list,Content@nav_edit,Content@nav_del,distribution@agent_list,distribution@agent_edit,distribution@agent_save,distribution@agent_del,distribution@product_list,distribution@product_edit,distribution@product_save,distribution@product_audit,distribution@reebate_list,distribution@rebate_audit,distribution@rebate_del,distribution@dis_order_list,distribution@dis_order_audit,distribution@product_del,distribution@dis_level_list,distribution@dis_level_edit,distribution@dis_level_save,distribution@dis_level_del,distribution@rebate_set,distribution@dis_order_del,distribution@agent_audit');

-- ----------------------------
-- Table structure for `ly_ship`
-- ----------------------------
DROP TABLE IF EXISTS `ly_ship`;
CREATE TABLE `ly_ship` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ship_name` varchar(255) NOT NULL,
  `ship_user_name` varchar(255) NOT NULL,
  `province` bigint(20) NOT NULL,
  `city` bigint(20) NOT NULL,
  `county` bigint(20) NOT NULL,
  `zip` varchar(6) NOT NULL,
  `addr` varchar(255) NOT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  `note` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `is_del` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_ship
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_spec_attr`
-- ----------------------------
DROP TABLE IF EXISTS `ly_spec_attr`;
CREATE TABLE `ly_spec_attr` (
  `goods_id` bigint(20) NOT NULL,
  `key` bigint(20) NOT NULL,
  `value` bigint(20) NOT NULL,
  UNIQUE KEY `GOODS_SPEC_ATTR` (`goods_id`,`key`,`value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_spec_attr
-- ----------------------------
INSERT INTO `ly_spec_attr` VALUES ('6', '1', '3');
INSERT INTO `ly_spec_attr` VALUES ('6', '2', '5');
INSERT INTO `ly_spec_attr` VALUES ('6', '2', '7');
INSERT INTO `ly_spec_attr` VALUES ('6', '2', '8');
INSERT INTO `ly_spec_attr` VALUES ('6', '1073741824', '3');
INSERT INTO `ly_spec_attr` VALUES ('7', '1', '1');
INSERT INTO `ly_spec_attr` VALUES ('7', '2', '5');
INSERT INTO `ly_spec_attr` VALUES ('7', '2', '6');
INSERT INTO `ly_spec_attr` VALUES ('7', '2', '11');
INSERT INTO `ly_spec_attr` VALUES ('7', '1073741824', '2');
INSERT INTO `ly_spec_attr` VALUES ('8', '1', '1');
INSERT INTO `ly_spec_attr` VALUES ('8', '2', '5');
INSERT INTO `ly_spec_attr` VALUES ('8', '2', '6');
INSERT INTO `ly_spec_attr` VALUES ('8', '1073741824', '2');
INSERT INTO `ly_spec_attr` VALUES ('9', '2', '5');
INSERT INTO `ly_spec_attr` VALUES ('9', '2', '7');
INSERT INTO `ly_spec_attr` VALUES ('9', '1073741825', '9');
INSERT INTO `ly_spec_attr` VALUES ('9', '1073741826', '14');
INSERT INTO `ly_spec_attr` VALUES ('9', '1073741827', '18');
INSERT INTO `ly_spec_attr` VALUES ('9', '1073741828', '23');
INSERT INTO `ly_spec_attr` VALUES ('10', '1073741825', '10');
INSERT INTO `ly_spec_attr` VALUES ('10', '1073741826', '14');
INSERT INTO `ly_spec_attr` VALUES ('10', '1073741827', '19');
INSERT INTO `ly_spec_attr` VALUES ('10', '1073741828', '23');
INSERT INTO `ly_spec_attr` VALUES ('11', '2', '5');
INSERT INTO `ly_spec_attr` VALUES ('11', '2', '7');
INSERT INTO `ly_spec_attr` VALUES ('11', '1073741825', '9');
INSERT INTO `ly_spec_attr` VALUES ('11', '1073741826', '14');
INSERT INTO `ly_spec_attr` VALUES ('11', '1073741827', '18');
INSERT INTO `ly_spec_attr` VALUES ('11', '1073741828', '23');
INSERT INTO `ly_spec_attr` VALUES ('12', '1', '3');
INSERT INTO `ly_spec_attr` VALUES ('12', '2', '5');
INSERT INTO `ly_spec_attr` VALUES ('12', '2', '10');
INSERT INTO `ly_spec_attr` VALUES ('12', '2', '11');
INSERT INTO `ly_spec_attr` VALUES ('12', '2', '12');
INSERT INTO `ly_spec_attr` VALUES ('12', '2', '13');
INSERT INTO `ly_spec_attr` VALUES ('12', '2', '14');
INSERT INTO `ly_spec_attr` VALUES ('12', '1073741824', '3');
INSERT INTO `ly_spec_attr` VALUES ('13', '1', '3');
INSERT INTO `ly_spec_attr` VALUES ('13', '2', '5');
INSERT INTO `ly_spec_attr` VALUES ('13', '2', '6');
INSERT INTO `ly_spec_attr` VALUES ('13', '1073741824', '3');
INSERT INTO `ly_spec_attr` VALUES ('14', '1', '1');
INSERT INTO `ly_spec_attr` VALUES ('14', '2', '5');
INSERT INTO `ly_spec_attr` VALUES ('14', '2', '10');
INSERT INTO `ly_spec_attr` VALUES ('14', '2', '11');
INSERT INTO `ly_spec_attr` VALUES ('14', '2', '14');
INSERT INTO `ly_spec_attr` VALUES ('14', '2', '16');
INSERT INTO `ly_spec_attr` VALUES ('14', '1073741824', '3');
INSERT INTO `ly_spec_attr` VALUES ('15', '2', '5');
INSERT INTO `ly_spec_attr` VALUES ('15', '2', '7');
INSERT INTO `ly_spec_attr` VALUES ('15', '3', '20');
INSERT INTO `ly_spec_attr` VALUES ('15', '3', '21');
INSERT INTO `ly_spec_attr` VALUES ('15', '4', '27');
INSERT INTO `ly_spec_attr` VALUES ('15', '5', '37');
INSERT INTO `ly_spec_attr` VALUES ('16', '2', '10');
INSERT INTO `ly_spec_attr` VALUES ('16', '2', '12');
INSERT INTO `ly_spec_attr` VALUES ('16', '2', '14');
INSERT INTO `ly_spec_attr` VALUES ('16', '2', '16');
INSERT INTO `ly_spec_attr` VALUES ('16', '6', '43');
INSERT INTO `ly_spec_attr` VALUES ('16', '6', '46');
INSERT INTO `ly_spec_attr` VALUES ('16', '6', '47');
INSERT INTO `ly_spec_attr` VALUES ('16', '6', '48');
INSERT INTO `ly_spec_attr` VALUES ('16', '1073741829', '25');
INSERT INTO `ly_spec_attr` VALUES ('16', '1073741830', '32');
INSERT INTO `ly_spec_attr` VALUES ('17', '2', '5');
INSERT INTO `ly_spec_attr` VALUES ('17', '2', '7');
INSERT INTO `ly_spec_attr` VALUES ('17', '6', '43');
INSERT INTO `ly_spec_attr` VALUES ('17', '6', '45');
INSERT INTO `ly_spec_attr` VALUES ('17', '6', '46');
INSERT INTO `ly_spec_attr` VALUES ('17', '6', '47');
INSERT INTO `ly_spec_attr` VALUES ('17', '6', '48');
INSERT INTO `ly_spec_attr` VALUES ('17', '1073741829', '26');
INSERT INTO `ly_spec_attr` VALUES ('17', '1073741830', '32');
INSERT INTO `ly_spec_attr` VALUES ('18', '2', '5');
INSERT INTO `ly_spec_attr` VALUES ('18', '2', '6');
INSERT INTO `ly_spec_attr` VALUES ('18', '2', '7');
INSERT INTO `ly_spec_attr` VALUES ('18', '2', '10');
INSERT INTO `ly_spec_attr` VALUES ('18', '6', '42');
INSERT INTO `ly_spec_attr` VALUES ('18', '6', '43');
INSERT INTO `ly_spec_attr` VALUES ('18', '6', '44');
INSERT INTO `ly_spec_attr` VALUES ('18', '6', '45');
INSERT INTO `ly_spec_attr` VALUES ('18', '6', '46');
INSERT INTO `ly_spec_attr` VALUES ('18', '6', '47');
INSERT INTO `ly_spec_attr` VALUES ('18', '6', '48');
INSERT INTO `ly_spec_attr` VALUES ('18', '1073741829', '27');
INSERT INTO `ly_spec_attr` VALUES ('18', '1073741830', '32');
INSERT INTO `ly_spec_attr` VALUES ('19', '2', '5');
INSERT INTO `ly_spec_attr` VALUES ('19', '2', '11');
INSERT INTO `ly_spec_attr` VALUES ('19', '6', '42');
INSERT INTO `ly_spec_attr` VALUES ('19', '6', '43');
INSERT INTO `ly_spec_attr` VALUES ('19', '6', '44');
INSERT INTO `ly_spec_attr` VALUES ('19', '6', '45');
INSERT INTO `ly_spec_attr` VALUES ('19', '6', '46');
INSERT INTO `ly_spec_attr` VALUES ('19', '6', '47');
INSERT INTO `ly_spec_attr` VALUES ('19', '1073741829', '25');
INSERT INTO `ly_spec_attr` VALUES ('19', '1073741830', '32');
INSERT INTO `ly_spec_attr` VALUES ('20', '2', '5');
INSERT INTO `ly_spec_attr` VALUES ('20', '6', '43');
INSERT INTO `ly_spec_attr` VALUES ('20', '6', '44');
INSERT INTO `ly_spec_attr` VALUES ('20', '6', '45');
INSERT INTO `ly_spec_attr` VALUES ('20', '6', '47');
INSERT INTO `ly_spec_attr` VALUES ('20', '1073741829', '27');
INSERT INTO `ly_spec_attr` VALUES ('20', '1073741830', '32');
INSERT INTO `ly_spec_attr` VALUES ('21', '2', '11');
INSERT INTO `ly_spec_attr` VALUES ('21', '7', '59');
INSERT INTO `ly_spec_attr` VALUES ('21', '7', '60');
INSERT INTO `ly_spec_attr` VALUES ('21', '7', '61');
INSERT INTO `ly_spec_attr` VALUES ('21', '7', '62');
INSERT INTO `ly_spec_attr` VALUES ('21', '7', '63');
INSERT INTO `ly_spec_attr` VALUES ('21', '1073741831', '43');
INSERT INTO `ly_spec_attr` VALUES ('21', '1073741832', '51');
INSERT INTO `ly_spec_attr` VALUES ('22', '2', '10');
INSERT INTO `ly_spec_attr` VALUES ('22', '2', '11');
INSERT INTO `ly_spec_attr` VALUES ('22', '7', '60');
INSERT INTO `ly_spec_attr` VALUES ('22', '7', '61');
INSERT INTO `ly_spec_attr` VALUES ('22', '7', '62');
INSERT INTO `ly_spec_attr` VALUES ('22', '7', '63');
INSERT INTO `ly_spec_attr` VALUES ('22', '7', '64');
INSERT INTO `ly_spec_attr` VALUES ('22', '7', '65');
INSERT INTO `ly_spec_attr` VALUES ('22', '1073741831', '42');
INSERT INTO `ly_spec_attr` VALUES ('22', '1073741832', '51');
INSERT INTO `ly_spec_attr` VALUES ('23', '2', '10');
INSERT INTO `ly_spec_attr` VALUES ('23', '7', '52');
INSERT INTO `ly_spec_attr` VALUES ('23', '7', '53');
INSERT INTO `ly_spec_attr` VALUES ('23', '7', '54');
INSERT INTO `ly_spec_attr` VALUES ('23', '1073741831', '42');
INSERT INTO `ly_spec_attr` VALUES ('23', '1073741832', '51');
INSERT INTO `ly_spec_attr` VALUES ('24', '2', '10');
INSERT INTO `ly_spec_attr` VALUES ('24', '2', '11');
INSERT INTO `ly_spec_attr` VALUES ('24', '7', '61');
INSERT INTO `ly_spec_attr` VALUES ('24', '7', '62');
INSERT INTO `ly_spec_attr` VALUES ('24', '7', '63');
INSERT INTO `ly_spec_attr` VALUES ('24', '7', '64');
INSERT INTO `ly_spec_attr` VALUES ('24', '7', '65');
INSERT INTO `ly_spec_attr` VALUES ('24', '1073741831', '42');
INSERT INTO `ly_spec_attr` VALUES ('24', '1073741832', '51');
INSERT INTO `ly_spec_attr` VALUES ('25', '2', '10');
INSERT INTO `ly_spec_attr` VALUES ('25', '2', '11');
INSERT INTO `ly_spec_attr` VALUES ('25', '7', '58');
INSERT INTO `ly_spec_attr` VALUES ('25', '7', '59');
INSERT INTO `ly_spec_attr` VALUES ('25', '7', '60');
INSERT INTO `ly_spec_attr` VALUES ('25', '7', '61');
INSERT INTO `ly_spec_attr` VALUES ('25', '1073741831', '42');
INSERT INTO `ly_spec_attr` VALUES ('25', '1073741832', '51');

-- ----------------------------
-- Table structure for `ly_spec_value`
-- ----------------------------
DROP TABLE IF EXISTS `ly_spec_value`;
CREATE TABLE `ly_spec_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `spec_id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `img` varchar(255) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID_NAME` (`spec_id`,`name`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_spec_value
-- ----------------------------
INSERT INTO `ly_spec_value` VALUES ('1', '1', '安卓（Android）', '', '0');
INSERT INTO `ly_spec_value` VALUES ('2', '1', '微软（Windows）', '', '1');
INSERT INTO `ly_spec_value` VALUES ('3', '1', '苹果（IOS）', '', '2');
INSERT INTO `ly_spec_value` VALUES ('4', '1', '其它', '', '3');
INSERT INTO `ly_spec_value` VALUES ('5', '2', '白色', '', '0');
INSERT INTO `ly_spec_value` VALUES ('6', '2', '黑色', '', '1');
INSERT INTO `ly_spec_value` VALUES ('7', '2', '灰色', '', '2');
INSERT INTO `ly_spec_value` VALUES ('8', '2', '金色', '', '3');
INSERT INTO `ly_spec_value` VALUES ('9', '2', '银色', '', '4');
INSERT INTO `ly_spec_value` VALUES ('10', '2', '红色', '', '5');
INSERT INTO `ly_spec_value` VALUES ('11', '2', '蓝色', '', '6');
INSERT INTO `ly_spec_value` VALUES ('12', '2', '粉色', '', '7');
INSERT INTO `ly_spec_value` VALUES ('13', '2', '黄色', '', '8');
INSERT INTO `ly_spec_value` VALUES ('14', '2', '绿色', '', '9');
INSERT INTO `ly_spec_value` VALUES ('15', '2', '橙色', '', '10');
INSERT INTO `ly_spec_value` VALUES ('16', '2', '紫色', '', '11');
INSERT INTO `ly_spec_value` VALUES ('17', '2', '其它', '', '12');
INSERT INTO `ly_spec_value` VALUES ('18', '3', '4G', '', '0');
INSERT INTO `ly_spec_value` VALUES ('19', '3', '8G', '', '1');
INSERT INTO `ly_spec_value` VALUES ('20', '3', '16G', '', '2');
INSERT INTO `ly_spec_value` VALUES ('21', '3', '32G', '', '3');
INSERT INTO `ly_spec_value` VALUES ('22', '3', '64G', '', '4');
INSERT INTO `ly_spec_value` VALUES ('23', '3', '128G', '', '5');
INSERT INTO `ly_spec_value` VALUES ('24', '3', '256G', '', '6');
INSERT INTO `ly_spec_value` VALUES ('25', '3', '512G', '', '7');
INSERT INTO `ly_spec_value` VALUES ('26', '4', 'Android', '', '0');
INSERT INTO `ly_spec_value` VALUES ('27', '4', 'ios系统', '', '1');
INSERT INTO `ly_spec_value` VALUES ('28', '4', 'windows', '', '2');
INSERT INTO `ly_spec_value` VALUES ('29', '4', 'Linux', '', '3');
INSERT INTO `ly_spec_value` VALUES ('30', '4', 'Unix', '', '4');
INSERT INTO `ly_spec_value` VALUES ('31', '5', '6英寸及以下', '', '0');
INSERT INTO `ly_spec_value` VALUES ('32', '5', '7英寸', '', '1');
INSERT INTO `ly_spec_value` VALUES ('33', '5', '7.85英寸', '', '2');
INSERT INTO `ly_spec_value` VALUES ('34', '5', '7.9英寸', '', '3');
INSERT INTO `ly_spec_value` VALUES ('35', '5', '8英寸', '', '4');
INSERT INTO `ly_spec_value` VALUES ('36', '5', '8.3英寸', '', '5');
INSERT INTO `ly_spec_value` VALUES ('37', '5', '9.7英寸', '', '6');
INSERT INTO `ly_spec_value` VALUES ('38', '5', '10.1英寸', '', '7');
INSERT INTO `ly_spec_value` VALUES ('39', '5', '11.6英寸', '', '8');
INSERT INTO `ly_spec_value` VALUES ('40', '5', '12.1英寸', '', '9');
INSERT INTO `ly_spec_value` VALUES ('41', '5', '13英寸及以上', '', '10');
INSERT INTO `ly_spec_value` VALUES ('42', '6', 'XS', '', '0');
INSERT INTO `ly_spec_value` VALUES ('43', '6', 'S', '', '1');
INSERT INTO `ly_spec_value` VALUES ('44', '6', 'M', '', '2');
INSERT INTO `ly_spec_value` VALUES ('45', '6', 'L', '', '3');
INSERT INTO `ly_spec_value` VALUES ('46', '6', 'XL', '', '4');
INSERT INTO `ly_spec_value` VALUES ('47', '6', 'XXL', '', '5');
INSERT INTO `ly_spec_value` VALUES ('48', '6', 'XXXL', '', '6');
INSERT INTO `ly_spec_value` VALUES ('49', '6', '均码', '', '7');
INSERT INTO `ly_spec_value` VALUES ('50', '6', '其它', '', '8');
INSERT INTO `ly_spec_value` VALUES ('51', '7', '165/88A', '', '0');
INSERT INTO `ly_spec_value` VALUES ('52', '7', '170/92A', '', '1');
INSERT INTO `ly_spec_value` VALUES ('53', '7', '175/96A', '', '2');
INSERT INTO `ly_spec_value` VALUES ('54', '7', '180/100A', '', '3');
INSERT INTO `ly_spec_value` VALUES ('55', '7', '185/104A', '', '4');
INSERT INTO `ly_spec_value` VALUES ('56', '7', '190/104', '', '5');
INSERT INTO `ly_spec_value` VALUES ('57', '7', '36', '', '6');
INSERT INTO `ly_spec_value` VALUES ('58', '7', '37', '', '7');
INSERT INTO `ly_spec_value` VALUES ('59', '7', '38', '', '8');
INSERT INTO `ly_spec_value` VALUES ('60', '7', '39', '', '9');
INSERT INTO `ly_spec_value` VALUES ('61', '7', '40', '', '10');
INSERT INTO `ly_spec_value` VALUES ('62', '7', '41', '', '11');
INSERT INTO `ly_spec_value` VALUES ('63', '7', '42', '', '12');
INSERT INTO `ly_spec_value` VALUES ('64', '7', '43', '', '13');
INSERT INTO `ly_spec_value` VALUES ('65', '7', '44', '', '14');
INSERT INTO `ly_spec_value` VALUES ('66', '7', '45', '', '15');
INSERT INTO `ly_spec_value` VALUES ('67', '7', '46', '', '16');
INSERT INTO `ly_spec_value` VALUES ('68', '7', '47', '', '17');

-- ----------------------------
-- Table structure for `ly_tags`
-- ----------------------------
DROP TABLE IF EXISTS `ly_tags`;
CREATE TABLE `ly_tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `num` bigint(20) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `is_hot` int(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_tags
-- ----------------------------
INSERT INTO `ly_tags` VALUES ('2', 'iphone', '8', '0', '0');

-- ----------------------------
-- Table structure for `ly_user`
-- ----------------------------
DROP TABLE IF EXISTS `ly_user`;
CREATE TABLE `ly_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `password` char(32) NOT NULL,
  `email` varchar(250) NOT NULL,
  `head_pic` varchar(250) DEFAULT NULL,
  `validcode` varchar(40) NOT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `USEREMAIL` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_user
-- ----------------------------
INSERT INTO `ly_user` VALUES ('2', 'crazyly', '407bdca298efe8efa521b7f82fa59201', '653541415@qq.com', null, '=@EUtgV0', '1');
INSERT INTO `ly_user` VALUES ('3', '1052875589@qq.com', '4840c1287a35f9c6f2543e7d874f9947', '1052875589@qq.com', null, '6X(}Q=o-', '0');
INSERT INTO `ly_user` VALUES ('5', '653541412@qq.com', 'bc5a038fbda395886c9e9c1ce64527cb', '653541412@qq.com', 'data/uploads/head/1023/1023/2047/e4da3b7fbbce2345d7772b0674a318d5.png', '6lE\"chKo', '1');

-- ----------------------------
-- Table structure for `ly_virtual_goods`
-- ----------------------------
DROP TABLE IF EXISTS `ly_virtual_goods`;
CREATE TABLE `ly_virtual_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `template_id` bigint(20) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `value` float(10,2) DEFAULT '0.00',
  `account` varchar(40) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_virtual_goods
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_virtual_template`
-- ----------------------------
DROP TABLE IF EXISTS `ly_virtual_template`;
CREATE TABLE `ly_virtual_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `value` float(10,2) DEFAULT '0.00',
  `valid_days` int(11) DEFAULT NULL,
  `auto` int(1) DEFAULT '0',
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_virtual_template
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_voucher`
-- ----------------------------
DROP TABLE IF EXISTS `ly_voucher`;
CREATE TABLE `ly_voucher` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `account` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `value` float(10,2) DEFAULT '0.00',
  `money` int(11) DEFAULT '0',
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `status` tinyint(1) DEFAULT '0',
  `is_send` tinyint(1) DEFAULT '0',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `VOUCHER_ACCOUNT` (`account`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_voucher
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_voucher_template`
-- ----------------------------
DROP TABLE IF EXISTS `ly_voucher_template`;
CREATE TABLE `ly_voucher_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `point` int(11) DEFAULT '0',
  `value` float(10,2) DEFAULT '0.00',
  `money` int(11) DEFAULT '0',
  `valid_days` int(11) DEFAULT '30',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_voucher_template
-- ----------------------------
INSERT INTO `ly_voucher_template` VALUES ('1', '伍元券', '0', '5.00', '200', '60');

-- ----------------------------
-- Table structure for `ly_withdraw`
-- ----------------------------
DROP TABLE IF EXISTS `ly_withdraw`;
CREATE TABLE `ly_withdraw` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `amount` float(10,2) DEFAULT '0.00',
  `name` varchar(255) DEFAULT NULL,
  `type_name` varchar(255) DEFAULT NULL,
  `account` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `re_note` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_withdraw
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_wx_context`
-- ----------------------------
DROP TABLE IF EXISTS `ly_wx_context`;
CREATE TABLE `ly_wx_context` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `public_id` bigint(20) DEFAULT NULL,
  `open_id` varchar(64) DEFAULT NULL,
  `current_key` varchar(64) DEFAULT NULL,
  `command` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_wx_context
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_wx_public`
-- ----------------------------
DROP TABLE IF EXISTS `ly_wx_public`;
CREATE TABLE `ly_wx_public` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `gid` varbinary(32) DEFAULT NULL,
  `token` varchar(32) DEFAULT NULL,
  `app_id` varchar(32) DEFAULT NULL,
  `app_secret` varchar(32) DEFAULT NULL,
  `access_token` varchar(1024) DEFAULT NULL,
  `type` enum('subscribe','service') DEFAULT NULL,
  `certified` enum('0','1') DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `menus` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_wx_public
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_wx_response`
-- ----------------------------
DROP TABLE IF EXISTS `ly_wx_response`;
CREATE TABLE `ly_wx_response` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `public_id` bigint(20) DEFAULT '0',
  `title` varchar(100) DEFAULT NULL,
  `event_key` varchar(128) DEFAULT NULL,
  `type` enum('text','image','news','voice','video','music','link','app') DEFAULT 'text',
  `content` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`public_id`,`event_key`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_wx_response
-- ----------------------------

-- ----------------------------
-- Table structure for `ly_zoning`
-- ----------------------------
DROP TABLE IF EXISTS `ly_zoning`;
CREATE TABLE `ly_zoning` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `provinces` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_zoning
-- ----------------------------
INSERT INTO `ly_zoning` VALUES ('12', '华东', '310000,320000,330000,340000,360000');
INSERT INTO `ly_zoning` VALUES ('13', '华北', '110000,120000,130000,140000,150000,370000');
INSERT INTO `ly_zoning` VALUES ('14', '华中', '410000,420000,430000');
INSERT INTO `ly_zoning` VALUES ('15', '华南', '350000,440000,450000,460000');
INSERT INTO `ly_zoning` VALUES ('16', '东北', '210000,220000,230000');
INSERT INTO `ly_zoning` VALUES ('17', '西北', '610000,620000,630000,640000,650000');
INSERT INTO `ly_zoning` VALUES ('18', '西南', '500000,510000,520000,530000,540000');
INSERT INTO `ly_zoning` VALUES ('20', '港澳台', '710000,810000,820000');
