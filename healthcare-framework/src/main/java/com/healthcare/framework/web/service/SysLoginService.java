package com.healthcare.framework.web.service;

import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import com.healthcare.common.constant.CacheConstants;
import com.healthcare.common.constant.Constants;
import com.healthcare.common.constant.UserConstants;
import com.healthcare.common.core.domain.entity.SysUser;
import com.healthcare.common.core.domain.model.LoginUser;
import com.healthcare.common.core.redis.RedisCache;
import com.healthcare.common.exception.ServiceException;
import com.healthcare.common.exception.user.BlackListException;
import com.healthcare.common.exception.user.CaptchaException;
import com.healthcare.common.exception.user.CaptchaExpireException;
import com.healthcare.common.exception.user.UserNotExistsException;
import com.healthcare.common.exception.user.UserPasswordNotMatchException;
import com.healthcare.common.utils.DateUtils;
import com.healthcare.common.utils.MessageUtils;
import com.healthcare.common.utils.StringUtils;
import com.healthcare.common.utils.ip.IpUtils;
import com.healthcare.framework.manager.AsyncManager;
import com.healthcare.framework.manager.factory.AsyncFactory;
import com.healthcare.framework.security.authentication.SmsCodeAuthenticationToken;
import com.healthcare.framework.security.context.AuthenticationContextHolder;
import com.healthcare.system.service.ISysConfigService;
import com.healthcare.system.service.ISysUserService;

/**
 * 登录校验方法
 * 
 * @author ruoyi
 */
@Component
public class SysLoginService
{
    @Autowired
    private TokenService tokenService;

    @Resource
    private AuthenticationManager authenticationManager;

    @Autowired
    private RedisCache redisCache;
    
    @Autowired
    private ISysUserService userService;

    @Autowired
    private ISysConfigService configService;

    /**
     * 登录验证
     * 
     * @param username 用户名
     * @param password 密码
     * @param code 验证码
     * @param uuid 唯一标识
     * @return 结果
     */
    public String login(String username, String password, String code, String uuid)
    {
        // 验证码校验
        validateCaptcha(username, code, uuid);
        // 登录前置校验
        loginPreCheck(username, password);
        // 用户验证
        Authentication authentication = null;
        try
        {
            UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(username, password);
            AuthenticationContextHolder.setContext(authenticationToken);
            // 该方法会去调用UserDetailsServiceImpl.loadUserByUsername
            authentication = authenticationManager.authenticate(authenticationToken);
        }
        catch (Exception e)
        {
            if (e instanceof BadCredentialsException)
            {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.not.match")));
                throw new UserPasswordNotMatchException();
            }
            else
            {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, e.getMessage()));
                throw new ServiceException(e.getMessage());
            }
        }
        finally
        {
            AuthenticationContextHolder.clearContext();
        }
        AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_SUCCESS, MessageUtils.message("user.login.success")));
        LoginUser loginUser = (LoginUser) authentication.getPrincipal();
        recordLoginInfo(loginUser.getUserId());
        // 生成token
        return tokenService.createToken(loginUser);
    }
    
    /**
     * 手机验证码验证
     * 
     * @param phonenumber 手机号
     * @param vcode 验证码
     * @return 结果
     */
    public String login4vcode(String phonenumber, String vcode)
    {
    	//String verifyKey = SysConst.REDIS_KEY_SMSLOGIN_SMSCODE + dto.getUuid();
    	String redisKey = "SMSVCODE_"+phonenumber;
    	
        String captcha = redisCache.getCacheObject(redisKey);
        if(captcha == null) {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(phonenumber, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.expire")));
            // 抛出一个验证码过期异常
            throw new CaptchaExpireException();
        }
        if(!captcha.equals(vcode.trim())){
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(phonenumber, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.error")));
            // 抛出一个验证码错误的异常
            throw new CaptchaException();
        }
        
        ////////////////////////////////////////////////////////////////////
//        redisCache.deleteObject(redisKey);
        
        // 用户验证
        Authentication authentication = null;
        
        
        try {
        	
        	SmsCodeAuthenticationToken smsService = new SmsCodeAuthenticationToken(phonenumber);
        	
            // 该方法会去调用UserDetailsByPhonenumberServiceImpl.loadUserByUsername
            authentication = authenticationManager.authenticate(smsService);
            
        } catch (Exception e) {
            if (e instanceof BadCredentialsException) {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(phonenumber, 
                		Constants.LOGIN_FAIL, MessageUtils.message("account.not.incorrect")));
                throw new UserPasswordNotMatchException();
            } else {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(phonenumber, 
                		Constants.LOGIN_FAIL, e.getMessage()));
                throw new ServiceException(e.getMessage());
            }
        }
        // 执行异步任务，记录登录信息
        AsyncManager.me().execute(AsyncFactory.recordLogininfor(phonenumber, 
        		Constants.LOGIN_SUCCESS, MessageUtils.message("user.login.success")));
        // 获取登录人信息
        LoginUser loginUser = (LoginUser) authentication.getPrincipal();
        // 修改最近登录IP和登录时间
        recordLoginInfo(loginUser.getUserId());
        // 生成token
        String token = tokenService.createToken(loginUser);

        return token;
    }

    /**
     * 校验验证码
     * 
     * @param username 用户名
     * @param code 验证码
     * @param uuid 唯一标识
     * @return 结果
     */
    public void validateCaptcha(String username, String code, String uuid)
    {
        boolean captchaEnabled = configService.selectCaptchaEnabled();
        if (captchaEnabled)
        {
            String verifyKey = CacheConstants.CAPTCHA_CODE_KEY + StringUtils.nvl(uuid, "");
            String captcha = redisCache.getCacheObject(verifyKey);
            redisCache.deleteObject(verifyKey);
            if (captcha == null)
            {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.expire")));
                throw new CaptchaExpireException();
            }
            if (!code.equalsIgnoreCase(captcha))
            {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.error")));
                throw new CaptchaException();
            }
        }
    }

    /**
     * 登录前置校验
     * @param username 用户名
     * @param password 用户密码
     */
    public void loginPreCheck(String username, String password)
    {
        // 用户名或密码为空 错误
        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password))
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("not.null")));
            throw new UserNotExistsException();
        }
        // 密码如果不在指定范围内 错误
        if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH)
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.not.match")));
            throw new UserPasswordNotMatchException();
        }
        // 用户名不在指定范围内 错误
        if (username.length() < UserConstants.USERNAME_MIN_LENGTH
                || username.length() > UserConstants.USERNAME_MAX_LENGTH)
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.not.match")));
            throw new UserPasswordNotMatchException();
        }
        // IP黑名单校验
        String blackStr = configService.selectConfigByKey("sys.login.blackIPList");
        if (IpUtils.isMatchedIp(blackStr, IpUtils.getIpAddr()))
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("login.blocked")));
            throw new BlackListException();
        }
    }

    /**
     * 记录登录信息
     *
     * @param userId 用户ID
     */
    public void recordLoginInfo(Long userId)
    {
        SysUser sysUser = new SysUser();
        sysUser.setUserId(userId);
        sysUser.setLoginIp(IpUtils.getIpAddr());
        sysUser.setLoginDate(DateUtils.getNowDate());
        userService.updateUserProfile(sysUser);
    }
}
