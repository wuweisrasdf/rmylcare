package com.healthcare.web.controller.system;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import com.healthcare.common.config.orderSystemConfig;
import com.healthcare.common.core.controller.BaseController;
import com.healthcare.common.core.domain.AjaxResult;
import com.healthcare.common.core.domain.entity.SysUser;
import com.healthcare.common.core.redis.RedisCache;
import com.healthcare.common.utils.DateUtils;
import com.healthcare.common.utils.OrderSystemUtils;
import com.healthcare.system.domain.HmDeliveryAddress;
import com.healthcare.system.domain.HmHospital;
import com.healthcare.system.domain.HmInvoice;
import com.healthcare.system.domain.HmMotherUser;
import com.healthcare.system.domain.HmOrderFdp;
import com.healthcare.system.domain.HmOrderFdpReturn;
import com.healthcare.system.domain.HmPayment;
import com.healthcare.system.service.IHmOrderFdpReturnService;
import com.healthcare.system.service.IHmOrderFdpService;
import com.healthcare.system.service.IHmPaymentService;
import com.healthcare.system.service.ISysUserService;

import io.swagger.annotations.ApiOperation;

/**
 * 与业务系统接口Controller
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@RestController
@RequestMapping("/interface/order")
public class OrderSystemController extends BaseController
{
	@Autowired
    private IHmOrderFdpService hmOrderFdpService;
	
	@Autowired
    private IHmOrderFdpReturnService hmOrderFdpReturnService;
	
	@Autowired
    private IHmPaymentService hmPaymentService;
	
	@Autowired
    private RedisCache redisCache;
	
	@Autowired
	private orderSystemConfig orderSystemConfig;
	
	@Autowired
    private ISysUserService userService;
	
	private OrderSystemUtils orderSystemUtils;
	
	private void init() {
		this.orderSystemUtils = new OrderSystemUtils();
        this.orderSystemUtils.redisCache = redisCache;
    }
	
	/**
     * 同步医院列表
     * @throws Exception 
     */
	@ApiOperation("同步医院列表")
	@PostMapping("/syncHostpitalList")
	public String getHostpitalList() throws Exception {
		init();
		String result = orderSystemUtils.send2OrderSystem(orderSystemConfig, "GetHspAllListV1", "");
		
		JSONObject returnObj = JSON.parseObject(result);
		if(returnObj == null) {
			throw new Exception("获取医院列表失败！");
		}
		String dataStr = returnObj.get("data").toString();
		Gson gson = new Gson();
	    Type listType = new TypeToken<List<HmHospital>>(){}.getType();
	    List<HmHospital> hospitalList = gson.fromJson(dataStr, listType);
	    
	    //先把缓存清了, 重新赋值
	    Collection<String> redisList = redisCache.keys("HspId_*");
	    for (String item : redisList) {
	    	redisCache.deleteObject(item);
	    }
	    for(HmHospital hospital : hospitalList) {
	    	redisCache.setCacheObject("HspId_"+hospital.getHspId(), hospital.getHspName());
	    }
		return "";
	}
	
	/**
	 * 定时任务接口
     * 同步合同,支付单,解约协议
     * @throws Exception 
     */
	@ApiOperation("同步数据")
	@PostMapping("/syncData")
	public String syncData() throws Exception {
		boolean success ;
		init();
		//同步合同
		HmOrderFdp orderCond = new HmOrderFdp();
		orderCond.setSyncFlag(0);		//未同步
		orderCond.setProStatus(1);	//已签约
		List<HmOrderFdp> orderList = hmOrderFdpService.selectHmOrderFdpList(orderCond);
		for(HmOrderFdp order : orderList) {
			success = this.syncOrder(order.getId());
			if(success)
				logger.info("sync success:orderId="+order.getId()+"["+order.getOrderCode()+"]");
			else
				logger.info("sync false:orderId="+order.getId()+"["+order.getOrderCode()+"]");
		}
		
		//同步付款单
		HmPayment payCond = new HmPayment();
		payCond.setSyncFlag(0);		//未同步
		payCond.setHasPayed(1);		//已支付成功
		List<HmPayment> payList = hmPaymentService.selectHmPaymentList(payCond);
		for(HmPayment payment : payList) {
			success = this.syncPayment(payment.getId());
			if(success)
				logger.info("sync success:payId="+payment.getId()+"["+payment.getTransactionId()+"]");
			else
				logger.info("sync false:payId="+payment.getId()+"["+payment.getTransactionId()+"]");
		}
		
		//同步解约协议
		HmOrderFdpReturn orderReturnCond = new HmOrderFdpReturn();
		orderReturnCond.setSyncFlag(0);		//未同步
		orderReturnCond.setStatus(2);			//已签
		List<HmOrderFdpReturn> orderReturnList = hmOrderFdpReturnService.selectHmOrderFdpReturnList(orderReturnCond);
		for(HmOrderFdpReturn orderReturn : orderReturnList) {
			success = this.syncOrderReturn(orderReturn.getId());
			if(success)
				logger.info("sync success:orderreturnId="+orderReturn.getId()+"["+orderReturn.getProCode()+"]");
			else
				logger.info("sync false:orderreturnId="+orderReturn.getId()+"["+orderReturn.getProCode()+"]");
		}
	
		return "sync finished!";
	}
	
	

	/**
     * 获得订单列表
     * @throws Exception 
     */
	@ApiOperation("获得订单列表")
	@PostMapping("/getOrderList")
	public void getOrderList(String orderCode) throws Exception {
		init();
		List orderList = new ArrayList();
		orderList.add(orderCode);
		List result = orderSystemUtils.getOrderList(orderSystemConfig, orderList);
	}
	
	/**
     * 向订单系统 发送 新增订单
     * @throws Exception 
     */
	@ApiOperation("向订单系统 发送 新增订单")
	@PostMapping("/syncOrder")
	public boolean syncOrder(Long orderId) throws Exception {
		boolean returnFlag = false;
		init();
		
		HmOrderFdp cond = new  HmOrderFdp();
		cond.setId(orderId);
		List<HmOrderFdp> resultList = hmOrderFdpService.selectHmOrderFdpMotherList(cond);
		HmOrderFdp orderObj = resultList.get(0);
		//取甲方
		Long userId = orderObj.getUserId();
		SysUser userObj = userService.selectUserById(userId);
		//取销售
		Long salesId = orderObj.getSalesId();
		SysUser salesObj = userService.selectUserById(salesId);
		String SalesCode = "";
		if(salesObj != null)
			SalesCode = salesObj.getUserName();
		
		JSONObject para = new JSONObject();
		para.put("ProCode", orderObj.getOrderCode());
		para.put("PartaName", userObj.getNickName());
		para.put("PartaTypeNumber", userObj.getIdType());
		para.put("PartaNumber", userObj.getIdCode());
		para.put("PartaTel", userObj.getPhonenumber());
		para.put("CustomerAddr", orderObj.getAddress());
		para.put("CustomerEmail", userObj.getEmail());
		para.put("MotherName", orderObj.getMotherName());
		
		para.put("MotherTypeNumber", orderObj.getIdType());
		para.put("MotherNumber", orderObj.getIdCode());
		para.put("MotherTel", orderObj.getPhonenumber());
		para.put("HspId", getHspId(orderObj.getHospitalName()));
		para.put("PreDate", orderObj.getDueDate());
		para.put("ProAddr", orderObj.getProCode());
		para.put("FullPrice", orderObj.getPriceOut());
		para.put("Discount", 0);
		para.put("AmountReceivable", orderObj.getPriceOut());
		para.put("SignDate", orderObj.getSignDate());
		para.put("SalesCode", SalesCode);
		
		String result = orderSystemUtils.send2OrderSystem(orderSystemConfig, "CreateProtocolV1", para.toString());
		
		JSONObject returnObj = JSON.parseObject(result);
		if(returnObj == null) {
			throw new Exception("同步合同失败["+orderObj.getOrderCode()+"]！");
		}
		
		//回写订单同步标志
		HmOrderFdp syncObj = new HmOrderFdp();
		syncObj.setId(orderId);
		if(returnObj.get("code").equals("1") && returnObj.get("msg").equals("成功")) {
			syncObj.setSyncFlag(1);
			returnFlag = true;
		}
		else {
			syncObj.setSyncFlag(3);
			syncObj.setRemark(returnObj.get("msg").toString());
		}
		hmOrderFdpService.updateHmOrderFdp(syncObj);

		return returnFlag;
	}
	
	/**
     * 向订单系统 发送 新增解除协议
     * @throws Exception 
     */
	@ApiOperation("向订单系统 发送 新增解除协议")
	@PostMapping("/syncOrderReturn")
	public boolean syncOrderReturn(Long returnId) throws Exception {
		init();
		
		HmOrderFdpReturn orderReturn = hmOrderFdpReturnService.selectHmOrderFdpReturnById(returnId);

		Long orderId = orderReturn.getOrderId();
		HmOrderFdp orderObj = hmOrderFdpService.selectHmOrderFdpById(orderId);
		
		JSONObject para = new JSONObject();
		para.put("ProCode", orderObj.getOrderCode());
		para.put("TerminateProtocolDate", orderReturn.getSignDate());
		para.put("TerminateProtocolAddr", orderReturn.getProCode());
		
		String result = orderSystemUtils.send2OrderSystem(orderSystemConfig, "CreateTAV1", para.toString());
		
		JSONObject returnObj = JSON.parseObject(result);
		if(returnObj == null) {
			throw new Exception("同步解约协议失败["+returnId+"]！");
		}
		
		//回写订单同步标志
		HmOrderFdpReturn syncObj = new HmOrderFdpReturn();
		syncObj.setId(returnId);
		if(returnObj.get("code").equals("1") && returnObj.get("msg").equals("成功")) {
			syncObj.setSyncFlag(1);
		}
		else {
			syncObj.setSyncFlag(3);
		}
		hmOrderFdpReturnService.updateHmOrderFdpReturn(syncObj);

		return true;
	}
	
	
	/**
     * 向订单系统 发送 付款单
     * @throws Exception 
     */
	@ApiOperation("向订单系统 发送 付款单")
	@PostMapping("/syncPayment")
	public boolean syncPayment(Long payId) throws Exception {
		init();
		HmPayment cond = new  HmPayment();
		cond.setId(payId);
		HmPayment payObj = hmPaymentService.selectHmPaymentById(payId);

		//取合同编号
		Long orderId = payObj.getOrderId();
		HmOrderFdp orderObj = hmOrderFdpService.selectHmOrderFdpById(orderId);

		JSONObject para = new JSONObject();
		para.put("ProCode", orderObj.getOrderCode());
		para.put("PayOrderNumber", payObj.getTransactionId());
		para.put("PayType", 3);
		para.put("AmountReceived", payObj.getPayAmount());
		para.put("PayDate", payObj.getPayDate());
		
		
		String result = orderSystemUtils.send2OrderSystem(orderSystemConfig, "CreatePaymentV1", para.toString());
		
		JSONObject returnObj = JSON.parseObject(result);
		if(returnObj == null) {
			throw new Exception("同步支付单失败["+payObj.getId()+"]！");
		}
		
		//回写订单同步标志
		HmPayment syncObj = new HmPayment();
		syncObj.setId(payId);
		if(returnObj.get("code").equals("1") && returnObj.get("msg").equals("成功")) {
			syncObj.setSyncFlag(1);
		}
		else {
			syncObj.setSyncFlag(3);
		}
		hmPaymentService.updateHmPayment(syncObj);
		return true;
	}
	
	private String getHspId(String hospitalName) {
		Collection<String> redisList = redisCache.keys("HspId_*");
	    for (String item : redisList) {
	    	String redisName = redisCache.getCacheObject(item);
	    	if(redisName.equals(hospitalName))
	    		return item.replace("HspId_", "");
	    }
	    return "H0000";
	}
	
	/**
     * 从订单系统 获取收货地址
	 * @throws Exception 
     */
	@ApiOperation("获取收货地址")
	@GetMapping(value = "getDeliveryAddress/{orderId}")
	public AjaxResult getDeliveryAddress(@PathVariable("orderId") Long orderId) throws Exception {
		AjaxResult ajax = AjaxResult.success();
		init();
		//取合同编号
		HmOrderFdp orderObj = hmOrderFdpService.selectHmOrderFdpById(orderId);
		String orderCode = orderObj.getOrderCode();
		JSONObject para = new JSONObject();
		para.put("ProCode", orderCode);
		
		String result = orderSystemUtils.send2OrderSystem(orderSystemConfig, "GetCneeAddrV1", para.toString());
		JSONObject returnObj = JSON.parseObject(result);
		if(returnObj == null) {
			throw new Exception("获取收货地址失败["+orderObj.getOrderCode()+"]！");
		}
		//{"code":"1","msg":"成功","data":{"CneeName":"王越","CneeTel":"18600581569","CneeAddr":"北京市朝阳区"}}
		if(returnObj.get("code").equals("1") && returnObj.get("msg").equals("成功")) {
			JSONObject dataObj = JSON.parseObject(returnObj.get("data").toString());
			ajax.put("consignee", dataObj.getString("CneeName"));
			ajax.put("contactNumber", dataObj.getString("CneeTel"));
			ajax.put("deliveryAddress", dataObj.getString("CneeAddr"));
		}
		else {
			ajax = AjaxResult.error(returnObj.get("msg").toString());
		}
		return ajax;
	}
	
	/**
     * 订单系统 更新收货地址
	 * @throws Exception 
     */
	@ApiOperation("更新收货地址")
	@PutMapping(value = "/updateDeliveryAddress")
	public AjaxResult updateDeliveryAddress(@RequestBody HmDeliveryAddress user) throws Exception {
		AjaxResult ajax = AjaxResult.success();
		init();
		//取合同编号
		HmOrderFdp orderObj = hmOrderFdpService.selectHmOrderFdpById(user.getOrderId());
		String orderCode = orderObj.getOrderCode();
		JSONObject para = new JSONObject();
		para.put("ProCode", orderCode);
		para.put("CneeName", user.getConsignee());
		para.put("CneeTel", user.getContactNumber());
		para.put("CneeAddr", user.getDeliveryAddress());
		para.put("UpdDate", DateUtils.getTime());
		
		String result = orderSystemUtils.send2OrderSystem(orderSystemConfig, "UpdCneeAddrV1", para.toString());
		JSONObject returnObj = JSON.parseObject(result);
		if(returnObj == null) {
			throw new Exception("更新收货地址失败["+orderObj.getOrderCode()+"]！");
		}
		//{"code":"1","msg":"成功","data":{"CneeName":"王越","CneeTel":"18600581569","CneeAddr":"北京市朝阳区"}}
		if(returnObj.get("code").equals("1") && returnObj.get("msg").equals("成功")) {
			return ajax;
		}
		else {
			ajax = AjaxResult.error(returnObj.get("msg").toString());
		}
		return ajax;
	}
	
	
	/**
     * 从订单系统 获取发票信息
	 * @throws Exception 
     */
	@ApiOperation("获取获取发票信息")
	@GetMapping(value = "getInvoice/{orderId}")
	public AjaxResult getInvoice(@PathVariable("orderId") Long orderId) throws Exception {
		AjaxResult ajax = AjaxResult.success();
		init();
		//取合同编号
		HmOrderFdp orderObj = hmOrderFdpService.selectHmOrderFdpById(orderId);
		String orderCode = orderObj.getOrderCode();
		JSONObject para = new JSONObject();
		para.put("ProCode", orderCode);
		
		String result = orderSystemUtils.send2OrderSystem(orderSystemConfig, "GetInvoiceV1", para.toString());
		JSONObject returnObj = JSON.parseObject(result);
		if(returnObj == null) {
			throw new Exception("获取发票信息失败["+orderObj.getOrderCode()+"]！");
		}
		//{"code":"1","msg":"成功","data":{"CneeName":"王越","CneeTel":"18600581569","CneeAddr":"北京市朝阳区"}}
		if(returnObj.get("code").equals("1") && returnObj.get("msg").equals("成功")) {
			JSONObject dataObj = JSON.parseObject(returnObj.get("data").toString());
			ajax.put("invoiceType", dataObj.getString("BuyerType"));
			ajax.put("invoiceTitle", dataObj.getString("BuyerName"));
			ajax.put("taxId", dataObj.getString("TaxId"));
			ajax.put("email", dataObj.getString("Email"));
		}
		else {
			ajax = AjaxResult.error(returnObj.get("msg").toString());
		}
		return ajax;
	}
	
	/**
     * 订单系统 更新发票信息
	 * @throws Exception 
     */
	@ApiOperation("更新发票信息")
	@PutMapping(value = "/updateInvoice")
	public AjaxResult updateInvoice(@RequestBody HmInvoice invoice) throws Exception {
		AjaxResult ajax = AjaxResult.success();
		init();
		//取合同编号
		HmOrderFdp orderObj = hmOrderFdpService.selectHmOrderFdpById(invoice.getOrderId());
		String orderCode = orderObj.getOrderCode();
		JSONObject para = new JSONObject();
		para.put("ProCode", orderCode);
		para.put("BuyerType", invoice.getInvoiceType());
		para.put("BuyerName", invoice.getInvoiceTitle());
		para.put("TaxId", invoice.getTaxId());
		para.put("Email", invoice.getEmail());
		para.put("UpdDate", DateUtils.getTime());
		
		String result = orderSystemUtils.send2OrderSystem(orderSystemConfig, "UpdInvoiceV1", para.toString());
		JSONObject returnObj = JSON.parseObject(result);
		if(returnObj == null) {
			throw new Exception("更新发票信息失败["+orderObj.getOrderCode()+"]！");
		}
		//{"code":"1","msg":"成功","data":{"CneeName":"王越","CneeTel":"18600581569","CneeAddr":"北京市朝阳区"}}
		if(returnObj.get("code").equals("1") && returnObj.get("msg").equals("成功")) {
			return ajax;
		}
		else {
			ajax = AjaxResult.error(returnObj.get("msg").toString());
		}
		return ajax;
	}
	
	/**
     * 订单系统 发送电子发票
	 * @throws Exception 
     */
	@ApiOperation("发送电子发票")
	@PostMapping("/sendInvoice")
	public AjaxResult sendInvoice(@RequestBody HmInvoice invoice) throws Exception {
		AjaxResult ajax = AjaxResult.success();
		init();
		//取合同编号
		HmOrderFdp orderObj = hmOrderFdpService.selectHmOrderFdpById(invoice.getOrderId());
		String orderCode = orderObj.getOrderCode();
		JSONObject para = new JSONObject();
		para.put("ProCode", orderCode);
		para.put("Email", invoice.getEmail());
	
		String result = orderSystemUtils.send2OrderSystem(orderSystemConfig, "SendInvoiceEmailV1", para.toString());
		JSONObject returnObj = JSON.parseObject(result);
		if(returnObj == null) {
			throw new Exception("发送电子发票失败["+orderObj.getOrderCode()+"]！");
		}
		//{"code":"1","msg":"成功","data":{"CneeName":"王越","CneeTel":"18600581569","CneeAddr":"北京市朝阳区"}}
		if(returnObj.get("code").equals("1") && returnObj.get("msg").equals("成功")) {
			return ajax;
		}
		else {
			ajax = AjaxResult.error(returnObj.get("msg").toString());
		}
		return ajax;
	}
	
}
