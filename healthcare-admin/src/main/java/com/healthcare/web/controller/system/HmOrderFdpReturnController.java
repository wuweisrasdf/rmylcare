package com.healthcare.web.controller.system;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.healthcare.system.domain.HmOrderFdp;
import com.healthcare.system.domain.HmOrderFdpReturn;
import com.healthcare.system.service.IHmOrderFdpReturnService;
import com.healthcare.system.service.IHmOrderFdpService;

import io.swagger.annotations.ApiOperation;

import com.healthcare.common.utils.poi.ExcelUtil;
import com.healthcare.common.core.page.TableDataInfo;

/**
 * 冻干粉订单退款Controller
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@RestController
@RequestMapping("/system/return")
public class HmOrderFdpReturnController extends BaseController
{
    @Autowired
    private IHmOrderFdpReturnService hmOrderFdpReturnService;
    
    @Autowired
    private IHmOrderFdpService hmOrderFdpService;

    /**
     * 查询冻干粉订单退款列表
     */
    @PreAuthorize("@ss.hasPermi('system:return:list')")
    @GetMapping("/list")
    public TableDataInfo list(HmOrderFdpReturn hmOrderFdpReturn)
    {
        startPage();
        List<HmOrderFdpReturn> list = hmOrderFdpReturnService.selectHmOrderFdpReturnList(hmOrderFdpReturn);
        return getDataTable(list);
    }

    /**
     * 导出冻干粉订单退款列表
     */
    @PreAuthorize("@ss.hasPermi('system:return:export')")
    @Log(title = "冻干粉订单退款", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, HmOrderFdpReturn hmOrderFdpReturn)
    {
        List<HmOrderFdpReturn> list = hmOrderFdpReturnService.selectHmOrderFdpReturnList(hmOrderFdpReturn);
        ExcelUtil<HmOrderFdpReturn> util = new ExcelUtil<HmOrderFdpReturn>(HmOrderFdpReturn.class);
        util.exportExcel(response, list, "冻干粉订单退款数据");
    }

    /**
     * 获取冻干粉订单退款详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:return:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(hmOrderFdpReturnService.selectHmOrderFdpReturnById(id));
    }

    /**
     * 新增冻干粉订单退款
     */
    @ApiOperation("新增冻干粉退款")
    @Log(title = "冻干粉订单退款", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody HmOrderFdpReturn hmOrderFdpReturn)
    {
    	AjaxResult ajax = AjaxResult.success();
    	hmOrderFdpReturnService.insertHmOrderFdpReturn(hmOrderFdpReturn);
    	ajax.put("id", hmOrderFdpReturn.getId());
        return ajax;
    }

    /**
     * 修改冻干粉订单退款
     */
    @ApiOperation("修改冻干粉退款")
    @Log(title = "冻干粉订单退款", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody HmOrderFdpReturn hmOrderFdpReturn)
    {
        return toAjax(hmOrderFdpReturnService.updateHmOrderFdpReturn(hmOrderFdpReturn));
    }
    
    /**
     * 查询冻干粉订单退款
     */
    @ApiOperation("查询冻干粉订单退款")
    @PostMapping("/list4order")
    public AjaxResult list4order(@RequestBody HmOrderFdpReturn hmOrderFdpReturn)
    {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	AjaxResult ajax = AjaxResult.success();
    	Map<String, String> result = new HashMap<String, String>();
    	List<HmOrderFdpReturn> list = hmOrderFdpReturnService.selectHmOrderFdpReturnList(hmOrderFdpReturn);
    	if(list.size() > 0) {
    		result.put("StatusDate", sdf.format(list.get(0).getSignDate()));
    		HmOrderFdp orderObj = hmOrderFdpService.selectHmOrderFdpById(hmOrderFdpReturn.getOrderId());
    		result.put("ProCode", orderObj.getOrderCode());
    		result.put("AmountReceived", orderObj.getPriceOut().toString());
    		ajax.put("orderReturn", result);
    	}
    	else {
    		ajax = AjaxResult.error("订单没有解约!");
    	}
        return ajax;
    }

    /**
     * 删除冻干粉订单退款
     */
    @PreAuthorize("@ss.hasPermi('system:return:remove')")
    @Log(title = "冻干粉订单退款", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(hmOrderFdpReturnService.deleteHmOrderFdpReturnByIds(ids));
    }
}
