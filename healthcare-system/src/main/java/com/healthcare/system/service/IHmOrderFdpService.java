package com.healthcare.system.service;

import java.util.List;
import com.healthcare.system.domain.HmOrderFdp;

/**
 * 冻干粉订单Service接口
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
public interface IHmOrderFdpService 
{
    /**
     * 查询冻干粉订单
     * 
     * @param id 冻干粉订单主键
     * @return 冻干粉订单
     */
    public HmOrderFdp selectHmOrderFdpById(Long id);

    /**
     * 查询冻干粉订单列表
     * 
     * @param hmOrderFdp 冻干粉订单
     * @return 冻干粉订单集合
     */
    public List<HmOrderFdp> selectHmOrderFdpList(HmOrderFdp hmOrderFdp);
    
    /**
     * 查询冻干粉订单列表+产妇信息
     * 
     * @param hmOrderFdp 冻干粉订单
     * @return 冻干粉订单集合
     */
    public List<HmOrderFdp> selectHmOrderFdpMotherList(HmOrderFdp hmOrderFdp);
    
    /**
     * 查询20分钟还未支付的订单
     * 
     * @return 冻干粉订单集合
     */
    public List<HmOrderFdp> selectNotPayList();
    

    /**
     * 新增冻干粉订单
     * 
     * @param hmOrderFdp 冻干粉订单
     * @return 结果
     */
    public int insertHmOrderFdp(HmOrderFdp hmOrderFdp);

    /**
     * 修改冻干粉订单
     * 
     * @param hmOrderFdp 冻干粉订单
     * @return 结果
     */
    public int updateHmOrderFdp(HmOrderFdp hmOrderFdp);

    /**
     * 批量删除冻干粉订单
     * 
     * @param ids 需要删除的冻干粉订单主键集合
     * @return 结果
     */
    public int deleteHmOrderFdpByIds(Long[] ids);

    /**
     * 删除冻干粉订单信息
     * 
     * @param id 冻干粉订单主键
     * @return 结果
     */
    public int deleteHmOrderFdpById(Long id);
}
