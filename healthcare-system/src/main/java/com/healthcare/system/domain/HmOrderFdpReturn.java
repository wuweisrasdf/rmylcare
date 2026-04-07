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
 * 冻干粉订单退款对象 hm_order_fdp_return
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
public class HmOrderFdpReturn extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 冻干粉合同ID */
    private Long orderId;

    /** 状态（1-申请,2-已退,3-取消） */
    @Excel(name = "状态", readConverterExp = "1=-申请,2-已退,3-取消")
    private Integer status;

    /** 退款金额 */
    @Excel(name = "退款金额")
    private BigDecimal price;

    /** 解约日期 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "解约日期", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date signDate;
    
    /** 电子签约号 */
    @Excel(name = "电子签约号")
    private String proCode;
    
    /** 同步标志 */
    @Excel(name = "同步标志")
    private Integer syncFlag;

    /** 协议编号 */
    @Excel(name = "协议编号")
	private String orderCode;

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
    public void setStatus(Integer status) 
    {
        this.status = status;
    }

    public Integer getStatus() 
    {
        return status;
    }
    public void setPrice(BigDecimal price) 
    {
        this.price = price;
    }

    public BigDecimal getPrice() 
    {
        return price;
    }
    public void setSignDate(Date signDate) 
    {
        this.signDate = signDate;
    }

    public Date getSignDate() 
    {
        return signDate;
    }
    
    public String getProCode() {
		return proCode;
	}

	public void setProCode(String proCode) {
		this.proCode = proCode;
	}

	public Integer getSyncFlag() {
		return syncFlag;
	}

	public void setSyncFlag(Integer syncFlag) {
		this.syncFlag = syncFlag;
	}

	@Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("orderId", getOrderId())
            .append("status", getStatus())
            .append("price", getPrice())
            .append("proCode", getProCode())
            .append("signDate", getSignDate())
            .append("syncFlag", getSyncFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .toString();
    }
}
