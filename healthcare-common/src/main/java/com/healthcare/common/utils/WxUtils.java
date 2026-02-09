package com.healthcare.common.utils;

import java.io.InputStream;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.PrivateKey;
import java.security.Signature;
import java.time.Instant;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.concurrent.TimeUnit;

import org.apache.http.HttpHeaders;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderRequest;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.healthcare.common.config.RuoYiConfig;
import com.healthcare.common.config.WxPayConfig;
import com.healthcare.common.config.eSignConfig;
import com.healthcare.common.core.redis.RedisCache;
import com.healthcare.common.utils.http.HttpUtils;
import com.healthcare.common.utils.uuid.UUID;

import com.wechat.pay.java.service.payments.jsapi.model.PrepayRequest;
import com.wechat.pay.java.core.util.PemUtil;
import com.wechat.pay.java.service.payments.jsapi.model.Amount;
import com.wechat.pay.java.service.payments.jsapi.model.Payer;
import com.wechat.pay.java.service.payments.jsapi.model.PrepayWithRequestPaymentResponse;

/**
 * 微信工具类
 * 
 * @author ruoyi
 */
public class WxUtils
{
	private final String appId = "wxe83a3700d3b60132";
	
	private final String AppSecret = "597ce52c64d3293fac4d6360f5772619";
	
	private final String mchid = "1732682102"; //商户号 在线支付用
	
	@Autowired
	private WxPayConfig wxPayConfig;
	
	/*
	 * 调微信接口取手机号
	 */
	public String getSessionKeyFromWeChat(String code, String accessToken) throws Exception {
		
		//获取phone
        String url = "https://api.weixin.qq.com/wxa/business/getuserphonenumber"
                + "?access_token=" + accessToken;
        
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", code);
        String requestBody = jsonObject.toJSONString();
        
        //发起请求
        String respPhone = sendWxApi(url, requestBody);
        
        if(respPhone == null) {
			throw new Exception("获取微信手机号码失败！");
		}
        return respPhone;
    }
	
	public String getQRcode(Long userId, String accessToken, WxPayConfig wxPayConfig) throws Exception {
		String fn = "";
		
		String url = "https://api.weixin.qq.com/wxa/getwxacodeunlimit"
                + "?access_token=" + accessToken;
        
        JSONObject jsonObject = new JSONObject();
        
        jsonObject.put("env_version", "trial");	//生成用于体验版的二维码,正式发布时去掉
        jsonObject.put("page", "pages/index/scan");
        jsonObject.put("check_path", false);
        jsonObject.put("scene", "salesId="+userId.toString());
        String requestBody = jsonObject.toJSONString();
        
        //发起请求
        byte[] res = getWechatQrcodeByHttpURL(url, requestBody);
        
        if(res == null) {
			throw new Exception("获取微信二维码失败！");
		}
        fn = saveQrCodeToLocal(res, userId);		
        fn = wxPayConfig.getDownloadUrl()+"/uploadPath/download/"+fn;
		return fn;
	}
	
	public String getWxOpenId(String code) {
		String url = "https://api.weixin.qq.com/sns/jscode2session?appid=" + appId + "&secret=" + AppSecret +
                "&js_code=" + code + "&grant_type=authorization_code";
        String response = HttpUtils.sendGet(url);
        JsonObject jsonObject = JsonParser.parseString(response).getAsJsonObject();
		String openid = jsonObject.get("openid").toString();
		
        //{"session_key":"WmmZmwLLTge7bn3lFNX5rg==","openid":"o0IB119Y7y6Ala8KT-30LhGpHnDU"}
        return openid;
	}
	
	private String sendWxApi(String requestUrl, String requestBody) throws IOException {
		URL url = new URL(requestUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json; charset=utf-8");
        connection.setDoOutput(true);
        // 构建请求体
        //String requestBody = "{\"code\":\"" + code + "\"}";
        
        // 发送请求体
        try (OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream(), StandardCharsets.UTF_8)) {
            writer.write(requestBody);
            writer.flush();
        }
        // 读取响应
        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String inputLine;
        StringBuilder content = new StringBuilder();
        while ((inputLine = in.readLine()) != null) {
            content.append(inputLine);
        }
        in.close();
        connection.disconnect();
        // 返回响应内容
        return content.toString();
	}
	
