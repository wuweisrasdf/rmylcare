package com.healthcare.system.service.impl;

import java.util.List;
import com.healthcare.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.healthcare.system.mapper.HmOrderFdpMapper;
import com.healthcare.system.domain.HmOrderFdp;
import com.healthcare.system.service.IHmOrderFdpService;

/**
 * 冻干粉订单Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@Service
public class HmOrderFdpServiceImpl implements IHmOrderFdpService 
{
    @Autowired
    private HmOrderFdpMapper hmOrderFdpMapper;

    /**
     * 查询冻干粉订单
     * 
     * @param id 冻干粉订单主键
     * @return 冻干粉订单
     */
    @Override
    public HmOrderFdp selectHmOrderFdpById(Long id)
    {
        return hmOrderFdpMapper.selectHmOrderFdpById(id);
    }

    /**
     * 查询冻干粉订单列表
     * 
     * @param hmOrderFdp 冻干粉订单
     * @return 冻干粉订单
     */
    @Override
    public List<HmOrderFdp> selectHmOrderFdpList(HmOrderFdp hmOrderFdp)
    {
    	List<HmOrderFdp> list = hmOrderFdpMapper.selectHmOrderFdpList(hmOrderFdp);
        return list;
    }
    
    /**
     * 查询冻干粉订单列表+产妇信息
     * 
     * @param hmOrderFdp 冻干粉订单
     * @return 冻干粉订单
     */
    @Override
    public List<HmOrderFdp> selectHmOrderFdpMotherList(HmOrderFdp hmOrderFdp)
    {
        return hmOrderFdpMapper.selectHmOrderFdpMotherList(hmOrderFdp);
    }

    /**
     * 新增冻干粉订单
     * 
     * @param hmOrderFdp 冻干粉订单
     * @return 结果
     */
    @Override
    public int insertHmOrderFdp(HmOrderFdp hmOrderFdp)
    {
        hmOrderFdp.setCreateTime(DateUtils.getNowDate());
        return hmOrderFdpMapper.insertHmOrderFdp(hmOrderFdp);
    }

    /**
     * 修改冻干粉订单
     * 
     * @param hmOrderFdp 冻干粉订单
     * @return 结果
     */
    @Override
    public int updateHmOrderFdp(HmOrderFdp hmOrderFdp)
    {
        return hmOrderFdpMapper.updateHmOrderFdp(hmOrderFdp);
    }

    /**
     * 批量删除冻干粉订单
     * 
     * @param ids 需要删除的冻干粉订单主键
     * @return 结果
     */
    @Override
    public int deleteHmOrderFdpByIds(Long[] ids)
    {
        return hmOrderFdpMapper.deleteHmOrderFdpByIds(ids);
    }

    /**
     * 删除冻干粉订单信息
     * 
     * @param id 冻干粉订单主键
     * @return 结果
     */
    @Override
    public int deleteHmOrderFdpById(Long id)
    {
        return hmOrderFdpMapper.deleteHmOrderFdpById(id);
    }
}
