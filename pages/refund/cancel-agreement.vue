<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" title="解除协议签署" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<view class="content-container">
			<view class="info">
				<view class="item">
					<text class="label">协议编号：</text>
					<text class="value">{{ orderCode }}</text>
				</view>


			</view>
		</view>

		<!-- 		<view class="content">
			<view class="content-head">
				<view class="content-head-icon"></view>
				<text class="content-head-title">请仔细阅读协议内容，确认无误后进行签署</text>
			</view>
			<scroll-view class="content-container" scroll-y="true">
				<view class="auth-content">
					<text class="title">人民医疗胎盘冻干粉储存服务解除协议</text>
					<text class="paragraph">
						欢迎您使用本平台提供的孕产服务。请您仔细阅读以下条款，特别是免除或者限制责任的条款、法律适用和争议解决条款。
						当您勾选“已阅读并同意”时，即表示您已充分理解并接受本协议全部内容。
					</text>
				</view>
			</scroll-view>

		</view> -->


		<view class="btn-group">
			<u-button :custom-style="primaryBtnStyle" @click="toSign">
				去签字
			</u-button>
			<u-button :custom-style="secondaryBtnStyle" @click="goPrev">
				取消
			</u-button>
		</view>

		<view class="desc">
			<text class="text">提交后，您的解除协议将生效，退款将在7个工作日内处理。</text>
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
					backgroundImage: 'url(/static/images/sign-btn.png)',
					backgroundSize: 'auto',
					backgroundRepeat: 'no-repeat',
					backgroundPosition: 'center',
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
			if (options.orderCode) {
				this.orderCode = options.orderCode;
			}
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
				orderCode: '', // 协议号
				isSigning: false, // 标记是否刚从签署页返回
				orderInfo: {},
				userInfo: {}, // 甲方信息
			};
		},
		methods: {
			async init() {
				// 1. 获取产妇和甲方信息
				const result = await api.getMotherAndUser();
				if (result.code !== 200) {
					uni.showToast({
						title: '甲方信息加载失败',
						icon: 'none'
					});
					return;
				}

				this.userInfo = result.user || {};
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
				if (!this.userInfo.nickName || !this.userInfo.phonenumber) {
					uni.showToast({
						title: "获取甲方信息失败",
						icon: 'none'
					});
					return;
				}

				const orderId = this.orderId;
				const params = {
					orderId: orderId,
					returnURL: api.signReturnUrl,
					signType: '2', // 签约=1，解约=2
					signerName: this.userInfo.nickName, // 签约甲方的姓名
					signerPhone: this.userInfo.phonenumber, // 签约甲方的手机号
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
			toSign() {
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
		margin-top: 74rpx;
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
			//margin-bottom: 40rpx;

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