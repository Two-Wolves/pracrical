-- ----------------------------
-- �����û�ͷ��
-- ----------------------------
ALTER TABLE `system_user` ADD COLUMN `head_img`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/static/image/admin/face.png' COMMENT 'ͷ��' AFTER `auth_id`;

-- ----------------------------
-- �����ɼ�������Ϣ
-- ----------------------------
INSERT INTO `system_config` (`name`, `group`, `type`, `value`, `remark`, `sort`, `create_at`, `create_by`, `update_at`, `update_by`) VALUES ('spider_access_key', 'spider', 'string', 'asdfmigshjogsn', '�ɼ��ӿڹ�Կ', '0', '2018-11-19 10:46:26', '0', NULL, NULL);
INSERT INTO `system_config` (`name`, `group`, `type`, `value`, `remark`, `sort`, `create_at`, `create_by`, `update_at`, `update_by`) VALUES ('spider_secret_key', 'spider', 'string', 'twjtrowmlca', '�ɼ��ӿ�˽Կ', '0', '2018-11-19 10:46:36', '0', NULL, NULL);
INSERT INTO `system_config` (`name`, `group`, `type`, `value`, `remark`, `sort`, `create_at`, `create_by`, `update_at`, `update_by`) VALUES ('spider_url', 'spider', 'string', 'http://spider.ytwlSystemForOa.cn/api/article/index.html', '�ɼ��ӿڵ�ַ', '0', '2018-11-19 10:46:46', '0', NULL, NULL);
INSERT INTO `system_config` (`name`, `group`, `type`, `value`, `remark`, `sort`, `create_at`, `create_by`, `update_at`, `update_by`) VALUES ('DataBack', 'basic', 'string', '../data_bak/', '备份地址', '8', '2019-02-24 15:03:15', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `system_menu` (`pid`, `title`, `spread`, `node`, `icon`, `href`, `params`, `target`, `sort`, `status`, `remark`, `create_by`, `create_at`, `update_at`, `update_by`) VALUES ('167', '数据库管理', '0', '', 'fa-database', 'admin/database/index', '', '_self', '0.00', '1', '', '0', '2020-02-26 15:20:50', NULL, NULL);