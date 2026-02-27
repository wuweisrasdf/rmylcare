<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" title="解除协议签署" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<view class="content-container">
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
					<text class="label">协议编号：</text>
					<text class="value">{{ info.orderCode }}</text>
				</view>


			</view>
		</view>



		<view class="btn-group">
			<u-button :custom-style="primaryBtnStyle" @click="toSign" :disabled="!canSign">
				去签字
			</u-button>
			<u-button :custom-style="secondaryBtnStyle" @click="goPrev">
				取消
			</u-button>
		</view>

		<view class="desc">
			<text class="text">提交后，您的解除协议将生效，退款将在10个工作日内处理。</text>
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
		onShow() {

		},
		data() {
			return {
				orderId: '', // 订单id
				isSigning: false, // 标记是否刚从签署页返回
				orderInfo: {},
				userInfo: {}, // 甲方信息
				canSign: false, // 是否可以签署解除协议
				info: {
					userName: '', // 甲方姓名
					userPhone: '', // 甲方手机
					productName: '', // 产品名称
					price: 0, // 签约金额
					orderCode: '', // 协议号
					signDate: '', // 签约时间
				}
			};
		},
		methods: {
			async init() {
				// 获取产品信息
				const productId = 1; // 固定值 1
				const res = await api.getProductById(productId);
				if (res.code == 200) {
					const data = res.data || {};
					this.info.productName = data.productName || '';
				}
				
				// 2. 获取订单信息
				const orderRes = await api.getFdpOrder(this.orderId);
				if (orderRes.code !== 200) {
					uni.showToast({
						title: '订单信息加载失败',
						icon: 'none'
					});
					return;
				}
				
				const row = (Array.isArray(orderRes.rows) && orderRes.rows.length > 0) ? orderRes.rows[0] : {};
				this.orderInfo = row;
				this.info.price = row.priceOut;
				this.info.orderCode = row.orderCode; // 协议号
				this.info.signDate = row.signDate;
				this.info.userName = row.userName;
				this.info.userPhone = row.phonenumber;
				if (!row.signReturnDate) {
					this.canSign = true;
				}
			},
			goPrev() {
				uni.navigateBack();
			},
			goHome() {
				uni.redirectTo({
					url: "/pages/index/index"
				})
			},
			// 获取签名URL
			async getSignUrl() {
				if (!this.info.userName || !this.info.userPhone) {
					uni.showToast({
						title: "获取甲方信息失败",
						icon: 'none'
					});
					return;
				}

				const orderId = this.orderId;
				const params = {
					orderId: orderId,
					//returnURL: api.signReturnUrl,
					returnURL: '',
					signType: '2', // 签约=1，解约=2
					signerName: this.info.userName, // 签约甲方的姓名
					signerPhone: this.info.userPhone, // 签约甲方的手机号
				}

				uni.showLoading({
					title: '正在生成签署链接...',
					mask: true // 防止用户点击穿透
				});

				try {
					const res = await api.getSignUrl(params);

					uni.hideLoading();

					if (res.code == 200) {
						console.log('getSignUrl:', res)
						if (res.signUrl) {
							this.isSigning = true; // 标记即将进入签署流程
							uni.navigateTo({
								url: `/pages/sign/signature?signUrl=${encodeURIComponent(res.signUrl)}&orderId=${this.orderId}&type=2`
							});
							return;
						}
					}
				} catch (err) {
					uni.hideLoading();

					console.log("签名失败：", err)
					uni.showToast({
						title: "甲方签名或手机号错误",
						icon: 'none'
					});
				}
			},
			// 去签字
			async toSign() {
				if (!this.canSign) {
					return;
				}
				
				let refundParams = {
					orderId: this.orderId,
					price: this.info.price,
					status: 0
				}
				const refundRes = await api.createRefund(refundParams);
				if (refundRes.code != 200) {
					uni.showToast({
						title: "生成解约协议失败",
						icon: 'none'
					});
					
					return;
				}
				
				this.isSigning = true;
				this.getSignUrl();

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
		flex: 1;
		padding: 40rpx 30rpx;
		box-sizing: border-box;
	}

	.info {
		background: #F6F7FC;
		border-radius: 40rpx;
		padding: 50rpx 40rpx;
		box-sizing: border-box;
		margin-bottom: 80rpx;

		.item {
			display: flex;
			justify-content: space-between;
			align-items: center;
			margin-bottom: 50rpx;

			.label {
				font-weight: 500;
				font-size: 30rpx;
				color: #727272;
			}

			.value {
				font-weight: 800;
				font-size: 30rpx;
				color: #151515;
				flex: 1;
				text-align: right;
			}
		}
		
		.item:last-child {
		    margin-bottom: 0;
		}

		.divider {
			height: 2rpx;
			background: #161421;
			opacity: 0.1;
			margin-bottom: 40rpx;
		}

		.price-section {
			display: flex;
			flex-direction: column;
			align-items: flex-end;
		}

		.price {
			font-weight: 800;
			font-size: 44rpx;
			color: #4A63E2;
		}
	}

	.payment-type {
		width: 100%;
		text-align: right;
		//font-weight: 500;
		font-size: 24rpx;
		color: #4A63E2;
		margin-top: -10rpx;
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
		margin: 70rpx auto;
		text-align: center;

		.text {
			font-weight: 500;
			font-size: 24rpx;
			color: #2449FF;
		}
	}

	.btn-group {
		display: flex;
		flex-direction: column;
		gap: 22rpx;
	}


</style>