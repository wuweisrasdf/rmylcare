-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('产品信息', '3', '1', 'product', 'system/product/index', 1, 0, 'C', '0', '0', 'system:product:list', '#', 'admin', sysdate(), '', null, '产品信息菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('产品信息查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:product:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('产品信息新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:product:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('产品信息修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:product:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('产品信息删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:product:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('产品信息导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:product:export',       '#', 'admin', sysdate(), '', null, '');


-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('冻干粉订单', '3', '1', 'fdp', 'system/fdp/index', 1, 0, 'C', '0', '0', 'system:fdp:list', '#', 'admin', sysdate(), '', null, '冻干粉订单菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('冻干粉订单查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:fdp:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('冻干粉订单新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:fdp:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('冻干粉订单修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:fdp:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('冻干粉订单删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:fdp:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('冻干粉订单导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:fdp:export',       '#', 'admin', sysdate(), '', null, '');

-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('产妇信息', '3', '1', 'mother', 'system/mother/index', 1, 0, 'C', '0', '0', 'system:mother:list', '#', 'admin', sysdate(), '', null, '产妇信息菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('产妇信息查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:mother:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('产妇信息新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:mother:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('产妇信息修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:mother:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('产妇信息删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:mother:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('产妇信息导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:mother:export',       '#', 'admin', sysdate(), '', null, '');