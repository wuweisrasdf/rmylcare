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
public class HmHospital extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    private String HspId;

    private String HspName;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getHspId() {
		return HspId;
	}

	public void setHspId(String hspId) {
		HspId = hspId;
	}

	public String getHspName() {
		return HspName;
	}

	public void setHspName(String hspName) {
		HspName = hspName;
	}
    
    
}
