<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<view class="content-container">
			<view class="top">
				<image src="/static/icons/refund.png" mode="widthFix"></image>
				<text class="title">退款处理中</text>
				<text class="top-desc">您的退款申请已提交，正在处理中</text>
			</view>

			<view class="info">
				<view class="item">
					<text class="label">退款详情</text>
					<text class="value"></text>
				</view>
				<view class="bottom-line"></view>
				<view class="item">
					<text class="label">退款金额</text>
					<text class="value">￥18000.00</text>

				</view>
				<view class="bottom-line"></view>
				<view class="item">
					<text class="label">退款方式</text>
					<text class="value">原路返回</text>
				</view>
				<view class="bottom-line"></view>

				<view class="item">
					<text class="label">申请时间</text>
					<text class="value">2026-02-15</text>
				</view>
			</view>

		</view>

		<!-- 按钮组容器 -->
		<view class="btn-group">
			<u-button :custom-style="primaryBtnStyle" @click="viewStatus">
				查看退款进度
			</u-button>

			<u-button :custom-style="secondaryBtnStyle" @click="goHome">
				返回首页
			</u-button>
		</view>

		<view class="desc">
			<text class="text">
				退款将原路返回至您的支付账户。如在预计时间内未收到退款，请联系客服。
			</text>
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
					color: '#FFFFFF',
					fontWeight: 'bold',
					fontSize: '32rpx',
					display: 'flex',
					justifyContent: 'center',
					alignItems: 'center',
					border: 'none',
					padding: '0 20rpx',
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
				info: {
					userName: '', // 甲方姓名
					productName: '', // 产品名称
					price: 0, // 签约金额
					orderCode: '', // 协议号
					payDate: '', // 支付时间
				}
			};
		},
		methods: {
			async init() {


			},
			viewStatus() {
				uni.redirectTo({
					url: `/pages/refund/status?orderId=${this.orderId}`
				});
			},
			goHome() {
				uni.redirectTo({
					url: `/pages/index/index`
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
		flex: 1;

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

			.top-desc {
				font-weight: 500;
				font-size: 28rpx;
				color: #848484;
				margin-bottom: 40rpx;
			}
		}
	}

	.info {
		background: #F6F7FC;
		border-radius: 40rpx;
		padding: 0 60rpx;
		box-sizing: border-box;
		padding-top: 40rpx;
		padding-bottom: 40rpx;

		.item {
			display: flex;
			justify-content: space-between;
			align-items: center;

			.label {
				font-weight: 500;
				font-size: 28rpx;
				color: #B0B0B0;
			}

			.value {
				font-weight: 500;
				font-size: 28rpx;
				color: #151515;
				flex: 1;
				text-align: right;
			}
		}

		// 分隔线样式
		.bottom-line {
			height: 2rpx;
			background: #161421;
			opacity: 0.1;
			margin: 30rpx 0;
		}

		.item:first-child {
			.label {
				color: #000000; // 或简写为 #000
			}
		}


	}


	.desc {
		margin: 70rpx auto;
		text-align: left;

		.text {
			font-weight: 500;
			font-size: 26rpx;
			color: #7A7A7A;
		}
	}

	.btn-group {
		display: flex;
		flex-direction: column;
		gap: 22rpx;
	}
</style>