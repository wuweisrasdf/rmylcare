修改用户密码 没加密
检测所有接口权限

签署成功回调
订单加同步失败标志

修改手机号时，只发验证码 校验， 不登录


[{"signerType":0,"psnSignerInfo":{"psnAccount":"15699736798","psnInfo":{"psnName":"吴伟"}},"signFields":[{"fileId":"8a6a0856a9454846ad5963f617ad95ec","customBizNum":"contract_1769599199076","normalSignFieldConfig":{"psnSealStyles":"0,1","signFieldStyle":1,"signFieldPosition":{"positionPage":"2","positionX":200,"positionY":200}}}]},{"signerType":0,"psnSignerInfo":{"psnAccount":"15699736798","psnInfo":{"psnName":"吴伟"}},"signFields":[{"fileId":"8a6a0856a9454846ad5963f617ad95ec","customBizNum":"contract_1769599199076","normalSignFieldConfig":{"psnSealStyles":"0,1","signFieldStyle":1,"signFieldPosition":{"positionPage":"2","positionX":200,"positionY":200}}}]}]




curl -X GET "http://localhost:81/dev-api/getInfo2" -H "accept: */*" -H "Authorization:Bearer eyJhbGciOiJIUzUxMiJ9.eyJsb2dpbl91c2VyX2tleSI6IjBkZDdjZTYyLWI5MTYtNDQxZS1iNmQ1LTA5OWY3OTNjODQ3ZiJ9.QtcZQtO_6F7AkOGz4gOlcETLaesytVTlHlqLUF0mBBuGTCi4tU3fdG3_BJ8091a7Z_Nkfc3eHssLqo2gN5ddMQ"


drop table if exists hm_customer;
create table hm_customer (
  id           			bigint(20)      not null auto_increment    comment '主键',
  cust_name         varchar(20)     default ''                 comment '姓名',
  cust_licence      varchar(18)     default ''                 comment '身份证',
  cust_phone        varchar(20)     default ''                 comment '手机号',
  cust_password     varchar(32)     default ''                 comment '登录密码(MD5加密后)',
  cust_wx           varchar(20)     default ''  	             comment '微信openId',
  cust_identify     varchar(20)     default '' 	  	           comment '识别码',
  primary key (id)
) engine=innodb auto_increment=200 comment = '客户信息表';

drop table if exists hm_patient;
create table hm_patient (
  id           			bigint(20)      not null auto_increment    comment '主键',
  cust_id        		bigint(20)      default 0                  comment '客户ID',
  patient_name      varchar(20)     default ''                 comment '姓名',
  patient_licence   varchar(18)     default ''                 comment '身份证',
  patient_phone     varchar(20)     default ''                 comment '手机号',
  patient_sex       int(1)    			default 0  	           		 comment '性别0:未知；1：男；2：女',
  patient_birthday  datetime									 	  	           comment '出生日期',
  patient_relation  varchar(10)     default '' 	  	           comment '客户与患者关系',
  primary key (id)
) engine=innodb auto_increment=200 comment = '患者信息表';


drop table if exists hm_file;
create table hm_file (
  id           			bigint(20)      not null auto_increment    comment '主键',
  cust_id        		bigint(20)      default 0                  comment '客户ID',
  file_name  		    varchar(50)     default ''                 comment '档案名',
  file_path 			  varchar(50)     default ''                 comment '文档存储路径',
  primary key (id)
) engine=innodb auto_increment=200 comment = '客户档案';




drop table if exists hm_hospital;
create table hm_hospital (
  id           			bigint(20)      not null auto_increment    comment '主键',
  hospital_name   	varchar(20)     default ''                 comment '医院名',
  hospital_class    varchar(50)     default ''                 comment '医院类型',
  hospital_address  varchar(50)     default ''                 comment '医院地址',
  primary key (id)
) engine=innodb auto_increment=200 comment = '医院信息表';




drop table if exists hm_departent;
create table hm_departent (
  id           			bigint(20)      not null auto_increment    comment '主键',
  dept_name   			varchar(20)     default ''                 comment '科室名',
  dept_address  	  varchar(50)     default ''                 comment '科室位置',
  primary key (id)
) engine=innodb auto_increment=200 comment = '科室信息表';



