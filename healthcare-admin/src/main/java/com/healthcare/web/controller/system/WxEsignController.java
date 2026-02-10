package com.healthcare.web.controller.system;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType0Font;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.wechat.pay.java.core.Config;
import com.wechat.pay.java.core.RSAAutoCertificateConfig;
import com.wechat.pay.java.core.exception.HttpException;
import com.wechat.pay.java.core.exception.MalformedMessageException;
import com.wechat.pay.java.core.exception.ServiceException;
import com.wechat.pay.java.service.partnerpayments.jsapi.JsapiServiceExtension;
import com.wechat.pay.java.service.partnerpayments.jsapi.model.Amount;
import com.wechat.pay.java.service.partnerpayments.jsapi.model.PrepayWithRequestPaymentResponse;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderRequest;
import com.github.binarywang.wxpay.bean.result.WxPayUnifiedOrderResult;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.healthcare.common.annotation.Excel;
import com.healthcare.common.annotation.Log;
import com.healthcare.common.config.RuoYiConfig;
import com.healthcare.common.config.WxPayConfig;
import com.healthcare.common.config.eSignConfig;
import com.healthcare.common.constant.Constants;
import com.healthcare.common.core.controller.BaseController;
import com.healthcare.common.core.domain.AjaxResult;
import com.healthcare.common.core.domain.entity.SysUser;
import com.healthcare.common.core.domain.model.LoginBody;
import com.healthcare.common.core.domain.model.RegisterBody;
import com.healthcare.common.enums.BusinessType;
import com.healthcare.system.domain.HmMother;
import com.healthcare.system.domain.HmMotherUser;
import com.healthcare.system.domain.HmOrderFdp;
import com.healthcare.system.domain.HmOrderFdpReturn;
import com.healthcare.system.domain.HmPayment;
import com.healthcare.system.service.IHmMotherService;
import com.healthcare.system.service.IHmOrderFdpReturnService;
import com.healthcare.system.service.IHmOrderFdpService;
import com.healthcare.system.service.IHmPaymentService;
import com.healthcare.system.service.ISysUserService;
import com.healthcare.web.controller.esign.comm.EsignFileBean;
import com.healthcare.web.controller.esign.comm.EsignHttpHelper;
import com.healthcare.web.controller.esign.comm.EsignHttpResponse;
import com.healthcare.web.controller.esign.comm.EsignParam;
import com.healthcare.web.controller.esign.comm.EwxParam;
import com.healthcare.web.controller.esign.comm.SafeVerify;
import com.healthcare.web.controller.esign.comm.WxPayParam;
import com.healthcare.web.controller.esign.enums.EsignHeaderConstant;
import com.healthcare.web.controller.esign.enums.EsignRequestType;
import com.healthcare.web.controller.esign.exception.EsignDemoException;
import com.wechat.pay.java.service.partnerpayments.jsapi.model.Payer;
import io.swagger.annotations.ApiOperation;

import com.wechat.pay.java.service.partnerpayments.jsapi.model.PrepayRequest;
import com.healthcare.common.utils.DateUtils;
import com.healthcare.common.utils.MoneyUtils;
import com.healthcare.common.utils.StringUtils;
import com.healthcare.common.utils.WxPayUtils;
import com.healthcare.common.utils.WxUtils;
import com.healthcare.common.utils.file.FileUploadUtils;
import com.healthcare.common.utils.http.HttpUtils;
import com.healthcare.common.utils.poi.ExcelUtil;
import com.healthcare.common.utils.uuid.IdUtils;
import com.healthcare.framework.web.service.SysLoginService;
import com.healthcare.framework.web.service.SysRegisterService;
import com.healthcare.common.core.page.TableDataInfo;
import com.healthcare.common.core.redis.RedisCache;

