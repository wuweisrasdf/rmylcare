package com.healthcare.common.utils;

import java.util.HashMap;
import java.util.Map;
/*
 * 小程序推送所需数据
 * */
public class SysWxMessage {
    private String touser;//用户openid
    private String template_id;//订阅消息模版id
    private String page = "pages/index/index";//默认跳到小程序首页
    private Map<String, SysWxTempData> data=new HashMap<String,SysWxTempData>();//推送文字

    public String getTouser() {
        return touser;
    }
    public void setTouser(String touser) {
        this.touser = touser;
    }
    public String getTemplate_id() {
        return template_id;
    }
    public void setTemplate_id(String template_id) {
        this.template_id = template_id;
    }
    public String getPage() {
        return page;
    }
    public void setPage(String page) {
        this.page = page;
    }
    public Map<String, SysWxTempData> getData() {
        return data;
    }
    public void setData(Map<String, SysWxTempData> data) {
        this.data = data;
    }
}