##################### INIT SCHEMA #####################
DROP SCHEMA IF EXISTS `ecp_admin`;
CREATE SCHEMA `ecp_admin` DEFAULT CHARACTER SET utf8 ;

################### CREATE TABLES #####################
use `ecp_admin`;
### SEQUENCE
DROP TABLE IF EXISTS s_sequence;
CREATE TABLE s_sequence (
  name VARCHAR(50) NOT NULL,
  current_value INT NOT NULL,
  increment INT NOT NULL DEFAULT 1,
  PRIMARY KEY (name)
)  ENGINE=InnoDB;


DROP FUNCTION IF EXISTS currval;
DELIMITER $
CREATE FUNCTION currval (seq_name VARCHAR(50))
  RETURNS INTEGER
CONTAINS SQL
  BEGIN
    DECLARE value INTEGER;
    SET value = -1;
    SELECT current_value INTO value
    FROM s_sequence
    WHERE name = seq_name;
    RETURN value;
  END$
DELIMITER ;

DROP FUNCTION IF EXISTS nextval;
DELIMITER $
CREATE FUNCTION nextval (seq_name VARCHAR(50))
  RETURNS INTEGER
CONTAINS SQL
  BEGIN
    UPDATE s_sequence
    SET          current_value = current_value + increment
    WHERE name = seq_name;
    RETURN currval(seq_name);
  END$
DELIMITER ;