/**
 * 电子签Controller
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@RestController
@RequestMapping("/system/esign")
public class WxEsignController extends BaseController
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
    private ISysUserService userService;
	
	@Autowired
    private SysLoginService loginService;
	
	@Autowired
    private SysRegisterService registerService;
	
	@Autowired
	private eSignConfig eSignConfig;
	
	@Autowired
	private WxPayConfig wxPayConfig;
	/*
	// 应用ID
    public static final String EsignAppId = "7439098939";
    // 应用密钥
    public static final String EsignAppSecret = "33e38adaa1c2f9cd842c034e80ed58e9";
    // e签宝接口调用域名（模拟环境）
    public static final String EsignHost = "https://smlopenapi.esign.cn";
    // 合同模板
    public static String contractFile = RuoYiConfig.getUploadPath()+"/contract.pdf";
    */
	// 应用ID	
    public static String EsignAppId ;
	
    // 应用密钥
    public static String EsignAppSecret;
	
    // e签宝接口调用域名（模拟环境）
    public static String EsignHost ;
    
 // 电签成功回调
    public static String returnURL;
    // 协议成功回调
    public static String returnURL1;
	// 解约成功回调
	public static String returnURL2;
	
    // 上传的合同模板
    public static String contractFile;
    // 签约合同模板
    public static String contractFile1;
    // 解约合同模板
    public static String contractFile2;

    
    // 经办人
    public static String signerName = "";
    public static String signerPhone = "";
    public static String signType = "";
    // 签署合同ID
    public static String orderId = "";
    // 回调URL
    //public static String returnURL = "https://dhmapi-test.rmylcare.com:81/dev-api/system/esign/returnURL";
    
  
    private void init() {
    	this.EsignAppId = eSignConfig.getAppId();
    	this.EsignAppSecret = eSignConfig.getAppSecret();
    	this.EsignHost = eSignConfig.getHost();
    	
    	this.returnURL1 = eSignConfig.getReturnUrl1();
    	this.returnURL2 = eSignConfig.getReturnUrl2();
    	
    	this.contractFile1 = RuoYiConfig.getUploadPath()+eSignConfig.getContractFile1();
    	this.contractFile2 = RuoYiConfig.getUploadPath()+eSignConfig.getContractFile2();
    }
    
    /**
     * 取电子签url
     * @throws Exception 
     */
	@ApiOperation("取电子签url")
	@PostMapping("/geturl")
    public AjaxResult geturl(@RequestBody EsignParam esignParam) throws Exception
    {
		init();
		AjaxResult ajax = AjaxResult.success();

		this.signerName = esignParam.getSignerName();
		this.signerPhone = esignParam.getSignerPhone();
		this.orderId = esignParam.getOrderId();
		this.signType = esignParam.getSignType();
		
		HmOrderFdp condObj = new HmOrderFdp();
		condObj.setId(Long.parseLong(this.orderId));
		List<HmOrderFdp> list = hmOrderFdpService.selectHmOrderFdpMotherList(condObj);
		if(list.size() < 0)
			return ajax.error("orderId参数错误!");
		HmOrderFdp orderObj = list.get(0);
		Long userId = orderObj.getUserId();
		SysUser userObj = userService.selectUserById(userId);
		
		if(this.signType.equals("1")) {
			this.contractFile = replacePDF(this.contractFile1,userObj, orderObj);
			this.returnURL = this.returnURL1;
		}
		else if(this.signType.equals("2")){
			this.contractFile = replacePDF(this.contractFile2,userObj, orderObj);
			this.returnURL = this.returnURL2;
		}
		else {
			return ajax.error("signType参数错误!");
		}
		
		String inputURL = esignParam.getReturnURL();
		if(inputURL.length() > 0) {
			this.returnURL = inputURL;
		}
		
    	String url = "";
    	//目前不支持PDF模板，只能用上传合同文件
        EsignFileBean bean = new EsignFileBean(contractFile);
        String apiPath = "/v3/files/file-upload-url";
        String jsonBody = "{\n" +
                "    \"contentMd5\": \"" + bean.getFileContentMD5() + "\",\n" +
                "    \"fileName\": \"" + bean.getFileName() + "\",\n" +
                "    \"fileSize\": " + bean.getFileSize() + ",\n" +
                "    \"convertToPDF\": false,\n" +
                "    \"contentType\": \"" + EsignHeaderConstant.CONTENTTYPE_STREAM.VALUE() + "\"\n" +
                "}";

        Map<String, String> headers;
		try {
			headers = EsignHttpHelper.signAndBuildSignAndJsonHeader(EsignAppId, EsignAppSecret, jsonBody, "POST", apiPath, true);
			
			EsignHttpResponse uploadUrlResp = EsignHttpHelper.doCommHttp(EsignHost, apiPath, EsignRequestType.POST, jsonBody, headers, true);
			
            JSONObject resp = JSON.parseObject(uploadUrlResp.getBody());
            if (!"0".equals(resp.getString("code"))) {
                throw new RuntimeException("获取上传地址失败: " + resp.getString("message"));
            }
            JSONObject data = resp.getJSONObject("data");
            String fileId = data.getString("fileId");
            String fileUploadUrl = data.getString("fileUploadUrl");

            EsignHttpResponse uploadResp = EsignHttpHelper.doUploadHttp(
                    fileUploadUrl,
                    EsignRequestType.PUT,
                    bean.getFileBytes(),
                    bean.getFileContentMD5(),
                    EsignHeaderConstant.CONTENTTYPE_STREAM.VALUE(),
                    true
            );
            JSONObject uploadResult = JSON.parseObject(uploadResp.getBody());
            if (uploadResult.getIntValue("errCode") != 0) {
                throw new RuntimeException("文件上传失败");
            }

            // 3. 轮询等待文件处理完成（状态 2 或 5）
            waitForFileReady(fileId);
            
            // 4. 创建签署流程并获取 H5 签署链接
            String signUrl = createPersonalSignFlow(fileId, signerName, signerPhone);

    		ajax.put("signUrl",signUrl);
    		
            return ajax;


			
		} catch (EsignDemoException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
    	return ajax.error("接口错误，未能获得签署地址！");
    	
    }
	
	private String getAction(String json) {
		// 获取完整的请求体内容
		JsonObject jsonObject = JsonParser.parseString(json).getAsJsonObject();
		String action = jsonObject.get("action").getAsString();
		return action;
	}
	
	private Map<String, String> json2obj(String json) {

        // 获取完整的请求体内容
		JsonObject jsonObject = JsonParser.parseString(json).getAsJsonObject();
		String action = jsonObject.get("action").getAsString();
		String customBizNum = jsonObject.get("customBizNum").getAsString();
		String signFlowId = jsonObject.get("signFlowId").getAsString();
		
		System.out.println(""+action);
		System.out.println("customBizNum"+customBizNum);
		System.out.println("signFlowId"+signFlowId);
		
		Map<String,String> resultMap = new HashMap<String,String>();
		resultMap.put("action", action);
		resultMap.put("customBizNum", customBizNum);
		resultMap.put("signFlowId", signFlowId);
		
		return resultMap;
	}
	
    /**
     * 接收协议签署成功消息
     */
	@ApiOperation("接收协议签署成功消息")
    @PostMapping("/returnURL1")
    public AjaxResult returnURL1(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
    	SafeVerify sv  =new SafeVerify();
		if(sv.checkPass(request,  EsignAppSecret))
		{
			System.out.println("--------------开始读取请求--------------");
			 // 获取请求体的读取器
	        BufferedReader reader = request.getReader();
	        StringBuilder sb = new StringBuilder();
	        String line;
	        
	        // 逐行读取请求体内容
	        while ((line = reader.readLine()) != null) {
	            sb.append(line);
	        }
	        
	        // 获取完整的请求体内容
	        String bodyContent = sb.toString();
	        String action = getAction(bodyContent);
	        if(action.equals("SIGN_MISSON_COMPLETE")) {
	        	Map<String, String> returnObj = json2obj(bodyContent);
	        	String signFlowId = returnObj.get("signFlowId");
	        	String customBizNum = returnObj.get("customBizNum");
	        	String idStr = customBizNum.substring(8);
	        	Long orderId = Long.parseLong(idStr);
	        	
	        	//处理签署成功后
	        	System.out.println("--------------签署成功--------------");
	        	//修改合同状态
	        	HmOrderFdp order = new HmOrderFdp();
	        	order.setId(orderId);
	        	order.setProCode(signFlowId);
	        	order.setProStatus(1);
	        	order.setSignDate(DateUtils.getNowDate());

				hmOrderFdpService.updateHmOrderFdp(order);
	        }
	        System.out.println("--------------结束读取请求--------------");
    	}
        return success();
    }
	
	/**
     * 接收解约签署成功消息
     */
	@ApiOperation("接收解约签署成功消息")
    @PostMapping("/returnURL2")
    public AjaxResult returnURL2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
    	SafeVerify sv  =new SafeVerify();
		if(sv.checkPass(request,  EsignAppSecret))
		{
			System.out.println("--------------开始读取请求--------------");
			 // 获取请求体的读取器
	        BufferedReader reader = request.getReader();
	        StringBuilder sb = new StringBuilder();
	        String line;
	        
	        // 逐行读取请求体内容
	        while ((line = reader.readLine()) != null) {
	            sb.append(line);
	        }
	        
	        // 获取完整的请求体内容
	        String bodyContent = sb.toString();
	        String action = getAction(bodyContent);
	        if(action.equals("SIGN_MISSON_COMPLETE")) {
	        	Map<String, String> returnObj = json2obj(bodyContent);
	        	String signFlowId = returnObj.get("signFlowId");
	        	String customBizNum = returnObj.get("customBizNum");
	        	String idStr = customBizNum.substring(8);
	        	Long orderId = Long.parseLong(idStr);
	        	
	        	//处理签署成功后
	        	System.out.println("--------------签署成功--------------");
	        	
	        	//修改解约协议状态 为 2
				HmOrderFdpReturn orderCond = new HmOrderFdpReturn();
				orderCond.setOrderId(orderId);
				List<HmOrderFdpReturn> returnOrderList = hmOrderFdpReturnService.selectHmOrderFdpReturnList(orderCond );
				if(returnOrderList.size() > 0) {
					HmOrderFdpReturn returnOrder = returnOrderList.get(0);
					returnOrder.setProCode(signFlowId);
		        	returnOrder.setStatus(2);
		        	returnOrder.setSignDate(DateUtils.getNowDate());
		        	hmOrderFdpReturnService.updateHmOrderFdpReturn(returnOrder);

		        	//修改解约协议状态 为 4
		        	Long oId = returnOrder.getOrderId();
		        	HmOrderFdp orderObj = new HmOrderFdp();
		        	orderObj.setId(oId);
		        	orderObj.setProStatus(4);
		        	hmOrderFdpService.updateHmOrderFdp(orderObj);
				}
	        	
	        }
	        System.out.println("--------------结束读取请求--------------");
    	}
        return success();
    }
    
    /**
     * 下载签署文件
     * @throws EsignDemoException 
     */
    @ApiOperation("下载签署文件")
    @GetMapping("/downloadSignFile")
    private AjaxResult downloadSignFile(Long orderId) throws EsignDemoException {
    	init();
    	
    	AjaxResult ajax = AjaxResult.success();
    	Gson gson = new Gson();
    	
    	HmOrderFdp orderObj = hmOrderFdpService.selectHmOrderFdpById(orderId);
    	String signFlowId = orderObj.getProCode();
    	Integer status = orderObj.getProStatus();
    	
    	if(signFlowId.length() < 32 ) {
    		return ajax.error("协议未签署或协议编号错误");
    	}
    	
    	EsignHttpResponse fileDownloadUrl = fileDownloadUrl(signFlowId);
        JsonObject fileDownloadUrlJsonObject = gson.fromJson(fileDownloadUrl.getBody(),JsonObject.class);
        JsonObject fileDownloadUrlArray = fileDownloadUrlJsonObject.getAsJsonObject("data");
        JsonArray files = fileDownloadUrlArray.getAsJsonArray("files");
        JsonObject fileObj = files.get(0).getAsJsonObject();
        String downloadUrl = fileObj.get("downloadUrl").getAsString();
        
        ajax.put("downloadUrl1", downloadUrl.toString());
        
        
        HmOrderFdpReturn cond = new HmOrderFdpReturn();
        cond.setOrderId(orderId);
		List<HmOrderFdpReturn> returnList = hmOrderFdpReturnService.selectHmOrderFdpReturnList(cond);
		if(returnList.size() > 0) {
			HmOrderFdpReturn returnObj = returnList.get(0);
			signFlowId = returnObj.getProCode();
			if(!(signFlowId.length() <32)) //已签
			{
				fileDownloadUrl = fileDownloadUrl(signFlowId);
		        fileDownloadUrlJsonObject = gson.fromJson(fileDownloadUrl.getBody(),JsonObject.class);
		        fileDownloadUrlArray = fileDownloadUrlJsonObject.getAsJsonObject("data");
		        files = fileDownloadUrlArray.getAsJsonArray("files");
		        fileObj = files.get(0).getAsJsonObject();
		        downloadUrl = fileObj.get("downloadUrl").getAsString();
		        ajax.put("downloadUrl2", downloadUrl.toString());
			}
		}
        return ajax;
    }
    
    /**
     * 下载已签署文件及附属材料     *
     * @return
     * @throws EsignDemoException
     */
    public static EsignHttpResponse fileDownloadUrl(String signFlowId) throws EsignDemoException {
        String apiaddr = "/v3/sign-flow/"+ signFlowId +"/file-download-url";
        //请求参数body体,json格式。get或者delete请求时jsonString传空json:"{}"或者null
        String jsonParm=null;
        //请求方法
        EsignRequestType requestType= EsignRequestType.GET;
        //生成签名鉴权方式的的header
        Map<String, String> header = EsignHttpHelper.signAndBuildSignAndJsonHeader(EsignAppId,EsignAppSecret,jsonParm,requestType.name(),apiaddr,true);
        //发起接口请求
        return EsignHttpHelper.doCommHttp(EsignHost, apiaddr,requestType , jsonParm, header,true);
    }
	
	
	 /**
     * 创建个人手动签署流程（严格遵循 V3 文档）
     */
    private String createPersonalSignFlow(String fileId, String signerName, String mobile) throws Exception {
        // 1、基于文件发起签署
        String createApiPath = "/v3/sign-flow/create-by-file";

        // 构建 signFields
        JSONObject signField = new JSONObject();
        signField.put("fileId", fileId);
        
        ////////////////////////////////////////////////////////////////////////////////////
        signField.put("customBizNum", "orderId_" + orderId);

        JSONObject position = new JSONObject();
        if(this.signType.equals("1")) {
	        position.put("positionPage", "1"); // 必须是字符串
	        position.put("positionX", 500);
	        position.put("positionY", 150);
        }
        else if(this.signType.equals("2")) {
        	position.put("positionPage", "1"); // 必须是字符串
	        position.put("positionX", 500);
	        position.put("positionY", 120);
        }

        JSONObject normalConfig = new JSONObject();
        normalConfig.put("psnSealStyles", "0,1"); // 手写签名 + 姓名章
        normalConfig.put("signFieldStyle", 1);
        normalConfig.put("signFieldPosition", position);

        signField.put("normalSignFieldConfig", normalConfig);

        JSONArray signFields = new JSONArray();
        signFields.add(signField);

        // 构建 psnSignerInfo（注意嵌套 psnInfo）
        JSONObject psnInfo = new JSONObject();
        psnInfo.put("psnName", signerName);
        // psnInfo.put("psnIDCardNum", ""); // 如需实名认证可传身份证号

        JSONObject psnSignerInfo = new JSONObject();
        psnSignerInfo.put("psnAccount", mobile); // 手机号
        psnSignerInfo.put("psnInfo", psnInfo);

        // 签署方
        JSONObject signer = new JSONObject();
        signer.put("signerType", 0); // 0 = 个人
        signer.put("psnSignerInfo", psnSignerInfo);
        signer.put("signFields", signFields);

        JSONArray signers = new JSONArray();
        signers.add(signer);
        
        ////////////////////////////////////////////////////////
        //第2个位置
        if(this.signType.equals("1")) {
	        JSONObject position2 = new JSONObject();
	        position2.put("positionPage", "8"); // 必须是字符串
	        position2.put("positionX", 450);
	        position2.put("positionY", 250);
	        
	        JSONObject normalConfig2 = new JSONObject();
	        normalConfig2.put("psnSealStyles", "0,1"); // 手写签名 + 姓名章
	        normalConfig2.put("signFieldStyle", 1);
	        normalConfig2.put("signFieldPosition", position2);
	        
	        JSONObject signField2 = new JSONObject();
	        signField2.put("fileId", fileId);
	        signField2.put("normalSignFieldConfig", normalConfig2);
	
	        JSONArray signFields2 = new JSONArray();
	        signFields2.add(signField2);
	
	        // 构建 psnSignerInfo（注意嵌套 psnInfo）
	        JSONObject psnInfo2 = new JSONObject();
	        psnInfo2.put("psnName", signerName);
	        // psnInfo.put("psnIDCardNum", ""); // 如需实名认证可传身份证号
	
	        JSONObject psnSignerInfo2 = new JSONObject();
	        psnSignerInfo2.put("psnAccount", mobile); // 手机号
	        psnSignerInfo2.put("psnInfo", psnInfo2);
	
	        // 签署方
	        JSONObject signer2 = new JSONObject();
	        signer2.put("signerType", 0); // 0 = 个人
	        signer2.put("psnSignerInfo", psnSignerInfo2);
	        signer2.put("signFields", signFields2);
	
	        signers.add(signer2);
        }
        else if(this.signType.equals("2")) {
        	//解约只有一个签名
        }
        ///////////////////////////////////////////////////////

        // docs
        JSONObject doc = new JSONObject();
        doc.put("fileId", fileId);
        doc.put("fileName", "电子合同.pdf");
        JSONArray docs = new JSONArray();
        docs.add(doc);

        // signFlowConfig
        JSONObject signFlowConfig = new JSONObject();
        signFlowConfig.put("signFlowTitle", "个人电子合同签署");
        signFlowConfig.put("autoFinish", true);
        signFlowConfig.put("notifyUrl", returnURL); //签署成功后的回调地址

        // 请求体
        JSONObject requestBody = new JSONObject();
        requestBody.put("docs", docs);
        requestBody.put("signers", signers);
        requestBody.put("signFlowConfig", signFlowConfig);

        String jsonBody = requestBody.toJSONString();
        System.out.println("📝 创建签署流程请求体: " + jsonBody);

        Map<String, String> headers = EsignHttpHelper.signAndBuildSignAndJsonHeader(
        		EsignAppId, EsignAppSecret, jsonBody, "POST", createApiPath, true
        );
        EsignHttpResponse resp = EsignHttpHelper.doCommHttp(EsignHost, createApiPath, EsignRequestType.POST, jsonBody, headers, true);

        JSONObject result = JSON.parseObject(resp.getBody());
        if (!"0".equals(result.getString("code"))) {
            throw new RuntimeException("创建签署流程失败: " + result.getString("message"));
        }

        String signFlowId = result.getJSONObject("data").getString("signFlowId");
        System.out.println("✅ signFlowId: " + signFlowId);

        // 2、获取签署页面链接
        // === 获取签署页面链接 ===
        String signUrlApiPath = "/v3/sign-flow/" + signFlowId + "/sign-url";

        JSONObject operator = new JSONObject();
        operator.put("psnAccount", mobile); // 必须与发起时一致

        JSONObject signUrlBody = new JSONObject();
        signUrlBody.put("urlType", 2);           // 2 = 签署链接
        signUrlBody.put("clientType", "H5");     // 明确指定 H5，适配小程序 WebView
        signUrlBody.put("needLogin", false);
        signUrlBody.put("operator", operator);

        String signUrlJsonBody = signUrlBody.toJSONString();
        System.out.println("🔗 获取签署链接请求体: " + signUrlJsonBody);

        Map<String, String> signUrlHeaders = EsignHttpHelper.signAndBuildSignAndJsonHeader(
        		EsignAppId, EsignAppSecret, signUrlJsonBody, "POST", signUrlApiPath, true
        );
        EsignHttpResponse signUrlResp = EsignHttpHelper.doCommHttp(
        		EsignHost, signUrlApiPath, EsignRequestType.POST, signUrlJsonBody, signUrlHeaders, true
        );

        JSONObject signUrlResult = JSON.parseObject(signUrlResp.getBody());
        if (!"0".equals(signUrlResult.getString("code"))) {
            throw new RuntimeException("获取签署链接失败: " + signUrlResult.getString("message"));
        }

        return signUrlResult.getJSONObject("data").getString("url");
    }

	
    private void waitForFileReady(String fileId) throws Exception {
        int maxRetries = 20;
        int retry = 0;
        while (retry++ < maxRetries) {
            Thread.sleep(1000);

            String apiPath = "/v1/files/" + fileId;
            Map<String, String> headers = EsignHttpHelper.signAndBuildSignAndJsonHeader(
            		EsignAppId, EsignAppSecret, "", "GET", apiPath, true
            );
            EsignHttpResponse resp = EsignHttpHelper.doCommHttp(EsignHost, apiPath, EsignRequestType.GET, "", headers, true);

            JSONObject result = JSON.parseObject(resp.getBody());
            if ("0".equals(result.getString("code"))) {
                String status = result.getJSONObject("data").getString("status");
                if ("2".equals(status) || "5".equals(status)) { // 2=成功, 5=转换成功
                    System.out.println("✅ 文件已就绪，status=" + status);
                    return;
                }
            }
            System.out.println("⏳ 文件处理中... retry=" + retry);
        }
        throw new RuntimeException("文件上传超时，未就绪");
    }
    
    
    /**
     * 取微信手机号
     * @throws Exception 
     */
	@ApiOperation("取微信手机号")
	@PostMapping("/getwxphone")
    public AjaxResult getwxphone(@RequestBody EwxParam wx) throws Exception
    {
		AjaxResult ajax = AjaxResult.success();
		WxUtils wxUtils = new WxUtils();

		String accessToken = getWxToken(wxUtils.getAppId(),wxUtils.getAppSecret());
		
		String returnString = wxUtils.getSessionKeyFromWeChat(wx.code, accessToken);
		//String returnString = "{\"errcode\":0,\"errmsg\":\"ok\",\"phone_info\":{\"phoneNumber\":\"15699736798\",\"purePhoneNumber\":\"15699736798\",\"countryCode\":\"86\",\"watermark\":{\"timestamp\":1769751529,\"appid\":\"wxe83a3700d3b60132\"}}}";
		
		JsonObject jsonObject = JsonParser.parseString(returnString).getAsJsonObject();
		String errcode = jsonObject.get("errcode").toString();
		
		if(!errcode.equals("0")) {
			return ajax.error("取微信手机号失败!wx_error="+errcode);
		}
		
		JsonObject phoneInfo = jsonObject.get("phone_info").getAsJsonObject();
		String phonenumber = phoneInfo.get("phoneNumber").getAsString();

		ajax.put("phone", phonenumber);
		
		//取openId
		String wxopenId = wxUtils.getWxOpenId(wx.getCode2());
		wxopenId = wxopenId.replace("\"", ""); //返回的openId多了 ""
		
		//判断手机号是否存在
		SysUser user = new SysUser();
		int count = userService.findPhonenumber(phonenumber);
		
		if(count == 0){
			RegisterBody registerObj = new RegisterBody();
			registerObj.setPhonenumber(phonenumber);
			registerObj.setPassword(phonenumber);
			registerObj.setUsername(phonenumber);
			registerObj.setWxOpenId(wxopenId);
			String msg = registerService.register(registerObj);
			if(!msg.isEmpty()) {
				ajax.error("新用户注册失败!");
				return ajax;
			}
		}
		// 生成令牌
        String token = loginService.login(phonenumber, phonenumber, null,null);
        ajax.put(Constants.TOKEN, token);
        return ajax;
    }
	
	/**
     * 获取当前销售的二维码
     * @throws Exception 
     */
	@ApiOperation("销售二维码")
	@PostMapping("/getwxqrcode")
    public AjaxResult getWxQRcode(@RequestBody EwxParam wx) throws Exception
    {
		AjaxResult ajax = AjaxResult.success();
		WxUtils wxUtils = new WxUtils();

		String accessToken = getWxToken(wxUtils.getAppId(),wxUtils.getAppSecret());
		
		String fn = wxUtils.getQRcode(wx.getUserId(), accessToken, wxPayConfig);
		ajax.put("qrcode", fn);

        return ajax;
    }
	
	/**
     * 获取微信token
     * @throws Exception 
     */
	@ApiOperation("获取微信token")
	@PostMapping("/getwxtoken")
    public AjaxResult getWxToken() throws Exception
    {
		AjaxResult ajax = AjaxResult.success();
		String accessToken = redisCache.getCacheObject("WXTOKEN");
		ajax.put("accessToken", accessToken);

        return ajax;
    }
	
	/**
     * 设置微信token
     * @throws Exception 
     */
	@ApiOperation("设置微信token")
	@PostMapping("/setwxtoken")
    public AjaxResult setWxToken(@RequestBody String accessToken) throws Exception
    {
		AjaxResult ajax = AjaxResult.success();
		redisCache.setCacheObject("WXTOKEN", accessToken, 60, TimeUnit.MINUTES);
        return ajax;
    }
	
	/**
     * 获取订单系统token
     * @throws Exception 
     */
	@ApiOperation("获取订单系统token")
	@PostMapping("/getordersystemtoken")
    public AjaxResult getOrderSystemToken() throws Exception
    {
		AjaxResult ajax = AjaxResult.success();
		String accessToken = redisCache.getCacheObject("ORDERTOKEN");
		ajax.put("accessToken", accessToken);

        return ajax;
    }
	
	/**
     * 设置订单系统token
     * @throws Exception 
     */
	@ApiOperation("设置订单系统token")
	@PostMapping("/setordersystemtoken")
    public AjaxResult setOrderSystemToken(@RequestBody String accessToken) throws Exception
    {
		AjaxResult ajax = AjaxResult.success();
		redisCache.setCacheObject("ORDERTOKEN", accessToken, 50, TimeUnit.MINUTES);
        return ajax;
    }
	
	/**
     * 获取微信支付的参数
     * @throws Exception 
     */
	@ApiOperation("微信支付的参数")
	@PostMapping("/getwxpay")
	public AjaxResult getWxPay(@RequestBody WxPayParam wx) throws Exception
	{
		AjaxResult ajax = AjaxResult.success();
		
		WxUtils wxUtils = new WxUtils();
		
		HmOrderFdp order = hmOrderFdpService.selectHmOrderFdpById(wx.getOrderId());
		
		BigDecimal amount = new BigDecimal(order.getPriceOut().toString());
		String prepayId = wxUtils.createWeChatOrderForMiniProgram(amount, order.getOrderCode(), wx.getLongId(), wxPayConfig);
		Map<String, String> result = wxUtils.createWeChatPayParamsForMiniProgram(prepayId, wxPayConfig);
		ajax.put("para", result);
		return ajax;
	}
	
	private String getWxToken(String appId, String AppSecret) throws Exception {
		
		String accessToken = "";
		if(redisCache.hasKey("WXTOKEN"))
			accessToken = redisCache.getCacheObject("WXTOKEN");
		//如果取不到就调接口
		if(accessToken == null || accessToken.isEmpty()) {
			
			String tokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+appId+"&secret="+AppSecret;
			String returnString = HttpUtils.sendGet(tokenUrl);
			JSONObject returnObj = JSON.parseObject(returnString);
			if(returnObj == null) {
				throw new Exception("获取微信token失败！");
			}
			
			accessToken = returnObj.getString("access_token");
			if(accessToken.isEmpty()) {
				throw new Exception("获取微信token失败！");
			}
				
			redisCache.setCacheObject("WXTOKEN", accessToken, 60, TimeUnit.MINUTES);
		}
		return accessToken;
		
	}
	
	/**
     * 支付成功回调
     * @throws Exception 
     */
	@ApiOperation("支付成功回调")
	@PostMapping("/paySuccess")
	public String paySuccess(HttpServletRequest request) throws Exception{
		try {
	         Map<String, String> notifyData = WxPayUtils.readXml(request.getInputStream());
	
	         if (!WxPayUtils.isSignatureValid(notifyData, wxPayConfig.getApiV2Key())) {
	             return "<xml><return_code><![CDATA[FAIL]]></return_code></xml>";
	         }
	
			 if (!"SUCCESS".equals(notifyData.get("result_code"))) {
				 return "<xml><return_code><![CDATA[FAIL]]></return_code></xml>";
			 }
			
			 String orderNo = notifyData.get("out_trade_no");
			 String transactionId = notifyData.get("transaction_id");
			 String total_fee = notifyData.get("total_fee");

			 orderNo = orderNo.replace("PFDP","");
	         Long orderId = Long.parseLong(orderNo) - 20000L;
	         
	         BigDecimal payAmount = new BigDecimal(total_fee); //total_fee是分
	         BigDecimal divisor = new BigDecimal("100");
	         payAmount = payAmount.divide(divisor, 2, RoundingMode.HALF_UP);
	         
	         //生成付款单
	         HmPayment payment = new HmPayment();
	         payment.setOrderId(orderId);
	         payment.setPayAmount(payAmount);
	         payment.setTransactionId(transactionId);
	         payment.setPayDate(DateUtils.getNowDate());
	         hmPaymentService.insertHmPayment(payment);
	         
	         //修改订单为已支付
	         HmOrderFdp orderObj = new HmOrderFdp();
	         orderObj.setId(orderId);
	         orderObj.setOrderStatus(1);
	         orderObj.setPayDate(DateUtils.getNowDate());
	         hmOrderFdpService.updateHmOrderFdp(orderObj);
		
	         return "<xml><return_code><![CDATA[SUCCESS]]></return_code></xml>";
		 } catch (Exception e) {
		     //log.error("WeChat payment notification processing failed", e);
			 return "<xml><return_code><![CDATA[FAIL]]></return_code></xml>";
		 }
 }
    
    
    /*
     * 替换PDF中甲方姓名，电话
     */
    private String replacePDF(String srcFile, SysUser userObj, HmOrderFdp orderObj) throws IOException {

    	String uuid = IdUtils.simpleUUID();
    	String destFileName = RuoYiConfig.getUploadPath() + "/" + uuid + ".pdf";
    	
		PDDocument document = PDDocument.load(new File(srcFile));
		//打开字体文件
		String ttf = RuoYiConfig.getUploadPath() + "/simhei.ttf";
    	PDType0Font font = PDType0Font.load(document, new File(ttf));
    	if(this.signType.equals("1")) {
			PDPage page = document.getPage(2); // 获取第3页
			PDPageContentStream contentStream = new PDPageContentStream(document, page, PDPageContentStream.AppendMode.APPEND, true, true); // 使用APPEND模式以避免清除现有内容
			changeTxt(contentStream , font, 180, 675, userObj.getNickName());
			changeTxt(contentStream , font, 200, 645, userObj.getIdCode());
			changeTxt(contentStream , font, 120, 620, orderObj.getAddress());
			changeTxt(contentStream , font, 150, 595, userObj.getPhonenumber());
			changeTxt(contentStream , font, 350, 595, userObj.getEmail());
			changeTxt(contentStream , font, 150, 565, DateUtils.dateTime(orderObj.getDueDate()));
			changeTxt(contentStream , font, 350, 565, orderObj.getHospitalName());
			contentStream.close(); // 关闭内容流以保存更改
			
			page = document.getPage(8); // 获取第9页
			contentStream = new PDPageContentStream(document, page, PDPageContentStream.AppendMode.APPEND, true, true); // 使用APPEND模式以避免清除现有内容
			changeTxt(contentStream , font, 130, 420, "0");
			changeTxt(contentStream , font, 240, 335, orderObj.getPriceOut().toString());
			changeTxt(contentStream , font, 380, 335, MoneyUtils.toChinese(orderObj.getPriceOut().toString()));
			contentStream.close(); // 关闭内容流以保存更改
    	}
    	else if(this.signType.equals("2")) {
    		PDPage page = document.getPage(0); // 获取第1页
			PDPageContentStream contentStream = new PDPageContentStream(document, page, PDPageContentStream.AppendMode.APPEND, true, true); // 使用APPEND模式以避免清除现有内容
			changeTxt(contentStream , font, 150, 650, userObj.getNickName());
			changeTxt(contentStream , font, 350, 650, userObj.getIdCode());
			changeTxt(contentStream , font, 350, 620, orderObj.getOrderCode());
			contentStream.close(); // 关闭内容流以保存更改
    	}
		document.save(destFileName); // 保存填充后的文件
		return destFileName;
    }
    
    private void changeTxt(PDPageContentStream contentStream, PDType0Font font, int x, int y, String txt) throws IOException {
    	contentStream.beginText();
		contentStream.setFont(font, 12); // 设置字体和大小
		contentStream.newLineAtOffset(x, y); // 设置文本位置（与模板中的位置对应）
		contentStream.showText(txt); // 替换模板中的文本占位符
		contentStream.endText();
		
    }
}
