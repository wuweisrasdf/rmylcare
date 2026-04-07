package com.healthcare.system.service;

import java.util.List;
import com.healthcare.system.domain.HmRefund;

/**
 * 退款单Service接口
 * 
 * @author ruoyi
 * @date 2026-03-14
 */
public interface IHmRefundService 
{
    /**
     * 查询退款单
     * 
     * @param id 退款单主键
     * @return 退款单
     */
    public HmRefund selectHmRefundById(Long id);

    /**
     * 查询退款单列表
     * 
     * @param hmRefund 退款单
     * @return 退款单集合
     */
    public List<HmRefund> selectHmRefundList(HmRefund hmRefund);

    /**
     * 新增退款单
     * 
     * @param hmRefund 退款单
     * @return 结果
     */
    public int insertHmRefund(HmRefund hmRefund);

    /**
     * 修改退款单
     * 
     * @param hmRefund 退款单
     * @return 结果
     */
    public int updateHmRefund(HmRefund hmRefund);

    /**
     * 批量删除退款单
     * 
     * @param ids 需要删除的退款单主键集合
     * @return 结果
     */
    public int deleteHmRefundByIds(Long[] ids);

    /**
     * 删除退款单信息
     * 
     * @param id 退款单主键
     * @return 结果
     */
    public int deleteHmRefundById(Long id);
    
    /**
     * 修改所有未完成退款单的deleteFlag标志
     * 
     * @return 
     */
    public int updateDeleteFlag();
}
