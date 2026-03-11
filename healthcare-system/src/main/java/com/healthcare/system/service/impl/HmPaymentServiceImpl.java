package com.healthcare.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.healthcare.system.mapper.HmPaymentMapper;
import com.healthcare.system.domain.HmPayment;
import com.healthcare.system.service.IHmPaymentService;

/**
 * 付款单Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-01-29
 */
@Service
public class HmPaymentServiceImpl implements IHmPaymentService 
{
    @Autowired
    private HmPaymentMapper hmPaymentMapper;

    /**
     * 查询付款单
     * 
     * @param id 付款单主键
     * @return 付款单
     */
    @Override
    public HmPayment selectHmPaymentById(Long id)
    {
        return hmPaymentMapper.selectHmPaymentById(id);
    }

    /**
     * 查询付款单列表
     * 
     * @param hmPayment 付款单
     * @return 付款单
     */
    @Override
    public List<HmPayment> selectHmPaymentList(HmPayment hmPayment)
    {
        return hmPaymentMapper.selectHmPaymentList(hmPayment);
    }

    /**
     * 新增付款单
     * 
     * @param hmPayment 付款单
     * @return 结果
     */
    @Override
    public int insertHmPayment(HmPayment hmPayment)
    {
        return hmPaymentMapper.insertHmPayment(hmPayment);
    }

    /**
     * 修改付款单
     * 
     * @param hmPayment 付款单
     * @return 结果
     */
    @Override
    public int updateHmPayment(HmPayment hmPayment)
    {
        return hmPaymentMapper.updateHmPayment(hmPayment);
    }

    /**
     * 批量删除付款单
     * 
     * @param ids 需要删除的付款单主键
     * @return 结果
     */
    @Override
    public int deleteHmPaymentByIds(Long[] ids)
    {
        return hmPaymentMapper.deleteHmPaymentByIds(ids);
    }

    /**
     * 删除付款单信息
     * 
     * @param id 付款单主键
     * @return 结果
     */
    @Override
    public int deleteHmPaymentById(Long id)
    {
        return hmPaymentMapper.deleteHmPaymentById(id);
    }
}
