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
import com.healthcare.system.domain.HmPayment;
import com.healthcare.system.service.IHmPaymentService;

import io.swagger.annotations.ApiOperation;

import com.healthcare.common.utils.poi.ExcelUtil;
import com.healthcare.common.core.page.TableDataInfo;

/**
 * 付款单Controller
 * 
 * @author ruoyi
 * @date 2026-01-29
 */
@RestController
@RequestMapping("/system/payment")
public class HmPaymentController extends BaseController
{
    @Autowired
    private IHmPaymentService hmPaymentService;

    /**
     * 查询付款单列表
     */
    @PreAuthorize("@ss.hasPermi('system:payment:list')")
    @GetMapping("/list")
    public TableDataInfo list(HmPayment hmPayment)
    {
        startPage();
        List<HmPayment> list = hmPaymentService.selectHmPaymentList(hmPayment);
        return getDataTable(list);
    }

    /**
     * 导出付款单列表
     */
    @PreAuthorize("@ss.hasPermi('system:payment:export')")
    @Log(title = "付款单", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, HmPayment hmPayment)
    {
        List<HmPayment> list = hmPaymentService.selectHmPaymentList(hmPayment);
        ExcelUtil<HmPayment> util = new ExcelUtil<HmPayment>(HmPayment.class);
        util.exportExcel(response, list, "付款单数据");
    }

    /**
     * 获取付款单详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:payment:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(hmPaymentService.selectHmPaymentById(id));
    }

    /**
     * 新增付款单
     */
    @ApiOperation("新增付款单")
    @Log(title = "付款单", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody HmPayment hmPayment)
    {
        return toAjax(hmPaymentService.insertHmPayment(hmPayment));
    }

    /**
     * 修改付款单
     */
    @PreAuthorize("@ss.hasPermi('system:payment:edit')")
    @Log(title = "付款单", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody HmPayment hmPayment)
    {
        return toAjax(hmPaymentService.updateHmPayment(hmPayment));
    }

    /**
     * 删除付款单
     */
    @PreAuthorize("@ss.hasPermi('system:payment:remove')")
    @Log(title = "付款单", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(hmPaymentService.deleteHmPaymentByIds(ids));
    }
}
