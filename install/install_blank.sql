/*
Navicat MySQL Data Transfer

Source Server         : wamp
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : demo

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2016-09-02 10:42:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for %DB_PREFIX%admin
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%admin`;
CREATE TABLE `%DB_PREFIX%admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adm_name` varchar(255) NOT NULL COMMENT '管理员用户名',
  `adm_password` varchar(255) NOT NULL COMMENT '管理员密码',
  `is_effect` tinyint(1) NOT NULL COMMENT '有效性控制',
  `is_delete` tinyint(1) NOT NULL COMMENT '删除标识',
  `role_id` int(11) NOT NULL COMMENT '角色ID(权限控制用)',
  `login_time` int(11) NOT NULL COMMENT '最后登录时间',
  `login_ip` varchar(255) NOT NULL COMMENT '最后登录IP',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_adm_name` (`adm_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='后台管理员表';

-- ----------------------------
-- Records of %DB_PREFIX%admin
-- ----------------------------
INSERT INTO `%DB_PREFIX%admin` VALUES ('1', 'admin', '21232f297a57a5a743894a0e4a801fc3', '1', '0', '4', '1461382222', '0.0.0.0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%adv`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%adv`;
CREATE TABLE `%DB_PREFIX%adv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) NOT NULL COMMENT '广告图片',
  `url` varchar(255) NOT NULL COMMENT '地址',
  `u_module` varchar(255) NOT NULL,
  `u_action` varchar(255) NOT NULL,
  `u_param` varchar(255) NOT NULL,
  `app_index` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL COMMENT '有效性控制标识',
  `name` varchar(255) NOT NULL COMMENT '广告位名称，用于后台管理查询用',
  `group` varchar(255) NOT NULL COMMENT '广告位归组',
  `page_module` varchar(255) NOT NULL,
  `page_name` varchar(255) NOT NULL COMMENT '页面名称',
  `sort` int(11) NOT NULL COMMENT '顺序（由小到大，该类型广告的显示顺序）',
  `cate_id` int(11) NOT NULL COMMENT '分类id，定位用',
  PRIMARY KEY (`id`),
  KEY `page_module` (`page_module`),
  KEY `group` (`group`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='广告位表';

-- ----------------------------
-- Table structure for %DB_PREFIX%agreement
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%agreement`;
CREATE TABLE `%DB_PREFIX%agreement` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `agreement` text NOT NULL COMMENT '服务协议&公告',
  `agreement_name` varchar(255) NOT NULL COMMENT '名称',
  `agreement_cate` varchar(32) NOT NULL,
  `sort` int(11) NOT NULL COMMENT '排序',
  `is_effect` tinyint(1) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for %DB_PREFIX%api_log
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%api_log`;
CREATE TABLE `%DB_PREFIX%api_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `act` varchar(30) NOT NULL,
  `api` text NOT NULL,
  `param_json` text NOT NULL,
  `param_array` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='移动端的调试日志表';

-- ----------------------------
-- Table structure for %DB_PREFIX%article
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%article`;
CREATE TABLE `%DB_PREFIX%article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '文章标题',
  `content` text NOT NULL COMMENT '文章内容',
  `cate_id` int(11) NOT NULL COMMENT '文章分类ID',
  `create_time` int(11) NOT NULL COMMENT '发表时间',
  `sort` int(11) NOT NULL COMMENT '排序 由大到小',
  `seo_title` text NOT NULL COMMENT '自定义seo页面标题',
  `seo_keyword` text NOT NULL COMMENT '自定义seo页面keyword',
  `seo_description` text NOT NULL COMMENT '自定义seo页面标述',
  `is_effect` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1为有效，0为无效',
  `click_count` int(11) NOT NULL DEFAULT '0' COMMENT '点击量',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`),
  KEY `create_time` (`create_time`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='帮助文章表';

-- ----------------------------
-- Table structure for %DB_PREFIX%article_cate
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%article_cate`;
CREATE TABLE `%DB_PREFIX%article_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '分类名称',
  `sort` int(11) NOT NULL,
  `iconfont` varchar(15) NOT NULL COMMENT '针对帮助文档分类的图标',
  PRIMARY KEY (`id`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT=' 帮助分类表';

-- ----------------------------
-- Table structure for %DB_PREFIX%brand
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%brand`;
CREATE TABLE `%DB_PREFIX%brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '品牌名称',
  `logo` varchar(255) NOT NULL COMMENT '品牌logo',
  `sort` int(11) NOT NULL COMMENT '排序(由大到小)',
  `deal_cate_id` int(11) NOT NULL COMMENT '所属的分类，用于前台分类展示用',
  PRIMARY KEY (`id`),
  KEY `shop_cate_id` (`deal_cate_id`),
  KEY `deal_cate_id` (`deal_cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='品牌配置表';

-- ----------------------------
-- Table structure for %DB_PREFIX%conf
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%conf`;
CREATE TABLE `%DB_PREFIX%conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `group_id` int(11) NOT NULL,
  `input_type` tinyint(1) NOT NULL COMMENT '配置输入的类型 0:文本输入 1:下拉框输入 2:图片上传 3:编辑器',
  `value_scope` text NOT NULL COMMENT '取值范围',
  `is_effect` tinyint(1) NOT NULL,
  `is_conf` tinyint(1) NOT NULL COMMENT '1:可配置  0:不可配置',
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- ----------------------------
-- Records of %DB_PREFIX%conf
-- ----------------------------
INSERT INTO `%DB_PREFIX%conf` VALUES ('1', 'DEFAULT_ADMIN', 'admin', '1', '0', '', '1', '0', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('2', 'URL_MODEL', '0', '1', '1', '0,1', '1', '0', '3');
INSERT INTO `%DB_PREFIX%conf` VALUES ('4', 'TIME_ZONE', '8', '1', '1', '0,8', '1', '1', '1');
INSERT INTO `%DB_PREFIX%conf` VALUES ('5', 'ADMIN_LOG', '1', '1', '1', '0,1', '0', '1', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('6', 'DB_VERSION', '1.72', '0', '0', '', '1', '0', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('7', 'DB_VOL_MAXSIZE', '8000000', '1', '0', '', '1', '1', '11');
INSERT INTO `%DB_PREFIX%conf` VALUES ('8', 'WATER_MARK', './public/attachment/201011/4cdde85a27105.gif', '2', '2', '', '1', '1', '48');
INSERT INTO `%DB_PREFIX%conf` VALUES ('24', 'CURRENCY_UNIT', '夺宝币', '3', '0', '', '1', '0', '21');
INSERT INTO `%DB_PREFIX%conf` VALUES ('10', 'BIG_WIDTH', '500', '2', '0', '', '0', '0', '49');
INSERT INTO `%DB_PREFIX%conf` VALUES ('11', 'BIG_HEIGHT', '500', '2', '0', '', '0', '0', '50');
INSERT INTO `%DB_PREFIX%conf` VALUES ('12', 'SMALL_WIDTH', '200', '2', '0', '', '0', '0', '51');
INSERT INTO `%DB_PREFIX%conf` VALUES ('13', 'SMALL_HEIGHT', '200', '2', '0', '', '0', '0', '52');
INSERT INTO `%DB_PREFIX%conf` VALUES ('14', 'WATER_ALPHA', '50', '2', '0', '', '1', '1', '53');
INSERT INTO `%DB_PREFIX%conf` VALUES ('15', 'WATER_POSITION', '4', '2', '1', '1,2,3,4,5', '1', '1', '54');
INSERT INTO `%DB_PREFIX%conf` VALUES ('16', 'MAX_IMAGE_SIZE', '2000000', '2', '0', '', '1', '1', '55');
INSERT INTO `%DB_PREFIX%conf` VALUES ('18', 'MAX_FILE_SIZE', '1', '1', '0', '', '0', '1', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('19', 'ALLOW_FILE_EXT', '1', '1', '0', '', '0', '1', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('20', 'BG_COLOR', '#ffffff', '2', '0', '', '0', '0', '57');
INSERT INTO `%DB_PREFIX%conf` VALUES ('21', 'IS_WATER_MARK', '1', '2', '1', '0,1', '1', '1', '58');
INSERT INTO `%DB_PREFIX%conf` VALUES ('22', 'TEMPLATE', 'fanwe', '3', '0', '', '1', '1', '17');
INSERT INTO `%DB_PREFIX%conf` VALUES ('25', 'SCORE_UNIT', '积分', '3', '0', '', '1', '0', '22');
INSERT INTO `%DB_PREFIX%conf` VALUES ('26', 'USER_VERIFY', '1', '4', '1', '0,1', '1', '0', '63');
INSERT INTO `%DB_PREFIX%conf` VALUES ('27', 'SHOP_LOGO', '', '3', '2', '', '1', '1', '19');
INSERT INTO `%DB_PREFIX%conf` VALUES ('28', 'SHOP_LANG', 'zh-cn', '3', '1', 'zh-cn', '1', '0', '18');
INSERT INTO `%DB_PREFIX%conf` VALUES ('29', 'SHOP_TITLE', '方维一元夺宝系统', '3', '0', '', '1', '1', '13');
INSERT INTO `%DB_PREFIX%conf` VALUES ('30', 'SHOP_KEYWORD', '方维一元夺宝系统', '3', '0', '', '1', '1', '15');
INSERT INTO `%DB_PREFIX%conf` VALUES ('31', 'SHOP_DESCRIPTION', '方维一元夺宝系统', '3', '0', '', '1', '1', '15');
INSERT INTO `%DB_PREFIX%conf` VALUES ('32', 'SHOP_TEL', '400-800-8888', '3', '0', '', '1', '1', '23');
INSERT INTO `%DB_PREFIX%conf` VALUES ('33', 'SIDE_DEAL_COUNT', '3', '3', '0', '', '1', '0', '29');
INSERT INTO `%DB_PREFIX%conf` VALUES ('34', 'SIDE_MESSAGE_COUNT', '3', '3', '0', '', '1', '0', '30');
INSERT INTO `%DB_PREFIX%conf` VALUES ('38', 'ONLINE_QQ', '800005515|800005515', '3', '0', '', '0', '1', '25');
INSERT INTO `%DB_PREFIX%conf` VALUES ('39', 'ONLINE_TIME', '周一至周六 9:00-18:00', '3', '0', '', '1', '1', '26');
INSERT INTO `%DB_PREFIX%conf` VALUES ('44', 'SHOP_FOOTER', '<div style=\"text-align:center;\">【方维一元夺宝系统】 <a href=\"http://www.fanwe.com\" target=\"_blank\">http://www.fanwe.com</a><br />\n</div>\n', '3', '3', '', '1', '1', '37');
INSERT INTO `%DB_PREFIX%conf` VALUES ('50', 'MAIL_SEND_PAYMENT', '0', '5', '1', '0,1', '1', '1', '75');
INSERT INTO `%DB_PREFIX%conf` VALUES ('51', 'SMS_SEND_PAYMENT', '0', '5', '1', '0,1', '1', '1', '81');
INSERT INTO `%DB_PREFIX%conf` VALUES ('62', 'REPLY_ADDRESS', 'info@fanwe.com', '5', '0', '', '1', '1', '77');
INSERT INTO `%DB_PREFIX%conf` VALUES ('54', 'MAIL_SEND_DELIVERY', '0', '5', '1', '0,1', '1', '1', '76');
INSERT INTO `%DB_PREFIX%conf` VALUES ('55', 'SMS_SEND_DELIVERY', '0', '5', '1', '0,1', '1', '1', '82');
INSERT INTO `%DB_PREFIX%conf` VALUES ('56', 'MAIL_ON', '1', '5', '1', '0,1', '1', '1', '72');
INSERT INTO `%DB_PREFIX%conf` VALUES ('57', 'SMS_ON', '1', '5', '1', '0,1', '1', '1', '78');
INSERT INTO `%DB_PREFIX%conf` VALUES ('63', 'BATCH_PAGE_SIZE', '500', '3', '0', '', '1', '0', '33');
INSERT INTO `%DB_PREFIX%conf` VALUES ('71', 'SUBMIT_DELAY', '5', '1', '0', '', '1', '0', '13');
INSERT INTO `%DB_PREFIX%conf` VALUES ('76', 'FOOTER_LOGO', '', '3', '2', '', '1', '1', '20');
INSERT INTO `%DB_PREFIX%conf` VALUES ('77', 'GZIP_ON', '1', '1', '1', '0,1', '1', '1', '2');
INSERT INTO `%DB_PREFIX%conf` VALUES ('78', 'INTEGRATE_CODE', '', '0', '0', '', '1', '0', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('79', 'INTEGRATE_CFG', '', '0', '0', '', '1', '0', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('80', 'SHOP_SEO_TITLE', '方维一元夺宝系统', '3', '0', '', '1', '1', '14');
INSERT INTO `%DB_PREFIX%conf` VALUES ('81', 'CACHE_ON', '1', '1', '1', '0,1', '1', '0', '7');
INSERT INTO `%DB_PREFIX%conf` VALUES ('82', 'EXPIRED_TIME', '0', '1', '0', '', '1', '0', '5');
INSERT INTO `%DB_PREFIX%conf` VALUES ('120', 'FILTER_WORD', '', '1', '0', '', '1', '1', '100');
INSERT INTO `%DB_PREFIX%conf` VALUES ('85', 'STYLE_DEFAULT', '1', '3', '1', '0,1', '0', '0', '45');
INSERT INTO `%DB_PREFIX%conf` VALUES ('86', 'TMPL_DOMAIN_ROOT', '', '2', '0', '0', '0', '0', '62');
INSERT INTO `%DB_PREFIX%conf` VALUES ('94', 'ICP_LICENSE', '', '3', '0', '', '1', '1', '27');
INSERT INTO `%DB_PREFIX%conf` VALUES ('95', 'COUNT_CODE', '', '3', '0', '', '1', '1', '28');
INSERT INTO `%DB_PREFIX%conf` VALUES ('101', 'KUAIDI_APP_KEY', '', '1', '0', '', '1', '1', '83');
INSERT INTO `%DB_PREFIX%conf` VALUES ('102', 'KUAIDI_TYPE', '2', '1', '1', '1,2,3', '1', '1', '84');
INSERT INTO `%DB_PREFIX%conf` VALUES ('103', 'SEND_SPAN', '2', '1', '0', '', '1', '1', '85');
INSERT INTO `%DB_PREFIX%conf` VALUES ('119', 'TMPL_CACHE_ON', '1', '1', '1', '0,1', '1', '0', '6');
INSERT INTO `%DB_PREFIX%conf` VALUES ('121', 'USER_LOGIN_SCORE', '1', '6', '0', '', '1', '1', '2');
INSERT INTO `%DB_PREFIX%conf` VALUES ('123', 'USER_REGISTER_SCORE', '2', '6', '0', '', '1', '1', '8');
INSERT INTO `%DB_PREFIX%conf` VALUES ('125', 'DOMAIN_ROOT', '', '1', '0', '', '1', '0', '10');
INSERT INTO `%DB_PREFIX%conf` VALUES ('128', 'VERIFY_IMAGE', '0', '1', '1', '0,1', '1', '0', '10');
INSERT INTO `%DB_PREFIX%conf` VALUES ('185', 'USER_INVITE_SCORE', '2', '6', '0', '', '1', '1', '9');
INSERT INTO `%DB_PREFIX%conf` VALUES ('138', 'USER_LOGIN_KEEP_SCORE', '2', '6', '0', '', '1', '1', '5');
INSERT INTO `%DB_PREFIX%conf` VALUES ('141', 'USER_ACTIVE_SCORE', '1', '6', '0', '', '1', '1', '11');
INSERT INTO `%DB_PREFIX%conf` VALUES ('144', 'USER_ACTIVE_SCORE_MAX', '100', '6', '0', '', '1', '1', '14');
INSERT INTO `%DB_PREFIX%conf` VALUES ('167', 'APPLE_PATH', 'ios', '3', '0', ' ', '1', '0', '101');
INSERT INTO `%DB_PREFIX%conf` VALUES ('168', 'ANDROID_PATH', 'android', '3', '0', ' ', '1', '0', '102');
INSERT INTO `%DB_PREFIX%conf` VALUES ('183', 'TENCENT_MAP_APPKEY', 'YKCBZ-OKT3G-VLAQY-IWFUI-TRR55-PWFEX', '1', '0', '', '1', '1', '35');
INSERT INTO `%DB_PREFIX%conf` VALUES ('187', 'WEIXIN_APPID', '', '1', '0', '', '0', '1', '85');
INSERT INTO `%DB_PREFIX%conf` VALUES ('188', 'WEIXIN_APPSCECRET', '', '1', '0', '', '0', '1', '86');
INSERT INTO `%DB_PREFIX%conf` VALUES ('189', 'PAGE_SIZE', '10', '3', '0', '', '1', '1', '31');
INSERT INTO `%DB_PREFIX%conf` VALUES ('190', 'DEAL_PAGE_SIZE', '20', '3', '0', '', '1', '1', '31');
INSERT INTO `%DB_PREFIX%conf` VALUES ('191', 'HELP_ITEM_LIMIT', '4', '3', '0', '', '1', '0', '31');
INSERT INTO `%DB_PREFIX%conf` VALUES ('192', 'HELP_CATE_LIMIT', '4', '3', '0', '', '1', '0', '31');
INSERT INTO `%DB_PREFIX%conf` VALUES ('193', "ROBOT_LOGO_SORT", '0', '1', '1', '', '0', '0', '103');

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal`;
CREATE TABLE `%DB_PREFIX%deal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL COMMENT '商品名称',
  `cate_id` int(11) NOT NULL COMMENT '分类ID',
  `description` text NOT NULL COMMENT '信息描述详情',
  `origin_price` decimal(20,4) NOT NULL COMMENT '原价',
  `current_price` decimal(20,4) NOT NULL COMMENT '当前销售价',
  `is_effect` tinyint(1) NOT NULL COMMENT '有效性标识',
  `brief` text NOT NULL COMMENT '商品简介',
  `icon` varchar(255) NOT NULL COMMENT '小图',
  `create_time` int(11) NOT NULL COMMENT '管理员发布时间',
  `brand_id` int(11) NOT NULL COMMENT '所归属的品牌',
  `sale_count` int(11) NOT NULL COMMENT '销量',
  `total_buy_stock` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '直购库存',
  PRIMARY KEY (`id`),
  KEY `shop_cate_id` (`is_effect`),
  KEY `cate_id` (`is_effect`,`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='商品库';

-- ----------------------------
-- Table structure for %DB_PREFIX%deal_cart
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_cart`;
CREATE TABLE `%DB_PREFIX%deal_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL COMMENT '当前用户的sessionID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `deal_id` int(11) NOT NULL COMMENT '产品ID',
  `duobao_id` int(11) NOT NULL COMMENT '夺宝计划ID',
  `duobao_item_id` int(11) NOT NULL COMMENT '夺宝具体期数ID',
  `name` text NOT NULL COMMENT '购买的产品显示名称(包含购买的规格)',
  `unit_price` decimal(20,4) NOT NULL COMMENT '单价',
  `number` int(11) NOT NULL COMMENT '数量',
  `total_price` decimal(20,4) NOT NULL COMMENT '总价',
  `create_time` int(11) NOT NULL COMMENT '加入购物车的时间',
  `update_time` int(11) NOT NULL COMMENT '更新的时间',
  `return_score` int(11) NOT NULL COMMENT '返积分的单价',
  `return_total_score` int(11) NOT NULL COMMENT '返积分的总价',
  `deal_icon` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL DEFAULT '1' COMMENT '该购物记录是否有效',
  `is_total_buy` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1为直购',
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`),
  KEY `user_id` (`user_id`),
  KEY `deal_id` (`deal_id`),
  KEY `update_time` (`update_time`),
  KEY `duobao_id` (`duobao_id`),
  KEY `duobao_item_id` (`duobao_item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='购物车表';

-- ----------------------------
-- Table structure for %DB_PREFIX%deal_cate
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_cate`;
CREATE TABLE `%DB_PREFIX%deal_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '分类名称',
  `sort` int(11) NOT NULL COMMENT '排序 由大到小',
  `iconfont` varchar(15) NOT NULL COMMENT '图标',
  `is_effect` tinyint(1) NOT NULL,
  `iconcolor` varchar(15) NOT NULL COMMENT '图标，分类的颜色',
  `icon` varchar(255) NOT NULL COMMENT '小图',
  `is_fictitious` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为虚拟商品。1为虚拟商品',
  PRIMARY KEY (`id`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='生活服务分类表';

-- ----------------------------
-- Table structure for %DB_PREFIX%deal_gallery
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_gallery`;
CREATE TABLE `%DB_PREFIX%deal_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` varchar(255) NOT NULL,
  `deal_id` int(11) NOT NULL,
  `sort` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='商品图集表';

-- ----------------------------
-- Table structure for %DB_PREFIX%deal_order
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_order`;
CREATE TABLE `%DB_PREFIX%deal_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(255) NOT NULL COMMENT '订单编号',
  `type` tinyint(1) NOT NULL COMMENT '订单类型(0:商品订单 1:用户充值单 2:夺宝订单 3:直购订单)',
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `create_time` int(11) NOT NULL COMMENT '下单时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `pay_status` tinyint(1) NOT NULL COMMENT '支付状态 0:未支付 1:部份付款(先用余额/代金券支付部份) 2:全部付款',
  `total_price` decimal(20,4) NOT NULL COMMENT '应付总额',
  `pay_amount` decimal(20,4) NOT NULL COMMENT '已付总额 当pay_amount = total_price 支付成功',
  `delivery_status` tinyint(1) NOT NULL COMMENT '发货状态 0:未发货 1:部份发货 2:全部发货 5:无需发货的订单',
  `order_status` tinyint(1) NOT NULL COMMENT '订单状态 0:开放状态（可操作不可删除） 1:结单（不可操作可删除） 2:订单关闭  3：已过期',
  `is_delete` tinyint(1) NOT NULL COMMENT '删除标识',
  `return_total_score` int(11) NOT NULL COMMENT '返给用户的总积分',
  `refund_amount` decimal(20,4) NOT NULL COMMENT '已退款总额',
  `admin_memo` text NOT NULL COMMENT '管理员的备注',
  `memo` text NOT NULL COMMENT '用户下单的备注',
  `region_info` varchar(255) NOT NULL COMMENT '配送地址信息，中奖后手动完善，默认生成时取默认配送地址',
  `address` text NOT NULL COMMENT '配送地址',
  `mobile` varchar(255) NOT NULL COMMENT '联系人手机',
  `zip` varchar(255) NOT NULL COMMENT '联系人邮编',
  `consignee` varchar(255) NOT NULL COMMENT '收货人姓名',
  `ecv_id` int(11) NOT NULL COMMENT '支付所用的代金券ID',
  `ecv_money` decimal(20,4) NOT NULL COMMENT '代金券支付部份的金额',
  `account_money` decimal(20,4) NOT NULL COMMENT '余额支付部份的金额',
  `payment_id` int(11) NOT NULL COMMENT '支付方式',
  `extra_status` tinyint(1) NOT NULL COMMENT '额外的订单标识 0:正常的订单 1.金额超额产生退款的订单（多次支付，重付通知） 2.发货失败退款（下单时库存足够，支付成功后库存不足，自动退款到用户的订单）',
  `bank_id` varchar(255) NOT NULL COMMENT '银行直连支付的银行编号',
  `referer` varchar(255) NOT NULL COMMENT '订单的来路 url',
  `duobao_ip` varchar(255) NOT NULL COMMENT '夺宝归属IP',
  `duobao_area` varchar(255) NOT NULL COMMENT '夺宝归属地',
  `a_create_time` decimal(20,3) NOT NULL COMMENT '开奖时间A数值',
  `create_date_ymd` varchar(15) NOT NULL COMMENT '中奖订单为中奖时间，夺宝订单为支付',
  `create_date_ym` varchar(15) NOT NULL,
  `create_date_y` int(4) NOT NULL,
  `create_date_m` int(2) NOT NULL,
  `create_date_d` int(2) NOT NULL,
  PRIMARY KEY (`id`,`user_id`),
  UNIQUE KEY `unique_sn` (`order_sn`),
  KEY `order_sn` (`order_sn`),
  KEY `type` (`type`),
  KEY `user_id` (`user_id`),
  KEY `pay_status` (`pay_status`),
  KEY `delivery_status` (`delivery_status`),
  KEY `order_status` (`order_status`),
  KEY `is_delete` (`is_delete`),
  KEY `extra_status` (`extra_status`),
  KEY `create_date_ymd` (`create_date_ymd`),
  KEY `create_date_ym` (`create_date_ym`),
  KEY `create_date_y` (`create_date_y`),
  KEY `create_date_m` (`create_date_m`),
  KEY `create_date_d` (`create_date_d`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Table structure for %DB_PREFIX%deal_order_item
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_order_item`;
CREATE TABLE `%DB_PREFIX%deal_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL COMMENT '商品ID',
  `duobao_id` int(11) NOT NULL COMMENT '夺宝活动ID',
  `duobao_item_id` int(11) NOT NULL COMMENT '夺宝活动具体期数ID',
  `number` int(11) NOT NULL COMMENT '购买的数量',
  `unit_price` decimal(20,4) NOT NULL COMMENT '单价',
  `total_price` decimal(20,4) NOT NULL COMMENT '总价',
  `delivery_status` tinyint(1) NOT NULL COMMENT '发货状态 0:未发货 1:已发货 5.无需发货',
  `name` text NOT NULL COMMENT '产品名称',
  `return_score` int(11) NOT NULL COMMENT '返积分单价',
  `return_total_score` int(11) NOT NULL COMMENT '返积分总价',
  `verify_code` varchar(255) NOT NULL COMMENT '唯一标识码（产品ID+属性ID加密）',
  `order_sn` varchar(255) NOT NULL,
  `order_id` int(11) NOT NULL COMMENT '所属的订单ID',
  `is_arrival` tinyint(1) NOT NULL COMMENT '是否已收货0:未收货1:已收货2:没收到货',
  `refund_status` tinyint(1) NOT NULL COMMENT '0:无  2:已退款',
  `deal_icon` varchar(255) NOT NULL COMMENT '商品图',
  `user_id` int(11) NOT NULL COMMENT '所属的用户ID',
  `lottery_sn_send` tinyint(1) NOT NULL COMMENT '是否已经发放幸运号',
  `lottery_sn` int(11) NOT NULL COMMENT '用于中奖订单使用的中奖号',
  `order_ip` varchar(255) NOT NULL COMMENT '订单归属IP',
  `order_to_area` varchar(255) NOT NULL COMMENT '订单归属地',
  `duobao_ip` varchar(255) NOT NULL COMMENT '夺宝归属IP',
  `duobao_area` varchar(255) NOT NULL COMMENT '夺宝归属地',
  `create_time` decimal(20,3) NOT NULL COMMENT '下单时间',
  `type` tinyint(1) NOT NULL COMMENT '由订单处冗余，2表示为夺宝订单',
  `pay_status` tinyint(1) NOT NULL COMMENT '支付状态，冗余',
  `user_name` varchar(255) NOT NULL COMMENT '用户名',
  `lottery_sn_data` longtext NOT NULL COMMENT '夺宝号冗余字段',
  `create_date_ymd` varchar(15) NOT NULL COMMENT '中奖订单为中奖时间与发货时间，夺宝订单为开奖时间',
  `create_date_ym` varchar(15) NOT NULL,
  `create_date_y` int(4) NOT NULL,
  `create_date_m` int(2) NOT NULL,
  `create_date_d` int(2) NOT NULL,
  `origin_price` decimal(20,4) NOT NULL DEFAULT '0.0000' COMMENT '商品原有价格',
  `is_set_consignee` tinyint(1) DEFAULT '0' COMMENT '是否选择了配送方式',
  `buy_create_time` varchar(255) DEFAULT '0' COMMENT '下单时候的时间',
  `buy_number` int(11) DEFAULT '0' COMMENT '中奖号对应下单的数量',
  `admin_memo` text NOT NULL COMMENT '管理员的备注',
  `memo` text NOT NULL COMMENT '用户下单的备注',
  `region_info` varchar(255) NOT NULL COMMENT '配送地址信息，中奖后手动完善，默认生成时取默认配送地址',
  `address` text NOT NULL COMMENT '配送地址',
  `mobile` varchar(255) NOT NULL COMMENT '联系人手机',
  `zip` varchar(255) NOT NULL COMMENT '联系人邮编',
  `consignee` varchar(255) NOT NULL COMMENT '收货人姓名',
  `is_send_share` tinyint(1) DEFAULT '0' COMMENT '是否已经晒单',
  `duobao_status` tinyint(1) NOT NULL COMMENT '同步的夺宝状态\r\n0.进度未满\r\n1.进度已满，等待开奖\r\n2.已开奖',
  `success_time_50` decimal(20,4) DEFAULT '0.0000' COMMENT '50条记录使用的下单时间毫秒值',
  `is_read` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1已经提示过了，判断用户中奖是否提示过了',
  PRIMARY KEY (`id`,`user_id`),
  KEY `deal_id` (`deal_id`),
  KEY `order_id` (`order_id`),
  KEY `verify_code` (`verify_code`),
  KEY `delivery_status` (`delivery_status`),
  KEY `order_sn` (`order_sn`),
  KEY `user_id` (`user_id`),
  KEY `duobao_id` (`duobao_id`),
  KEY `duobao_item_id` (`duobao_item_id`),
  KEY `type` (`type`),
  KEY `create_date_ymd` (`create_date_ymd`),
  KEY `create_date_ym` (`create_date_ym`),
  KEY `create_date_y` (`create_date_y`),
  KEY `create_date_m` (`create_date_m`),
  KEY `create_date_d` (`create_date_d`),
  KEY `lottery_sn` (`lottery_sn`),
  KEY `create_time` (`create_time`),
  KEY `duobao_status` (`duobao_status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='订单产品表';

-- ----------------------------
-- Table structure for %DB_PREFIX%deal_order_log
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_order_log`;
CREATE TABLE `%DB_PREFIX%deal_order_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_info` text NOT NULL,
  `log_time` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='订单操作的日志表';

-- ----------------------------
-- Table structure for %DB_PREFIX%delivery_notice
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%delivery_notice`;
CREATE TABLE `%DB_PREFIX%delivery_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notice_sn` varchar(255) NOT NULL COMMENT '快递单号',
  `delivery_time` int(11) NOT NULL COMMENT '发货时间',
  `is_arrival` tinyint(1) NOT NULL COMMENT '是否已收货0:未收货1:已收货2:没收到货',
  `arrival_time` int(11) NOT NULL COMMENT '收货时间',
  `order_item_id` int(11) NOT NULL COMMENT '发货的订单商品ID',
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `memo` text NOT NULL COMMENT '发货说明备注',
  `express_id` int(11) NOT NULL COMMENT '快递接口ID（用于查询快递与打印快递单）',
  `delivery_supplier_id` int(11) NOT NULL COMMENT '发货的商家账号ID',
  `location_id` int(11) NOT NULL COMMENT '发货的门店点',
  `deal_id` int(11) NOT NULL COMMENT '发货的对应商品ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `fictitious_info` varchar(255) DEFAULT '' COMMENT '虚拟物品信息',
  PRIMARY KEY (`id`),
  KEY `notice_sn` (`notice_sn`),
  KEY `order_item_id` (`order_item_id`),
  KEY `is_arrival` (`is_arrival`),
  KEY `user_id` (`user_id`),
  KEY `delivery_supplier_id` (`delivery_supplier_id`),
  KEY `location_id` (`location_id`),
  KEY `deal_id` (`deal_id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='发货单表';

-- ----------------------------
-- Table structure for %DB_PREFIX%delivery_region
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%delivery_region`;
CREATE TABLE `%DB_PREFIX%delivery_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '父级地区ID',
  `name` varchar(50) NOT NULL COMMENT '地区名称',
  `region_level` tinyint(4) NOT NULL COMMENT '1:国 2:省 3:市(县) 4:区(镇)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='配送地区表';

-- ----------------------------
-- Records of %DB_PREFIX%delivery_region
-- ----------------------------
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2', '1', '北京', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3', '1', '安徽', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('4', '1', '福建', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('5', '1', '甘肃', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('6', '1', '广东', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('7', '1', '广西', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('8', '1', '贵州', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('9', '1', '海南', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('10', '1', '河北', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('11', '1', '河南', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('12', '1', '黑龙江', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('13', '1', '湖北', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('14', '1', '湖南', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('15', '1', '吉林', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('16', '1', '江苏', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('17', '1', '江西', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('18', '1', '辽宁', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('19', '1', '内蒙古', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('20', '1', '宁夏', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('21', '1', '青海', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('22', '1', '山东', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('23', '1', '山西', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('24', '1', '陕西', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('25', '1', '上海', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('26', '1', '四川', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('27', '1', '天津', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('28', '1', '西藏', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('29', '1', '新疆', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('30', '1', '云南', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('31', '1', '浙江', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('32', '1', '重庆', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('33', '1', '香港', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('34', '1', '澳门', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('35', '1', '台湾', '2');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('36', '3', '安庆', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('37', '3', '蚌埠', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('38', '3', '巢湖', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('39', '3', '池州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('40', '3', '滁州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('41', '3', '阜阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('42', '3', '淮北', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('43', '3', '淮南', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('44', '3', '黄山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('45', '3', '六安', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('46', '3', '马鞍山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('47', '3', '宿州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('48', '3', '铜陵', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('49', '3', '芜湖', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('50', '3', '宣城', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('51', '3', '亳州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('52', '2', '北京', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('53', '4', '福州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('54', '4', '龙岩', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('55', '4', '南平', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('56', '4', '宁德', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('57', '4', '莆田', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('58', '4', '泉州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('59', '4', '三明', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('60', '4', '厦门', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('61', '4', '漳州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('62', '5', '兰州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('63', '5', '白银', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('64', '5', '定西', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('65', '5', '甘南', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('66', '5', '嘉峪关', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('67', '5', '金昌', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('68', '5', '酒泉', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('69', '5', '临夏', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('70', '5', '陇南', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('71', '5', '平凉', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('72', '5', '庆阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('73', '5', '天水', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('74', '5', '武威', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('75', '5', '张掖', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('76', '6', '广州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('77', '6', '深圳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('78', '6', '潮州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('79', '6', '东莞', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('80', '6', '佛山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('81', '6', '河源', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('82', '6', '惠州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('83', '6', '江门', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('84', '6', '揭阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('85', '6', '茂名', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('86', '6', '梅州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('87', '6', '清远', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('88', '6', '汕头', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('89', '6', '汕尾', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('90', '6', '韶关', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('91', '6', '阳江', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('92', '6', '云浮', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('93', '6', '湛江', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('94', '6', '肇庆', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('95', '6', '中山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('96', '6', '珠海', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('97', '7', '南宁', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('98', '7', '桂林', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('99', '7', '百色', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('100', '7', '北海', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('101', '7', '崇左', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('102', '7', '防城港', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('103', '7', '贵港', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('104', '7', '河池', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('105', '7', '贺州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('106', '7', '来宾', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('107', '7', '柳州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('108', '7', '钦州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('109', '7', '梧州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('110', '7', '玉林', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('111', '8', '贵阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('112', '8', '安顺', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('113', '8', '毕节', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('114', '8', '六盘水', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('115', '8', '黔东南', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('116', '8', '黔南', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('117', '8', '黔西南', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('118', '8', '铜仁', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('119', '8', '遵义', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('120', '9', '海口', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('121', '9', '三亚', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('122', '9', '白沙', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('123', '9', '保亭', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('124', '9', '昌江', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('125', '9', '澄迈县', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('126', '9', '定安县', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('127', '9', '东方', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('128', '9', '乐东', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('129', '9', '临高县', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('130', '9', '陵水', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('131', '9', '琼海', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('132', '9', '琼中', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('133', '9', '屯昌县', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('134', '9', '万宁', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('135', '9', '文昌', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('136', '9', '五指山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('137', '9', '儋州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('138', '10', '石家庄', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('139', '10', '保定', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('140', '10', '沧州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('141', '10', '承德', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('142', '10', '邯郸', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('143', '10', '衡水', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('144', '10', '廊坊', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('145', '10', '秦皇岛', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('146', '10', '唐山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('147', '10', '邢台', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('148', '10', '张家口', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('149', '11', '郑州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('150', '11', '洛阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('151', '11', '开封', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('152', '11', '安阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('153', '11', '鹤壁', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('154', '11', '济源', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('155', '11', '焦作', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('156', '11', '南阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('157', '11', '平顶山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('158', '11', '三门峡', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('159', '11', '商丘', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('160', '11', '新乡', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('161', '11', '信阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('162', '11', '许昌', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('163', '11', '周口', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('164', '11', '驻马店', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('165', '11', '漯河', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('166', '11', '濮阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('167', '12', '哈尔滨', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('168', '12', '大庆', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('169', '12', '大兴安岭', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('170', '12', '鹤岗', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('171', '12', '黑河', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('172', '12', '鸡西', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('173', '12', '佳木斯', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('174', '12', '牡丹江', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('175', '12', '七台河', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('176', '12', '齐齐哈尔', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('177', '12', '双鸭山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('178', '12', '绥化', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('179', '12', '伊春', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('180', '13', '武汉', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('181', '13', '仙桃', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('182', '13', '鄂州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('183', '13', '黄冈', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('184', '13', '黄石', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('185', '13', '荆门', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('186', '13', '荆州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('187', '13', '潜江', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('188', '13', '神农架林区', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('189', '13', '十堰', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('190', '13', '随州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('191', '13', '天门', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('192', '13', '咸宁', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('193', '13', '襄樊', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('194', '13', '孝感', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('195', '13', '宜昌', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('196', '13', '恩施', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('197', '14', '长沙', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('198', '14', '张家界', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('199', '14', '常德', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('200', '14', '郴州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('201', '14', '衡阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('202', '14', '怀化', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('203', '14', '娄底', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('204', '14', '邵阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('205', '14', '湘潭', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('206', '14', '湘西', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('207', '14', '益阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('208', '14', '永州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('209', '14', '岳阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('210', '14', '株洲', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('211', '15', '长春', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('212', '15', '吉林', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('213', '15', '白城', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('214', '15', '白山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('215', '15', '辽源', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('216', '15', '四平', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('217', '15', '松原', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('218', '15', '通化', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('219', '15', '延边', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('220', '16', '南京', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('221', '16', '苏州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('222', '16', '无锡', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('223', '16', '常州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('224', '16', '淮安', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('225', '16', '连云港', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('226', '16', '南通', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('227', '16', '宿迁', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('228', '16', '泰州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('229', '16', '徐州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('230', '16', '盐城', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('231', '16', '扬州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('232', '16', '镇江', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('233', '17', '南昌', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('234', '17', '抚州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('235', '17', '赣州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('236', '17', '吉安', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('237', '17', '景德镇', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('238', '17', '九江', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('239', '17', '萍乡', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('240', '17', '上饶', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('241', '17', '新余', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('242', '17', '宜春', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('243', '17', '鹰潭', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('244', '18', '沈阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('245', '18', '大连', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('246', '18', '鞍山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('247', '18', '本溪', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('248', '18', '朝阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('249', '18', '丹东', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('250', '18', '抚顺', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('251', '18', '阜新', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('252', '18', '葫芦岛', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('253', '18', '锦州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('254', '18', '辽阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('255', '18', '盘锦', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('256', '18', '铁岭', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('257', '18', '营口', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('258', '19', '呼和浩特', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('259', '19', '阿拉善盟', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('260', '19', '巴彦淖尔盟', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('261', '19', '包头', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('262', '19', '赤峰', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('263', '19', '鄂尔多斯', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('264', '19', '呼伦贝尔', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('265', '19', '通辽', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('266', '19', '乌海', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('267', '19', '乌兰察布市', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('268', '19', '锡林郭勒盟', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('269', '19', '兴安盟', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('270', '20', '银川', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('271', '20', '固原', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('272', '20', '石嘴山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('273', '20', '吴忠', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('274', '20', '中卫', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('275', '21', '西宁', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('276', '21', '果洛', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('277', '21', '海北', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('278', '21', '海东', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('279', '21', '海南', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('280', '21', '海西', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('281', '21', '黄南', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('282', '21', '玉树', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('283', '22', '济南', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('284', '22', '青岛', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('285', '22', '滨州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('286', '22', '德州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('287', '22', '东营', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('288', '22', '菏泽', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('289', '22', '济宁', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('290', '22', '莱芜', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('291', '22', '聊城', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('292', '22', '临沂', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('293', '22', '日照', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('294', '22', '泰安', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('295', '22', '威海', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('296', '22', '潍坊', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('297', '22', '烟台', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('298', '22', '枣庄', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('299', '22', '淄博', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('300', '23', '太原', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('301', '23', '长治', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('302', '23', '大同', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('303', '23', '晋城', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('304', '23', '晋中', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('305', '23', '临汾', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('306', '23', '吕梁', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('307', '23', '朔州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('308', '23', '忻州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('309', '23', '阳泉', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('310', '23', '运城', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('311', '24', '西安', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('312', '24', '安康', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('313', '24', '宝鸡', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('314', '24', '汉中', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('315', '24', '商洛', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('316', '24', '铜川', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('317', '24', '渭南', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('318', '24', '咸阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('319', '24', '延安', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('320', '24', '榆林', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('321', '25', '上海', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('322', '26', '成都', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('323', '26', '绵阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('324', '26', '阿坝', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('325', '26', '巴中', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('326', '26', '达州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('327', '26', '德阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('328', '26', '甘孜', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('329', '26', '广安', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('330', '26', '广元', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('331', '26', '乐山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('332', '26', '凉山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('333', '26', '眉山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('334', '26', '南充', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('335', '26', '内江', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('336', '26', '攀枝花', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('337', '26', '遂宁', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('338', '26', '雅安', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('339', '26', '宜宾', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('340', '26', '资阳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('341', '26', '自贡', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('342', '26', '泸州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('343', '27', '天津', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('344', '28', '拉萨', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('345', '28', '阿里', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('346', '28', '昌都', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('347', '28', '林芝', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('348', '28', '那曲', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('349', '28', '日喀则', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('350', '28', '山南', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('351', '29', '乌鲁木齐', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('352', '29', '阿克苏', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('353', '29', '阿拉尔', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('354', '29', '巴音郭楞', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('355', '29', '博尔塔拉', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('356', '29', '昌吉', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('357', '29', '哈密', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('358', '29', '和田', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('359', '29', '喀什', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('360', '29', '克拉玛依', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('361', '29', '克孜勒苏', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('362', '29', '石河子', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('363', '29', '图木舒克', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('364', '29', '吐鲁番', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('365', '29', '五家渠', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('366', '29', '伊犁', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('367', '30', '昆明', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('368', '30', '怒江', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('369', '30', '普洱', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('370', '30', '丽江', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('371', '30', '保山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('372', '30', '楚雄', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('373', '30', '大理', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('374', '30', '德宏', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('375', '30', '迪庆', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('376', '30', '红河', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('377', '30', '临沧', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('378', '30', '曲靖', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('379', '30', '文山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('380', '30', '西双版纳', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('381', '30', '玉溪', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('382', '30', '昭通', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('383', '31', '杭州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('384', '31', '湖州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('385', '31', '嘉兴', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('386', '31', '金华', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('387', '31', '丽水', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('388', '31', '宁波', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('389', '31', '绍兴', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('390', '31', '台州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('391', '31', '温州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('392', '31', '舟山', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('393', '31', '衢州', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('394', '32', '重庆', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('395', '33', '香港', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('396', '34', '澳门', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('397', '35', '台湾', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('398', '36', '迎江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('399', '36', '大观区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('400', '36', '宜秀区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('401', '36', '桐城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('402', '36', '怀宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('403', '36', '枞阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('404', '36', '潜山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('405', '36', '太湖县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('406', '36', '宿松县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('407', '36', '望江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('408', '36', '岳西县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('409', '37', '中市区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('410', '37', '东市区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('411', '37', '西市区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('412', '37', '郊区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('413', '37', '怀远县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('414', '37', '五河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('415', '37', '固镇县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('416', '38', '居巢区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('417', '38', '庐江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('418', '38', '无为县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('419', '38', '含山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('420', '38', '和县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('421', '39', '贵池区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('422', '39', '东至县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('423', '39', '石台县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('424', '39', '青阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('425', '40', '琅琊区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('426', '40', '南谯区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('427', '40', '天长市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('428', '40', '明光市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('429', '40', '来安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('430', '40', '全椒县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('431', '40', '定远县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('432', '40', '凤阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('433', '41', '蚌山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('434', '41', '龙子湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('435', '41', '禹会区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('436', '41', '淮上区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('437', '41', '颍州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('438', '41', '颍东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('439', '41', '颍泉区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('440', '41', '界首市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('441', '41', '临泉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('442', '41', '太和县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('443', '41', '阜南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('444', '41', '颖上县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('445', '42', '相山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('446', '42', '杜集区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('447', '42', '烈山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('448', '42', '濉溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('449', '43', '田家庵区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('450', '43', '大通区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('451', '43', '谢家集区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('452', '43', '八公山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('453', '43', '潘集区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('454', '43', '凤台县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('455', '44', '屯溪区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('456', '44', '黄山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('457', '44', '徽州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('458', '44', '歙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('459', '44', '休宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('460', '44', '黟县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('461', '44', '祁门县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('462', '45', '金安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('463', '45', '裕安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('464', '45', '寿县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('465', '45', '霍邱县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('466', '45', '舒城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('467', '45', '金寨县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('468', '45', '霍山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('469', '46', '雨山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('470', '46', '花山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('471', '46', '金家庄区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('472', '46', '当涂县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('473', '47', '埇桥区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('474', '47', '砀山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('475', '47', '萧县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('476', '47', '灵璧县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('477', '47', '泗县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('478', '48', '铜官山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('479', '48', '狮子山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('480', '48', '郊区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('481', '48', '铜陵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('482', '49', '镜湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('483', '49', '弋江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('484', '49', '鸠江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('485', '49', '三山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('486', '49', '芜湖县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('487', '49', '繁昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('488', '49', '南陵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('489', '50', '宣州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('490', '50', '宁国市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('491', '50', '郎溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('492', '50', '广德县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('493', '50', '泾县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('494', '50', '绩溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('495', '50', '旌德县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('496', '51', '涡阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('497', '51', '蒙城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('498', '51', '利辛县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('499', '51', '谯城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('500', '52', '东城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('501', '52', '西城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('502', '52', '海淀区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('503', '52', '朝阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('504', '52', '崇文区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('505', '52', '宣武区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('506', '52', '丰台区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('507', '52', '石景山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('508', '52', '房山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('509', '52', '门头沟区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('510', '52', '通州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('511', '52', '顺义区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('512', '52', '昌平区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('513', '52', '怀柔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('514', '52', '平谷区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('515', '52', '大兴区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('516', '52', '密云县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('517', '52', '延庆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('518', '53', '鼓楼区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('519', '53', '台江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('520', '53', '仓山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('521', '53', '马尾区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('522', '53', '晋安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('523', '53', '福清市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('524', '53', '长乐市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('525', '53', '闽侯县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('526', '53', '连江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('527', '53', '罗源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('528', '53', '闽清县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('529', '53', '永泰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('530', '53', '平潭县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('531', '54', '新罗区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('532', '54', '漳平市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('533', '54', '长汀县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('534', '54', '永定县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('535', '54', '上杭县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('536', '54', '武平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('537', '54', '连城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('538', '55', '延平区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('539', '55', '邵武市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('540', '55', '武夷山市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('541', '55', '建瓯市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('542', '55', '建阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('543', '55', '顺昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('544', '55', '浦城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('545', '55', '光泽县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('546', '55', '松溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('547', '55', '政和县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('548', '56', '蕉城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('549', '56', '福安市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('550', '56', '福鼎市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('551', '56', '霞浦县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('552', '56', '古田县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('553', '56', '屏南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('554', '56', '寿宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('555', '56', '周宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('556', '56', '柘荣县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('557', '57', '城厢区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('558', '57', '涵江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('559', '57', '荔城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('560', '57', '秀屿区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('561', '57', '仙游县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('562', '58', '鲤城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('563', '58', '丰泽区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('564', '58', '洛江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('565', '58', '清濛开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('566', '58', '泉港区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('567', '58', '石狮市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('568', '58', '晋江市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('569', '58', '南安市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('570', '58', '惠安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('571', '58', '安溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('572', '58', '永春县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('573', '58', '德化县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('574', '58', '金门县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('575', '59', '梅列区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('576', '59', '三元区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('577', '59', '永安市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('578', '59', '明溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('579', '59', '清流县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('580', '59', '宁化县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('581', '59', '大田县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('582', '59', '尤溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('583', '59', '沙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('584', '59', '将乐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('585', '59', '泰宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('586', '59', '建宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('587', '60', '思明区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('588', '60', '海沧区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('589', '60', '湖里区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('590', '60', '集美区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('591', '60', '同安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('592', '60', '翔安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('593', '61', '芗城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('594', '61', '龙文区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('595', '61', '龙海市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('596', '61', '云霄县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('597', '61', '漳浦县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('598', '61', '诏安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('599', '61', '长泰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('600', '61', '东山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('601', '61', '南靖县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('602', '61', '平和县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('603', '61', '华安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('604', '62', '皋兰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('605', '62', '城关区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('606', '62', '七里河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('607', '62', '西固区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('608', '62', '安宁区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('609', '62', '红古区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('610', '62', '永登县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('611', '62', '榆中县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('612', '63', '白银区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('613', '63', '平川区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('614', '63', '会宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('615', '63', '景泰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('616', '63', '靖远县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('617', '64', '临洮县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('618', '64', '陇西县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('619', '64', '通渭县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('620', '64', '渭源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('621', '64', '漳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('622', '64', '岷县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('623', '64', '安定区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('624', '64', '安定区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('625', '65', '合作市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('626', '65', '临潭县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('627', '65', '卓尼县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('628', '65', '舟曲县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('629', '65', '迭部县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('630', '65', '玛曲县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('631', '65', '碌曲县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('632', '65', '夏河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('633', '66', '嘉峪关市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('634', '67', '金川区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('635', '67', '永昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('636', '68', '肃州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('637', '68', '玉门市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('638', '68', '敦煌市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('639', '68', '金塔县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('640', '68', '瓜州县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('641', '68', '肃北', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('642', '68', '阿克塞', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('643', '69', '临夏市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('644', '69', '临夏县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('645', '69', '康乐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('646', '69', '永靖县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('647', '69', '广河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('648', '69', '和政县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('649', '69', '东乡族自治县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('650', '69', '积石山', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('651', '70', '成县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('652', '70', '徽县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('653', '70', '康县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('654', '70', '礼县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('655', '70', '两当县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('656', '70', '文县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('657', '70', '西和县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('658', '70', '宕昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('659', '70', '武都区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('660', '71', '崇信县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('661', '71', '华亭县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('662', '71', '静宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('663', '71', '灵台县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('664', '71', '崆峒区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('665', '71', '庄浪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('666', '71', '泾川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('667', '72', '合水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('668', '72', '华池县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('669', '72', '环县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('670', '72', '宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('671', '72', '庆城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('672', '72', '西峰区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('673', '72', '镇原县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('674', '72', '正宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('675', '73', '甘谷县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('676', '73', '秦安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('677', '73', '清水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('678', '73', '秦州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('679', '73', '麦积区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('680', '73', '武山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('681', '73', '张家川', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('682', '74', '古浪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('683', '74', '民勤县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('684', '74', '天祝', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('685', '74', '凉州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('686', '75', '高台县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('687', '75', '临泽县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('688', '75', '民乐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('689', '75', '山丹县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('690', '75', '肃南', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('691', '75', '甘州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('692', '76', '从化市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('693', '76', '天河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('694', '76', '东山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('695', '76', '白云区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('696', '76', '海珠区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('697', '76', '荔湾区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('698', '76', '越秀区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('699', '76', '黄埔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('700', '76', '番禺区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('701', '76', '花都区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('702', '76', '增城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('703', '76', '从化区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('704', '76', '市郊', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('705', '77', '福田区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('706', '77', '罗湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('707', '77', '南山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('708', '77', '宝安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('709', '77', '龙岗区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('710', '77', '盐田区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('711', '78', '湘桥区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('712', '78', '潮安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('713', '78', '饶平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('714', '79', '南城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('715', '79', '东城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('716', '79', '万江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('717', '79', '莞城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('718', '79', '石龙镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('719', '79', '虎门镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('720', '79', '麻涌镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('721', '79', '道滘镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('722', '79', '石碣镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('723', '79', '沙田镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('724', '79', '望牛墩镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('725', '79', '洪梅镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('726', '79', '茶山镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('727', '79', '寮步镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('728', '79', '大岭山镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('729', '79', '大朗镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('730', '79', '黄江镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('731', '79', '樟木头', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('732', '79', '凤岗镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('733', '79', '塘厦镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('734', '79', '谢岗镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('735', '79', '厚街镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('736', '79', '清溪镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('737', '79', '常平镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('738', '79', '桥头镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('739', '79', '横沥镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('740', '79', '东坑镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('741', '79', '企石镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('742', '79', '石排镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('743', '79', '长安镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('744', '79', '中堂镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('745', '79', '高埗镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('746', '80', '禅城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('747', '80', '南海区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('748', '80', '顺德区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('749', '80', '三水区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('750', '80', '高明区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('751', '81', '东源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('752', '81', '和平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('753', '81', '源城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('754', '81', '连平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('755', '81', '龙川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('756', '81', '紫金县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('757', '82', '惠阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('758', '82', '惠城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('759', '82', '大亚湾', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('760', '82', '博罗县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('761', '82', '惠东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('762', '82', '龙门县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('763', '83', '江海区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('764', '83', '蓬江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('765', '83', '新会区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('766', '83', '台山市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('767', '83', '开平市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('768', '83', '鹤山市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('769', '83', '恩平市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('770', '84', '榕城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('771', '84', '普宁市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('772', '84', '揭东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('773', '84', '揭西县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('774', '84', '惠来县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('775', '85', '茂南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('776', '85', '茂港区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('777', '85', '高州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('778', '85', '化州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('779', '85', '信宜市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('780', '85', '电白县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('781', '86', '梅县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('782', '86', '梅江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('783', '86', '兴宁市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('784', '86', '大埔县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('785', '86', '丰顺县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('786', '86', '五华县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('787', '86', '平远县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('788', '86', '蕉岭县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('789', '87', '清城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('790', '87', '英德市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('791', '87', '连州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('792', '87', '佛冈县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('793', '87', '阳山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('794', '87', '清新县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('795', '87', '连山', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('796', '87', '连南', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('797', '88', '南澳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('798', '88', '潮阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('799', '88', '澄海区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('800', '88', '龙湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('801', '88', '金平区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('802', '88', '濠江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('803', '88', '潮南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('804', '89', '城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('805', '89', '陆丰市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('806', '89', '海丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('807', '89', '陆河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('808', '90', '曲江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('809', '90', '浈江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('810', '90', '武江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('811', '90', '曲江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('812', '90', '乐昌市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('813', '90', '南雄市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('814', '90', '始兴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('815', '90', '仁化县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('816', '90', '翁源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('817', '90', '新丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('818', '90', '乳源', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('819', '91', '江城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('820', '91', '阳春市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('821', '91', '阳西县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('822', '91', '阳东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('823', '92', '云城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('824', '92', '罗定市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('825', '92', '新兴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('826', '92', '郁南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('827', '92', '云安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('828', '93', '赤坎区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('829', '93', '霞山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('830', '93', '坡头区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('831', '93', '麻章区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('832', '93', '廉江市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('833', '93', '雷州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('834', '93', '吴川市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('835', '93', '遂溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('836', '93', '徐闻县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('837', '94', '肇庆市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('838', '94', '高要市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('839', '94', '四会市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('840', '94', '广宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('841', '94', '怀集县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('842', '94', '封开县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('843', '94', '德庆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('844', '95', '石岐街道', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('845', '95', '东区街道', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('846', '95', '西区街道', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('847', '95', '环城街道', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('848', '95', '中山港街道', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('849', '95', '五桂山街道', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('850', '96', '香洲区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('851', '96', '斗门区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('852', '96', '金湾区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('853', '97', '邕宁区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('854', '97', '青秀区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('855', '97', '兴宁区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('856', '97', '良庆区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('857', '97', '西乡塘区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('858', '97', '江南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('859', '97', '武鸣县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('860', '97', '隆安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('861', '97', '马山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('862', '97', '上林县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('863', '97', '宾阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('864', '97', '横县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('865', '98', '秀峰区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('866', '98', '叠彩区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('867', '98', '象山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('868', '98', '七星区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('869', '98', '雁山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('870', '98', '阳朔县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('871', '98', '临桂县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('872', '98', '灵川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('873', '98', '全州县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('874', '98', '平乐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('875', '98', '兴安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('876', '98', '灌阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('877', '98', '荔浦县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('878', '98', '资源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('879', '98', '永福县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('880', '98', '龙胜', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('881', '98', '恭城', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('882', '99', '右江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('883', '99', '凌云县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('884', '99', '平果县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('885', '99', '西林县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('886', '99', '乐业县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('887', '99', '德保县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('888', '99', '田林县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('889', '99', '田阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('890', '99', '靖西县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('891', '99', '田东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('892', '99', '那坡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('893', '99', '隆林', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('894', '100', '海城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('895', '100', '银海区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('896', '100', '铁山港区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('897', '100', '合浦县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('898', '101', '江州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('899', '101', '凭祥市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('900', '101', '宁明县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('901', '101', '扶绥县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('902', '101', '龙州县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('903', '101', '大新县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('904', '101', '天等县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('905', '102', '港口区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('906', '102', '防城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('907', '102', '东兴市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('908', '102', '上思县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('909', '103', '港北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('910', '103', '港南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('911', '103', '覃塘区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('912', '103', '桂平市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('913', '103', '平南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('914', '104', '金城江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('915', '104', '宜州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('916', '104', '天峨县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('917', '104', '凤山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('918', '104', '南丹县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('919', '104', '东兰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('920', '104', '都安', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('921', '104', '罗城', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('922', '104', '巴马', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('923', '104', '环江', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('924', '104', '大化', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('925', '105', '八步区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('926', '105', '钟山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('927', '105', '昭平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('928', '105', '富川', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('929', '106', '兴宾区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('930', '106', '合山市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('931', '106', '象州县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('932', '106', '武宣县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('933', '106', '忻城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('934', '106', '金秀', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('935', '107', '城中区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('936', '107', '鱼峰区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('937', '107', '柳北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('938', '107', '柳南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('939', '107', '柳江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('940', '107', '柳城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('941', '107', '鹿寨县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('942', '107', '融安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('943', '107', '融水', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('944', '107', '三江', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('945', '108', '钦南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('946', '108', '钦北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('947', '108', '灵山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('948', '108', '浦北县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('949', '109', '万秀区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('950', '109', '蝶山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('951', '109', '长洲区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('952', '109', '岑溪市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('953', '109', '苍梧县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('954', '109', '藤县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('955', '109', '蒙山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('956', '110', '玉州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('957', '110', '北流市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('958', '110', '容县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('959', '110', '陆川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('960', '110', '博白县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('961', '110', '兴业县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('962', '111', '南明区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('963', '111', '云岩区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('964', '111', '花溪区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('965', '111', '乌当区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('966', '111', '白云区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('967', '111', '小河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('968', '111', '金阳新区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('969', '111', '新天园区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('970', '111', '清镇市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('971', '111', '开阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('972', '111', '修文县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('973', '111', '息烽县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('974', '112', '西秀区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('975', '112', '关岭', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('976', '112', '镇宁', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('977', '112', '紫云', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('978', '112', '平坝县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('979', '112', '普定县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('980', '113', '毕节市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('981', '113', '大方县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('982', '113', '黔西县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('983', '113', '金沙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('984', '113', '织金县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('985', '113', '纳雍县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('986', '113', '赫章县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('987', '113', '威宁', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('988', '114', '钟山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('989', '114', '六枝特区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('990', '114', '水城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('991', '114', '盘县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('992', '115', '凯里市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('993', '115', '黄平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('994', '115', '施秉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('995', '115', '三穗县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('996', '115', '镇远县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('997', '115', '岑巩县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('998', '115', '天柱县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('999', '115', '锦屏县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1000', '115', '剑河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1001', '115', '台江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1002', '115', '黎平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1003', '115', '榕江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1004', '115', '从江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1005', '115', '雷山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1006', '115', '麻江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1007', '115', '丹寨县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1008', '116', '都匀市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1009', '116', '福泉市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1010', '116', '荔波县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1011', '116', '贵定县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1012', '116', '瓮安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1013', '116', '独山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1014', '116', '平塘县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1015', '116', '罗甸县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1016', '116', '长顺县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1017', '116', '龙里县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1018', '116', '惠水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1019', '116', '三都', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1020', '117', '兴义市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1021', '117', '兴仁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1022', '117', '普安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1023', '117', '晴隆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1024', '117', '贞丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1025', '117', '望谟县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1026', '117', '册亨县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1027', '117', '安龙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1028', '118', '铜仁市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1029', '118', '江口县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1030', '118', '石阡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1031', '118', '思南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1032', '118', '德江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1033', '118', '玉屏', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1034', '118', '印江', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1035', '118', '沿河', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1036', '118', '松桃', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1037', '118', '万山特区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1038', '119', '红花岗区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1039', '119', '务川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1040', '119', '道真县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1041', '119', '汇川区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1042', '119', '赤水市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1043', '119', '仁怀市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1044', '119', '遵义县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1045', '119', '桐梓县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1046', '119', '绥阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1047', '119', '正安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1048', '119', '凤冈县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1049', '119', '湄潭县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1050', '119', '余庆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1051', '119', '习水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1052', '119', '道真', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1053', '119', '务川', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1054', '120', '秀英区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1055', '120', '龙华区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1056', '120', '琼山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1057', '120', '美兰区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1058', '137', '市区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1059', '137', '洋浦开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1060', '137', '那大镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1061', '137', '王五镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1062', '137', '雅星镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1063', '137', '大成镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1064', '137', '中和镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1065', '137', '峨蔓镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1066', '137', '南丰镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1067', '137', '白马井镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1068', '137', '兰洋镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1069', '137', '和庆镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1070', '137', '海头镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1071', '137', '排浦镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1072', '137', '东成镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1073', '137', '光村镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1074', '137', '木棠镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1075', '137', '新州镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1076', '137', '三都镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1077', '137', '其他', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1078', '138', '长安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1079', '138', '桥东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1080', '138', '桥西区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1081', '138', '新华区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1082', '138', '裕华区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1083', '138', '井陉矿区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1084', '138', '高新区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1085', '138', '辛集市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1086', '138', '藁城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1087', '138', '晋州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1088', '138', '新乐市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1089', '138', '鹿泉市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1090', '138', '井陉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1091', '138', '正定县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1092', '138', '栾城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1093', '138', '行唐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1094', '138', '灵寿县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1095', '138', '高邑县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1096', '138', '深泽县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1097', '138', '赞皇县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1098', '138', '无极县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1099', '138', '平山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1100', '138', '元氏县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1101', '138', '赵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1102', '139', '新市区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1103', '139', '南市区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1104', '139', '北市区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1105', '139', '涿州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1106', '139', '定州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1107', '139', '安国市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1108', '139', '高碑店市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1109', '139', '满城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1110', '139', '清苑县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1111', '139', '涞水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1112', '139', '阜平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1113', '139', '徐水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1114', '139', '定兴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1115', '139', '唐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1116', '139', '高阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1117', '139', '容城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1118', '139', '涞源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1119', '139', '望都县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1120', '139', '安新县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1121', '139', '易县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1122', '139', '曲阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1123', '139', '蠡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1124', '139', '顺平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1125', '139', '博野县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1126', '139', '雄县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1127', '140', '运河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1128', '140', '新华区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1129', '140', '泊头市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1130', '140', '任丘市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1131', '140', '黄骅市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1132', '140', '河间市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1133', '140', '沧县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1134', '140', '青县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1135', '140', '东光县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1136', '140', '海兴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1137', '140', '盐山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1138', '140', '肃宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1139', '140', '南皮县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1140', '140', '吴桥县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1141', '140', '献县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1142', '140', '孟村', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1143', '141', '双桥区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1144', '141', '双滦区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1145', '141', '鹰手营子矿区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1146', '141', '承德县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1147', '141', '兴隆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1148', '141', '平泉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1149', '141', '滦平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1150', '141', '隆化县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1151', '141', '丰宁', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1152', '141', '宽城', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1153', '141', '围场', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1154', '142', '从台区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1155', '142', '复兴区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1156', '142', '邯山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1157', '142', '峰峰矿区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1158', '142', '武安市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1159', '142', '邯郸县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1160', '142', '临漳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1161', '142', '成安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1162', '142', '大名县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1163', '142', '涉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1164', '142', '磁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1165', '142', '肥乡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1166', '142', '永年县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1167', '142', '邱县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1168', '142', '鸡泽县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1169', '142', '广平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1170', '142', '馆陶县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1171', '142', '魏县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1172', '142', '曲周县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1173', '143', '桃城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1174', '143', '冀州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1175', '143', '深州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1176', '143', '枣强县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1177', '143', '武邑县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1178', '143', '武强县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1179', '143', '饶阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1180', '143', '安平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1181', '143', '故城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1182', '143', '景县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1183', '143', '阜城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1184', '144', '安次区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1185', '144', '广阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1186', '144', '霸州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1187', '144', '三河市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1188', '144', '固安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1189', '144', '永清县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1190', '144', '香河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1191', '144', '大城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1192', '144', '文安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1193', '144', '大厂', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1194', '145', '海港区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1195', '145', '山海关区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1196', '145', '北戴河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1197', '145', '昌黎县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1198', '145', '抚宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1199', '145', '卢龙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1200', '145', '青龙', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1201', '146', '路北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1202', '146', '路南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1203', '146', '古冶区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1204', '146', '开平区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1205', '146', '丰南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1206', '146', '丰润区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1207', '146', '遵化市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1208', '146', '迁安市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1209', '146', '滦县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1210', '146', '滦南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1211', '146', '乐亭县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1212', '146', '迁西县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1213', '146', '玉田县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1214', '146', '唐海县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1215', '147', '桥东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1216', '147', '桥西区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1217', '147', '南宫市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1218', '147', '沙河市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1219', '147', '邢台县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1220', '147', '临城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1221', '147', '内丘县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1222', '147', '柏乡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1223', '147', '隆尧县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1224', '147', '任县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1225', '147', '南和县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1226', '147', '宁晋县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1227', '147', '巨鹿县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1228', '147', '新河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1229', '147', '广宗县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1230', '147', '平乡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1231', '147', '威县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1232', '147', '清河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1233', '147', '临西县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1234', '148', '桥西区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1235', '148', '桥东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1236', '148', '宣化区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1237', '148', '下花园区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1238', '148', '宣化县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1239', '148', '张北县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1240', '148', '康保县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1241', '148', '沽源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1242', '148', '尚义县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1243', '148', '蔚县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1244', '148', '阳原县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1245', '148', '怀安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1246', '148', '万全县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1247', '148', '怀来县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1248', '148', '涿鹿县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1249', '148', '赤城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1250', '148', '崇礼县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1251', '149', '金水区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1252', '149', '邙山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1253', '149', '二七区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1254', '149', '管城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1255', '149', '中原区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1256', '149', '上街区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1257', '149', '惠济区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1258', '149', '郑东新区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1259', '149', '经济技术开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1260', '149', '高新开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1261', '149', '出口加工区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1262', '149', '巩义市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1263', '149', '荥阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1264', '149', '新密市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1265', '149', '新郑市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1266', '149', '登封市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1267', '149', '中牟县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1268', '150', '西工区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1269', '150', '老城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1270', '150', '涧西区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1271', '150', '瀍河回族区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1272', '150', '洛龙区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1273', '150', '吉利区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1274', '150', '偃师市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1275', '150', '孟津县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1276', '150', '新安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1277', '150', '栾川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1278', '150', '嵩县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1279', '150', '汝阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1280', '150', '宜阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1281', '150', '洛宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1282', '150', '伊川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1283', '151', '鼓楼区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1284', '151', '龙亭区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1285', '151', '顺河回族区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1286', '151', '金明区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1287', '151', '禹王台区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1288', '151', '杞县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1289', '151', '通许县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1290', '151', '尉氏县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1291', '151', '开封县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1292', '151', '兰考县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1293', '152', '北关区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1294', '152', '文峰区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1295', '152', '殷都区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1296', '152', '龙安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1297', '152', '林州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1298', '152', '安阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1299', '152', '汤阴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1300', '152', '滑县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1301', '152', '内黄县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1302', '153', '淇滨区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1303', '153', '山城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1304', '153', '鹤山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1305', '153', '浚县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1306', '153', '淇县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1307', '154', '济源市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1308', '155', '解放区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1309', '155', '中站区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1310', '155', '马村区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1311', '155', '山阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1312', '155', '沁阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1313', '155', '孟州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1314', '155', '修武县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1315', '155', '博爱县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1316', '155', '武陟县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1317', '155', '温县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1318', '156', '卧龙区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1319', '156', '宛城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1320', '156', '邓州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1321', '156', '南召县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1322', '156', '方城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1323', '156', '西峡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1324', '156', '镇平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1325', '156', '内乡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1326', '156', '淅川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1327', '156', '社旗县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1328', '156', '唐河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1329', '156', '新野县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1330', '156', '桐柏县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1331', '157', '新华区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1332', '157', '卫东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1333', '157', '湛河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1334', '157', '石龙区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1335', '157', '舞钢市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1336', '157', '汝州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1337', '157', '宝丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1338', '157', '叶县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1339', '157', '鲁山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1340', '157', '郏县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1341', '158', '湖滨区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1342', '158', '义马市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1343', '158', '灵宝市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1344', '158', '渑池县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1345', '158', '陕县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1346', '158', '卢氏县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1347', '159', '梁园区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1348', '159', '睢阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1349', '159', '永城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1350', '159', '民权县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1351', '159', '睢县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1352', '159', '宁陵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1353', '159', '虞城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1354', '159', '柘城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1355', '159', '夏邑县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1356', '160', '卫滨区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1357', '160', '红旗区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1358', '160', '凤泉区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1359', '160', '牧野区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1360', '160', '卫辉市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1361', '160', '辉县市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1362', '160', '新乡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1363', '160', '获嘉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1364', '160', '原阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1365', '160', '延津县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1366', '160', '封丘县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1367', '160', '长垣县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1368', '161', '浉河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1369', '161', '平桥区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1370', '161', '罗山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1371', '161', '光山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1372', '161', '新县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1373', '161', '商城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1374', '161', '固始县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1375', '161', '潢川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1376', '161', '淮滨县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1377', '161', '息县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1378', '162', '魏都区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1379', '162', '禹州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1380', '162', '长葛市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1381', '162', '许昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1382', '162', '鄢陵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1383', '162', '襄城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1384', '163', '川汇区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1385', '163', '项城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1386', '163', '扶沟县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1387', '163', '西华县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1388', '163', '商水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1389', '163', '沈丘县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1390', '163', '郸城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1391', '163', '淮阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1392', '163', '太康县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1393', '163', '鹿邑县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1394', '164', '驿城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1395', '164', '西平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1396', '164', '上蔡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1397', '164', '平舆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1398', '164', '正阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1399', '164', '确山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1400', '164', '泌阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1401', '164', '汝南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1402', '164', '遂平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1403', '164', '新蔡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1404', '165', '郾城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1405', '165', '源汇区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1406', '165', '召陵区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1407', '165', '舞阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1408', '165', '临颍县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1409', '166', '华龙区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1410', '166', '清丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1411', '166', '南乐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1412', '166', '范县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1413', '166', '台前县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1414', '166', '濮阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1415', '167', '道里区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1416', '167', '南岗区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1417', '167', '动力区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1418', '167', '平房区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1419', '167', '香坊区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1420', '167', '太平区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1421', '167', '道外区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1422', '167', '阿城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1423', '167', '呼兰区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1424', '167', '松北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1425', '167', '尚志市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1426', '167', '双城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1427', '167', '五常市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1428', '167', '方正县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1429', '167', '宾县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1430', '167', '依兰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1431', '167', '巴彦县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1432', '167', '通河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1433', '167', '木兰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1434', '167', '延寿县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1435', '168', '萨尔图区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1436', '168', '红岗区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1437', '168', '龙凤区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1438', '168', '让胡路区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1439', '168', '大同区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1440', '168', '肇州县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1441', '168', '肇源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1442', '168', '林甸县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1443', '168', '杜尔伯特', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1444', '169', '呼玛县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1445', '169', '漠河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1446', '169', '塔河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1447', '170', '兴山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1448', '170', '工农区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1449', '170', '南山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1450', '170', '兴安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1451', '170', '向阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1452', '170', '东山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1453', '170', '萝北县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1454', '170', '绥滨县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1455', '171', '爱辉区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1456', '171', '五大连池市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1457', '171', '北安市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1458', '171', '嫩江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1459', '171', '逊克县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1460', '171', '孙吴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1461', '172', '鸡冠区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1462', '172', '恒山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1463', '172', '城子河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1464', '172', '滴道区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1465', '172', '梨树区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1466', '172', '虎林市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1467', '172', '密山市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1468', '172', '鸡东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1469', '173', '前进区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1470', '173', '郊区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1471', '173', '向阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1472', '173', '东风区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1473', '173', '同江市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1474', '173', '富锦市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1475', '173', '桦南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1476', '173', '桦川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1477', '173', '汤原县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1478', '173', '抚远县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1479', '174', '爱民区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1480', '174', '东安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1481', '174', '阳明区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1482', '174', '西安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1483', '174', '绥芬河市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1484', '174', '海林市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1485', '174', '宁安市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1486', '174', '穆棱市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1487', '174', '东宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1488', '174', '林口县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1489', '175', '桃山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1490', '175', '新兴区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1491', '175', '茄子河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1492', '175', '勃利县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1493', '176', '龙沙区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1494', '176', '昂昂溪区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1495', '176', '铁峰区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1496', '176', '建华区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1497', '176', '富拉尔基区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1498', '176', '碾子山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1499', '176', '梅里斯达斡尔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1500', '176', '讷河市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1501', '176', '龙江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1502', '176', '依安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1503', '176', '泰来县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1504', '176', '甘南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1505', '176', '富裕县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1506', '176', '克山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1507', '176', '克东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1508', '176', '拜泉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1509', '177', '尖山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1510', '177', '岭东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1511', '177', '四方台区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1512', '177', '宝山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1513', '177', '集贤县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1514', '177', '友谊县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1515', '177', '宝清县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1516', '177', '饶河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1517', '178', '北林区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1518', '178', '安达市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1519', '178', '肇东市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1520', '178', '海伦市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1521', '178', '望奎县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1522', '178', '兰西县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1523', '178', '青冈县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1524', '178', '庆安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1525', '178', '明水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1526', '178', '绥棱县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1527', '179', '伊春区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1528', '179', '带岭区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1529', '179', '南岔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1530', '179', '金山屯区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1531', '179', '西林区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1532', '179', '美溪区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1533', '179', '乌马河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1534', '179', '翠峦区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1535', '179', '友好区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1536', '179', '上甘岭区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1537', '179', '五营区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1538', '179', '红星区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1539', '179', '新青区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1540', '179', '汤旺河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1541', '179', '乌伊岭区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1542', '179', '铁力市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1543', '179', '嘉荫县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1544', '180', '江岸区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1545', '180', '武昌区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1546', '180', '江汉区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1547', '180', '硚口区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1548', '180', '汉阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1549', '180', '青山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1550', '180', '洪山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1551', '180', '东西湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1552', '180', '汉南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1553', '180', '蔡甸区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1554', '180', '江夏区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1555', '180', '黄陂区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1556', '180', '新洲区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1557', '180', '经济开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1558', '181', '仙桃市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1559', '182', '鄂城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1560', '182', '华容区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1561', '182', '梁子湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1562', '183', '黄州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1563', '183', '麻城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1564', '183', '武穴市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1565', '183', '团风县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1566', '183', '红安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1567', '183', '罗田县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1568', '183', '英山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1569', '183', '浠水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1570', '183', '蕲春县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1571', '183', '黄梅县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1572', '184', '黄石港区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1573', '184', '西塞山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1574', '184', '下陆区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1575', '184', '铁山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1576', '184', '大冶市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1577', '184', '阳新县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1578', '185', '东宝区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1579', '185', '掇刀区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1580', '185', '钟祥市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1581', '185', '京山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1582', '185', '沙洋县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1583', '186', '沙市区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1584', '186', '荆州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1585', '186', '石首市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1586', '186', '洪湖市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1587', '186', '松滋市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1588', '186', '公安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1589', '186', '监利县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1590', '186', '江陵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1591', '187', '潜江市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1592', '188', '神农架林区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1593', '189', '张湾区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1594', '189', '茅箭区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1595', '189', '丹江口市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1596', '189', '郧县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1597', '189', '郧西县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1598', '189', '竹山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1599', '189', '竹溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1600', '189', '房县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1601', '190', '曾都区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1602', '190', '广水市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1603', '191', '天门市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1604', '192', '咸安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1605', '192', '赤壁市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1606', '192', '嘉鱼县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1607', '192', '通城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1608', '192', '崇阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1609', '192', '通山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1610', '193', '襄城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1611', '193', '樊城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1612', '193', '襄阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1613', '193', '老河口市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1614', '193', '枣阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1615', '193', '宜城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1616', '193', '南漳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1617', '193', '谷城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1618', '193', '保康县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1619', '194', '孝南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1620', '194', '应城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1621', '194', '安陆市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1622', '194', '汉川市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1623', '194', '孝昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1624', '194', '大悟县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1625', '194', '云梦县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1626', '195', '长阳', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1627', '195', '五峰', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1628', '195', '西陵区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1629', '195', '伍家岗区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1630', '195', '点军区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1631', '195', '猇亭区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1632', '195', '夷陵区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1633', '195', '宜都市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1634', '195', '当阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1635', '195', '枝江市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1636', '195', '远安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1637', '195', '兴山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1638', '195', '秭归县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1639', '196', '恩施市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1640', '196', '利川市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1641', '196', '建始县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1642', '196', '巴东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1643', '196', '宣恩县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1644', '196', '咸丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1645', '196', '来凤县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1646', '196', '鹤峰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1647', '197', '岳麓区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1648', '197', '芙蓉区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1649', '197', '天心区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1650', '197', '开福区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1651', '197', '雨花区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1652', '197', '开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1653', '197', '浏阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1654', '197', '长沙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1655', '197', '望城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1656', '197', '宁乡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1657', '198', '永定区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1658', '198', '武陵源区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1659', '198', '慈利县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1660', '198', '桑植县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1661', '199', '武陵区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1662', '199', '鼎城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1663', '199', '津市市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1664', '199', '安乡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1665', '199', '汉寿县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1666', '199', '澧县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1667', '199', '临澧县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1668', '199', '桃源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1669', '199', '石门县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1670', '200', '北湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1671', '200', '苏仙区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1672', '200', '资兴市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1673', '200', '桂阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1674', '200', '宜章县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1675', '200', '永兴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1676', '200', '嘉禾县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1677', '200', '临武县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1678', '200', '汝城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1679', '200', '桂东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1680', '200', '安仁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1681', '201', '雁峰区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1682', '201', '珠晖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1683', '201', '石鼓区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1684', '201', '蒸湘区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1685', '201', '南岳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1686', '201', '耒阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1687', '201', '常宁市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1688', '201', '衡阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1689', '201', '衡南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1690', '201', '衡山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1691', '201', '衡东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1692', '201', '祁东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1693', '202', '鹤城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1694', '202', '靖州', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1695', '202', '麻阳', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1696', '202', '通道', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1697', '202', '新晃', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1698', '202', '芷江', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1699', '202', '沅陵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1700', '202', '辰溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1701', '202', '溆浦县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1702', '202', '中方县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1703', '202', '会同县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1704', '202', '洪江市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1705', '203', '娄星区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1706', '203', '冷水江市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1707', '203', '涟源市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1708', '203', '双峰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1709', '203', '新化县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1710', '204', '城步', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1711', '204', '双清区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1712', '204', '大祥区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1713', '204', '北塔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1714', '204', '武冈市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1715', '204', '邵东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1716', '204', '新邵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1717', '204', '邵阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1718', '204', '隆回县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1719', '204', '洞口县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1720', '204', '绥宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1721', '204', '新宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1722', '205', '岳塘区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1723', '205', '雨湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1724', '205', '湘乡市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1725', '205', '韶山市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1726', '205', '湘潭县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1727', '206', '吉首市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1728', '206', '泸溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1729', '206', '凤凰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1730', '206', '花垣县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1731', '206', '保靖县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1732', '206', '古丈县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1733', '206', '永顺县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1734', '206', '龙山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1735', '207', '赫山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1736', '207', '资阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1737', '207', '沅江市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1738', '207', '南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1739', '207', '桃江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1740', '207', '安化县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1741', '208', '江华', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1742', '208', '冷水滩区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1743', '208', '零陵区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1744', '208', '祁阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1745', '208', '东安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1746', '208', '双牌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1747', '208', '道县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1748', '208', '江永县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1749', '208', '宁远县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1750', '208', '蓝山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1751', '208', '新田县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1752', '209', '岳阳楼区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1753', '209', '君山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1754', '209', '云溪区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1755', '209', '汨罗市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1756', '209', '临湘市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1757', '209', '岳阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1758', '209', '华容县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1759', '209', '湘阴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1760', '209', '平江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1761', '210', '天元区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1762', '210', '荷塘区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1763', '210', '芦淞区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1764', '210', '石峰区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1765', '210', '醴陵市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1766', '210', '株洲县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1767', '210', '攸县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1768', '210', '茶陵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1769', '210', '炎陵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1770', '211', '朝阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1771', '211', '宽城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1772', '211', '二道区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1773', '211', '南关区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1774', '211', '绿园区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1775', '211', '双阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1776', '211', '净月潭开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1777', '211', '高新技术开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1778', '211', '经济技术开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1779', '211', '汽车产业开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1780', '211', '德惠市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1781', '211', '九台市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1782', '211', '榆树市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1783', '211', '农安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1784', '212', '船营区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1785', '212', '昌邑区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1786', '212', '龙潭区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1787', '212', '丰满区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1788', '212', '蛟河市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1789', '212', '桦甸市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1790', '212', '舒兰市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1791', '212', '磐石市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1792', '212', '永吉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1793', '213', '洮北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1794', '213', '洮南市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1795', '213', '大安市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1796', '213', '镇赉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1797', '213', '通榆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1798', '214', '江源区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1799', '214', '八道江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1800', '214', '长白', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1801', '214', '临江市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1802', '214', '抚松县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1803', '214', '靖宇县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1804', '215', '龙山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1805', '215', '西安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1806', '215', '东丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1807', '215', '东辽县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1808', '216', '铁西区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1809', '216', '铁东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1810', '216', '伊通', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1811', '216', '公主岭市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1812', '216', '双辽市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1813', '216', '梨树县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1814', '217', '前郭尔罗斯', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1815', '217', '宁江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1816', '217', '长岭县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1817', '217', '乾安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1818', '217', '扶余县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1819', '218', '东昌区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1820', '218', '二道江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1821', '218', '梅河口市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1822', '218', '集安市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1823', '218', '通化县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1824', '218', '辉南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1825', '218', '柳河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1826', '219', '延吉市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1827', '219', '图们市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1828', '219', '敦化市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1829', '219', '珲春市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1830', '219', '龙井市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1831', '219', '和龙市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1832', '219', '安图县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1833', '219', '汪清县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1834', '220', '玄武区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1835', '220', '鼓楼区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1836', '220', '白下区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1837', '220', '建邺区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1838', '220', '秦淮区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1839', '220', '雨花台区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1840', '220', '下关区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1841', '220', '栖霞区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1842', '220', '浦口区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1843', '220', '江宁区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1844', '220', '六合区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1845', '220', '溧水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1846', '220', '高淳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1847', '221', '沧浪区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1848', '221', '金阊区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1849', '221', '平江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1850', '221', '虎丘区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1851', '221', '吴中区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1852', '221', '相城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1853', '221', '园区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1854', '221', '新区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1855', '221', '常熟市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1856', '221', '张家港市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1857', '221', '玉山镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1858', '221', '巴城镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1859', '221', '周市镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1860', '221', '陆家镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1861', '221', '花桥镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1862', '221', '淀山湖镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1863', '221', '张浦镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1864', '221', '周庄镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1865', '221', '千灯镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1866', '221', '锦溪镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1867', '221', '开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1868', '221', '吴江市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1869', '221', '太仓市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1870', '222', '崇安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1871', '222', '北塘区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1872', '222', '南长区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1873', '222', '锡山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1874', '222', '惠山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1875', '222', '滨湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1876', '222', '新区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1877', '222', '江阴市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1878', '222', '宜兴市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1879', '223', '天宁区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1880', '223', '钟楼区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1881', '223', '戚墅堰区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1882', '223', '郊区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1883', '223', '新北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1884', '223', '武进区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1885', '223', '溧阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1886', '223', '金坛市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1887', '224', '清河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1888', '224', '清浦区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1889', '224', '楚州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1890', '224', '淮阴区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1891', '224', '涟水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1892', '224', '洪泽县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1893', '224', '盱眙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1894', '224', '金湖县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1895', '225', '新浦区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1896', '225', '连云区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1897', '225', '海州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1898', '225', '赣榆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1899', '225', '东海县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1900', '225', '灌云县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1901', '225', '灌南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1902', '226', '崇川区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1903', '226', '港闸区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1904', '226', '经济开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1905', '226', '启东市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1906', '226', '如皋市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1907', '226', '通州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1908', '226', '海门市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1909', '226', '海安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1910', '226', '如东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1911', '227', '宿城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1912', '227', '宿豫区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1913', '227', '宿豫县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1914', '227', '沭阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1915', '227', '泗阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1916', '227', '泗洪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1917', '228', '海陵区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1918', '228', '高港区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1919', '228', '兴化市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1920', '228', '靖江市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1921', '228', '泰兴市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1922', '228', '姜堰市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1923', '229', '云龙区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1924', '229', '鼓楼区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1925', '229', '九里区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1926', '229', '贾汪区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1927', '229', '泉山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1928', '229', '新沂市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1929', '229', '邳州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1930', '229', '丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1931', '229', '沛县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1932', '229', '铜山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1933', '229', '睢宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1934', '230', '城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1935', '230', '亭湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1936', '230', '盐都区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1937', '230', '盐都县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1938', '230', '东台市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1939', '230', '大丰市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1940', '230', '响水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1941', '230', '滨海县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1942', '230', '阜宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1943', '230', '射阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1944', '230', '建湖县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1945', '231', '广陵区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1946', '231', '维扬区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1947', '231', '邗江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1948', '231', '仪征市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1949', '231', '高邮市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1950', '231', '江都市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1951', '231', '宝应县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1952', '232', '京口区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1953', '232', '润州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1954', '232', '丹徒区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1955', '232', '丹阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1956', '232', '扬中市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1957', '232', '句容市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1958', '233', '东湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1959', '233', '西湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1960', '233', '青云谱区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1961', '233', '湾里区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1962', '233', '青山湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1963', '233', '红谷滩新区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1964', '233', '昌北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1965', '233', '高新区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1966', '233', '南昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1967', '233', '新建县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1968', '233', '安义县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1969', '233', '进贤县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1970', '234', '临川区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1971', '234', '南城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1972', '234', '黎川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1973', '234', '南丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1974', '234', '崇仁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1975', '234', '乐安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1976', '234', '宜黄县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1977', '234', '金溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1978', '234', '资溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1979', '234', '东乡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1980', '234', '广昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1981', '235', '章贡区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1982', '235', '于都县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1983', '235', '瑞金市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1984', '235', '南康市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1985', '235', '赣县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1986', '235', '信丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1987', '235', '大余县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1988', '235', '上犹县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1989', '235', '崇义县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1990', '235', '安远县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1991', '235', '龙南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1992', '235', '定南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1993', '235', '全南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1994', '235', '宁都县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1995', '235', '兴国县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1996', '235', '会昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1997', '235', '寻乌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1998', '235', '石城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1999', '236', '安福县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2000', '236', '吉州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2001', '236', '青原区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2002', '236', '井冈山市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2003', '236', '吉安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2004', '236', '吉水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2005', '236', '峡江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2006', '236', '新干县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2007', '236', '永丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2008', '236', '泰和县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2009', '236', '遂川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2010', '236', '万安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2011', '236', '永新县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2012', '237', '珠山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2013', '237', '昌江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2014', '237', '乐平市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2015', '237', '浮梁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2016', '238', '浔阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2017', '238', '庐山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2018', '238', '瑞昌市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2019', '238', '九江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2020', '238', '武宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2021', '238', '修水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2022', '238', '永修县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2023', '238', '德安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2024', '238', '星子县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2025', '238', '都昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2026', '238', '湖口县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2027', '238', '彭泽县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2028', '239', '安源区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2029', '239', '湘东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2030', '239', '莲花县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2031', '239', '芦溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2032', '239', '上栗县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2033', '240', '信州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2034', '240', '德兴市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2035', '240', '上饶县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2036', '240', '广丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2037', '240', '玉山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2038', '240', '铅山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2039', '240', '横峰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2040', '240', '弋阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2041', '240', '余干县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2042', '240', '波阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2043', '240', '万年县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2044', '240', '婺源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2045', '241', '渝水区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2046', '241', '分宜县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2047', '242', '袁州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2048', '242', '丰城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2049', '242', '樟树市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2050', '242', '高安市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2051', '242', '奉新县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2052', '242', '万载县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2053', '242', '上高县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2054', '242', '宜丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2055', '242', '靖安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2056', '242', '铜鼓县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2057', '243', '月湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2058', '243', '贵溪市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2059', '243', '余江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2060', '244', '沈河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2061', '244', '皇姑区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2062', '244', '和平区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2063', '244', '大东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2064', '244', '铁西区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2065', '244', '苏家屯区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2066', '244', '东陵区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2067', '244', '沈北新区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2068', '244', '于洪区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2069', '244', '浑南新区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2070', '244', '新民市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2071', '244', '辽中县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2072', '244', '康平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2073', '244', '法库县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2074', '245', '西岗区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2075', '245', '中山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2076', '245', '沙河口区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2077', '245', '甘井子区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2078', '245', '旅顺口区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2079', '245', '金州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2080', '245', '开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2081', '245', '瓦房店市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2082', '245', '普兰店市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2083', '245', '庄河市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2084', '245', '长海县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2085', '246', '铁东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2086', '246', '铁西区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2087', '246', '立山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2088', '246', '千山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2089', '246', '岫岩', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2090', '246', '海城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2091', '246', '台安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2092', '247', '本溪', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2093', '247', '平山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2094', '247', '明山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2095', '247', '溪湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2096', '247', '南芬区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2097', '247', '桓仁', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2098', '248', '双塔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2099', '248', '龙城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2100', '248', '喀喇沁左翼蒙古族自治', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2101', '248', '北票市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2102', '248', '凌源市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2103', '248', '朝阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2104', '248', '建平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2105', '249', '振兴区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2106', '249', '元宝区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2107', '249', '振安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2108', '249', '宽甸', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2109', '249', '东港市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2110', '249', '凤城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2111', '250', '顺城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2112', '250', '新抚区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2113', '250', '东洲区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2114', '250', '望花区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2115', '250', '清原', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2116', '250', '新宾', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2117', '250', '抚顺县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2118', '251', '阜新', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2119', '251', '海州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2120', '251', '新邱区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2121', '251', '太平区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2122', '251', '清河门区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2123', '251', '细河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2124', '251', '彰武县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2125', '252', '龙港区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2126', '252', '南票区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2127', '252', '连山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2128', '252', '兴城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2129', '252', '绥中县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2130', '252', '建昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2131', '253', '太和区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2132', '253', '古塔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2133', '253', '凌河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2134', '253', '凌海市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2135', '253', '北镇市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2136', '253', '黑山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2137', '253', '义县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2138', '254', '白塔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2139', '254', '文圣区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2140', '254', '宏伟区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2141', '254', '太子河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2142', '254', '弓长岭区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2143', '254', '灯塔市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2144', '254', '辽阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2145', '255', '双台子区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2146', '255', '兴隆台区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2147', '255', '大洼县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2148', '255', '盘山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2149', '256', '银州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2150', '256', '清河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2151', '256', '调兵山市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2152', '256', '开原市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2153', '256', '铁岭县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2154', '256', '西丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2155', '256', '昌图县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2156', '257', '站前区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2157', '257', '西市区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2158', '257', '鲅鱼圈区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2159', '257', '老边区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2160', '257', '盖州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2161', '257', '大石桥市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2162', '258', '回民区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2163', '258', '玉泉区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2164', '258', '新城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2165', '258', '赛罕区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2166', '258', '清水河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2167', '258', '土默特左旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2168', '258', '托克托县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2169', '258', '和林格尔县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2170', '258', '武川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2171', '259', '阿拉善左旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2172', '259', '阿拉善右旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2173', '259', '额济纳旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2174', '260', '临河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2175', '260', '五原县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2176', '260', '磴口县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2177', '260', '乌拉特前旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2178', '260', '乌拉特中旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2179', '260', '乌拉特后旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2180', '260', '杭锦后旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2181', '261', '昆都仑区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2182', '261', '青山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2183', '261', '东河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2184', '261', '九原区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2185', '261', '石拐区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2186', '261', '白云矿区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2187', '261', '土默特右旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2188', '261', '固阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2189', '261', '达尔罕茂明安联合旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2190', '262', '红山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2191', '262', '元宝山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2192', '262', '松山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2193', '262', '阿鲁科尔沁旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2194', '262', '巴林左旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2195', '262', '巴林右旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2196', '262', '林西县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2197', '262', '克什克腾旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2198', '262', '翁牛特旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2199', '262', '喀喇沁旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2200', '262', '宁城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2201', '262', '敖汉旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2202', '263', '东胜区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2203', '263', '达拉特旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2204', '263', '准格尔旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2205', '263', '鄂托克前旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2206', '263', '鄂托克旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2207', '263', '杭锦旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2208', '263', '乌审旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2209', '263', '伊金霍洛旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2210', '264', '海拉尔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2211', '264', '莫力达瓦', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2212', '264', '满洲里市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2213', '264', '牙克石市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2214', '264', '扎兰屯市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2215', '264', '额尔古纳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2216', '264', '根河市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2217', '264', '阿荣旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2218', '264', '鄂伦春自治旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2219', '264', '鄂温克族自治旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2220', '264', '陈巴尔虎旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2221', '264', '新巴尔虎左旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2222', '264', '新巴尔虎右旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2223', '265', '科尔沁区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2224', '265', '霍林郭勒市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2225', '265', '科尔沁左翼中旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2226', '265', '科尔沁左翼后旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2227', '265', '开鲁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2228', '265', '库伦旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2229', '265', '奈曼旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2230', '265', '扎鲁特旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2231', '266', '海勃湾区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2232', '266', '乌达区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2233', '266', '海南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2234', '267', '化德县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2235', '267', '集宁区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2236', '267', '丰镇市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2237', '267', '卓资县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2238', '267', '商都县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2239', '267', '兴和县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2240', '267', '凉城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2241', '267', '察哈尔右翼前旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2242', '267', '察哈尔右翼中旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2243', '267', '察哈尔右翼后旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2244', '267', '四子王旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2245', '268', '二连浩特市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2246', '268', '锡林浩特市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2247', '268', '阿巴嘎旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2248', '268', '苏尼特左旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2249', '268', '苏尼特右旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2250', '268', '东乌珠穆沁旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2251', '268', '西乌珠穆沁旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2252', '268', '太仆寺旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2253', '268', '镶黄旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2254', '268', '正镶白旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2255', '268', '正蓝旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2256', '268', '多伦县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2257', '269', '乌兰浩特市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2258', '269', '阿尔山市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2259', '269', '科尔沁右翼前旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2260', '269', '科尔沁右翼中旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2261', '269', '扎赉特旗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2262', '269', '突泉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2263', '270', '西夏区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2264', '270', '金凤区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2265', '270', '兴庆区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2266', '270', '灵武市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2267', '270', '永宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2268', '270', '贺兰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2269', '271', '原州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2270', '271', '海原县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2271', '271', '西吉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2272', '271', '隆德县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2273', '271', '泾源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2274', '271', '彭阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2275', '272', '惠农县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2276', '272', '大武口区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2277', '272', '惠农区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2278', '272', '陶乐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2279', '272', '平罗县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2280', '273', '利通区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2281', '273', '中卫县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2282', '273', '青铜峡市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2283', '273', '中宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2284', '273', '盐池县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2285', '273', '同心县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2286', '274', '沙坡头区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2287', '274', '海原县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2288', '274', '中宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2289', '275', '城中区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2290', '275', '城东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2291', '275', '城西区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2292', '275', '城北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2293', '275', '湟中县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2294', '275', '湟源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2295', '275', '大通', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2296', '276', '玛沁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2297', '276', '班玛县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2298', '276', '甘德县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2299', '276', '达日县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2300', '276', '久治县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2301', '276', '玛多县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2302', '277', '海晏县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2303', '277', '祁连县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2304', '277', '刚察县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2305', '277', '门源', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2306', '278', '平安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2307', '278', '乐都县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2308', '278', '民和', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2309', '278', '互助', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2310', '278', '化隆', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2311', '278', '循化', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2312', '279', '共和县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2313', '279', '同德县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2314', '279', '贵德县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2315', '279', '兴海县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2316', '279', '贵南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2317', '280', '德令哈市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2318', '280', '格尔木市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2319', '280', '乌兰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2320', '280', '都兰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2321', '280', '天峻县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2322', '281', '同仁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2323', '281', '尖扎县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2324', '281', '泽库县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2325', '281', '河南蒙古族自治县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2326', '282', '玉树县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2327', '282', '杂多县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2328', '282', '称多县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2329', '282', '治多县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2330', '282', '囊谦县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2331', '282', '曲麻莱县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2332', '283', '市中区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2333', '283', '历下区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2334', '283', '天桥区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2335', '283', '槐荫区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2336', '283', '历城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2337', '283', '长清区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2338', '283', '章丘市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2339', '283', '平阴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2340', '283', '济阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2341', '283', '商河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2342', '284', '市南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2343', '284', '市北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2344', '284', '城阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2345', '284', '四方区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2346', '284', '李沧区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2347', '284', '黄岛区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2348', '284', '崂山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2349', '284', '胶州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2350', '284', '即墨市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2351', '284', '平度市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2352', '284', '胶南市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2353', '284', '莱西市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2354', '285', '滨城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2355', '285', '惠民县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2356', '285', '阳信县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2357', '285', '无棣县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2358', '285', '沾化县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2359', '285', '博兴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2360', '285', '邹平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2361', '286', '德城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2362', '286', '陵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2363', '286', '乐陵市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2364', '286', '禹城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2365', '286', '宁津县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2366', '286', '庆云县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2367', '286', '临邑县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2368', '286', '齐河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2369', '286', '平原县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2370', '286', '夏津县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2371', '286', '武城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2372', '287', '东营区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2373', '287', '河口区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2374', '287', '垦利县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2375', '287', '利津县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2376', '287', '广饶县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2377', '288', '牡丹区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2378', '288', '曹县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2379', '288', '单县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2380', '288', '成武县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2381', '288', '巨野县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2382', '288', '郓城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2383', '288', '鄄城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2384', '288', '定陶县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2385', '288', '东明县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2386', '289', '市中区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2387', '289', '任城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2388', '289', '曲阜市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2389', '289', '兖州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2390', '289', '邹城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2391', '289', '微山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2392', '289', '鱼台县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2393', '289', '金乡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2394', '289', '嘉祥县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2395', '289', '汶上县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2396', '289', '泗水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2397', '289', '梁山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2398', '290', '莱城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2399', '290', '钢城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2400', '291', '东昌府区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2401', '291', '临清市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2402', '291', '阳谷县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2403', '291', '莘县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2404', '291', '茌平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2405', '291', '东阿县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2406', '291', '冠县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2407', '291', '高唐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2408', '292', '兰山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2409', '292', '罗庄区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2410', '292', '河东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2411', '292', '沂南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2412', '292', '郯城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2413', '292', '沂水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2414', '292', '苍山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2415', '292', '费县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2416', '292', '平邑县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2417', '292', '莒南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2418', '292', '蒙阴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2419', '292', '临沭县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2420', '293', '东港区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2421', '293', '岚山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2422', '293', '五莲县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2423', '293', '莒县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2424', '294', '泰山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2425', '294', '岱岳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2426', '294', '新泰市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2427', '294', '肥城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2428', '294', '宁阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2429', '294', '东平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2430', '295', '荣成市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2431', '295', '乳山市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2432', '295', '环翠区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2433', '295', '文登市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2434', '296', '潍城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2435', '296', '寒亭区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2436', '296', '坊子区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2437', '296', '奎文区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2438', '296', '青州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2439', '296', '诸城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2440', '296', '寿光市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2441', '296', '安丘市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2442', '296', '高密市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2443', '296', '昌邑市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2444', '296', '临朐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2445', '296', '昌乐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2446', '297', '芝罘区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2447', '297', '福山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2448', '297', '牟平区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2449', '297', '莱山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2450', '297', '开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2451', '297', '龙口市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2452', '297', '莱阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2453', '297', '莱州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2454', '297', '蓬莱市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2455', '297', '招远市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2456', '297', '栖霞市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2457', '297', '海阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2458', '297', '长岛县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2459', '298', '市中区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2460', '298', '山亭区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2461', '298', '峄城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2462', '298', '台儿庄区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2463', '298', '薛城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2464', '298', '滕州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2465', '299', '张店区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2466', '299', '临淄区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2467', '299', '淄川区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2468', '299', '博山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2469', '299', '周村区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2470', '299', '桓台县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2471', '299', '高青县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2472', '299', '沂源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2473', '300', '杏花岭区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2474', '300', '小店区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2475', '300', '迎泽区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2476', '300', '尖草坪区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2477', '300', '万柏林区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2478', '300', '晋源区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2479', '300', '高新开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2480', '300', '民营经济开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2481', '300', '经济技术开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2482', '300', '清徐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2483', '300', '阳曲县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2484', '300', '娄烦县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2485', '300', '古交市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2486', '301', '城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2487', '301', '郊区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2488', '301', '沁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2489', '301', '潞城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2490', '301', '长治县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2491', '301', '襄垣县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2492', '301', '屯留县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2493', '301', '平顺县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2494', '301', '黎城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2495', '301', '壶关县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2496', '301', '长子县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2497', '301', '武乡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2498', '301', '沁源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2499', '302', '城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2500', '302', '矿区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2501', '302', '南郊区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2502', '302', '新荣区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2503', '302', '阳高县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2504', '302', '天镇县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2505', '302', '广灵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2506', '302', '灵丘县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2507', '302', '浑源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2508', '302', '左云县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2509', '302', '大同县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2510', '303', '城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2511', '303', '高平市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2512', '303', '沁水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2513', '303', '阳城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2514', '303', '陵川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2515', '303', '泽州县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2516', '304', '榆次区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2517', '304', '介休市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2518', '304', '榆社县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2519', '304', '左权县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2520', '304', '和顺县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2521', '304', '昔阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2522', '304', '寿阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2523', '304', '太谷县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2524', '304', '祁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2525', '304', '平遥县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2526', '304', '灵石县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2527', '305', '尧都区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2528', '305', '侯马市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2529', '305', '霍州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2530', '305', '曲沃县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2531', '305', '翼城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2532', '305', '襄汾县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2533', '305', '洪洞县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2534', '305', '吉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2535', '305', '安泽县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2536', '305', '浮山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2537', '305', '古县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2538', '305', '乡宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2539', '305', '大宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2540', '305', '隰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2541', '305', '永和县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2542', '305', '蒲县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2543', '305', '汾西县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2544', '306', '离石市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2545', '306', '离石区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2546', '306', '孝义市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2547', '306', '汾阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2548', '306', '文水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2549', '306', '交城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2550', '306', '兴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2551', '306', '临县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2552', '306', '柳林县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2553', '306', '石楼县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2554', '306', '岚县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2555', '306', '方山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2556', '306', '中阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2557', '306', '交口县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2558', '307', '朔城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2559', '307', '平鲁区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2560', '307', '山阴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2561', '307', '应县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2562', '307', '右玉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2563', '307', '怀仁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2564', '308', '忻府区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2565', '308', '原平市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2566', '308', '定襄县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2567', '308', '五台县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2568', '308', '代县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2569', '308', '繁峙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2570', '308', '宁武县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2571', '308', '静乐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2572', '308', '神池县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2573', '308', '五寨县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2574', '308', '岢岚县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2575', '308', '河曲县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2576', '308', '保德县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2577', '308', '偏关县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2578', '309', '城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2579', '309', '矿区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2580', '309', '郊区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2581', '309', '平定县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2582', '309', '盂县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2583', '310', '盐湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2584', '310', '永济市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2585', '310', '河津市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2586', '310', '临猗县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2587', '310', '万荣县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2588', '310', '闻喜县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2589', '310', '稷山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2590', '310', '新绛县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2591', '310', '绛县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2592', '310', '垣曲县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2593', '310', '夏县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2594', '310', '平陆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2595', '310', '芮城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2596', '311', '莲湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2597', '311', '新城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2598', '311', '碑林区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2599', '311', '雁塔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2600', '311', '灞桥区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2601', '311', '未央区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2602', '311', '阎良区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2603', '311', '临潼区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2604', '311', '长安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2605', '311', '蓝田县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2606', '311', '周至县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2607', '311', '户县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2608', '311', '高陵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2609', '312', '汉滨区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2610', '312', '汉阴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2611', '312', '石泉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2612', '312', '宁陕县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2613', '312', '紫阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2614', '312', '岚皋县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2615', '312', '平利县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2616', '312', '镇坪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2617', '312', '旬阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2618', '312', '白河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2619', '313', '陈仓区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2620', '313', '渭滨区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2621', '313', '金台区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2622', '313', '凤翔县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2623', '313', '岐山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2624', '313', '扶风县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2625', '313', '眉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2626', '313', '陇县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2627', '313', '千阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2628', '313', '麟游县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2629', '313', '凤县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2630', '313', '太白县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2631', '314', '汉台区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2632', '314', '南郑县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2633', '314', '城固县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2634', '314', '洋县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2635', '314', '西乡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2636', '314', '勉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2637', '314', '宁强县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2638', '314', '略阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2639', '314', '镇巴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2640', '314', '留坝县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2641', '314', '佛坪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2642', '315', '商州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2643', '315', '洛南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2644', '315', '丹凤县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2645', '315', '商南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2646', '315', '山阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2647', '315', '镇安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2648', '315', '柞水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2649', '316', '耀州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2650', '316', '王益区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2651', '316', '印台区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2652', '316', '宜君县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2653', '317', '临渭区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2654', '317', '韩城市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2655', '317', '华阴市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2656', '317', '华县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2657', '317', '潼关县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2658', '317', '大荔县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2659', '317', '合阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2660', '317', '澄城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2661', '317', '蒲城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2662', '317', '白水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2663', '317', '富平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2664', '318', '秦都区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2665', '318', '渭城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2666', '318', '杨陵区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2667', '318', '兴平市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2668', '318', '三原县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2669', '318', '泾阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2670', '318', '乾县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2671', '318', '礼泉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2672', '318', '永寿县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2673', '318', '彬县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2674', '318', '长武县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2675', '318', '旬邑县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2676', '318', '淳化县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2677', '318', '武功县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2678', '319', '吴起县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2679', '319', '宝塔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2680', '319', '延长县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2681', '319', '延川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2682', '319', '子长县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2683', '319', '安塞县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2684', '319', '志丹县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2685', '319', '甘泉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2686', '319', '富县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2687', '319', '洛川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2688', '319', '宜川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2689', '319', '黄龙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2690', '319', '黄陵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2691', '320', '榆阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2692', '320', '神木县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2693', '320', '府谷县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2694', '320', '横山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2695', '320', '靖边县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2696', '320', '定边县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2697', '320', '绥德县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2698', '320', '米脂县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2699', '320', '佳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2700', '320', '吴堡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2701', '320', '清涧县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2702', '320', '子洲县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2703', '321', '长宁区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2704', '321', '闸北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2705', '321', '闵行区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2706', '321', '徐汇区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2707', '321', '浦东新区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2708', '321', '杨浦区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2709', '321', '普陀区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2710', '321', '静安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2711', '321', '卢湾区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2712', '321', '虹口区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2713', '321', '黄浦区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2714', '321', '南汇区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2715', '321', '松江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2716', '321', '嘉定区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2717', '321', '宝山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2718', '321', '青浦区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2719', '321', '金山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2720', '321', '奉贤区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2721', '321', '崇明县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2722', '322', '青羊区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2723', '322', '锦江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2724', '322', '金牛区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2725', '322', '武侯区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2726', '322', '成华区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2727', '322', '龙泉驿区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2728', '322', '青白江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2729', '322', '新都区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2730', '322', '温江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2731', '322', '高新区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2732', '322', '高新西区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2733', '322', '都江堰市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2734', '322', '彭州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2735', '322', '邛崃市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2736', '322', '崇州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2737', '322', '金堂县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2738', '322', '双流县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2739', '322', '郫县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2740', '322', '大邑县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2741', '322', '蒲江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2742', '322', '新津县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2743', '322', '都江堰市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2744', '322', '彭州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2745', '322', '邛崃市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2746', '322', '崇州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2747', '322', '金堂县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2748', '322', '双流县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2749', '322', '郫县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2750', '322', '大邑县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2751', '322', '蒲江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2752', '322', '新津县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2753', '323', '涪城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2754', '323', '游仙区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2755', '323', '江油市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2756', '323', '盐亭县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2757', '323', '三台县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2758', '323', '平武县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2759', '323', '安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2760', '323', '梓潼县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2761', '323', '北川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2762', '324', '马尔康县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2763', '324', '汶川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2764', '324', '理县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2765', '324', '茂县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2766', '324', '松潘县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2767', '324', '九寨沟县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2768', '324', '金川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2769', '324', '小金县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2770', '324', '黑水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2771', '324', '壤塘县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2772', '324', '阿坝县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2773', '324', '若尔盖县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2774', '324', '红原县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2775', '325', '巴州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2776', '325', '通江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2777', '325', '南江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2778', '325', '平昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2779', '326', '通川区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2780', '326', '万源市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2781', '326', '达县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2782', '326', '宣汉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2783', '326', '开江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2784', '326', '大竹县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2785', '326', '渠县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2786', '327', '旌阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2787', '327', '广汉市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2788', '327', '什邡市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2789', '327', '绵竹市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2790', '327', '罗江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2791', '327', '中江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2792', '328', '康定县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2793', '328', '丹巴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2794', '328', '泸定县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2795', '328', '炉霍县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2796', '328', '九龙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2797', '328', '甘孜县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2798', '328', '雅江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2799', '328', '新龙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2800', '328', '道孚县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2801', '328', '白玉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2802', '328', '理塘县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2803', '328', '德格县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2804', '328', '乡城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2805', '328', '石渠县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2806', '328', '稻城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2807', '328', '色达县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2808', '328', '巴塘县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2809', '328', '得荣县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2810', '329', '广安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2811', '329', '华蓥市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2812', '329', '岳池县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2813', '329', '武胜县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2814', '329', '邻水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2815', '330', '利州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2816', '330', '元坝区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2817', '330', '朝天区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2818', '330', '旺苍县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2819', '330', '青川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2820', '330', '剑阁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2821', '330', '苍溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2822', '331', '峨眉山市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2823', '331', '乐山市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2824', '331', '犍为县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2825', '331', '井研县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2826', '331', '夹江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2827', '331', '沐川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2828', '331', '峨边', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2829', '331', '马边', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2830', '332', '西昌市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2831', '332', '盐源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2832', '332', '德昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2833', '332', '会理县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2834', '332', '会东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2835', '332', '宁南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2836', '332', '普格县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2837', '332', '布拖县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2838', '332', '金阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2839', '332', '昭觉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2840', '332', '喜德县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2841', '332', '冕宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2842', '332', '越西县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2843', '332', '甘洛县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2844', '332', '美姑县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2845', '332', '雷波县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2846', '332', '木里', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2847', '333', '东坡区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2848', '333', '仁寿县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2849', '333', '彭山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2850', '333', '洪雅县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2851', '333', '丹棱县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2852', '333', '青神县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2853', '334', '阆中市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2854', '334', '南部县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2855', '334', '营山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2856', '334', '蓬安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2857', '334', '仪陇县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2858', '334', '顺庆区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2859', '334', '高坪区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2860', '334', '嘉陵区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2861', '334', '西充县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2862', '335', '市中区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2863', '335', '东兴区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2864', '335', '威远县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2865', '335', '资中县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2866', '335', '隆昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2867', '336', '东  区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2868', '336', '西  区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2869', '336', '仁和区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2870', '336', '米易县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2871', '336', '盐边县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2872', '337', '船山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2873', '337', '安居区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2874', '337', '蓬溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2875', '337', '射洪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2876', '337', '大英县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2877', '338', '雨城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2878', '338', '名山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2879', '338', '荥经县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2880', '338', '汉源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2881', '338', '石棉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2882', '338', '天全县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2883', '338', '芦山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2884', '338', '宝兴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2885', '339', '翠屏区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2886', '339', '宜宾县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2887', '339', '南溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2888', '339', '江安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2889', '339', '长宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2890', '339', '高县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2891', '339', '珙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2892', '339', '筠连县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2893', '339', '兴文县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2894', '339', '屏山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2895', '340', '雁江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2896', '340', '简阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2897', '340', '安岳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2898', '340', '乐至县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2899', '341', '大安区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2900', '341', '自流井区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2901', '341', '贡井区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2902', '341', '沿滩区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2903', '341', '荣县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2904', '341', '富顺县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2905', '342', '江阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2906', '342', '纳溪区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2907', '342', '龙马潭区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2908', '342', '泸县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2909', '342', '合江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2910', '342', '叙永县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2911', '342', '古蔺县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2912', '343', '和平区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2913', '343', '河西区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2914', '343', '南开区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2915', '343', '河北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2916', '343', '河东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2917', '343', '红桥区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2918', '343', '东丽区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2919', '343', '津南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2920', '343', '西青区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2921', '343', '北辰区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2922', '343', '塘沽区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2923', '343', '汉沽区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2924', '343', '大港区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2925', '343', '武清区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2926', '343', '宝坻区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2927', '343', '经济开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2928', '343', '宁河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2929', '343', '静海县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2930', '343', '蓟县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2931', '344', '城关区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2932', '344', '林周县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2933', '344', '当雄县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2934', '344', '尼木县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2935', '344', '曲水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2936', '344', '堆龙德庆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2937', '344', '达孜县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2938', '344', '墨竹工卡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2939', '345', '噶尔县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2940', '345', '普兰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2941', '345', '札达县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2942', '345', '日土县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2943', '345', '革吉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2944', '345', '改则县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2945', '345', '措勤县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2946', '346', '昌都县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2947', '346', '江达县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2948', '346', '贡觉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2949', '346', '类乌齐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2950', '346', '丁青县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2951', '346', '察雅县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2952', '346', '八宿县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2953', '346', '左贡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2954', '346', '芒康县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2955', '346', '洛隆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2956', '346', '边坝县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2957', '347', '林芝县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2958', '347', '工布江达县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2959', '347', '米林县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2960', '347', '墨脱县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2961', '347', '波密县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2962', '347', '察隅县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2963', '347', '朗县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2964', '348', '那曲县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2965', '348', '嘉黎县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2966', '348', '比如县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2967', '348', '聂荣县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2968', '348', '安多县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2969', '348', '申扎县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2970', '348', '索县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2971', '348', '班戈县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2972', '348', '巴青县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2973', '348', '尼玛县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2974', '349', '日喀则市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2975', '349', '南木林县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2976', '349', '江孜县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2977', '349', '定日县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2978', '349', '萨迦县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2979', '349', '拉孜县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2980', '349', '昂仁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2981', '349', '谢通门县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2982', '349', '白朗县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2983', '349', '仁布县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2984', '349', '康马县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2985', '349', '定结县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2986', '349', '仲巴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2987', '349', '亚东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2988', '349', '吉隆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2989', '349', '聂拉木县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2990', '349', '萨嘎县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2991', '349', '岗巴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2992', '350', '乃东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2993', '350', '扎囊县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2994', '350', '贡嘎县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2995', '350', '桑日县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2996', '350', '琼结县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2997', '350', '曲松县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2998', '350', '措美县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('2999', '350', '洛扎县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3000', '350', '加查县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3001', '350', '隆子县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3002', '350', '错那县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3003', '350', '浪卡子县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3004', '351', '天山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3005', '351', '沙依巴克区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3006', '351', '新市区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3007', '351', '水磨沟区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3008', '351', '头屯河区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3009', '351', '达坂城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3010', '351', '米东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3011', '351', '乌鲁木齐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3012', '352', '阿克苏市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3013', '352', '温宿县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3014', '352', '库车县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3015', '352', '沙雅县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3016', '352', '新和县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3017', '352', '拜城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3018', '352', '乌什县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3019', '352', '阿瓦提县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3020', '352', '柯坪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3021', '353', '阿拉尔市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3022', '354', '库尔勒市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3023', '354', '轮台县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3024', '354', '尉犁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3025', '354', '若羌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3026', '354', '且末县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3027', '354', '焉耆', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3028', '354', '和静县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3029', '354', '和硕县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3030', '354', '博湖县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3031', '355', '博乐市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3032', '355', '精河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3033', '355', '温泉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3034', '356', '呼图壁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3035', '356', '米泉市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3036', '356', '昌吉市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3037', '356', '阜康市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3038', '356', '玛纳斯县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3039', '356', '奇台县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3040', '356', '吉木萨尔县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3041', '356', '木垒', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3042', '357', '哈密市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3043', '357', '伊吾县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3044', '357', '巴里坤', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3045', '358', '和田市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3046', '358', '和田县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3047', '358', '墨玉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3048', '358', '皮山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3049', '358', '洛浦县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3050', '358', '策勒县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3051', '358', '于田县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3052', '358', '民丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3053', '359', '喀什市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3054', '359', '疏附县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3055', '359', '疏勒县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3056', '359', '英吉沙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3057', '359', '泽普县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3058', '359', '莎车县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3059', '359', '叶城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3060', '359', '麦盖提县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3061', '359', '岳普湖县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3062', '359', '伽师县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3063', '359', '巴楚县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3064', '359', '塔什库尔干', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3065', '360', '克拉玛依市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3066', '361', '阿图什市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3067', '361', '阿克陶县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3068', '361', '阿合奇县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3069', '361', '乌恰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3070', '362', '石河子市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3071', '363', '图木舒克市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3072', '364', '吐鲁番市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3073', '364', '鄯善县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3074', '364', '托克逊县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3075', '365', '五家渠市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3076', '366', '阿勒泰市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3077', '366', '布克赛尔', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3078', '366', '伊宁市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3079', '366', '布尔津县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3080', '366', '奎屯市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3081', '366', '乌苏市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3082', '366', '额敏县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3083', '366', '富蕴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3084', '366', '伊宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3085', '366', '福海县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3086', '366', '霍城县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3087', '366', '沙湾县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3088', '366', '巩留县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3089', '366', '哈巴河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3090', '366', '托里县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3091', '366', '青河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3092', '366', '新源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3093', '366', '裕民县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3094', '366', '和布克赛尔', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3095', '366', '吉木乃县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3096', '366', '昭苏县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3097', '366', '特克斯县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3098', '366', '尼勒克县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3099', '366', '察布查尔', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3100', '367', '盘龙区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3101', '367', '五华区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3102', '367', '官渡区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3103', '367', '西山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3104', '367', '东川区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3105', '367', '安宁市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3106', '367', '呈贡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3107', '367', '晋宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3108', '367', '富民县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3109', '367', '宜良县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3110', '367', '嵩明县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3111', '367', '石林县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3112', '367', '禄劝', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3113', '367', '寻甸', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3114', '368', '兰坪', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3115', '368', '泸水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3116', '368', '福贡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3117', '368', '贡山', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3118', '369', '宁洱', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3119', '369', '思茅区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3120', '369', '墨江', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3121', '369', '景东', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3122', '369', '景谷', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3123', '369', '镇沅', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3124', '369', '江城', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3125', '369', '孟连', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3126', '369', '澜沧', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3127', '369', '西盟', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3128', '370', '古城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3129', '370', '宁蒗', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3130', '370', '玉龙', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3131', '370', '永胜县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3132', '370', '华坪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3133', '371', '隆阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3134', '371', '施甸县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3135', '371', '腾冲县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3136', '371', '龙陵县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3137', '371', '昌宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3138', '372', '楚雄市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3139', '372', '双柏县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3140', '372', '牟定县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3141', '372', '南华县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3142', '372', '姚安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3143', '372', '大姚县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3144', '372', '永仁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3145', '372', '元谋县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3146', '372', '武定县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3147', '372', '禄丰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3148', '373', '大理市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3149', '373', '祥云县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3150', '373', '宾川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3151', '373', '弥渡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3152', '373', '永平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3153', '373', '云龙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3154', '373', '洱源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3155', '373', '剑川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3156', '373', '鹤庆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3157', '373', '漾濞', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3158', '373', '南涧', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3159', '373', '巍山', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3160', '374', '潞西市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3161', '374', '瑞丽市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3162', '374', '梁河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3163', '374', '盈江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3164', '374', '陇川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3165', '375', '香格里拉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3166', '375', '德钦县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3167', '375', '维西', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3168', '376', '泸西县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3169', '376', '蒙自县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3170', '376', '个旧市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3171', '376', '开远市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3172', '376', '绿春县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3173', '376', '建水县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3174', '376', '石屏县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3175', '376', '弥勒县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3176', '376', '元阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3177', '376', '红河县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3178', '376', '金平', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3179', '376', '河口', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3180', '376', '屏边', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3181', '377', '临翔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3182', '377', '凤庆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3183', '377', '云县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3184', '377', '永德县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3185', '377', '镇康县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3186', '377', '双江', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3187', '377', '耿马', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3188', '377', '沧源', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3189', '378', '麒麟区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3190', '378', '宣威市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3191', '378', '马龙县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3192', '378', '陆良县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3193', '378', '师宗县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3194', '378', '罗平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3195', '378', '富源县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3196', '378', '会泽县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3197', '378', '沾益县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3198', '379', '文山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3199', '379', '砚山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3200', '379', '西畴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3201', '379', '麻栗坡县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3202', '379', '马关县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3203', '379', '丘北县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3204', '379', '广南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3205', '379', '富宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3206', '380', '景洪市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3207', '380', '勐海县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3208', '380', '勐腊县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3209', '381', '红塔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3210', '381', '江川县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3211', '381', '澄江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3212', '381', '通海县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3213', '381', '华宁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3214', '381', '易门县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3215', '381', '峨山', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3216', '381', '新平', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3217', '381', '元江', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3218', '382', '昭阳区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3219', '382', '鲁甸县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3220', '382', '巧家县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3221', '382', '盐津县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3222', '382', '大关县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3223', '382', '永善县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3224', '382', '绥江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3225', '382', '镇雄县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3226', '382', '彝良县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3227', '382', '威信县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3228', '382', '水富县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3229', '383', '西湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3230', '383', '上城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3231', '383', '下城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3232', '383', '拱墅区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3233', '383', '滨江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3234', '383', '江干区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3235', '383', '萧山区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3236', '383', '余杭区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3237', '383', '市郊', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3238', '383', '建德市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3239', '383', '富阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3240', '383', '临安市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3241', '383', '桐庐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3242', '383', '淳安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3243', '384', '吴兴区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3244', '384', '南浔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3245', '384', '德清县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3246', '384', '长兴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3247', '384', '安吉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3248', '385', '南湖区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3249', '385', '秀洲区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3250', '385', '海宁市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3251', '385', '嘉善县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3252', '385', '平湖市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3253', '385', '桐乡市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3254', '385', '海盐县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3255', '386', '婺城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3256', '386', '金东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3257', '386', '兰溪市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3258', '386', '市区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3259', '386', '佛堂镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3260', '386', '上溪镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3261', '386', '义亭镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3262', '386', '大陈镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3263', '386', '苏溪镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3264', '386', '赤岸镇', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3265', '386', '东阳市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3266', '386', '永康市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3267', '386', '武义县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3268', '386', '浦江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3269', '386', '磐安县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3270', '387', '莲都区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3271', '387', '龙泉市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3272', '387', '青田县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3273', '387', '缙云县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3274', '387', '遂昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3275', '387', '松阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3276', '387', '云和县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3277', '387', '庆元县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3278', '387', '景宁', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3279', '388', '海曙区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3280', '388', '江东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3281', '388', '江北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3282', '388', '镇海区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3283', '388', '北仑区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3284', '388', '鄞州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3285', '388', '余姚市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3286', '388', '慈溪市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3287', '388', '奉化市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3288', '388', '象山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3289', '388', '宁海县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3290', '389', '越城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3291', '389', '上虞市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3292', '389', '嵊州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3293', '389', '绍兴县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3294', '389', '新昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3295', '389', '诸暨市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3296', '390', '椒江区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3297', '390', '黄岩区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3298', '390', '路桥区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3299', '390', '温岭市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3300', '390', '临海市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3301', '390', '玉环县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3302', '390', '三门县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3303', '390', '天台县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3304', '390', '仙居县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3305', '391', '鹿城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3306', '391', '龙湾区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3307', '391', '瓯海区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3308', '391', '瑞安市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3309', '391', '乐清市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3310', '391', '洞头县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3311', '391', '永嘉县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3312', '391', '平阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3313', '391', '苍南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3314', '391', '文成县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3315', '391', '泰顺县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3316', '392', '定海区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3317', '392', '普陀区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3318', '392', '岱山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3319', '392', '嵊泗县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3320', '393', '衢州市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3321', '393', '江山市', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3322', '393', '常山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3323', '393', '开化县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3324', '393', '龙游县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3325', '394', '合川区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3326', '394', '江津区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3327', '394', '南川区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3328', '394', '永川区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3329', '394', '南岸区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3330', '394', '渝北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3331', '394', '万盛区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3332', '394', '大渡口区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3333', '394', '万州区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3334', '394', '北碚区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3335', '394', '沙坪坝区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3336', '394', '巴南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3337', '394', '涪陵区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3338', '394', '江北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3339', '394', '九龙坡区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3340', '394', '渝中区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3341', '394', '黔江开发区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3342', '394', '长寿区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3343', '394', '双桥区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3344', '394', '綦江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3345', '394', '潼南县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3346', '394', '铜梁县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3347', '394', '大足县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3348', '394', '荣昌县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3349', '394', '璧山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3350', '394', '垫江县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3351', '394', '武隆县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3352', '394', '丰都县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3353', '394', '城口县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3354', '394', '梁平县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3355', '394', '开县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3356', '394', '巫溪县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3357', '394', '巫山县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3358', '394', '奉节县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3359', '394', '云阳县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3360', '394', '忠县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3361', '394', '石柱', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3362', '394', '彭水', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3363', '394', '酉阳', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3364', '394', '秀山', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3365', '395', '沙田区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3366', '395', '东区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3367', '395', '观塘区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3368', '395', '黄大仙区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3369', '395', '九龙城区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3370', '395', '屯门区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3371', '395', '葵青区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3372', '395', '元朗区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3373', '395', '深水埗区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3374', '395', '西贡区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3375', '395', '大埔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3376', '395', '湾仔区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3377', '395', '油尖旺区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3378', '395', '北区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3379', '395', '南区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3380', '395', '荃湾区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3381', '395', '中西区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3382', '395', '离岛区', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3383', '396', '澳门', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3384', '397', '台北', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3385', '397', '高雄', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3386', '397', '基隆', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3387', '397', '台中', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3388', '397', '台南', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3389', '397', '新竹', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3390', '397', '嘉义', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3391', '397', '宜兰县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3392', '397', '桃园县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3393', '397', '苗栗县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3394', '397', '彰化县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3395', '397', '南投县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3396', '397', '云林县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3397', '397', '屏东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3398', '397', '台东县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3399', '397', '花莲县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3400', '397', '澎湖县', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('1', '0', '中国', '1');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3401', '3', '合肥', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3402', '3401', '瑶海', '3');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3403', '3401', '庐阳', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3404', '3401', '蜀山', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3405', '3401', '包河', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3406', '3401', '长丰', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3407', '3401', '肥东', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3408', '3401', '肥西', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3409', '3401', '巢湖', '4');
INSERT INTO `%DB_PREFIX%delivery_region` VALUES ('3410', '3401', '庐江', '4');

-- ----------------------------
-- Table structure for %DB_PREFIX%duobao
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%duobao`;
CREATE TABLE `%DB_PREFIX%duobao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL COMMENT '商品ID',
  `name` varchar(255) NOT NULL COMMENT '品名',
  `cate_id` int(11) NOT NULL COMMENT '分类ID',
  `description` text NOT NULL,
  `is_effect` tinyint(1) NOT NULL COMMENT '状态为1是将会自动开启新的活动，设为1先检查是否有正在进行的夺宝活动，如无则自动开启新的一期',
  `brief` text NOT NULL,
  `icon` varchar(255) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `deal_gallery` text NOT NULL COMMENT '图集',
  `duobao_score` int(11) NOT NULL COMMENT '夺宝返还积分',
  `invite_score` int(11) NOT NULL COMMENT '推荐人积分',
  `max_buy` int(11) NOT NULL COMMENT '总需人次',
  `min_buy` int(11) NOT NULL COMMENT '最小投单量',
  `max_schedule` int(11) NOT NULL COMMENT '最大举办期数，0表示无限期',
  `current_schedule` int(11) NOT NULL COMMENT '已开期数',
  `fair_type` varchar(255) NOT NULL DEFAULT 'wy' COMMENT '公证采集源，用于计算开奖规则的接口',
  `robot_end_time` int(11) NOT NULL COMMENT '机器人运行时长(xx分)',
  `robot_is_db` tinyint(1) NOT NULL COMMENT '机器人是否必须在结束时间前完成进度',
  `robot_is_lottery` tinyint(1) NOT NULL COMMENT '自动开奖时是否必需机器人中奖(fair_type为yydb，且机器人开启时有效)',
  `robot_buy_min_time` int(11) NOT NULL COMMENT '机器人下单的最小时间间隔',
  `robot_buy_max_time` int(11) NOT NULL COMMENT '机器人下单的最大时间间隔(秒)',
  `robot_buy_min` int(11) NOT NULL COMMENT '机器人最小投单量',
  `robot_buy_max` int(11) NOT NULL COMMENT '机器人最大投单量',
  `is_recomend` tinyint(1) NOT NULL COMMENT '是否为推荐产品',
  `robot_type` tinyint(1) NOT NULL COMMENT '机器人夺宝方式（0: 按截止时间夺宝 1:按指定频率夺宝）',
  `origin_price` decimal(20,4) NOT NULL DEFAULT '0.0000' COMMENT '商品原有价格',
  `unit_price` int(11) NOT NULL DEFAULT '1' COMMENT '每个人次的单价（主要用于百元专区）',
  `user_max_buy` int(11) NOT NULL COMMENT '每个号的限购单数(0表示不限购)',
  `is_total_buy` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1可以直接购买',
  `total_buy_price` decimal(20,4) NOT NULL DEFAULT '0.0000' COMMENT '全价购买的价格',
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `cate_id` (`cate_id`),
  KEY `is_effect` (`is_effect`),
  KEY `brand_id` (`brand_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='夺宝活动计划表';

-- ----------------------------
-- Table structure for %DB_PREFIX%duobao_item
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%duobao_item`;
CREATE TABLE `%DB_PREFIX%duobao_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '期号即主键',
  `deal_id` int(11) NOT NULL COMMENT '商品ID',
  `duobao_id` int(11) NOT NULL COMMENT '夺宝计划ID',
  `name` varchar(255) NOT NULL COMMENT '品名',
  `cate_id` int(11) NOT NULL COMMENT '分类ID',
  `description` text NOT NULL,
  `is_effect` tinyint(1) NOT NULL COMMENT '是否人工关闭该项夺宝，关闭时有选项是否退回已夺宝的金额',
  `brief` text NOT NULL,
  `icon` varchar(255) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `deal_gallery` text NOT NULL COMMENT '图集',
  `create_time` int(11) NOT NULL COMMENT '开期时间',
  `duobao_score` int(11) NOT NULL,
  `invite_score` int(11) NOT NULL,
  `max_buy` int(11) NOT NULL COMMENT '总需人次',
  `min_buy` int(11) NOT NULL COMMENT '最小投单量',
  `fair_type` varchar(255) NOT NULL DEFAULT 'wy' COMMENT '公证采集源，用于计算开奖规则的接口',
  `robot_end_time` int(11) NOT NULL COMMENT '机器人运行时长(xx分)',
  `robot_is_db` tinyint(1) NOT NULL COMMENT '机器人是否必须在结束时间前完成进度',
  `current_buy` int(11) NOT NULL COMMENT '已购买的人次',
  `progress` int(11) NOT NULL COMMENT '进度0-100',
  `lottery_sn` int(11) NOT NULL COMMENT '中奖号码',
  `has_lottery` tinyint(1) NOT NULL COMMENT '开奖状态 0未开奖  1已开奖',
  `success_time` int(11) NOT NULL COMMENT '成功时间',
  `lottery_time` int(11) NOT NULL COMMENT '开奖时间 0为未生成开奖时间',
  `fair_sn` int(11) NOT NULL COMMENT '公证号',
  `fair_sn_local` varchar(100) NOT NULL COMMENT '进度完成时间点前最后50条全站参与记录，时+分+秒字符串拼单后的累加总合',
  `fair_period` varchar(12) NOT NULL COMMENT '对应的开奖期号',
  `luck_user_id` int(11) NOT NULL COMMENT '中奖人ID',
  `click_count` int(11) NOT NULL COMMENT '点击量',
  `robot_buy_count` int(11) NOT NULL COMMENT '机器人购买数量',
  `luck_user_name` varchar(255) NOT NULL COMMENT '中奖用户名',
  `log_moved` tinyint(1) NOT NULL COMMENT '是否已经迁移过夺宝开奖池数据，0未移，1已移',
  `luck_user_buy_count` int(11) DEFAULT '0' COMMENT '中奖人购买的次数',
  `duobao_ip` varchar(255) DEFAULT NULL COMMENT '夺宝Ip',
  `duobao_area` varchar(255) DEFAULT NULL COMMENT '夺宝地区',
  `share_id` int(11) DEFAULT '0' COMMENT '晒单id',
  `is_send_share` tinyint(1) DEFAULT '0' COMMENT '晒单是否发布，只有点击发布才会更新字段',
  `unit_price` int(11) NOT NULL DEFAULT '1' COMMENT '每个人次的单价（主要用于百元专区）',
  `user_max_buy` int(11) NOT NULL COMMENT '每个号的限购单数(0表示不限购)',
  `origin_price` decimal(20,4) DEFAULT '0.0000' COMMENT '商品原有价格',
  `success_time_50` decimal(20,4) DEFAULT '0.0000' COMMENT '50条记录的最后一个下单时间毫秒值',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序。按数字从大到小排序',
  `is_total_buy` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1可以直接购买',
  `total_buy_price` decimal(20,4) NOT NULL DEFAULT '0.0000' COMMENT '全价购买的价格',
  `is_robot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为机器人帐号',
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `cate_id` (`cate_id`),
  KEY `is_effect` (`is_effect`),
  KEY `brand_id` (`brand_id`),
  KEY `max_buy` (`max_buy`),
  KEY `progress` (`progress`),
  KEY `lottery_time` (`lottery_time`),
  KEY `db_id` (`duobao_id`)
) ENGINE=MyISAM AUTO_INCREMENT=100000000 DEFAULT CHARSET=utf8 COMMENT='夺宝活动每期';

-- ----------------------------
-- Table structure for %DB_PREFIX%duobao_item_log
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%duobao_item_log`;
CREATE TABLE `%DB_PREFIX%duobao_item_log` (
  `id` int(11) NOT NULL,
  `deal_id` int(11) NOT NULL,
  `duobao_id` int(11) NOT NULL,
  `duobao_item_id` int(11) NOT NULL COMMENT '夺宝期号',
  `lottery_sn` int(11) NOT NULL DEFAULT '0' COMMENT '幸运号',
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `order_item_id` int(11) NOT NULL COMMENT '订单商品ID',
  `create_time` decimal(20,3) NOT NULL COMMENT '生成时间,即最后订单支付完成的时间',
  `is_luck` tinyint(1) NOT NULL COMMENT '是否中奖',
  `duobao_ip` varchar(255) NOT NULL COMMENT 'IP',
  `duobao_area` varchar(255) NOT NULL COMMENT '夺宝归属地',
  `is_robot` tinyint(1) NOT NULL COMMENT '是不是机器人',
  PRIMARY KEY (`duobao_item_id`,`lottery_sn`),
  UNIQUE KEY `unk` (`duobao_item_id`,`lottery_sn`),
  KEY `deal_id` (`deal_id`),
  KEY `user_id` (`user_id`),
  KEY `is_luck` (`is_luck`),
  KEY `duobao_id` (`duobao_id`),
  KEY `duobao_item_id` (`duobao_item_id`),
  KEY `user_id_duobao_item_id` (`duobao_item_id`,`user_id`),
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for %DB_PREFIX%duobao_item_log_history
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%duobao_item_log_history`;
CREATE TABLE `%DB_PREFIX%duobao_item_log_history` (
  `id` int(11) NOT NULL,
  `deal_id` int(11) NOT NULL,
  `duobao_id` int(11) NOT NULL,
  `duobao_item_id` int(11) NOT NULL COMMENT '夺宝期号',
  `lottery_sn` int(11) NOT NULL DEFAULT '0' COMMENT '幸运号',
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `order_item_id` int(11) NOT NULL COMMENT '订单商品ID',
  `create_time` decimal(20,3) NOT NULL COMMENT '生成时间,即最后订单支付完成的时间',
  `is_luck` tinyint(1) NOT NULL COMMENT '是否中奖',
  `duobao_ip` varchar(255) NOT NULL COMMENT 'IP',
  `duobao_area` varchar(255) NOT NULL COMMENT '夺宝归属地',
  `is_robot` tinyint(1) NOT NULL COMMENT '是不是机器人',
  `create_date_ymd` varchar(15) NOT NULL COMMENT '时间表示为开奖的时间',
  `create_date_ym` varchar(15) NOT NULL,
  `create_date_y` int(4) NOT NULL,
  `create_date_m` int(2) NOT NULL,
  `create_date_d` int(2) NOT NULL,
  PRIMARY KEY (`duobao_item_id`,`lottery_sn`),
  UNIQUE KEY `unk` (`duobao_item_id`,`lottery_sn`),
  KEY `deal_id` (`deal_id`),
  KEY `user_id` (`user_id`),
  KEY `is_luck` (`is_luck`),
  KEY `duobao_id` (`duobao_id`),
  KEY `duobao_item_id` (`duobao_item_id`),
  KEY `user_id_duobao_item_id` (`duobao_item_id`,`user_id`),
  KEY `id` (`id`),
  KEY `create_date_ymd` (`create_date_ymd`),
  KEY `create_date_ym` (`create_date_ym`),
  KEY `create_date_y` (`create_date_y`),
  KEY `create_date_m` (`create_date_m`),
  KEY `create_date_d` (`create_date_d`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for %DB_PREFIX%ecv
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%ecv`;
CREATE TABLE `%DB_PREFIX%ecv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(255) NOT NULL COMMENT '序列号',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `use_limit` int(11) NOT NULL COMMENT '代金券的使用次数,0表示无限次数使用',
  `use_count` int(11) NOT NULL COMMENT '已用次数',
  `user_id` int(11) NOT NULL COMMENT '会员ID ',
  `begin_time` int(11) NOT NULL COMMENT '有效期开始时间',
  `end_time` int(11) NOT NULL COMMENT '有效期结束时间',
  `money` decimal(20,4) NOT NULL COMMENT '代金券面额',
  `ecv_type_id` int(11) NOT NULL COMMENT '代金额类型ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unk_sn` (`sn`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='代金券表';

-- ----------------------------
-- Table structure for %DB_PREFIX%ecv_type
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%ecv_type`;
CREATE TABLE `%DB_PREFIX%ecv_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '代金券类型名称',
  `money` decimal(20,4) NOT NULL COMMENT '面额',
  `use_limit` int(11) NOT NULL COMMENT '可用次数, 0表示无限次数',
  `begin_time` int(11) NOT NULL COMMENT '有效期开始时间',
  `end_time` int(11) NOT NULL COMMENT '有效期结束时间',
  `gen_count` int(11) NOT NULL COMMENT '已发放的数量',
  `send_type` tinyint(1) NOT NULL COMMENT '发放方式 0:管理员手动发放 1:会员积分兑换 2:序列号兑换',
  `exchange_score` int(11) NOT NULL COMMENT '兑换所需的积分',
  `exchange_limit` int(11) NOT NULL COMMENT '每个会员限兑换的数量',
  `exchange_sn` varchar(20) DEFAULT NULL COMMENT '红包兑换的序列号',
  `share_url` varchar(255) NOT NULL COMMENT '分享连接',
  `memo` varchar(255) NOT NULL COMMENT '红包备注',
  `tpl` varchar(255) NOT NULL COMMENT '红包模版',
  `total_limit` int(11) NOT NULL COMMENT '发放总量限制',
  PRIMARY KEY (`id`),
  UNIQUE KEY `exchange_sn` (`exchange_sn`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='代金券类型表';

-- ----------------------------
-- Table structure for %DB_PREFIX%expression
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%expression`;
CREATE TABLE `%DB_PREFIX%expression` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'tusiji',
  `emotion` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='表情配置表';

-- ----------------------------
-- Records of %DB_PREFIX%expression
-- ----------------------------
INSERT INTO `%DB_PREFIX%expression` VALUES ('19', '傲慢', 'qq', '[傲慢]', 'aoman.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('20', '白眼', 'qq', '[白眼]', 'baiyan.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('21', '鄙视', 'qq', '[鄙视]', 'bishi.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('22', '闭嘴', 'qq', '[闭嘴]', 'bizui.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('23', '擦汗', 'qq', '[擦汗]', 'cahan.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('24', '菜刀', 'qq', '[菜刀]', 'caidao.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('25', '差劲', 'qq', '[差劲]', 'chajin.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('26', '欢庆', 'qq', '[欢庆]', 'cheer.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('27', '虫子', 'qq', '[虫子]', 'chong.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('28', '呲牙', 'qq', '[呲牙]', 'ciya.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('29', '捶打', 'qq', '[捶打]', 'da.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('30', '大便', 'qq', '[大便]', 'dabian.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('31', '大兵', 'qq', '[大兵]', 'dabing.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('32', '大叫', 'qq', '[大叫]', 'dajiao.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('33', '大哭', 'qq', '[大哭]', 'daku.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('34', '蛋糕', 'qq', '[蛋糕]', 'dangao.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('35', '发怒', 'qq', '[发怒]', 'fanu.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('36', '刀', 'qq', '[刀]', 'dao.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('37', '得意', 'qq', '[得意]', 'deyi.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('38', '凋谢', 'qq', '[凋谢]', 'diaoxie.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('39', '饿', 'qq', '[饿]', 'er.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('40', '发呆', 'qq', '[发呆]', 'fadai.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('41', '发抖', 'qq', '[发抖]', 'fadou.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('42', '饭', 'qq', '[饭]', 'fan.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('43', '飞吻', 'qq', '[飞吻]', 'feiwen.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('44', '奋斗', 'qq', '[奋斗]', 'fendou.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('45', '尴尬', 'qq', '[尴尬]', 'gangga.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('46', '给力', 'qq', '[给力]', 'geili.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('47', '勾引', 'qq', '[勾引]', 'gouyin.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('48', '鼓掌', 'qq', '[鼓掌]', 'guzhang.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('49', '哈哈', 'qq', '[哈哈]', 'haha.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('50', '害羞', 'qq', '[害羞]', 'haixiu.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('51', '哈欠', 'qq', '[哈欠]', 'haqian.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('52', '花', 'qq', '[花]', 'hua.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('53', '坏笑', 'qq', '[坏笑]', 'huaixiao.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('54', '挥手', 'qq', '[挥手]', 'huishou.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('55', '回头', 'qq', '[回头]', 'huitou.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('56', '激动', 'qq', '[激动]', 'jidong.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('57', '惊恐', 'qq', '[惊恐]', 'jingkong.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('58', '惊讶', 'qq', '[惊讶]', 'jingya.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('59', '咖啡', 'qq', '[咖啡]', 'kafei.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('60', '可爱', 'qq', '[可爱]', 'keai.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('61', '可怜', 'qq', '[可怜]', 'kelian.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('62', '磕头', 'qq', '[磕头]', 'ketou.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('63', '示爱', 'qq', '[示爱]', 'kiss.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('64', '酷', 'qq', '[酷]', 'ku.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('65', '难过', 'qq', '[难过]', 'kuaikule.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('66', '骷髅', 'qq', '[骷髅]', 'kulou.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('67', '困', 'qq', '[困]', 'kun.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('68', '篮球', 'qq', '[篮球]', 'lanqiu.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('69', '冷汗', 'qq', '[冷汗]', 'lenghan.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('70', '流汗', 'qq', '[流汗]', 'liuhan.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('71', '流泪', 'qq', '[流泪]', 'liulei.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('72', '礼物', 'qq', '[礼物]', 'liwu.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('73', '爱心', 'qq', '[爱心]', 'love.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('74', '骂人', 'qq', '[骂人]', 'ma.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('75', '不开心', 'qq', '[不开心]', 'nanguo.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('76', '不好', 'qq', '[不好]', 'no.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('77', '很好', 'qq', '[很好]', 'ok.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('78', '佩服', 'qq', '[佩服]', 'peifu.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('79', '啤酒', 'qq', '[啤酒]', 'pijiu.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('80', '乒乓', 'qq', '[乒乓]', 'pingpang.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('81', '撇嘴', 'qq', '[撇嘴]', 'pizui.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('82', '强', 'qq', '[强]', 'qiang.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('83', '亲亲', 'qq', '[亲亲]', 'qinqin.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('84', '出丑', 'qq', '[出丑]', 'qioudale.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('85', '足球', 'qq', '[足球]', 'qiu.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('86', '拳头', 'qq', '[拳头]', 'quantou.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('87', '弱', 'qq', '[弱]', 'ruo.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('88', '色', 'qq', '[色]', 'se.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('89', '闪电', 'qq', '[闪电]', 'shandian.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('90', '胜利', 'qq', '[胜利]', 'shengli.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('91', '衰', 'qq', '[衰]', 'shuai.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('92', '睡觉', 'qq', '[睡觉]', 'shuijiao.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('93', '太阳', 'qq', '[太阳]', 'taiyang.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('96', '啊', 'tusiji', '[啊]', 'aa.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('97', '暗爽', 'tusiji', '[暗爽]', 'anshuang.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('98', 'byebye', 'tusiji', '[byebye]', 'baibai.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('99', '不行', 'tusiji', '[不行]', 'buxing.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('100', '戳眼', 'tusiji', '[戳眼]', 'chuoyan.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('101', '很得意', 'tusiji', '[很得意]', 'deyi.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('102', '顶', 'tusiji', '[顶]', 'ding.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('103', '抖抖', 'tusiji', '[抖抖]', 'douxiong.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('104', '哼', 'tusiji', '[哼]', 'heng.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('105', '挥汗', 'tusiji', '[挥汗]', 'huihan.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('106', '昏迷', 'tusiji', '[昏迷]', 'hunmi.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('107', '互拍', 'tusiji', '[互拍]', 'hupai.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('108', '瞌睡', 'tusiji', '[瞌睡]', 'keshui.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('109', '笼子', 'tusiji', '[笼子]', 'longzi.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('110', '听歌', 'tusiji', '[听歌]', 'music.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('111', '奶瓶', 'tusiji', '[奶瓶]', 'naiping.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('112', '扭背', 'tusiji', '[扭背]', 'niubei.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('113', '拍砖', 'tusiji', '[拍砖]', 'paizhuan.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('114', '飘过', 'tusiji', '[飘过]', 'piaoguo.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('115', '揉脸', 'tusiji', '[揉脸]', 'roulian.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('116', '闪闪', 'tusiji', '[闪闪]', 'shanshan.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('117', '生日', 'tusiji', '[生日]', 'shengri.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('118', '摊手', 'tusiji', '[摊手]', 'tanshou.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('119', '躺坐', 'tusiji', '[躺坐]', 'tanzuo.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('120', '歪头', 'tusiji', '[歪头]', 'waitou.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('121', '我踢', 'tusiji', '[我踢]', 'woti.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('122', '无聊', 'tusiji', '[无聊]', 'wuliao.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('123', '醒醒', 'tusiji', '[醒醒]', 'xingxing.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('124', '睡了', 'tusiji', '[睡了]', 'xixishui.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('125', '旋转', 'tusiji', '[旋转]', 'xuanzhuan.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('126', '摇晃', 'tusiji', '[摇晃]', 'yaohuang.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('127', '耶', 'tusiji', '[耶]', 'yeah.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('128', '郁闷', 'tusiji', '[郁闷]', 'yumen.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('129', '晕厥', 'tusiji', '[晕厥]', 'yunjue.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('130', '砸', 'tusiji', '[砸]', 'za.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('131', '震荡', 'tusiji', '[震荡]', 'zhendang.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('132', '撞墙', 'tusiji', '[撞墙]', 'zhuangqiang.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('133', '转头', 'tusiji', '[转头]', 'zhuantou.gif');
INSERT INTO `%DB_PREFIX%expression` VALUES ('134', '抓墙', 'tusiji', '[抓墙]', 'zhuaqiang.gif');

-- ----------------------------
-- Table structure for `%DB_PREFIX%fair_fetch`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%fair_fetch`;
CREATE TABLE `%DB_PREFIX%fair_fetch` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `fair_type` varchar(20) NOT NULL,
  `drawdate` varchar(8) NOT NULL COMMENT '开奖日期（格式：yyyyMMdd）',
  `period` varchar(12) NOT NULL COMMENT '期号',
  `drawtime` datetime NOT NULL COMMENT '开奖时间(精确到秒）',
  `number` varchar(12) DEFAULT NULL COMMENT '中奖号码',
  `addtime` int(11) NOT NULL COMMENT '记录添加时间',
  `updatetime` int(11) DEFAULT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_date_period` (`drawdate`,`period`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of %DB_PREFIX%fair_fetch
-- ----------------------------
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('1', 'wy', '20160523', '160523001', '2016-05-23 00:05:00', '16611', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('2', 'wy', '20160523', '160523002', '2016-05-23 00:10:00', '11328', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('3', 'wy', '20160523', '160523003', '2016-05-23 00:15:00', '62792', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('4', 'wy', '20160523', '160523004', '2016-05-23 00:20:00', '20922', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('5', 'wy', '20160523', '160523005', '2016-05-23 00:25:00', '12448', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('6', 'wy', '20160523', '160523006', '2016-05-23 00:30:00', '42125', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('7', 'wy', '20160523', '160523007', '2016-05-23 00:35:00', '90134', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('8', 'wy', '20160523', '160523008', '2016-05-23 00:40:00', '10370', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('9', 'wy', '20160523', '160523009', '2016-05-23 00:45:00', '16851', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('10', 'wy', '20160523', '160523010', '2016-05-23 00:50:00', '01250', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('11', 'wy', '20160523', '160523011', '2016-05-23 00:55:00', '09161', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('12', 'wy', '20160523', '160523012', '2016-05-23 01:00:00', '07130', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('13', 'wy', '20160523', '160523013', '2016-05-23 01:05:00', '83579', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('14', 'wy', '20160523', '160523014', '2016-05-23 01:10:00', '63034', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('15', 'wy', '20160523', '160523015', '2016-05-23 01:15:00', '06477', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('16', 'wy', '20160523', '160523016', '2016-05-23 01:20:00', '89362', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('17', 'wy', '20160523', '160523017', '2016-05-23 01:25:00', '25094', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('18', 'wy', '20160523', '160523018', '2016-05-23 01:30:00', '66395', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('19', 'wy', '20160523', '160523019', '2016-05-23 01:35:00', '66971', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('20', 'wy', '20160523', '160523020', '2016-05-23 01:40:00', '18348', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('21', 'wy', '20160523', '160523021', '2016-05-23 01:45:00', '55532', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('22', 'wy', '20160523', '160523022', '2016-05-23 01:50:00', '26746', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('23', 'wy', '20160523', '160523023', '2016-05-23 01:55:00', '10786', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('24', 'wy', '20160523', '160523024', '2016-05-23 10:00:00', '85089', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('25', 'wy', '20160523', '160523025', '2016-05-23 10:10:00', '08330', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('26', 'wy', '20160523', '160523026', '2016-05-23 10:20:00', '80719', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('27', 'wy', '20160523', '160523027', '2016-05-23 10:30:00', '89417', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('28', 'wy', '20160523', '160523028', '2016-05-23 10:40:00', '37794', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('29', 'wy', '20160523', '160523029', '2016-05-23 10:50:00', '66492', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('30', 'wy', '20160523', '160523030', '2016-05-23 11:00:00', '76525', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('31', 'wy', '20160523', '160523031', '2016-05-23 11:10:00', '85018', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('32', 'wy', '20160523', '160523032', '2016-05-23 11:20:00', '05400', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('33', 'wy', '20160523', '160523033', '2016-05-23 11:30:00', '87003', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('34', 'wy', '20160523', '160523034', '2016-05-23 11:40:00', '17377', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('35', 'wy', '20160523', '160523035', '2016-05-23 11:50:00', '05127', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('36', 'wy', '20160523', '160523036', '2016-05-23 12:00:00', '54065', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('37', 'wy', '20160523', '160523037', '2016-05-23 12:10:00', '32170', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('38', 'wy', '20160523', '160523038', '2016-05-23 12:20:00', '43922', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('39', 'wy', '20160523', '160523039', '2016-05-23 12:30:00', '68441', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('40', 'wy', '20160523', '160523040', '2016-05-23 12:40:00', '56659', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('41', 'wy', '20160523', '160523041', '2016-05-23 12:50:00', '91762', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('42', 'wy', '20160523', '160523042', '2016-05-23 13:00:00', '21773', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('43', 'wy', '20160523', '160523043', '2016-05-23 13:10:00', '32672', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('44', 'wy', '20160523', '160523044', '2016-05-23 13:20:00', '18875', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('45', 'wy', '20160523', '160523045', '2016-05-23 13:30:00', '88448', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('46', 'wy', '20160523', '160523046', '2016-05-23 13:40:00', '14949', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('47', 'wy', '20160523', '160523047', '2016-05-23 13:50:00', '62801', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('48', 'wy', '20160523', '160523048', '2016-05-23 14:00:00', '11423', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('49', 'wy', '20160523', '160523049', '2016-05-23 14:10:00', '71405', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('50', 'wy', '20160523', '160523050', '2016-05-23 14:20:00', '58573', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('51', 'wy', '20160523', '160523051', '2016-05-23 14:30:00', '65423', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('52', 'wy', '20160523', '160523052', '2016-05-23 14:40:00', '01939', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('53', 'wy', '20160523', '160523053', '2016-05-23 14:50:00', '76666', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('54', 'wy', '20160523', '160523054', '2016-05-23 15:00:00', '90141', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('55', 'wy', '20160523', '160523055', '2016-05-23 15:10:00', '77416', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('56', 'wy', '20160523', '160523056', '2016-05-23 15:20:00', '27400', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('57', 'wy', '20160523', '160523057', '2016-05-23 15:30:00', '44901', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('58', 'wy', '20160523', '160523058', '2016-05-23 15:40:00', '05914', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('59', 'wy', '20160523', '160523059', '2016-05-23 15:50:00', '16230', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('60', 'wy', '20160523', '160523060', '2016-05-23 16:00:00', '52201', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('61', 'wy', '20160523', '160523061', '2016-05-23 16:10:00', '29254', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('62', 'wy', '20160523', '160523062', '2016-05-23 16:20:00', '20864', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('63', 'wy', '20160523', '160523063', '2016-05-23 16:30:00', '70188', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('64', 'wy', '20160523', '160523064', '2016-05-23 16:40:00', '97657', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('65', 'wy', '20160523', '160523065', '2016-05-23 16:50:00', '07766', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('66', 'wy', '20160523', '160523066', '2016-05-23 17:00:00', '93410', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('67', 'wy', '20160523', '160523067', '2016-05-23 17:10:00', '14353', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('68', 'wy', '20160523', '160523068', '2016-05-23 17:20:00', '77921', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('69', 'wy', '20160523', '160523069', '2016-05-23 17:30:00', '24756', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('70', 'wy', '20160523', '160523070', '2016-05-23 17:40:00', '17571', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('71', 'wy', '20160523', '160523071', '2016-05-23 17:50:00', '31280', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('72', 'wy', '20160523', '160523072', '2016-05-23 18:00:00', '30730', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('73', 'wy', '20160523', '160523073', '2016-05-23 18:10:00', '37244', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('74', 'wy', '20160523', '160523074', '2016-05-23 18:20:00', '81759', '1463970431', '1463970431');
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('75', 'wy', '20160523', '160523075', '2016-05-23 18:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('76', 'wy', '20160523', '160523076', '2016-05-23 18:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('77', 'wy', '20160523', '160523077', '2016-05-23 18:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('78', 'wy', '20160523', '160523078', '2016-05-23 19:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('79', 'wy', '20160523', '160523079', '2016-05-23 19:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('80', 'wy', '20160523', '160523080', '2016-05-23 19:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('81', 'wy', '20160523', '160523081', '2016-05-23 19:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('82', 'wy', '20160523', '160523082', '2016-05-23 19:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('83', 'wy', '20160523', '160523083', '2016-05-23 19:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('84', 'wy', '20160523', '160523084', '2016-05-23 20:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('85', 'wy', '20160523', '160523085', '2016-05-23 20:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('86', 'wy', '20160523', '160523086', '2016-05-23 20:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('87', 'wy', '20160523', '160523087', '2016-05-23 20:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('88', 'wy', '20160523', '160523088', '2016-05-23 20:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('89', 'wy', '20160523', '160523089', '2016-05-23 20:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('90', 'wy', '20160523', '160523090', '2016-05-23 21:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('91', 'wy', '20160523', '160523091', '2016-05-23 21:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('92', 'wy', '20160523', '160523092', '2016-05-23 21:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('93', 'wy', '20160523', '160523093', '2016-05-23 21:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('94', 'wy', '20160523', '160523094', '2016-05-23 21:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('95', 'wy', '20160523', '160523095', '2016-05-23 21:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('96', 'wy', '20160523', '160523096', '2016-05-23 22:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('97', 'wy', '20160523', '160523097', '2016-05-23 22:05:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('98', 'wy', '20160523', '160523098', '2016-05-23 22:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('99', 'wy', '20160523', '160523099', '2016-05-23 22:15:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('100', 'wy', '20160523', '160523100', '2016-05-23 22:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('101', 'wy', '20160523', '160523101', '2016-05-23 22:25:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('102', 'wy', '20160523', '160523102', '2016-05-23 22:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('103', 'wy', '20160523', '160523103', '2016-05-23 22:35:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('104', 'wy', '20160523', '160523104', '2016-05-23 22:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('105', 'wy', '20160523', '160523105', '2016-05-23 22:45:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('106', 'wy', '20160523', '160523106', '2016-05-23 22:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('107', 'wy', '20160523', '160523107', '2016-05-23 22:55:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('108', 'wy', '20160523', '160523108', '2016-05-23 23:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('109', 'wy', '20160523', '160523109', '2016-05-23 23:05:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('110', 'wy', '20160523', '160523110', '2016-05-23 23:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('111', 'wy', '20160523', '160523111', '2016-05-23 23:15:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('112', 'wy', '20160523', '160523112', '2016-05-23 23:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('113', 'wy', '20160523', '160523113', '2016-05-23 23:25:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('114', 'wy', '20160523', '160523114', '2016-05-23 23:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('115', 'wy', '20160523', '160523115', '2016-05-23 23:35:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('116', 'wy', '20160523', '160523116', '2016-05-23 23:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('117', 'wy', '20160523', '160523117', '2016-05-23 23:45:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('118', 'wy', '20160523', '160523118', '2016-05-23 23:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('119', 'wy', '20160523', '160523119', '2016-05-23 23:55:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('120', 'wy', '20160523', '160523120', '2016-05-24 00:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('121', 'wy', '20160524', '160524001', '2016-05-24 00:05:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('122', 'wy', '20160524', '160524002', '2016-05-24 00:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('123', 'wy', '20160524', '160524003', '2016-05-24 00:15:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('124', 'wy', '20160524', '160524004', '2016-05-24 00:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('125', 'wy', '20160524', '160524005', '2016-05-24 00:25:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('126', 'wy', '20160524', '160524006', '2016-05-24 00:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('127', 'wy', '20160524', '160524007', '2016-05-24 00:35:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('128', 'wy', '20160524', '160524008', '2016-05-24 00:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('129', 'wy', '20160524', '160524009', '2016-05-24 00:45:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('130', 'wy', '20160524', '160524010', '2016-05-24 00:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('131', 'wy', '20160524', '160524011', '2016-05-24 00:55:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('132', 'wy', '20160524', '160524012', '2016-05-24 01:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('133', 'wy', '20160524', '160524013', '2016-05-24 01:05:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('134', 'wy', '20160524', '160524014', '2016-05-24 01:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('135', 'wy', '20160524', '160524015', '2016-05-24 01:15:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('136', 'wy', '20160524', '160524016', '2016-05-24 01:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('137', 'wy', '20160524', '160524017', '2016-05-24 01:25:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('138', 'wy', '20160524', '160524018', '2016-05-24 01:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('139', 'wy', '20160524', '160524019', '2016-05-24 01:35:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('140', 'wy', '20160524', '160524020', '2016-05-24 01:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('141', 'wy', '20160524', '160524021', '2016-05-24 01:45:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('142', 'wy', '20160524', '160524022', '2016-05-24 01:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('143', 'wy', '20160524', '160524023', '2016-05-24 01:55:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('144', 'wy', '20160524', '160524024', '2016-05-24 10:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('145', 'wy', '20160524', '160524025', '2016-05-24 10:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('146', 'wy', '20160524', '160524026', '2016-05-24 10:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('147', 'wy', '20160524', '160524027', '2016-05-24 10:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('148', 'wy', '20160524', '160524028', '2016-05-24 10:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('149', 'wy', '20160524', '160524029', '2016-05-24 10:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('150', 'wy', '20160524', '160524030', '2016-05-24 11:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('151', 'wy', '20160524', '160524031', '2016-05-24 11:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('152', 'wy', '20160524', '160524032', '2016-05-24 11:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('153', 'wy', '20160524', '160524033', '2016-05-24 11:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('154', 'wy', '20160524', '160524034', '2016-05-24 11:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('155', 'wy', '20160524', '160524035', '2016-05-24 11:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('156', 'wy', '20160524', '160524036', '2016-05-24 12:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('157', 'wy', '20160524', '160524037', '2016-05-24 12:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('158', 'wy', '20160524', '160524038', '2016-05-24 12:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('159', 'wy', '20160524', '160524039', '2016-05-24 12:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('160', 'wy', '20160524', '160524040', '2016-05-24 12:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('161', 'wy', '20160524', '160524041', '2016-05-24 12:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('162', 'wy', '20160524', '160524042', '2016-05-24 13:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('163', 'wy', '20160524', '160524043', '2016-05-24 13:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('164', 'wy', '20160524', '160524044', '2016-05-24 13:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('165', 'wy', '20160524', '160524045', '2016-05-24 13:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('166', 'wy', '20160524', '160524046', '2016-05-24 13:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('167', 'wy', '20160524', '160524047', '2016-05-24 13:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('168', 'wy', '20160524', '160524048', '2016-05-24 14:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('169', 'wy', '20160524', '160524049', '2016-05-24 14:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('170', 'wy', '20160524', '160524050', '2016-05-24 14:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('171', 'wy', '20160524', '160524051', '2016-05-24 14:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('172', 'wy', '20160524', '160524052', '2016-05-24 14:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('173', 'wy', '20160524', '160524053', '2016-05-24 14:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('174', 'wy', '20160524', '160524054', '2016-05-24 15:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('175', 'wy', '20160524', '160524055', '2016-05-24 15:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('176', 'wy', '20160524', '160524056', '2016-05-24 15:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('177', 'wy', '20160524', '160524057', '2016-05-24 15:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('178', 'wy', '20160524', '160524058', '2016-05-24 15:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('179', 'wy', '20160524', '160524059', '2016-05-24 15:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('180', 'wy', '20160524', '160524060', '2016-05-24 16:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('181', 'wy', '20160524', '160524061', '2016-05-24 16:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('182', 'wy', '20160524', '160524062', '2016-05-24 16:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('183', 'wy', '20160524', '160524063', '2016-05-24 16:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('184', 'wy', '20160524', '160524064', '2016-05-24 16:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('185', 'wy', '20160524', '160524065', '2016-05-24 16:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('186', 'wy', '20160524', '160524066', '2016-05-24 17:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('187', 'wy', '20160524', '160524067', '2016-05-24 17:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('188', 'wy', '20160524', '160524068', '2016-05-24 17:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('189', 'wy', '20160524', '160524069', '2016-05-24 17:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('190', 'wy', '20160524', '160524070', '2016-05-24 17:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('191', 'wy', '20160524', '160524071', '2016-05-24 17:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('192', 'wy', '20160524', '160524072', '2016-05-24 18:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('193', 'wy', '20160524', '160524073', '2016-05-24 18:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('194', 'wy', '20160524', '160524074', '2016-05-24 18:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('195', 'wy', '20160524', '160524075', '2016-05-24 18:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('196', 'wy', '20160524', '160524076', '2016-05-24 18:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('197', 'wy', '20160524', '160524077', '2016-05-24 18:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('198', 'wy', '20160524', '160524078', '2016-05-24 19:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('199', 'wy', '20160524', '160524079', '2016-05-24 19:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('200', 'wy', '20160524', '160524080', '2016-05-24 19:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('201', 'wy', '20160524', '160524081', '2016-05-24 19:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('202', 'wy', '20160524', '160524082', '2016-05-24 19:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('203', 'wy', '20160524', '160524083', '2016-05-24 19:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('204', 'wy', '20160524', '160524084', '2016-05-24 20:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('205', 'wy', '20160524', '160524085', '2016-05-24 20:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('206', 'wy', '20160524', '160524086', '2016-05-24 20:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('207', 'wy', '20160524', '160524087', '2016-05-24 20:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('208', 'wy', '20160524', '160524088', '2016-05-24 20:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('209', 'wy', '20160524', '160524089', '2016-05-24 20:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('210', 'wy', '20160524', '160524090', '2016-05-24 21:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('211', 'wy', '20160524', '160524091', '2016-05-24 21:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('212', 'wy', '20160524', '160524092', '2016-05-24 21:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('213', 'wy', '20160524', '160524093', '2016-05-24 21:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('214', 'wy', '20160524', '160524094', '2016-05-24 21:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('215', 'wy', '20160524', '160524095', '2016-05-24 21:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('216', 'wy', '20160524', '160524096', '2016-05-24 22:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('217', 'wy', '20160524', '160524097', '2016-05-24 22:05:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('218', 'wy', '20160524', '160524098', '2016-05-24 22:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('219', 'wy', '20160524', '160524099', '2016-05-24 22:15:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('220', 'wy', '20160524', '160524100', '2016-05-24 22:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('221', 'wy', '20160524', '160524101', '2016-05-24 22:25:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('222', 'wy', '20160524', '160524102', '2016-05-24 22:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('223', 'wy', '20160524', '160524103', '2016-05-24 22:35:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('224', 'wy', '20160524', '160524104', '2016-05-24 22:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('225', 'wy', '20160524', '160524105', '2016-05-24 22:45:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('226', 'wy', '20160524', '160524106', '2016-05-24 22:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('227', 'wy', '20160524', '160524107', '2016-05-24 22:55:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('228', 'wy', '20160524', '160524108', '2016-05-24 23:00:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('229', 'wy', '20160524', '160524109', '2016-05-24 23:05:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('230', 'wy', '20160524', '160524110', '2016-05-24 23:10:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('231', 'wy', '20160524', '160524111', '2016-05-24 23:15:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('232', 'wy', '20160524', '160524112', '2016-05-24 23:20:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('233', 'wy', '20160524', '160524113', '2016-05-24 23:25:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('234', 'wy', '20160524', '160524114', '2016-05-24 23:30:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('235', 'wy', '20160524', '160524115', '2016-05-24 23:35:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('236', 'wy', '20160524', '160524116', '2016-05-24 23:40:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('237', 'wy', '20160524', '160524117', '2016-05-24 23:45:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('238', 'wy', '20160524', '160524118', '2016-05-24 23:50:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('239', 'wy', '20160524', '160524119', '2016-05-24 23:55:00', null, '1463970431', null);
INSERT INTO `%DB_PREFIX%fair_fetch` VALUES ('240', 'wy', '20160524', '160524120', '2016-05-25 00:00:00', null, '1463970431', null);


-- ----------------------------
-- Table structure for %DB_PREFIX%form_verify
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%form_verify`;
CREATE TABLE `%DB_PREFIX%form_verify` (
  `session_id` varchar(255) NOT NULL,
  `verify_data` text NOT NULL,
  `update_time` varchar(20) NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `session_id` (`session_id`),
  KEY `update_time` (`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for %DB_PREFIX%fx_salary
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%fx_salary`;
CREATE TABLE `%DB_PREFIX%fx_salary` (
  `level_id` int(11) NOT NULL COMMENT '分销等级的ID(0表示默认等级，即全局配置)',
  `fx_level` int(11) NOT NULL COMMENT '分销返还等级由0开始，0表示为分销店主的分成利润',
  `fx_salary` decimal(20,4) NOT NULL COMMENT '分销当前等级的提成率(以会员标价的单前购买价为提成标准)',
  `fx_salary_type` tinyint(1) NOT NULL COMMENT '佣金类型：0定额 1比率',
  `fx_type_qrcode` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0临时1永久微信渠道二维码',
  `fx_default_status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1为默认开启，0关闭',
  `fx_is_open` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1开启三级分销'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='分销会员等级分销提成配置';

-- ----------------------------
-- Table structure for %DB_PREFIX%fx_user_reward
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%fx_user_reward`;
CREATE TABLE `%DB_PREFIX%fx_user_reward` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '分销商ID',
  `user_id` int(11) NOT NULL COMMENT '每个会员针对每个分销商的返佣情况',
  `cur_user_id` int(10) unsigned NOT NULL COMMENT '当前购买的用户id',
  `money` decimal(20,4) NOT NULL COMMENT '总返佣的钱',
  `order_money` decimal(20,4) NOT NULL COMMENT '分销交易订单金额 ',
  `create_time` int(10) unsigned NOT NULL,
  `order_sn` varchar(255) NOT NULL,
  `fx_level` tinyint(1) unsigned NOT NULL COMMENT '分销等级',
  `fx_salary_type` tinyint(1) unsigned NOT NULL COMMENT '分销类型 0定额，1比率',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='每个会员针对每个分销商的返佣情况';

-- ----------------------------
-- Table structure for %DB_PREFIX%log
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%log`;
CREATE TABLE `%DB_PREFIX%log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_info` text NOT NULL COMMENT '日志描述内容',
  `log_time` int(11) NOT NULL COMMENT '发生时间',
  `log_admin` int(11) NOT NULL COMMENT '操作的管理员ID',
  `log_ip` varchar(255) NOT NULL COMMENT '操作者IP',
  `log_status` tinyint(1) NOT NULL COMMENT '操作结果 1:操作成功 0:操作失败',
  `module` varchar(255) NOT NULL COMMENT '操作的模块module',
  `action` varchar(255) NOT NULL COMMENT '操作的命令action',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='后台操作日志表';

-- ----------------------------
-- Table structure for %DB_PREFIX%mail_list
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%mail_list`;
CREATE TABLE `%DB_PREFIX%mail_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_address` varchar(255) NOT NULL COMMENT '邮件的地址',
  `city_id` int(11) NOT NULL COMMENT '订阅的城市ID，用于按地区群发时匹配',
  `code` varchar(255) NOT NULL COMMENT '弃用',
  `is_effect` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mail_address_idx` (`mail_address`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='邮件订阅表';

-- ----------------------------
-- Records of %DB_PREFIX%mail_list
-- ----------------------------
INSERT INTO `%DB_PREFIX%mail_list` VALUES ('20', 'fanwe@fanwe.com', '45', '', '1');



-- ----------------------------
-- Table structure for `%DB_PREFIX%mail_server`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%mail_server`;
CREATE TABLE `%DB_PREFIX%mail_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smtp_server` varchar(255) NOT NULL COMMENT 'smtp服务器地址IP或域名',
  `smtp_name` varchar(255) NOT NULL COMMENT 'smtp发件帐号名',
  `smtp_pwd` varchar(255) NOT NULL COMMENT 'smtp密码',
  `is_ssl` tinyint(1) NOT NULL COMMENT '是否ssl加密连接（参考具体smtp服务商的要求，如gmail要求ssl连接）',
  `smtp_port` varchar(255) NOT NULL COMMENT 'smtp端口',
  `use_limit` int(11) NOT NULL COMMENT '可用次数为0时表示无限次数使用, 次数满后轮到下一个配置的邮件服务器发件，直到没有可发的邮件服务器为止',
  `is_reset` tinyint(1) NOT NULL COMMENT '是否自动清零，1:次数达到上限后自动清零，等待下一个轮回继续使用该邮箱发送',
  `is_effect` tinyint(1) NOT NULL,
  `total_use` int(11) NOT NULL COMMENT '当前已用次数',
  `is_verify` tinyint(1) NOT NULL COMMENT '是否需要身份验证,通常为1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='发件用邮件服务器列表';

-- ----------------------------
-- Table structure for %DB_PREFIX%mobile_list
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%mobile_list`;
CREATE TABLE `%DB_PREFIX%mobile_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(255) NOT NULL COMMENT '手机号',
  `city_id` int(11) NOT NULL COMMENT '订阅城市ID（按地区群发时匹配）',
  `verify_code` varchar(255) NOT NULL COMMENT '验证码',
  `is_effect` tinyint(1) NOT NULL COMMENT '有效性标识',
  PRIMARY KEY (`id`),
  KEY `mobile_idx` (`mobile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='手机订阅表';

-- ----------------------------
-- Table structure for %DB_PREFIX%msg_box
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%msg_box`;
CREATE TABLE `%DB_PREFIX%msg_box` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL COMMENT '内容',
  `user_id` int(11) NOT NULL COMMENT '消息所属的会员',
  `create_time` int(11) NOT NULL COMMENT '发信时间',
  `is_read` tinyint(1) NOT NULL COMMENT '是否已读 0:未读 1:已读',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否被用户删除',
  `type` varchar(200) NOT NULL COMMENT '消息接口类型:SystemMsg/OrderMsg等，实现来源于接口调用',
  `data` text NOT NULL COMMENT '消息相关数据集，序列化后用于接口调用',
  `data_id` int(11) NOT NULL COMMENT '相关数据的ID,可为0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `is_read` (`is_read`),
  KEY `is_delete` (`is_delete`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='新的会员站内信表';

-- ----------------------------
-- Table structure for %DB_PREFIX%msg_system
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%msg_system`;
CREATE TABLE `%DB_PREFIX%msg_system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL COMMENT '内容',
  `create_time` int(11) NOT NULL COMMENT '发放时间点',
  `user_names` text NOT NULL COMMENT '群发的用户名列表，逗号分隔(为空表示发给所有人)',
  `user_ids` text NOT NULL COMMENT 'user_id的全文索引',
  `end_time` int(11) NOT NULL COMMENT '过期时间点',
  PRIMARY KEY (`id`),
  FULLTEXT KEY `user_ids` (`user_ids`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='站内信群发数据表';

-- ----------------------------
-- Table structure for %DB_PREFIX%msg_template
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%msg_template`;
CREATE TABLE `%DB_PREFIX%msg_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '名称标识',
  `content` text NOT NULL COMMENT '模板内容',
  `type` tinyint(1) NOT NULL COMMENT '类型 0:短信 1:邮件',
  `is_html` tinyint(1) NOT NULL COMMENT '针对邮件设置的是否超文本标识',
  `is_allow_app` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:不允许发给app;1:允许发给app',
  `is_allow_wx` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:不允许发给wx;1:允许发给wx',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统邮件、短信模板';

-- ----------------------------
-- Records of %DB_PREFIX%msg_template
-- ----------------------------
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('4', 'TPL_MAIL_USER_PASSWORD', '{$user.user_name}你好，请点击以下链接修改您的密码\r\n</p>\r\n<a href=\'{$user.password_url}\'>{$user.password_url}</a>', '1', '1', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('5', 'TPL_SMS_PAYMENT', '{$payment_notice.user_name}你好,你所下订单{$payment_notice.order_sn}的收款单{$payment_notice.notice_sn}金额{$payment_notice.money_format}于{$payment_notice.pay_time_format}支付成功', '0', '0', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('6', 'TPL_MAIL_PAYMENT', '{$payment_notice.user_name}你好,你所下订单{$payment_notice.order_sn}的收款单{$payment_notice.notice_sn}金额{$payment_notice.money_format}于{$payment_notice.pay_time_format}支付成功', '1', '0', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('7', 'TPL_SMS_DELIVERY', '{$delivery_notice.user_name}你好,你所下订单{$delivery_notice.order_sn}的商品{$delivery_notice.deal_names}于{$delivery_notice.delivery_time_format}发货成功,发货单号{$delivery_notice.notice_sn}', '0', '0', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('8', 'TPL_MAIL_DELIVERY', '{$delivery_notice.user_name}你好,你所下订单{$delivery_notice.order_sn}的商品{$delivery_notice.deal_names}于{$delivery_notice.delivery_time_format}发货成功,发货单号{$delivery_notice.notice_sn}', '1', '0', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('9', 'TPL_SMS_VERIFY_CODE', '你的手机号为{$verify.mobile},验证码为{$verify.code}', '0', '0', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('20', 'TPL_USER_WITHDRAW_SMS', '{$user_name}您好，你的提现申请已通过，{$money_format}已经转入您指定账户。', '0', '0', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('21', 'TPL_USER_WITHDRAW_MAIL', '{$user_name}您好，你的提现申请已通过，{$money_format}已经转入您指定账户。', '1', '1', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('23', 'TPL_USER_LOTTERY', '{$user_name}恭喜您，您参与的{$duobao_item.name}夺宝活动，中奖了', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%m_adv`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%m_adv`;
CREATE TABLE `%DB_PREFIX%m_adv` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '' COMMENT '广告名称',
  `img` varchar(255) DEFAULT '' COMMENT '广告图片',
  `mobile_type` tinyint(1) DEFAULT '0' COMMENT '手机类型0:ios/android; 1:wap',
  `type` tinyint(1) DEFAULT '0' COMMENT '1分类标签广告\r\n2URL广告\r\n3分类排行\r\n4达人页\r\n5搜索页\r\n6拍照\r\n7热门\r\n8分享详细\r\n9团购列表\r\n10商品列表\r\n11活动列表\r\n12优惠列表\r\n13代金券列表\r\n14团购明细\r\n15商品明细\r\n16活动明细\r\n17优惠明细\r\n18代金券明细\r\n19关于我们\r\n20优惠券主页面\r\n21公告列表			',
  `position` tinyint(1) NOT NULL COMMENT '显示的位置 0:首页 1:启动页 2:专题位',
  `data` text COMMENT '配置的序列化数据（根据不同的type存放不同的结果）',
  `sort` smallint(5) DEFAULT '10' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态 0:无效1:有效',
  `city_id` int(11) DEFAULT '0' COMMENT '所属城市',
  `ctl` varchar(255) DEFAULT NULL,
  `zt_id` int(11) NOT NULL COMMENT '手机端专题组的ID',
  `zt_position` varchar(255) NOT NULL COMMENT '专题模板的位置显示(广告位ID)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='手机端广告配置表';

-- ----------------------------
-- Table structure for %DB_PREFIX%m_config
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%m_config`;
CREATE TABLE `%DB_PREFIX%m_config` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `val` text,
  `type` tinyint(1) NOT NULL,
  `group_name` varchar(50) NOT NULL DEFAULT '基础配置' COMMENT '分组显示',
  `sort` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='手机端的后台配置表';

-- ----------------------------
-- Records of %DB_PREFIX%m_config
-- ----------------------------
INSERT INTO `%DB_PREFIX%m_config` VALUES ('22', 'sina_app_key', '新浪App Key', '', '0', 'APP配置', '0');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('23', 'sina_app_secret', '新浪App Secret', '', '0', 'APP配置', '0');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('50', 'ios_version', 'ios版本号(yyyymmddnn)', '', '0', 'APP配置', '1');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('51', 'ios_down_url', 'ios下载地址(appstore连接地址)', 'http://o2o.fanwe.net/o2o%DB_PREFIX%app.ipa', '0', 'APP配置', '2');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('52', 'ios_upgrade', 'ios版本升级内容', 'ios升级测试', '0', 'APP配置', '3');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('53', 'ios_forced_upgrade', 'ios是否强制升级(0:否;1:是)', '0', '0', 'APP配置', '4');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('54', 'android_version', 'android版本号(yyyymmddnn)', '2015021001', '0', 'APP配置', '5');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('55', 'android_filename', 'android下载包名', 'http://o2o.fanwe.net/o2o%DB_PREFIX%app.apk', '0', 'APP配置', '6');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('56', 'android_upgrade', 'android版本升级内容', 'android升级测试', '0', 'APP配置', '7');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('57', 'android_forced_upgrade', 'android是否强制升级(0:否;1:是)', '0', '0', 'APP配置', '8');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('29', 'qq_app_secret', '腾讯开放平台APP KEY', '', '0', 'APP配置', '0');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('28', 'qq_app_key', '腾讯开放平台APP ID', '', '0', 'APP配置', '0');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('78', 'android_master_secret', 'android推送友盟AppMasterSecret', '', '0', 'APP配置', '24');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('79', 'android_app_key', 'android推送友盟AppKey', '', '0', 'APP配置', '23');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('80', 'ios_app_key', 'ios推送友盟AppKey', '', '0', 'APP配置', '25');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('81', 'ios_master_secret', 'ios推送友盟AppMasterSecret', '', '0', 'APP配置', '26');

-- ----------------------------
-- Table structure for `%DB_PREFIX%m_config_list`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%m_config_list`;
CREATE TABLE `%DB_PREFIX%m_config_list` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pay_id` varchar(50) DEFAULT NULL,
  `group` int(10) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `has_calc` int(1) DEFAULT NULL,
  `money` float(10,2) DEFAULT NULL,
  `is_verify` int(1) DEFAULT '0' COMMENT '0:无效；1:有效',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='手机端支付时用到一些额外配置，包括支付接口等';

-- ----------------------------
-- Table structure for %DB_PREFIX%m_index
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%m_index`;
CREATE TABLE `%DB_PREFIX%m_index` (
  `id` mediumint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '',
  `vice_name` varchar(100) DEFAULT NULL,
  `desc` varchar(100) DEFAULT '',
  `img` varchar(255) DEFAULT '',
  `type` tinyint(1) DEFAULT '0' COMMENT '1.标签集,2.url地址,3.分类排行,4.最亮达人,5.搜索发现,6.一起拍,7.热门单品排行,8.直接显示某个分享',
  `data` text,
  `sort` smallint(5) DEFAULT '10',
  `status` tinyint(1) DEFAULT '1',
  `is_hot` tinyint(1) DEFAULT '0',
  `is_new` tinyint(1) DEFAULT '0',
  `city_id` int(11) DEFAULT '0',
  `mobile_type` tinyint(1) DEFAULT '0' COMMENT '手机类型0:ios/android; 1:wap',
  `ctl` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of %DB_PREFIX%m_index
-- ----------------------------
INSERT INTO `%DB_PREFIX%m_index` VALUES ('80', '分类', '&#58938;', '#d93a56', '', '1', 'a:1:{s:0:\"\";N;}', '1', '1', '0', '0', '0', '1', 'cate');
INSERT INTO `%DB_PREFIX%m_index` VALUES ('81', '10元专区', '&#58934;', '#43d4cd', '', '7', 'a:1:{s:7:\"min_buy\";s:2:\"10\";}', '2', '1', '0', '0', '0', '1', 'duobaost');
INSERT INTO `%DB_PREFIX%m_index` VALUES ('82', '帮助', '&#58939;', '#f08e33', '', '5', 'a:1:{s:0:\"\";N;}', '4', '1', '0', '0', '0', '1', 'helps');
INSERT INTO `%DB_PREFIX%m_index` VALUES ('83', '揭晓', '&#58940;', '#52b4ff', '', '3', 'a:1:{s:7:\"cate_id\";s:0:\"\";}', '3', '1', '0', '0', '0', '1', 'anno');

-- ----------------------------
-- Table structure for `%DB_PREFIX%m_zt`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%m_zt`;
CREATE TABLE `%DB_PREFIX%m_zt` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '' COMMENT '名称',
  `mobile_type` tinyint(1) DEFAULT '0' COMMENT '手机类型0:ios/android; 1:wap',
  `type` tinyint(1) DEFAULT '0' COMMENT '1分类标签广告\r\n2URL广告\r\n3分类排行\r\n4达人页\r\n5搜索页\r\n6拍照\r\n7热门\r\n8分享详细\r\n9团购列表\r\n10商品列表\r\n11活动列表\r\n12优惠列表\r\n13代金券列表\r\n14团购明细\r\n15商品明细\r\n16活动明细\r\n17优惠明细\r\n18代金券明细\r\n19关于我们\r\n20优惠券主页面\r\n21公告列表			',
  `data` text COMMENT '配置的序列化数据（根据不同的type存放不同的结果）',
  `sort` smallint(5) DEFAULT '10' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态 0:无效1:有效',
  `city_id` int(11) DEFAULT '0' COMMENT '所属城市',
  `ctl` varchar(255) DEFAULT NULL,
  `zt_moban` varchar(255) NOT NULL COMMENT '专题模板文件路径',
  `zt_title` varchar(255) NOT NULL COMMENT '专题显示的标题',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='手机端首页专题位';

-- ----------------------------
-- Table structure for %DB_PREFIX%nav
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%nav`;
CREATE TABLE `%DB_PREFIX%nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '菜单名称',
  `url` varchar(255) NOT NULL COMMENT '跳转的外链URL',
  `blank` tinyint(1) NOT NULL COMMENT '是否在新窗口打开',
  `sort` int(11) NOT NULL COMMENT '排序 大到小',
  `is_effect` tinyint(1) NOT NULL COMMENT '有效性标识',
  `u_module` varchar(255) NOT NULL COMMENT '指向的前台module',
  `u_action` varchar(255) NOT NULL COMMENT '指向的前台action',
  `u_id` int(11) NOT NULL COMMENT '弃用',
  `u_param` varchar(255) NOT NULL COMMENT 'url的参数，以原始的url传参方式填入 如：id=1&cid=2&pid=3',
  `app_index` varchar(255) NOT NULL COMMENT '指向的前台app应用入口',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='前台导航菜单配置表';

-- ----------------------------
-- Table structure for %DB_PREFIX%payment
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%payment`;
CREATE TABLE `%DB_PREFIX%payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) NOT NULL COMMENT '支付接口类名',
  `is_effect` tinyint(1) NOT NULL COMMENT '有效性标识',
  `online_pay` tinyint(1) NOT NULL COMMENT '是否为在线支付的接口',
  `fee_amount` double(20,4) NOT NULL COMMENT '手续费用的计费值',
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `total_amount` double(20,4) NOT NULL,
  `config` text NOT NULL COMMENT '相关的配置信息',
  `logo` varchar(255) NOT NULL COMMENT '显示的图标',
  `sort` int(11) NOT NULL,
  `fee_type` tinyint(1) NOT NULL COMMENT '手续费的计费标准 0:定额 1:支付总额的比率',
  `is_default_pc` int(1) NOT NULL COMMENT '1为pc端默认支付方式',
  `is_default_wap` int(1) NOT NULL COMMENT '1为wap端默认支付方式',
  `is_default_app` int(1) NOT NULL COMMENT '1为app端默认支付方式',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='支付接口表';

-- ----------------------------
-- Table structure for %DB_PREFIX%payment_notice
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%payment_notice`;
CREATE TABLE `%DB_PREFIX%payment_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notice_sn` varchar(255) NOT NULL COMMENT '支付单号',
  `create_time` int(11) NOT NULL COMMENT '下单时间',
  `pay_time` int(11) NOT NULL COMMENT '付款时间',
  `order_id` int(11) NOT NULL COMMENT '关联的订单号ID',
  `is_paid` tinyint(1) NOT NULL COMMENT '是否已支付',
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `payment_id` int(11) NOT NULL COMMENT '支付接口ID',
  `memo` text NOT NULL COMMENT '付款单备注',
  `money` decimal(20,4) NOT NULL COMMENT '应付金额',
  `outer_notice_sn` varchar(255) NOT NULL COMMENT '第三方支付平台的对帐号',
  `ecv_id` int(11) NOT NULL COMMENT '代金券ID',
  `create_date_ymd` varchar(15) NOT NULL COMMENT '支付单为创建时间',
  `create_date_ym` varchar(15) NOT NULL,
  `create_date_y` int(4) NOT NULL,
  `create_date_m` int(2) NOT NULL,
  `create_date_d` int(2) NOT NULL,
  `order_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单类型,3直购订单',
  PRIMARY KEY (`id`),
  UNIQUE KEY `notice_sn_unk` (`notice_sn`),
  KEY `create_date_ymd` (`create_date_ymd`),
  KEY `create_date_ym` (`create_date_ym`),
  KEY `create_date_y` (`create_date_y`),
  KEY `create_date_m` (`create_date_m`),
  KEY `create_date_d` (`create_date_d`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='支付单表';

-- ----------------------------
-- Table structure for %DB_PREFIX%promote_msg
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%promote_msg`;
CREATE TABLE `%DB_PREFIX%promote_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '群发推广信息类型(0:短信 1:邮件)',
  `title` varchar(255) NOT NULL COMMENT '群发信息（邮件标题）',
  `content` text NOT NULL COMMENT '群发的内容',
  `send_time` int(11) NOT NULL COMMENT '设置的自动发送的时间',
  `send_status` tinyint(1) NOT NULL COMMENT '发送状态 0:未发送 1:发送中 2:已发送',
  `deal_id` int(11) NOT NULL COMMENT '针对某个商品发送的推广信息',
  `send_type` tinyint(1) NOT NULL COMMENT '发送方式（0:按会员组 1:按订阅地区发送 2:自定义发送，即指定邮箱、手机发送）',
  `send_type_id` int(11) NOT NULL COMMENT '发送类型为按会员组时：会员组ID，发送类型为按地区时：城市ID',
  `send_define_data` text NOT NULL COMMENT '自定义发送时存放指定的邮箱地址、手机号，用半角逗号分隔',
  `is_html` tinyint(1) NOT NULL COMMENT '群发为邮件时的邮件类型，是否为超文本邮件',
  `last_user_id` int(11) NOT NULL COMMENT '用于发送过程中的分页计算',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='群发推广信息';

-- ----------------------------
-- Table structure for %DB_PREFIX%referrals
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%referrals`;
CREATE TABLE `%DB_PREFIX%referrals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '邀请人ID（即需要返利的会员ID）',
  `rel_user_id` int(11) NOT NULL COMMENT '被邀请人ID',
  `money` double(20,4) NOT NULL COMMENT '返利的现金',
  `create_time` int(11) NOT NULL COMMENT '返利生成的时间',
  `pay_time` int(11) NOT NULL COMMENT '返利发放的时间',
  `order_id` int(11) NOT NULL COMMENT '关联的订单ID',
  `score` int(11) NOT NULL COMMENT '返利的积分',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='邀请返利记录表';

-- ----------------------------
-- Table structure for %DB_PREFIX%region_conf
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%region_conf`;
CREATE TABLE `%DB_PREFIX%region_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '父级地区ID',
  `name` varchar(50) NOT NULL COMMENT '地区名称',
  `region_level` tinyint(4) NOT NULL COMMENT '2:省 3:市(县)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='地区信息表（会员资料修改中用到的地区信息）';

-- ----------------------------
-- Records of %DB_PREFIX%region_conf
-- ----------------------------
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3', '1', '安徽', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('4', '1', '福建', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('5', '1', '甘肃', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('6', '1', '广东', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('7', '1', '广西', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('8', '1', '贵州', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('9', '1', '海南', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('10', '1', '河北', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('11', '1', '河南', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('12', '1', '黑龙江', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('13', '1', '湖北', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('14', '1', '湖南', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('15', '1', '吉林', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('16', '1', '江苏', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('17', '1', '江西', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('18', '1', '辽宁', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('19', '1', '内蒙古', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('20', '1', '宁夏', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('21', '1', '青海', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('22', '1', '山东', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('23', '1', '山西', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('24', '1', '陕西', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('26', '1', '四川', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('28', '1', '西藏', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('29', '1', '新疆', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('30', '1', '云南', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('31', '1', '浙江', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('36', '3', '安庆', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('37', '3', '蚌埠', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('38', '3', '巢湖', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('39', '3', '池州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('40', '3', '滁州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('41', '3', '阜阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('42', '3', '淮北', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('43', '3', '淮南', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('44', '3', '黄山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('45', '3', '六安', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('46', '3', '马鞍山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('47', '3', '宿州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('48', '3', '铜陵', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('49', '3', '芜湖', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('50', '3', '宣城', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('51', '3', '亳州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('52', '2', '北京', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('53', '4', '福州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('54', '4', '龙岩', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('55', '4', '南平', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('56', '4', '宁德', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('57', '4', '莆田', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('58', '4', '泉州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('59', '4', '三明', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('60', '4', '厦门', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('61', '4', '漳州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('62', '5', '兰州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('63', '5', '白银', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('64', '5', '定西', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('65', '5', '甘南', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('66', '5', '嘉峪关', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('67', '5', '金昌', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('68', '5', '酒泉', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('69', '5', '临夏', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('70', '5', '陇南', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('71', '5', '平凉', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('72', '5', '庆阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('73', '5', '天水', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('74', '5', '武威', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('75', '5', '张掖', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('76', '6', '广州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('77', '6', '深圳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('78', '6', '潮州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('79', '6', '东莞', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('80', '6', '佛山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('81', '6', '河源', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('82', '6', '惠州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('83', '6', '江门', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('84', '6', '揭阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('85', '6', '茂名', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('86', '6', '梅州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('87', '6', '清远', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('88', '6', '汕头', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('89', '6', '汕尾', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('90', '6', '韶关', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('91', '6', '阳江', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('92', '6', '云浮', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('93', '6', '湛江', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('94', '6', '肇庆', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('95', '6', '中山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('96', '6', '珠海', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('97', '7', '南宁', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('98', '7', '桂林', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('99', '7', '百色', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('100', '7', '北海', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('101', '7', '崇左', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('102', '7', '防城港', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('103', '7', '贵港', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('104', '7', '河池', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('105', '7', '贺州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('106', '7', '来宾', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('107', '7', '柳州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('108', '7', '钦州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('109', '7', '梧州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('110', '7', '玉林', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('111', '8', '贵阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('112', '8', '安顺', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('113', '8', '毕节', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('114', '8', '六盘水', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('115', '8', '黔东南', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('116', '8', '黔南', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('117', '8', '黔西南', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('118', '8', '铜仁', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('119', '8', '遵义', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('120', '9', '海口', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('121', '9', '三亚', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('122', '9', '白沙', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('123', '9', '保亭', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('124', '9', '昌江', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('125', '9', '澄迈县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('126', '9', '定安县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('127', '9', '东方', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('128', '9', '乐东', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('129', '9', '临高县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('130', '9', '陵水', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('131', '9', '琼海', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('132', '9', '琼中', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('133', '9', '屯昌县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('134', '9', '万宁', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('135', '9', '文昌', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('136', '9', '五指山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('137', '9', '儋州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('138', '10', '石家庄', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('139', '10', '保定', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('140', '10', '沧州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('141', '10', '承德', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('142', '10', '邯郸', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('143', '10', '衡水', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('144', '10', '廊坊', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('145', '10', '秦皇岛', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('146', '10', '唐山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('147', '10', '邢台', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('148', '10', '张家口', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('149', '11', '郑州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('150', '11', '洛阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('151', '11', '开封', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('152', '11', '安阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('153', '11', '鹤壁', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('154', '11', '济源', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('155', '11', '焦作', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('156', '11', '南阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('157', '11', '平顶山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('158', '11', '三门峡', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('159', '11', '商丘', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('160', '11', '新乡', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('161', '11', '信阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('162', '11', '许昌', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('163', '11', '周口', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('164', '11', '驻马店', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('165', '11', '漯河', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('166', '11', '濮阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('167', '12', '哈尔滨', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('168', '12', '大庆', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('169', '12', '大兴安岭', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('170', '12', '鹤岗', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('171', '12', '黑河', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('172', '12', '鸡西', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('173', '12', '佳木斯', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('174', '12', '牡丹江', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('175', '12', '七台河', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('176', '12', '齐齐哈尔', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('177', '12', '双鸭山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('178', '12', '绥化', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('179', '12', '伊春', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('180', '13', '武汉', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('181', '13', '仙桃', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('182', '13', '鄂州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('183', '13', '黄冈', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('184', '13', '黄石', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('185', '13', '荆门', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('186', '13', '荆州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('187', '13', '潜江', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('188', '13', '神农架林区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('189', '13', '十堰', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('190', '13', '随州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('191', '13', '天门', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('192', '13', '咸宁', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('193', '13', '襄樊', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('194', '13', '孝感', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('195', '13', '宜昌', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('196', '13', '恩施', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('197', '14', '长沙', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('198', '14', '张家界', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('199', '14', '常德', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('200', '14', '郴州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('201', '14', '衡阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('202', '14', '怀化', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('203', '14', '娄底', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('204', '14', '邵阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('205', '14', '湘潭', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('206', '14', '湘西', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('207', '14', '益阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('208', '14', '永州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('209', '14', '岳阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('210', '14', '株洲', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('211', '15', '长春', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('212', '15', '吉林', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('213', '15', '白城', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('214', '15', '白山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('215', '15', '辽源', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('216', '15', '四平', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('217', '15', '松原', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('218', '15', '通化', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('219', '15', '延边', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('220', '16', '南京', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('221', '16', '苏州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('222', '16', '无锡', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('223', '16', '常州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('224', '16', '淮安', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('225', '16', '连云港', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('226', '16', '南通', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('227', '16', '宿迁', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('228', '16', '泰州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('229', '16', '徐州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('230', '16', '盐城', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('231', '16', '扬州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('232', '16', '镇江', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('233', '17', '南昌', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('234', '17', '抚州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('235', '17', '赣州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('236', '17', '吉安', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('237', '17', '景德镇', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('238', '17', '九江', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('239', '17', '萍乡', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('240', '17', '上饶', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('241', '17', '新余', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('242', '17', '宜春', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('243', '17', '鹰潭', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('244', '18', '沈阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('245', '18', '大连', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('246', '18', '鞍山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('247', '18', '本溪', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('248', '18', '朝阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('249', '18', '丹东', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('250', '18', '抚顺', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('251', '18', '阜新', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('252', '18', '葫芦岛', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('253', '18', '锦州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('254', '18', '辽阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('255', '18', '盘锦', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('256', '18', '铁岭', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('257', '18', '营口', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('258', '19', '呼和浩特', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('259', '19', '阿拉善盟', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('260', '19', '巴彦淖尔盟', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('261', '19', '包头', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('262', '19', '赤峰', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('263', '19', '鄂尔多斯', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('264', '19', '呼伦贝尔', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('265', '19', '通辽', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('266', '19', '乌海', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('267', '19', '乌兰察布市', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('268', '19', '锡林郭勒盟', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('269', '19', '兴安盟', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('270', '20', '银川', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('271', '20', '固原', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('272', '20', '石嘴山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('273', '20', '吴忠', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('274', '20', '中卫', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('275', '21', '西宁', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('276', '21', '果洛', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('277', '21', '海北', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('278', '21', '海东', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('279', '21', '海南', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('280', '21', '海西', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('281', '21', '黄南', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('282', '21', '玉树', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('283', '22', '济南', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('284', '22', '青岛', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('285', '22', '滨州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('286', '22', '德州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('287', '22', '东营', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('288', '22', '菏泽', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('289', '22', '济宁', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('290', '22', '莱芜', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('291', '22', '聊城', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('292', '22', '临沂', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('293', '22', '日照', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('294', '22', '泰安', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('295', '22', '威海', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('296', '22', '潍坊', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('297', '22', '烟台', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('298', '22', '枣庄', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('299', '22', '淄博', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('300', '23', '太原', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('301', '23', '长治', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('302', '23', '大同', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('303', '23', '晋城', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('304', '23', '晋中', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('305', '23', '临汾', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('306', '23', '吕梁', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('307', '23', '朔州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('308', '23', '忻州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('309', '23', '阳泉', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('310', '23', '运城', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('311', '24', '西安', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('312', '24', '安康', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('313', '24', '宝鸡', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('314', '24', '汉中', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('315', '24', '商洛', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('316', '24', '铜川', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('317', '24', '渭南', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('318', '24', '咸阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('319', '24', '延安', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('320', '24', '榆林', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('321', '25', '上海', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('322', '26', '成都', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('323', '26', '绵阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('324', '26', '阿坝', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('325', '26', '巴中', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('326', '26', '达州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('327', '26', '德阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('328', '26', '甘孜', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('329', '26', '广安', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('330', '26', '广元', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('331', '26', '乐山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('332', '26', '凉山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('333', '26', '眉山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('334', '26', '南充', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('335', '26', '内江', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('336', '26', '攀枝花', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('337', '26', '遂宁', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('338', '26', '雅安', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('339', '26', '宜宾', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('340', '26', '资阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('341', '26', '自贡', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('342', '26', '泸州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('343', '27', '天津', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('344', '28', '拉萨', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('345', '28', '阿里', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('346', '28', '昌都', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('347', '28', '林芝', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('348', '28', '那曲', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('349', '28', '日喀则', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('350', '28', '山南', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('351', '29', '乌鲁木齐', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('352', '29', '阿克苏', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('353', '29', '阿拉尔', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('354', '29', '巴音郭楞', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('355', '29', '博尔塔拉', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('356', '29', '昌吉', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('357', '29', '哈密', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('358', '29', '和田', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('359', '29', '喀什', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('360', '29', '克拉玛依', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('361', '29', '克孜勒苏', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('362', '29', '石河子', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('363', '29', '图木舒克', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('364', '29', '吐鲁番', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('365', '29', '五家渠', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('366', '29', '伊犁', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('367', '30', '昆明', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('368', '30', '怒江', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('369', '30', '普洱', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('370', '30', '丽江', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('371', '30', '保山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('372', '30', '楚雄', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('373', '30', '大理', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('374', '30', '德宏', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('375', '30', '迪庆', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('376', '30', '红河', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('377', '30', '临沧', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('378', '30', '曲靖', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('379', '30', '文山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('380', '30', '西双版纳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('381', '30', '玉溪', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('382', '30', '昭通', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('383', '31', '杭州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('384', '31', '湖州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('385', '31', '嘉兴', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('386', '31', '金华', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('387', '31', '丽水', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('388', '31', '宁波', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('389', '31', '绍兴', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('390', '31', '台州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('391', '31', '温州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('392', '31', '舟山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('393', '31', '衢州', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('394', '32', '重庆', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('395', '33', '香港', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('396', '34', '澳门', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('397', '35', '台湾', '2');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('500', '52', '东城区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('501', '52', '西城区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('502', '52', '海淀区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('503', '52', '朝阳区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('504', '52', '崇文区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('505', '52', '宣武区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('506', '52', '丰台区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('507', '52', '石景山区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('508', '52', '房山区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('509', '52', '门头沟区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('510', '52', '通州区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('511', '52', '顺义区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('512', '52', '昌平区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('513', '52', '怀柔区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('514', '52', '平谷区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('515', '52', '大兴区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('516', '52', '密云县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('517', '52', '延庆县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2703', '321', '长宁区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2704', '321', '闸北区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2705', '321', '闵行区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2706', '321', '徐汇区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2707', '321', '浦东新区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2708', '321', '杨浦区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2709', '321', '普陀区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2710', '321', '静安区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2711', '321', '卢湾区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2712', '321', '虹口区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2713', '321', '黄浦区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2714', '321', '南汇区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2715', '321', '松江区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2716', '321', '嘉定区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2717', '321', '宝山区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2718', '321', '青浦区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2719', '321', '金山区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2720', '321', '奉贤区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2721', '321', '崇明县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2912', '343', '和平区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2913', '343', '河西区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2914', '343', '南开区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2915', '343', '河北区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2916', '343', '河东区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2917', '343', '红桥区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2918', '343', '东丽区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2919', '343', '津南区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2920', '343', '西青区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2921', '343', '北辰区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2922', '343', '塘沽区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2923', '343', '汉沽区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2924', '343', '大港区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2925', '343', '武清区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2926', '343', '宝坻区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2927', '343', '经济开发区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2928', '343', '宁河县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2929', '343', '静海县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2930', '343', '蓟县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3325', '394', '合川区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3326', '394', '江津区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3327', '394', '南川区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3328', '394', '永川区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3329', '394', '南岸区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3330', '394', '渝北区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3331', '394', '万盛区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3332', '394', '大渡口区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3333', '394', '万州区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3334', '394', '北碚区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3335', '394', '沙坪坝区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3336', '394', '巴南区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3337', '394', '涪陵区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3338', '394', '江北区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3339', '394', '九龙坡区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3340', '394', '渝中区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3341', '394', '黔江开发区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3342', '394', '长寿区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3343', '394', '双桥区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3344', '394', '綦江县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3345', '394', '潼南县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3346', '394', '铜梁县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3347', '394', '大足县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3348', '394', '荣昌县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3349', '394', '璧山县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3350', '394', '垫江县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3351', '394', '武隆县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3352', '394', '丰都县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3353', '394', '城口县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3354', '394', '梁平县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3355', '394', '开县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3356', '394', '巫溪县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3357', '394', '巫山县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3358', '394', '奉节县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3359', '394', '云阳县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3360', '394', '忠县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3361', '394', '石柱', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3362', '394', '彭水', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3363', '394', '酉阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3364', '394', '秀山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3365', '395', '沙田区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3366', '395', '东区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3367', '395', '观塘区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3368', '395', '黄大仙区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3369', '395', '九龙城区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3370', '395', '屯门区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3371', '395', '葵青区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3372', '395', '元朗区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3373', '395', '深水埗区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3374', '395', '西贡区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3375', '395', '大埔区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3376', '395', '湾仔区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3377', '395', '油尖旺区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3378', '395', '北区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3379', '395', '南区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3380', '395', '荃湾区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3381', '395', '中西区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3382', '395', '离岛区', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3383', '396', '澳门', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3384', '397', '台北', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3385', '397', '高雄', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3386', '397', '基隆', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3387', '397', '台中', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3388', '397', '台南', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3389', '397', '新竹', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3390', '397', '嘉义', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3391', '397', '宜兰县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3392', '397', '桃园县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3393', '397', '苗栗县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3394', '397', '彰化县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3395', '397', '南投县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3396', '397', '云林县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3397', '397', '屏东县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3398', '397', '台东县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3399', '397', '花莲县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3400', '397', '澎湖县', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3401', '3', '合肥', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3402', '3401', '瑶海', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3403', '3401', '庐阳', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3404', '3401', '蜀山', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3405', '3401', '包河', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3406', '3401', '长丰', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3407', '3401', '肥东', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3408', '3401', '肥西', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3409', '3401', '巢湖', '3');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3410', '3401', '庐江', '3');

-- ----------------------------
-- Table structure for `%DB_PREFIX%role`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%role`;
CREATE TABLE `%DB_PREFIX%role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='后台管理员角色表';

-- ----------------------------
-- Table structure for %DB_PREFIX%role_access
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%role_access`;
CREATE TABLE `%DB_PREFIX%role_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `node` varchar(255) NOT NULL COMMENT '节点action名',
  `module` varchar(255) NOT NULL COMMENT '模块名',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='后台角色权限配置表';

-- ----------------------------
-- Table structure for %DB_PREFIX%scan_subscribe_log
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%scan_subscribe_log`;
CREATE TABLE `%DB_PREFIX%scan_subscribe_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `openid` varchar(100) NOT NULL COMMENT '关注用户的openid',
  `pid` int(10) unsigned NOT NULL COMMENT '上级用户id',
  `create_time` int(10) unsigned NOT NULL COMMENT '关注时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `openid_unique` (`openid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户通过带参数二维码关注的用户';

-- ----------------------------
-- Table structure for %DB_PREFIX%schedule_list
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%schedule_list`;
CREATE TABLE `%DB_PREFIX%schedule_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL COMMENT '计划任务类型，不同类型有不同的执行接口',
  `name` varchar(255) NOT NULL COMMENT '计划任务可识别的名称',
  `dest` varchar(255) DEFAULT NULL COMMENT '计划任务标（手机，邮箱，推送用的openid，内部执行程序为NULL）',
  `data` longtext NOT NULL COMMENT '计划任务运行参数',
  `schedule_date` date NOT NULL COMMENT '计划任务的日期',
  `schedule_time` int(11) NOT NULL COMMENT '计划任务启动执行时间',
  `lock_time` int(11) NOT NULL COMMENT 'exec_lock加锁时间',
  `exec_begin_time` int(11) NOT NULL COMMENT '执行开始时间',
  `exec_end_time` int(11) NOT NULL COMMENT '执行结束时间',
  `exec_status` tinyint(1) NOT NULL COMMENT '执行结果 0未执行 1执行中 2执行结束',
  `exec_info` longtext NOT NULL COMMENT '执行结果的相关信息',
  `exec_lock` tinyint(1) NOT NULL COMMENT ' 任务是否锁住，防止多次请求 0否 1是',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `dest` (`dest`),
  KEY `schedule_date` (`schedule_date`),
  KEY `idx` (`type`,`schedule_date`),
  KEY `exec_status` (`exec_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='计划任务';

-- ----------------------------
-- Table structure for %DB_PREFIX%session
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%session`;
CREATE TABLE `%DB_PREFIX%session` (
  `session_id` varchar(255) NOT NULL,
  `session_data` text NOT NULL,
  `session_time` int(11) NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for %DB_PREFIX%share
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%share`;
CREATE TABLE `%DB_PREFIX%share` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `duobao_item_id` int(11) NOT NULL DEFAULT '0' COMMENT '夺宝活动ID',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `create_time` int(11) NOT NULL COMMENT '发表时间',
  `type` varchar(255) NOT NULL COMMENT '1:晒单分享',
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `user_name` varchar(255) NOT NULL COMMENT '会员名',
  `is_effect` tinyint(1) NOT NULL COMMENT '有效性',
  `xpoint` varchar(255) NOT NULL COMMENT '手机发表的经度',
  `ypoint` varchar(255) NOT NULL COMMENT '手机发表的纬度',
  `is_recommend` tinyint(1) NOT NULL COMMENT '推荐',
  `is_top` tinyint(1) NOT NULL COMMENT '置顶',
  `images_count` int(11) NOT NULL COMMENT '图片数',
  `image_list` text NOT NULL COMMENT '图片列表缓存',
  `cache_duobao_item_data` text COMMENT '夺宝活动缓存',
  `is_index` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否首页展示',
  `buy_number_1` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1元就中奖的，最小下单量必须是1的活动才更新',
  `is_check` tinyint(1) DEFAULT '0' COMMENT '管理员是否审核过',
  `is_send_ecv` tinyint(1) DEFAULT '0' COMMENT '是否发送红包',
  `ecv_id` int(1) DEFAULT '0' COMMENT '发送的红包ID',
  `duobao_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '夺宝计划id',
  `is_robot` tinyint(1) DEFAULT '0' COMMENT '是否为机器人晒单（0 非机器人，1为机器人）',
  PRIMARY KEY (`id`),
  KEY `buy_number_1` (`buy_number_1`),
  KEY `create_time` (`create_time`),
  KEY `user_id` (`user_id`),
  KEY `is_recommend` (`is_recommend`),
  KEY `is_top` (`is_top`),
  KEY `is_effect` (`is_effect`),
  KEY `is_index` (`is_index`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员分享数据表';

-- ----------------------------
-- Table structure for %DB_PREFIX%share_image
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%share_image`;
CREATE TABLE `%DB_PREFIX%share_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `share_id` int(11) NOT NULL COMMENT '主题ID',
  `name` varchar(255) NOT NULL COMMENT '文件名',
  `filesize` int(11) NOT NULL COMMENT '文件大小',
  `create_time` int(11) NOT NULL COMMENT '上传时间',
  `user_id` int(11) NOT NULL COMMENT '所属会员ID',
  `user_name` varchar(255) NOT NULL COMMENT '所属会员名',
  `path` varchar(255) NOT NULL COMMENT '小图路径',
  `o_path` varchar(255) NOT NULL COMMENT '原图路径',
  `width` int(11) NOT NULL COMMENT '图片宽px',
  `height` int(11) NOT NULL COMMENT '图片高px',
  PRIMARY KEY (`id`),
  KEY `share_id` (`share_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='分享晒单相关图片数据表';

-- ----------------------------
-- Table structure for %DB_PREFIX%sms
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%sms`;
CREATE TABLE `%DB_PREFIX%sms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '短信接口显示名称',
  `description` text NOT NULL COMMENT '描述',
  `class_name` varchar(255) NOT NULL COMMENT '类名',
  `server_url` text NOT NULL COMMENT '接口的服务器通讯地址',
  `user_name` varchar(255) NOT NULL COMMENT '接口商验证用用户名',
  `password` varchar(255) NOT NULL COMMENT '接口商验证用密码',
  `config` text NOT NULL COMMENT '额外的配置信息',
  `is_effect` tinyint(1) NOT NULL COMMENT '有效性',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='短信接口配置表';

-- ----------------------------
-- Table structure for %DB_PREFIX%sms_mobile_verify
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%sms_mobile_verify`;
CREATE TABLE `%DB_PREFIX%sms_mobile_verify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mobile_phone` varchar(50) NOT NULL DEFAULT '',
  `code` varchar(20) NOT NULL DEFAULT '',
  `add_time` int(10) NOT NULL,
  `ip` varchar(100) NOT NULL COMMENT '发送短信人的IP',
  `send_count` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for %DB_PREFIX%statements
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%statements`;
CREATE TABLE `%DB_PREFIX%statements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `income_money` decimal(20,4) NOT NULL COMMENT '收入',
  `income_order` decimal(20,4) NOT NULL COMMENT '收入中用于订单支付',
  `income_incharge` decimal(20,4) NOT NULL COMMENT '收入用于会员充值(含超额充值)',
  `out_money` decimal(20,4) NOT NULL COMMENT '支出',
  `out_uwd_money` decimal(20,4) NOT NULL COMMENT '会员提现支出',
  `stat_time` date NOT NULL COMMENT '日报时间',
  `stat_month` varchar(10) NOT NULL COMMENT '月份',
  PRIMARY KEY (`id`),
  UNIQUE KEY `stat_time` (`stat_time`),
  KEY `stat_month` (`stat_month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='平台财务日报表\r\n';

-- ----------------------------
-- Table structure for %DB_PREFIX%statements_log
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%statements_log`;
CREATE TABLE `%DB_PREFIX%statements_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '0.收入 1.订单支付收入 2.会员充值收入 3.支出 4.会员提现支出',
  `money` decimal(20,4) NOT NULL,
  `log_info` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='财务报表日志';

-- ----------------------------
-- Table structure for %DB_PREFIX%urls
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%urls`;
CREATE TABLE `%DB_PREFIX%urls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` text NOT NULL COMMENT '外链的url',
  `count` int(11) NOT NULL COMMENT '该链接被点击的次数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='分享中关于外链的加密存储表';

-- ----------------------------
-- Table structure for %DB_PREFIX%user
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user`;
CREATE TABLE `%DB_PREFIX%user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL COMMENT '会员名',
  `user_pwd` varchar(255) NOT NULL COMMENT '会员密码',
  `create_time` int(11) NOT NULL COMMENT '注册时间',
  `update_time` int(11) NOT NULL COMMENT '修改时间',
  `login_ip` varchar(255) NOT NULL COMMENT '最后登录IP',
  `group_id` int(11) NOT NULL COMMENT '会员组ID',
  `is_effect` tinyint(1) NOT NULL COMMENT '是否被禁用（未验证）',
  `is_delete` tinyint(1) NOT NULL COMMENT '删除',
  `email` varchar(255) DEFAULT NULL COMMENT '会员邮件',
  `mobile` varchar(255) DEFAULT NULL COMMENT '会员手机号',
  `score` int(11) NOT NULL COMMENT '会员积分',
  `total_score` int(11) NOT NULL COMMENT '累积积分：用于会员组升级',
  `money` double(20,4) NOT NULL COMMENT '会员余额',
  `verify` varchar(255) NOT NULL COMMENT '验证注册生效时生成的验证码',
  `code` varchar(255) NOT NULL COMMENT '登录用的标识码(md5加密前缀)',
  `pid` int(11) NOT NULL COMMENT '推荐人ID',
  `login_time` int(11) NOT NULL COMMENT '最后登录时间',
  `referral_count` int(11) NOT NULL COMMENT '返利数量',
  `password_verify` varchar(255) NOT NULL COMMENT '取回密码的验证码',
  `integrate_id` int(11) NOT NULL COMMENT '会员整合的用户ID（如uc中的会员ID）',
  `sina_id` varchar(255) NOT NULL COMMENT '新浪同步的会员ID',
  `renren_id` varchar(255) NOT NULL COMMENT '预留',
  `kaixin_id` varchar(255) NOT NULL COMMENT '预留',
  `sohu_id` varchar(255) NOT NULL COMMENT '预留',
  `lottery_mobile` varchar(255) NOT NULL COMMENT '抽奖时用的手机号',
  `lottery_verify` varchar(255) NOT NULL COMMENT '抽奖手机的验证码',
  `verify_create_time` int(11) NOT NULL COMMENT '抽奖手机验证码生成时间',
  `tencent_id` varchar(255) NOT NULL COMMENT '腾讯微博ID',
  `referer` varchar(255) NOT NULL COMMENT '会员来路',
  `login_pay_time` int(11) NOT NULL COMMENT '弃用',
  `focus_count` int(11) NOT NULL COMMENT '关注别人的数量',
  `focused_count` int(11) NOT NULL COMMENT '粉丝数',
  `province_id` int(11) NOT NULL COMMENT '所属省份ID',
  `city_id` int(11) NOT NULL COMMENT '所属城市 ID',
  `sex` tinyint(1) NOT NULL DEFAULT '-1' COMMENT '性别',
  `my_intro` varchar(255) NOT NULL COMMENT '个人简介',
  `is_merchant` tinyint(1) NOT NULL COMMENT '是否绑定商家',
  `merchant_name` varchar(255) NOT NULL COMMENT '商家帐号名',
  `is_daren` tinyint(1) NOT NULL COMMENT '达人标识 ',
  `daren_title` varchar(255) NOT NULL COMMENT '达人称号',
  `step` tinyint(1) NOT NULL COMMENT '新手已完成步骤',
  `byear` int(4) NOT NULL COMMENT '生日年',
  `bmonth` int(2) NOT NULL COMMENT '生日月',
  `bday` int(2) NOT NULL COMMENT '生日日',
  `locate_time` int(11) DEFAULT '0' COMMENT '用户最后登陆时间',
  `xpoint` float(10,6) DEFAULT '0.000000' COMMENT '用户最后登陆x座标',
  `ypoint` float(10,6) DEFAULT '0.000000' COMMENT '用户最后登陆y座标',
  `topic_count` int(11) NOT NULL COMMENT '主题数',
  `fav_count` int(11) NOT NULL COMMENT '喜欢数',
  `faved_count` int(11) NOT NULL COMMENT '被喜欢数',
  `dp_count` int(11) NOT NULL COMMENT '点评总数',
  `insite_count` int(11) NOT NULL COMMENT '站点分享数总（本站的商品等数据）',
  `outsite_count` int(11) NOT NULL COMMENT '外站的分享数（如有实现的淘宝分享等）',
  `level_id` int(11) NOT NULL COMMENT '等级ID',
  `point` int(11) NOT NULL COMMENT '经验值',
  `sina_app_key` varchar(255) NOT NULL COMMENT '新浪的同步验证key',
  `sina_app_secret` varchar(255) NOT NULL COMMENT '新浪的同步验证密码',
  `is_syn_sina` tinyint(1) NOT NULL COMMENT '是否同步发微博到新浪',
  `tencent_app_key` varchar(255) NOT NULL COMMENT '腾讯的同步验证key',
  `tencent_app_secret` varchar(255) NOT NULL COMMENT '腾讯的同步验证密码',
  `is_syn_tencent` tinyint(1) NOT NULL COMMENT '是否同步发微博到腾讯',
  `sina_token` varchar(255) NOT NULL COMMENT '新浪的授权码',
  `t_access_token` varchar(255) NOT NULL COMMENT '腾讯微博授权码',
  `t_openkey` varchar(255) NOT NULL COMMENT '腾讯微博的openkey',
  `t_openid` varchar(255) NOT NULL COMMENT '腾讯微博OPENID',
  `avatar` varchar(255) NOT NULL DEFAULT './public/avatar/noavatar.gif',
  `is_tmp` tinyint(1) NOT NULL COMMENT '表示是否为临时用户（如手机注册）',
  `qqv2_id` varchar(255) NOT NULL,
  `qq_token` varchar(255) NOT NULL,
  `t_name` varchar(255) NOT NULL,
  `dev_type` varchar(20) DEFAULT 'android' COMMENT 'android,ios 客户手机类型,一个客户只绑定一个最新的手机',
  `device_token` varchar(255) DEFAULT NULL COMMENT '推送device_token一个客户只绑定一个最新的手机',
  `wx_openid` varchar(255) NOT NULL COMMENT '微信OPENID',
  `is_fx` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否允许分销(默认都允许)',
  `fx_total_money` decimal(20,4) NOT NULL COMMENT '分销的累积营业额',
  `fx_total_balance` decimal(20,4) NOT NULL COMMENT '分销的累积利润',
  `fx_money` decimal(20,4) NOT NULL COMMENT '分销的利润（可提现）',
  `fx_level` int(11) NOT NULL COMMENT '分销会员的等级(0表示默认等级)',
  `fx_mall_bg` varchar(255) NOT NULL COMMENT '分销小店背景',
  `real_name` varchar(255) NOT NULL COMMENT '会员真实姓名',
  `is_robot` tinyint(1) NOT NULL COMMENT '是否为机器人帐号',
  `user_logo` varchar(255) NOT NULL,
  `is_phone_register` tinyint(1) NOT NULL COMMENT '手机注册用户',
  `is_cart_agreement` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否同意购物车协议',
  `union_id` varchar(255) NOT NULL,
  `m_openid` varchar(255) NOT NULL,
  `is_open_scan` tinyint(1) unsigned NOT NULL COMMENT '1开启渠道，0未开启渠道',
  `remark_name` varchar(255) DEFAULT '' COMMENT '标注信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unk_user_name` (`user_name`),
  UNIQUE KEY `unk_email` (`email`),
  UNIQUE KEY `unk_mobile` (`mobile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Table structure for %DB_PREFIX%user_active_log
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_active_log`;
CREATE TABLE `%DB_PREFIX%user_active_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `create_time` int(11) NOT NULL COMMENT '发生时间',
  `point` int(11) NOT NULL COMMENT '经验',
  `score` int(11) NOT NULL COMMENT '积分',
  `money` double(11,4) NOT NULL COMMENT '钱',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='关于会员活跃度的帐号变更日志';

-- ----------------------------
-- Table structure for %DB_PREFIX%user_auth
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_auth`;
CREATE TABLE `%DB_PREFIX%user_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `m_name` varchar(255) NOT NULL,
  `a_name` varchar(255) NOT NULL,
  `rel_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员前台操作权限的配置表';

-- ----------------------------
-- Table structure for %DB_PREFIX%user_bank
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_bank`;
CREATE TABLE `%DB_PREFIX%user_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `bank_name` varchar(255) NOT NULL,
  `bank_account` varchar(255) NOT NULL,
  `bank_user` varchar(255) NOT NULL,
  `bank_mobile` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for %DB_PREFIX%user_consignee
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_consignee`;
CREATE TABLE `%DB_PREFIX%user_consignee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `region_lv1` int(11) NOT NULL COMMENT '国',
  `region_lv2` int(11) NOT NULL COMMENT '省',
  `region_lv3` int(11) NOT NULL COMMENT '市',
  `region_lv4` int(11) NOT NULL COMMENT '地区',
  `address` text NOT NULL COMMENT '地址',
  `mobile` varchar(255) NOT NULL COMMENT '手机',
  `zip` varchar(255) NOT NULL COMMENT '邮编',
  `consignee` varchar(255) NOT NULL COMMENT '收货人',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为默认配送地址',
  `xpoint` varchar(255) NOT NULL COMMENT '经度',
  `ypoint` varchar(255) NOT NULL COMMENT '纬度',
  `id_card` varchar(255) DEFAULT NULL COMMENT '身份证号码',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员的收货地址';

-- ----------------------------
-- Table structure for %DB_PREFIX%user_log
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_log`;
CREATE TABLE `%DB_PREFIX%user_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_info` text NOT NULL COMMENT '日志内容',
  `log_time` int(11) NOT NULL COMMENT '发生时间',
  `log_admin_id` int(11) NOT NULL COMMENT '操作管理员的ID',
  `log_user_id` int(11) NOT NULL COMMENT '操作的前台会员ID',
  `money` double(20,4) NOT NULL COMMENT '相关的钱',
  `score` int(11) NOT NULL COMMENT '相关的积分',
  `point` int(11) NOT NULL COMMENT '相关的经验',
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `current_money` double(20,2) NOT NULL COMMENT '当前金额',
  `current_score` int(11) NOT NULL COMMENT '当前积分',
  `current_point` int(11) NOT NULL COMMENT '当前经验',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员的资金、积分、经验日志';

-- ----------------------------
-- Table structure for %DB_PREFIX%user_sign_log
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_sign_log`;
CREATE TABLE `%DB_PREFIX%user_sign_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `sign_date` int(11) NOT NULL COMMENT '签到时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员签到日志';

-- ----------------------------
-- Table structure for %DB_PREFIX%web_article
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%web_article`;
CREATE TABLE `%DB_PREFIX%web_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '文章标题',
  `content` text NOT NULL COMMENT '文章内容',
  `cate_id` int(11) NOT NULL COMMENT '文章分类ID',
  `create_time` int(11) NOT NULL COMMENT '发表时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `add_admin_id` int(11) NOT NULL COMMENT '发布人(管理员ID)',
  `is_effect` tinyint(4) NOT NULL COMMENT '有效性标识',
  `rel_url` varchar(255) NOT NULL COMMENT '自动跳转的外链',
  `update_admin_id` int(11) NOT NULL COMMENT '更新人(管理员ID)',
  `is_delete` tinyint(4) NOT NULL COMMENT '删除标识',
  `click_count` int(11) NOT NULL COMMENT '点击数',
  `sort` int(11) NOT NULL COMMENT '排序 由大到小',
  `seo_title` text NOT NULL COMMENT '自定义seo页面标题',
  `seo_keyword` text NOT NULL COMMENT '自定义seo页面keyword',
  `seo_description` text NOT NULL COMMENT '自定义seo页面标述',
  `uname` varchar(255) NOT NULL,
  `notice_page` tinyint(1) NOT NULL,
  `sub_title` varchar(255) NOT NULL,
  `brief` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`),
  KEY `create_time` (`create_time`),
  KEY `update_time` (`update_time`),
  KEY `click_count` (`click_count`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章展示';

-- ----------------------------
-- Table structure for %DB_PREFIX%web_article_cate
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%web_article_cate`;
CREATE TABLE `%DB_PREFIX%web_article_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '分类名称',
  `brief` varchar(255) NOT NULL COMMENT '分类简介(备用字段)',
  `pid` int(11) NOT NULL COMMENT '父ID，程序分类可分二级',
  `is_effect` tinyint(4) NOT NULL COMMENT '有效性标识',
  `is_delete` tinyint(4) NOT NULL COMMENT '删除标识',
  `type_id` tinyint(1) NOT NULL COMMENT '类型\r\n0:普通文章（可通前台分类列表查找到）\r\n1.帮助文章（用于前台页面底部的站点帮助）\r\n2.公告文章（用于前台页面公告模块的调用）\r\n3.系统文章（自定义的一些文章，需要前台自定义一些入口链接到该文章）\r\n所属该分类的所有文章类型与分类一致',
  `sort` int(11) NOT NULL,
  `iconfont` varchar(15) NOT NULL COMMENT '针对帮助文档分类的图标',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `type_id` (`type_id`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章分类表';

-- ----------------------------
-- Table structure for %DB_PREFIX%weixin_account
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%weixin_account`;
CREATE TABLE `%DB_PREFIX%weixin_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appid` varchar(255) NOT NULL COMMENT 'AppID(应用ID)-第三方平台指 授权方appid',
  `appsecret` varchar(255) NOT NULL COMMENT 'AppSecret(应用密钥)-第三方平台无用',
  `app_url` varchar(255) NOT NULL COMMENT 'URL(服务器地址)-第三方平台无用',
  `app_token` varchar(255) NOT NULL COMMENT 'Token(令牌)-第三方平台无用',
  `app_encodingAESKey` varchar(255) NOT NULL COMMENT 'EncodingAESKey(消息加解密密钥)-第三方平台无用',
  `authorizer_appid` varchar(255) NOT NULL COMMENT '授权方appid',
  `authorizer_access_token` varchar(255) NOT NULL COMMENT '授权方令牌-第三方平台无用',
  `expires_in` int(11) NOT NULL COMMENT '授权方令牌 有效时间-第三方平台无用',
  `authorizer_refresh_token` varchar(255) NOT NULL COMMENT '刷新令牌-第三方平台',
  `func_info` text NOT NULL COMMENT '公众号授权给开发者的权限集列表',
  `verify_type_info` tinyint(1) NOT NULL COMMENT '授权方认证类型，-1代表未认证，0代表微信认证，1代表新浪微博认证，2代表腾讯微博认证，3代表已资质认证通过但还未通过名称认证，4代表已资质认证通过、还未通过名称认证，但通过了新浪微博认证，5代表已资质认证通过、还未通过名称认证，但通过了腾讯微博认证',
  `service_type_info` tinyint(1) NOT NULL COMMENT '授权方公众号类型，0代表订阅号，1代表由历史老帐号升级后的订阅号，2代表服务号',
  `nick_name` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL COMMENT '授权方公众号的原始ID',
  `authorizer_info` varchar(255) NOT NULL COMMENT '授权方昵称',
  `head_img` varchar(255) NOT NULL COMMENT '授权方头像',
  `alias` varchar(255) NOT NULL COMMENT '授权方公众号所设置的微信号，可能为空',
  `qrcode_url` varchar(255) NOT NULL COMMENT '二维码图片的URL，开发者最好自行也进行保存',
  `location_report` tinyint(1) NOT NULL COMMENT '地理位置上报选项 0 无上报 1 进入会话时上报 2 每5s上报',
  `voice_recognize` tinyint(1) NOT NULL COMMENT '语音识别开关选项 0 关闭语音识别 1 开启语音识别',
  `customer_service` tinyint(1) NOT NULL COMMENT '客服开关选项 0 关闭多客服 1 开启多客服',
  `is_authorized` tinyint(1) NOT NULL DEFAULT '0' COMMENT '授权方是否取消授权 0表示取消授权 1表示授权',
  `user_id` int(11) NOT NULL COMMENT '商户ID ，诺type为1，user_id 为空',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 表示前台商户会员 1 表示后台管理员',
  `industry_1` int(11) NOT NULL,
  `industry_1_status` tinyint(1) NOT NULL,
  `industry_2` int(11) NOT NULL,
  `industry_2_status` tinyint(1) NOT NULL,
  `test_user` varchar(255) DEFAULT NULL COMMENT '测试微信号',
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `authorizer_appid` (`authorizer_appid`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `appid` (`appid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='//微信公众号列表';

-- ----------------------------
-- Table structure for %DB_PREFIX%weixin_account_conf
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%weixin_account_conf`;
CREATE TABLE `%DB_PREFIX%weixin_account_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `group_id` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '配置输入的类型 0:文本输入 1:下拉框输入 2:图片上传 3:编辑器',
  `value_scope` text NOT NULL COMMENT '取值范围',
  `is_require` tinyint(1) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `is_conf` tinyint(1) NOT NULL COMMENT '是否可配置 0: 可配置  1:不可配置',
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='微信账号配置选项';

-- ----------------------------
-- Records of %DB_PREFIX%weixin_account_conf
-- ----------------------------
INSERT INTO `%DB_PREFIX%weixin_account_conf` VALUES ('1', 'AppID(应用ID)', 'appid', '', '0', '0', '', '0', '1', '1', '1');
INSERT INTO `%DB_PREFIX%weixin_account_conf` VALUES ('2', 'AppSecret(应用密钥)', 'appsecret', '', '0', '0', '', '0', '1', '1', '2');
INSERT INTO `%DB_PREFIX%weixin_account_conf` VALUES ('3', 'Token(令牌)', 'token', '', '0', '0', '', '0', '1', '1', '3');
INSERT INTO `%DB_PREFIX%weixin_account_conf` VALUES ('4', 'EncodingAESKey(消息加解密密钥)', 'encodingAesKey', '', '0', '0', '', '0', '1', '1', '4');
INSERT INTO `%DB_PREFIX%weixin_account_conf` VALUES ('5', 'industry_1', 'industry_1', '', '0', '0', '', '0', '0', '1', '4');
INSERT INTO `%DB_PREFIX%weixin_account_conf` VALUES ('6', 'industry_1_status', 'industry_1_status', '', '0', '0', '', '0', '0', '1', '4');
INSERT INTO `%DB_PREFIX%weixin_account_conf` VALUES ('7', 'industry_2', 'industry_2', '', '0', '0', '', '0', '0', '1', '4');
INSERT INTO `%DB_PREFIX%weixin_account_conf` VALUES ('8', 'industry_2_status', 'industry_2_status', '', '0', '0', '', '0', '0', '1', '4');
INSERT INTO `%DB_PREFIX%weixin_account_conf` VALUES ('9', '移动应用AppID', 'mappid', '', '0', '0', '', '0', '1', '1', '0');
INSERT INTO `%DB_PREFIX%weixin_account_conf` VALUES ('10', '移动应用AppSecret', 'mappsecret', '', '0', '0', '', '0', '1', '1', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%weixin_api_get_record`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%weixin_api_get_record`;
CREATE TABLE `%DB_PREFIX%weixin_api_get_record` (
  `openid` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`openid`),
  KEY `account_id` (`account_id`),
  KEY `idx_0` (`account_id`,`create_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='请求的用户记录';

-- ----------------------------
-- Table structure for %DB_PREFIX%weixin_conf
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%weixin_conf`;
CREATE TABLE `%DB_PREFIX%weixin_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `group_id` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '配置输入的类型 0:文本输入 1:下拉框输入 2:图片上传 3:编辑器',
  `value_scope` text NOT NULL COMMENT '取值范围',
  `is_require` tinyint(1) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `is_conf` tinyint(1) NOT NULL COMMENT '是否可配置 0: 可配置  1:不可配置',
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='微信配置选项';

-- ----------------------------
-- Records of %DB_PREFIX%weixin_conf
-- ----------------------------
INSERT INTO `%DB_PREFIX%weixin_conf` VALUES ('1', '第三方平台appid', 'platform_appid', '', '0', '0', '', '0', '1', '1', '1');
INSERT INTO `%DB_PREFIX%weixin_conf` VALUES ('2', '公众号消息校验Token', 'platform_token', 'AhpZT', '0', '0', '', '0', '1', '1', '2');
INSERT INTO `%DB_PREFIX%weixin_conf` VALUES ('3', '公众号消息加解密Key', 'platform_encodingAesKey', 'qY4kH6eDqfB0spLb81Nmi4jhi2n9ZRCGG276fwt91NL', '0', '0', '', '0', '1', '1', '3');
INSERT INTO `%DB_PREFIX%weixin_conf` VALUES ('4', '是否开启第三方平台', 'platform_status', '0', '0', '4', '0,1', '0', '1', '1', '4');
INSERT INTO `%DB_PREFIX%weixin_conf` VALUES ('5', '第三方平台AppSecret', 'platform_appsecret', '', '0', '0', '', '0', '1', '1', '1');
INSERT INTO `%DB_PREFIX%weixin_conf` VALUES ('6', 'component_verify_ticket', 'platform_component_verify_ticket', '0', '0', '0', '', '0', '1', '0', '6');
INSERT INTO `%DB_PREFIX%weixin_conf` VALUES ('7', '第三方平台access_token', 'platform_component_access_token', '0', '0', '0', '', '0', '1', '0', '7');
INSERT INTO `%DB_PREFIX%weixin_conf` VALUES ('8', '第三方平台预授权码', 'platform_pre_auth_code', '0', '0', '0', '', '0', '1', '0', '8');
INSERT INTO `%DB_PREFIX%weixin_conf` VALUES ('9', '第三方平台access_token有效期', 'platform_component_access_token_expire', '0', '0', '0', '', '0', '1', '0', '9');
INSERT INTO `%DB_PREFIX%weixin_conf` VALUES ('10', '第三方平台预授权码有效期', 'platform_pre_auth_code_expire', '0', '0', '0', '', '0', '1', '0', '10');
INSERT INTO `%DB_PREFIX%weixin_conf` VALUES ('11', '是否已全网发布', 'platform_all_publish', '0', '0', '4', '0,1', '0', '1', '1', '11');

-- ----------------------------
-- Table structure for `%DB_PREFIX%weixin_nav`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%weixin_nav`;
CREATE TABLE `%DB_PREFIX%weixin_nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '' COMMENT '菜单名称',
  `sort` int(11) DEFAULT '0' COMMENT '菜单排序 大->小',
  `event_type` enum('click') DEFAULT 'click' COMMENT '按钮的事件，目前微信只支持click',
  `account_id` int(11) DEFAULT '0' COMMENT '商户ID,0表示平台',
  `status` tinyint(1) DEFAULT '0' COMMENT '是否已推送到微信(0:未推送或失败 1:成功)，该列同一个商家全部相同，菜单为一次性推送,对菜单本地修改时，批量更新该值为0',
  `pid` int(11) DEFAULT '0',
  `ctl` varchar(255) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sort` (`sort`),
  KEY `event_type` (`event_type`),
  KEY `account_id` (`account_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='为微信自定义的菜单设置';

-- ----------------------------
-- Table structure for %DB_PREFIX%weixin_reply
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%weixin_reply`;
CREATE TABLE `%DB_PREFIX%weixin_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `i_msg_type` enum('event','link','location','image','text') DEFAULT 'text' COMMENT '接收到的微信的推送到本系统api中的MsgType',
  `o_msg_type` enum('news','music','text') DEFAULT 'text' COMMENT '用于响应并回复给微信推送的消息类型 news:图文 music:音乐 text:纯文本',
  `keywords` varchar(300) DEFAULT NULL COMMENT '用于响应文本(i_msg_type:text或者i_event:click时对key的响应)类型的回复时进行匹配的关键词',
  `keywords_match` text COMMENT 'keywords的全文索引列',
  `keywords_match_row` text COMMENT 'keywords全文索引的未作unicode编码的原文，用于开发者查看',
  `address` text COMMENT '用于显示的地理地址',
  `api_address` text COMMENT '用于地理定位的API地址',
  `x_point` varchar(100) DEFAULT '' COMMENT '用于lbs消息,i_msg_type:location 匹配的经度',
  `y_point` varchar(100) DEFAULT '' COMMENT '用于lbs消息,i_msg_type:location 匹配的纬度',
  `scale_meter` int(11) DEFAULT '0' COMMENT '用于lbs消息,i_msg_type:location 匹配的距离范围(米)',
  `i_event` enum('subscribe','unsubscribe','click','empty') DEFAULT 'empty' COMMENT '用于响应i_msg_type为event时的对应事件',
  `reply_content` text COMMENT '回复的文本消息',
  `reply_music` varchar(255) DEFAULT '' COMMENT '回复的音乐链接',
  `reply_news_title` text COMMENT '图文回复的标题',
  `reply_news_description` text COMMENT '图文回复的描述',
  `reply_news_picurl` varchar(255) DEFAULT '' COMMENT '图文回复的图片链接',
  `reply_news_url` varchar(255) DEFAULT '' COMMENT '图文回复的跳转链接',
  `reply_news_content` text,
  `type` tinyint(1) DEFAULT '0' COMMENT '回复归类 \r\n0:普通的回复 \r\n1:默认回复(只能一条文本或图文) \r\n4.关注时回复(只能有一条文本或图文) ',
  `account_id` int(11) DEFAULT '0' COMMENT '所属的商家ID',
  `default_close` tinyint(1) DEFAULT '1' COMMENT '默认回复是否关闭 0：关闭 1：开启',
  `match_type` tinyint(1) NOT NULL DEFAULT '0',
  `ctl` varchar(255) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `i_msg_type` (`i_msg_type`),
  KEY `o_msg_type` (`o_msg_type`),
  KEY `i_event` (`i_event`),
  KEY `type` (`type`),
  KEY `account_id` (`account_id`),
  KEY `match_type` (`account_id`,`match_type`,`keywords`),
  FULLTEXT KEY `keywords_match` (`keywords_match`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='商家回复设置表';

-- ----------------------------
-- Table structure for %DB_PREFIX%weixin_reply_relate
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%weixin_reply_relate`;
CREATE TABLE `%DB_PREFIX%weixin_reply_relate` (
  `main_reply_id` int(11) DEFAULT '0' COMMENT '主回复ID',
  `relate_reply_id` int(11) DEFAULT '0' COMMENT '关联的多图文用的子回复ID',
  `sort` tinyint(1) DEFAULT '0',
  KEY `main_reply_id` (`main_reply_id`),
  KEY `relate_reply_id` (`relate_reply_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='多图文回复的关联配置';

-- ----------------------------
-- Table structure for %DB_PREFIX%weixin_tmpl
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%weixin_tmpl`;
CREATE TABLE `%DB_PREFIX%weixin_tmpl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '' COMMENT '模板名称',
  `msg` text COMMENT '模板内容',
  `template_id` varchar(255) DEFAULT NULL COMMENT '模板ID',
  `template_id_short` varchar(255) DEFAULT NULL COMMENT '模板编号',
  `account_id` int(11) DEFAULT '0' COMMENT '所属的商家ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='微信模板';

-- ----------------------------
-- Table structure for %DB_PREFIX%weixin_user
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%weixin_user`;
CREATE TABLE `%DB_PREFIX%weixin_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL COMMENT '商家ID,平台级为0',
  `subscribe` tinyint(1) NOT NULL COMMENT '用户是否订阅该公众号标识，值为0时，代表此用户没有关注该公众号，拉取不到其余信息。',
  `openid` varchar(255) NOT NULL COMMENT '用户的标识，对当前公众号唯一',
  `nickname` varchar(255) NOT NULL,
  `sex` tinyint(1) NOT NULL COMMENT '用户的性别，值为1时是男性，值为2时是女性，值为0时是未知',
  `city` varchar(255) NOT NULL,
  `country` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `language` varchar(20) DEFAULT NULL,
  `headimgurl` varchar(255) DEFAULT NULL,
  `subscribe_time` varchar(255) DEFAULT NULL COMMENT '用户关注时间，为时间戳。如果用户曾多次关注，则取最后关注时间',
  `unionid` varchar(255) DEFAULT NULL COMMENT '只有在用户将公众号绑定到微信开放平台帐号后，才会出现该字段。',
  `remark` varchar(255) DEFAULT NULL COMMENT '公众号运营者对粉丝的备注，公众号运营者可在微信公众平台用户管理界面对粉丝添加备注',
  `groupid` int(11) DEFAULT NULL COMMENT '用户所在的分组ID',
  `union_id` varchar(255) DEFAULT NULL,
  `m_openid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`account_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='//微信公众号会员列表';

-- ----------------------------
-- Table structure for %DB_PREFIX%withdraw
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%withdraw`;
CREATE TABLE `%DB_PREFIX%withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `money` decimal(20,4) NOT NULL COMMENT '提现金额',
  `create_time` int(11) NOT NULL,
  `is_paid` tinyint(1) NOT NULL COMMENT '是否已确认',
  `pay_time` int(11) NOT NULL COMMENT '确认支付时间',
  `bank_name` varchar(255) NOT NULL COMMENT '开户行名称',
  `bank_account` varchar(255) NOT NULL COMMENT '开户行账号',
  `bank_user` varchar(255) NOT NULL COMMENT '开户行会员名',
  `is_delete` tinyint(1) NOT NULL,
  `bank_mobile` varchar(255) NOT NULL COMMENT '银行预留手机号',
  `is_bind` tinyint(1) NOT NULL COMMENT '是否绑定',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
