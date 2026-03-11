package com.healthcare.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.healthcare.common.annotation.Excel;
import com.healthcare.common.core.domain.BaseEntity;

/**
 * 产妇信息对象 hm_mother
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
public class HmMotherUser extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long motherId;

    /** 甲方与产妇关系(1-本人、2-丈夫) */
    @Excel(name = "甲方与产妇关系(1-本人、2-丈夫)")
    private String motherRelation;

    /** 姓名 */
    @Excel(name = "姓名")
    private String motherName;

    /** 邮箱 */
    @Excel(name = "邮箱")
    private String motherEmail;

    /** 手机号 */
    @Excel(name = "手机号")
    private String motherPhone;

    /** 证件类型(1-身份证、2-护照、3-永久居留身份证、4-台湾来往大陆通行证、5-香港来往大陆通行证、6-澳门来往大陆通行证、10-其它) */
    @Excel(name = "证件类型(1-身份证、2-护照、3-永久居留身份证、4-台湾来往大陆通行证、5-香港来往大陆通行证、6-澳门来往大陆通行证、10-其它)")
    private String motherIdType;

    /** 证件号码 */
    @Excel(name = "证件号码")
    private String motherIdCode;

    /** 预产医院 */
    @Excel(name = "预产医院")
    private String hospitalName;

    /** 预产期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "预产期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date dueDate;

    /** 地址 */
    @Excel(name = "地址")
    private String address;
    
    ////////////////////////以下为用户信息
    /** 甲方ID */
    @Excel(name = "甲方ID")
    private Long userId;
    
    @Excel(name = "用户名")
    private String nickName;
    
    /** 证件类型(1-身份证、2-护照、3-永久居留身份证、4-台湾来往大陆通行证、5-香港来往大陆通行证、6-澳门来往大陆通行证、10-其它) */
    @Excel(name = "证件类型(1-身份证、2-护照、3-永久居留身份证、4-台湾来往大陆通行证、5-香港来往大陆通行证、6-澳门来往大陆通行证、10-其它)")
    private String userIdType;

    /** 证件号码 */
    @Excel(name = "证件号码")
    private String userIdCode;
    
    /** 手机号 */
    @Excel(name = "手机号")
    private String userPhone;
    
    /** 邮箱 */
    @Excel(name = "邮箱")
    private String userEmail;
    
    public Long getMotherId() {
		return motherId;
	}

	public void setMotherId(Long motherId) {
		this.motherId = motherId;
	}

	public String getMotherRelation() {
		return motherRelation;
	}

	public void setMotherRelation(String motherRelation) {
		this.motherRelation = motherRelation;
	}

	public String getMotherName() {
		return motherName;
	}

	public void setMotherName(String motherName) {
		this.motherName = motherName;
	}

	public String getMotherEmail() {
		return motherEmail;
	}

	public void setMotherEmail(String motherEmail) {
		this.motherEmail = motherEmail;
	}

	public String getMotherPhone() {
		return motherPhone;
	}

	public void setMotherPhone(String motherPhone) {
		this.motherPhone = motherPhone;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getUserIdType() {
		return userIdType;
	}

	public void setUserIdType(String userIdType) {
		this.userIdType = userIdType;
	}

	public String getUserIdCode() {
		return userIdCode;
	}

	public void setUserIdCode(String userIdCode) {
		this.userIdCode = userIdCode;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	@Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
        		.append("motherId", getMotherId())
				.append("motherRelation", getMotherRelation())
				.append("motherName", getMotherName())
				.append("motherEmail", getMotherEmail()) 
				.append("motherPhone", getMotherPhone())
				.append("motherIdType", getMotherIdType())
				.append("motherIdCode", getMotherIdCode())
				.append("hospitalName", getHospitalName())
				.append("dueDate", getDueDate())
				.append("address", getAddress())
				.append("userId", getUserId())
				.append("nickName", getNickName())
				.append("userIdType", getUserIdType())
				.append("userIdCode", getUserIdCode())
				.append("userPhone", getUserPhone())
            .toString();
    }
}
