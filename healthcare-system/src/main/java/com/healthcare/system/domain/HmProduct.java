package com.healthcare.system.domain;

import java.math.BigDecimal;

import javax.validation.constraints.Pattern;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.healthcare.common.annotation.Excel;
import com.healthcare.common.core.domain.BaseEntity;

/**
 * 产品信息对象 hm_product
 * 
 * @author ruoyi
 * @date 2026-01-28
 */
public class HmProduct extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 产品名 */
    @Excel(name = "产品名")
    private String productName;

    /** 导航栏小图 */
    private String navbar;

    /** 详情页大图 */
    private String details;

    /** 价格 */
    @Excel(name = "价格")
    private BigDecimal price;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setProductName(String productName) 
    {
        this.productName = productName;
    }

    public String getProductName() 
    {
        return productName;
    }
    public void setNavbar(String navbar) 
    {
        this.navbar = navbar;
    }

    public String getNavbar() 
    {
        return navbar;
    }
    public void setDetails(String details) 
    {
        this.details = details;
    }

    public String getDetails() 
    {
        return details;
    }
    public void setPrice(BigDecimal price) 
    {
        this.price = price;
    }

    public BigDecimal getPrice() 
    {
        return price;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("productName", getProductName())
            .append("navbar", getNavbar())
            .append("details", getDetails())
            .append("price", getPrice())
            .toString();
    }
}