drop table if exists hm_service;
create table hm_service (
  id           			bigint(20)      not null auto_increment    comment '主键',
  service_name      varchar(20)     default ''                 comment '姓名',
  service_licence   varchar(18)     default ''                 comment '身份证',
  service_phone   	varchar(20)     default ''                 comment '手机号',
  service_password  varchar(32)     default ''                 comment '登录密码(MD5加密后)',
  service_wx       	varchar(30)    	default ''  	           	 comment '微信openId',
  service_type  		varchar(5)   	  default ''               	 comment '服务人员类型',
  service_hospital  varchar(20)     default '' 	  	           comment '所属医院(json串)',
  service_identify	varchar(20)     default '' 	  	           comment '识别码',
  check_status			int(1)    			default 0  	           		 comment '人员状态(0:未审核;1：已审核)',
  primary key (id)
) engine=innodb auto_increment=200 comment = '服务人员信息';


drop table if exists hm_order_status;
create table hm_order_status (
  id           			int(8)      not null auto_increment    comment '主键',
  status_name      	varchar(20)     default ''                 comment '状态描述',
  primary key (id)
) engine=innodb auto_increment=200 comment = '单据状态';



drop table if exists hm_order_accompany;
create table hm_order_accompany (
  id           			bigint(20)      not null auto_increment    comment '主键',
  cust_id        		bigint(20)      default 0                  comment '客户ID',
  hospital_id      	bigint(20)      default 0                  comment '医院ID',
  dept_id        		bigint(20)      default 0                  comment '科室ID',
  patient_id       	bigint(20)      default 0                  comment '患者ID',
  order_phone     	varchar(20)     default ''                 comment '联系电话',
  begin_time  			datetime									 	  	           comment '开始时间',
  endding_time  		datetime									 	  	           comment '结束时间',
  created_time  		datetime									 	  	           comment '创建时间',
  service_id       	bigint(20)      default 0                  comment '服务人员ID',
  assign_time  			datetime									 	  	           comment '分派时间',
  user_id       		bigint(20)      default 0                  comment '负责人',
  check_time  			datetime									 	  	           comment '审核时间',
  order_amount      float(8,2)      default 0                  comment '订单金额',
  payment_amount    float(8,2)      default 0                  comment '支付金额',
  order_payment     int(1)     			default 0                  comment '支付状态(0:未；1:已)',
  payment_time  		datetime									 	  	       		 comment '支付时间',
  order_coupon_id   bigint(20)      default 0                  comment '优惠券ID',
  order_status_id		int(8)					default 0                  comment '订单状态',
  order_remark   	varchar(100)     default ''                comment '备注',
  primary key (id)
) engine=innodb auto_increment=200 comment = '陪诊单';



drop table if exists hm_order_in_hospital;
create table hm_order_in_hospital (
  id           			bigint(20)      not null auto_increment    comment '主键',
  cust_id        		bigint(20)      default 0                  comment '客户ID',
  hospital_id      	bigint(20)      default 0                  comment '医院ID',
  dept_id        		bigint(20)      default 0                  comment '科室ID',
  patient_id       	bigint(20)      default 0                  comment '患者ID',
  order_phone     	varchar(20)     default ''                 comment '联系电话',
  begin_time  			datetime									 	  	           comment '开始时间',
  endding_time  		datetime									 	  	           comment '结束时间',
  created_time  		datetime									 	  	           comment '创建时间',
  service_id       	bigint(20)      default 0                  comment '服务人员ID',
  assign_time  			datetime									 	  	           comment '分派时间',
  user_id       		bigint(20)      default 0                  comment '负责人',
  check_time  			datetime									 	  	           comment '审核时间',
  order_amount      float(8,2)      default 0                  comment '订单金额',
  payment_amount    float(8,2)      default 0                  comment '支付金额',
  order_payment     int(1)     			default 0                  comment '支付状态(0:未；1:已)',
  payment_time  		datetime									 	  	       		 comment '支付时间',
  order_coupon_id   bigint(20)      default 0                  comment '优惠券ID',
  order_status_id		int(8)					default 0                  comment '订单状态',
  order_remark   	varchar(100)     default ''                comment '备注',
  primary key (id)
) engine=innodb auto_increment=200 comment = '入院单';


