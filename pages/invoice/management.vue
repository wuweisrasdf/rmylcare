<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" title="发票管理" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>
		
		<view class="content-container">
			
		</view>
		
		<view class="btn-group">
			<u-button :custom-style="primaryBtnStyle" @click="goHome">
				返回首页
			</u-button>
		</view>
	</view>
</template>

<script>
	import * as api from '@/utils/api.js'
	import {
		mapState
	} from 'vuex'

	export default {
		computed: {
			...mapState({
				user: state => state.user,
				token: state => state.token,
			}),
			containerPaddingTop() {
				const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
				return barHeight;
			},
			primaryBtnStyle() {
				return {
					height: '98rpx',
					borderRadius: '49rpx',
					backgroundColor: '#4A63E4',
					fontWeight: 'bold',
					fontSize: '32rpx',
					color: '#FFFFFF'
				};
			}
		},
		onLoad(options) {
			if (options.orderId) {
				this.orderId = options.orderId;
				this.init();
			}
		},
		data() {
			return {
				orderId: '',
			};
		},
		methods: {
			async init() {
				try {
					const res = await api.getInvoice(this.orderId);
					if (res.code == 200) {

					} else {
						uni.showToast({
							title: res.msg || '加载失败',
							icon: 'none'
						});
					}
				} catch (error) {
					console.error('失败:', error);
					uni.showToast({
						title: '网络错误',
						icon: 'none'
					});
				} finally {

				}
			},
			
			
			
			goHome() {
				uni.redirectTo({
					url: "/pages/index/index"
				});
			}
		}
	};
</script>


<style lang="scss" scoped>
	.container {
		background-color: #F5F7FA;
		min-height: 100vh;
		display: flex;
		flex-direction: column;
	}
	
	.content-container {
		flex: 1;
		padding: 30rpx;
		padding-bottom: 160rpx;
	}
	
	.btn-group {
		display: flex;
		flex-direction: column;
		gap: 22rpx;
		width: 100%;
		margin: 50rpx auto 120rpx;
		padding: 0 26rpx;
		box-sizing: border-box;
	}
</style>