package com.healthcare.web.controller.system;

import java.lang.reflect.Type;
import java.text.SimpleDateFormat;
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
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.healthcare.common.annotation.Log;
import com.healthcare.common.config.orderSystemConfig;
import com.healthcare.common.core.controller.BaseController;
import com.healthcare.common.core.domain.AjaxResult;
import com.healthcare.common.core.domain.entity.SysUser;
import com.healthcare.common.enums.BusinessType;
import com.healthcare.system.domain.HmOrderFdp;
import com.healthcare.system.domain.HmOrderFdpReturn;
import com.healthcare.system.service.IHmOrderFdpReturnService;
import com.healthcare.system.service.IHmOrderFdpService;
import com.healthcare.system.service.ISysUserService;

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
    private IHmOrderFdpReturnService hmOrderFdpReturnService;
    
    @Autowired
    private RedisCache redisCache;
    
    @Autowired
	private orderSystemConfig orderSystemConfig;
    
    @Autowired
    private ISysUserService userService;

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
        	
        	if(tmpObj.getOrderStatus() == 1)
        		tmpObj.setStatusTxt("已付款");
        	
        	if(tmpObj.getSyncFlag() == 1) {
        		String orderCode = tmpObj.getOrderCode();
        		tmpObj.setStatusTxt(statusList.get(orderCode));
        	}
            // 直接修改当前元素的值
            list.set(i,  tmpObj);
        }
        
        //如果是订单详情
        if(hmOrderFdp.getId() != null) {
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        	HmOrderFdp tmpObj = list.get(0);
        	List<Map<String, String>> progressList = new ArrayList<Map<String, String>>();
        	if(tmpObj.getSyncFlag() == 1) {
        		OrderSystemUtils orderSystemUtils = new OrderSystemUtils();
                orderSystemUtils.redisCache = redisCache;
                JSONArray progress = orderSystemUtils.getOrderDetail(orderSystemConfig, tmpObj.getOrderCode());
                //"OrderProgress":[{"Id":"1","OrderName":"已签约","Status":"1","StatusDate":"2026-02-09","Desc":"签约已完成"},{"Id":"2","OrderName":"已付款","Status":"1","StatusDate":"2026-02-09","Desc":"支付已完成"},{"Id":"3","OrderName":"样本接收","Status":"1","StatusDate":"2026-02-09","Desc":"样本已送达处理中心"},{"Id":"4","OrderName":"病毒检测","Status":"0","StatusDate":"","Desc":"病毒检测已完成"},{"Id":"5","OrderName":"制备完成","Status":"0","StatusDate":"","Desc":"产品已制备完成"},{"Id":"6","OrderName":"配送","Status":"0","StatusDate":"","Desc":"产品已发出，请关注物流"},{"Id":"7","OrderName":"已完成","Status":"0","StatusDate":"","Desc":"产品已签收"}]
                Map<String, String> progObj1 = new HashMap<String, String>();
                progObj1.put("Id", "0");
                progObj1.put("OrderName", "未签约");
                progObj1.put("StatusDate", sdf.format(tmpObj.getCreateTime()));
                progressList.add(progObj1);
            	for (int i = 0; i < progress.size(); i++) {
            		Map<String, String> progObj = new HashMap<String, String>();
            	    String jsonString = progress.getString(i);
            	    jsonString = jsonString.replace("[", "");
            	    jsonString = jsonString.replace("]", "");
            	    JSONObject jsonObject = JSON.parseObject(jsonString);
            	    if(jsonObject.getString("Status").equals("0"))
            	    	break;
            	    progObj.put("Id", jsonObject.getString("Id"));
                    progObj.put("OrderName", jsonObject.getString("OrderName"));
                    progObj.put("StatusDate", jsonObject.getString("StatusDate"));
                    progressList.add(progObj);
            	}
        	}
        	else {
        		Map<String, String> progInfo = new HashMap<String, String>();
        		progInfo.put("id", "0");
        		progInfo.put("OrderName", "未签约");
        		progInfo.put("StatusDate", sdf.format(tmpObj.getCreateTime()));
        		progressList.add(progInfo);
        		
        		if(!tmpObj.getProCode().isEmpty()) {
        			Map<String, String> progInfo1 = new HashMap<String, String>();
            		progInfo1.put("id", "1");
            		progInfo1.put("OrderName", "已签约");
            		progInfo1.put("StatusDate", sdf.format(tmpObj.getSignDate()));
            		progressList.add(progInfo1);
            		
            		if(tmpObj.getPayDate() != null) {
            			Map<String, String> progInfo2 = new HashMap<String, String>();
                		progInfo2.put("id", "2");
                		progInfo2.put("OrderName", "已付款");
                		progInfo2.put("StatusDate", sdf.format(tmpObj.getPayDate()));
                		progressList.add(progInfo2);
            		}
        		}
        	}
        	tmpObj.setOrderProgress(progressList);
        	
        	//详情页面又加入了甲方手机号、证件类型、证件号
        	tmpObj.setMotherIdType(tmpObj.getIdType());
        	tmpObj.setMotherIdCode(tmpObj.getIdCode());
        	tmpObj.setMotherPhonenumber(tmpObj.getPhonenumber());
        	
        	if(tmpObj.getUserInfo() == null) //如果还没签约，从user里读
        	{
        		Long userId = tmpObj.getUserId();
        		SysUser userObj = userService.selectUserById(userId);
        		tmpObj.setIdType(userObj.getIdType());
        		tmpObj.setIdCode(userObj.getIdCode());
            	tmpObj.setPhonenumber(userObj.getPhonenumber());
            	tmpObj.setUserName(userObj.getNickName());
            	tmpObj.setUserEmail(userObj.getEmail());
        	}
        	else {//已签约的从user_info字段里读
        		String jsonStr = tmpObj.getUserInfo();
        		JsonObject jsonObject = JsonParser.parseString(jsonStr).getAsJsonObject();
        		tmpObj.setUserName(jsonObject.get("userName").getAsString());
        		tmpObj.setIdType(jsonObject.get("idType").getAsString());
        		
        		tmpObj.setIdCode(jsonObject.get("idCode").getAsString());
        		tmpObj.setUserEmail(jsonObject.get("userEmail").getAsString());
        		tmpObj.setPhonenumber(jsonObject.get("phonenumber").getAsString());
        	}
        	
        	//详情页需要加入是否已经签署解约 
            HmOrderFdpReturn cond = new HmOrderFdpReturn();
            cond.setOrderId(tmpObj.getId());
			List<HmOrderFdpReturn> resultList = hmOrderFdpReturnService.selectHmOrderFdpReturnList(cond );
			if(resultList.size() > 0) {
				HmOrderFdpReturn orderReturn = resultList.get(resultList.size()-1);
				if(!orderReturn.getProCode().isEmpty()) {
					tmpObj.setSignReturnDate(orderReturn.getSignDate());
				}
			}
        	list.set(0,  tmpObj);
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
