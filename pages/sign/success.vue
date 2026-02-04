<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<view class="content-container">
			<view class="top">
				<image src="/static/icons/sign-success.png" mode="widthFix"></image>
				<text class="title">签约成功！</text>
			</view>

			<view class="info">
				<view class="item">
					<text class="label">甲方名称</text>
					<text class="value">{{ info.userName }}</text>
				</view>

				<view class="item">
					<text class="label">产品名称</text>
					<text class="value">{{ info.productName }}</text>
				</view>

				<view class="item">
					<text class="label">签约金额</text>
					<text class="value">￥{{ info.price }}</text>
				</view>

				<view class="item">
					<text class="label">协议号</text>
					<text class="value">{{ info.orderCode }}</text>
				</view>

				<view class="item">
					<text class="label">签约时间</text>
					<text class="value">{{ info.signDate }}</text>
				</view>
			</view>

			<view class="desc">
				<view class="desc-head">
					<view class="desc-icon"></view>
					<text class="desc-title">后续步骤</text>
				</view>
				<view class="desc-content">
					<view class="content-item">
						<view class="list-icon"></view>
						<text class="text">您可以随时查看业务进度</text>
					</view>
					<view class="content-item">
						<view class="list-icon"></view>
						<text class="text">胎盘接受后将实时接收更新状态送</text>
					</view>
					<view class="content-item">
						<view class="list-icon"></view>
						<text class="text">重要通知将通过微信服务通知推送</text>
					</view>
				</view>

			</view>

		</view>

		<!-- 按钮组容器 -->
		<view class="btn-group">
			<u-button :custom-style="primaryBtnStyle" @click="toPay">
				去支付
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
				this.info.userName = this.user.nickName;
				
				// 获取产品信息
				const productId = 1; // 固定值 1
				const res = await api.getProductById(productId);
				if (res.code == 200) {
					const data = res.data || {};
					this.info.productName = data.productName || '';
				}
				
				// 获取合同信息
				const result = await api.getFdpOrder(this.orderId);
				if (result.code == 200 && result.rows.length > 0) {
					const order = result.rows[0];
					
					this.info.price = order.priceOut;
					this.info.orderCode = order.orderCode; // 协议号
					this.info.signDate = order.signDate;
				}

			},
			// 去支付
			async toPay() {
				if (!this.orderId) {
					uni.showToast({
						title: '订单信息缺失',
						icon: 'none'
					});
					return;
				}

				// 防止重复点击
				if (this.paying) return;
				this.paying = true;

				try {
					// 1. 调用后端接口，获取微信支付参数
					const res = await api.createPayment(this.orderId);

					if (res.code !== 200 || !res.data) {
						uni.showToast({
							title: res.msg || '获取支付参数失败',
							icon: 'none'
						});
						return;
					}

					const payData = res.data;

					// 2. 调起微信支付
					const paymentResult = await uni.requestPayment({
						timeStamp: String(payData.timeStamp),
						nonceStr: payData.nonceStr,
						package: payData.package,
						signType: payData.signType || 'MD5',
						paySign: payData.paySign
					});

					// 3. 支付成功
					uni.showToast({
						title: '支付成功！',
						icon: 'success'
					});

					// 跳转到支付成功页
					setTimeout(() => {
						uni.redirectTo({
							url: '/pages/sign/pay-success?orderId=' + this.orderId
						});
					}, 1500);

				} catch (err) {
					// 支付失败或用户取消
					console.error('支付失败:', err);

					// err.errMsg 可能包含 "requestPayment:fail cancel"（用户取消）
					if (err.errMsg && err.errMsg.includes('cancel')) {
						uni.showToast({
							title: '已取消支付',
							icon: 'none'
						});
					} else {
						uni.showToast({
							title: '支付失败，请重试',
							icon: 'none'
						});
					}
				} finally {
					this.paying = false
				}
			},
			// 查看订单
			viewOrder() {
				uni.navigateTo({
					url: `/pages/order/detail?orderId=${this.orderId}`
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

	.info {
		background: #F6F7FC;
		border-radius: 40rpx;
		padding: 0 60rpx;
		box-sizing: border-box;
		padding-top: 50rpx;

		.item {
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding-bottom: 50rpx;

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
		margin-bottom: 130rpx;
	}
</style>