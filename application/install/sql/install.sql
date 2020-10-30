/*
Navicat MySQL Data Transfer
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for yt_article
-- ----------------------------
DROP TABLE IF EXISTS `yt_article`;
CREATE TABLE `yt_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` tinyint(1) NOT NULL DEFAULT '0' COMMENT '文章类型',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '系统用户',
  `title` varchar(255) NOT NULL COMMENT '文章标题',
  `cover_img` varchar(255) DEFAULT NULL COMMENT '文章封面',
  `describe` varchar(255) DEFAULT NULL COMMENT '文章描述',
  `content` mediumtext NOT NULL COMMENT '文章内容',
  `recommend` int(10) DEFAULT '0' COMMENT '推荐级别',
  `praise` int(11) DEFAULT '0' COMMENT '点赞量',
  `clicks` int(10) DEFAULT '0' COMMENT '点击量',
  `sort` int(10) DEFAULT '0' COMMENT '排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `is_open` tinyint(1) DEFAULT '1' COMMENT '是否公开 (0：否，1：是）',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` int(10) DEFAULT '0' COMMENT '创建人',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` int(10) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `index_yt_article_title` (`title`) USING BTREE,
  KEY `index_yt_article_sort` (`sort`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统文章表';

-- ----------------------------
-- Table structure for yt_article_tag
-- ----------------------------
DROP TABLE IF EXISTS `yt_article_tag`;
CREATE TABLE `yt_article_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL COMMENT '文章编号',
  `tag_id` int(11) NOT NULL COMMENT '标签编号',
  PRIMARY KEY (`id`),
  KEY `index_yt_article_tag_article_id` (`article_id`) USING BTREE,
  KEY `index_yt_article_tag_tag_id` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='文章标签关联表';

-- ----------------------------
-- Table structure for yt_category
-- ----------------------------
DROP TABLE IF EXISTS `yt_category`;
CREATE TABLE `yt_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL COMMENT '栏目标题',
  `image` varchar(20) DEFAULT NULL COMMENT '栏目图片',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态(0：正常，1：禁用)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` int(10) DEFAULT '0' COMMENT '创建人',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` int(10) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `index_yt_nav_title` (`title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统文章栏目表';

-- ----------------------------
-- Records of yt_category
-- ----------------------------
INSERT INTO `yt_category` VALUES ('1', '技术杂谈', null, null, '6', '0', '2018-08-10 16:58:32', '0', null, null);
INSERT INTO `yt_category` VALUES ('2', 'PHP开发', null, null, '4', '0', '2018-08-10 16:58:43', '0', null, null);
INSERT INTO `yt_category` VALUES ('3', 'JAVA开发', null, null, '0', '0', '2018-08-10 16:58:49', '0', null, null);
INSERT INTO `yt_category` VALUES ('4', 'Linux运维', null, null, '0', '0', '2018-08-10 16:58:56', '0', null, null);
INSERT INTO `yt_category` VALUES ('5', 'Python开发', null, null, '0', '0', '2018-08-11 01:42:41', '0', null, null);
INSERT INTO `yt_category` VALUES ('6', 'Mysql数据库', null, '', '0', '0', '2018-08-11 01:43:09', '0', null, null);

-- ----------------------------
-- Table structure for yt_comment
-- ----------------------------
DROP TABLE IF EXISTS `yt_comment`;
CREATE TABLE `yt_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(10) NOT NULL COMMENT '文章编号',
  `member_id` int(11) NOT NULL COMMENT '会员标号',
  `content` varchar(1000) NOT NULL COMMENT '评论内容',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `index_yt_comment_article_id` (`article_id`) USING BTREE,
  KEY `index_yt_comment_member_id` (`member_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='文章评论表';

-- ----------------------------
-- Records of yt_comment
-- ----------------------------
INSERT INTO `yt_comment` VALUES ('67', '25', '1', '<p>哈哈</p>', null, '0', '0', '2018-09-06 02:59:26');
INSERT INTO `yt_comment` VALUES ('71', '38', '1', '<p>我就评论了</p>', null, '0', '0', '2018-10-11 20:59:06');

-- ----------------------------
-- Table structure for yt_config
-- ----------------------------
DROP TABLE IF EXISTS `yt_config`;
CREATE TABLE `yt_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) NOT NULL DEFAULT '' COMMENT '分组',
  `type` varchar(30) NOT NULL DEFAULT 'string' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `value` text NOT NULL COMMENT '变量值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注信息',
  `sort` int(10) DEFAULT '0',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT '0' COMMENT '创建人',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `group` (`group`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统配置';

-- ----------------------------
-- Table structure for yt_follow
-- ----------------------------
DROP TABLE IF EXISTS `yt_follow`;
CREATE TABLE `yt_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_pid` int(11) DEFAULT NULL COMMENT '被关注人',
  `member_id` int(11) DEFAULT NULL COMMENT '关注人',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态(0：已关注，1：取消关注）',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- ----------------------------
-- Records of yt_follow
-- ----------------------------

-- ----------------------------
-- Table structure for yt_login_record
-- ----------------------------
DROP TABLE IF EXISTS `yt_login_record`;
CREATE TABLE `yt_login_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) DEFAULT '1' COMMENT '登录类型（0：退出，1：登录）',
  `member_id` int(11) DEFAULT NULL COMMENT '会员ID',
  `ip` varchar(255) DEFAULT NULL COMMENT '登录IP地址',
  `country` varchar(50) DEFAULT NULL COMMENT '国家',
  `region` varchar(50) DEFAULT NULL COMMENT '省份',
  `city` varchar(50) DEFAULT NULL COMMENT '城市',
  `isp` varchar(50) DEFAULT NULL COMMENT '网络类型',
  `location` varchar(100) DEFAULT NULL COMMENT '地址',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统会员登录记录';

-- ----------------------------
-- Table structure for yt_member
-- ----------------------------
DROP TABLE IF EXISTS `yt_member`;
CREATE TABLE `yt_member` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `openid` varchar(100) DEFAULT '' COMMENT '用户的标识，对当前网站唯一',
  `nickname` varchar(255) DEFAULT NULL COMMENT '别称',
  `username` varchar(20) DEFAULT NULL COMMENT '用户名',
  `password` varchar(40) DEFAULT NULL COMMENT '密码',
  `head_img` varchar(100) DEFAULT '/static/image/blog/face_default.jpg' COMMENT '用户头像',
  `phone` varchar(15) DEFAULT NULL COMMENT '手机号',
  `email` varchar(30) DEFAULT NULL COMMENT '邮箱',
  `job` varchar(20) DEFAULT NULL COMMENT '职位',
  `sex` tinyint(1) DEFAULT '0' COMMENT '性别（0：男，1：女）',
  `year` int(20) DEFAULT NULL COMMENT '出生年份',
  `sign` varchar(255) DEFAULT NULL COMMENT '个性签名',
  `province` varchar(100) DEFAULT '' COMMENT '所在省份',
  `city` varchar(100) DEFAULT '' COMMENT '所在城市',
  `location` varchar(255) DEFAULT NULL COMMENT '工作位置',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `source` tinyint(1) DEFAULT '0' COMMENT '注册来源',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否有删除',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` int(10) DEFAULT '0' COMMENT '创建人',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` int(10) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `index_yt_member_nickname` (`nickname`) USING BTREE,
  KEY `index_yt_member_username` (`username`) USING BTREE,
  KEY `index_yt_member_phone` (`phone`),
  KEY `index_yt_member_email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统用户表';

-- ----------------------------
-- Records of yt_member
-- ----------------------------
INSERT INTO `yt_member` VALUES ('11', '', '测试1', 'ceshi1', 'ed696eb5bba1f7460585cc6975e6cf9bf24903dd', '/static/image/face.png', '13659797499', '223@qq.com', null, '0', null, null, '', '', null, '', '0', '0', '1', '2018-10-10 15:54:35', '0', null, null);
INSERT INTO `yt_member` VALUES ('12', '', '测试2', 'ceshi2', 'ed696eb5bba1f7460585cc6975e6cf9bf24903dd', 'https://static.ytwlSystemForOa.cn/817665ed87824a76af9b997081d87cf7.jpg', '15521045869', '', null, '0', null, null, '', '', null, '', '0', '0', '0', '2018-10-17 01:47:35', '0', null, null);

-- ----------------------------
-- Table structure for yt_member_follow
-- ----------------------------
DROP TABLE IF EXISTS `yt_member_follow`;
CREATE TABLE `yt_member_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) DEFAULT NULL COMMENT '会员编号',
  `follow_num` int(11) DEFAULT '0' COMMENT '关注数量',
  `fans_num` int(11) DEFAULT '0' COMMENT '粉丝数量',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- ----------------------------
-- Table structure for yt_msg_record
-- ----------------------------
DROP TABLE IF EXISTS `yt_msg_record`;
CREATE TABLE `yt_msg_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) DEFAULT '0' COMMENT '信息类型(0：验证码）',
  `send_type` tinyint(1) DEFAULT '1' COMMENT '联系方式类型（0：手机号，1：邮箱）',
  `send` varchar(30) DEFAULT NULL COMMENT '联系方式',
  `message` varchar(255) NOT NULL COMMENT '信息内容',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `index_yt_msg_record_send` (`send`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='短信发送记录表';

-- ----------------------------
-- Table structure for yt_notice
-- ----------------------------
DROP TABLE IF EXISTS `yt_notice`;
CREATE TABLE `yt_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL COMMENT '标题',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `href` varchar(100) DEFAULT NULL COMMENT '链接',
  `target` varchar(10) DEFAULT '_blank' COMMENT '弹出方式',
  `sort` int(10) DEFAULT '0' COMMENT '排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` int(10) DEFAULT '0' COMMENT '创建人',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` int(10) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `index_yt_notice_title` (`title`) USING BTREE,
  KEY `idex_yt_notice_sort` (`sort`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统公告表';

-- ----------------------------
-- Table structure for yt_search
-- ----------------------------
DROP TABLE IF EXISTS `yt_search`;
CREATE TABLE `yt_search` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(255) DEFAULT NULL COMMENT '搜索关键词',
  `total` int(11) DEFAULT '0' COMMENT '搜索总次数',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='搜索统计表';

-- ----------------------------
-- Records of yt_search
-- ----------------------------
INSERT INTO `yt_search` VALUES ('14', 'git', '4', '2018-10-22 18:23:05', '2018-08-30 13:29:53');
INSERT INTO `yt_search` VALUES ('15', 'php', '37', '2018-10-29 22:21:17', '2018-08-30 13:38:35');
INSERT INTO `yt_search` VALUES ('16', 'css', '2', '2018-08-30 13:37:40', '2018-08-30 13:39:11');
INSERT INTO `yt_search` VALUES ('17', 'mysql', '1', null, '2018-08-30 13:39:20');
INSERT INTO `yt_search` VALUES ('18', '索引', '1', null, '2018-08-30 13:39:27');
INSERT INTO `yt_search` VALUES ('19', '索引用法', '2', '2018-08-30 13:43:11', '2018-08-30 13:39:35');
INSERT INTO `yt_search` VALUES ('20', 'sdsd', '1', null, '2018-09-21 00:01:07');
INSERT INTO `yt_search` VALUES ('21', '646', '20', '2018-10-29 22:15:38', '2018-10-29 22:13:01');

-- ----------------------------
-- Table structure for yt_search_record
-- ----------------------------
DROP TABLE IF EXISTS `yt_search_record`;
CREATE TABLE `yt_search_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) DEFAULT '0' COMMENT '搜索类型（0：未知，1：标题，2：标签）',
  `word` varchar(255) DEFAULT NULL COMMENT '搜索关键词',
  `member_id` int(11) DEFAULT '0' COMMENT '登录会员编号（0：游客）',
  `ip` varchar(255) DEFAULT '' COMMENT 'ip地址',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='搜索记录表';

-- ----------------------------
-- Records of yt_search_record
-- ----------------------------
INSERT INTO `yt_search_record` VALUES ('6', '2', 'php', '0', '127.0.0.1', '正在搜索文章！', '2018-08-30 12:59:43');
INSERT INTO `yt_search_record` VALUES ('7', '2', 'mysql', '0', '127.0.0.1', '正在搜索文章！', '2018-08-30 13:00:05');
INSERT INTO `yt_search_record` VALUES ('8', '2', 'redis', '0', '127.0.0.1', '正在搜索文章！', '2018-08-30 13:01:04');

-- ----------------------------
-- Table structure for yt_slider
-- ----------------------------
DROP TABLE IF EXISTS `yt_slider`;
CREATE TABLE `yt_slider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) DEFAULT NULL COMMENT '标题',
  `image` text NOT NULL COMMENT '轮播图片',
  `href` varchar(100) DEFAULT NULL COMMENT '轮播图片链接',
  `target` varchar(10) DEFAULT '_blank' COMMENT '弹出方式',
  `sort` int(10) DEFAULT '0' COMMENT '排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` int(10) DEFAULT '0' COMMENT '创建人',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` int(10) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `index_yt_slider_title` (`title`) USING BTREE,
  KEY `index_yt_slider_sort` (`sort`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统轮播图';

-- ----------------------------
-- Records of yt_slider
-- ----------------------------
INSERT INTO `yt_slider` VALUES ('1', '轮播图1', 'https://static.ytwlSystemForOa.cn/slide1.jpg', 'https://www.baidu.com', '_blank', '3', null, '0', '2018-08-10 16:17:20', null, null, null);
INSERT INTO `yt_slider` VALUES ('2', '轮播图2', 'https://static.ytwlSystemForOa.cn/slide2.jpg', 'https://www.ytwlSystemForOa.cn', '_blank', '2', null, '0', '2018-08-10 16:17:42', null, null, null);
INSERT INTO `yt_slider` VALUES ('3', '轮播图3', 'https://static.ytwlSystemForOa.cn/slide3.jpg', 'admin/auth/index', '_blank', '0', '', '0', '2018-08-10 16:53:18', '0', null, null);

-- ----------------------------
-- Table structure for yt_tag
-- ----------------------------
DROP TABLE IF EXISTS `yt_tag`;
CREATE TABLE `yt_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_title` varchar(20) NOT NULL COMMENT '标签标题',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` int(10) DEFAULT '0' COMMENT '创建人',
  PRIMARY KEY (`id`),
  KEY `index_yt_tag_title` (`tag_title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统标签表';

-- ----------------------------
-- Records of yt_tag
-- ----------------------------
INSERT INTO `yt_tag` VALUES ('4', 'PHP', null, '0', '2018-08-11 03:09:16', '0');
INSERT INTO `yt_tag` VALUES ('15', 'Compare4', null, '0', '2018-09-03 15:23:04', '0');
INSERT INTO `yt_tag` VALUES ('16', '七牛云', null, '0', '2018-09-20 03:27:23', '0');


-- ----------------------------
-- Table structure for yt_website_link
-- ----------------------------
DROP TABLE IF EXISTS `yt_website_link`;
CREATE TABLE `yt_website_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `website_name` varchar(255) DEFAULT NULL COMMENT '站点名称',
  `website_logo` varchar(500) DEFAULT NULL COMMENT '网站LOGO',
  `href` varchar(500) DEFAULT '#' COMMENT '链接地址',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `sort` int(255) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='站点友链';

-- ----------------------------
-- Records of yt_website_link
-- ----------------------------
INSERT INTO `yt_website_link` VALUES ('1', '百度一下', null, 'https://www.baidu.com', null, '2', '0', '2018-08-29 12:30:32');
INSERT INTO `yt_website_link` VALUES ('2', 'hao123', null, 'https://www.hao123.com', '', '1', '0', '2018-08-29 12:31:44');

-- ----------------------------
-- Table structure for email_template
-- ----------------------------
DROP TABLE IF EXISTS `email_template`;
CREATE TABLE `email_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) DEFAULT '0' COMMENT '类型 (1：注册，2：找回密码）',
  `name` varchar(255) DEFAULT NULL COMMENT '模板名称',
  `value` varchar(255) DEFAULT NULL COMMENT '模板内容',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='短信模板';

-- ----------------------------
-- Records of email_template
-- ----------------------------
INSERT INTO `email_template` VALUES ('2', '1', '注册验证码', '您正在申请手机注册，验证码为：${code}，5分钟内有效！', null, '2018-09-04 17:39:28');

-- ----------------------------
-- Table structure for sms_template
-- ----------------------------
DROP TABLE IF EXISTS `sms_template`;
CREATE TABLE `sms_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) DEFAULT '0' COMMENT '类型 (1：注册，2：找回密码）',
  `name` varchar(255) DEFAULT NULL COMMENT '模板名称',
  `value` varchar(255) DEFAULT NULL COMMENT '模板内容',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='短信模板';

-- ----------------------------
-- Records of sms_template
-- ----------------------------
INSERT INTO `sms_template` VALUES ('1', '1', 'SMS_134075338', '您正在申请手机注册，验证码为：${code}，5分钟内有效！', null, '2018-09-01 00:18:10');

-- ----------------------------
-- Table structure for system_auth
-- ----------------------------
DROP TABLE IF EXISTS `system_auth`;
CREATE TABLE `system_auth` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL COMMENT '权限名称',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `sort` smallint(6) unsigned DEFAULT '0' COMMENT '排序权重',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_by` bigint(11) unsigned DEFAULT '0' COMMENT '创建人',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` timestamp NULL DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_system_auth_title` (`title`) USING BTREE,
  KEY `index_system_auth_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统权限表';

-- ----------------------------
-- Records of system_auth
-- ----------------------------
INSERT INTO `system_auth` VALUES ('1', '管理员', '1', '4', '测试管理员', '0', '2018-03-17 15:59:46', '2018-08-07 10:26:57', null);
INSERT INTO `system_auth` VALUES ('4', '超级管理员', '0', '1', '不受权限控制', '0', '2018-01-23 13:28:14', null, null);
INSERT INTO `system_auth` VALUES ('6', '测试权限', '1', '0', '4242543', '0', '2018-09-22 18:15:31', null, null);

-- ----------------------------
-- Table structure for system_auth_node
-- ----------------------------
DROP TABLE IF EXISTS `system_auth_node`;
CREATE TABLE `system_auth_node` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `auth` bigint(20) unsigned DEFAULT NULL COMMENT '角色ID',
  `node` varchar(200) DEFAULT NULL COMMENT '节点路径',
  PRIMARY KEY (`id`),
  KEY `index_system_auth_auth` (`auth`) USING BTREE,
  KEY `index_system_auth_node` (`node`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=381 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色与节点关系表';

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) NOT NULL DEFAULT '' COMMENT '分组',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `value` text NOT NULL COMMENT '变量值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注信息',
  `sort` int(10) DEFAULT '0',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT '0' COMMENT '创建人',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统配置';

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES ('1', 'ManageName', 'basic', 'string', 'YtwlSystemForOA', '后台名称', '0', '2018-07-17 17:27:27', '0', '2018-07-17 22:10:33', null);
INSERT INTO `system_config` VALUES ('2', 'Beian', 'basic', 'string', '冀ICP备12018451号 ', '备案号', '4', '2018-07-17 17:27:27', '0', '2018-07-17 22:10:39', null);
INSERT INTO `system_config` VALUES ('3', 'FooterName', 'basic', 'string', 'Copyright © 2018-2019 垣通网络科技', '底部网站标识', '5', '2018-07-17 17:27:27', '0', '2018-07-17 18:40:16', null);
INSERT INTO `system_config` VALUES ('4', 'BeianUrl', 'basic', 'string', 'http://www.miitbeian.gov.cn', '备案查询链接', '2', '2018-07-17 17:30:39', '0', '2018-07-17 17:31:22', null);
INSERT INTO `system_config` VALUES ('5', 'HomeUrl', 'basic', 'string', 'https://www.zjkytwl.com', '网站首页', '0', '2018-07-17 18:45:59', '0', '2018-07-17 18:46:12', null);
INSERT INTO `system_config` VALUES ('6', 'VercodeType', 'basic', 'tinyint', '0', '验证码登录开关（0：不开启，1：开启）', '3', '2018-07-17 21:52:00', '0', '2018-07-18 02:38:10', null);
INSERT INTO `system_config` VALUES ('7', 'Describe', 'basic', 'string', 'RBAC后台权限控制系统', '网站描述', '9', '2018-07-30 23:01:34', '0', null, null);
INSERT INTO `system_config` VALUES ('8', 'Author', 'basic', 'string', '', '作者', '15', '2018-07-30 23:02:41', '0', null, null);
INSERT INTO `system_config` VALUES ('9', 'Email', 'basic', 'string', 'server@52zjk.cn', '联系邮箱', '8', '2018-07-30 23:03:15', '0', null, null);
INSERT INTO `system_config` VALUES ('10', 'MailHost', 'mail', 'string', 'smtp.163.com', '发送方的SMTP服务器地址', '0', '2018-08-31 15:39:04', '0', null, null);
INSERT INTO `system_config` VALUES ('11', 'MailUsername', 'mail', 'string', '', '发送方的QQ邮箱用户名', '0', '2018-08-31 15:39:43', '0', null, null);
INSERT INTO `system_config` VALUES ('12', 'MailPassword', 'mail', 'string', '', '第三方授权登录码', '0', '2018-08-31 15:39:53', '0', null, null);
INSERT INTO `system_config` VALUES ('13', 'MailNickname', 'mail', 'string', '垣通网络科技', '设置发件人昵称', '0', '2018-08-31 15:40:44', '0', null, null);
INSERT INTO `system_config` VALUES ('14', 'MailReplyTo', 'mail', 'string', 'server@52zjk.cn', '回复邮件地址', '0', '2018-08-31 15:41:03', '0', null, null);
INSERT INTO `system_config` VALUES ('15', 'AccessKeyId', 'sms', 'string', '', '阿里大于公钥', '0', '2018-08-31 23:58:34', '0', null, null);
INSERT INTO `system_config` VALUES ('16', 'AccessKeySecret', 'sms', 'string', '', '阿里大鱼私钥', '0', '2018-08-31 23:58:45', '0', null, null);
INSERT INTO `system_config` VALUES ('17', 'SignName', 'sms', 'string', '垣通网络', '短信注册模板', '0', '2018-09-01 00:08:55', '0', null, null);
INSERT INTO `system_config` VALUES ('18', 'CodeTime', 'code', 'int', '60', '验证码发送间隔时间', '0', '2018-09-04 18:03:52', '0', null, null);
INSERT INTO `system_config` VALUES ('19', 'CodeDieTime', 'code', 'int', '300', '验证码有效期', '0', '2018-09-04 18:17:26', '0', null, null);
INSERT INTO `system_config` VALUES ('20', 'FileType', 'file', 'int', '1', '文件保存方法（1：本地，2：七牛云）', '0', '2018-09-17 11:44:12', '0', null, null);
INSERT INTO `system_config` VALUES ('21', 'FileKey', 'file', 'string', '', '文件路径加密秘钥', '0', '2018-09-17 16:51:29', '0', null, null);
INSERT INTO `system_config` VALUES ('22', 'LoginDuration', 'basic', 'int', '7200', '后台登录有效时间', '0', '2018-09-30 01:02:53', '0', null, null);
INSERT INTO `system_config` VALUES ('23', 'AdminModuleName', 'basic', 'int', 'admin', '后台登录模块名', '0', '2018-10-01 01:22:05', '0', null, null);
INSERT INTO `system_config` VALUES ('24', 'CleanCachePassword', 'basic', 'string', 'YtwlSystemForOA', '刷新缓存的密码', '0', '2018-10-01 01:42:16', '0', null, null);

-- ----------------------------
-- Table structure for system_login_record
-- ----------------------------
DROP TABLE IF EXISTS `system_login_record`;
CREATE TABLE `system_login_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) DEFAULT '1' COMMENT '登录类型（0：退出，1：登录）',
  `user_id` int(11) DEFAULT NULL COMMENT '系统用户ID（0：账户不存在）',
  `ip` varchar(255) DEFAULT NULL COMMENT '登录IP地址',
  `country` varchar(50) DEFAULT NULL COMMENT '国家',
  `region` varchar(50) DEFAULT NULL COMMENT '省份',
  `city` varchar(50) DEFAULT NULL COMMENT '城市',
  `isp` varchar(50) DEFAULT NULL COMMENT '网络类型',
  `location` varchar(100) DEFAULT NULL COMMENT '地址',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态（0：失败，1：成功）',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=444 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员登录记录';

-- ----------------------------
-- Table structure for system_menu
-- ----------------------------
DROP TABLE IF EXISTS `system_menu`;
CREATE TABLE `system_menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父id',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `spread` tinyint(1) DEFAULT '0',
  `node` varchar(200) NOT NULL DEFAULT '' COMMENT '节点代码',
  `icon` varchar(100) NOT NULL DEFAULT '' COMMENT '菜单图标',
  `href` varchar(400) NOT NULL DEFAULT '' COMMENT '链接',
  `params` varchar(500) DEFAULT '' COMMENT '链接参数',
  `target` varchar(20) NOT NULL DEFAULT '_self' COMMENT '链接打开方式',
  `sort` float(11,2) DEFAULT '0.00' COMMENT '菜单排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `remark` varchar(255) DEFAULT NULL,
  `create_by` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` timestamp NULL DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_system_menu_node` (`node`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=227 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统菜单表';

-- ----------------------------
-- Records of system_menu
-- ----------------------------
INSERT INTO `system_menu` VALUES (1, 0, '后台首页', 0, '', '&#xe68e;', 'admin/index/welcome', '', '_self', 0.00, 1, '', 0, '2018-7-21 13:28:32', NULL, NULL);
INSERT INTO `system_menu` VALUES (142, 0, '系统设置', 0, '', '&#xe620;', '#', '', '_self', 3.00, 1, NULL, 0, '2018-7-17 03:09:41', NULL, NULL);
INSERT INTO `system_menu` VALUES (163, 167, '管理员列表', 0, '', 'fa-group', 'admin/user/index', '', '_self', 1.00, 1, '', 0, '2018-7-18 01:15:16', NULL, NULL);
INSERT INTO `system_menu` VALUES (164, 167, '菜单配置', 0, '', '&#xe620;', 'admin/menu/index', '', '_self', 1.00, 1, '', 0, '2018-7-19 02:05:48', NULL, NULL);
INSERT INTO `system_menu` VALUES (165, 169, '刷新缓存', 0, '', '&#xe9aa;', 'admin/system/refresh', '', '_self', 5.00, 1, '', 0, '2018-7-19 10:11:27', NULL, NULL);
INSERT INTO `system_menu` VALUES (166, 168, '系统节点', 0, '', '&#xe631;', 'admin/node/index', '', '_self', 5.00, 1, '', 0, '2018-7-23 00:44:49', NULL, NULL);
INSERT INTO `system_menu` VALUES (167, 142, '系统管理', 0, '', '&#xe716;', '#', '', '_self', 0.00, 1, '', 0, '2018-7-23 01:23:11', NULL, NULL);
INSERT INTO `system_menu` VALUES (168, 142, '权限管理', 0, '', '&#xe857;', '#', '', '_self', 2.00, 1, '', 0, '2018-7-23 01:23:27', NULL, NULL);
INSERT INTO `system_menu` VALUES (169, 142, '系统刷新', 0, '', '&#xe639;', '#', '', '_self', 3.00, 1, '', 0, '2018-7-23 01:26:30', NULL, NULL);
INSERT INTO `system_menu` VALUES (171, 168, '角色权限', 0, '', '&#xe606;', 'admin/auth/index', '', '_self', 0.00, 1, '', 0, '2018-7-23 15:37:53', NULL, NULL);
INSERT INTO `system_menu` VALUES (172, 169, '刷新节点', 0, '', '&#xe666;', 'admin/system/refresh_node', '', '_self', 1.00, 1, '', 0, '2018-7-25 22:06:45', NULL, NULL);
INSERT INTO `system_menu` VALUES (173, 169, '清除节点', 0, '', '&#xe639;', 'admin/system/clear_node', '', '_self', 0.00, 1, '', 0, '2018-7-26 15:27:24', NULL, NULL);
INSERT INTO `system_menu` VALUES (175, 167, '系统配置', 0, '', '&#xe663;', 'admin/config/index', '', '_self', 5.00, 1, '', 0, '2018-7-31 00:11:14', '2018-8-1 11:28:42', NULL);
INSERT INTO `system_menu` VALUES (178, 0, '内容管理', 0, '', '&#xe60a;', '#', '', '_self', 2.00, 1, '', 0, '2018-9-20 02:00:30', NULL, NULL);
INSERT INTO `system_menu` VALUES (179, 178, '文章管理', 0, '', '&#xe62a;', '#', '', '_self', 4.00, 1, '', 0, '2018-9-20 02:01:44', NULL, NULL);
INSERT INTO `system_menu` VALUES (180, 179, '文章列表', 0, '', '&#xe637;', 'admin/article.article/index', '', '_self', 0.00, 1, '', 0, '2018-9-20 02:03:17', NULL, NULL);
INSERT INTO `system_menu` VALUES (185, 178, '会员管理', 0, '', '&#xe66f;', '#', '', '_self', 3.00, 1, '', 0, '2018-9-21 01:12:26', NULL, NULL);
INSERT INTO `system_menu` VALUES (186, 185, '会员列表', 0, '', '&#xe770;', 'admin/article.member/index', '', '_self', 0.00, 1, '', 0, '2018-9-21 01:13:19', NULL, NULL);
INSERT INTO `system_menu` VALUES (187, 179, '标签管理', 0, '', '&#xe6b2;', 'admin/article.tag/index', '', '_self', 0.00, 1, '', 0, '2018-9-21 01:14:43', NULL, NULL);
INSERT INTO `system_menu` VALUES (189, 178, '广告管理', 0, '', '&#xe857;', '#', '', '_self', 5.00, 1, '', 0, '2018-9-21 01:17:25', NULL, NULL);
INSERT INTO `system_menu` VALUES (190, 189, '轮播图配置', 0, '', '&#xe64a;', 'admin/article.slider/index', '', '_self', 2.00, 1, '', 0, '2018-9-21 01:17:44', NULL, NULL);
INSERT INTO `system_menu` VALUES (210, 185, '登录记录', 0, '', '&#xe665;', 'admin/article.login_record/index', '', '_self', 2.00, 1, '', 0, '2018-9-26 17:33:29', NULL, NULL);
INSERT INTO `system_menu` VALUES (211, 179, '文章分类', 0, '', '&#xe664;', 'admin/article.category/index', '', '_self', 0.00, 1, '', 0, '2018-9-27 01:34:06', NULL, NULL);
INSERT INTO `system_menu` VALUES (212, 179, '文章评论', 0, '', '&#xe66a;', 'admin\\article.comment\\index', '', '_self', 0.00, 1, '', 0, '2018-10-11 21:04:53', NULL, NULL);
INSERT INTO `system_menu` VALUES (213, 178, '常用工具', 0, '', '&#xe665;', '#', '', '_self', 0.00, 1, '', 0, '2018-10-11 22:18:28', NULL, NULL);
INSERT INTO `system_menu` VALUES (214, 213, '配置管理', 0, '', '&#xe716;', 'admin/article.config/index', '', '_self', 0.00, 1, '', 0, '2018-10-11 22:19:02', NULL, NULL);
INSERT INTO `system_menu` VALUES (215, 213, '友情链接', 0, '', '&#xe64d;', 'admin/article.website_link/index', '', '_self', 0.00, 1, '', 0, '2018-10-11 22:19:32', NULL, NULL);
INSERT INTO `system_menu` VALUES (216, 213, '公告管理', 0, '', '&#xe667;', 'admin/article.notice/index', '', '_self', 0.00, 1, '', 0, '2018-10-11 22:21:02', NULL, NULL);
INSERT INTO `system_menu` VALUES (217, 178, '搜索管理', 0, '', '&#xe615;', '#', '', '_self', 0.00, 1, '', 0, '2018-10-11 22:23:04', NULL, NULL);
INSERT INTO `system_menu` VALUES (218, 217, '搜索排行', 0, '', '&#xe649;', 'admin/article.search_record/index', '', '_self', 0.00, 1, '', 0, '2018-10-11 22:23:32', NULL, NULL);
INSERT INTO `system_menu` VALUES (219, 217, '搜索记录', 0, '', '&#xe66e;', 'admin/article.search/index', '', '_self', 0.00, 1, '', 0, '2018-10-11 22:23:54', NULL, NULL);
INSERT INTO `system_menu` VALUES (224, 142, '系统工具', 0, '', 'fa-server', '#', '', '_self', 6.00, 1, '', 0, '2018-10-13 21:41:40', NULL, NULL);
INSERT INTO `system_menu` VALUES (225, 224, '图标管理-layui', 0, '', 'fa-circle-o-notch', 'admin/tool.icon/index', '', '_self', 0.00, 1, '', 0, '2018-10-13 21:42:25', NULL, NULL);
INSERT INTO `system_menu` VALUES (226, 224, '图标管理-fa', 0, '', 'fa-crosshairs', 'admin/tool.icon/fa', '', '_self', 0.00, 1, '', 0, '2018-10-13 21:43:02', NULL, NULL);

-- ----------------------------
-- Table structure for system_nav
-- ----------------------------
DROP TABLE IF EXISTS `system_nav`;
CREATE TABLE `system_nav` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `icon` varchar(100) NOT NULL DEFAULT '' COMMENT '菜单图标',
  `href` varchar(400) NOT NULL DEFAULT '' COMMENT '链接',
  `sort` float(11,2) DEFAULT '0.00' COMMENT '菜单排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `remark` varchar(255) DEFAULT NULL,
  `create_by` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` timestamp NULL DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=227 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统快捷导航';

-- ----------------------------
-- Records of system_nav
-- ----------------------------
INSERT INTO `system_nav` VALUES ('214', '配置管理', '&#xe716;', 'admin/article.config/index', '0.00', '1', '', '0', '2018-10-11 22:19:02', null, null);
INSERT INTO `system_nav` VALUES ('215', '友情链接', '&#xe64d;', 'admin/article.website_link/index', '0.00', '1', '', '0', '2018-10-11 22:19:32', null, null);
INSERT INTO `system_nav` VALUES ('216', '公告管理', '&#xe667;', 'admin/article.notice/index', '0.00', '1', '', '0', '2018-10-11 22:21:02', null, null);
INSERT INTO `system_nav` VALUES ('218', '搜索排行', '&#xe649;', 'admin/article.search_record/index', '0.00', '1', '', '0', '2018-10-11 22:23:32', null, null);
INSERT INTO `system_nav` VALUES ('219', '搜索记录', '&#xe66e;', 'admin/article.search/index', '0.00', '1', '', '0', '2018-10-11 22:23:54', null, null);
INSERT INTO `system_nav` VALUES ('225', '图标管理-layui', 'fa-circle-o-notch', 'admin/tool.icon/index', '0.00', '1', '', '0', '2018-10-13 21:42:25', null, null);
INSERT INTO `system_nav` VALUES ('226', '图标管理-fa', 'fa-crosshairs', 'admin/tool.icon/fa', '0.00', '1', '', '0', '2018-10-13 21:43:02', null, null);

-- ----------------------------
-- Table structure for system_node
-- ----------------------------
DROP TABLE IF EXISTS `system_node`;
CREATE TABLE `system_node` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `node` varchar(100) DEFAULT NULL COMMENT '节点代码',
  `title` varchar(500) DEFAULT NULL COMMENT '节点标题',
  `type` tinyint(1) DEFAULT '3' COMMENT '节点类型（1：模块，2：控制器，3：节点）',
  `is_auth` tinyint(1) unsigned DEFAULT '1' COMMENT '是否启动RBAC权限控制',
  `is_auto` tinyint(1) DEFAULT '0' COMMENT '是否为系统自动刷新（0：是，1：手动添加）',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_system_node_node` (`node`)
) ENGINE=InnoDB AUTO_INCREMENT=1396 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统节点表';

-- ----------------------------
-- Records of system_node
-- ----------------------------
INSERT INTO `system_node` VALUES ('1037', 'admin', '后台模块管理', '1', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1040', 'admin/auth', '角色管理', '2', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1041', 'admin/auth/index', '角色列表', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1042', 'admin/auth/add', '添加角色', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1043', 'admin/auth/edit', '编辑角色', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1044', 'admin/auth/del', '删除角色', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1045', 'admin/auth/status', '更改角色状态', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1046', 'admin/auth/authorize', '角色授权', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1047', 'admin/icon', '系统图标管理', '2', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1048', 'admin/icon/index', '图标列表', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1049', 'admin/index', '系统后台首页（不要开启）', '2', '0', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1050', 'admin/index/index', '后台首页（不要开启）', '3', '0', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1051', 'admin/index/welcome', '后台欢迎页面（不要开启）', '3', '0', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1052', 'admin/menu', '系统菜单管理', '2', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1053', 'admin/menu/index', '菜单列表', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1054', 'admin/menu/add', '添加菜单', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1055', 'admin/menu/edit', '编辑菜单', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1056', 'admin/menu/del', '删除菜单', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1057', 'admin/menu/status', '更改菜单状态', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1058', 'admin/node', '节点管理', '2', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1059', 'admin/node/index', '节点列表', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1063', 'admin/node/status', '更改节点状态', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1064', 'admin/system', '系统管理', '2', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1065', 'admin/system/refresh', '刷新缓存', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1066', 'admin/system/refresh_node', '刷新节点', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1069', 'admin/user', '系统管理员管理', '2', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1070', 'admin/user/index', '管理员列表', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1071', 'admin/user/add', '添加管理员', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1072', 'admin/user/edit', '编辑管理员', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1073', 'admin/user/del', '删除管理员', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1074', 'admin/user/edit_password', '修改管理员密码', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1075', 'admin/user/status', '更改管理员状态', '3', '1', null, '2018-07-26 02:51:09', null, null, null);
INSERT INTO `system_node` VALUES ('1109', 'admin/system/clear_node', '清除节点', '3', '1', null, '2018-07-26 15:29:55', null, null, null);
INSERT INTO `system_node` VALUES ('1113', 'admin/config', '系统配置管理', '2', '1', null, '2018-07-31 01:00:16', null, null, null);
INSERT INTO `system_node` VALUES ('1114', 'admin/config/index', '系统配置列表', '3', '1', null, '2018-07-31 01:00:16', null, null, null);
INSERT INTO `system_node` VALUES ('1124', 'admin/login', '后台登录（不要开启）', '2', '0', '0', '2018-09-19 18:21:57', null, null, null);
INSERT INTO `system_node` VALUES ('1125', 'admin/login/index', null, '3', '0', '0', '2018-09-19 18:21:57', null, null, null);
INSERT INTO `system_node` VALUES ('1126', 'admin/login/change', null, '3', '0', '0', '2018-09-19 18:21:57', null, null, null);
INSERT INTO `system_node` VALUES ('1127', 'admin/login/out', null, '3', '0', '0', '2018-09-19 18:21:57', null, null, null);
INSERT INTO `system_node` VALUES ('1337', 'admin/api.menu', '菜单接口（不要开启）', '2', '0', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1338', 'admin/api.menu/get_menu', null, '3', '0', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1341', 'admin/api.node', '节点接口（不要开启）', '2', '0', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1342', 'admin/api.node/get_node_tree', null, '3', '0', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1345', 'admin/api.upload', '上传接口（不要开启）', '2', '0', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1346', 'admin/api.upload/image', null, '3', '0', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1349', 'admin/article.article', '系统文章管理', '2', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1350', 'admin/article.article/index', '文章列表', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1351', 'admin/article.article/add', '文章添加', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1352', 'admin/article.article/edit', '文章修改', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1353', 'admin/article.article/del', '文章删除', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1354', 'admin/article.article/status', '修改文章状态', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1357', 'admin/article.category', '系统分类管理', '2', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1358', 'admin/article.category/index', '分类列表', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1361', 'admin/article.login_record', '系统登录记录管理', '2', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1362', 'admin/article.login_record/index', '登录记录列表', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1363', 'admin/article.login_record/del', '登录记录删除', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1366', 'admin/article.member', '系统会员管理', '2', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1367', 'admin/article.member/index', '会员列表', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1368', 'admin/article.member/add', '会员接口', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1369', 'admin/article.member/edit', '会员编辑', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1371', 'admin/article.member/del', '会员删除', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1372', 'admin/article.member/status', '会员状态修改', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1373', 'admin/article.member/detail', '会员详情', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1376', 'admin/article.tag', '系统文章标签管理', '2', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1377', 'admin/article.tag/index', '标签列表', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1378', 'admin/article.tag/add', '标签添加', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1379', 'admin/article.tag/edit', '标签编辑', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1380', 'admin/article.tag/del', '标签删除', '3', '1', '0', '2018-10-01 13:54:12', null, null, null);
INSERT INTO `system_node` VALUES ('1383', 'admin/article.category/add', '分类添加', '3', '1', '0', '2018-10-11 16:52:46', null, null, null);
INSERT INTO `system_node` VALUES ('1384', 'admin/article.category/edit', '分类编辑', '3', '1', '0', '2018-10-11 16:52:46', null, null, null);
INSERT INTO `system_node` VALUES ('1385', 'admin/article.category/del', '分类删除', '3', '1', '0', '2018-10-11 16:52:46', null, null, null);
INSERT INTO `system_node` VALUES ('1386', 'admin/article.category/status', '修改分类状态', '3', '1', '0', '2018-10-11 16:52:46', null, null, null);
INSERT INTO `system_node` VALUES ('1387', 'admin/article.member/reset_password', '会员重置密码', '3', '1', '0', '2018-10-11 16:52:46', null, null, null);
INSERT INTO `system_node` VALUES ('1388', 'admin/article.slider', '系统轮播图管理', '2', '1', '0', '2018-10-11 16:52:46', null, null, null);
INSERT INTO `system_node` VALUES ('1389', 'admin/article.slider/index', '轮播图列表', '3', '1', '0', '2018-10-11 16:52:46', null, null, null);
INSERT INTO `system_node` VALUES ('1390', 'admin/article.slider/add', '轮播图添加', '3', '1', '0', '2018-10-11 16:52:46', null, null, null);
INSERT INTO `system_node` VALUES ('1391', 'admin/article.slider/edit', '轮播图编辑', '3', '1', '0', '2018-10-11 16:52:46', null, null, null);
INSERT INTO `system_node` VALUES ('1392', 'admin/article.slider/del', '轮播图删除', '3', '1', '0', '2018-10-11 16:52:46', null, null, null);
INSERT INTO `system_node` VALUES ('1393', 'admin/article.slider/status', '轮播图状态修改', '3', '1', '0', '2018-10-11 16:52:46', null, null, null);

-- ----------------------------
-- Table structure for system_user
-- ----------------------------
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `auth_id` varchar(255) DEFAULT NULL COMMENT '角色权限ID',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '用户登录名',
  `password` char(40) NOT NULL DEFAULT '' COMMENT '用户登录密码',
  `qq` varchar(16) DEFAULT NULL COMMENT '联系QQ',
  `mail` varchar(32) DEFAULT NULL COMMENT '联系邮箱',
  `phone` varchar(16) DEFAULT NULL COMMENT '联系手机号',
  `remark` varchar(255) DEFAULT '' COMMENT '备注说明',
  `login_num` bigint(20) unsigned DEFAULT '0' COMMENT '登录次数',
  `login_at` datetime DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用,)',
  `is_deleted` tinyint(1) unsigned DEFAULT '0' COMMENT '删除状态(1:删除,0:未删)',
  `create_by` bigint(20) unsigned DEFAULT '0' COMMENT '创建人',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_system_user_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10015 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统用户表';

-- ----------------------------
-- 新增用户头像
-- ----------------------------
ALTER TABLE `system_user` ADD COLUMN `head_img`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/static/image/admin/face.png' COMMENT '头像' AFTER `auth_id`;
