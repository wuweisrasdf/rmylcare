package com.healthcare.web.controller.system;

import java.util.List;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.healthcare.common.config.RuoYiConfig;
import com.healthcare.common.config.orderSystemConfig;
import com.healthcare.common.core.controller.BaseController;
import com.healthcare.common.core.redis.RedisCache;
import com.healthcare.common.utils.OSOrder;
import com.healthcare.common.utils.OrderSystemUtils;
import com.healthcare.common.utils.WxUtils;
import com.healthcare.common.utils.http.HttpUtils;

import io.swagger.annotations.ApiOperation;

/**
 * Token Controller
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@RestController
@RequestMapping("/system/token")
public class HmTokenController extends BaseController
{
	@Autowired
    private RedisCache redisCache;
	
	@Autowired
	private orderSystemConfig orderSystemConfig;
	
	@ApiOperation("取微信token")
	@GetMapping("/getWxToken")
	public String getWxToken() throws Exception {
		WxUtils wxUtils = new WxUtils();
		String accessToken = wxUtils.getWxToken(redisCache);
		return accessToken;
	}
	
	@ApiOperation("取后台系统token")
	@GetMapping("/getOrderSystemToken")
	public String getOrderSystemToken() throws Exception  {
		OrderSystemUtils orderSystemUtils = new OrderSystemUtils();
        orderSystemUtils.redisCache = redisCache;
        String accessToken = orderSystemUtils.gettoken(orderSystemConfig);
		return accessToken;
	}
	
}
