package com.healthcare.web.controller.system;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.healthcare.common.annotation.Log;
import com.healthcare.common.core.controller.BaseController;
import com.healthcare.common.core.domain.AjaxResult;
import com.healthcare.common.enums.BusinessType;
import com.healthcare.system.domain.HmProduct;
import com.healthcare.system.service.IHmProductService;

import io.swagger.annotations.ApiOperation;

import com.healthcare.common.utils.poi.ExcelUtil;
import com.healthcare.common.core.page.TableDataInfo;

/**
 * 产品信息Controller
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@RestController
@RequestMapping("/system/product")
public class HmProductController extends BaseController
{
    @Autowired
    private IHmProductService hmProductService;

    /**
     * 查询产品信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:product:list')")
    @GetMapping("/list")
    public TableDataInfo list(HmProduct hmProduct)
    {
        startPage();
        List<HmProduct> list = hmProductService.selectHmProductList(hmProduct);
        return getDataTable(list);
    }

    /**
     * 导出产品信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:product:export')")
    @Log(title = "产品信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, HmProduct hmProduct)
    {
        List<HmProduct> list = hmProductService.selectHmProductList(hmProduct);
        ExcelUtil<HmProduct> util = new ExcelUtil<HmProduct>(HmProduct.class);
        util.exportExcel(response, list, "产品信息数据");
    }

    /**
     * 获取产品信息详细信息
     */
    @ApiOperation("获取产品信息详细信息")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(hmProductService.selectHmProductById(id));
    }

    /**
     * 新增产品信息
     */
    @PreAuthorize("@ss.hasPermi('system:product:add')")
    @Log(title = "产品信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody HmProduct hmProduct)
    {
        return toAjax(hmProductService.insertHmProduct(hmProduct));
    }

    /**
     * 修改产品信息
     */
    @Log(title = "产品信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody HmProduct hmProduct)
    {
        return toAjax(hmProductService.updateHmProduct(hmProduct));
    }

    /**
     * 删除产品信息
     */
    @PreAuthorize("@ss.hasPermi('system:product:remove')")
    @Log(title = "产品信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(hmProductService.deleteHmProductByIds(ids));
    }
}
