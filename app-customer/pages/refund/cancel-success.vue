<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<view class="content-container">
			<view class="top">
				<image src="/static/icons/sign-success.png" mode="widthFix"></image>
				<text class="title">解约成功！</text>
			</view>

		</view>

		<!-- 按钮组容器 -->
		<view class="btn-group">
			<u-button :custom-style="primaryBtnStyle" @click="goHome">
				返回首页
			</u-button>
			
			<u-button :custom-style="secondaryBtnStyle" @click="viewOrder">
				查看订单
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
			},
			secondaryBtnStyle() {
				return {
					height: '98rpx',
					borderRadius: '49rpx',
					border: '2px solid rgba(142,142,142,0.5)',
					backgroundColor: 'transparent', // 透明背景
					fontWeight: 'bold',
					fontSize: '32rpx',
					color: '#3D3D3D'
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
				paying: false, // 支付防重复点击
				info: {
					userName: '', // 甲方姓名
					productName: '', // 产品名称
					price: 0, // 签约金额
					orderCode: '', // 协议号
					signDate: '', // 签约时间
				}
			};
		},
		methods: {
			async init() {
				

			},
			goHome(){
				uni.redirectTo({
					url: `/pages/index/index`
				});
			},
			// 查看订单
			viewOrder() {
				uni.redirectTo({
					url: `/pages/order/order`
				});
			}
		}
	};
</script>

<style lang="scss" scoped>
	.container {
		background-color: #ffffff;
		padding: 0 74rpx;
		min-height: 100vh;
		box-sizing: border-box;
		position: relative;
		display: flex;
		flex-direction: column;
	}

	.content-container {
		.top {
			display: flex;
			flex-direction: column;
			justify-content: center;
			align-items: center;
			text-align: center;

			image {
				width: 100rpx;
				height: 100rpx;
				margin-bottom: 40rpx;
			}

			.title {
				font-weight: 800;
				font-size: 32rpx;
				color: #000000;
				margin-bottom: 40rpx;
				text-align: center;
			}
		}
	}

	.desc {
		margin: 116rpx 26rpx;

		.desc-head {
			display: flex;
			flex-direction: row;
			align-items: center;

			.desc-icon {
				width: 6rpx;
				height: 28rpx;
				background: #4A63E4;
				border-radius: 3rpx;
				margin-right: 24rpx;
			}

			.desc-title {
				font-weight: bold;
				font-size: 32rpx;
				color: #2C2C2C;
			}
		}

		.desc-content {
			margin-top: 52rpx;

			.content-item {
				display: flex;
				flex-direction: row;
				align-items: center;
				margin-bottom: 20rpx;

				.list-icon {
					width: 12rpx;
					height: 12rpx;
					background: #4A63E4;
					border-radius: 50%;
					margin-right: 18rpx;
				}

				.text {
					font-weight: bold;
					font-size: 26rpx;
					color: #5B5B5B;
				}
			}
		}

	}

	.btn-group {
		display: flex;
		flex-direction: column;
		gap: 22rpx;
		margin-top: 130rpx;
	}
</style>