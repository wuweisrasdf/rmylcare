package com.healthcare.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.healthcare.system.mapper.HmProductMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.healthcare.system.domain.HmProduct;
import com.healthcare.system.service.IHmProductService;

/**
 * 产品信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@Service
public class HmProductServiceImpl implements IHmProductService 
{
    @Autowired
    private HmProductMapper hmProductMapper;

    /**
     * 查询产品信息
     * 
     * @param id 产品信息主键
     * @return 产品信息
     */
    @Override
    public HmProduct selectHmProductById(Long id)
    {
    	HmProduct prodObj = hmProductMapper.selectHmProductById(id);
    	String details = prodObj.getDetails();
    	JsonObject jsonObject = JsonParser.parseString(details).getAsJsonObject();
    	String url = jsonObject.get("file").getAsString();
    	int idx = jsonObject.get("idx").getAsInt();
    	List fileArr = new ArrayList();
    	for(int i = 1; i <= idx ; i++) {
    		fileArr.add(String.format(url, i));
    	}
    	Gson gson = new Gson();
        String json = gson.toJson(fileArr);
        prodObj.setDetails(json);
        return prodObj;
    }

    /**
     * 查询产品信息列表
     * 
     * @param hmProduct 产品信息
     * @return 产品信息
     */
    @Override
    public List<HmProduct> selectHmProductList(HmProduct hmProduct)
    {
        return hmProductMapper.selectHmProductList(hmProduct);
    }

    /**
     * 新增产品信息
     * 
     * @param hmProduct 产品信息
     * @return 结果
     */
    @Override
    public int insertHmProduct(HmProduct hmProduct)
    {
        return hmProductMapper.insertHmProduct(hmProduct);
    }

    /**
     * 修改产品信息
     * 
     * @param hmProduct 产品信息
     * @return 结果
     */
    @Override
    public int updateHmProduct(HmProduct hmProduct)
    {
        return hmProductMapper.updateHmProduct(hmProduct);
    }

    /**
     * 批量删除产品信息
     * 
     * @param ids 需要删除的产品信息主键
     * @return 结果
     */
    @Override
    public int deleteHmProductByIds(Long[] ids)
    {
        return hmProductMapper.deleteHmProductByIds(ids);
    }

    /**
     * 删除产品信息信息
     * 
     * @param id 产品信息主键
     * @return 结果
     */
    @Override
    public int deleteHmProductById(Long id)
    {
        return hmProductMapper.deleteHmProductById(id);
    }
}
