package com.healthcare.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.healthcare.common.annotation.Excel;
import com.healthcare.common.core.domain.BaseEntity;

/**
 * 收货信息
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
public class HmDeliveryAddress extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 协议主键 */
    private Long orderId;

    /** 收件人 */
    private String consignee;

    /** 联系电话 */
    private String contactNumber;

    /** 收货地址 */
    private String deliveryAddress;

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public String getConsignee() {
		return consignee;
	}

	public void setConsignee(String consignee) {
		this.consignee = consignee;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public String getDeliveryAddress() {
		return deliveryAddress;
	}

	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}
    
    
}
