package com.healthcare.common.config;
 
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
 
/**
 * <p>
 * 微信小程序支付配置
 * </p>
 *
 * @author songfayuan
 * @date 2024/9/30 15:59
 */
@Data
@Component
@ConfigurationProperties(prefix = "wxpay")
public class WxPayConfig {
    /**
     * 微信小程序的 AppID
     */
    private String appid;
 
    /**
     * 微信小程序的密钥
     */
    private String secret;
 
    /**
     * 商户号
     */
    private String merchantId;
 
    /**
     * 商户API私钥路径
     */
    private String privateKeyPath;
 
    /**
     * 商户证书序列号
     */
    private String merchantSerialNumber;
 
    /**
     * 商户APIV3密钥
     */
    private String apiV3Key;
    
    /**
     * 商户APIV3密钥
     */
    private String apiV2Key;
 
    /**
     * 支付通知地址
     */
    private String payNotifyUrl;
    
    /**
     * 资源访问域名
     */
    private String downloadUrl;
 
    /**
     * 退款通知地址
     */
    private String refundNotifyUrl;
 
    private String publicKeyId;
 
    private String publicKeyPath;

	public String getAppid() {
		return appid;
	}

	public void setAppid(String appid) {
		this.appid = appid;
	}

	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

	public String getMerchantId() {
		return merchantId;
	}

	public void setMerchantId(String merchantId) {
		this.merchantId = merchantId;
	}

	public String getPrivateKeyPath() {
		return privateKeyPath;
	}

	public void setPrivateKeyPath(String privateKeyPath) {
		this.privateKeyPath = privateKeyPath;
	}

	public String getMerchantSerialNumber() {
		return merchantSerialNumber;
	}

	public void setMerchantSerialNumber(String merchantSerialNumber) {
		this.merchantSerialNumber = merchantSerialNumber;
	}

	public String getApiV3Key() {
		return apiV3Key;
	}

	public void setApiV3Key(String apiV3Key) {
		this.apiV3Key = apiV3Key;
	}

	public String getPayNotifyUrl() {
		return payNotifyUrl;
	}

	public void setPayNotifyUrl(String payNotifyUrl) {
		this.payNotifyUrl = payNotifyUrl;
	}

	public String getRefundNotifyUrl() {
		return refundNotifyUrl;
	}

	public void setRefundNotifyUrl(String refundNotifyUrl) {
		this.refundNotifyUrl = refundNotifyUrl;
	}

	public String getPublicKeyId() {
		return publicKeyId;
	}
	public void setPublicKeyId(String publicKeyId) {
		this.publicKeyId = publicKeyId;
	}

	public String getPublicKeyPath() {
		return publicKeyPath;
	}
	public void setPublicKeyPath(String publicKeyPath) {
		this.publicKeyPath = publicKeyPath;
	}

	public String getApiV2Key() {
		return apiV2Key;
	}
	public void setApiV2Key(String apiV2Key) {
		this.apiV2Key = apiV2Key;
	}

	public String getDownloadUrl() {
		return downloadUrl;
	}

	public void setDownloadUrl(String downloadUrl) {
		this.downloadUrl = downloadUrl;
	}
}
 