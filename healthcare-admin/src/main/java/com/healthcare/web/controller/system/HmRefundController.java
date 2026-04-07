package com.healthcare.web.controller.system;

import java.lang.reflect.Type;
import java.util.Collection;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
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
import com.alibaba.fastjson2.JSONObject;
import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import com.healthcare.common.annotation.Log;
import com.healthcare.common.config.WxPayConfig;
import com.healthcare.common.config.orderSystemConfig;
import com.healthcare.common.core.controller.BaseController;
import com.healthcare.common.core.domain.AjaxResult;
import com.healthcare.common.core.domain.entity.SysUser;
import com.healthcare.common.core.domain.model.LoginUser;
import com.healthcare.common.enums.BusinessType;
import com.healthcare.system.domain.HmHospital;
import com.healthcare.system.domain.HmInvoice;
import com.healthcare.system.domain.HmOrderFdp;
import com.healthcare.system.domain.HmRefund;
import com.healthcare.system.domain.HmRefund4OrderSystem;
import com.healthcare.system.service.IHmRefundService;

import io.swagger.annotations.ApiOperation;

import com.healthcare.common.utils.DateUtils;
import com.healthcare.common.utils.OrderSystemUtils;
import com.healthcare.common.utils.SecurityUtils;
import com.healthcare.common.utils.WxUtils;
import com.healthcare.common.utils.poi.ExcelUtil;
import com.healthcare.common.core.page.TableDataInfo;
import com.healthcare.common.core.redis.RedisCache;

/**
 * 退款单Controller
 * 
 * @author ruoyi
 * @date 2026-03-14
 */
@RestController
@RequestMapping("/system/refund")
public class HmRefundController extends BaseController
{
    @Autowired
    private IHmRefundService hmRefundService;
    
    @Autowired
    private RedisCache redisCache;
    
    @Autowired
	private orderSystemConfig orderSystemConfig;
    
    @Autowired
	private WxPayConfig wxPayConfig;
    
    private OrderSystemUtils orderSystemUtils;
    
	private void init() {
		this.orderSystemUtils = new OrderSystemUtils();
        this.orderSystemUtils.redisCache = redisCache;
    }

    /**
     * 查询退款单列表
     * @throws Exception 
     */
    @PreAuthorize("@ss.hasPermi('system:refund:list')")
    @GetMapping("/list")
    public TableDataInfo list(HmRefund hmRefund,BindingResult result) throws Exception
    {
	    if (result.hasErrors()) {
	        result.getAllErrors();
	        TableDataInfo returnErr = new TableDataInfo();
	        returnErr.setCode(500);
	        returnErr.setMsg("查询条件的类型不匹配:请输入数字!");
	        return returnErr;
	    }
    	//从业务系统同步信息
    	this.getRefund();
    	hmRefund.setDeleteFlag(0);
    	/*
    	boolean isAccountant = SecurityUtils.hasRole("accountant");
    	boolean isCashier = SecurityUtils.hasRole("cashier");
    	if(isAccountant) {
    		hmRefund.setCheckStep(2);
    	}
    	else if(isCashier) {
    		hmRefund.setCheckStep(1);
    	}
    	*/
    	startPage();
    	if(hmRefund.orderCode != null ) {
        	String tmpStr = hmRefund.orderCode.replace("P", "");
        	tmpStr = tmpStr.replace("F", "");
        	tmpStr = tmpStr.replace("D", "");
        	Long id = 0L;
        	try {
        		id = Long.parseLong(tmpStr);        		
        	}
        	catch(NumberFormatException e) {
        		;
        	}
        	
        	if(id > 30000) {
        		id -= 30000;
        	}
        	else if(id > 20000){
        		id -= 20000;
        	}
        	hmRefund.setOrderId(id);
        }
        List<HmRefund> list = hmRefundService.selectHmRefundList(hmRefund);
        return getDataTable(list);
    }
    
    @PostMapping("/syncRefund")
    public AjaxResult syncRefund(@RequestBody Long id) throws Exception {
    	HmRefund refundObj = hmRefundService.selectHmRefundById(id);
    	//同步给订单系统
		OrderSystemUtils orderSystemUtils = new OrderSystemUtils();
		orderSystemUtils.redisCache = redisCache;
        JSONObject returnObj = orderSystemUtils.syncRefund(refundObj.getSyncId(), refundObj.getOrderCode(), orderSystemConfig);
        HmRefund saveObj = new HmRefund();
        saveObj.setId(id);
        if(!"1".equals(returnObj.get("code").toString())){
        	saveObj.setSyncFlag(3);
        	saveObj.setRemark(returnObj.get("msg").toString());
        }
        else {
        	saveObj.setSyncFlag(1);
        	saveObj.setRemark("");
        }
        hmRefundService.updateHmRefund(saveObj);
        return AjaxResult.success();
    }
    