drop table if exists hm_order_out_hospital;
create table hm_order_out_hospital (
  id           			bigint(20)      not null auto_increment    comment '主键',
  cust_id        		bigint(20)      default 0                  comment '客户ID',
  hospital_id      	bigint(20)      default 0                  comment '医院ID',
  dept_id        		bigint(20)      default 0                  comment '科室ID',
  patient_id       	bigint(20)      default 0                  comment '患者ID',
  hospital_area     varchar(30)     default ''                 comment '住院病区',
  hospital_bed     	varchar(10)     default ''                 comment '住院床位',
  order_phone     	varchar(20)     default ''                 comment '联系电话',
  begin_time  			datetime									 	  	           comment '开始时间',
  endding_time  		datetime									 	  	           comment '结束时间',
  created_time  		datetime									 	  	           comment '创建时间',
  service_id       	bigint(20)      default 0                  comment '服务人员ID',
  assign_time  			datetime									 	  	           comment '分派时间',
  user_id       		bigint(20)      default 0                  comment '负责人',
  check_time  			datetime									 	  	           comment '审核时间',
  order_amount      float(8,2)      default 0                  comment '订单金额',
  payment_amount    float(8,2)      default 0                  comment '支付金额',
  order_payment     int(1)     			default 0                  comment '支付状态(0:未；1:已)',
  payment_time  		datetime									 	  	       		 comment '支付时间',
  order_coupon_id   bigint(20)      default 0                  comment '优惠券ID',
  order_status_id		int(8)					default 0                  comment '订单状态',
  order_remark   		varchar(100)     default ''                comment '备注',
  primary key (id)
) engine=innodb auto_increment=200 comment = '出院单';



drop table if exists hm_order_nursing;
create table hm_order_nursing (
  id           			bigint(20)      not null auto_increment    comment '主键',
  cust_id        		bigint(20)      default 0                  comment '客户ID',
  hospital_id      	bigint(20)      default 0                  comment '医院ID',
  dept_id        		bigint(20)      default 0                  comment '科室ID',
  patient_id       	bigint(20)      default 0                  comment '患者ID',
  hospital_area     varchar(30)     default ''                 comment '住院病区',
  hospital_bed     	varchar(10)     default ''                 comment '住院床位',
  order_phone     	varchar(20)     default ''                 comment '联系电话',
  begin_time  			datetime									 	  	           comment '开始时间',
  endding_time  		datetime									 	  	           comment '结束时间',
  created_time  		datetime									 	  	           comment '创建时间',
  service_id       	bigint(20)      default 0                  comment '服务人员ID',
  assign_time  			datetime									 	  	           comment '分派时间',
  user_id       		bigint(20)      default 0                  comment '负责人',
  check_time  			datetime									 	  	           comment '审核时间',
  order_amount      float(8,2)      default 0                  comment '订单金额',
  payment_amount    float(8,2)      default 0                  comment '支付金额',
  order_payment     int(1)     			default 0                  comment '支付状态(0:未；1:已)',
  payment_time  		datetime									 	  	       		 comment '支付时间',
  order_coupon_id   bigint(20)      default 0                  comment '优惠券ID',
  order_status_id		int(8)					default 0                  comment '订单状态',
  order_remark   		varchar(100)     default ''                comment '备注',
  primary key (id)
) engine=innodb auto_increment=200 comment = '住院陪护单';


drop table if exists hm_agency_content;
create table hm_agency_content (
  id           			int(8)     			not null auto_increment    comment '主键',
  agency_content   	varchar(20)     default ''                 comment '代办内容',
  primary key (id)
) engine=innodb auto_increment=200 comment = '代办事项';



