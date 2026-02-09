package com.healthcare.common.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 读取项目相关配置
 * 
 * @author ruoyi
 */
@Component
@ConfigurationProperties(prefix = "esign")
public class eSignConfig
{
	
    private String appId;

    private String appSecret;

    private String host;
    
    private String returnUrl1;
    
    private String returnUrl2;
    
    private String contractFile1;
    
    private String contractFile2;

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public String getAppSecret() {
		return appSecret;
	}

	public void setAppSecret(String appSecret) {
		this.appSecret = appSecret;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getReturnUrl1() {
		return returnUrl1;
	}

	public void setReturnUrl1(String returnUrl1) {
		this.returnUrl1 = returnUrl1;
	}

	public String getReturnUrl2() {
		return returnUrl2;
	}

	public void setReturnUrl2(String returnUrl2) {
		this.returnUrl2 = returnUrl2;
	}

	public String getContractFile1() {
		return contractFile1;
	}

	public void setContractFile1(String contractFile1) {
		this.contractFile1 = contractFile1;
	}

	public String getContractFile2() {
		return contractFile2;
	}

	public void setContractFile2(String contractFile2) {
		this.contractFile2 = contractFile2;
	}
}
