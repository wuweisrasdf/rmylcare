import $C from './config.js';
import $H from './request.js';

// ========== 认证与用户相关 ==========

// 微信手机号一键登录
export const getwxphone = params => { return $H.post(`${$C.baseUrl}/system/esign/getwxphone`, params, { useToken: false }) };

// 账号密码登录
export const loginPwd = params => { return $H.post(`${$C.baseUrl}/login`, params, { useToken: false }) };

// 手机验证码登录
export const login4vcode = params => { return $H.post(`${$C.baseUrl}/login4vcode`, params, { useToken: false }) };

// 发送验证码
export const sendvcode = params => { return $H.post(`${$C.baseUrl}/sendvcode`, params) };

// 校验验证码
export const checkvcode = params => { return $H.post(`${$C.baseUrl}/checkvcode`, params) };

// 退出登录
export const logout = params => { return $H.post(`${$C.baseUrl}/logout`, params) };

// 获取当前登录用户信息
export const getUserDetail = () => { return $H.get(`${$C.baseUrl}/getInfo`) };

// 修改用户信息
export const updateUser = params => { return $H.put(`${$C.baseUrl}/system/user`, params) };


// ========== 产妇与甲方信息 ==========

// 获取当前用户的产妇和甲方信息
export const getMotherAndUser = () => { return $H.get(`${$C.baseUrl}/getInfo2`) };

// 填写/更新产妇和甲方信息
export const updateMotherAndUser = params => { return $H.put(`${$C.baseUrl}/system/mother/editMotherUser`, params) };

// ========== 冻干粉订单相关 ==========

// 新增冻干粉订单（合同）
export const createFdpOrder = params => { return $H.post(`${$C.baseUrl}/system/fdp`, params) };

// 修改冻干粉订单状态（包括协议状态和订单状态）
export const updateFdpOrderStatus = params => { return $H.put(`${$C.baseUrl}/system/fdp`, params) };

// 获取当前用户的冻干粉订单列表（客户端）
export const getFdpOrderListForUser = (userId, dueDateBegin, dueDateEnd) => { return $H.get(`${$C.baseUrl}/system/fdp/list4user?userId=${userId}&dueDateBegin=${dueDateBegin}&dueDateEnd=${dueDateEnd}`) };

// 获取销售端的冻干粉订单列表（按销售ID查询）
export const getFdpOrderListForSales = (salesId) => { return $H.get(`${$C.baseUrl}/system/fdp/list4user?salesId=${salesId}`) };

// 获取合同信息
export const getFdpOrder = (orderId) => { return $H.get(`${$C.baseUrl}/system/fdp/list4user?id=${orderId}`) };


// ========== 产品相关 ==========

// 根据产品ID获取产品详情
export const getProductById = (id) => { return $H.get(`${$C.baseUrl}/system/product/${id}`) };

// ========== 退款相关 ==========

// 生成解约协议
export const createRefund = params => { return $H.post(`${$C.baseUrl}/system/return`, params) };

// 修改退款单状态
export const updateRefundStatus = params => { return $H.put(`${$C.baseUrl}/system/return`, params) };

// ========== 电子签名相关 ==========

// 获取电子签名URL
export const getSignUrl = params => { return $H.post(`${$C.baseUrl}/system/esign/geturl`, params) };

// 电子签名回调URL
export const signReturnUrl = `${$C.baseUrl}/system/esign/returnURL1`;

// 下载已签署的文件
export const downloadSignedFile = (orderId) => { return $H.get(`${$C.baseUrl}/system/esign/downloadSignFile?orderId=${orderId}`) };

// 微信支付
export const createPayment = params => { return $H.post(`${$C.baseUrl}/system/esign/getwxpay`, params) };

// 支付成功接口
export const paySuccess = params => { return $H.post(`${$C.baseUrl}/system/payment`, params) };

// 获取医院列表
export const getHospitalList = () => { return $H.get(`${$C.baseUrl}/system/fdp/getHospital`) };