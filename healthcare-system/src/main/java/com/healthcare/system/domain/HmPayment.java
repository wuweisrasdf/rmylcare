package com.healthcare.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.healthcare.common.annotation.Excel;
import com.healthcare.common.config.RuoYiConfig;
import com.healthcare.common.core.domain.BaseEntity;

/**
 * 付款单对象 hm_payment
 * 
 * @author ruoyi
 * @date 2026-01-29
 */
public class HmPayment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 订单ID */
    @Excel(name = "订单ID")
    private Long orderId;
    
    /** 协议编号 */
    @Excel(name = "协议编号")
    private String orderCode;

    /** 付款金额 */
    @Excel(name = "付款金额")
    private BigDecimal payAmount;

    /** 微信流水号 */
    @Excel(name = "微信流水号")
    private String transactionId;

    /** 付款时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "付款时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date payDate;

    /** 同步标志 */
    @Excel(name = "同步标志")
    private Integer syncFlag;
    
    /** 支付标志 作为查询条件使用*/
    private Integer hasPayed;
    
    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setOrderId(Long orderId) 
    {
        this.orderId = orderId;
    }

    public Long getOrderId() 
    {
        return orderId;
    }
    
    public String getOrderCode() {
    	if(this.orderId == null)
    		return "";
    	String orderCode = "";
    	String version = RuoYiConfig.getVersion();
    	if(version.equals("3.8.7-TEST") || version.equals("3.8.7-LOCAL")) {
    		orderCode = String.format("PFDP%06d", 20000+getOrderId());
    	}
    	else {
    		orderCode = String.format("PFDP%06d", 30000+getOrderId());
    	}
		return orderCode;
	}
	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public void setPayAmount(BigDecimal payAmount) 
    {
        this.payAmount = payAmount;
    }

    public BigDecimal getPayAmount() 
    {
        return payAmount;
    }
    public void setTransactionId(String transactionId) 
    {
        this.transactionId = transactionId;
    }

    public String getTransactionId() 
    {
        return transactionId;
    }
    public void setPayDate(Date payDate) 
    {
        this.payDate = payDate;
    }

    public Date getPayDate() 
    {
        return payDate;
    }
    public void setSyncFlag(Integer syncFlag) 
    {
        this.syncFlag = syncFlag;
    }

    public Integer getSyncFlag() 
    {
        return syncFlag;
    }
    
    public Integer getHasPayed() {
		return hasPayed;
	}
	public void setHasPayed(Integer hasPayed) {
		this.hasPayed = hasPayed;
	}

	@Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("orderId", getOrderId())
            .append("payAmount", getPayAmount())
            .append("transactionId", getTransactionId())
            .append("payDate", getPayDate())
            .append("syncFlag", getSyncFlag())
            .toString();
    }
}
