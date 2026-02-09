package com.healthcare.web.controller.system;

import java.util.Date;
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

import com.fasterxml.jackson.annotation.JsonFormat;
import com.healthcare.common.annotation.Excel;
import com.healthcare.common.annotation.Log;
import com.healthcare.common.core.controller.BaseController;
import com.healthcare.common.core.domain.AjaxResult;
import com.healthcare.common.core.domain.entity.SysUser;
import com.healthcare.common.enums.BusinessType;
import com.healthcare.system.domain.HmMother;
import com.healthcare.system.domain.HmMotherUser;
import com.healthcare.system.service.IHmMotherService;
import com.healthcare.system.service.ISysUserService;

import io.swagger.annotations.ApiOperation;

import com.healthcare.common.utils.poi.ExcelUtil;
import com.healthcare.common.core.page.TableDataInfo;

/**
 * 产妇信息Controller
 * 
 * @author ruoyi
 * @date 2026-01-27
 */
@RestController
@RequestMapping("/system/mother")
public class HmMotherController extends BaseController
{
	@Autowired
    private ISysUserService userService;
	
    @Autowired
    private IHmMotherService hmMotherService;

    /**
     * 查询产妇信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:mother:list')")
    @GetMapping("/list")
    public TableDataInfo list(HmMother hmMother)
    {
        startPage();
        List<HmMother> list = hmMotherService.selectHmMotherList(hmMother);
        return getDataTable(list);
    }

    /**
     * 导出产妇信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:mother:export')")
    @Log(title = "产妇信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, HmMother hmMother)
    {
        List<HmMother> list = hmMotherService.selectHmMotherList(hmMother);
        ExcelUtil<HmMother> util = new ExcelUtil<HmMother>(HmMother.class);
        util.exportExcel(response, list, "产妇信息数据");
    }

    /**
     * 获取产妇信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:mother:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(hmMotherService.selectHmMotherById(id));
    }

    /**
     * 新增产妇信息
     */
    @Log(title = "产妇信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody HmMother hmMother)
    {
        return toAjax(hmMotherService.insertHmMother(hmMother));
    }

    /**
     * 修改产妇信息
     */
    @PreAuthorize("@ss.hasPermi('system:mother:edit')")
    @Log(title = "产妇信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody HmMother hmMother)
    {
        return toAjax(hmMotherService.updateHmMother(hmMother));
    }
    
    /**
     * 填写产妇和甲方信息
     */
    @ApiOperation("填写产妇和甲方信息")
    @Log(title = "填写产妇和甲方信息")
    @PutMapping("/editMotherUser")
    public AjaxResult editMotherUser(@RequestBody HmMotherUser hmMotherUser)
    {
    	AjaxResult ajax = AjaxResult.success();
    	
    	//先修改user
    	SysUser user = new SysUser();
    	user.setUserId(hmMotherUser.getUserId());
    	user.setNickName(hmMotherUser.getNickName());
    	user.setIdType(hmMotherUser.getUserIdType());
    	user.setIdCode(hmMotherUser.getUserIdCode());
    	user.setEmail(hmMotherUser.getUserEmail());
    	user.setPhonenumber(hmMotherUser.getUserPhone());
    	try {
    		userService.updateUser(user);
    	} catch (Exception e) {
    		return ajax.error("保存用户信息失败");
    	}
    	
    	//再处理产妇
    	HmMother hmMother = new HmMother();
    	hmMother.setMotherRelation(hmMotherUser.getMotherRelation());
    	hmMother.setMotherName(hmMotherUser.getMotherName());
    	hmMother.setEmail(hmMotherUser.getMotherEmail());
    	hmMother.setPhonenumber(hmMotherUser.getMotherPhone());
    	hmMother.setIdType(hmMotherUser.getMotherIdType());
    	hmMother.setIdCode(hmMotherUser.getMotherIdCode());
    	hmMother.setHospitalName(hmMotherUser.getHospitalName());
    	hmMother.setDueDate(hmMotherUser.getDueDate());
    	hmMother.setAddress(hmMotherUser.getAddress());
    	hmMother.setUserId(hmMotherUser.getUserId());
    	
    	Long motherId = hmMotherUser.getMotherId();
    	try {
        	if(motherId > 0L) {
        		hmMother.setId(motherId);
        		hmMotherService.updateHmMother(hmMother);
        		ajax.put("motherId", motherId);
        	}
        	else {
        		hmMother.setId(0L);
        		hmMotherService.insertHmMother(hmMother);
        		ajax.put("motherId", hmMother.getId());
        	}
    	} catch (Exception e) {
    		return ajax.error("保存产妇信息失败");
    	}
    	
        return ajax;
    }

    /**
     * 删除产妇信息
     */
    @PreAuthorize("@ss.hasPermi('system:mother:remove')")
    @Log(title = "产妇信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(hmMotherService.deleteHmMotherByIds(ids));
    }
}
