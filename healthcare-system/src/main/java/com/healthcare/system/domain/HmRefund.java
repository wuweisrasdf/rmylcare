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
 * 退款单对象 hm_refund
 * 
 * @author ruoyi
 * @date 2026-03-14
 */
public class HmRefund extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 业务系统ID */
    @Excel(name = "业务系统ID")
    private String syncId;

    /** 合同ID */
    @Excel(name = "合同ID")
    private Long orderId;
    
    /** 协议编号  */
    @Excel(name = "协议编号")
    public String orderCode;

    /** 甲方姓名 */
    @Excel(name = "甲方姓名")
    private String firstName;

    /** 收款金额 */
    @Excel(name = "收款金额")
    private BigDecimal amount;

    /** 退款金额 */
    @Excel(name = "退款金额")
    private BigDecimal refund;

    /** 出纳人员ID */
    private Long user1Id;
    
    /** 出纳姓名 */
    @Excel(name = "出纳姓名")
    private String user1Name;
    
    /** 会计人员ID */
    private Long user2Id;
    
    /** 会计姓名 */
    @Excel(name = "会计姓名")
    private String user2Name;

    /** 出纳审核时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "出纳审核时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date commit1Date;

    /** 会计审核时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "会计审核时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date commit2Date;

    /** 微信退款标志（0-未退款,1-已退款成功,2-退款失败） */
    @Excel(name = "微信退款标志", readConverterExp = "0=-未退款,1-已退款成功,2-退款失败")
    private Integer wxStatus;

    /** 返回信息 */
    @Excel(name = "返回信息")
    private String wxResult;

    /** 同步标志 */
    @Excel(name = "同步标志")
    private Integer syncFlag;
    
    /** 微信流水号 */
    @Excel(name = "微信流水号")
    private String transactionId;
    
    /** 有效标志 */
    @Excel(name = "有效标志")
    private int deleteFlag;
    
    /** 查询条件 审核阶段 1,出纳 2,会计 */
    private int checkStep;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setSyncId(String syncId) 
    {
        this.syncId = syncId;
    }

    public String getSyncId() 
    {
        return syncId;
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

	public String getUser1Name() {
		return user1Name;
	}

	public void setUser1Name(String user1Name) {
		this.user1Name = user1Name;
	}

	public String getUser2Name() {
		return user2Name;
	}

	public void setUser2Name(String user2Name) {
		this.user2Name = user2Name;
	}

	public void setFirstName(String firstName) 
    {
        this.firstName = firstName;
    }

    public String getFirstName() 
    {
        return firstName;
    }
    public void setAmount(BigDecimal amount) 
    {
        this.amount = amount;
    }

    public BigDecimal getAmount() 
    {
        return amount;
    }
    public void setRefund(BigDecimal refund) 
    {
        this.refund = refund;
    }

    public BigDecimal getRefund() 
    {
        return refund;
    }
    public void setUser1Id(Long user1Id) 
    {
        this.user1Id = user1Id;
    }

    public Long getUser1Id() 
    {
        return user1Id;
    }
    public void setUser2Id(Long user2Id) 
    {
        this.user2Id = user2Id;
    }

    public Long getUser2Id() 
    {
        return user2Id;
    }
    public void setCommit1Date(Date commit1Date) 
    {
        this.commit1Date = commit1Date;
    }

    public Date getCommit1Date() 
    {
        return commit1Date;
    }
    public void setCommit2Date(Date commit2Date) 
    {
        this.commit2Date = commit2Date;
    }

    public Date getCommit2Date() 
    {
        return commit2Date;
    }
    public void setWxStatus(Integer wxStatus) 
    {
        this.wxStatus = wxStatus;
    }

    public Integer getWxStatus() 
    {
        return wxStatus;
    }
    public void setWxResult(String wxResult) 
    {
        this.wxResult = wxResult;
    }

    public String getWxResult() 
    {
        return wxResult;
    }
    public void setSyncFlag(Integer syncFlag) 
    {
        this.syncFlag = syncFlag;
    }

    public Integer getSyncFlag() 
    {
        return syncFlag;
    }
    
    public String getTransactionId() {
		return transactionId;
	}
	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public int getCheckStep() {
		return checkStep;
	}
	public void setCheckStep(int checkStep) {
		this.checkStep = checkStep;
	}
	
	public int getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(int deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	@Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("syncId", getSyncId())
            .append("orderId", getOrderId())
            .append("firstName", getFirstName())
            .append("amount", getAmount())
            .append("refund", getRefund())
            .append("user1Id", getUser1Id())
            .append("user2Id", getUser2Id())
            .append("commit1Date", getCommit1Date())
            .append("commit2Date", getCommit2Date())
            .append("wxStatus", getWxStatus())
            .append("wxResult", getWxResult())
            .append("syncFlag", getSyncFlag())
            .append("remark", getRemark())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .toString();
    }
}
