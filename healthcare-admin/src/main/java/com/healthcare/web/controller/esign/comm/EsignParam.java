package com.healthcare.web.controller.esign.comm;


public class EsignParam {
	
	public String signerName;
	public String signerPhone;
	public String signType;		//1:签约;2:解约
	public String orderId;
	public String returnURL;
	
	public void EsignParam() {
		signerName = "";
		signerPhone = "";
		orderId = "";
		returnURL = "";
	}
	
	public String getSignerName() {
		return signerName;
	}
	public void setSignerName(String signerName) {
		this.signerName = signerName;
	}
	public String getSignerPhone() {
		return signerPhone;
	}
	public void setSignerPhone(String signerPhone) {
		this.signerPhone = signerPhone;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getReturnURL() {
		return returnURL;
	}
	public void setReturnURL(String returnURL) {
		this.returnURL = returnURL;
	}

	public String getSignType() {
		return signType;
	}
	public void setSignType(String signType) {
		this.signType = signType;
	}
	
}
