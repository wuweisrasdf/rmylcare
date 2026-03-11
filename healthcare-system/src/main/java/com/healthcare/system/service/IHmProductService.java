package com.healthcare.system.service;

import java.util.List;
import com.healthcare.system.domain.HmProduct;

/**
 * 产品信息Service接口
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
public interface IHmProductService 
{
    /**
     * 查询产品信息
     * 
     * @param id 产品信息主键
     * @return 产品信息
     */
    public HmProduct selectHmProductById(Long id);

    /**
     * 查询产品信息列表
     * 
     * @param hmProduct 产品信息
     * @return 产品信息集合
     */
    public List<HmProduct> selectHmProductList(HmProduct hmProduct);

    /**
     * 新增产品信息
     * 
     * @param hmProduct 产品信息
     * @return 结果
     */
    public int insertHmProduct(HmProduct hmProduct);

    /**
     * 修改产品信息
     * 
     * @param hmProduct 产品信息
     * @return 结果
     */
    public int updateHmProduct(HmProduct hmProduct);

    /**
     * 批量删除产品信息
     * 
     * @param ids 需要删除的产品信息主键集合
     * @return 结果
     */
    public int deleteHmProductByIds(Long[] ids);

    /**
     * 删除产品信息信息
     * 
     * @param id 产品信息主键
     * @return 结果
     */
    public int deleteHmProductById(Long id);
}
