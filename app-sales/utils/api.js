import $C from './config.js';
import $H from './request.js';

// 上传
export const uploadURL =  `${$C.baseUrl}/common/upload`

// 签名上传
export const uploadSign = `${$C.baseUrl}/system/piinfo/signUpload/`

// 下载地址
export const downloadURL = `${$C.baseUrl}/common/download?fileName=`


// 退出登录
export const logout = params => {return $H.post(`${$C.baseUrl}/logout`, params, {useToken:false}) }
// 账号密码登录
export const loginPwd = params => {return $H.post(`${$C.baseUrl}/login`, params, {useToken:false}) }
// 发送验证码 
export const sendvcode = params => {return $H.post(`${$C.baseUrl}/sendvcode`, params) }
// 校验验证码 
export const checkvcode = params => {return $H.post(`${$C.baseUrl}/checkvcode`, params) }
// 校验旧密码 
export const checkPassword = params => {return $H.post(`${$C.baseUrl}/checkpassword`, params) }

//获取用户信息
export const getUserDetail = () => { return $H.get(`${$C.baseUrl}/getInfo`) }

// 根据id获取用户信息
export const getUserDetailByUid = (uid) => { return $H.get(`${$C.baseUrl}/system/user/${uid}`) }
// 根据id修改用户信息
export const putUserDetailByUid = (params) => { return $H.put(`${$C.baseUrl}/system/user`, params) }

// 下载声音
export const downloadFile = (fileName) => { return $H.get(`${$C.baseUrl}/common/download?fileName=${fileName}`) }

// 获取合同信息机会列表
export const contractList = (params) => {return $H.get(`${$C.baseUrl}/system/fdp/list4user?salesId=${params.salesId}&dueDateBegin=${params.dueDateBegin}&dueDateEnd=${params.dueDateEnd}`)}
// 获取合同信息机会(销售端)
export const contractDetail = (params) => {return $H.get(`${$C.baseUrl}/system/fdp/list4user?id=${params.id}`)}

// 认证
export const getRmyToken = (params) => {return $H.post(`${$C.baseUrl}/openapi/index/gettoken`, params)}
// 获取合同信息列表
export const contractRmylList = (params) => {return $H.post(`${$C.baseUrl}/openapi/index/services/?op=GetProtocolListV1`, params)}
// 获取合同信息(销售端)
export const contractRmylDetail = (params) => {return $H.get(`${$C.baseUrl}/system/fdp/list4user?id=${params.id}`)}

// 获取销售人员二维码接口 
export const getwxqrcode = params => { return $H.post(`${$C.baseUrl}/system/esign/getwxqrcode`, params) }

// 获取产妇和甲方信息接口
export const getInfo2 = params => { return $H.get(`${$C.baseUrl}/getInfo2?id=${params.id}`) }

// 根据产品ID获取产品详情
export const getProductById = (id) => { return $H.get(`${$C.baseUrl}/system/product/${id}`) };

// 查看顺丰快递接口
export const getLogistics = (orderId) => { return $H.post(`${$C.baseUrl}/interface/sf/orderTracking?orderId=${orderId}`) };
