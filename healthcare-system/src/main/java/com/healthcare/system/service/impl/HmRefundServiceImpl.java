package com.healthcare.system.service.impl;

import java.util.List;
import com.healthcare.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.healthcare.system.mapper.HmRefundMapper;
import com.healthcare.system.domain.HmRefund;
import com.healthcare.system.service.IHmRefundService;

/**
 * 退款单Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-03-14
 */
@Service
public class HmRefundServiceImpl implements IHmRefundService 
{
    @Autowired
    private HmRefundMapper hmRefundMapper;

    /**
     * 查询退款单
     * 
     * @param id 退款单主键
     * @return 退款单
     */
    @Override
    public HmRefund selectHmRefundById(Long id)
    {
        return hmRefundMapper.selectHmRefundById(id);
    }

    /**
     * 查询退款单列表
     * 
     * @param hmRefund 退款单
     * @return 退款单
     */
    @Override
    public List<HmRefund> selectHmRefundList(HmRefund hmRefund)
    {
        return hmRefundMapper.selectHmRefundList(hmRefund);
    }

    /**
     * 新增退款单
     * 
     * @param hmRefund 退款单
     * @return 结果
     */
    @Override
    public int insertHmRefund(HmRefund hmRefund)
    {
        hmRefund.setCreateTime(DateUtils.getNowDate());
        return hmRefundMapper.insertHmRefund(hmRefund);
    }

    /**
     * 修改退款单
     * 
     * @param hmRefund 退款单
     * @return 结果
     */
    @Override
    public int updateHmRefund(HmRefund hmRefund)
    {
        return hmRefundMapper.updateHmRefund(hmRefund);
    }

    /**
     * 批量删除退款单
     * 
     * @param ids 需要删除的退款单主键
     * @return 结果
     */
    @Override
    public int deleteHmRefundByIds(Long[] ids)
    {
        return hmRefundMapper.deleteHmRefundByIds(ids);
    }

    /**
     * 删除退款单信息
     * 
     * @param id 退款单主键
     * @return 结果
     */
    @Override
    public int deleteHmRefundById(Long id)
    {
        return hmRefundMapper.deleteHmRefundById(id);
    }
    
    /**
     * 修改所有未完成退款单的deleteFlag标志
     * 
     * @return 
     */
    @Override
    public int updateDeleteFlag() {
    	return hmRefundMapper.updateDeleteFlag();
    }
}
