package com.healthcare.common.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.healthcare.common.config.orderSystemConfig;
import com.healthcare.common.core.redis.RedisCache;
import com.healthcare.common.utils.http.HttpUtils;

public class OrderSystemUtils {
	
    public RedisCache redisCache;
	
	public String gettoken(orderSystemConfig orderSystemConfig) throws Exception
    {
		String accessToken = "";
		if(redisCache.hasKey("ORDERTOKEN"))
			accessToken = redisCache.getCacheObject("ORDERTOKEN");
		//如果取不到就调接口
		if(accessToken == null || accessToken.isEmpty()) {
			JSONObject para = new JSONObject();
			para.put("client_id", orderSystemConfig.getId()); // 手机号
			para.put("client_secret", orderSystemConfig.getSecret());
			
			
			String tokenUrl = orderSystemConfig.getUrl() + "openapi/index/gettoken/";
			String result = HttpUtils.sendPost(tokenUrl, para.toString());
			
			JSONObject returnObj = JSON.parseObject(result);
			if(returnObj == null) {
				throw new Exception("获取token失败！");
			}
			JSONObject dataObj = JSON.parseObject(returnObj.get("data").toString());
			accessToken = dataObj.getString("access_token");
			if(accessToken.isEmpty()) {
				throw new Exception("获取token失败！");
			}
				
			redisCache.setCacheObject("ORDERTOKEN", accessToken, 50, TimeUnit.MINUTES);
		}
		return accessToken;
    }
	
	public String send2OrderSystem(orderSystemConfig orderSystemConfig, String interfaceName, String paraJsonStr) throws Exception {
		String url = orderSystemConfig.getUrl() + "openapi/index/services/?op="+interfaceName;
		String sendPara = "{\"client_id\":\""+orderSystemConfig.getId()+"\","
				+ "\"access_token\":\""+this.gettoken(orderSystemConfig)+"\","
				+ "\"param_json\":["+paraJsonStr+"]}";
		String result = HttpUtils.sendPost(url, sendPara.toString());
		
		return result;
	}
	
	public JSONArray getOrderDetail(orderSystemConfig orderSystemConfig, String orderCode) throws Exception {
		String interfaceName = "GetProtocolInfoV1";
		String para = "{\"ProCode\":\"" + orderCode + "\"}";;
		
		String result = send2OrderSystem(orderSystemConfig, interfaceName, para);
		JSONObject returnObj = JSON.parseObject(result);
		if(returnObj == null) {
			throw new Exception("获取订单列表失败！");
		}
		String dataStr = returnObj.get("data").toString();
		JSONObject dataObj = JSON.parseObject(returnObj.get("data").toString());
		String progressStr = dataObj.getString("OrderProgress");
		JSONArray jsonArray = JSONArray.parse(progressStr);

		
    	return jsonArray;
	}

	public List<OSOrder> getOrderList(orderSystemConfig orderSystemConfig, List<String> orderCodeList) throws Exception {
		String interfaceName = "GetProtocolListV1";
		String para = "";
		for(String orderCode : orderCodeList) {
			if(para.equals("")) {
				para +=  "{\"ProCode\":\"" + orderCode + "\"}";
			}
			else {
				para += "," + "{\"ProCode\":\"" + orderCode + "\"}";
			}
		}
	
		String result = send2OrderSystem(orderSystemConfig, interfaceName, para);
		JSONObject returnObj = JSON.parseObject(result);
		if(returnObj == null) {
			throw new Exception("获取订单列表失败！");
		}
		String dataStr = returnObj.get("data").toString();
    	//String dataStr = "[{\"ProCode\":\"PFDP020023\",\"MotherName\":\"张灵\",\"HspId\":\"H0069\",\"HspName\":\"北京大学第三医院\",\"PreDate\":\"2026-04-01\",\"SignDate\":\"2026-02-05 00:00:00\",\"OrderStatus\":\"2\"}]";
    	//String dataStr = "[{\"ProCode\":\"PFDP020022\",\"MotherName\":\"张灵\",\"HspId\":\"H0069\",\"HspName\":\"北京大学第三医院\",\"PreDate\":\"2026-04-01\",\"SignDate\":\"2026-02-05 00:00:00\",\"OrderStatus\":\"1\"},{\"ProCode\":\"PFDP020023\",\"MotherName\":\"张灵\",\"HspId\":\"H0069\",\"HspName\":\"北京大学第三医院\",\"PreDate\":\"2026-04-01\",\"SignDate\":\"2026-02-05 00:00:00\",\"OrderStatus\":\"2\"}]";
		JSONArray jsonArray = JSONArray.parse(dataStr);
    	
    	List<OSOrder> orderList = new ArrayList<OSOrder>();
    	
    	for (int i = 0; i < jsonArray.size(); i++) {
    		OSOrder orderObj = new OSOrder();
    	    String jsonString = jsonArray.getString(i);
    	    jsonString = jsonString.replace("[", "");
    	    jsonString = jsonString.replace("]", "");
    	    JSONObject jsonObject = JSON.parseObject(jsonString);
    	    orderObj.setProCode(jsonObject.getString("ProCode"));
    	    orderObj.setMotherName(jsonObject.getString("MotherName"));
    	    orderObj.setHspId(jsonObject.getString("HspId"));
    	    orderObj.setHspName(jsonObject.getString("HspName"));
    	    orderObj.setPreDate(jsonObject.getString("PreDate"));
    	    orderObj.setSignDate(jsonObject.getDate("SignDate"));
    	    orderObj.setOrderStatus(getStatusTxt(jsonObject.getString("OrderStatus")));
    	    orderList.add(orderObj);
    	}
		return orderList;
	}
	
    public String getStatusTxt(String id) {
    	Map<String, String> statusMap = new HashMap<String, String>();
    	statusMap.put("1", "已签约");
    	statusMap.put("2", "已付款");
    	statusMap.put("3", "样本接收");
    	statusMap.put("4", "病毒检测");
    	statusMap.put("5", "制备完成");
    	statusMap.put("6", "配送");
    	statusMap.put("7", "已完成");
    	statusMap.put("8", "申请解除");
    	statusMap.put("9", "协议解除");
    	statusMap.put("10", "已退款");
    	return statusMap.get(id);
    }
}
