package com.healthcare.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.healthcare.system.mapper.HmMotherMapper;
import com.healthcare.system.domain.HmMother;
import com.healthcare.system.service.IHmMotherService;

/**
 * 产妇信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@Service
public class HmMotherServiceImpl implements IHmMotherService 
{
    @Autowired
    private HmMotherMapper hmMotherMapper;

    /**
     * 查询产妇信息
     * 
     * @param id 产妇信息主键
     * @return 产妇信息
     */
    @Override
    public HmMother selectHmMotherById(Long id)
    {
        return hmMotherMapper.selectHmMotherById(id);
    }

    /**
     * 查询产妇信息列表
     * 
     * @param hmMother 产妇信息
     * @return 产妇信息
     */
    @Override
    public List<HmMother> selectHmMotherList(HmMother hmMother)
    {
        return hmMotherMapper.selectHmMotherList(hmMother);
    }

    /**
     * 新增产妇信息
     * 
     * @param hmMother 产妇信息
     * @return 结果
     */
    @Override
    public int insertHmMother(HmMother hmMother)
    {
        return hmMotherMapper.insertHmMother(hmMother);
    }

    /**
     * 修改产妇信息
     * 
     * @param hmMother 产妇信息
     * @return 结果
     */
    @Override
    public int updateHmMother(HmMother hmMother)
    {
        return hmMotherMapper.updateHmMother(hmMother);
    }

    /**
     * 批量删除产妇信息
     * 
     * @param ids 需要删除的产妇信息主键
     * @return 结果
     */
    @Override
    public int deleteHmMotherByIds(Long[] ids)
    {
        return hmMotherMapper.deleteHmMotherByIds(ids);
    }

    /**
     * 删除产妇信息信息
     * 
     * @param id 产妇信息主键
     * @return 结果
     */
    @Override
    public int deleteHmMotherById(Long id)
    {
        return hmMotherMapper.deleteHmMotherById(id);
    }
}
