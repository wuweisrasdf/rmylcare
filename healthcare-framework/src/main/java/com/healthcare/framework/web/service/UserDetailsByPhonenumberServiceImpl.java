package com.healthcare.framework.web.service;

import com.healthcare.common.core.domain.entity.SysUser;
import com.healthcare.common.core.domain.model.LoginUser;
import com.healthcare.common.enums.UserStatus;
import com.healthcare.common.exception.ServiceException;
import com.healthcare.common.utils.StringUtils;
import com.healthcare.system.service.ISysUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * 用户验证处理
 *
 * @author hjs
 */
@Service("userDetailsByPhonenumber")
public class UserDetailsByPhonenumberServiceImpl implements UserDetailsService {

    private static final Logger log = LoggerFactory.getLogger(UserDetailsByPhonenumberServiceImpl.class);

    @Autowired
    private ISysUserService userService;

    @Autowired
    private SysPermissionService permissionService;

    @Override
    public UserDetails loadUserByUsername(String phoneNumber) throws UsernameNotFoundException {
    	// 防止漏查角色等所需的信息，尽量模仿根据用户名查用户的方法开发：ISysUserService.selectUserByUserName(username)
        SysUser user = userService.selectUserByPhoneNumber(phoneNumber);
        if (StringUtils.isNull(user)) {
            log.info("登录用户：{} 不存在.", phoneNumber);
            throw new ServiceException("登录用户：" + phoneNumber+ " 不存在");
        } else if (UserStatus.DELETED.getCode().equals(user.getDelFlag())) {
            log.info("登录用户：{} 已被删除.", phoneNumber);
            throw new ServiceException("对不起，您的账号：" + phoneNumber+ " 已被删除");
        } else if (UserStatus.DISABLE.getCode().equals(user.getStatus())) {
            log.info("登录用户：{} 已被停用.", phoneNumber);
            throw new ServiceException("对不起，您的账号：" + phoneNumber+ " 已停用");
        }
        return createLoginUser(user);
    }

    public UserDetails createLoginUser(SysUser user) {
    	return new LoginUser(user.getUserId(), user.getDeptId(), user, permissionService.getMenuPermission(user));
        // return new LoginUser(user, permissionService.getMenuPermission(user));
    }

}