    /**
     * 审核退款单
     * @throws Exception 
     */
    @PreAuthorize("@ss.hasPermi('system:refund:edit')")
    @PostMapping("/checkRefund")
    public AjaxResult checkRefund(@RequestBody HmRefund hmRefund) throws Exception
    {
    	LoginUser loginUser = getLoginUser();
        SysUser currentUser = loginUser.getUser();
    	HmRefund refundObj = new HmRefund();
    	refundObj.setId(hmRefund.getId());
    	
    	if(hmRefund.getCheckStep() == 2) {
    		//先执行微信退款
    		WxUtils wxUtils = new WxUtils();
    		AjaxResult result = wxUtils.createWeChatRefund(hmRefund.getOrderCode(), hmRefund.getSyncId().toString(), hmRefund.getAmount(), hmRefund.getRefund(), wxPayConfig);
    		if(!result.isSuccess()) {
    			refundObj.setWxStatus(2);
    			refundObj.setWxResult(result.get(result.MSG_TAG).toString());
    			hmRefundService.updateHmRefund(refundObj);
    			return result;
    		}
    		//同步给订单系统
    		OrderSystemUtils orderSystemUtils = new OrderSystemUtils();
    		orderSystemUtils.redisCache = redisCache;
            JSONObject returnObj = orderSystemUtils.syncRefund(hmRefund.getSyncId(), hmRefund.getOrderCode(), orderSystemConfig);
            if(!"1".equals(returnObj.get("code").toString())){
            	refundObj.setSyncFlag(3);
            	refundObj.setRemark(returnObj.get("msg").toString());
            }
            else {
            	refundObj.setSyncFlag(1);
            }
    		
    		//退款成功就更新审核信息
    		refundObj.setUser2Id(currentUser.getUserId());
    		refundObj.setCommit2Date(DateUtils.parseDate(DateUtils.getTime()));
    		refundObj.setWxStatus(1);
    		refundObj.setWxResult("退款成功");
    		hmRefundService.updateHmRefund(refundObj);
    	}
    	else if(hmRefund.getCheckStep() == 1) {
    		refundObj.setUser1Id(currentUser.getUserId());
    		refundObj.setCommit1Date(DateUtils.parseDate(DateUtils.getTime()));
    		hmRefundService.updateHmRefund(refundObj);
    	}
		
        return AjaxResult.success();
    }
    
    /**
     * 订单系统 获取退款单
	 * @throws Exception 
     */
	@ApiOperation("获取退款单")
	@GetMapping(value = "/getRefund")
	public void getRefund() throws Exception {
		init();
		//先把所有进行中的退款单设为无效。
		hmRefundService.updateDeleteFlag();
		
		JSONObject para = new JSONObject();
		para.put("RefundType", 2);
		
		String result = orderSystemUtils.send2OrderSystem(orderSystemConfig, "GetPendingRefundListV1", para.toString());
		JSONObject returnObj = JSON.parseObject(result);
		if(returnObj == null) {
			throw new Exception("更新退款单失败[]！");
		}

		if(returnObj.get("code").equals("1") && returnObj.get("msg").equals("成功")) {
			String dataStr = returnObj.get("data").toString();
			Gson gson = new Gson();
		    Type listType = new TypeToken<List<HmRefund4OrderSystem>>(){}.getType();
		    List<HmRefund4OrderSystem> refundList = gson.fromJson(dataStr, listType);
		    
		    for(HmRefund4OrderSystem refund : refundList) {
		    	//先检查是否已经同步过了
		    	HmRefund cond = new  HmRefund();
		    	cond.setSyncId(refund.getRefundId());
		    	cond.setDeleteFlag(-1);
				List<HmRefund> list = hmRefundService.selectHmRefundList(cond );
				HmRefund hmRefund = new HmRefund();
				//如果接口退款单在数据库中没有就新增
				if(list.size() == 0) {
			    	hmRefund.setSyncId(refund.getRefundId());
			    	hmRefund.setOrderId(Long.parseLong(refund.getProCode().substring(6)));
			    	hmRefund.setFirstName(refund.getPartaName());
			    	hmRefund.setAmount(refund.getAmountReceived());
			    	hmRefund.setRefund(refund.getAmountRefund());
			    	
					hmRefundService.insertHmRefund(hmRefund);
				}
				//已经存在的退款单修改有效标志
				else if(list.size() > 0) {
					hmRefund= list.get(0);
					hmRefund.setDeleteFlag(0);
					hmRefundService.updateHmRefund(hmRefund);
				}
		    }
		}
		else {
			throw new Exception(returnObj.get("msg").toString());
		}
	}

    /**
     * 导出退款单列表
     */
    @PreAuthorize("@ss.hasPermi('system:refund:export')")
    @Log(title = "退款单", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, HmRefund hmRefund)
    {
        List<HmRefund> list = hmRefundService.selectHmRefundList(hmRefund);
        for(HmRefund obj : list) {
        	obj.setOrderCode(obj.getOrderCode());
        }
        ExcelUtil<HmRefund> util = new ExcelUtil<HmRefund>(HmRefund.class);
        util.exportExcel(response, list, "退款单数据");
    }

    /**
     * 获取退款单详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:refund:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(hmRefundService.selectHmRefundById(id));
    }

    /**
     * 新增退款单
     */
    @PreAuthorize("@ss.hasPermi('system:refund:add')")
    @Log(title = "退款单", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody HmRefund hmRefund)
    {
        return toAjax(hmRefundService.insertHmRefund(hmRefund));
    }

    /**
     * 修改退款单
     */
    @PreAuthorize("@ss.hasPermi('system:refund:edit')")
    @Log(title = "退款单", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody HmRefund hmRefund)
    {
        return toAjax(hmRefundService.updateHmRefund(hmRefund));
    }

    /**
     * 删除退款单
     */
    @PreAuthorize("@ss.hasPermi('system:refund:remove')")
    @Log(title = "退款单", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(hmRefundService.deleteHmRefundByIds(ids));
    }
    /*
    private boolean hasRole(String roleKey) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            return false; // 用户未登录或未认证
        }
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (GrantedAuthority authority : authorities) {
            if (role.equals(authority.getAuthority())) { // 比较角色名称，例如 "ROLE_ADMIN" 或 "ROLE_USER"
                return true;
            }
        }
    	return false;
    }
    */
}
