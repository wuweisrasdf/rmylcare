package com.healthcare.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.healthcare.common.annotation.Excel;
import com.healthcare.common.core.domain.BaseEntity;

/**
 * 冻干粉订单对象 hm_order_fdp
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
public class HmRefund4OrderSystem extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private String RefundId;

    private String ProCode;

    private String PartaName;
    
    private BigDecimal AmountReceived;
    
    private BigDecimal AmountRefund;
    
    private String PayType;
    
    private String PayOrderNumber;

	public String getRefundId() {
		return RefundId;
	}

	public void setRefundId(String refundId) {
		RefundId = refundId;
	}

	public String getProCode() {
		return ProCode;
	}

	public void setProCode(String proCode) {
		ProCode = proCode;
	}

	public String getPartaName() {
		return PartaName;
	}

	public void setPartaName(String partaName) {
		PartaName = partaName;
	}

	public BigDecimal getAmountReceived() {
		return AmountReceived;
	}

	public void setAmountReceived(BigDecimal amountReceived) {
		AmountReceived = amountReceived;
	}

	public BigDecimal getAmountRefund() {
		return AmountRefund;
	}

	public void setAmountRefund(BigDecimal amountRefund) {
		AmountRefund = amountRefund;
	}

	public String getPayType() {
		return PayType;
	}

	public void setPayType(String payType) {
		PayType = payType;
	}

	public String getPayOrderNumber() {
		return PayOrderNumber;
	}

	public void setPayOrderNumber(String payOrderNumber) {
		PayOrderNumber = payOrderNumber;
	}

    
}
