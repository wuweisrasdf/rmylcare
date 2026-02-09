package com.healthcare.web.controller.esign.comm;

import java.math.BigDecimal;

public class WxPayParam {
	
	public Long userId;
	public Long orderId;
	public Integer totalAmount;
	public String goodsName;
	public String LongId;
	
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getOrderId() {
		return orderId;
	}
	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}
	public Integer getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(Integer totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getLongId() {
		return LongId;
	}
	public void setLongId(String longId) {
		LongId = longId;
	}
	
}
