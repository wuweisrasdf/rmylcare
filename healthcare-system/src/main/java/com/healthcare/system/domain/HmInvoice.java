package com.healthcare.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.healthcare.common.annotation.Excel;
import com.healthcare.common.core.domain.BaseEntity;

/**
 * 发票信息对象 
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
public class HmInvoice extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 协议主键 */
    private Long orderId;

    /** 发票类型 1:个人; 2:公司 */
    private int invoiceType;

    /** 发票标题 */
    private String invoiceTitle;

    /** 公司税号 */
    private String taxId;
    
    /** 邮箱地址 */
    private String email;

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public int getInvoiceType() {
		return invoiceType;
	}

	public void setInvoiceType(int invoiceType) {
		this.invoiceType = invoiceType;
	}

	public String getInvoiceTitle() {
		return invoiceTitle;
	}

	public void setInvoiceTitle(String invoiceTitle) {
		this.invoiceTitle = invoiceTitle;
	}

	public String getTaxId() {
		return taxId;
	}

	public void setTaxId(String taxId) {
		this.taxId = taxId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}
