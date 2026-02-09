
-- 用户增加证件类型和证件号码 
ALTER TABLE `db_healthcare`.`sys_user` 
ADD COLUMN `id_type` int NOT NULL COMMENT '证件类型(1-身份证、2-护照、3-永久居留身份证、4-台湾来往大陆通行证、5-香港来往大陆通行证、6-澳门来往大陆通行证、10-其它)' AFTER `remark`,
ADD COLUMN `id_code` varchar(50) NOT NULL COMMENT '证件号码' AFTER `id_type`;



-- 产妇信息表
drop table if exists hm_mother;
create table hm_mother (
  id           		bigint(20)      not null auto_increment    comment '主键',
  mother_name		varchar(30)     default ''                 comment '姓名',
  email			    varchar(50)     default ''                 comment '邮箱',
  phonenumber       varchar(11)     default ''                 comment '手机号',
  id_type     		char(2)		    default ''                 comment '证件类型(1-身份证、2-护照、3-永久居留身份证、4-台湾来往大陆通行证、5-香港来往大陆通行证、6-澳门来往大陆通行证、10-其它)',
  id_code           varchar(50)     default ''  	           comment '证件号码',
  hospital_name     varchar(100)    default '' 	  	           comment '预产医院',
  due_date			datetime								   comment '预产期',
  address			varchar(200)	default '' 	  	           comment '地址',
  primary key (id)
) engine=innodb auto_increment=1 comment = '产妇信息表';


-- 产品信息表
drop table if exists hm_product;
create table hm_product (
  id           		bigint(20)      not null auto_increment    comment '主键',
  product_name		varchar(30)     default ''                 comment '产品名',
  navbar		    varchar(50)     default ''                 comment '导航栏小图',
  details		    varchar(50)     default ''                 comment '详情页大图',
  primary key (id)
) engine=innodb auto_increment=1 comment = '产品信息表';

-- 冻干粉订单表
drop table if exists hm_order_fdp;
create table hm_order_fdp (
  id           			bigint(20)      not null auto_increment    comment '主键',
  record_status			tinyint(1)		default 1	comment	'记录状态	(1-有效 0-无效)',
  pro_code				varchar(32)		default ''	comment	'协议编号',
  pro_status			tinyint(1)		default 2	comment	'协议状态（1-已签,2-未签,3-取消,4-终止）',
  order_status			tinyint(1)		default 11	comment	'订单状态（11-未交费,1-已缴费,2-接收胎盘,3-已出报告,12-送制备,13-制备接收,14-送辐照,15-辐照接收,16-初检,17-复检,8-成品登记,9-待取货,10-待发货,4-待交付,5-已完成,6-待解除,7-已退费）',
  user_id				varchar(16)		default ''	comment	'用户(甲方)ID',
  sign_date				date						comment	'签约日期',
  price_in				float(10,2)		default 0	comment	'采购价格',
  tax_in				float(10,2)		default 0	comment	'采购税点',
  price_out				float(10,2)		default 0	comment	'销售价格',
  tax_out				float(10,2)		default 0	comment	'销售税点',
  price_back			float(10,2)		default 0	comment	'退款金额',
  pay_date				date						comment	'缴费日期',
  pay_type				int(11)			default 3	comment	'缴费方式	（1-支付宝、2-银行汇款、3-微信）',
  is_check_from			tinyint(1)		default 0	comment	'是否与供应商对账	(1-是 0-否)',
  mother_id				bigint			default 0	comment	'产妇ID',
  c_memo				text			default ''	comment	'备注',
  get_flag				tinyint(1)		default 0	comment	'是否回库(1-是 0-否)',
  get_h_id				varchar(8)		default ''	comment	'实际生产医院',
  get_tp_date			date						comment	'收到胎盘日期',
  get_is_pass			tinyint(1)		default 0	comment	'病毒报告合格(0-未检 1-合格 2-不合格)	',
  get_report_date		date						comment	'病毒报告收到日期	',
  is_submit_with		tinyint(1)		default 0	comment	'是否成品登记(1-是 0-否)',
  submit_date_with		date						comment	'可交付日期(成品登记日期)',
  submit_number			int(11)			default 0	comment	'交付数量',
  submit_unit			int(11)			default 0	comment	'交付瓶数',
  submit_unit_per		int(11) 		default 0	comment	'常规瓶规格',
  submit_unit_ss		int(11) 		default 0	comment	'特殊瓶粒数	',
  submit_date_plan		date						comment	'计划交付日期',
  submit_uid_plan		int(11)			default 0	comment	'计划交付人	',
  submit_require_plan	varchar(255)	default ''	comment	'客户需求',
  submit_memo_plan		varchar(128)	default ''	comment	'计划交付备注',
  submit_date			datetime					comment	'实际交付时间',
  submit_uid			int(11)			default 0	comment	'实际交付人',
  submit_memo			varchar(128)	default ''	comment	'实际交付备注',
  submit_type			int(11)			default 0	comment	'交付方式(0-未知 1-自送 2-快递)',
  back_apply_flag		tinyint(1)		default 0	comment	'是否申请退款(1-是 0-否)',
  back_date_apply		date						comment	'申请退款日期',
  back_memo_apply		varchar(128)	default ''	comment	'申请退款原因',
  back_pro_flag			tinyint(1)		default 0	comment	'协议是否收回(1-是 0-否)',
  back_date_cancel		date						comment	'协议解除日期',
  back_date				date						comment	'实际退款日期',
  upload_receipt		tinyint(1)		default 0	comment	'是否上传收据(1-是 0-否)',
  receipt_addr			varchar(128)	default ''	comment	'收据地址',
  receipt_uid			int(11)			default 0	comment	'收据上传人	',
  receipt_time			datetime					comment	'收据上传时间',
  upload_invoice		tinyint(1)		default 0	comment	'是否上传发票(1-是 0-否)',
  invoice_addr			varchar(128)	default ''	comment	'发票地址',
  invoice_uid			int(11)			default 0	comment	'发票上传人',
  invoice_time			datetime					comment	'发票上传时间',
  toout_date			datetime					comment	'发货时间',
  toout_memo			varchar(128)	default ''	comment	'发货备注',
  toout_expid			int(11)			default 0	comment	'快递公司ID',
  toout_expcode			varchar(64)		default ''	comment	'快递单号',
  is_special			tinyint(1)		default 0	comment	'是否特殊审批(1-是 0-否)',
  get_number			varchar(32)		default ''	comment	'采血管编号	',
  get_infomemo			varchar(128)	default ''	comment	'备注	',
  test_success_date		date						comment	'无菌检测合格日期	',
  create_by				varchar(64)		default ''	comment	'添加人',
  create_time			datetime					comment	'添加时间',
  primary key (id)
) engine=innodb auto_increment=1 comment = '冻干粉订单表';


-- 冻干粉订单退款表
drop table if exists hm_order_fdp_return;
create table hm_order_fdp_return (
  id           		bigint(20)      not null auto_increment    comment '主键',
  order_id			bigint(20)	    default 0                  comment '冻干粉合同ID',
  status			tinyint(1)		default 1				   comment '状态（1-申请,2-已退,3-取消）',
  create_by			varchar(64)		default ''					comment	'添加人',
  create_time		datetime									comment	'添加时间',
  primary key (id)
) engine=innodb auto_increment=1 comment = '冻干粉订单退款表';