	public byte[] getWechatQrcodeByHttpURL(String url, String body) {
	    HttpURLConnection httpURLConnection = null;
	    try {
	        httpURLConnection = (HttpURLConnection) new URL(url).openConnection();
	        httpURLConnection.setRequestMethod("POST");
	        // 发送POST请求必须设置如下两行
	        httpURLConnection.setDoOutput(true);
	        httpURLConnection.setDoInput(true);
	        // 获取URLConnection对象对应的输出流
	        PrintWriter printWriter = new PrintWriter(httpURLConnection.getOutputStream());
	        // 发送请求参数
	        printWriter.write(body);
	        // flush输出流的缓冲
	        printWriter.flush();
	        //开始获取数据
	        try (InputStream inputStream = httpURLConnection.getInputStream();
	             ByteArrayOutputStream out = new ByteArrayOutputStream()) {
	            byte[] buffer = new byte[1024];
	            int len = -1;
	            while ((len = inputStream.read(buffer)) != -1) {
	                out.write(buffer, 0, len);
	            }
	            return out.toByteArray();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        if (httpURLConnection != null) {
	            httpURLConnection.disconnect();
	        }
	    }
	    return null;
	}
	
	private String saveQrCodeToLocal(byte[] bytes, Long userId) {
		
		String fn = userId.toString()+".png";
		String savePath =RuoYiConfig.getDownloadPath()+fn; 
	    try {
	    	try (FileOutputStream fos = new FileOutputStream(savePath)) {
	            fos.write(bytes);
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    return fn;
	}
	
	public String createWeChatOrderForMiniProgram(BigDecimal amount, String orderNo, String openid, WxPayConfig wxPayConfig) throws Exception {
		
		// 1. 构建统一下单参数
	    SortedMap<String, String> params = new TreeMap<>();
	    params.put("appid", wxPayConfig.getAppid());              // 小程序的 AppID
	    params.put("mch_id", wxPayConfig.getMerchantId());            // 商户号
//	    params.put("sub_mch_id", wxPayConfig.getSubMchId());     // 子商户号（如无，可移除）
	    params.put("nonce_str", WxPayUtils.generateNonceStr());
	    params.put("body", "冻干粉");
	    params.put("out_trade_no", orderNo);
	    params.put("total_fee", amount.multiply(BigDecimal.valueOf(100)).intValue() + ""); // 单位：分
	    params.put("spbill_create_ip", "127.0.0.1"); // 小程序场景可写固定IP或服务器出口IP
	    params.put("notify_url", wxPayConfig.getPayNotifyUrl());
	    params.put("trade_type", "JSAPI");                       // 关键：改为 JSAPI
	    params.put("openid", openid);                            // 必填！小程序用户的 openid

	    //log.info("小程序微信下单参数: {}", params);

	    // 2. 生成签名
	    String sign = WxPayUtils.createSign(params, wxPayConfig.getApiV2Key());
	    params.put("sign", sign);

	    // 3. 发送请求
	    String xmlRequest = WxPayUtils.mapToXml(params);
	    String responseXml = HttpUtils.postXml("https://api.mch.weixin.qq.com/pay/unifiedorder", xmlRequest);

	    // 4. 解析结果
	    Map<String, String> result = WxPayUtils.xmlToMap(responseXml);
	    //log.info("微信下单结果: {}", result);

	    if (!"SUCCESS".equals(result.get("return_code")) || !"SUCCESS".equals(result.get("result_code"))) {
	        String errMsg = result.get("err_code_des") != null ? result.get("err_code_des") : result.get("return_msg");
	        throw new RuntimeException("微信小程序下单失败: " + errMsg);
	    }

	    // 5. 返回 prepay_id（前端需要它来调起支付）
	    return result.get("prepay_id");
	}
	public Map<String, String> createWeChatPayParamsForMiniProgram(String prepayId, WxPayConfig wxPayConfig) {
		SortedMap<String, String> payParams = new TreeMap<String, String>();
	    payParams.put("appId", wxPayConfig.getAppid());
	    payParams.put("timeStamp", String.valueOf(System.currentTimeMillis() / 1000));
	    payParams.put("nonceStr", WxPayUtils.generateNonceStr());
	    payParams.put("package", "prepay_id=" + prepayId);
	    payParams.put("signType", "MD5");

	    // 再次签名（使用商户 key）
	    String paySign = WxPayUtils.createSign(payParams, wxPayConfig.getApiV2Key());
	    payParams.put("paySign", paySign);

	    return payParams; // 返回给小程序前端
	}
	
	public String getAppId() {
		return appId;
	}

	public String getAppSecret() {
		return AppSecret;
	}
}
