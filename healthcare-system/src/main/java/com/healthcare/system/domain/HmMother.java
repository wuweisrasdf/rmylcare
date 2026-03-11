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
public class HmMother extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 甲方ID */
    @Excel(name = "甲方ID")
    private Long userId;

    /** 甲方与产妇关系(1-本人、2-丈夫) */
    @Excel(name = "甲方与产妇关系(1-本人、2-丈夫)")
    private String motherRelation;

    /** 姓名 */
    @Excel(name = "姓名")
    private String motherName;

    /** 邮箱 */
    @Excel(name = "邮箱")
    private String email;

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

    /** 地址 */
    @Excel(name = "地址")
    private String address;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setMotherRelation(String motherRelation) 
    {
        this.motherRelation = motherRelation;
    }

    public String getMotherRelation() 
    {
        return motherRelation;
    }
    public void setMotherName(String motherName) 
    {
        this.motherName = motherName;
    }

    public String getMotherName() 
    {
        return motherName;
    }
    public void setEmail(String email) 
    {
        this.email = email;
    }

    public String getEmail() 
    {
        return email;
    }
    public void setPhonenumber(String phonenumber) 
    {
        this.phonenumber = phonenumber;
    }

    public String getPhonenumber() 
    {
        return phonenumber;
    }
    public void setIdType(String idType) 
    {
        this.idType = idType;
    }

    public String getIdType() 
    {
        return idType;
    }
    public void setIdCode(String idCode) 
    {
        this.idCode = idCode;
    }

    public String getIdCode() 
    {
        return idCode;
    }
    public void setHospitalName(String hospitalName) 
    {
        this.hospitalName = hospitalName;
    }

    public String getHospitalName() 
    {
        return hospitalName;
    }
    public void setDueDate(Date dueDate) 
    {
        this.dueDate = dueDate;
    }

    public Date getDueDate() 
    {
        return dueDate;
    }
    public void setAddress(String address) 
    {
        this.address = address;
    }

    public String getAddress() 
    {
        return address;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("userId", getUserId())
            .append("motherRelation", getMotherRelation())
            .append("motherName", getMotherName())
            .append("email", getEmail())
            .append("phonenumber", getPhonenumber())
            .append("idType", getIdType())
            .append("idCode", getIdCode())
            .append("hospitalName", getHospitalName())
            .append("dueDate", getDueDate())
            .append("address", getAddress())
            .toString();
    }
}
