/*
 Navicat Premium Dump SQL

 Source Server         : 本地开发
 Source Server Type    : MySQL
 Source Server Version : 80200 (8.2.0)
 Source Host           : localhost:3306
 Source Schema         : db_healthcare

 Target Server Type    : MySQL
 Target Server Version : 80200 (8.2.0)
 File Encoding         : 65001

 Date: 29/01/2026 17:08:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hm_order_fdp
-- ----------------------------
DROP TABLE IF EXISTS `hm_order_fdp`;
CREATE TABLE `hm_order_fdp`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `record_status` tinyint(1) NULL DEFAULT 1 COMMENT '记录状态	(1-有效 0-无效)',
  `pro_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '协议编号',
  `pro_status` tinyint(1) NULL DEFAULT 2 COMMENT '协议状态（1-已签,2-未签,3-取消,4-终止）',
  `order_status` tinyint(1) NULL DEFAULT 11 COMMENT '订单状态（11-未交费,1-已缴费,2-接收胎盘,3-已出报告,12-送制备,13-制备接收,14-送辐照,15-辐照接收,16-初检,17-复检,8-成品登记,9-待取货,10-待发货,4-待交付,5-已完成,6-待解除,7-已退费）',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户(甲方)ID',
  `sign_date` date NULL DEFAULT NULL COMMENT '签约日期',
  `price_in` float(10, 2) NULL DEFAULT 0.00 COMMENT '采购价格',
  `sales_id` bigint NULL DEFAULT NULL COMMENT '销售人员ID',
  `sync_flag` tinyint(1) NULL DEFAULT 0 COMMENT '同步标志',
  `tax_in` float(10, 2) NULL DEFAULT 0.00 COMMENT '采购税点',
  `price_out` float(10, 2) NULL DEFAULT 0.00 COMMENT '销售价格',
  `tax_out` float(10, 2) NULL DEFAULT 0.00 COMMENT '销售税点',
  `price_back` float(10, 2) NULL DEFAULT 0.00 COMMENT '退款金额',
  `pay_date` date NULL DEFAULT NULL COMMENT '缴费日期',
  `pay_type` int NULL DEFAULT 3 COMMENT '缴费方式	（1-支付宝、2-银行汇款、3-微信）',
  `is_check_from` tinyint(1) NULL DEFAULT 0 COMMENT '是否与供应商对账	(1-是 0-否)',
  `mother_id` bigint NULL DEFAULT 0 COMMENT '产妇ID',
  `c_memo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注',
  `get_flag` tinyint(1) NULL DEFAULT 0 COMMENT '是否回库(1-是 0-否)',
  `get_h_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实际生产医院',
  `get_tp_date` date NULL DEFAULT NULL COMMENT '收到胎盘日期',
  `get_is_pass` tinyint(1) NULL DEFAULT 0 COMMENT '病毒报告合格(0-未检 1-合格 2-不合格)	',
  `get_report_date` date NULL DEFAULT NULL COMMENT '病毒报告收到日期	',
  `is_submit_with` tinyint(1) NULL DEFAULT 0 COMMENT '是否成品登记(1-是 0-否)',
  `submit_date_with` date NULL DEFAULT NULL COMMENT '可交付日期(成品登记日期)',
  `submit_number` int NULL DEFAULT 0 COMMENT '交付数量',
  `submit_unit` int NULL DEFAULT 0 COMMENT '交付瓶数',
  `submit_unit_per` int NULL DEFAULT 0 COMMENT '常规瓶规格',
  `submit_unit_ss` int NULL DEFAULT 0 COMMENT '特殊瓶粒数	',
  `submit_date_plan` date NULL DEFAULT NULL COMMENT '计划交付日期',
  `submit_uid_plan` int NULL DEFAULT 0 COMMENT '计划交付人	',
  `submit_require_plan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '客户需求',
  `submit_memo_plan` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '计划交付备注',
  `submit_date` datetime NULL DEFAULT NULL COMMENT '实际交付时间',
  `submit_uid` int NULL DEFAULT 0 COMMENT '实际交付人',
  `submit_memo` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实际交付备注',
  `submit_type` int NULL DEFAULT 0 COMMENT '交付方式(0-未知 1-自送 2-快递)',
  `back_apply_flag` tinyint(1) NULL DEFAULT 0 COMMENT '是否申请退款(1-是 0-否)',
  `back_date_apply` date NULL DEFAULT NULL COMMENT '申请退款日期',
  `back_memo_apply` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '申请退款原因',
  `back_pro_flag` tinyint(1) NULL DEFAULT 0 COMMENT '协议是否收回(1-是 0-否)',
  `back_date_cancel` date NULL DEFAULT NULL COMMENT '协议解除日期',
  `back_date` date NULL DEFAULT NULL COMMENT '实际退款日期',
  `upload_receipt` tinyint(1) NULL DEFAULT 0 COMMENT '是否上传收据(1-是 0-否)',
  `receipt_addr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '收据地址',
  `receipt_uid` int NULL DEFAULT 0 COMMENT '收据上传人	',
  `receipt_time` datetime NULL DEFAULT NULL COMMENT '收据上传时间',
  `upload_invoice` tinyint(1) NULL DEFAULT 0 COMMENT '是否上传发票(1-是 0-否)',
  `invoice_addr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '发票地址',
  `invoice_uid` int NULL DEFAULT 0 COMMENT '发票上传人',
  `invoice_time` datetime NULL DEFAULT NULL COMMENT '发票上传时间',
  `toout_date` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `toout_memo` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '发货备注',
  `toout_expid` int NULL DEFAULT 0 COMMENT '快递公司ID',
  `toout_expcode` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '快递单号',
  `is_special` tinyint(1) NULL DEFAULT 0 COMMENT '是否特殊审批(1-是 0-否)',
  `get_number` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '采血管编号	',
  `get_infomemo` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注	',
  `test_success_date` date NULL DEFAULT NULL COMMENT '无菌检测合格日期	',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '添加人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE,
  INDEX `idx_sales`(`sales_id` ASC) USING BTREE,
  INDEX `idx_mother`(`mother_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '冻干粉订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hm_order_fdp
-- ----------------------------
INSERT INTO `hm_order_fdp` VALUES (1, 2, 'proCode', -1, -1, 1, '2026-01-28', 0.00, 107, 0, 0.00, 180000.00, 0.00, 0.00, NULL, 3, 0, 4, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-01-28 13:54:22');
INSERT INTO `hm_order_fdp` VALUES (2, 1, 'proCode', 2, 11, 1, '2026-01-28', 0.00, 107, 0, 0.00, 180000.00, 0.00, 0.00, NULL, 3, 0, 4, NULL, 0, '', NULL, 0, NULL, 0, NULL, 0, 0, 0, 0, NULL, 0, '', '', NULL, 0, '', 0, 0, NULL, '', 0, NULL, NULL, 0, '', 0, NULL, 0, '', 0, NULL, NULL, '', 0, '', 0, '', '', NULL, '', '2026-01-28 14:52:50');

-- ----------------------------
-- Table structure for hm_order_fdp_return
-- ----------------------------
DROP TABLE IF EXISTS `hm_order_fdp_return`;
CREATE TABLE `hm_order_fdp_return`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint NULL DEFAULT 0 COMMENT '冻干粉合同ID',
  `pro_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '协议编号',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态（1-申请,2-已退,3-取消）',
  `price` float(10, 2) NULL DEFAULT 0.00 COMMENT '退款金额',
  `sign_date` datetime NULL DEFAULT NULL COMMENT '签约日期',
  `sync_flag` tinyint(1) NULL DEFAULT 0 COMMENT '同步标志',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '添加人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '冻干粉订单退款表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hm_order_fdp_return
-- ----------------------------
INSERT INTO `hm_order_fdp_return` VALUES (1, 1, NULL, 1, 130000.00, '2026-01-27 00:00:00', 0, '', '2026-01-28 15:55:20');

-- ----------------------------
-- Table structure for hm_payment
-- ----------------------------
DROP TABLE IF EXISTS `hm_payment`;
CREATE TABLE `hm_payment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `pay_amount` float(10, 2) NULL DEFAULT 0.00 COMMENT '付款金额',
  `transaction_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信流水号',
  `pay_date` datetime NULL DEFAULT NULL COMMENT '付款时间',
  `sync_flag` tinyint(1) NULL DEFAULT 0 COMMENT '同步标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '付款单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hm_payment
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
