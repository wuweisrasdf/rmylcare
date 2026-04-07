package com.healthcare.web.controller.system;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.healthcare.common.config.orderSystemConfig;
import com.healthcare.common.core.controller.BaseController;
import com.healthcare.common.core.domain.AjaxResult;
import com.healthcare.common.core.redis.RedisCache;
import com.healthcare.common.utils.OrderSystemUtils;
import com.healthcare.common.utils.uuid.UUID;
import com.healthcare.system.domain.HmOrderFdp;
import com.healthcare.system.service.IHmOrderFdpService;

import io.swagger.annotations.ApiOperation;

/**
 * 与业务系统接口Controller
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@RestController
@RequestMapping("/interface/sf")
public class ShunFengController extends BaseController
{
	
	@Value("${sf.partnerID}")
    private String partnerID;
    @Value("${sf.checkWord}")
    private String checkWord;
    
    @Autowired
    private IHmOrderFdpService hmOrderFdpService;
    
    @Autowired
	private orderSystemConfig orderSystemConfig;
    
    @Autowired
    private RedisCache redisCache;
    
    private static final String BASE_URL = "https://bspgw.sf-express.com/std/service"; // 根据顺丰API文档调整URL
    private static final String TEST_URL = "https://sfapi-sbox.sf-express.com/std/service";
	
    /**
     * 查询 物流进程
     * @throws Exception 
     * @throws NoSuchAlgorithmException 
     * @throws IOException 
     */
	@ApiOperation("协议的物流信息")
	@PostMapping("/orderTracking")
    public AjaxResult orderTracking(Long orderId) throws Exception{
		OrderSystemUtils orderSystemUtils = new OrderSystemUtils();
		orderSystemUtils.redisCache = redisCache;
		HmOrderFdp orderObj = hmOrderFdpService.selectHmOrderFdpById(orderId);
        JSONObject dataObj = orderSystemUtils.getShippingInfo(orderObj.getOrderCode(), orderSystemConfig);
        String carrierCode = dataObj.get("CarrierCode").toString();
        if(!"2".equals(carrierCode)) {
        	return AjaxResult.error("非顺丰快递");
        }
        
        String trackingNo = dataObj.get("TrackingNumber").toString();
        String checkPhoneNo = dataObj.get("CneeTel").toString();
        checkPhoneNo = checkPhoneNo.substring(checkPhoneNo.length()-4);
        AjaxResult ajax = query(trackingNo, checkPhoneNo);
        ajax.put("trackingNo", trackingNo);
        return ajax;
	}
		
	
    /**
     * 查询 物流进程
     * @throws NoSuchAlgorithmException 
     * @throws IOException 
     */
	@ApiOperation("物流进程")
	@PostMapping("/query")
    public AjaxResult query(String trackingNo, String checkPhoneNo) throws NoSuchAlgorithmException, IOException {
		
		Long timestamp = System.currentTimeMillis();
		
		String msgData = "{\"language\": \"0\",\"trackingType\": \"1\",\"trackingNumber\": [\""+trackingNo+"\"],\"methodType\": \"1\",\"checkPhoneNo\": \""+checkPhoneNo+"\"}";
        String msgDigest = createMsgDigest(msgData, timestamp);
        String requestID = UUID.fastUUID().toString();
        URL url = new URL(BASE_URL);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
        connection.setDoOutput(true);
        
        String urlParameters = "partnerID=" + URLEncoder.encode(this.partnerID, StandardCharsets.UTF_8.toString()) +
                "&requestID=" + URLEncoder.encode(requestID, StandardCharsets.UTF_8.toString()) +
                "&serviceCode=" + URLEncoder.encode("EXP_RECE_SEARCH_ROUTES", StandardCharsets.UTF_8.toString()) +
                "&timestamp=" + URLEncoder.encode(timestamp.toString(), StandardCharsets.UTF_8.toString()) +
                "&msgDigest=" + URLEncoder.encode(msgDigest, StandardCharsets.UTF_8.toString()) +
                "&msgData=" + URLEncoder.encode(msgData, StandardCharsets.UTF_8.toString())
                ;

		try (OutputStream os = connection.getOutputStream()) {
			byte[] input = urlParameters.getBytes(StandardCharsets.UTF_8);
			os.write(input, 0, input.length);
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
        String returnStr = content.toString();
        JSONObject resultObj = JSONObject.parseObject(returnStr);
        String apiResultCode = resultObj.get("apiResultCode").toString();
        String apiErrorMsg = resultObj.get("apiErrorMsg").toString();
        
        if ("A1000".equals(apiResultCode) && "".equals(apiErrorMsg)) {
        	String apiResultTxt = resultObj.get("apiResultData").toString();
        	JSONObject apiResultData = JSONObject.parseObject(apiResultTxt);
        	String msgDataTxt = apiResultData.get("msgData").toString();
        	JSONObject msgDataObj = JSONObject.parseObject(msgDataTxt);
        	String routeRespsTxt = msgDataObj.get("routeResps").toString();
        	JSONArray jsonArray = JSONArray.parse(routeRespsTxt);
        	String trackTxt = jsonArray.get(0).toString();
        	JSONObject trackObj = JSONObject.parse(trackTxt);
        	String routesTxt = trackObj.get("routes").toString();
        	
        	AjaxResult ajax = AjaxResult.success();
        	ajax.put("routes", routesTxt);
        	return ajax;
        }
        else {
        	return AjaxResult.error(apiErrorMsg);
        }
    }
	
	//生成数字签名
	private String createMsgDigest(String msgData, Long timestamp) throws UnsupportedEncodingException, NoSuchAlgorithmException {
		//客户校验码    使用顺丰分配的客户校验码
        String checkWord = this.checkWord;
        		
        //将业务报文+时间戳+校验码组合成需加密的字符串(注意顺序)
        String toVerifyText = msgData.toString()+timestamp.toString()+checkWord;

        //进行Md5加密		
        MessageDigest  md5 = MessageDigest.getInstance("MD5");
        md5.update(toVerifyText.getBytes("UTF-8"));
        byte[] md = md5.digest();

        //通过BASE64生成数字签名
        //String msgDigest = new String(new BASE64Encoder().encode(md));
        String msgDigest = Base64.encodeBase64String(md);
        return msgDigest;
	}
	
}
