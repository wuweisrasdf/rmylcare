<template>
	<view class="">
		<u-loading-page loading-mode="spinner" loading-text="加载中..." font-size="36" icon-size="80"
			:loading="loading">
		</u-loading-page>
	</view>
</template>

<script>
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
			if (!options.scene) {
				uni.showToast({ title: '参数无效', icon: 'none' });
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
			
			console.log('SCAN_SALES_ID', salesId);

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