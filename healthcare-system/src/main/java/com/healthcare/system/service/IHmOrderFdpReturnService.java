package com.healthcare.system.service;

import java.util.List;
import com.healthcare.system.domain.HmOrderFdpReturn;

/**
 * 冻干粉订单退款Service接口
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
public interface IHmOrderFdpReturnService 
{
    /**
     * 查询冻干粉订单退款
     * 
     * @param id 冻干粉订单退款主键
     * @return 冻干粉订单退款
     */
    public HmOrderFdpReturn selectHmOrderFdpReturnById(Long id);

    /**
     * 查询冻干粉订单退款列表
     * 
     * @param hmOrderFdpReturn 冻干粉订单退款
     * @return 冻干粉订单退款集合
     */
    public List<HmOrderFdpReturn> selectHmOrderFdpReturnList(HmOrderFdpReturn hmOrderFdpReturn);

    /**
     * 新增冻干粉订单退款
     * 
     * @param hmOrderFdpReturn 冻干粉订单退款
     * @return 结果
     */
    public int insertHmOrderFdpReturn(HmOrderFdpReturn hmOrderFdpReturn);

    /**
     * 修改冻干粉订单退款
     * 
     * @param hmOrderFdpReturn 冻干粉订单退款
     * @return 结果
     */
    public int updateHmOrderFdpReturn(HmOrderFdpReturn hmOrderFdpReturn);

    /**
     * 批量删除冻干粉订单退款
     * 
     * @param ids 需要删除的冻干粉订单退款主键集合
     * @return 结果
     */
    public int deleteHmOrderFdpReturnByIds(Long[] ids);

    /**
     * 删除冻干粉订单退款信息
     * 
     * @param id 冻干粉订单退款主键
     * @return 结果
     */
    public int deleteHmOrderFdpReturnById(Long id);
}
