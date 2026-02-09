INSERT INTO `db_healthcare`.`sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES ('5', '用户管理', '0', '5', 'custom', NULL, '', '1', '0', 'M', '0', '0', NULL, '#', 'admin', '2024-05-31 09:29:14', NULL, NULL, NULL);
INSERT INTO `db_healthcare`.`sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES ('6', '订单管理', '0', '6', 'order', NULL, NULL, '1', '0', 'M', '0', '0', NULL, '#', 'admin', '2024-05-31 09:31:22', '', NULL, '');
INSERT INTO `db_healthcare`.`sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES ('7', '在线讲座', '0', '7', 'online', NULL, NULL, '1', '0', 'M', '0', '0', NULL, '#', 'admin', '2024-05-31 09:33:05', '', NULL, '');
DELETE FROM sys_menu WHERE menu_id=4;

-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('客户信息', '5', '1', 'customer', 'system/customer/index', 1, 0, 'C', '0', '0', 'system:customer:list', '#', 'admin', sysdate(), '', null, '客户信息菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('客户信息查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:customer:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('客户信息新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:customer:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('客户信息修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:customer:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('客户信息删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:customer:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('客户信息导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:customer:export',       '#', 'admin', sysdate(), '', null, '');


-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('患者信息', '5', '1', 'patient', 'system/patient/index', 1, 0, 'C', '0', '0', 'system:patient:list', '#', 'admin', sysdate(), '', null, '患者信息菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('患者信息查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:patient:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('患者信息新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:patient:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('患者信息修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:patient:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('患者信息删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:patient:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('患者信息导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:patient:export',       '#', 'admin', sysdate(), '', null, '');

-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('服务人员信息', '5', '1', 'service', 'system/service/index', 1, 0, 'C', '0', '0', 'system:service:list', '#', 'admin', sysdate(), '', null, '服务人员信息菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('服务人员信息查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:service:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('服务人员信息新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:service:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('服务人员信息修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:service:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('服务人员信息删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:service:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('服务人员信息导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:service:export',       '#', 'admin', sysdate(), '', null, '');


-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('陪诊单', '6', '1', 'accompany', 'system/accompany/index', 1, 0, 'C', '0', '0', 'system:accompany:list', '#', 'admin', sysdate(), '', null, '陪诊单菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('陪诊单查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:accompany:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('陪诊单新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:accompany:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('陪诊单修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:accompany:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('陪诊单删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:accompany:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('陪诊单导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:accompany:export',       '#', 'admin', sysdate(), '', null, '');


-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('入院单', '6', '1', 'hospital', 'system/inhospital/index', 1, 0, 'C', '0', '0', 'system:inhospital:list', '#', 'admin', sysdate(), '', null, '医院信息菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('入院单查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:inhospital:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('入院单新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:inhospital:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('入院单修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:inhospital:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('入院单删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:inhospital:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('入院单导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:inhospital:export',       '#', 'admin', sysdate(), '', null, '');


-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('出院单', '6', '1', 'hospital', 'system/outhospital/index', 1, 0, 'C', '0', '0', 'system:outhospital:list', '#', 'admin', sysdate(), '', null, '医院信息菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('出院单查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:outhospital:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('出院单新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:outhospital:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('出院单修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:outhospital:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('出院单删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:outhospital:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('出院单导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:outhospital:export',       '#', 'admin', sysdate(), '', null, '');



-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('住院陪护单', '6', '1', 'nursing', 'system/nursing/index', 1, 0, 'C', '0', '0', 'system:nursing:list', '#', 'admin', sysdate(), '', null, '住院陪护单菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('住院陪护单查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:nursing:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('住院陪护单新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:nursing:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('住院陪护单修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:nursing:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('住院陪护单删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:nursing:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('住院陪护单导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:nursing:export',       '#', 'admin', sysdate(), '', null, '');


-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('代办单', '6', '1', 'agency', 'system/agency/index', 1, 0, 'C', '0', '0', 'system:agency:list', '#', 'admin', sysdate(), '', null, '代办单菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('代办单查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:agency:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('代办单新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:agency:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('代办单修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:agency:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('代办单删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:agency:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('代办单导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:agency:export',       '#', 'admin', sysdate(), '', null, '');



-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('咨询单', '6', '1', 'guidance', 'system/guidance/index', 1, 0, 'C', '0', '0', 'system:guidance:list', '#', 'admin', sysdate(), '', null, '咨询单菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('咨询单查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:guidance:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('咨询单新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:guidance:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('咨询单修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:guidance:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('咨询单删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:guidance:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('咨询单导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:guidance:export',       '#', 'admin', sysdate(), '', null, '');



-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('讲座信息', '7', '1', 'lecture', 'system/lecture/index', 1, 0, 'C', '0', '0', 'system:lecture:list', '#', 'admin', sysdate(), '', null, '讲座信息菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('讲座信息查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:lecture:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('讲座信息新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:lecture:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('讲座信息修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:lecture:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('讲座信息删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:lecture:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('讲座信息导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:lecture:export',       '#', 'admin', sysdate(), '', null, '');


-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('讲座报名', '7', '1', 'entry', 'system/entry/index', 1, 0, 'C', '0', '0', 'system:entry:list', '#', 'admin', sysdate(), '', null, '讲座报名菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('讲座报名查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:entry:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('讲座报名新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:entry:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('讲座报名修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:entry:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('讲座报名删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:entry:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('讲座报名导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:entry:export',       '#', 'admin', sysdate(), '', null, '');






insert into sys_dict_type(dict_name, dict_type, status, remark) value ('证件类型','sys_user_id_type','0','证件类型枚举');

insert into sys_dict_type(dict_name, dict_type, status, remark) value ('证件类型','hm_mother_id_type','0','证件类型枚举');

insert into sys_dict_type(dict_name, dict_type, status, remark) value ('订单状态','hm_order_status','0','订单状态枚举');

insert into sys_dict_type(dict_name, dict_type, status, remark) value ('支付方式','hm_order_pay_type','0','支付方式枚举');


insert into sys_dict_data(dict_sort,dict_label,dict_value,dict_type,is_default,status) values 
(1, '身份证','1','sys_user_id_type','Y','0'),
(2, '护照','2','sys_user_id_type','N','0'),
(3, '永久居留身份证','3','sys_user_id_type','N','0'),
(4, '台湾来往大陆通行证','4','sys_user_id_type','N','0'),
(5, '香港来往大陆通行证','5','sys_user_id_type','N','0'),
(6, '澳门来往大陆通行证','6','sys_user_id_type','N','0'),
(7, '其它','10','sys_user_id_type','N','0');

insert into sys_dict_data(dict_sort,dict_label,dict_value,dict_type,is_default,status) values 
(1, '身份证','1','hm_mother_id_type','Y','0'),
(2, '护照','2','hm_mother_id_type','N','0'),
(3, '永久居留身份证','3','hm_mother_id_type','N','0'),
(4, '台湾来往大陆通行证','4','hm_mother_id_type','N','0'),
(5, '香港来往大陆通行证','5','hm_mother_id_type','N','0'),
(6, '澳门来往大陆通行证','6','hm_mother_id_type','N','0'),
(7, '其它','10','hm_mother_id_type','N','0');


insert into sys_dict_data(dict_sort,dict_label,dict_value,dict_type,is_default,status) values 
(1, '未交费','11','hm_order_status','Y','0'),
(2, '已缴费','1','hm_order_status','N','0'),
(3, '接收胎盘','2','hm_order_status','N','0'),
(4, '已出报告','3','hm_order_status','N','0'),
(5, '送制备','12','hm_order_status','N','0'),
(6, '制备接收','13','hm_order_status','N','0'),
(7, '送辐照','14','hm_order_status','N','0'),
(8, '辐照接收','15','hm_order_status','N','0'),
(9, '初检','16','hm_order_status','N','0'),
(10, '复检','17','hm_order_status','N','0'),
(11, '成品登记','8','hm_order_status','N','0'),
(12, '待取货','9','hm_order_status','N','0'),
(13, '待发货','10','hm_order_status','N','0'),
(14, '待交付','4','hm_order_status','N','0'),
(15, '已完成','5','hm_order_status','N','0'),
(16, '待解除','6','hm_order_status','N','0'),
(17, '已退费','7','hm_order_status','N','0');

insert into sys_dict_data(dict_sort,dict_label,dict_value,dict_type,is_default,status) values 
(1, '支付宝','1','hm_order_pay_type','N','0'),
(2, '银行汇款','2','hm_order_pay_type','N','0'),
(3, '微信','3','hm_order_pay_type','Y','0');