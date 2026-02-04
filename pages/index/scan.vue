<!-- pages/landing/scan.vue -->
<template>
	<view>加载中...</view>
</template>

<script>
	import {
		mapState
	} from 'vuex';

	export default {
		computed: {
			...mapState(['token', 'user'])
		},
		onLoad(options) {
			const salesId = options.salesId;

			if (!salesId) {
				// 无 salesId，可能是非法访问，跳首页
				uni.redirectTo({
					url: '/pages/index/index'
				});
				return;
			}

			// 保存 salesId
			uni.setStorageSync('SCAN_SALES_ID', salesId);

			if (this.token) {
				// 已登录 → 直接进签约页
				uni.redirectTo({
					url: `/pages/index/intro`
				});
			} else {
				// 表示来自 scan 
				uni.setStorageSync('FROM_SCAN', 1);
				
				// 未登录 → 跳登录页
				uni.redirectTo({
					url: '/pages/login/login'
				});
			}
		}
	};
</script>