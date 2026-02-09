package com.healthcare.web.controller.system;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import com.healthcare.common.annotation.Log;
import com.healthcare.common.config.orderSystemConfig;
import com.healthcare.common.core.controller.BaseController;
import com.healthcare.common.core.domain.AjaxResult;
import com.healthcare.common.enums.BusinessType;
import com.healthcare.system.domain.HmOrderFdp;
import com.healthcare.system.service.IHmOrderFdpService;

import io.swagger.annotations.ApiOperation;

import com.healthcare.common.utils.OSOrder;
import com.healthcare.common.utils.OrderSystemUtils;
import com.healthcare.common.utils.poi.ExcelUtil;
import com.healthcare.common.core.page.TableDataInfo;
import com.healthcare.common.core.redis.RedisCache;

/**
 * 冻干粉订单Controller
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@RestController
@RequestMapping("/system/fdp")
public class HmOrderFdpController extends BaseController
{
    @Autowired
    private IHmOrderFdpService hmOrderFdpService;
    
    @Autowired
    private RedisCache redisCache;
    
    @Autowired
	private orderSystemConfig orderSystemConfig;

    /**
     * 查询冻干粉订单列表
     */
    @GetMapping("/list")
    @ApiOperation("冻干粉订单列表")
    public TableDataInfo list(HmOrderFdp hmOrderFdp)
    {
        startPage();
        List<HmOrderFdp> list = hmOrderFdpService.selectHmOrderFdpList(hmOrderFdp);
        return getDataTable(list);
    }
    
    /**
     * 客户端查询冻干粉订单列表
     * @throws Exception 
     */
    @GetMapping("/list4user")
    @ApiOperation("冻干粉订单列表")
    public TableDataInfo list4user(HmOrderFdp hmOrderFdp) throws Exception
    {
    	
    	Map<String , String> statusList = new HashMap<String,String>();
    	List codeList = new ArrayList();
        List<HmOrderFdp> list = hmOrderFdpService.selectHmOrderFdpMotherList(hmOrderFdp);
        for(HmOrderFdp order : list) {
        	if(order.getSyncFlag() == 1) {
        		codeList.add(order.getOrderCode());
        	}
        }
        if(codeList.size() > 0 ) {
        	OrderSystemUtils orderSystemUtils = new OrderSystemUtils();
            orderSystemUtils.redisCache = redisCache;
            List<OSOrder> osOrderList = orderSystemUtils.getOrderList(orderSystemConfig, codeList);
            
            for(OSOrder order : osOrderList) {
            	statusList.put(order.getProCode(), order.getOrderStatus());
            }
        }
        
        for (int i = 0; i < list.size(); i++) {
        	HmOrderFdp tmpObj = list.get(i);
        	if(tmpObj.getProStatus() == 2)
        		tmpObj.setStatusTxt("未签约");
        	else if(tmpObj.getProStatus() == 1)
        		tmpObj.setStatusTxt("已签约");
        	else if(tmpObj.getOrderStatus() == 1)
        		tmpObj.setStatusTxt("已付款");
        	
        	if(tmpObj.getSyncFlag() == 1) {
        		String orderCode = tmpObj.getOrderCode();
        		tmpObj.setStatusTxt(statusList.get(orderCode));
        	}
            // 直接修改当前元素的值
            list.set(i,  tmpObj);
        }
        
        return getDataTable(list );
    }
    


    /**
     * 导出冻干粉订单列表
     */
    @PreAuthorize("@ss.hasPermi('system:fdp:export')")
    @Log(title = "冻干粉订单", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, HmOrderFdp hmOrderFdp)
    {
        List<HmOrderFdp> list = hmOrderFdpService.selectHmOrderFdpList(hmOrderFdp);
        ExcelUtil<HmOrderFdp> util = new ExcelUtil<HmOrderFdp>(HmOrderFdp.class);
        util.exportExcel(response, list, "冻干粉订单数据");
    }

    /**
     * 获取冻干粉订单详细信息
     */
    @ApiOperation("冻干粉订单详情")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(hmOrderFdpService.selectHmOrderFdpById(id));
    }
    
    /**
     * 获取医院列表
     */
    @ApiOperation("获取医院列表")
    @GetMapping(value = "/getHospital")
    public AjaxResult getHospital()
    {
    	AjaxResult ajax = AjaxResult.success();
    	Collection<String> redisList = redisCache.keys("HspId_*");
    	List hospitalList = new ArrayList();
	    for (String item : redisList) {
	    	hospitalList.add(redisCache.getCacheObject(item));
	    }
	    ajax.put("hospitalList", hospitalList);
	    return ajax;
    }

    /**
     * 新增冻干粉订单
     */
    @ApiOperation("新增冻干粉订单")
    @Log(title = "冻干粉订单", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody HmOrderFdp hmOrderFdp)
    {
    	AjaxResult ajax = AjaxResult.success();
    	int orderId = hmOrderFdpService.insertHmOrderFdp(hmOrderFdp);
    	ajax.put("id", hmOrderFdp.getId());
        return ajax;
    }

    /**
     * 修改冻干粉订单
     */
    @ApiOperation("修改冻干粉订单")
    @Log(title = "冻干粉订单", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody HmOrderFdp hmOrderFdp)
    {
        return toAjax(hmOrderFdpService.updateHmOrderFdp(hmOrderFdp));
    }

    /**
     * 删除冻干粉订单
     */
    @PreAuthorize("@ss.hasPermi('system:fdp:remove')")
    @Log(title = "冻干粉订单", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(hmOrderFdpService.deleteHmOrderFdpByIds(ids));
    }
}
