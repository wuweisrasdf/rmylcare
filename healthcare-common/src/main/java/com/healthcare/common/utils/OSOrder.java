package com.healthcare.common.utils;

import java.util.Date;

import com.healthcare.common.core.domain.BaseEntity;

/**
 * 来自订单系统的订单对象
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
public class OSOrder extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private String ProCode;

    private String MotherName;

    private String HspId;

    private String HspName;

    private String PreDate;

    private Date SignDate;

    private String OrderStatus;

	public String getProCode() {
		return ProCode;
	}

	public void setProCode(String proCode) {
		ProCode = proCode;
	}

	public String getMotherName() {
		return MotherName;
	}

	public void setMotherName(String motherName) {
		MotherName = motherName;
	}

	public String getHspId() {
		return HspId;
	}

	public void setHspId(String hspId) {
		HspId = hspId;
	}

	public String getHspName() {
		return HspName;
	}

	public void setHspName(String hspName) {
		HspName = hspName;
	}

	public String getPreDate() {
		return PreDate;
	}

	public void setPreDate(String preDate) {
		PreDate = preDate;
	}

	public Date getSignDate() {
		return SignDate;
	}

	public void setSignDate(Date signDate) {
		SignDate = signDate;
	}

	public String getOrderStatus() {
		return OrderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		OrderStatus = orderStatus;
	}
}
