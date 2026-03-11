package com.healthcare.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.healthcare.common.annotation.Excel;
import com.healthcare.common.config.RuoYiConfig;
import com.healthcare.common.core.domain.BaseEntity;

import net.sf.jsqlparser.expression.DateTimeLiteralExpression.DateTime;

/**
 * 冻干粉订单对象 hm_order_fdp
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
public class HmOrderFdp extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 记录状态	(1-有效 0-无效) */
    @Excel(name = "记录状态	(1-有效 0-无效)")
    private Integer recordStatus;

    /** 协议编号 —— 电子签返回 */
    @Excel(name = "协议编号")
    private String proCode;
    
    /** 合同编号 —— 系统自动编号 */
    @Excel(name = "合同编号")
    public String orderCode;
    

    /** 协议状态（1-已签,2-未签,3-取消,4-终止） */
    @Excel(name = "协议状态", readConverterExp = "1=-已签,2-未签,3-取消,4-终止")
    private Integer proStatus;

    /** 订单状态（11-未交费,1-已缴费,2-接收胎盘,3-已出报告,12-送制备,13-制备接收,14-送辐照,15-辐照接收,16-初检,17-复检,8-成品登记,9-待取货,10-待发货,4-待交付,5-已完成,6-待解除,7-已退费） */
    @Excel(name = "订单状态", readConverterExp = "1=1-未交费,1-已缴费,2-接收胎盘,3-已出报告,12-送制备,13-制备接收,14-送辐照,15-辐照接收,16-初检,17-复检,8-成品登记,9-待取货,10-待发货,4-待交付,5-已完成,6-待解除,7-已退费")
    private Integer orderStatus;
    
    private String statusTxt;
    
    /** 邮箱 */
    @Excel(name = "邮箱")
    private String email;

    /** 用户(甲方)ID */
    @Excel(name = "用户(甲方)ID")
    private Long userId;
    
    /** 销售ID */
    @Excel(name = "销售ID")
    private Long salesId;
    
    /** 销售姓名 */
    @Excel(name = "销售姓名")
    private String salesName;
    
    /** 产妇ID */
    @Excel(name = "产妇ID")
    private Long motherId;
    
    /** 姓名 */
    @Excel(name = "姓名")
    private String motherName;
    
    /** 产妇证件类型 */
    @Excel(name = "产妇证件类型")
    private String motherIdType;
    
    /** 产妇证件号 */
    @Excel(name = "产妇证件号")
    private String motherIdCode;
    
    /** 产妇ID */
    @Excel(name = "产妇手机号")
    private String motherPhonenumber;
    
    /** 同步标志 */
    @Excel(name = "同步标志")
    private Integer syncFlag;
    
    ////////////////////////////////
    /** 地址 */
    @Excel(name = "地址")
    private String address;
    
    /** 甲方信息 */
    @Excel(name = "甲方信息")
    private String userInfo;

    /** 邮箱 */
    @Excel(name = "甲方邮箱")
    private String userEmail;
    
    /** 邮箱 */
    @Excel(name = "甲方姓名")
    private String userName;

    /** 手机号 */
    @Excel(name = "手机号")
    private String phonenumber;

    /** 证件类型(1-身份证、2-护照、3-永久居留身份证、4-台湾来往大陆通行证、5-香港来往大陆通行证、6-澳门来往大陆通行证、10-其它) */
    @Excel(name = "证件类型(1-身份证、2-护照、3-永久居留身份证、4-台湾来往大陆通行证、5-香港来往大陆通行证、6-澳门来往大陆通行证、10-其它)")
    private String idType;

    /** 证件号码 */
    @Excel(name = "证件号码")
    private String idCode;

    /** 预产医院 */
    @Excel(name = "预产医院")
    private String hospitalName;

    /** 预产期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "预产期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date dueDate;
    
    /////////////////////////////
    
    /** 签约日期 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "签约日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date signDate;
    
    /** 支付日期 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "支付日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date payDate;
    
    /** 解约日期 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "解约日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date signReturnDate;
    
    /** 销售价格 */
    @Excel(name = "销售价格")
    private BigDecimal priceOut;
    
    /** 退款金额 */
    @Excel(name = "退款金额")
    private BigDecimal amountRefund;
    
    /** 预产期查询条件1 */
    private Date dueDateBegin;
    
    /** 预产期查询条件2 */
    private Date dueDateEnd;
    
    /** 订单流程 */
    private List<Map<String, String>> orderProgress;
    
    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    
    public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setRecordStatus(Integer recordStatus) 
    {
        this.recordStatus = recordStatus;
    }

    public Integer getRecordStatus() 
    {
        return recordStatus;
    }
    public void setProCode(String proCode) 
    {
        this.proCode = proCode;
    }

    public String getProCode() 
    {
        return proCode;
    }
    public String getOrderCode() {
    	if(this.id == null)
    		return "";
    	String orderCode = "";
    	String version = RuoYiConfig.getVersion();
    	if(version.equals("3.8.7-TEST") || version.equals("3.8.7-LOCAL")) {
    		orderCode = String.format("PFDP%06d", 20000+getId());
    	}
    	else {
    		orderCode = String.format("PFDP%06d", 30000+getId());
    	}
		return orderCode;
	}
	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public void setProStatus(Integer proStatus) 
    {
        this.proStatus = proStatus;
    }

    public Integer getProStatus() 
    {
        return proStatus;
    }
    public void setOrderStatus(Integer orderStatus) 
    {
        this.orderStatus = orderStatus;
    }
    public Integer getOrderStatus() 
    {
        return orderStatus;
    }

    public String getStatusTxt() {
		return statusTxt;
	}
	public void setStatusTxt(String statusTxt) {
		this.statusTxt = statusTxt;
	}

	public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setSignDate(Date signDate) 
    {
        this.signDate = signDate;
    }

    public Date getSignDate() 
    {
        return signDate;
    }
    
    public Date getPayDate() {
		return payDate;
	}
	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	
	public Date getSignReturnDate() {
		return signReturnDate;
	}
	public void setSignReturnDate(Date signReturnDate) {
		this.signReturnDate = signReturnDate;
	}

	public void setPriceOut(BigDecimal priceOut) 
    {
        this.priceOut = priceOut;
    }

    public BigDecimal getPriceOut() 
    {
        return priceOut;
    }
    
    public BigDecimal getAmountRefund() {
		return amountRefund;
	}

	public void setAmountRefund(BigDecimal amountRefund) {
		this.amountRefund = amountRefund;
	}

	public void setMotherId(Long motherId) 
    {
        this.motherId = motherId;
    }

    public Long getMotherId() 
    {
        return motherId;
    }
    
    public String getMotherIdType() {
		return motherIdType;
	}

	public void setMotherIdType(String motherIdType) {
		this.motherIdType = motherIdType;
	}

	public String getMotherIdCode() {
		return motherIdCode;
	}

	public void setMotherIdCode(String motherIdCode) {
		this.motherIdCode = motherIdCode;
	}

	public String getMotherPhonenumber() {
		return motherPhonenumber;
	}

	public void setMotherPhonenumber(String motherPhonenumber) {
		this.motherPhonenumber = motherPhonenumber;
	}

	public Integer getSyncFlag() {
		return syncFlag;
	}
	
	public String getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(String userInfo) {
		this.userInfo = userInfo;
	}

	public void setSyncFlag(Integer syncFlag) {
		this.syncFlag = syncFlag;
	}

	public Long getSalesId() {
		return salesId;
	}

	public void setSalesId(Long salesId) {
		this.salesId = salesId;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMotherName() {
		return motherName;
	}

	public void setMotherName(String motherName) {
		this.motherName = motherName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPhonenumber() {
		return phonenumber;
	}

	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}

	public String getIdType() {
		return idType;
	}

	public void setIdType(String idType) {
		this.idType = idType;
	}

	public String getIdCode() {
		return idCode;
	}

	public void setIdCode(String idCode) {
		this.idCode = idCode;
	}
	
	

	public String getHospitalName() {
		return hospitalName;
	}

	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}

	public Date getDueDate() {
		return dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}
	
	public Date getDueDateBegin() {
		return dueDateBegin;
	}

	public void setDueDateBegin(Date dueDateBegin) {
		this.dueDateBegin = dueDateBegin;
	}

	public Date getDueDateEnd() {
		return dueDateEnd;
	}

	public void setDueDateEnd(Date dueDateEnd) {
		this.dueDateEnd = dueDateEnd;
	}

	public List<Map<String, String>> getOrderProgress() {
		return orderProgress;
	}
	public void setOrderProgress(List<Map<String, String>> progressList) {
		this.orderProgress = progressList;
	}
	
	public String getSalesName() {
		return salesName;
	}
	public void setSalesName(String salesName) {
		this.salesName = salesName;
	}

	@Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("recordStatus", getRecordStatus())
            .append("proCode", getProCode())
            .append("proStatus", getProStatus())
            .append("orderStatus", getOrderStatus())
            .append("userId", getUserId())
            .append("signDate", getSignDate())
            .append("priceOut", getPriceOut())
            .append("motherId", getMotherId())
            .append("syncFlag", getSyncFlag())
            .append("remark", this.getRemark())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .toString();
    }
}
