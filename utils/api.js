import $C from './config.js';
import $H from './request.js';

// 上传
export const uploadURL =  `${$C.baseUrl}/dev-api/common/upload`

// 签名上传
export const uploadSign = `${$C.baseUrl}/dev-api/system/piinfo/signUpload/`

// 下载地址
export const downloadURL = `${$C.baseUrl}/dev-api/common/download?fileName=`


// 账号密码登录
export const loginPwd = params => {return $H.post(`${$C.baseUrl}/dev-api/login`, params, {useToken:false}) }

// 手机验证码登录
export const loginSmsCode = params => {return $H.post(`${$C.baseUrl}/dev-api/sms/login`, params, {useToken:false})}

// 获取短信
export const getSms = parmas => { return $H.post(`${$C.baseUrl}/dev-api/sms/code`, parmas) }

//获取用户信息
export const getUserDetail = () => { return $H.get(`${$C.baseUrl}/dev-api/getInfo`) }

// 根据id获取用户信息
export const getUserDetailByUid = (uid) => { return $H.get(`${$C.baseUrl}/dev-api/system/user/${uid}`) }

// PI列表
export const getPIList = (page,pageSize) => { return $H.get(`${$C.baseUrl}/dev-api/system/piinfo/list?pageNum=${page}&pageSize=${pageSize}`) }

// PI详情
export const getPIDetail = (id) => { return $H.get(`${$C.baseUrl}/dev-api/system/piinfo/${id}`) }

// PI在研项目列表
export const getPItrial = (doctorName,page,pageSize) => { return $H.get(`${$C.baseUrl}/dev-api/system/list/list?doctorName=${doctorName}&pageNum=${page}&pageSize=${pageSize}`) }

// PI项目报表
export const getPIreport = (doctorName) => { return $H.get(`${$C.baseUrl}/dev-api/system/list/report?doctorName=${doctorName}`) }


// 预研项目列表
export const getShallResearch = (createId,page,pageSize) => { return $H.get(`${$C.baseUrl}/dev-api/system/pretrial/list?orderByColumn=id&isAsc=desc&createId=${createId}&pageNum=${page}&pageSize=${pageSize}`) }


// 获取预研项目信息详细信息
export const getShallDetail = (id) => { return $H.get(`${$C.baseUrl}/dev-api/system/pretrial/${id}`) }


// 在研项目列表 - 1
export const getInResearch = (uid) => { return $H.get(`${$C.baseUrl}/dev-api/system/cro/list?userId=${uid}`) }

// 在研项目列表 - 2
export const getInResearchDetail = (id) =>  { return $H.get(`${$C.baseUrl}/dev-api/system/list/${id}`) }

// 检查在研项目编号是否已经收录系统
export const checkInResearch = (trialCode) => { return $H.get(`${$C.baseUrl}/dev-api/system/list/list?trialCode=${trialCode}`) }


// 修改预研项目提交PI 
export const updatePretrial = params => { return $H.put(`${$C.baseUrl}/dev-api/system/pi`,params) }

// 查询预研项目提交PI列表
export const getSubmitedList = (userId,trialId) => { return $H.get(`${$C.baseUrl}/dev-api/system/pi/list?trialId=${trialId}&userId=${userId}`) }

// PI获取新药资料列表（提交给PI的列表）
export const getMyPretrialList = (userId,page,pageSize) => { return $H.get(`${$C.baseUrl}/dev-api/system/pi/list?userId=${userId}&pageNum=${page}&pageSize=${pageSize}&orderByColumn=id&isAsc=desc`) }

// 所有约见请求
export const getSchedulelList = (doctorName,page,pageSize) => { return $H.get(`${$C.baseUrl}/dev-api/system/schedule/list?doctorName=${doctorName}&pageNum=${page}&pageSize=${pageSize}&orderByColumn=id&isAsc=desc&scheduleAddress`) }

// PI常用的见面地址
export const getPiAddress = (doctorName) => { return $H.get(`${$C.baseUrl}/dev-api/system/schedule/address/${doctorName}`) }

// PI修改约见时间和地点
export const updateSchedule = params => { return $H.put(`${$C.baseUrl}/dev-api/system/schedule`,params) }

// 获取已约见的邀请
export const getReadyAppointments =(doctorName) =>  { return $H.get(`${$C.baseUrl}/dev-api/system/schedule/confirm?doctorName=${doctorName}`) }

// 获取PI在研项目列表
export const getPIProjects = (doctorName,page,pageSize,applyName,drugName) => { return $H.get(`${$C.baseUrl}/dev-api/system/list/list?doctorName=${doctorName}&pageNum=${page}&pageSize=${pageSize}&applyName=${applyName}&drugName=${drugName}`) }

// 将文本转换成声音
export const text2mp3 = params => {return $H.post(`${$C.baseUrl}/dev-api/tools`, params)}

// 下载声音
export const downloadFile = (fileName) => { return $H.get(`${$C.baseUrl}/dev-api/common/download?fileName=${fileName}`) }

// 返回项目对应的聊天群组ID
export const getEmGroupId = (trialCode,userId) => { return $H.get(`${$C.baseUrl}/dev-api/system/em/getGroupId/${trialCode}/${userId}`,{native:true}) }

// 通过预研项目与PI的关联对象ID返回GROUPID
export const getPreGroupId = (preTrialID,PIuserId) => { return $H.get(`${$C.baseUrl}/dev-api/system/em/getPreTrialGroupId/${preTrialID}/${PIuserId}`,{native:true})}

// 播放mp3
export const playMP3 = (fileName) => { return $H.get(`${$C.baseUrl}/dev-api/common/playMP3?fileName=${fileName}`,{native:true}) }

// 生成在线浏览资料文件 ​/dev-api​/common​/viewDoc?fileName=
export const getViewDoc = (fileName) => { return $H.get(`${$C.baseUrl}/dev-api/common/viewDoc?fileName=${fileName}`) }

// 检查PI是否有签名
export const checkPISign = (id) => { return $H.get(`${$C.baseUrl}/dev-api/system/piinfo/sign/${id}`,{native:true}) }

// 气泡提示
export const getNewTips = (id) => { return $H.get(`${$C.baseUrl}/dev-api/system/piinfo/common/newinfo/${id}`) }

// 在线PDF文件签名
export const signPDF = (TrialId,userId) => { return $H.get(`${$C.baseUrl}/dev-api/common/signPDF?preTrialId=${TrialId}&userId=${userId}` ,{native:true}) }

// 获取PDF签名后的文件
export const getSignPDF = (relid) => { return $H.get(`${$C.baseUrl}/dev-api/common/getSignPDF?relId=${relid}`,{native:true} ) }