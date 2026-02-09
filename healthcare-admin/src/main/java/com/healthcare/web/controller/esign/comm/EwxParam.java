package com.healthcare.web.controller.esign.comm;


public class EwxParam {
	
	//获得微信手机号时必要参数
	public String code;
	//获得当前用户的openId的code
	public String code2;
	//获得小程序二维码时, 销售人员ID
	public Long userId;
	
	public String encryptedData;
	public String iv;
	
	public void EsignParam() {
		code = "";
		encryptedData = "";
		iv = "";
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getEncryptedData() {
		return encryptedData;
	}

	public void setEncryptedData(String encryptedData) {
		this.encryptedData = encryptedData;
	}

	public String getIv() {
		return iv;
	}

	public void setIv(String iv) {
		this.iv = iv;
	}

	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getCode2() {
		return code2;
	}
	public void setCode2(String code2) {
		this.code2 = code2;
	}
}
