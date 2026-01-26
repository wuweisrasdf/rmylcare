//app.js
export let appx={
	state:{
		privacyAgree: false,//是否需要调用隐私协议 同意过返回false
	},
	mutations:{
		setPrivacyAgree(state,payload){
			state.privacyAgree = payload;
		}
	},
	actions:{
		getPrivacyAgree(state,payload){
			uni.getPrivacySetting({
				success: res => {
				// 返回结果为: res = { needAuthorization: true/false, privacyContractName: '《xxx隐私保护指引》' }
					commit("setPrivacyAgree",res.needAuthorization)
				},
				fail: () => {},
				complete: () => {}
			})
		}
	},
	modules: {}
}
