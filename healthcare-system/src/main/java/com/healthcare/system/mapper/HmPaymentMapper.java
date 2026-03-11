package com.healthcare.system.mapper;

import java.util.List;
import com.healthcare.system.domain.HmPayment;

/**
 * 付款单Mapper接口
 * 
 * @author ruoyi
 * @date 2026-01-29
 */
public interface HmPaymentMapper 
{
    /**
     * 查询付款单
     * 
     * @param id 付款单主键
     * @return 付款单
     */
    public HmPayment selectHmPaymentById(Long id);

    /**
     * 查询付款单列表
     * 
     * @param hmPayment 付款单
     * @return 付款单集合
     */
    public List<HmPayment> selectHmPaymentList(HmPayment hmPayment);

    /**
     * 新增付款单
     * 
     * @param hmPayment 付款单
     * @return 结果
     */
    public int insertHmPayment(HmPayment hmPayment);

    /**
     * 修改付款单
     * 
     * @param hmPayment 付款单
     * @return 结果
     */
    public int updateHmPayment(HmPayment hmPayment);

    /**
     * 删除付款单
     * 
     * @param id 付款单主键
     * @return 结果
     */
    public int deleteHmPaymentById(Long id);

    /**
     * 批量删除付款单
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteHmPaymentByIds(Long[] ids);
}