-- ----------------------------
-- Table structure for s_dict 字典表
-- ----------------------------
-- DROP TABLE IF EXISTS `s_dict`;
-- CREATE TABLE `s_dict` (
--   `dict_id` varchar(128) NOT NULL COMMENT '字典数据ID',
--   `dict_service` char(2) NOT NULL COMMENT '服务类型(10:共通，20:会员，30：商品，40:交易)',
--   `dict_name` varchar(128) NOT NULL COMMENT '分类名',
--   `dict_type` varchar(128) NOT NULL COMMENT '字典分类',
--   `dict_code` char(2) NOT NULL COMMENT '字典编码',
--   `dict_value_cn` varchar(20) NOT NULL COMMENT '字典value-cn',
--   `dict_value_en` varchar(20) DEFAULT NULL COMMENT '字典value-en',
--   `del_flag` char(1) DEFAULT '0' COMMENT '逻辑删除标示 默认是有效数据，默认值0（False）',
--   `create_dt` bigint(20) NOT NULL COMMENT '创建时间',
--   `create_uid` varchar(128) NOT NULL COMMENT '创建人',
--   `modify_dt` bigint(20) NOT NULL COMMENT '修改时间',
--   `modify_uid` varchar(128) NOT NULL COMMENT '修改人',
--   PRIMARY KEY (`dict_id`),
--   KEY `idx_service` (`dict_service`),
--   KEY `idx_code` (`dict_code`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for s_user 系统用户表
-- ----------------------------
DROP TABLE IF EXISTS `s_user`;
CREATE TABLE `s_user` (
  `user_id` varchar(128) NOT NULL COMMENT '用户ID',
  `user_name` varchar(128) NOT NULL COMMENT '用户名',
  `user_password` varchar(60) NOT NULL COMMENT '用户密码',
  `role_id` varchar(128) NOT NULL COMMENT '角色ID',
  `real_name` varchar(128) NOT NULL COMMENT '真实姓名',
  `phone` varchar(60) NOT NULL COMMENT '手机号',
  `work_id` varchar(60) DEFAULT NULL COMMENT '员工id',
  `depart_id` varchar(60) NOT NULL COMMENT '部门id',
  `status` char(1) DEFAULT '1' COMMENT '状态 0-锁定 1-正常',
  `last_login_ip` varchar(45) DEFAULT NULL COMMENT '最后登录IP',
  `last_login_dt` bigint(20) DEFAULT NULL COMMENT '最后登录时间',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标示 默认是有效数据，默认值0（False）',
  `create_dt` bigint(20) NOT NULL COMMENT '创建时间',
  `create_uid` varchar(128) NOT NULL COMMENT '创建人',
  `modify_dt` bigint(20) NOT NULL COMMENT '修改时间',
  `modify_uid` varchar(128) NOT NULL COMMENT '修改人',
  PRIMARY KEY (`user_id`),
  KEY `idx_user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

INSERT INTO `ecp_admin`.`s_user` (`user_id`, `user_name`, `user_password`, `role_id`, `real_name`, `phone`, `work_id`, `depart_id`, `status`, `last_login_ip`, `last_login_dt`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('0000000001', 'admin', '411328525e07a33fd00b59a82ab127f0', 'JSG395390151300744017', '系统管理员', '', '', '1', '1', '127.0.0.1', '1516954959003', '0', '1508303405992', '0000000001', '1515131008834', '0000000001');

-- ----------------------------
-- Table structure for s_role 角色表
-- ----------------------------
DROP TABLE IF EXISTS `s_role`;
CREATE TABLE `s_role` (
  `role_id` varchar(128) NOT NULL COMMENT '角色ID',
  `role_name` varchar(128) NOT NULL COMMENT '角色名',
  `role_dsc` varchar(128) DEFAULT NULL COMMENT '角色描述 系统管理员、商户管理员、店铺管理员、业务操作员等',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标示 默认是有效数据，默认值0（False）',
  `create_dt` bigint(20) NOT NULL COMMENT '创建时间',
  `create_uid` varchar(128) NOT NULL COMMENT '创建人',
  `modify_dt` bigint(20) NOT NULL COMMENT '修改时间',
  `modify_uid` varchar(128) NOT NULL COMMENT '修改人',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

INSERT INTO `ecp_admin`.`s_role` (`role_id`, `role_name`, `role_dsc`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '系统管理员', '系统管理员', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');

-- ----------------------------
-- Table structure for s_menu 菜单表
-- ----------------------------
DROP TABLE IF EXISTS `s_menu`;
CREATE TABLE `s_menu` (
  `menu_id` varchar(128) NOT NULL COMMENT '菜单ID 主菜单1000,1100,1200递增，二级菜单1010,1020；1110,1120；1210,1220递增, 三级菜单二级页面按钮1011，1012；1111，1112递增',
  `menu_name` varchar(128) NOT NULL COMMENT '菜单名',
  `parent_id` varchar(128) NOT NULL COMMENT '上级菜单ID',
  `url` varchar(128) DEFAULT NULL COMMENT '菜单链接',
  `sort` int(2) DEFAULT NULL COMMENT '排序',
  `level` int(2) DEFAULT NULL COMMENT '级别',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标示 默认是有效数据，默认值0（False）',
  `create_dt` bigint(20) NOT NULL COMMENT '创建时间',
  `create_uid` varchar(128) NOT NULL COMMENT '创建人',
  `modify_dt` bigint(20) NOT NULL COMMENT '修改时间',
  `modify_uid` varchar(128) NOT NULL COMMENT '修改人',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1000', '权限管理', '0', '1', '1', '1', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1010', '字典管理', '1000', 'SystemDictionary/toSystemDictionary', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1020', '用户一览', '1000', 'User/toUser', '2', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1021', '重置密码', '1020', 'pwbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1022', '新增', '1020', 'addbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1023', '编辑', '1020', 'editbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1024', '删除', '1020', 'delbtn', '4', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1025', '启用停用', '1020', 'statusbtn', '5', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1030', '角色一览', '1000', 'Role/toRole', '3', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1031', '新增', '1030', 'addbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1032', '编辑', '1030', 'editbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1033', '删除', '1030', 'delbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1100', '系统设置', '0', '-', '2', '1', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1110', '热搜词管理', '1100', 'hotSearch/toHotSearch', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1111', '新增', '1110', 'addbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1112', '删除', '1110', 'delbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1120', '广告一览', '1100', 'Banner/toBanner', '2', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1121', '新增', '1120', 'addbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1122', '编辑', '1120', 'editbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1123', '删除', '1120', 'delbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1130', '首页模块管理', '1100', 'Img/toImg', '3', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1140', '运费模板一览', '1100', 'FreightTemplate/toFreightTemplateList', '4', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1141', '新增', '1140', 'addbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1142', '编辑', '1140', 'editbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1143', '删除', '1140', 'delbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1150', '分润模板一览', '1100', 'GoodsReward/toGoodsReward', '5', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1151', '新增', '1150', 'addbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1152', '编辑', '1150', 'editbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1153', '删除', '1150', 'delbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1160', '首页模块一览', '1100', 'Img/toImgList', '6', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1161', '新增', '1160', 'addbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1162', '编辑', '1160', 'editbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1163', '删除', '1160', 'delbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1170', '系统设置一览', '1100', 'SysSet/toSysSet', '7', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1171', '编辑', '1170', 'editbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1200', '商品管理', '0', '-', '3', '1', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1210', '品牌管理', '1200', 'GoodsBrand/toGoodsBrand', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1211', '新增', '1210', 'addbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1212', '编辑', '1210', 'editbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1213', '删除', '1210', 'delbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1214', '启用停用', '1210', 'statusbtn', '4', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1220', '商品类目管理', '1200', 'Goods/toGoodsCategory', '2', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1230', '商品审核一览', '1200', 'Goods/toGoodsExamine', '3', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1231', '审核', '1230', 'verifybtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1240', '商品上下架管理', '1200', 'Goods/toGoodsMng', '4', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1241', '编辑', '1240', 'editbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1242', '复制', '1240', 'copybtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1243', '上架下架', '1240', 'updownbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1250', '热销商品管理', '1200', 'HotGoods/toHotGoods', '5', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1251', '新增', '1250', 'addbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1252', '删除', '1250', 'delbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1300', '会员管理', '0', '-', '4', '1', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1310', '会员基本信息一览', '1300', 'Customer/toCustomer', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1311', '重置密码', '1310', 'pwbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1312', '账户状态', '1310', 'statusbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1313', '调整级别', '1310', 'levelbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1320', '会员账户信息一览', '1300', 'AccountBalance/toAccountBalance', '2', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1321', '编辑', '1320', 'editbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1400', '供应商', '0', '-', '5', '1', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1410', '供应商一览', '1400', 'Vendor/toVendor', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1411', '审核', '1410', 'verifybtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1412', '正常停用', '1410', 'statusbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1413', '重置密码', '1410', 'pwbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1500', '订单中心', '0', '-', '6', '1', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1510', '订单一览', '1500', 'Order/toOrderList', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1511', '退款退货', '1510', 'returnbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1512', '取消订单', '1510', 'cancelbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1513', '修改运费', '1510', 'editbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1514', '订单导出', '1510', 'exportbtn', '4', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1520', '商品销售一览', '1500', 'OrderGoodsSell/toOrderGoodsSellList', '2', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1521', '报表导出', '1520', 'exportbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1600', '退货退款', '0', '-', '7', '1', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1610', '退单一览', '1600', 'OrderReturn/toOrderReturnList', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1611', '编辑快递', '1610', 'editbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1612', '确认收货', '1610', 'okbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1700', '财务管理', '0', '-', '8', '1', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1710', '供应商结算信息', '1700', 'VendorBalance/toVendorBalance', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1711', '确认结算', '1710', 'okbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1720', '退款一览', '1700', 'FinanceReturn/toFinanceReturnList', '2', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1721', '确认退款', '1720', 'okbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1730', '会员收支明细', '1700', 'AccountBalance/toAccountBalanceAllDetail', '3', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1740', '在线支付一览', '1700', 'OnLinePayment/toOnLinePaymentList', '4', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1750', '提现一览', '1700', 'Expenditure/toExpenditureList', '5', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1751', '审核', '1750', 'exambtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1752', '拒绝', '1750', 'refusebtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1753', '发放', '1750', 'grantbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1760', '平台收支一览', '1700', 'BalanceReport/toBalanceReportList', '5', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1761', '报表导出', '1760', 'exportbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1800', '信息中心', '0', '-', '9', '1', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1810', '公告一览', '1800', 'Notice/toNotice', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1811', '新增', '1810', 'addbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1812', '编辑', '1810', 'editbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1813', '删除', '1810', 'delbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1814', '发布撤消', '1810', 'statusbtn', '4', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1820', '商品评价', '1800', 'GoodsEvaluate/toGoodsEvaluate', '2', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1821', '新增', '1820', 'addbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1822', '审核', '1820', 'verifybtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1823', '删除', '1820', 'delbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1900', '店铺管理', '0', '-', '10', '1', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1910', '店铺一览', '1900', 'Shop/toShop', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1911', '开启关闭', '1910', 'openclosebtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1920', '店铺商品管理', '1900', 'Shop/toShopGoods', '2', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1921', '新增', '1920', 'addbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1922', '删除', '1920', 'delbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1930', '店铺分润一览', '1900', 'Shop/toShopReward', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1931', '报表导出', '1930', 'exportbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1932', '重新计算', '1930', 'okbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1933', '发放', '1930', 'sentbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1940', '店铺分润统计报表', '1900', 'Shop/toShopRewardReport', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1941', '报表导出', '1940', 'exportbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1950', '分润店铺一览', '1900', 'Shop/toRewardShopList', '4', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1951', '报表导出', '1950', 'exportbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2000', '活动管理', '0', '-', '11', '1', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2100', '日志管理', '0', '-', '12', '1', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2110', '管理员登录一览', '2100', 'LoginLog/toLoginLog', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2120', '管理员操作一览 ', '2100', '', '2', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2200', '商城结算', '0', '-', '10', '1', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2210', '分润一览', '2200', 'Reward/toRewardList', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2211', '报表导出', '2210', 'exportbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2212', '重新计算', '2210', 'okbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2213', '发放', '2210', 'sentbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2220', '分润统计报表', '2200', 'Reward/toRewardGroupList', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2221', '报表导出', '2220', 'exportbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2230', '分润用户一览', '2200', 'RewardUser/toRewardUserList', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2231', '报表导出', '2230', 'exportbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2240', '分润用户统计报表', '2200', 'RewardUser/toRewardUserGroupList', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2241', '报表导出', '2240', 'exportbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1960', '分润店铺统计报表', '1900', 'Shop/toRewardShopGroupList', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1961', '报表导出', '1960', 'exportbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2020', '活动一览', '2000', 'Activity/toActivityList', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2021', '开启关闭', '2020', 'openclosebtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2022', '新增', '2020', 'addbtn', '2', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2023', '删除', '2020', 'delbtn', '3', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2024', '编辑', '2020', 'editbtn', '4', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2025', '添加活动商品', '2020', 'addActivityGoodsBtnFlag', '5', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2300', '卡包管理', '0', '-', '1', '1', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2310', '卡券一览', '2300', 'Card/toCard', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2311', '设置备注', '2310', 'remarkbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2250', '分润统计一览', '2200', 'CustomerReward/toCustomerRewardList', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2251', '报表导出', '2250', 'exportbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1515', '修改备注', '1510', 'updremarkbtn', '5', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('1330', '会员推荐信息一览', '1300', 'Customer/toCustomerReferee', '3', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2260', '用户分润统计一览', '2200', 'CustomerReward/toCustomerRewardUserList', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2261', '报表导出', '2260', 'exportbtn', '1', '3', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2270', '用户分润一览', '2200', 'CustomerReward/toCustomerRewardUserNoGroupList', '1', '2', '0', '1', '1', '1', '1');
INSERT INTO `ecp_admin`.`s_menu` (`menu_id`, `menu_name`, `parent_id`, `url`, `sort`, `level`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('2271', '报表导出', '2270', 'exportbtn', '1', '3', '0', '1', '1', '1', '1');


-- -- ----------------------------
-- -- Table structure for s_user_role 用户角色表
-- -- ----------------------------
-- DROP TABLE IF EXISTS `s_user_role`;
-- CREATE TABLE `s_user_role` (
--   `user_id` varchar(128) NOT NULL COMMENT '用户ID',
--   `role_id` varchar(128) NOT NULL COMMENT '角色ID',
--   `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标示 默认是有效数据，默认值0（False）',
--   `create_dt` bigint(20) NOT NULL COMMENT '创建时间',
--   `create_uid` varchar(128) NOT NULL COMMENT '创建人',
--   `modify_dt` bigint(20) NOT NULL COMMENT '修改时间',
--   `modify_uid` varchar(128) NOT NULL COMMENT '修改人',
--   KEY `idx_user_id` (`user_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for s_menu_role 菜单角色表
-- ----------------------------
DROP TABLE IF EXISTS `s_menu_role`;
CREATE TABLE `s_menu_role` (
  `role_id` varchar(128) NOT NULL COMMENT '角色ID',
  `menu_id` varchar(128) NOT NULL COMMENT '菜单ID',
  `parent_menu_id` varchar(128) NOT NULL COMMENT '上级菜单ID',
  `use_btn` varchar(128) DEFAULT NULL COMMENT '角色可用按钮',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标示 默认是有效数据，默认值0（False）',
  `create_dt` bigint(20) NOT NULL COMMENT '创建时间',
  `create_uid` varchar(128) NOT NULL COMMENT '创建人',
  `modify_dt` bigint(20) NOT NULL COMMENT '修改时间',
  `modify_uid` varchar(128) NOT NULL COMMENT '修改人',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1000', '0', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1010', '1000', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1020', '1000', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1021', '1020', 'pwbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1022', '1020', 'addbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1023', '1020', 'editbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1024', '1020', 'delbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1025', '1020', 'statusbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1030', '1000', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1031', '1030', 'addbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1032', '1030', 'editbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1033', '1030', 'delbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1100', '0', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1110', '1100', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1111', '1110', 'addbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1112', '1110', 'delbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1120', '1100', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1121', '1120', 'addbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1122', '1120', 'editbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1123', '1120', 'delbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1130', '1100', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1140', '1100', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1141', '1140', 'addbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1142', '1140', 'editbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1143', '1140', 'delbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1150', '1100', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1151', '1150', 'addbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1152', '1150', 'editbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1153', '1150', 'delbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1200', '0', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1210', '1200', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1211', '1210', 'addbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1212', '1210', 'editbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1213', '1210', 'delbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1214', '1210', 'statusbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1220', '1200', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1230', '1200', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1231', '1230', 'verifybtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1240', '1200', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1241', '1240', 'editbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1242', '1240', 'copybtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1243', '1240', 'updownbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1300', '0', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1310', '1300', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1311', '1310', 'pwbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1312', '1310', 'statusbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1313', '1310', 'levelbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1320', '1300', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1321', '1320', 'editbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1400', '0', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1410', '1400', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1411', '1410', 'verifybtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1412', '1410', 'statusbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1413', '1410', 'pwbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1500', '0', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1510', '1500', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1511', '1510', 'returnbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1512', '1510', 'cancelbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1513', '1510', 'editbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1514', '1510', 'exportbtn', '0', '1508293728819', 'YHG395390022185124797', '1516860290374', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1600', '0', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1610', '1600', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1611', '1610', 'editbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1612', '1610', 'okbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1700', '0', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1710', '1700', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1711', '1710', 'okbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1720', '1700', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1721', '1720', 'okbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1730', '1700', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1740', '1700', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1750', '1700', '', '0', '1508293728819', 'YHG395390022185124797', '1517391303662', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1751', '1750', 'exambtn', '0', '1508293728819', 'YHG395390022185124797', '1517391303662', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1752', '1750', 'refusebtn', '0', '1508293728819', 'YHG395390022185124797', '1517391303662', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1753', '1750', 'grantbtn', '0', '1508293728819', 'YHG395390022185124797', '1517391303662', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1760', '1700', '', '0', '1508293728819', 'YHG395390022185124797', '1517391303662', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1761', '1760', 'exportbtn', '0', '1508293728819', 'YHG395390022185124797', '1517391303662', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1800', '0', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1810', '1800', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1811', '1810', 'addbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1812', '1810', 'editbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1813', '1810', 'delbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1814', '1810', 'statusbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1820', '1800', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1821', '1820', 'addbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1822', '1820', 'verifybtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1823', '1820', 'delbtn', '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1900', '0', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1910', '1900', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '2000', '0', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '2010', '2000', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '2100', '0', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '2110', '2100', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '2120', '2100', NULL, '0', '1508293728819', 'YHG395390022185124797', '1516861755002', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1250', '1200', NULL, '0', '1508293728819', 'YHG395390022185124797', '1520228949736', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1251', '1250', 'addbtn', '0', '1508293728819', 'YHG395390022185124797', '1520228949736', '0000000001');
INSERT INTO `ecp_admin`.`s_menu_role` (`role_id`, `menu_id`, `parent_menu_id`, `use_btn`, `del_flag`, `create_dt`, `create_uid`, `modify_dt`, `modify_uid`) VALUES ('JSG395390151300744017', '1252', '1250', 'delbtn', '0', '1508293728819', 'YHG395390022185124797', '1520228949736', '0000000001');