drop table if exists hm_order_agency;
create table hm_order_agency (
  id           			bigint(20)      not null auto_increment    comment '主键',
  cust_id        		bigint(20)      default 0                  comment '客户ID',
  hospital_id      	bigint(20)      default 0                  comment '医院ID',
  dept_id        		bigint(20)      default 0                  comment '科室ID',
  patient_id       	bigint(20)      default 0                  comment '患者ID',
  order_content    	varchar(20)     default ''                 comment '代办内容(json)',
  order_phone     	varchar(20)     default ''                 comment '联系电话',
  begin_time  			datetime									 	  	           comment '开始时间',
  endding_time  		datetime									 	  	           comment '结束时间',
  created_time  		datetime									 	  	           comment '创建时间',
  service_id       	bigint(20)      default 0                  comment '服务人员ID',
  assign_time  			datetime									 	  	           comment '分派时间',
  user_id       		bigint(20)      default 0                  comment '负责人',
  check_time  			datetime									 	  	           comment '审核时间',
  order_amount      float(8,2)      default 0                  comment '订单金额',
  payment_amount    float(8,2)      default 0                  comment '支付金额',
  order_payment     int(1)     			default 0                  comment '支付状态(0:未；1:已)',
  payment_time  		datetime									 	  	       		 comment '支付时间',
  order_coupon_id   bigint(20)      default 0                  comment '优惠券ID',
  order_status_id		int(8)					default 0                  comment '订单状态',
  order_remark   		varchar(100)     default ''                comment '备注',
  primary key (id)
) engine=innodb auto_increment=200 comment = '代办单';





drop table if exists hm_order_guidance;
create table hm_order_guidance (
  id           			bigint(20)      not null auto_increment    comment '主键',
  cust_id        		bigint(20)      default 0                  comment '客户ID',
  hospital_id      	bigint(20)      default 0                  comment '医院ID',
  dept_id        		bigint(20)      default 0                  comment '科室ID',
  order_im      	 	varchar(100)    default ''                 comment 'IM相关信息',
  begin_time  			datetime									 	  	           comment '开始时间',
  endding_time  		datetime									 	  	           comment '结束时间',
  created_time  		datetime									 	  	           comment '创建时间',
  service_id       	bigint(20)      default 0                  comment '服务人员ID',
  assign_time  			datetime									 	  	           comment '分派时间',
  user_id       		bigint(20)      default 0                  comment '负责人',
  check_time  			datetime									 	  	           comment '审核时间',
  order_amount      float(8,2)      default 0                  comment '订单金额',
  payment_amount    float(8,2)      default 0                  comment '支付金额',
  order_payment     int(1)     			default 0                  comment '支付状态(0:未；1:已)',
  payment_time  		datetime									 	  	       		 comment '支付时间',
  order_coupon_id   bigint(20)      default 0                  comment '优惠券ID',
  order_status_id		int(8)					default 0                  comment '订单状态',
  order_remark   		varchar(100)     default ''                comment '备注',
  primary key (id)
) engine=innodb auto_increment=200 comment = '咨询单';



drop table if exists hm_lecture;
create table hm_lecture (
  id           			bigint(20)      not null auto_increment    comment '主键',
  banner_img      	varchar(50) 	  default ''                 comment '小图',
  content_img      	varchar(50) 	  default ''                 comment '详细内容大图',
  begin_time  			datetime									 	  	           comment '展示开始时间',
  endding_time  		datetime									 	  	           comment '展示结束时间',
  lecture_status_id	int(8)					default 0                  comment '讲座状态',
  lecture_remark 		varchar(100)    default ''        	       comment '备注',
  primary key (id)
) engine=innodb auto_increment=200 comment = '讲座信息';


drop table if exists hm_entry;
create table hm_entry (
  id           			bigint(20)      not null auto_increment    comment '主键',
  cust_id        		bigint(20)      default 0                  comment '客户ID',
  lecture_id        bigint(20)      default 0                  comment '讲座ID',
  entry_time  			datetime									 	  	           comment '报名时间',
  primary key (id)
) engine=innodb auto_increment=200 comment = '讲座报名';