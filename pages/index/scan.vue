<template>
	<view class="">
		<u-loading-page loading-mode="spinner" loading-text="解析中..." font-size="36" icon-size="80" :loading="loading">
		</u-loading-page>
	</view>
</template>

<script>
	import * as api from '@/utils/api.js'
	import {
		mapState
	} from 'vuex';

	export default {
		computed: {
			...mapState(['token', 'user'])
		},
		data() {
			return {
				loading: true
			}
		},
		onLoad(options) {
			// 1. 解析 scene 参数
			if (!options.scene) {
				uni.showToast({
					title: '参数无效',
					icon: 'none'
				});
				return;
			}

			let para = options.scene.split("%2F");
			let salesId = para[0] || '';
			let token = para[1] || '';
			salesId = Number(salesId);
			
			if (isNaN(salesId) || !token) {
				this.handleError();
				return;
			}
			
			this.checkWxQrcode(salesId,token);
		},
		methods: {
			// 检查二维码token是否已使用过
			async checkWxQrcode(salesId,token) {
				const params = {
					userId: salesId,
					token: token
				}
				try {
					const res = await api.checkwxqrcode(params);
					if (res.code == 200) {
						
						// 2. 保存 salesId 到本地，供后续流程使用
						uni.setStorageSync('SCAN_SALES_ID', salesId);
						
						this.checkLogin();
					}
				}catch (error) {
					//console.error('二维码验证失败:', error);
					
					uni.showModal({
						title: '二维码已失效',
						content: '请联系咨询顾问获取新的二维码',
						confirmText: '关闭',
						showCancel: false,
						success: (res) => {
							this.handleError();
						}
					});
				}
			},
			// 检查是否登录
			checkLogin() {
				// 3. 根据登录状态执行不同逻辑
				if (this.token) {
					uni.redirectTo({
						url: '/pages/index/flow'
					});
				} else {
					// 表示来自 scan 
					uni.setStorageSync('FROM_SCAN', 1);
				
					//this.loading = false;
				
					// 未登录 → 跳登录页
					uni.redirectTo({
						url: '/pages/login/login'
					});
				}
			},
			handleError(){
				this.loading = false;
				uni.exitMiniProgram({
					success: () => {
						console.log('成功退出小程序')
					},
					fail:(err) => {
						console.error('退出失败', err)
						uni.redirectTo({
							url: '/pages/index/index'
						});
					}
				}); 
			}
		}
	};
</script>