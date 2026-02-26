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
				loading: true,
				salesId: null
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

			let para = options.scene
			let salesId = para.replace("salesId%3D", "");

			if (!typeof(salesId) == Number) {
				// 无 salesId，可能是非法访问，跳首页
				uni.redirectTo({
					url: '/pages/index/index'
				});
				return;
			}

			this.salesId = salesId;
			console.log('SCAN_SALES_ID', salesId);

			// 2. 保存 salesId 到本地，供后续流程使用
			uni.setStorageSync('SCAN_SALES_ID', salesId);

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
		methods: {
			
		}
	};
</script>