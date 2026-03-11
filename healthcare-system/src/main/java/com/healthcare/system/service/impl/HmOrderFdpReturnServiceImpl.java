package com.healthcare.system.service.impl;

import java.util.List;
import com.healthcare.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.healthcare.system.mapper.HmOrderFdpReturnMapper;
import com.healthcare.system.domain.HmOrderFdpReturn;
import com.healthcare.system.service.IHmOrderFdpReturnService;

/**
 * 冻干粉订单退款Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@Service
public class HmOrderFdpReturnServiceImpl implements IHmOrderFdpReturnService 
{
    @Autowired
    private HmOrderFdpReturnMapper hmOrderFdpReturnMapper;

    /**
     * 查询冻干粉订单退款
     * 
     * @param id 冻干粉订单退款主键
     * @return 冻干粉订单退款
     */
    @Override
    public HmOrderFdpReturn selectHmOrderFdpReturnById(Long id)
    {
        return hmOrderFdpReturnMapper.selectHmOrderFdpReturnById(id);
    }

    /**
     * 查询冻干粉订单退款列表
     * 
     * @param hmOrderFdpReturn 冻干粉订单退款
     * @return 冻干粉订单退款
     */
    @Override
    public List<HmOrderFdpReturn> selectHmOrderFdpReturnList(HmOrderFdpReturn hmOrderFdpReturn)
    {
        return hmOrderFdpReturnMapper.selectHmOrderFdpReturnList(hmOrderFdpReturn);
    }

    /**
     * 新增冻干粉订单退款
     * 
     * @param hmOrderFdpReturn 冻干粉订单退款
     * @return 结果
     */
    @Override
    public int insertHmOrderFdpReturn(HmOrderFdpReturn hmOrderFdpReturn)
    {
        hmOrderFdpReturn.setCreateTime(DateUtils.getNowDate());
        return hmOrderFdpReturnMapper.insertHmOrderFdpReturn(hmOrderFdpReturn);
    }

    /**
     * 修改冻干粉订单退款
     * 
     * @param hmOrderFdpReturn 冻干粉订单退款
     * @return 结果
     */
    @Override
    public int updateHmOrderFdpReturn(HmOrderFdpReturn hmOrderFdpReturn)
    {
        return hmOrderFdpReturnMapper.updateHmOrderFdpReturn(hmOrderFdpReturn);
    }

    /**
     * 批量删除冻干粉订单退款
     * 
     * @param ids 需要删除的冻干粉订单退款主键
     * @return 结果
     */
    @Override
    public int deleteHmOrderFdpReturnByIds(Long[] ids)
    {
        return hmOrderFdpReturnMapper.deleteHmOrderFdpReturnByIds(ids);
    }

    /**
     * 删除冻干粉订单退款信息
     * 
     * @param id 冻干粉订单退款主键
     * @return 结果
     */
    @Override
    public int deleteHmOrderFdpReturnById(Long id)
    {
        return hmOrderFdpReturnMapper.deleteHmOrderFdpReturnById(id);
    }
}
