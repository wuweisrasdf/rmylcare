package com.healthcare.system.service;

import java.util.List;
import com.healthcare.system.domain.HmMother;

/**
 * 产妇信息Service接口
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
public interface IHmMotherService 
{
    /**
     * 查询产妇信息
     * 
     * @param id 产妇信息主键
     * @return 产妇信息
     */
    public HmMother selectHmMotherById(Long id);

    /**
     * 查询产妇信息列表
     * 
     * @param hmMother 产妇信息
     * @return 产妇信息集合
     */
    public List<HmMother> selectHmMotherList(HmMother hmMother);

    /**
     * 新增产妇信息
     * 
     * @param hmMother 产妇信息
     * @return 结果
     */
    public int insertHmMother(HmMother hmMother);

    /**
     * 修改产妇信息
     * 
     * @param hmMother 产妇信息
     * @return 结果
     */
    public int updateHmMother(HmMother hmMother);

    /**
     * 批量删除产妇信息
     * 
     * @param ids 需要删除的产妇信息主键集合
     * @return 结果
     */
    public int deleteHmMotherByIds(Long[] ids);

    /**
     * 删除产妇信息信息
     * 
     * @param id 产妇信息主键
     * @return 结果
     */
    public int deleteHmMotherById(Long id);
}
