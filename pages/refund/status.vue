<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" title="退款状态查询" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<view class="content-container">
			<view class="info">
				<view class="item">
					<text class="label">退款金额</text>
					<text class="refund-btn">退款中</text>
				</view>
				<view class="item">
					<text class="label price">￥18000.00</text>
					<text class="value"> </text>
				</view>
				<view class="bottom-line"></view>

				<view class="item">
					<text class="label">退款订单</text>
					<text class="value">df242534674</text>
				</view>
				<view class="bottom-line"></view>

				<view class="item">
					<text class="label">申请时间</text>
					<text class="value">2026-02-12 14:00</text>
				</view>
				<view class="bottom-line"></view>

				<view class="item">
					<text class="label">退款方式</text>
					<text class="value">原路返回</text>
				</view>

			</view>
		</view>

		<view class="btn-group">
			<u-button :custom-style="primaryBtnStyle" @click="viewOrder">
				返回订单查询
			</u-button>
			<u-button :custom-style="secondaryBtnStyle" @click="goHome">
				返回首页
			</u-button>
		</view>

		<view class="desc">
			<text class="text">提示：退款通常在审批通过后的10个工作日内到账。</text>
			<text class="text">如有疑问，请联系客服。</text>
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
				orderId: '', // 订单id
			};
		},
		methods: {
			async init() {},
			viewOrder() {
				uni.redirectTo({
					url: "/pages/order/order"
				})
			},
			goHome() {
				uni.redirectTo({
					url: "/pages/index/index"
				})
			}
		}
	};
</script>

<style lang="scss" scoped>
	.container {
		background-color: #ffffff;
		padding: 0 26rpx;
		min-height: 100vh;
		box-sizing: border-box;
		position: relative;
		display: flex;
		flex-direction: column;
	}

	.content-container {
		flex-grow: 1;
		padding-top: 76rpx;

		.info {
			background: #F6F7FC;
			border-radius: 40rpx;
			padding: 40rpx;
			box-sizing: border-box;

			.item {
				display: flex;
				justify-content: space-between;
				align-items: center;
				padding: 30rpx 0;

				.label {
					font-weight: 500;
					font-size: 28rpx;
					color: #727272;
				}

				.value {
					font-weight: 500;
					font-size: 28rpx;
					color: #000000;
					flex: 1;
					text-align: right;
				}

				.price {
					font-weight: 800;
					font-size: 48rpx;
					color: #4A63E2;
					line-height: 1.2;
				}
			}

			.item:first-child {
				padding-top: 0;
				padding-bottom: 0;
			}

			.item:last-child {
				padding-bottom: 0;
			}

			.bottom-line {
				width: 100%;
				height: 2rpx;
				background: #161421;
				opacity: 0.1;
			}

		}
	}

	.refund-btn {
		background-image: url('/static/images/refund-btn.png');
		background-size: 100% 100%;
		font-weight: 500;
		font-size: 26rpx;
		color: #FFFFFF;
		width: 162rpx;
		height: 54rpx;
		text-align: center;
		line-height: 54rpx;
	}



	.desc {
		padding:70rpx 30rpx;
		text-align: left;

		.text {
			font-weight: bold;
			font-size: 28rpx;
			color: #979797;
			line-height: 54rpx;
		}
	}

	.btn-group {
		display: flex;
		flex-direction: column;
		gap: 22rpx;
	}
</style>