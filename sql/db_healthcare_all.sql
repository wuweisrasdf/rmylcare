/*
 Navicat Premium Dump SQL

 Source Server         : 线上接口
 Source Server Type    : MySQL
 Source Server Version : 50617 (5.6.17)
 Source Host           : 47.94.145.40:3306
 Source Schema         : db_healthcare

 Target Server Type    : MySQL
 Target Server Version : 50617 (5.6.17)
 File Encoding         : 65001

 Date: 05/02/2026 14:27:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint(20) NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for hm_mother
-- ----------------------------
DROP TABLE IF EXISTS `hm_mother`;
CREATE TABLE `hm_mother`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) NULL DEFAULT 0 COMMENT '甲方ID',
  `mother_relation` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '甲方与产妇关系(1-本人、2-丈夫)',
  `mother_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '姓名',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号',
  `id_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '证件类型(1-身份证、2-护照、3-永久居留身份证、4-台湾来往大陆通行证、5-香港来往大陆通行证、6-澳门来往大陆通行证、10-其它)',
  `id_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '证件号码',
  `hospital_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '预产医院',
  `due_date` datetime NULL DEFAULT NULL COMMENT '预产期',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '产妇信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hm_mother
-- ----------------------------
INSERT INTO `hm_mother` VALUES (1, 0, '1', '12321321', '3213213', '123213', '1', '123123213', '123123213', '2026-01-07 00:00:00', '3333');
INSERT INTO `hm_mother` VALUES (2, 107, '1', '产妇', 'xxx@163.com', '13545648795', '1', '122231232312331', '预产医院', '2026-01-29 00:00:00', '地址地址地址地址');
INSERT INTO `hm_mother` VALUES (4, 1, '1', '产妇1号', 'mother@mail.com', '12345678901', '1', '12345678990000', '解放军301医院', '2026-02-28 00:00:00', '海淀区甲1号');
INSERT INTO `hm_mother` VALUES (5, 0, '2', '张晓梅', 'zhangxiaomei@example.com', '13812345678', '1', '310105199003072345', '上海市第一妇婴保健院', '2026-06-01 00:00:00', '上海市浦东新区锦绣路1234弄56号702室');
INSERT INTO `hm_mother` VALUES (6, 110, '2', '张晓梅', 'zhangxiaomei@example.com', '13812345678', '1', '310105199003072345', '上海市第一妇婴保健院', '2026-04-01 00:00:00', '上海市浦东新区锦绣路1234弄56号702室');

-- ----------------------------
-- Table structure for hm_order_fdp
-- ----------------------------
DROP TABLE IF EXISTS `hm_order_fdp`;
CREATE TABLE `hm_order_fdp`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `record_status` tinyint(1) NULL DEFAULT 1 COMMENT '记录状态	(1-有效 0-无效)',
  `pro_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '协议编号',
  `pro_status` tinyint(1) NULL DEFAULT 2 COMMENT '协议状态（1-已签,2-未签,3-取消,4-终止）',
  `order_status` tinyint(1) NULL DEFAULT 11 COMMENT '订单状态（11-未交费,1-已缴费,2-接收胎盘,3-已出报告,12-送制备,13-制备接收,14-送辐照,15-辐照接收,16-初检,17-复检,8-成品登记,9-待取货,10-待发货,4-待交付,5-已完成,6-待解除,7-已退费）',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户(甲方)ID',
  `sign_date` date NULL DEFAULT NULL COMMENT '签约日期',
  `price_in` float(10, 2) NULL DEFAULT 0.00 COMMENT '采购价格',
  `sales_id` bigint(20) NULL DEFAULT NULL COMMENT '销售人员ID',
  `sync_flag` tinyint(1) NULL DEFAULT 0 COMMENT '同步标志',
  `tax_in` float(10, 2) NULL DEFAULT 0.00 COMMENT '采购税点',
  `price_out` float(10, 2) NULL DEFAULT 0.00 COMMENT '销售价格',
  `tax_out` float(10, 2) NULL DEFAULT 0.00 COMMENT '销售税点',
  `price_back` float(10, 2) NULL DEFAULT 0.00 COMMENT '退款金额',
  `pay_date` date NULL DEFAULT NULL COMMENT '缴费日期',
  `pay_type` int(11) NULL DEFAULT 3 COMMENT '缴费方式	（1-支付宝、2-银行汇款、3-微信）',
  `is_check_from` tinyint(1) NULL DEFAULT 0 COMMENT '是否与供应商对账	(1-是 0-否)',
  `mother_id` bigint(20) NULL DEFAULT 0 COMMENT '产妇ID',
  `c_memo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注',
  `get_flag` tinyint(1) NULL DEFAULT 0 COMMENT '是否回库(1-是 0-否)',
  `get_h_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实际生产医院',
  `get_tp_date` date NULL DEFAULT NULL COMMENT '收到胎盘日期',
  `get_is_pass` tinyint(1) NULL DEFAULT 0 COMMENT '病毒报告合格(0-未检 1-合格 2-不合格)	',
  `get_report_date` date NULL DEFAULT NULL COMMENT '病毒报告收到日期	',
  `is_submit_with` tinyint(1) NULL DEFAULT 0 COMMENT '是否成品登记(1-是 0-否)',
  `submit_date_with` date NULL DEFAULT NULL COMMENT '可交付日期(成品登记日期)',
  `submit_number` int(11) NULL DEFAULT 0 COMMENT '交付数量',
  `submit_unit` int(11) NULL DEFAULT 0 COMMENT '交付瓶数',
  `submit_unit_per` int(11) NULL DEFAULT 0 COMMENT '常规瓶规格',
  `submit_unit_ss` int(11) NULL DEFAULT 0 COMMENT '特殊瓶粒数	',
  `submit_date_plan` date NULL DEFAULT NULL COMMENT '计划交付日期',
  `submit_uid_plan` int(11) NULL DEFAULT 0 COMMENT '计划交付人	',
  `submit_require_plan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '客户需求',
  `submit_memo_plan` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '计划交付备注',
  `submit_date` datetime NULL DEFAULT NULL COMMENT '实际交付时间',
  `submit_uid` int(11) NULL DEFAULT 0 COMMENT '实际交付人',
  `submit_memo` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实际交付备注',
  `submit_type` int(11) NULL DEFAULT 0 COMMENT '交付方式(0-未知 1-自送 2-快递)',
  `back_apply_flag` tinyint(1) NULL DEFAULT 0 COMMENT '是否申请退款(1-是 0-否)',
  `back_date_apply` date NULL DEFAULT NULL COMMENT '申请退款日期',
  `back_memo_apply` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '申请退款原因',
  `back_pro_flag` tinyint(1) NULL DEFAULT 0 COMMENT '协议是否收回(1-是 0-否)',
  `back_date_cancel` date NULL DEFAULT NULL COMMENT '协议解除日期',
  `back_date` date NULL DEFAULT NULL COMMENT '实际退款日期',
  `upload_receipt` tinyint(1) NULL DEFAULT 0 COMMENT '是否上传收据(1-是 0-否)',
  `receipt_addr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '收据地址',
  `receipt_uid` int(11) NULL DEFAULT 0 COMMENT '收据上传人	',
  `receipt_time` datetime NULL DEFAULT NULL COMMENT '收据上传时间',
  `upload_invoice` tinyint(1) NULL DEFAULT 0 COMMENT '是否上传发票(1-是 0-否)',
  `invoice_addr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '发票地址',
  `invoice_uid` int(11) NULL DEFAULT 0 COMMENT '发票上传人',
  `invoice_time` datetime NULL DEFAULT NULL COMMENT '发票上传时间',
  `toout_date` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `toout_memo` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '发货备注',
  `toout_expid` int(11) NULL DEFAULT 0 COMMENT '快递公司ID',
  `toout_expcode` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '快递单号',
  `is_special` tinyint(1) NULL DEFAULT 0 COMMENT '是否特殊审批(1-是 0-否)',
  `get_number` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '采血管编号	',
  `get_infomemo` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注	',
  `test_success_date` date NULL DEFAULT NULL COMMENT '无菌检测合格日期	',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '添加人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user`(`user_id`) USING BTREE,
  INDEX `idx_sales`(`sales_id`) USING BTREE,
  INDEX `idx_mother`(`mother_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '冻干粉订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hm_order_fdp
-- ----------------------------
INSERT INTO `hm_order_fdp` VALUES (1, 2, 'proCode', -1, -1, 1, '2026-01-28', 0.00, 107, 0, 0.00, 180000.00, 0.00, 0.00, NULL, 3, 0, 4, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-01-28 13:54:22');
INSERT INTO `hm_order_fdp` VALUES (2, 1, '5b3ee3e0522a4e139ece23858c388c62', 1, 11, 1, '2026-02-03', 0.00, 107, 0, 0.00, 180000.00, 0.00, 0.00, NULL, 3, 0, 4, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-01-28 14:52:50');
INSERT INTO `hm_order_fdp` VALUES (3, 1, '881a3288f1474cfc91031da0d9e80578', 4, 11, 1, '2026-01-29', 0.00, 107, 0, 0.00, 180000.00, 0.00, 0.00, NULL, 3, 0, 4, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-01-29 18:09:15');
INSERT INTO `hm_order_fdp` VALUES (4, 1, 'proCode', 2, 11, 1, '2026-01-28', 0.00, 107, 0, 0.00, 180000.00, 0.00, 0.00, NULL, 3, 0, 4, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-01-29 18:40:11');
INSERT INTO `hm_order_fdp` VALUES (5, 1, 'proCode', 2, 11, 1, '2026-01-28', 0.00, 107, 0, 0.00, 180000.00, 0.00, 0.00, NULL, 3, 0, 4, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-01-29 18:41:36');
INSERT INTO `hm_order_fdp` VALUES (6, 1, 'proCode', 2, 11, 1, '2026-01-28', 0.00, 107, 0, 0.00, 180000.00, 0.00, 0.00, NULL, 3, 0, 4, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-02-03 09:35:16');
INSERT INTO `hm_order_fdp` VALUES (7, 1, 'proCode', 2, 11, 1, '2026-01-28', 0.00, 107, 0, 0.00, 180000.00, 0.00, 0.00, NULL, 3, 0, 4, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-02-03 09:35:23');
INSERT INTO `hm_order_fdp` VALUES (8, 1, 'proCode', 2, 11, 1, '2026-01-28', 0.00, 107, 0, 0.00, 180000.00, 0.00, 0.00, NULL, 3, 0, 4, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-02-03 09:40:26');
INSERT INTO `hm_order_fdp` VALUES (9, 1, 'proCode', 2, 11, 1, '2026-01-28', 0.00, 107, 0, 0.00, 180000.00, 0.00, 0.00, NULL, 3, 0, 4, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-02-03 09:41:02');
INSERT INTO `hm_order_fdp` VALUES (10, 1, 'proCode', 2, 11, 1, '2026-01-28', 0.00, 107, 0, 0.00, 180000.00, 0.00, 0.00, NULL, 3, 0, 4, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-02-03 09:41:29');
INSERT INTO `hm_order_fdp` VALUES (11, 1, 'proCode', 2, 11, 1, '2026-01-28', 0.00, 107, 0, 0.00, 180000.00, 0.00, 0.00, NULL, 3, 0, 4, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-02-03 09:43:56');
INSERT INTO `hm_order_fdp` VALUES (12, 1, '', 2, 11, 110, '2026-02-03', 0.00, 1, 0, 0.00, 12.00, 0.00, 0.00, NULL, 3, 0, 6, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-02-03 11:23:22');
INSERT INTO `hm_order_fdp` VALUES (13, 1, '', 2, 11, 110, '2026-02-03', 0.00, 1, 0, 0.00, 12.00, 0.00, 0.00, NULL, 3, 0, 6, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-02-03 11:48:29');
INSERT INTO `hm_order_fdp` VALUES (14, 1, '', 2, 11, 110, '2026-02-03', 0.00, 1, 0, 0.00, 12.00, 0.00, 0.00, NULL, 3, 0, 6, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-02-03 11:51:12');
INSERT INTO `hm_order_fdp` VALUES (15, 1, '', 2, 11, 110, '2026-02-03', 0.00, 1, 0, 0.00, 12.00, 0.00, 0.00, NULL, 3, 0, 6, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-02-03 15:45:14');
INSERT INTO `hm_order_fdp` VALUES (16, 1, '', 2, 11, 110, '2026-02-03', 0.00, 1, 0, 0.00, 12.00, 0.00, 0.00, NULL, 3, 0, 6, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-02-03 15:45:56');
INSERT INTO `hm_order_fdp` VALUES (17, 1, 'ef198de619f34a898c8300a652c2bd73', 1, 11, 110, '2026-02-04', 0.00, 1, 0, 0.00, 12.00, 0.00, 0.00, NULL, 3, 0, 6, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-02-04 10:41:36');

-- ----------------------------
-- Table structure for hm_order_fdp_return
-- ----------------------------
DROP TABLE IF EXISTS `hm_order_fdp_return`;
CREATE TABLE `hm_order_fdp_return`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint(20) NULL DEFAULT 0 COMMENT '冻干粉合同ID',
  `pro_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '协议编号',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态（1-申请,2-已退,3-取消）',
  `price` float(10, 2) NULL DEFAULT 0.00 COMMENT '退款金额',
  `sign_date` datetime NULL DEFAULT NULL COMMENT '签约日期',
  `sync_flag` tinyint(1) NULL DEFAULT 0 COMMENT '同步标志',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '添加人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '冻干粉订单退款表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hm_order_fdp_return
-- ----------------------------
INSERT INTO `hm_order_fdp_return` VALUES (1, 1, NULL, 1, 130000.00, '2026-01-27 00:00:00', 0, '', '2026-01-28 15:55:20');
INSERT INTO `hm_order_fdp_return` VALUES (2, 3, '8e5a3fa9ab584d328780f82c85b19d3a', 2, 150000.00, '2026-01-29 18:46:20', 0, '', '2026-01-29 18:44:18');

-- ----------------------------
-- Table structure for hm_payment
-- ----------------------------
DROP TABLE IF EXISTS `hm_payment`;
CREATE TABLE `hm_payment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint(20) NULL DEFAULT NULL COMMENT '订单ID',
  `pay_amount` float(10, 2) NULL DEFAULT 0.00 COMMENT '付款金额',
  `transaction_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信流水号',
  `pay_date` datetime NULL DEFAULT NULL COMMENT '付款时间',
  `sync_flag` tinyint(1) NULL DEFAULT 0 COMMENT '同步标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '付款单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hm_payment
-- ----------------------------
INSERT INTO `hm_payment` VALUES (1, 1, 180000.00, 'lkasdjflasdjfklsdaflsadjfasld', '2026-01-29 00:00:00', 0);

-- ----------------------------
-- Table structure for hm_product
-- ----------------------------
DROP TABLE IF EXISTS `hm_product`;
CREATE TABLE `hm_product`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `product_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '产品名',
  `navbar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '导航栏小图',
  `details` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '详情页大图',
  `price` float(10, 2) NULL DEFAULT 0.00 COMMENT '价格',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '产品信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hm_product
-- ----------------------------
INSERT INTO `hm_product` VALUES (1, '冻干粉', '/profile/upload/2026/01/27/1_20260127213139A001.jpg', '/profile/upload/2026/01/27/2_20260127213143A002.jpg', 12.00);

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日历信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-01-10 10:11:57', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-01-10 10:11:57', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-01-10 10:11:57', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2026-01-10 10:11:57', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2026-01-10 10:11:57', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-01-10 10:11:57', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-10 10:11:57', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-10 10:11:57', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-10 10:11:57', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-10 10:11:57', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-10 10:11:57', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-10 10:11:57', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-10 10:11:57', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-10 10:11:57', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-10 10:11:57', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-10 10:11:57', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(11) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 139 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 1, '身份证', '1', 'sys_user_id_type', '', '', 'Y', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (101, 2, '护照', '2', 'sys_user_id_type', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (102, 3, '永久居留身份证', '3', 'sys_user_id_type', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (103, 4, '台湾来往大陆通行证', '4', 'sys_user_id_type', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (104, 5, '香港来往大陆通行证', '5', 'sys_user_id_type', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (105, 6, '澳门来往大陆通行证', '6', 'sys_user_id_type', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (106, 7, '其它', '10', 'sys_user_id_type', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (107, 1, '身份证', '1', 'hm_mother_id_type', '', 'default', 'Y', '0', 'admin', '2026-01-10 10:11:57', 'admin', '2026-01-27 15:52:58', NULL);
INSERT INTO `sys_dict_data` VALUES (108, 2, '护照', '2', 'hm_mother_id_type', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (109, 3, '永久居留身份证', '3', 'hm_mother_id_type', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (110, 4, '台湾来往大陆通行证', '4', 'hm_mother_id_type', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (111, 5, '香港来往大陆通行证', '5', 'hm_mother_id_type', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (112, 6, '澳门来往大陆通行证', '6', 'hm_mother_id_type', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (113, 7, '其它', '10', 'hm_mother_id_type', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (114, 1, '未交费', '11', 'hm_order_status', '', '', 'Y', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (115, 2, '已缴费', '1', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (116, 3, '接收胎盘', '2', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (117, 4, '已出报告', '3', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (118, 5, '送制备', '12', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (119, 6, '制备接收', '13', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (120, 7, '送辐照', '14', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (121, 8, '辐照接收', '15', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (122, 9, '初检', '16', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (123, 10, '复检', '17', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (124, 11, '成品登记', '8', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (125, 12, '待取货', '9', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (126, 13, '待发货', '10', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (127, 14, '待交付', '4', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (128, 15, '已完成', '5', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (129, 16, '待解除', '6', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (130, 17, '已退费', '7', 'hm_order_status', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (131, 1, '支付宝', '1', 'hm_order_pay_type', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (132, 2, '银行汇款', '2', 'hm_order_pay_type', '', '', 'N', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (133, 3, '微信', '3', 'hm_order_pay_type', '', '', 'Y', '0', 'admin', '2026-01-10 10:11:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (134, 0, '系统用户', '0', 'sys_user_type', NULL, 'default', 'N', '0', 'admin', '2026-01-27 20:47:34', 'admin', '2026-01-27 20:48:43', NULL);
INSERT INTO `sys_dict_data` VALUES (135, 1, '微信用户', '1', 'sys_user_type', NULL, 'default', 'Y', '0', 'admin', '2026-01-27 20:47:52', 'admin', '2026-01-27 20:48:36', NULL);
INSERT INTO `sys_dict_data` VALUES (136, 2, '销售人员', '2', 'sys_user_type', NULL, 'default', 'N', '0', 'admin', '2026-01-27 20:48:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (137, 1, '本人', '0', 'hm_mother_relation', NULL, 'default', 'N', '0', 'admin', '2026-01-28 08:50:44', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (138, 2, '丈夫', '1', 'hm_mother_relation', NULL, 'default', 'N', '0', 'admin', '2026-01-28 08:51:18', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '证件类型', 'sys_user_id_type', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '证件类型列表');
INSERT INTO `sys_dict_type` VALUES (101, '证件类型', 'hm_mother_id_type', '0', 'admin', '2026-01-10 10:11:57', 'admin', '2026-01-27 15:42:45', '证件类型枚举');
INSERT INTO `sys_dict_type` VALUES (102, '订单状态', 'hm_order_status', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '订单状态枚举');
INSERT INTO `sys_dict_type` VALUES (103, '支付方式', 'hm_order_pay_type', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '支付方式枚举');
INSERT INTO `sys_dict_type` VALUES (104, '用户类型', 'sys_user_type', '0', 'admin', '2026-01-27 20:46:38', 'admin', '2026-01-28 08:50:08', '用户类型枚举');
INSERT INTO `sys_dict_type` VALUES (105, '与产妇关系', 'hm_mother_relation', '0', 'admin', '2026-01-28 08:49:47', 'admin', '2026-01-28 08:50:19', '与产妇关系枚举');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-01-10 10:11:57', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status`) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 292 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-13 17:30:04');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-13 17:35:49');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-13 17:55:14');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-14 09:27:00');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-14 10:20:04');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-14 10:56:15');
INSERT INTO `sys_logininfor` VALUES (106, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-14 11:01:50');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-14 14:01:27');
INSERT INTO `sys_logininfor` VALUES (108, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', 'No AuthenticationProvider found for com.healthcare.framework.security.authentication.SmsCodeAuthenticationToken', '2026-01-14 14:03:57');
INSERT INTO `sys_logininfor` VALUES (109, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-01-14 14:08:40');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-14 14:08:53');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-14 14:08:58');
INSERT INTO `sys_logininfor` VALUES (112, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', 'No AuthenticationProvider found for com.healthcare.framework.security.authentication.SmsCodeAuthenticationToken', '2026-01-14 14:10:57');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-14 14:17:20');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-14 14:17:25');
INSERT INTO `sys_logininfor` VALUES (115, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', 'No AuthenticationProvider found for com.healthcare.framework.security.authentication.SmsCodeAuthenticationToken', '2026-01-14 14:19:52');
INSERT INTO `sys_logininfor` VALUES (116, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', 'No AuthenticationProvider found for com.healthcare.framework.security.authentication.SmsCodeAuthenticationToken', '2026-01-14 14:21:00');
INSERT INTO `sys_logininfor` VALUES (117, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', 'No AuthenticationProvider found for com.healthcare.framework.security.authentication.SmsCodeAuthenticationToken', '2026-01-14 14:23:45');
INSERT INTO `sys_logininfor` VALUES (118, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', 'No AuthenticationProvider found for com.healthcare.framework.security.authentication.SmsCodeAuthenticationToken', '2026-01-14 14:27:03');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-14 14:49:48');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-14 14:49:50');
INSERT INTO `sys_logininfor` VALUES (121, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-14 14:56:08');
INSERT INTO `sys_logininfor` VALUES (122, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-14 14:57:45');
INSERT INTO `sys_logininfor` VALUES (123, 'admin123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-14 15:01:15');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-14 15:01:45');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-14 15:01:47');
INSERT INTO `sys_logininfor` VALUES (126, '13512345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-01-14 15:03:06');
INSERT INTO `sys_logininfor` VALUES (127, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-14 15:03:38');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-14 15:59:52');
INSERT INTO `sys_logininfor` VALUES (129, '13612345678 ', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-01-14 16:09:26');
INSERT INTO `sys_logininfor` VALUES (130, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-14 16:11:23');
INSERT INTO `sys_logininfor` VALUES (131, '13612345678 ', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-14 16:12:11');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-15 16:10:01');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-16 13:33:25');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-16 16:48:15');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-16 17:45:59');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-27 10:30:08');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-27 14:26:09');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-27 15:16:06');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-27 18:58:22');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-27 20:15:07');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-27 20:17:43');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-27 20:17:51');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-27 21:18:32');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 08:40:30');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-28 09:16:00');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 09:16:03');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-28 09:45:00');
INSERT INTO `sys_logininfor` VALUES (148, '15888888888', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 09:45:48');
INSERT INTO `sys_logininfor` VALUES (149, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-28 09:47:47');
INSERT INTO `sys_logininfor` VALUES (150, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 09:54:30');
INSERT INTO `sys_logininfor` VALUES (151, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 09:55:26');
INSERT INTO `sys_logininfor` VALUES (152, '15888888888', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 10:08:01');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-28 10:12:37');
INSERT INTO `sys_logininfor` VALUES (154, '15888888888', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 10:15:57');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-28 10:17:27');
INSERT INTO `sys_logininfor` VALUES (156, '15888888888', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 10:19:50');
INSERT INTO `sys_logininfor` VALUES (157, '15888888888', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 11:07:16');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-28 11:33:12');
INSERT INTO `sys_logininfor` VALUES (159, '13687654322', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-01-28 11:33:56');
INSERT INTO `sys_logininfor` VALUES (160, '13687654322', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-01-28 11:34:05');
INSERT INTO `sys_logininfor` VALUES (161, '13687654322', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 11:34:27');
INSERT INTO `sys_logininfor` VALUES (162, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-28 11:35:05');
INSERT INTO `sys_logininfor` VALUES (163, '13687654322', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 11:35:07');
INSERT INTO `sys_logininfor` VALUES (164, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-28 11:36:15');
INSERT INTO `sys_logininfor` VALUES (165, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 11:36:19');
INSERT INTO `sys_logininfor` VALUES (166, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-28 11:36:58');
INSERT INTO `sys_logininfor` VALUES (167, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-01-28 11:37:00');
INSERT INTO `sys_logininfor` VALUES (168, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-01-28 11:37:02');
INSERT INTO `sys_logininfor` VALUES (169, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 11:37:15');
INSERT INTO `sys_logininfor` VALUES (170, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-28 11:38:15');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 11:38:20');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-28 11:39:22');
INSERT INTO `sys_logininfor` VALUES (173, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 11:39:34');
INSERT INTO `sys_logininfor` VALUES (174, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 12:57:10');
INSERT INTO `sys_logininfor` VALUES (175, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-28 12:57:21');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 12:57:25');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 13:40:43');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-28 13:53:54');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 13:53:58');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 14:36:13');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-28 15:24:14');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 15:24:18');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 18:16:23');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 19:17:51');
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 20:23:38');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-29 09:40:28');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '221.216.154.199', 'XX XX', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-29 11:58:39');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-29 16:38:22');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-29 17:21:39');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-29 18:05:05');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-30 12:03:27');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-30 12:03:31');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-30 12:03:32');
INSERT INTO `sys_logininfor` VALUES (194, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '用户不存在/密码错误', '2026-01-30 12:53:56');
INSERT INTO `sys_logininfor` VALUES (195, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '用户不存在/密码错误', '2026-01-30 12:54:16');
INSERT INTO `sys_logininfor` VALUES (196, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '用户不存在/密码错误', '2026-01-30 12:54:19');
INSERT INTO `sys_logininfor` VALUES (197, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '用户不存在/密码错误', '2026-01-30 12:54:33');
INSERT INTO `sys_logininfor` VALUES (198, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '用户不存在/密码错误', '2026-01-30 12:59:35');
INSERT INTO `sys_logininfor` VALUES (199, '15888888888', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-30 13:01:04');
INSERT INTO `sys_logininfor` VALUES (200, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 13:05:10');
INSERT INTO `sys_logininfor` VALUES (201, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 13:09:38');
INSERT INTO `sys_logininfor` VALUES (202, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 13:09:48');
INSERT INTO `sys_logininfor` VALUES (203, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 13:14:11');
INSERT INTO `sys_logininfor` VALUES (204, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 13:16:21');
INSERT INTO `sys_logininfor` VALUES (205, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 13:16:36');
INSERT INTO `sys_logininfor` VALUES (206, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 13:18:09');
INSERT INTO `sys_logininfor` VALUES (207, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 13:19:11');
INSERT INTO `sys_logininfor` VALUES (208, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 13:32:19');
INSERT INTO `sys_logininfor` VALUES (209, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-30 13:34:10');
INSERT INTO `sys_logininfor` VALUES (210, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-30 14:26:25');
INSERT INTO `sys_logininfor` VALUES (211, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-30 15:27:03');
INSERT INTO `sys_logininfor` VALUES (212, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 15:49:50');
INSERT INTO `sys_logininfor` VALUES (213, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 15:50:35');
INSERT INTO `sys_logininfor` VALUES (214, '15699736798', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-30 15:50:57');
INSERT INTO `sys_logininfor` VALUES (215, '15699736798', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-30 15:50:59');
INSERT INTO `sys_logininfor` VALUES (216, '15699736798', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-30 15:51:20');
INSERT INTO `sys_logininfor` VALUES (217, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '注册成功', '2026-01-30 16:08:42');
INSERT INTO `sys_logininfor` VALUES (218, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 16:08:43');
INSERT INTO `sys_logininfor` VALUES (219, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 16:09:58');
INSERT INTO `sys_logininfor` VALUES (220, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 16:10:44');
INSERT INTO `sys_logininfor` VALUES (221, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 16:13:04');
INSERT INTO `sys_logininfor` VALUES (222, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 16:15:32');
INSERT INTO `sys_logininfor` VALUES (223, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 16:16:53');
INSERT INTO `sys_logininfor` VALUES (224, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-30 16:29:41');
INSERT INTO `sys_logininfor` VALUES (225, '15888888888', '36.101.158.35', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-31 00:13:38');
INSERT INTO `sys_logininfor` VALUES (226, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-31 09:42:20');
INSERT INTO `sys_logininfor` VALUES (227, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-31 09:42:28');
INSERT INTO `sys_logininfor` VALUES (228, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-01-31 09:43:00');
INSERT INTO `sys_logininfor` VALUES (229, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '登录用户：13612345678 不存在', '2026-01-31 09:48:18');
INSERT INTO `sys_logininfor` VALUES (230, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '登录用户：13612345678 不存在', '2026-01-31 09:48:24');
INSERT INTO `sys_logininfor` VALUES (231, '13612345678', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-31 09:49:44');
INSERT INTO `sys_logininfor` VALUES (232, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-31 23:45:14');
INSERT INTO `sys_logininfor` VALUES (233, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '退出成功', '2026-01-31 23:50:29');
INSERT INTO `sys_logininfor` VALUES (234, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-01-31 23:53:00');
INSERT INTO `sys_logininfor` VALUES (235, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-01 17:08:35');
INSERT INTO `sys_logininfor` VALUES (236, '15888888888', '36.101.158.50', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-01 18:56:39');
INSERT INTO `sys_logininfor` VALUES (237, '15801515490', '117.129.82.197', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2026-02-01 22:09:28');
INSERT INTO `sys_logininfor` VALUES (238, '15888888888', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-01 22:49:09');
INSERT INTO `sys_logininfor` VALUES (239, '15888888888', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-01 22:49:33');
INSERT INTO `sys_logininfor` VALUES (240, '13581708896', '36.101.158.50', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '注册成功', '2026-02-01 23:27:44');
INSERT INTO `sys_logininfor` VALUES (241, '13581708896', '36.101.158.50', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-01 23:27:44');
INSERT INTO `sys_logininfor` VALUES (242, '15888888888', '36.101.83.28', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-02 14:16:29');
INSERT INTO `sys_logininfor` VALUES (243, '15888888888', '36.101.83.28', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-02 14:16:52');
INSERT INTO `sys_logininfor` VALUES (244, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-02 20:47:03');
INSERT INTO `sys_logininfor` VALUES (245, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 20:59:49');
INSERT INTO `sys_logininfor` VALUES (246, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 20:59:57');
INSERT INTO `sys_logininfor` VALUES (247, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 21:00:17');
INSERT INTO `sys_logininfor` VALUES (248, '15888888888', '36.101.83.28', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-02 21:10:01');
INSERT INTO `sys_logininfor` VALUES (249, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 23:22:40');
INSERT INTO `sys_logininfor` VALUES (250, '15801515490', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 23:29:20');
INSERT INTO `sys_logininfor` VALUES (251, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-02 23:32:47');
INSERT INTO `sys_logininfor` VALUES (252, '15888888888', '36.101.83.28', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-02 23:38:59');
INSERT INTO `sys_logininfor` VALUES (253, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-03 09:34:19');
INSERT INTO `sys_logininfor` VALUES (254, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-03 10:11:36');
INSERT INTO `sys_logininfor` VALUES (255, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-03 11:21:58');
INSERT INTO `sys_logininfor` VALUES (256, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-03 13:59:06');
INSERT INTO `sys_logininfor` VALUES (257, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-03 14:48:39');
INSERT INTO `sys_logininfor` VALUES (258, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-03 15:44:55');
INSERT INTO `sys_logininfor` VALUES (259, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-03 16:35:00');
INSERT INTO `sys_logininfor` VALUES (260, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-03 16:35:07');
INSERT INTO `sys_logininfor` VALUES (261, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-03 16:35:43');
INSERT INTO `sys_logininfor` VALUES (262, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-04 09:47:44');
INSERT INTO `sys_logininfor` VALUES (263, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-04 10:10:43');
INSERT INTO `sys_logininfor` VALUES (264, 'admin', '221.216.154.199', 'XX XX', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-04 10:24:38');
INSERT INTO `sys_logininfor` VALUES (265, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-04 11:38:36');
INSERT INTO `sys_logininfor` VALUES (266, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-04 13:08:27');
INSERT INTO `sys_logininfor` VALUES (267, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-04 14:00:12');
INSERT INTO `sys_logininfor` VALUES (268, NULL, '150.255.208.13', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '* 必须填写', '2026-02-04 14:21:38');
INSERT INTO `sys_logininfor` VALUES (269, NULL, '150.255.208.13', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '* 必须填写', '2026-02-04 14:23:15');
INSERT INTO `sys_logininfor` VALUES (270, 'admin', '150.255.208.13', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-04 14:27:01');
INSERT INTO `sys_logininfor` VALUES (271, 'admin', '150.255.208.13', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-04 14:28:16');
INSERT INTO `sys_logininfor` VALUES (272, 'admin', '150.255.208.13', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-04 14:32:45');
INSERT INTO `sys_logininfor` VALUES (273, 'admin', '150.255.208.13', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-04 14:33:24');
INSERT INTO `sys_logininfor` VALUES (274, 'admin', '150.255.208.13', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-04 14:36:57');
INSERT INTO `sys_logininfor` VALUES (275, 'admin', '150.255.208.13', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-04 14:37:37');
INSERT INTO `sys_logininfor` VALUES (276, 'admin', '150.255.208.13', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '用户不存在/密码错误', '2026-02-04 14:38:11');
INSERT INTO `sys_logininfor` VALUES (277, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-04 14:40:25');
INSERT INTO `sys_logininfor` VALUES (278, '15699736798', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-04 14:44:07');
INSERT INTO `sys_logininfor` VALUES (279, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-04 15:42:47');
INSERT INTO `sys_logininfor` VALUES (280, '15699736798', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-04 17:22:14');
INSERT INTO `sys_logininfor` VALUES (281, '15888888888', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-04 17:49:36');
INSERT INTO `sys_logininfor` VALUES (282, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-04 17:50:45');
INSERT INTO `sys_logininfor` VALUES (283, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-04 17:57:32');
INSERT INTO `sys_logininfor` VALUES (284, '15699736798', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-04 18:17:48');
INSERT INTO `sys_logininfor` VALUES (285, '15699736798', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-02-04 18:36:59');
INSERT INTO `sys_logininfor` VALUES (286, '15699736798', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-04 18:37:41');
INSERT INTO `sys_logininfor` VALUES (287, '15699736798', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-02-04 18:46:42');
INSERT INTO `sys_logininfor` VALUES (288, '15699736798', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-04 18:46:53');
INSERT INTO `sys_logininfor` VALUES (289, '15801515490', '117.129.82.197', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2026-02-05 11:24:12');
INSERT INTO `sys_logininfor` VALUES (290, '15801515490', '117.129.82.197', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2026-02-05 11:47:55');
INSERT INTO `sys_logininfor` VALUES (291, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-05 14:03:40');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(11) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(11) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2096 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-01-10 10:11:57', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-01-10 10:11:57', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-01-10 10:11:57', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (5, '产品信息', 3, 5, 'product', 'system/product/index', NULL, 1, 0, 'M', '0', '0', 'system:product:list', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '产品信息菜单');
INSERT INTO `sys_menu` VALUES (6, '冻干粉订单', 3, 6, 'fdp', 'system/fdp/index', NULL, 1, 0, 'M', '0', '0', 'system:fdp:list', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '冻干粉订单菜单');
INSERT INTO `sys_menu` VALUES (7, '产妇信息', 3, 7, 'mother', 'system/mother/index', NULL, 1, 0, 'M', '0', '0', 'system:mother:list', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '产妇信息菜单');
INSERT INTO `sys_menu` VALUES (8, '冻干粉订单退款', 3, 8, 'return', 'system/return/index', NULL, 1, 0, 'C', '0', '0', 'system:return:list', '#', 'admin', '2026-01-28 15:21:54', '', NULL, '冻干粉订单退款菜单');
INSERT INTO `sys_menu` VALUES (9, '付款单', 3, 9, 'payment', 'system/payment/index', NULL, 1, 0, 'C', '0', '0', 'system:payment:list', '#', 'admin', '2026-01-29 17:19:32', '', NULL, '付款单菜单');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-01-10 10:11:57', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-01-10 10:11:57', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-01-10 10:11:57', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-01-10 10:11:57', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2026-01-10 10:11:57', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-01-10 10:11:57', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-01-10 10:11:57', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-01-10 10:11:57', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-01-10 10:11:57', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-01-10 10:11:57', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-01-10 10:11:57', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-01-10 10:11:57', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-01-10 10:11:57', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-01-10 10:11:57', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-01-10 10:11:57', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-01-10 10:11:57', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-01-10 10:11:57', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-01-10 10:11:57', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-01-10 10:11:57', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-01-10 10:11:57', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2067, '产品信息查询', 5, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:product:query', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2068, '产品信息新增', 5, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:product:add', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2069, '产品信息修改', 5, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:product:edit', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2070, '产品信息删除', 5, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:product:remove', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2071, '产品信息导出', 5, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:product:export', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2073, '冻干粉订单查询', 6, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fdp:query', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2074, '冻干粉订单新增', 6, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fdp:add', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2075, '冻干粉订单修改', 6, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fdp:edit', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2076, '冻干粉订单删除', 6, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fdp:remove', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2077, '冻干粉订单导出', 6, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fdp:export', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2079, '产妇信息查询', 7, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:mother:query', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2080, '产妇信息新增', 7, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:mother:add', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2081, '产妇信息修改', 7, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:mother:edit', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2082, '产妇信息删除', 7, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:mother:remove', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2083, '产妇信息导出', 7, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:mother:export', '#', 'admin', '2026-01-27 14:31:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2085, '冻干粉订单退款查询', 8, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:return:query', '#', 'admin', '2026-01-28 15:21:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2086, '冻干粉订单退款新增', 8, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:return:add', '#', 'admin', '2026-01-28 15:21:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2087, '冻干粉订单退款修改', 8, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:return:edit', '#', 'admin', '2026-01-28 15:21:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2088, '冻干粉订单退款删除', 8, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:return:remove', '#', 'admin', '2026-01-28 15:21:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2089, '冻干粉订单退款导出', 8, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:return:export', '#', 'admin', '2026-01-28 15:21:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2091, '付款单查询', 9, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:payment:query', '#', 'admin', '2026-01-29 17:19:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2092, '付款单新增', 9, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:payment:add', '#', 'admin', '2026-01-29 17:19:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2093, '付款单修改', 9, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:payment:edit', '#', 'admin', '2026-01-29 17:19:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2094, '付款单删除', 9, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:payment:remove', '#', 'admin', '2026-01-29 17:19:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2095, '付款单导出', 9, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:payment:export', '#', 'admin', '2026-01-29 17:19:32', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-01-10 10:11:57', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-01-10 10:11:57', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(11) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(11) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(11) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type`) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status`) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 216 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"nickName\":\"张三\",\"params\":{},\"phonenumber\":\"13687654321\",\"updateBy\":\"admin\",\"userId\":104,\"userName\":\"13687654321\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-14 16:31:57', 162);
INSERT INTO `sys_oper_log` VALUES (101, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"nickName\":\"张三\",\"params\":{},\"phonenumber\":\"13687654321\",\"userId\":105,\"userName\":\"13687654321\"}', '{\"msg\":\"修改用户\'13687654321\'失败，登录账号已存在\",\"code\":500}', 0, NULL, '2026-01-14 16:33:23', 18);
INSERT INTO `sys_oper_log` VALUES (102, '代码生成', 6, 'com.healthcare.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"hm_agency_content,hm_customer,hm_departent,hm_entry,hm_file,hm_hospital,hm_lecture,hm_order_accompany,hm_order_agency,hm_order_guidance,hm_order_in_hospital,hm_order_nursing,hm_order_out_hospital,hm_order_status,hm_patient,hm_service\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 10:34:35', 2816);
INSERT INTO `sys_oper_log` VALUES (103, '代码生成', 8, 'com.healthcare.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"hm_agency_content,hm_customer,hm_departent,hm_entry,hm_file,hm_hospital,hm_lecture,hm_order_accompany,hm_order_agency,hm_order_guidance,hm_order_in_hospital,hm_order_nursing,hm_order_out_hospital,hm_order_status,hm_patient,hm_service\"}', NULL, 0, NULL, '2026-01-27 10:35:06', 5902);
INSERT INTO `sys_oper_log` VALUES (104, '代码生成', 3, 'com.healthcare.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/11,12,13,14,15,16', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 14:26:24', 116);
INSERT INTO `sys_oper_log` VALUES (105, '代码生成', 3, 'com.healthcare.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/1,2,3,4,5,6,7,8,9,10', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 14:26:30', 26);
INSERT INTO `sys_oper_log` VALUES (106, '代码生成', 6, 'com.healthcare.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"hm_mother,hm_order_fdp,hm_order_fdp_return,hm_product\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 14:26:46', 1315);
INSERT INTO `sys_oper_log` VALUES (107, '代码生成', 8, 'com.healthcare.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"hm_mother,hm_order_fdp,hm_order_fdp_return,hm_product\"}', NULL, 0, NULL, '2026-01-27 14:26:53', 2506);
INSERT INTO `sys_oper_log` VALUES (108, '字典类型', 9, 'com.healthcare.web.controller.system.SysDictTypeController.refreshCache()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/refreshCache', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 15:19:30', 99);
INSERT INTO `sys_oper_log` VALUES (109, '产妇信息', 1, 'com.healthcare.web.controller.system.HmMotherController.add()', 'POST', 1, 'admin', '研发部门', '/system/mother', '127.0.0.1', '内网IP', '{\"address\":\"3333\",\"dueDate\":\"2026-01-07\",\"email\":\"3213213\",\"hospitalName\":\"123123213\",\"id\":1,\"idCode\":\"123123213\",\"motherName\":\"12321321\",\"params\":{},\"phonenumber\":\"123213\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 15:22:18', 507);
INSERT INTO `sys_oper_log` VALUES (110, '字典类型', 2, 'com.healthcare.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"\",\"dictId\":101,\"dictName\":\"证件类型\",\"dictType\":\"hm_mother_id_type\",\"params\":{},\"remark\":\"证件类型枚举\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 15:42:46', 128);
INSERT INTO `sys_oper_log` VALUES (111, '字典类型', 9, 'com.healthcare.web.controller.system.SysDictTypeController.refreshCache()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/refreshCache', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 15:44:02', 68);
INSERT INTO `sys_oper_log` VALUES (112, '字典类型', 9, 'com.healthcare.web.controller.system.SysDictTypeController.refreshCache()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/refreshCache', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 15:44:20', 81);
INSERT INTO `sys_oper_log` VALUES (113, '字典数据', 2, 'com.healthcare.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"\",\"default\":true,\"dictCode\":107,\"dictLabel\":\"身份证\",\"dictSort\":1,\"dictType\":\"hm_mother_id_type\",\"dictValue\":\"1\",\"isDefault\":\"Y\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 15:52:58', 59);
INSERT INTO `sys_oper_log` VALUES (114, '字典类型', 9, 'com.healthcare.web.controller.system.SysDictTypeController.refreshCache()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/refreshCache', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 15:53:05', 54);
INSERT INTO `sys_oper_log` VALUES (115, '字典类型', 9, 'com.healthcare.web.controller.system.SysDictTypeController.refreshCache()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/refreshCache', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 16:06:55', 42);
INSERT INTO `sys_oper_log` VALUES (116, '用户管理', 5, 'com.healthcare.web.controller.system.SysUserController.export()', 'POST', 1, 'admin', '研发部门', '/system/user/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2026-01-27 16:32:00', 2827);
INSERT INTO `sys_oper_log` VALUES (117, '用户头像', 2, 'com.healthcare.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2026/01/27/avatar_20260127185850A001.png\",\"code\":200}', 0, NULL, '2026-01-27 18:58:50', 616);
INSERT INTO `sys_oper_log` VALUES (118, '字典类型', 9, 'com.healthcare.web.controller.system.SysDictTypeController.refreshCache()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/refreshCache', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:38:18', 181);
INSERT INTO `sys_oper_log` VALUES (119, '字典类型', 1, 'com.healthcare.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"用户类型\",\"dictType\":\"sys_user_type\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:46:39', 98);
INSERT INTO `sys_oper_log` VALUES (120, '字典类型', 1, 'com.healthcare.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"dictName\":\"用户类型\",\"dictType\":\"sys_user_type\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"新增字典\'用户类型\'失败，字典类型已存在\",\"code\":500}', 0, NULL, '2026-01-27 20:46:39', 24);
INSERT INTO `sys_oper_log` VALUES (121, '字典数据', 1, 'com.healthcare.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"系统用户\",\"dictSort\":0,\"dictType\":\"sys_user_type\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:47:34', 86);
INSERT INTO `sys_oper_log` VALUES (122, '字典数据', 1, 'com.healthcare.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"微信用户\",\"dictSort\":2,\"dictType\":\"sys_user_type\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:47:52', 29);
INSERT INTO `sys_oper_log` VALUES (123, '字典数据', 1, 'com.healthcare.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"销售人员\",\"dictSort\":2,\"dictType\":\"sys_user_type\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:48:15', 24);
INSERT INTO `sys_oper_log` VALUES (124, '字典数据', 2, 'com.healthcare.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:47:52\",\"default\":false,\"dictCode\":135,\"dictLabel\":\"微信用户\",\"dictSort\":1,\"dictType\":\"sys_user_type\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:48:36', 31);
INSERT INTO `sys_oper_log` VALUES (125, '字典数据', 2, 'com.healthcare.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:47:34\",\"default\":false,\"dictCode\":134,\"dictLabel\":\"系统用户\",\"dictSort\":0,\"dictType\":\"sys_user_type\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:48:43', 32);
INSERT INTO `sys_oper_log` VALUES (126, '用户管理', 1, 'com.healthcare.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"销售人员\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userName\":\"销售人员\",\"userType\":\"2\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id_type\' doesn\'t have a default value\r\n### The error may exist in file [D:\\workspace\\health\\healthcare\\BackendSystem\\healthcare-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.healthcare.system.mapper.SysUserMapper.insertUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_user(                  user_name,       nick_name,                               password,       status,                   create_by,            create_time    )values(                  ?,       ?,                               ?,       ?,                   ?,            sysdate()    )\r\n### Cause: java.sql.SQLException: Field \'id_type\' doesn\'t have a default value\n; Field \'id_type\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id_type\' doesn\'t have a default value', '2026-01-27 20:52:27', 2354);
INSERT INTO `sys_oper_log` VALUES (127, '用户管理', 1, 'com.healthcare.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"销售人员\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":105,\"userName\":\"销售人员\",\"userType\":\"2\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:53:30', 286);
INSERT INTO `sys_oper_log` VALUES (128, '用户管理', 1, 'com.healthcare.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"xs\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":106,\"userName\":\"xs\",\"userType\":\"2\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:56:43', 104301);
INSERT INTO `sys_oper_log` VALUES (129, '代码生成', 2, 'com.healthcare.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"product\",\"className\":\"HmProduct\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":250,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 14:26:46\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":20,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ProductName\",\"columnComment\":\"产品名\",\"columnId\":251,\"columnName\":\"product_name\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 14:26:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"productName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":20,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Navbar\",\"columnComment\":\"导航栏小图\",\"columnId\":252,\"columnName\":\"navbar\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 14:26:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"navbar\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":20,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Details\",\"columnComment\":\"详情页大图\",\"columnId\":253,\"columnName\":\"details\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-27 14:26:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isR', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 21:26:46', 256);
INSERT INTO `sys_oper_log` VALUES (130, '代码生成', 8, 'com.healthcare.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"hm_product\"}', NULL, 0, NULL, '2026-01-27 21:26:54', 1264);
INSERT INTO `sys_oper_log` VALUES (131, '产品信息', 1, 'com.healthcare.web.controller.system.HmProductController.add()', 'POST', 1, 'admin', '研发部门', '/system/product', '127.0.0.1', '内网IP', '{\"details\":\"/profile/upload/2026/01/27/2_20260127213143A002.jpg\",\"navbar\":\"/profile/upload/2026/01/27/1_20260127213139A001.jpg\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'navbar\' at row 1\r\n### The error may exist in file [D:\\workspace\\health\\healthcare\\BackendSystem\\healthcare-system\\target\\classes\\mapper\\system\\HmProductMapper.xml]\r\n### The error may involve com.healthcare.system.mapper.HmProductMapper.insertHmProduct-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into hm_product          ( navbar,             details )           values ( ?,             ? )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'navbar\' at row 1\n; Data truncation: Data too long for column \'navbar\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'navbar\' at row 1', '2026-01-27 21:31:46', 976);
INSERT INTO `sys_oper_log` VALUES (132, '产品信息', 1, 'com.healthcare.web.controller.system.HmProductController.add()', 'POST', 1, 'admin', '研发部门', '/system/product', '127.0.0.1', '内网IP', '{\"details\":\"/profile/upload/2026/01/27/2_20260127213143A002.jpg\",\"id\":1,\"navbar\":\"/profile/upload/2026/01/27/1_20260127213139A001.jpg\",\"params\":{},\"productName\":\"冻干粉\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 21:33:19', 30);
INSERT INTO `sys_oper_log` VALUES (133, '代码生成', 3, 'com.healthcare.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/17,18,19,20', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 08:40:50', 73);
INSERT INTO `sys_oper_log` VALUES (134, '代码生成', 6, 'com.healthcare.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"hm_order_fdp_return,hm_mother,hm_product\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 08:41:28', 593);
INSERT INTO `sys_oper_log` VALUES (135, '代码生成', 8, 'com.healthcare.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"hm_mother,hm_order_fdp_return,hm_product\"}', NULL, 0, NULL, '2026-01-28 08:41:38', 2225);
INSERT INTO `sys_oper_log` VALUES (136, '产品信息', 2, 'com.healthcare.web.controller.system.HmProductController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/product', '127.0.0.1', '内网IP', '{\"details\":\"/profile/upload/2026/01/27/2_20260127213143A002.jpg\",\"id\":1,\"navbar\":\"/profile/upload/2026/01/27/1_20260127213139A001.jpg\",\"params\":{},\"price\":12,\"productName\":\"冻干粉\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 08:47:01', 91);
INSERT INTO `sys_oper_log` VALUES (137, '字典类型', 1, 'com.healthcare.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"与产妇关系\",\"dictType\":\"hm_mother_relation\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 08:49:47', 64);
INSERT INTO `sys_oper_log` VALUES (138, '字典类型', 2, 'com.healthcare.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:46:38\",\"dictId\":104,\"dictName\":\"用户类型\",\"dictType\":\"sys_user_type\",\"params\":{},\"remark\":\"用户类型枚举\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 08:50:08', 85);
INSERT INTO `sys_oper_log` VALUES (139, '字典类型', 2, 'com.healthcare.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-01-28 08:49:47\",\"dictId\":105,\"dictName\":\"与产妇关系\",\"dictType\":\"hm_mother_relation\",\"params\":{},\"remark\":\"与产妇关系枚举\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 08:50:19', 100);
INSERT INTO `sys_oper_log` VALUES (140, '字典数据', 1, 'com.healthcare.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"本人\",\"dictSort\":1,\"dictType\":\"hm_mother_relation\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 08:50:44', 64);
INSERT INTO `sys_oper_log` VALUES (141, '字典数据', 1, 'com.healthcare.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"丈夫\",\"dictSort\":2,\"dictType\":\"hm_mother_relation\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 08:51:18', 32);
INSERT INTO `sys_oper_log` VALUES (142, '字典类型', 9, 'com.healthcare.web.controller.system.SysDictTypeController.refreshCache()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/refreshCache', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 08:51:35', 130);
INSERT INTO `sys_oper_log` VALUES (143, '产妇信息', 1, 'com.healthcare.web.controller.system.HmMotherController.add()', 'POST', 1, 'admin', '研发部门', '/system/mother', '127.0.0.1', '内网IP', '{\"address\":\"地址地址地址地址\",\"dueDate\":\"2026-01-29\",\"email\":\"xxx@163.com\",\"hospitalName\":\"预产医院\",\"id\":2,\"idCode\":\"122231232312331\",\"idType\":\"3\",\"motherName\":\"产妇\",\"params\":{},\"phonenumber\":\"13545648795\",\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 09:02:32', 48);
INSERT INTO `sys_oper_log` VALUES (144, '代码生成', 2, 'com.healthcare.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"product\",\"className\":\"HmProduct\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":272,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 08:41:27\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":23,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ProductName\",\"columnComment\":\"产品名\",\"columnId\":273,\"columnName\":\"product_name\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 08:41:27\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"productName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":23,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Navbar\",\"columnComment\":\"导航栏小图\",\"columnId\":274,\"columnName\":\"navbar\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 08:41:27\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"navbar\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":23,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Details\",\"columnComment\":\"详情页大图\",\"columnId\":275,\"columnName\":\"details\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 08:41:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"i', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 09:05:51', 287);
INSERT INTO `sys_oper_log` VALUES (145, '代码生成', 8, 'com.healthcare.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"hm_product\"}', NULL, 0, NULL, '2026-01-28 09:05:56', 1175);
INSERT INTO `sys_oper_log` VALUES (146, '产妇信息', 2, 'com.healthcare.web.controller.system.HmMotherController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/mother', '127.0.0.1', '内网IP', '{\"address\":\"地址地址地址地址\",\"dueDate\":\"2026-01-29\",\"email\":\"xxx@163.com\",\"hospitalName\":\"预产医院\",\"id\":2,\"idCode\":\"122231232312331\",\"idType\":\"3\",\"motherName\":\"产妇\",\"motherRelation\":\"1\",\"params\":{},\"phonenumber\":\"13545648795\",\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 09:18:13', 12);
INSERT INTO `sys_oper_log` VALUES (147, '产妇信息', 2, 'com.healthcare.web.controller.system.HmMotherController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/mother', '127.0.0.1', '内网IP', '{\"address\":\"地址地址地址地址\",\"dueDate\":\"2026-01-29\",\"email\":\"xxx@163.com\",\"hospitalName\":\"预产医院\",\"id\":2,\"idCode\":\"122231232312331\",\"idType\":\"3\",\"motherName\":\"产妇\",\"motherRelation\":\"1\",\"params\":{},\"phonenumber\":\"13545648795\",\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 09:18:24', 16);
INSERT INTO `sys_oper_log` VALUES (148, '产妇信息', 2, 'com.healthcare.web.controller.system.HmMotherController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/mother', '127.0.0.1', '内网IP', '{\"address\":\"地址地址地址地址\",\"dueDate\":\"2026-01-29\",\"email\":\"xxx@163.com\",\"hospitalName\":\"预产医院\",\"id\":2,\"idCode\":\"122231232312331\",\"idType\":\"3\",\"motherName\":\"产妇\",\"motherRelation\":\"1\",\"params\":{},\"phonenumber\":\"13545648795\",\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 09:21:22', 16);
INSERT INTO `sys_oper_log` VALUES (149, '产妇信息', 2, 'com.healthcare.web.controller.system.HmMotherController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/mother', '127.0.0.1', '内网IP', '{\"address\":\"地址地址地址地址\",\"dueDate\":\"2026-01-29\",\"email\":\"xxx@163.com\",\"hospitalName\":\"预产医院\",\"id\":2,\"idCode\":\"122231232312331\",\"idType\":\"3\",\"motherName\":\"产妇\",\"motherRelation\":\"1\",\"params\":{},\"phonenumber\":\"13545648795\",\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 09:23:02', 13);
INSERT INTO `sys_oper_log` VALUES (150, '产妇信息', 2, 'com.healthcare.web.controller.system.HmMotherController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/mother', '127.0.0.1', '内网IP', '{\"address\":\"地址地址地址地址\",\"dueDate\":\"2026-01-29\",\"email\":\"xxx@163.com\",\"hospitalName\":\"预产医院\",\"id\":2,\"idCode\":\"122231232312331\",\"idType\":\"3\",\"motherName\":\"产妇\",\"motherRelation\":\"0\",\"params\":{},\"phonenumber\":\"13545648795\",\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 09:24:29', 14);
INSERT INTO `sys_oper_log` VALUES (151, '产妇信息', 2, 'com.healthcare.web.controller.system.HmMotherController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/mother', '127.0.0.1', '内网IP', '{\"address\":\"地址地址地址地址\",\"dueDate\":\"2026-01-29\",\"email\":\"xxx@163.com\",\"hospitalName\":\"预产医院\",\"id\":2,\"idCode\":\"122231232312331\",\"idType\":\"1\",\"motherName\":\"产妇\",\"motherRelation\":\"0\",\"params\":{},\"phonenumber\":\"13545648795\",\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 09:24:44', 11);
INSERT INTO `sys_oper_log` VALUES (152, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2026-01-28 09:47:47\",\"delFlag\":\"0\",\"email\":\"\",\"idCode\":\"\",\"idType\":\"0\",\"loginDate\":\"2026-01-28 09:55:26\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"小二黑\",\"params\":{},\"phonenumber\":\"13612345678\",\"postIds\":[],\"roleIds\":[],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":107,\"userName\":\"13612345678\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 09:56:18', 131);
INSERT INTO `sys_oper_log` VALUES (153, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"asdfsd@111.com\",\"params\":{},\"phonenumber\":\"13687654321\",\"userId\":107,\"userName\":\"13612345678\"}', '{\"msg\":\"修改用户\'13612345678\'失败，手机号码已存在\",\"code\":500}', 0, NULL, '2026-01-28 11:07:56', 44);
INSERT INTO `sys_oper_log` VALUES (154, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"asdfsd@111.com\",\"params\":{},\"phonenumber\":\"13687654322\",\"updateBy\":\"admin\",\"userId\":107,\"userName\":\"13612345678\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:08:27', 260);
INSERT INTO `sys_oper_log` VALUES (155, '用户管理', 1, 'com.healthcare.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"D:/wamp64/www/qrcode/dd67563f-08fe-40c6-8650-6d40f50c73c9.png\",\"createBy\":\"admin\",\"nickName\":\"销售二维码\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":108,\"userName\":\"销售二维码\",\"userType\":\"2\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 11:12:51', 3118);
INSERT INTO `sys_oper_log` VALUES (156, '填写产妇和甲方信息', 0, 'com.healthcare.web.controller.system.HmMotherController.editMotherUser()', 'PUT', 1, 'admin', '研发部门', '/system/mother/editMotherUser', '127.0.0.1', '内网IP', '{\"address\":\"海淀区甲1号\",\"dueDate\":\"2026-02-28\",\"hospitalName\":\"解放军301医院\",\"motherEmail\":\"mother@mail.com\",\"motherId\":0,\"motherIdCode\":\"12345678990000\",\"motherIdType\":\"1\",\"motherName\":\"产妇1号\",\"motherPhone\":\"1234567890123\",\"motherRelation\":\"1\",\"nickName\":\"产妇1号甲方\",\"params\":{},\"userId\":1,\"userIdCode\":\"产妇1号甲方\",\"userIdType\":\"6\",\"userPhone\":\"1234567890123\"}', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'phonenumber\' at row 1\r\n### The error may exist in file [D:\\workspace\\health\\healthcare\\BackendSystem\\healthcare-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.healthcare.system.mapper.SysUserMapper.updateUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user     SET nick_name = ?,          phonenumber = ?,                         id_type = ?,     id_code = ?,                         update_time = sysdate()     where user_id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'phonenumber\' at row 1\n; Data truncation: Data too long for column \'phonenumber\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'phonenumber\' at row 1', '2026-01-28 13:00:59', 536);
INSERT INTO `sys_oper_log` VALUES (157, '填写产妇和甲方信息', 0, 'com.healthcare.web.controller.system.HmMotherController.editMotherUser()', 'PUT', 1, 'admin', '研发部门', '/system/mother/editMotherUser', '127.0.0.1', '内网IP', '{\"address\":\"海淀区甲1号\",\"dueDate\":\"2026-02-28\",\"hospitalName\":\"解放军301医院\",\"motherEmail\":\"mother@mail.com\",\"motherId\":0,\"motherIdCode\":\"12345678990000\",\"motherIdType\":\"1\",\"motherName\":\"产妇1号\",\"motherPhone\":\"1234567890123\",\"motherRelation\":\"1\",\"nickName\":\"产妇1号甲方\",\"params\":{},\"userId\":1,\"userIdCode\":\"产妇1号甲方\",\"userIdType\":\"6\",\"userPhone\":\"1234567890123\"}', '{\"msg\":\"保存用户信息失败\",\"code\":500}', 0, NULL, '2026-01-28 13:06:43', 720);
INSERT INTO `sys_oper_log` VALUES (158, '填写产妇和甲方信息', 0, 'com.healthcare.web.controller.system.HmMotherController.editMotherUser()', 'PUT', 1, 'admin', '研发部门', '/system/mother/editMotherUser', '127.0.0.1', '内网IP', '{\"address\":\"海淀区甲1号\",\"dueDate\":\"2026-02-28\",\"hospitalName\":\"解放军301医院\",\"motherEmail\":\"mother@mail.com\",\"motherId\":0,\"motherIdCode\":\"12345678990000\",\"motherIdType\":\"1\",\"motherName\":\"产妇1号\",\"motherPhone\":\"1234567890123\",\"motherRelation\":\"1\",\"nickName\":\"产妇1号甲方\",\"params\":{},\"userId\":1,\"userIdCode\":\"产妇1号甲方\",\"userIdType\":\"6\",\"userPhone\":\"12345678901\"}', '{\"msg\":\"保存产妇信息失败\",\"code\":500}', 0, NULL, '2026-01-28 13:06:58', 72);
INSERT INTO `sys_oper_log` VALUES (159, '填写产妇和甲方信息', 0, 'com.healthcare.web.controller.system.HmMotherController.editMotherUser()', 'PUT', 1, 'admin', '研发部门', '/system/mother/editMotherUser', '127.0.0.1', '内网IP', '{\"address\":\"海淀区甲1号\",\"dueDate\":\"2026-02-28\",\"hospitalName\":\"解放军301医院\",\"motherEmail\":\"mother@mail.com\",\"motherId\":0,\"motherIdCode\":\"12345678990000\",\"motherIdType\":\"1\",\"motherName\":\"产妇1号\",\"motherPhone\":\"12345678901\",\"motherRelation\":\"1\",\"nickName\":\"产妇1号甲方\",\"params\":{},\"userId\":1,\"userIdCode\":\"产妇1号甲方\",\"userIdType\":\"6\",\"userPhone\":\"12345678901\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 13:07:08', 61);
INSERT INTO `sys_oper_log` VALUES (160, '填写产妇和甲方信息', 0, 'com.healthcare.web.controller.system.HmMotherController.editMotherUser()', 'PUT', 1, 'admin', '研发部门', '/system/mother/editMotherUser', '127.0.0.1', '内网IP', '{\"address\":\"海淀区甲1号\",\"dueDate\":\"2026-02-28\",\"hospitalName\":\"解放军301医院\",\"motherEmail\":\"mother@mail.com\",\"motherId\":0,\"motherIdCode\":\"12345678990000\",\"motherIdType\":\"1\",\"motherName\":\"产妇1号\",\"motherPhone\":\"12345678901\",\"motherRelation\":\"1\",\"nickName\":\"产妇1号甲方\",\"params\":{},\"userId\":1,\"userIdCode\":\"产妇1号甲方\",\"userIdType\":\"6\",\"userPhone\":\"12345678901\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 13:09:32', 679);
INSERT INTO `sys_oper_log` VALUES (161, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, 'admin', '研发部门', '/system/fdp', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-28 13:54:21\",\"id\":1,\"motherId\":4,\"orderStatus\":0,\"params\":{},\"priceOut\":180000,\"proCode\":\"proCode\",\"proStatus\":1,\"recordStatus\":2,\"signDate\":\"2026-01-28\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 13:54:21', 104);
INSERT INTO `sys_oper_log` VALUES (162, '冻干粉订单', 2, 'com.healthcare.web.controller.system.HmOrderFdpController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/fdp', '127.0.0.1', '内网IP', '{\"id\":1,\"orderStatus\":-1,\"params\":{},\"proStatus\":-1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 14:00:00', 11);
INSERT INTO `sys_oper_log` VALUES (163, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, 'admin', '研发部门', '/system/fdp', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-28 14:52:50\",\"id\":2,\"motherId\":4,\"orderStatus\":11,\"params\":{},\"priceOut\":180000,\"proCode\":\"proCode\",\"proStatus\":2,\"recordStatus\":1,\"salesId\":107,\"signDate\":\"2026-01-28\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 14:52:50', 31238);
INSERT INTO `sys_oper_log` VALUES (164, '代码生成', 3, 'com.healthcare.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/21,22,23', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:19:54', 77);
INSERT INTO `sys_oper_log` VALUES (165, '代码生成', 6, 'com.healthcare.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"hm_order_fdp_return\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:20:00', 273);
INSERT INTO `sys_oper_log` VALUES (166, '代码生成', 8, 'com.healthcare.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"hm_order_fdp_return\"}', NULL, 0, NULL, '2026-01-28 15:20:03', 1151);
INSERT INTO `sys_oper_log` VALUES (167, '冻干粉订单退款', 1, 'com.healthcare.web.controller.system.HmOrderFdpReturnController.add()', 'POST', 1, 'admin', '研发部门', '/system/return', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-28 15:55:20\",\"id\":1,\"orderId\":1,\"params\":{},\"price\":150000,\"signDate\":\"2026-01-28\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:55:20', 56);
INSERT INTO `sys_oper_log` VALUES (168, '冻干粉订单退款', 2, 'com.healthcare.web.controller.system.HmOrderFdpReturnController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/return', '127.0.0.1', '内网IP', '{\"id\":1,\"orderId\":1,\"params\":{},\"price\":130000,\"signDate\":\"2026-01-27\",\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:57:06', 17);
INSERT INTO `sys_oper_log` VALUES (169, '代码生成', 3, 'com.healthcare.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/24', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-29 16:38:44', 139);
INSERT INTO `sys_oper_log` VALUES (170, '付款单', 1, 'com.healthcare.web.controller.system.HmPaymentController.add()', 'POST', 1, 'admin', '研发部门', '/system/payment', '127.0.0.1', '内网IP', '{\"id\":1,\"orderId\":1,\"params\":{},\"payAmount\":180000,\"payDate\":\"2026-01-29\",\"transactionId\":\"lkasdjflasdjfklsdaflsadjfasld\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-29 17:28:40', 81);
INSERT INTO `sys_oper_log` VALUES (171, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, 'admin', '研发部门', '/system/fdp', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-29 18:06:14\",\"motherId\":4,\"orderStatus\":11,\"params\":{},\"priceOut\":180000,\"proStatus\":2,\"recordStatus\":1,\"salesId\":107,\"syncFlag\":0,\"userId\":1}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'sync_flag\' in \'class com.healthcare.system.domain.HmOrderFdp\'', '2026-01-29 18:06:14', 106);
INSERT INTO `sys_oper_log` VALUES (172, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, 'admin', '研发部门', '/system/fdp', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-29 18:09:15\",\"id\":3,\"motherId\":4,\"orderStatus\":11,\"params\":{},\"priceOut\":180000,\"proStatus\":2,\"recordStatus\":1,\"salesId\":107,\"syncFlag\":0,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-29 18:09:15', 608);
INSERT INTO `sys_oper_log` VALUES (173, '冻干粉订单退款', 1, 'com.healthcare.web.controller.system.HmOrderFdpReturnController.add()', 'POST', 1, 'admin', '研发部门', '/system/return', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-29 18:31:16\",\"orderId\":3,\"params\":{},\"price\":150000,\"status\":0,\"syncFlag\":0}', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'sync_flag\' at row 1\r\n### The error may exist in file [D:\\workspace\\health\\healthcare\\BackendSystem\\healthcare-system\\target\\classes\\mapper\\system\\HmOrderFdpReturnMapper.xml]\r\n### The error may involve com.healthcare.system.mapper.HmOrderFdpReturnMapper.insertHmOrderFdpReturn-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into hm_order_fdp_return          ( order_id,             status,             price,                                       sync_flag,                          create_time )           values ( ?,             ?,             ?,                                       ?,             ? )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'sync_flag\' at row 1\n; Data truncation: Out of range value for column \'sync_flag\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'sync_flag\' at row 1', '2026-01-29 18:31:17', 954);
INSERT INTO `sys_oper_log` VALUES (174, '冻干粉订单退款', 1, 'com.healthcare.web.controller.system.HmOrderFdpReturnController.add()', 'POST', 1, 'admin', '研发部门', '/system/return', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-29 18:38:12\",\"orderId\":3,\"params\":{},\"price\":150000,\"status\":0,\"syncFlag\":0}', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'sync_flag\' at row 1\r\n### The error may exist in file [D:\\workspace\\health\\healthcare\\BackendSystem\\healthcare-system\\target\\classes\\mapper\\system\\HmOrderFdpReturnMapper.xml]\r\n### The error may involve com.healthcare.system.mapper.HmOrderFdpReturnMapper.insertHmOrderFdpReturn-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into hm_order_fdp_return          ( order_id,             status,             price,                                       sync_flag,                          create_time )           values ( ?,             ?,             ?,                                       ?,             ? )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'sync_flag\' at row 1\n; Data truncation: Out of range value for column \'sync_flag\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'sync_flag\' at row 1', '2026-01-29 18:38:11', 31258);
INSERT INTO `sys_oper_log` VALUES (175, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, 'admin', '研发部门', '/system/fdp', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-29 18:40:11\",\"id\":4,\"motherId\":4,\"orderStatus\":11,\"params\":{},\"priceOut\":180000,\"proCode\":\"proCode\",\"proStatus\":2,\"recordStatus\":1,\"salesId\":107,\"signDate\":\"2026-01-28\",\"syncFlag\":0,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-29 18:40:10', 32078);
INSERT INTO `sys_oper_log` VALUES (176, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, 'admin', '研发部门', '/system/fdp', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-29 18:41:35\",\"id\":5,\"motherId\":4,\"orderStatus\":11,\"params\":{},\"priceOut\":180000,\"proCode\":\"proCode\",\"proStatus\":2,\"recordStatus\":1,\"salesId\":107,\"signDate\":\"2026-01-28\",\"syncFlag\":0,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-29 18:41:35', 40);
INSERT INTO `sys_oper_log` VALUES (177, '冻干粉订单退款', 1, 'com.healthcare.web.controller.system.HmOrderFdpReturnController.add()', 'POST', 1, 'admin', '研发部门', '/system/return', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-29 18:41:55\",\"orderId\":3,\"params\":{},\"price\":150000,\"status\":0,\"syncFlag\":0}', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'sync_flag\' at row 1\r\n### The error may exist in file [D:\\workspace\\health\\healthcare\\BackendSystem\\healthcare-system\\target\\classes\\mapper\\system\\HmOrderFdpReturnMapper.xml]\r\n### The error may involve com.healthcare.system.mapper.HmOrderFdpReturnMapper.insertHmOrderFdpReturn-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into hm_order_fdp_return          ( order_id,             status,             price,                                       sync_flag,                          create_time )           values ( ?,             ?,             ?,                                       ?,             ? )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'sync_flag\' at row 1\n; Data truncation: Out of range value for column \'sync_flag\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'sync_flag\' at row 1', '2026-01-29 18:41:54', 4733);
INSERT INTO `sys_oper_log` VALUES (178, '冻干粉订单退款', 1, 'com.healthcare.web.controller.system.HmOrderFdpReturnController.add()', 'POST', 1, 'admin', '研发部门', '/system/return', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-29 18:44:18\",\"id\":2,\"orderId\":3,\"params\":{},\"price\":150000,\"status\":0,\"syncFlag\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-29 18:44:18', 518);
INSERT INTO `sys_oper_log` VALUES (179, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '36.101.158.35', 'XX XX', '{\"admin\":false,\"email\":\"\",\"params\":{},\"phonenumber\":\"\",\"updateBy\":\"admin\",\"userId\":107,\"userName\":\"admin11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-30 16:24:46', 244);
INSERT INTO `sys_oper_log` VALUES (180, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '36.101.158.35', 'XX XX', '{\"admin\":false,\"email\":\"\",\"params\":{},\"phonenumber\":\"\",\"updateBy\":\"admin\",\"userId\":107,\"userName\":\"admin11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-30 16:25:13', 175);
INSERT INTO `sys_oper_log` VALUES (181, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '36.101.158.35', 'XX XX', '{\"admin\":true,\"email\":\"\",\"params\":{},\"phonenumber\":\"\",\"userId\":1,\"userName\":\"admin11\"}', NULL, 1, '不允许操作超级管理员用户', '2026-01-30 16:26:04', 3);
INSERT INTO `sys_oper_log` VALUES (182, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '36.101.158.35', 'XX XX', '{\"admin\":true,\"email\":\"ry@163.com\",\"params\":{},\"phonenumber\":\"15888888888\",\"userId\":1,\"userName\":\"admin\"}', NULL, 1, '不允许操作超级管理员用户', '2026-01-30 16:49:56', 1);
INSERT INTO `sys_oper_log` VALUES (183, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"D:/wamp64/www/qrcode/dd67563f-08fe-40c6-8650-6d40f50c73c9.png\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 11:12:51\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"\",\"idCode\":\"\",\"idType\":\"0\",\"loginDate\":\"2026-01-31 09:49:45\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"销售二维码\",\"params\":{},\"phonenumber\":\"13612345678\",\"postIds\":[],\"roleIds\":[],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":108,\"userName\":\"销售二维码\",\"userType\":\"2\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-31 09:50:33', 382);
INSERT INTO `sys_oper_log` VALUES (184, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"D:/wamp64/www/qrcode/dd67563f-08fe-40c6-8650-6d40f50c73c9.png\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 11:12:51\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"\",\"idCode\":\"\",\"idType\":\"0\",\"loginDate\":\"2026-01-31 09:49:45\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"销售二维码\",\"params\":{},\"phonenumber\":\"13612345678\",\"postIds\":[],\"roleIds\":[],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":108,\"userName\":\"销售二维码\",\"userType\":\"2\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-31 09:51:00', 330);
INSERT INTO `sys_oper_log` VALUES (185, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"D:/wamp64/www/qrcode/dd67563f-08fe-40c6-8650-6d40f50c73c9.png\",\"createBy\":\"admin\",\"createTime\":\"2026-01-28 11:12:51\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"\",\"idCode\":\"\",\"idType\":\"0\",\"loginDate\":\"2026-01-31 09:49:45\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"销售二维码\",\"params\":{},\"phonenumber\":\"13612345678\",\"postIds\":[],\"roleIds\":[],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":108,\"userName\":\"销售二维码\",\"userType\":\"2\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-31 10:11:45', 474);
INSERT INTO `sys_oper_log` VALUES (186, '用户管理', 1, 'com.healthcare.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"D:/wamp64/www/qrcode/ebb9d1aa-7401-4861-bf5e-6c9eba98ce5a.png\",\"createBy\":\"admin\",\"nickName\":\"哈哈\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userName\":\"13439365944\",\"userType\":\"2\"}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'user_type\' in \'class com.healthcare.common.core.domain.entity.SysUser\'', '2026-01-31 10:12:38', 857);
INSERT INTO `sys_oper_log` VALUES (187, '用户管理', 1, 'com.healthcare.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"D:/wamp64/www/qrcode/1ba0b320-879a-4beb-8764-2fef83defec7.png\",\"createBy\":\"admin\",\"nickName\":\"哈哈\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":111,\"userName\":\"13439365944\",\"userType\":\"2\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-31 10:15:28', 847);
INSERT INTO `sys_oper_log` VALUES (188, '用户管理', 1, 'com.healthcare.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"nickName\":\"哈哈2\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userName\":\"13556149828\"}', NULL, 1, 'Cannot invoke \"String.equals(Object)\" because the return value of \"com.healthcare.common.core.domain.entity.SysUser.getUserType()\" is null', '2026-01-31 10:16:20', 18);
INSERT INTO `sys_oper_log` VALUES (189, '字典类型', 9, 'com.healthcare.web.controller.system.SysDictTypeController.refreshCache()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/refreshCache', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-31 10:19:50', 103);
INSERT INTO `sys_oper_log` VALUES (190, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, '15801515490', NULL, '/system/user', '117.129.82.197', 'XX XX', '{\"admin\":false,\"email\":\"1234@qq.cs\",\"params\":{},\"userId\":110,\"userName\":\"15801515490\"}', NULL, 1, '没有权限访问用户数据！', '2026-02-01 00:17:40', 115);
INSERT INTO `sys_oper_log` VALUES (191, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, '15801515490', NULL, '/system/user', '117.129.82.197', 'XX XX', '{\"admin\":false,\"email\":\"1233@qq.com\",\"params\":{},\"phonenumber\":\"15801515490\",\"userId\":110,\"userName\":\"15801515490\"}', NULL, 1, '没有权限访问用户数据！', '2026-02-01 00:23:01', 22);
INSERT INTO `sys_oper_log` VALUES (192, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, '15801515490', NULL, '/system/user', '117.129.82.197', 'XX XX', '{\"admin\":false,\"email\":\"123123@qq.com\",\"params\":{},\"userId\":110,\"userName\":\"15801515490\"}', NULL, 1, '没有权限访问用户数据！', '2026-02-01 00:24:28', 22);
INSERT INTO `sys_oper_log` VALUES (193, '填写产妇和甲方信息', 0, 'com.healthcare.web.controller.system.HmMotherController.editMotherUser()', 'PUT', 1, 'admin', '研发部门', '/system/mother/editMotherUser', '127.0.0.1', '内网IP', '{\"address\":\"上海市浦东新区锦绣路1234弄56号702室\",\"dueDate\":\"2026-06-01\",\"hospitalName\":\"上海市第一妇婴保健院\",\"motherEmail\":\"zhangxiaomei@example.com\",\"motherId\":0,\"motherIdCode\":\"310105199003072345\",\"motherIdType\":\"1\",\"motherName\":\"张晓梅\",\"motherPhone\":\"13812345678\",\"motherRelation\":\"2\",\"nickName\":\"李伟\",\"params\":{},\"userIdCode\":\"310105198811223456\",\"userIdType\":\"1\",\"userPhone\":\"13987654321\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 21:03:23', 273);
INSERT INTO `sys_oper_log` VALUES (194, '填写产妇和甲方信息', 0, 'com.healthcare.web.controller.system.HmMotherController.editMotherUser()', 'PUT', 1, '15801515490', NULL, '/system/mother/editMotherUser', '117.129.82.197', 'XX XX', '{\"address\":\"上海市浦东新区锦绣路1234弄56号702室\",\"dueDate\":\"2026-04-01\",\"hospitalName\":\"上海市第一妇婴保健院\",\"motherEmail\":\"zhangxiaomei@example.com\",\"motherId\":0,\"motherIdCode\":\"310105199003072345\",\"motherIdType\":\"1\",\"motherName\":\"张晓梅\",\"motherPhone\":\"13812345678\",\"motherRelation\":\"1\",\"nickName\":\"李伟\",\"params\":{},\"userId\":110,\"userIdCode\":\"310105198811223456\",\"userIdType\":\"1\",\"userPhone\":\"13987654321\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 21:26:23', 238);
INSERT INTO `sys_oper_log` VALUES (195, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '36.101.83.28', 'XX XX', '{\"admin\":true,\"email\":\"ry@163.com\",\"params\":{},\"phonenumber\":\"15888888888\",\"userId\":1,\"userName\":\"产妇1号甲方\"}', NULL, 1, '不允许操作超级管理员用户', '2026-02-03 00:03:13', 40);
INSERT INTO `sys_oper_log` VALUES (196, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, 'admin', '研发部门', '/system/fdp', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-02-03 09:35:16\",\"id\":6,\"motherId\":4,\"orderStatus\":11,\"params\":{},\"priceOut\":180000,\"proCode\":\"proCode\",\"proStatus\":2,\"recordStatus\":1,\"salesId\":107,\"signDate\":\"2026-01-28\",\"syncFlag\":0,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-03 09:35:19', 5219);
INSERT INTO `sys_oper_log` VALUES (197, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, 'admin', '研发部门', '/system/fdp', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-02-03 09:41:01\",\"id\":9,\"motherId\":4,\"orderStatus\":11,\"params\":{},\"priceOut\":180000,\"proCode\":\"proCode\",\"proStatus\":2,\"recordStatus\":1,\"salesId\":107,\"signDate\":\"2026-01-28\",\"syncFlag\":0,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-03 09:41:02', 572);
INSERT INTO `sys_oper_log` VALUES (198, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, 'admin', '研发部门', '/system/fdp', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-02-03 09:41:28\",\"id\":10,\"motherId\":4,\"orderStatus\":11,\"params\":{},\"priceOut\":180000,\"proCode\":\"proCode\",\"proStatus\":2,\"recordStatus\":1,\"salesId\":107,\"signDate\":\"2026-01-28\",\"syncFlag\":0,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-03 09:41:37', 8498);
INSERT INTO `sys_oper_log` VALUES (199, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, 'admin', '研发部门', '/system/fdp', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-02-03 09:43:56\",\"id\":11,\"motherId\":4,\"orderStatus\":11,\"params\":{},\"priceOut\":180000,\"proCode\":\"proCode\",\"proStatus\":2,\"recordStatus\":1,\"salesId\":107,\"signDate\":\"2026-01-28\",\"syncFlag\":0,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"id\":11}', 0, NULL, '2026-02-03 09:44:00', 3822);
INSERT INTO `sys_oper_log` VALUES (200, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, '15801515490', NULL, '/system/fdp', '117.129.82.197', 'XX XX', '{\"createTime\":\"2026-02-03 11:23:22\",\"id\":12,\"motherId\":6,\"orderStatus\":11,\"params\":{},\"priceOut\":12,\"proCode\":\"\",\"proStatus\":2,\"recordStatus\":1,\"salesId\":1,\"signDate\":\"2026-02-03\",\"syncFlag\":0,\"userId\":110}', '{\"msg\":\"操作成功\",\"code\":200,\"id\":12}', 0, NULL, '2026-02-03 11:23:22', 201);
INSERT INTO `sys_oper_log` VALUES (201, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, '15801515490', NULL, '/system/fdp', '117.129.82.197', 'XX XX', '{\"createTime\":\"2026-02-03 11:48:28\",\"id\":13,\"motherId\":6,\"orderStatus\":11,\"params\":{},\"priceOut\":12,\"proCode\":\"\",\"proStatus\":2,\"recordStatus\":1,\"salesId\":1,\"signDate\":\"2026-02-03\",\"syncFlag\":0,\"userId\":110}', '{\"msg\":\"操作成功\",\"code\":200,\"id\":13}', 0, NULL, '2026-02-03 11:48:29', 437);
INSERT INTO `sys_oper_log` VALUES (202, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, '15801515490', NULL, '/system/fdp', '117.129.82.197', 'XX XX', '{\"createTime\":\"2026-02-03 11:51:11\",\"id\":14,\"motherId\":6,\"orderStatus\":11,\"params\":{},\"priceOut\":12,\"proCode\":\"\",\"proStatus\":2,\"recordStatus\":1,\"salesId\":1,\"signDate\":\"2026-02-03\",\"syncFlag\":0,\"userId\":110}', '{\"msg\":\"操作成功\",\"code\":200,\"id\":14}', 0, NULL, '2026-02-03 11:51:12', 26);
INSERT INTO `sys_oper_log` VALUES (203, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, '15801515490', NULL, '/system/fdp', '117.129.82.197', 'XX XX', '{\"createTime\":\"2026-02-03 15:45:14\",\"id\":15,\"motherId\":6,\"orderStatus\":11,\"params\":{},\"priceOut\":12,\"proCode\":\"\",\"proStatus\":2,\"recordStatus\":1,\"salesId\":1,\"signDate\":\"2026-02-03\",\"syncFlag\":0,\"userId\":110}', '{\"msg\":\"操作成功\",\"code\":200,\"id\":15}', 0, NULL, '2026-02-03 15:45:14', 15);
INSERT INTO `sys_oper_log` VALUES (204, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, '15801515490', NULL, '/system/fdp', '117.129.82.197', 'XX XX', '{\"createTime\":\"2026-02-03 15:45:55\",\"id\":16,\"motherId\":6,\"orderStatus\":11,\"params\":{},\"priceOut\":12,\"proCode\":\"\",\"proStatus\":2,\"recordStatus\":1,\"salesId\":1,\"signDate\":\"2026-02-03\",\"syncFlag\":0,\"userId\":110}', '{\"msg\":\"操作成功\",\"code\":200,\"id\":16}', 0, NULL, '2026-02-03 15:45:55', 19);
INSERT INTO `sys_oper_log` VALUES (205, '填写产妇和甲方信息', 0, 'com.healthcare.web.controller.system.HmMotherController.editMotherUser()', 'PUT', 1, '15801515490', NULL, '/system/mother/editMotherUser', '117.129.82.197', 'XX XX', '{\"address\":\"上海市浦东新区锦绣路1234弄56号702室\",\"dueDate\":\"2026-04-01\",\"hospitalName\":\"上海市第一妇婴保健院\",\"motherEmail\":\"zhangxiaomei@example.com\",\"motherId\":6,\"motherIdCode\":\"310105199003072345\",\"motherIdType\":\"1\",\"motherName\":\"张晓梅\",\"motherPhone\":\"13812345678\",\"motherRelation\":\"1\",\"nickName\":\"李伟\",\"params\":{},\"userId\":110,\"userIdCode\":\"310105198811223456\",\"userIdType\":\"1\",\"userPhone\":\"13987654321\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 10:29:55', 219);
INSERT INTO `sys_oper_log` VALUES (206, '填写产妇和甲方信息', 0, 'com.healthcare.web.controller.system.HmMotherController.editMotherUser()', 'PUT', 1, '15801515490', NULL, '/system/mother/editMotherUser', '117.129.82.197', 'XX XX', '{\"address\":\"上海市浦东新区锦绣路1234弄56号702室\",\"dueDate\":\"2026-04-01\",\"hospitalName\":\"上海市第一妇婴保健院\",\"motherEmail\":\"zhangxiaomei@example.com\",\"motherId\":6,\"motherIdCode\":\"310105199003072345\",\"motherIdType\":\"1\",\"motherName\":\"张晓梅\",\"motherPhone\":\"13812345678\",\"motherRelation\":\"2\",\"nickName\":\"赵晨\",\"params\":{},\"userId\":110,\"userIdCode\":\"110222198210294117\",\"userIdType\":\"1\",\"userPhone\":\"15801515490\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 10:38:52', 77);
INSERT INTO `sys_oper_log` VALUES (207, '填写产妇和甲方信息', 0, 'com.healthcare.web.controller.system.HmMotherController.editMotherUser()', 'PUT', 1, '15801515490', NULL, '/system/mother/editMotherUser', '117.129.82.197', 'XX XX', '{\"address\":\"上海市浦东新区锦绣路1234弄56号702室\",\"dueDate\":\"2026-04-01\",\"hospitalName\":\"上海市第一妇婴保健院\",\"motherEmail\":\"zhangxiaomei@example.com\",\"motherId\":6,\"motherIdCode\":\"310105199003072345\",\"motherIdType\":\"1\",\"motherName\":\"张晓梅\",\"motherPhone\":\"13812345678\",\"motherRelation\":\"2\",\"nickName\":\"李伟\",\"params\":{},\"userId\":110,\"userIdCode\":\"310105198811223456\",\"userIdType\":\"1\",\"userPhone\":\"13987654321\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 10:41:03', 78);
INSERT INTO `sys_oper_log` VALUES (208, '冻干粉订单', 1, 'com.healthcare.web.controller.system.HmOrderFdpController.add()', 'POST', 1, '15801515490', NULL, '/system/fdp', '117.129.82.197', 'XX XX', '{\"createTime\":\"2026-02-04 10:41:35\",\"id\":17,\"motherId\":6,\"orderCode\":\"PFDP020017\",\"orderStatus\":11,\"params\":{},\"priceOut\":12,\"proCode\":\"\",\"proStatus\":2,\"recordStatus\":1,\"salesId\":1,\"signDate\":\"2026-02-04\",\"syncFlag\":0,\"userId\":110}', '{\"msg\":\"操作成功\",\"code\":200,\"id\":17}', 0, NULL, '2026-02-04 10:41:35', 67);
INSERT INTO `sys_oper_log` VALUES (209, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '150.255.208.13', 'XX XX', '{\"admin\":true,\"email\":\"ry@163.com\",\"params\":{},\"phonenumber\":\"15888888888\",\"userId\":1,\"userName\":\"产妇1号甲方\"}', NULL, 1, '不允许操作超级管理员用户', '2026-02-04 14:37:38', 12);
INSERT INTO `sys_oper_log` VALUES (210, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '117.129.82.197', 'XX XX', '{\"admin\":true,\"email\":\"ry@163.com\",\"params\":{},\"phonenumber\":\"15888888888\",\"userId\":1,\"userName\":\"产妇1号甲方1\"}', NULL, 1, '不允许操作超级管理员用户', '2026-02-04 17:49:42', 2);
INSERT INTO `sys_oper_log` VALUES (211, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '117.129.82.197', 'XX XX', '{\"admin\":true,\"email\":\"ry@163.com\",\"params\":{},\"phonenumber\":\"15888888888\",\"userId\":1,\"userName\":\"产妇1号甲方1\"}', NULL, 1, '不允许操作超级管理员用户', '2026-02-04 17:49:46', 1);
INSERT INTO `sys_oper_log` VALUES (212, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '117.129.82.197', 'XX XX', '{\"admin\":true,\"email\":\"ry1@163.com\",\"params\":{},\"phonenumber\":\"15888888888\",\"userId\":1,\"userName\":\"产妇1号甲方1\"}', NULL, 1, '不允许操作超级管理员用户', '2026-02-04 17:49:53', 1);
INSERT INTO `sys_oper_log` VALUES (213, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, '15801515490', NULL, '/system/user', '117.129.82.197', 'XX XX', '{\"admin\":false,\"email\":\"23332@163.com\",\"params\":{},\"userId\":110,\"userName\":\"15801515490\"}', NULL, 1, '没有权限访问用户数据！', '2026-02-04 17:51:04', 29);
INSERT INTO `sys_oper_log` VALUES (214, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, '15801515490', NULL, '/system/user', '117.129.82.197', 'XX XX', '{\"admin\":false,\"params\":{},\"userId\":110,\"userName\":\"微信用户\"}', NULL, 1, '没有权限访问用户数据！', '2026-02-04 18:08:50', 64);
INSERT INTO `sys_oper_log` VALUES (215, '用户管理', 2, 'com.healthcare.web.controller.system.SysUserController.edit()', 'PUT', 1, '15801515490', NULL, '/system/user', '117.129.82.197', 'XX XX', '{\"admin\":false,\"email\":\"3332@qq.com\",\"params\":{},\"phonenumber\":\"13987654321\",\"userId\":110,\"userName\":\"15801515490\"}', NULL, 1, '没有权限访问用户数据！', '2026-02-04 18:11:44', 20);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(11) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-01-10 10:11:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-01-10 10:11:57', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(11) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-01-10 10:11:57', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户；01微信用户；02销售人员）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `id_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '证件类型 (1-身份证、2-护照、3-永久居留身份证、4-台湾来往大陆通行证、5-香港来往大陆通行证、6-澳门来往大陆通行证、10-其它)',
  `id_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '证件号码',
  `wx_open_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信OpenId',
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `idx_phonenumber`(`phonenumber`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '产妇1号甲方', '00', 'ry@163.com', '15888888888', '1', '/profile/avatar/2026/01/27/avatar_20260127185850A001.png', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-02-05 14:03:39', 'admin', '2026-01-10 10:11:57', '', '2026-02-05 14:03:39', '管理员', '6', '产妇1号甲方', NULL);
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-01-10 10:11:57', 'admin', '2026-01-10 10:11:57', '', NULL, '测试员', '0', '', NULL);
INSERT INTO `sys_user` VALUES (104, 103, '13687654321', '张三', '02', '', '13687654321', '0', '', '87654321', '0', '0', '127.0.0.1', '2026-01-14 16:12:11', '', '2026-01-14 16:11:23', 'admin', '2026-01-14 16:31:57', NULL, '2', '2222222222222', NULL);
INSERT INTO `sys_user` VALUES (105, 103, '销售人员', '销售人员', '00', '', '', '0', '', '$2a$10$.Ayp3HVLRI8RGugmGXcZHup1JSEba05Ywk91fGoaYbp8GRlG2acwG', '0', '0', '', NULL, 'admin', '2026-01-27 20:53:30', '', NULL, NULL, '0', '', NULL);
INSERT INTO `sys_user` VALUES (106, 103, 'xs', 'xs', '00', '', '', '0', '', '$2a$10$oIbXrxMRWTppw2.rp/7Ql.0/wY5Vfhqz.kSgq/KIsPKBHBglHKley', '0', '0', '', NULL, 'admin', '2026-01-27 20:56:40', '', NULL, NULL, '0', '', NULL);
INSERT INTO `sys_user` VALUES (107, 103, 'admin11', '小二黑', '00', '', '', '0', '', '$2a$10$hoJdf2T0PCNnFYUbnkXn6.faah1LzMrnpg1Ndid8nmoB49Cuxivzi', '0', '0', '127.0.0.1', '2026-01-28 12:57:10', '', '2026-01-28 09:47:47', 'admin', '2026-01-30 16:25:13', NULL, '0', '', NULL);
INSERT INTO `sys_user` VALUES (108, 103, '销售二维码', '销售二维码', '2', '', '13612345678', '0', 'D:/wamp64/www/qrcode/dd67563f-08fe-40c6-8650-6d40f50c73c9.png', '$2a$10$RgxEcHLn14M7caS/YgIW5OXD5LRdB02Ey7obQbtUOT252A.q.aDkK', '0', '0', '127.0.0.1', '2026-01-31 09:49:45', 'admin', '2026-01-28 11:12:51', 'admin', '2026-01-31 10:11:44', NULL, '0', '', NULL);
INSERT INTO `sys_user` VALUES (110, NULL, '15801515490', '李伟', '00', '', '13987654321', '0', '', '$2a$10$mmoziYeSYs7FI8buNPV0guzvLl9bdZ33tNCfqS1mPUZ90F429tvZa', '0', '0', '117.129.82.197', '2026-02-05 11:47:56', '', '2026-01-30 16:08:42', '', '2026-02-05 11:47:55', NULL, '1', '310105198811223456', NULL);
INSERT INTO `sys_user` VALUES (111, NULL, '13439365944', '哈哈', '2', '', '', '0', 'D:/wamp64/www/qrcode/1ba0b320-879a-4beb-8764-2fef83defec7.png', '$2a$10$lHb1WZ4WXwkxd4pedxl3xOe/Pll0KlLZ51qvDumIIHKKjPFNiNetu', '0', '0', '', NULL, 'admin', '2026-01-31 10:15:27', '', NULL, NULL, '0', '', NULL);
INSERT INTO `sys_user` VALUES (112, NULL, '13581708896', '13581708896', '00', '', '13581708896', '0', '', '$2a$10$Et4v4YLmH4hIymTweeZHUeBtKKcsVfm1O3uOfkFyZumCd.FMr3lja', '0', '0', '36.101.158.50', '2026-02-01 23:27:44', '', '2026-02-01 23:27:44', '', '2026-02-01 23:27:44', NULL, '0', '', NULL);
INSERT INTO `sys_user` VALUES (114, NULL, '15699736798', '15699736798', '00', '', '15699736798', '0', '', '$2a$10$bH0BPJ71vYEqA.kOjVtDG.TInx/WbBL0JIokLpmp6Lrd9A.VUijW.', '0', '0', '127.0.0.1', '2026-02-04 18:46:52', '', '2026-02-04 18:46:42', '', '2026-02-04 18:46:53', NULL, '0', '', '\"o0IB119Y7y6Ala8KT-30LhGpHnDU\"');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
