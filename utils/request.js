import $store from '@/store/index.js';
import $C from '@/utils/config.js';

// 错误码处理策略表（集中管理）
const ERROR_HANDLERS = {
  401: { // 与服务器端沟通， 401 表示登录过期
    message: '登录状态过期，请重新登录',
    action: 'logoutAndRedirect'
  },
  // 402: {
  //   message: '账号异常，请重新登录',
  //   action: 'logoutAndRedirect'
  // },
  403: {
    message: '没有操作权限',
    action: 'toastOnly'
  },
  404: {
    message: '请求地址错误',
    action: 'toastOnly'
  },
  500: {
    message: '服务器开小差了',
    action: 'toastOnly'
  }
};

// 执行登出并跳转
function handleLogoutAndRedirect() {
  $store.dispatch('logout');
  setTimeout(() => {
    uni.reLaunch({ url: '/pages/login/login' });
  }, 3000);
}

// 统一错误处理器
function handleError(result, options) {
  const code = result.data.code;
  const handler = ERROR_HANDLERS[code] || { message: '请求失败', action: 'toastOnly' };
  const msg = result.data.msg || handler.message;

  if (options.toast !== false) {
	let title = msg;
	// 对外隐藏服务器错误
	if (code == 500) {
		title = '服务器开小差了';
	}
    uni.showToast({ title: title, icon: 'none', duration: 3000 });
  }

  if (handler.action === 'logoutAndRedirect') {
    console.log(`触发登出 (code: ${code})`);
    handleLogoutAndRedirect();
  }

  return new Error(msg);
}


export default {
    // 全局配置
    common:{
        baseUrl:'',
        header:{
            'Content-Type':'application/json;charset=UTF-8',
        },
        data:{},
        method:'GET',
        dataType:'json',
		useToken:true,
		toast: true
    },
    // 请求 返回promise
    request(options = {}){
        // 组织参数
        options.url = this.common.baseUrl + options.url
        //options.header = options.header || this.common.header
		options.header = { ...this.common.header, ...options.header };
        options.data = options.data || this.common.data
        options.method = options.method || this.common.method
        options.dataType = options.dataType || this.common.dataType
		options.toast = options.toast || this.common.toast

		if (typeof(options.useToken) == 'undefined'){
			options.useToken = this.common.useToken
		}
		
        // 请求
        return new Promise((resolve, reject)=>{
			// 请求之前验证...
			// token验证
			if (false === options.useToken){
				options.header.Authorization = null
			}
			
			let token = $store.state.token; // 从 Vuex 读取（初始化时已从 storage 恢复）
			if (!token) {
				token = uni.getStorageSync('token'); // 兜底：防止 store 未初始化
			}
				  
			if (token && options.useToken){
				// 往header头中添加token
				options.header.Authorization = 'Bearer ' + token 
			}
			 
			//console.info('token',token)
			 
            // 请求中...
            uni.request({
                ...options,
                success: (result) => {
                    // 返回原始数据
                    if(options.native){
                        return resolve(result)
                    }
					//console.log('result',result);
                    
					// HTTP 层错误（如 404, 500）					
					if (result.statusCode !== 200) {
						const msg = result.data?.data || '服务端失败';
						if (options.toast !== false) {
						  uni.showToast({ title: msg, icon: 'none' });
						}
						return reject(result.data);
					}
										
					// 服务端未返回 code 字段
					if (typeof result.data.code === 'undefined') {
						const errMsg = '服务端未返回code参数';
						if (options.toast !== false) {
						  uni.showToast({ title: errMsg, icon: 'none' });
						}
						return reject(new Error(errMsg));
					}
					
					// 业务成功
					if (result.data.code === 200) {
						return resolve(result.data);
					}
					
				    // 业务错误
				    const error = handleError(result, options);
				    return reject(error);
                },
                fail: (error) => {
                    uni.showToast({ title: error.errMsg || '请求失败', icon: 'none' });
                    return reject(error)
                }
            });
        })
    },
    // get请求
    get(url,options = {}){
        options.url = url
        options.data = {}
        options.method = 'GET'
        return this.request(options)
    },
    // post请求
    post(url,data = {},options = {}){
        options.url = url
        options.data = data
        options.method = 'POST'
        return this.request(options)
    },
    // put请求
    put(url,data = {},options = {}){
        options.url = url
        options.data = data
        options.method = 'PUT'
        return this.request(options)
    },	
    // delete请求
    del(url,data = {},options = {}){
        options.url = url
        options.data = data
        options.method = 'DELETE'
        return this.request(options)
    },
	// 上传文件
	upload(url, data, onProgress = false) {
	    return new Promise((resolve, reject) => {
	      // 优先从 store 读取 token
	      let token = $store.state.token;
	      if (!token) {
	        token = uni.getStorageSync('token');
	      }
	
	      if (!token) {
	        uni.showToast({ title: '请先登录', icon: 'none' });
	        uni.reLaunch({ url: '/pages/login/login' });
	        return reject(new Error('未登录'));
	      }
	
	      const uploadTask = uni.uploadFile({
	        url: this.common.baseUrl + url,
	        filePath: data.filePath,
	        name: data.name || 'files',
	        header: { Authorization: 'Bearer ' + token }, // 保持与 request 一致
	        formData: data.formData || {},
	        success: (res) => {
	          if (res.statusCode !== 200) {
	            uni.showToast({ title: '上传失败', icon: 'none' });
	            return resolve(false);
	          }
	
	          let message;
	          try {
	            message = JSON.parse(res.data);
	          } catch (e) {
	            uni.showToast({ title: '上传响应格式错误', icon: 'none' });
	            return reject(e);
	          }
	
	          if (message.code !== 200) {
	            const errMsg = message.msg || '上传失败';
	            uni.showToast({ title: errMsg, icon: 'none' });
	            return reject(new Error(errMsg));
	          }
	
	          resolve(message.data);
	        },
	        fail: (err) => {
	          console.error('上传失败:', err);
	          uni.showToast({ title: '上传失败', icon: 'none' });
	          reject(err);
	        }
	      });
	
	      if (typeof onProgress === 'function') {
	        uploadTask.onProgressUpdate((progressRes) => {
	          onProgress(progressRes.progress);
	        });
	      }
	    });
	  }
}