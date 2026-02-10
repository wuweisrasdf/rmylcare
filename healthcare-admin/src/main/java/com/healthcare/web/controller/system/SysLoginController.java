package com.healthcare.web.controller.system;

import java.util.List;
import java.util.Random;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import javax.validation.constraints.Size;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.healthcare.common.constant.Constants;
import com.healthcare.common.core.domain.AjaxResult;
import com.healthcare.common.core.domain.entity.SysMenu;
import com.healthcare.common.core.domain.entity.SysUser;
import com.healthcare.common.core.domain.model.LoginBody;
import com.healthcare.common.core.redis.RedisCache;
import com.healthcare.common.utils.SecurityUtils;
import com.healthcare.framework.web.service.SysLoginService;
import com.healthcare.framework.web.service.SysPermissionService;
import com.healthcare.system.domain.HmMother;
import com.healthcare.system.service.IHmMotherService;
import com.healthcare.system.service.ISysMenuService;
import com.healthcare.system.service.ISysUserService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 登录验证
 * 
 * @author ruoyi
 */
@RestController
public class SysLoginController
{
    @Autowired
    private SysLoginService loginService;
    
    @Autowired
    private ISysUserService userService;

    @Autowired
    private ISysMenuService menuService;

    @Autowired
    private SysPermissionService permissionService;
    
    @Autowired
    private IHmMotherService hmMotherService;
    
    @Autowired
    private RedisCache redisCache;

    /**
     * 登录方法
     * 
     * @param loginBody 登录信息
     * @return 结果
     */
    @ApiOperation("手机密码登录")
    @PostMapping("/login")
    public AjaxResult login(@RequestBody LoginBody loginBody)
    {
        AjaxResult ajax = AjaxResult.success();
        // 生成令牌
        String token = loginService.login(loginBody.getUsername(), loginBody.getPassword(), loginBody.getCode(),
                loginBody.getUuid());
        ajax.put(Constants.TOKEN, token);
        return ajax;
    }
    
    /**
     * 发送手机验证码
     * 
     * @param loginBody 登录信息
     * @return 结果
     */
    @ApiOperation("发送验证码")
    @PostMapping("/sendvcode")
    public AjaxResult sendvcode(@RequestBody SysUser user)
    {
        AjaxResult ajax = AjaxResult.success();
        
		String phonenumber = user.getPhonenumber();
        
		// 生成6位验证码
		Random random = new Random();
        // 生成0-999999的随机数，然后格式化为6位数字，不足前面补零
        int randomNum = random.nextInt((int) Math.pow(10, 6));
        String vcode = String.format("%0" + 6 + "d", randomNum);
        
        //存入redis
        redisCache.setCacheObject("SMSVCODE_"+phonenumber, vcode, 5, TimeUnit.MINUTES);
        //redisCache.setCacheObject("SMSVCODE_"+phonenumber, vcode);
        
        //调用短信接口
        ///////////////////////////////////////////////////////////////
        System.out.print(vcode);
        
        ///////////////////////////////////////////////////////////////
        
        return ajax.success();
    }
    
    /**
     * 校验手机验证码
     * 
     * @param loginBody 登录信息
     * @return 结果
     */
    @ApiOperation("校验手机验证码")
    @PostMapping("/checkvcode")
    public AjaxResult checkvcode(@RequestBody LoginBody loginBody)
    {
        AjaxResult ajax = AjaxResult.success();
        String phonenumber = loginBody.getPhonenumber();
        
        String redisKey = "SMSVCODE_"+phonenumber;
    	
        if(redisCache.hasKey(redisKey)) {
        	String captcha = redisCache.getCacheObject(redisKey);
        	if(loginBody.getVcode().equals(captcha))
        		return ajax.success();
        }
        return ajax.error("校验失败");
    }
    
    
    /**
     * 手机验证码登录
     * 
     * @param loginBody 登录信息
     * @return 结果
     */
    @ApiOperation("手机验证码登录")
    @PostMapping("/login4vcode")
    public AjaxResult login4vcode(@RequestBody LoginBody loginBody)
    {
        AjaxResult ajax = AjaxResult.success();
        // 生成令牌
        String token = loginService.login4vcode(loginBody.getPhonenumber(), loginBody.getVcode());
        ajax.put(Constants.TOKEN, token);
        return ajax;
    }
    
    
    /**
     * 获取用户信息
     * 
     * @return 用户信息
     */
    @ApiOperation("获取用户信息")
    @GetMapping("getInfo")
    public AjaxResult getInfo()
    {
        SysUser user = SecurityUtils.getLoginUser().getUser();
        // 角色集合
        Set<String> roles = permissionService.getRolePermission(user);
        // 权限集合
        Set<String> permissions = permissionService.getMenuPermission(user);
        //如果通过editMotherUser修改了user，需要重新取user
        Long userId = user.getUserId();
        user = userService.selectUserById(userId);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("user", user);
        ajax.put("roles", roles);
        ajax.put("permissions", permissions);
        
        return ajax;
    }
    
    /**
     * 获取用户+产妇信息
     * 
     * @return 获取用户+产妇信息
     */
    @ApiOperation("获取用户+产妇信息")
    @GetMapping("getInfo2")
    public AjaxResult getInfo2()
    {
        SysUser user = SecurityUtils.getLoginUser().getUser();
        // 角色集合
        Set<String> roles = permissionService.getRolePermission(user);
        // 权限集合
        Set<String> permissions = permissionService.getMenuPermission(user);
        
        //如果通过editMotherUser修改了user，需要重新取user
        Long userId = user.getUserId();
        user = userService.selectUserById(userId);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("user", user);
        ajax.put("roles", roles);
        ajax.put("permissions", permissions);
        
        //追加相关产妇的列表
        ///////////////////////////////////
        HmMother cond = new HmMother();
        cond.setUserId(user.getUserId());
        List<HmMother> motherList = hmMotherService.selectHmMotherList(cond);
        ajax.put("mother", motherList);
        return ajax;
    }

    /**
     * 获取路由信息
     * 
     * @return 路由信息
     */
    @GetMapping("getRouters")
    public AjaxResult getRouters()
    {
        Long userId = SecurityUtils.getUserId();
        List<SysMenu> menus = menuService.selectMenuTreeByUserId(userId);
        return AjaxResult.success(menuService.buildMenus(menus));
    }
}
