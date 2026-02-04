<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<view class="content-container">
			<view class="top">
				<image src="/static/icons/guide-top.png" mode="widthFix"></image>
				<text class="title">线上签约</text>
				<text class="subtitle">简单三部，快速完成签约流程</text>
			</view>
			<view class="steps">
				<!-- 步骤1 -->
				<view class="step-item">
					<view class="step-icon">
						<image src="/static/icons/guide-edit.png" mode="widthFix"></image>
					</view>
					<view class="step-content">
						<view class="step-top"><text>第1步</text></view>
						<text class="step-title">填写信息</text>
						<text class="step-desc">输入产妇和甲方的基本信息</text>
					</view>
				</view>

				<!-- 步骤2 -->
				<view class="step-item">
					<view class="step-icon">
						<image src="/static/icons/guide-book.png" mode="widthFix"></image>
					</view>
					<view class="step-content">
						<view class="step-top"><text>第2步</text></view>
						<text class="step-title">阅读协议</text>
						<text class="step-desc">仔细阅读电子协议内容</text>
					</view>
				</view>

				<!-- 步骤3 -->
				<view class="step-item">
					<view class="step-icon">
						<image src="/static/icons/guide-signature.png" mode="widthFix"></image>
					</view>
					<view class="step-content">
						<view class="step-top"><text>第3步</text></view>
						<text class="step-title">手写签名</text>
						<text class="step-desc">手写签名并确认支付</text>
					</view>
				</view>
			</view>

			<view class="notice">
				<text class="notice-title">签约须知</text>
				<text class="notice-desc">请确保您已准备好证件号、手机号等必要信息。整个签约过程约需5-10分钟。</text>
			</view>

		</view>

		<!-- 按钮组容器 -->
		<view class="btn-group">
			<u-button class="primary-btn" :custom-style="primaryBtnStyle" @click="handleStart">
				开始签约
			</u-button>

			<u-button class="secondary-btn" :custom-style="secondaryBtnStyle" @click="goHome">
				返回首页
			</u-button>
		</view>
	</view>
</template>

<script>
	export default {
		computed: {
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
					// 注意：uView 的 custom-style 中 border 需写完整
					border: '2px solid rgba(142,142,142,0.5)',
					backgroundColor: 'transparent', // 透明背景
					fontWeight: 'bold',
					fontSize: '32rpx',
					color: '#3D3D3D'
				};
			}
		},
		methods: {
			handleStart() {
				uni.navigateTo({
					url: "/pages/sign/form"
				})
			},
			goHome() {
				uni.reLaunch({
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
		flex: 1;
		margin-bottom: 400rpx;

		.top {
			display: flex;
			flex-direction: column;
			justify-content: center;
			align-items: center;
			text-align: center;
			margin-bottom: 54rpx;

			image {
				width: 100rpx;
				height: 100rpx;
				margin-bottom: 44rpx;
			}

			.title {
				font-weight: 800;
				font-size: 36rpx;
				color: #000000;
				margin-bottom: 38rpx;
			}

			.subtitle {
				font-weight: 500;
				font-size: 28rpx;
				color: #707070;
			}
		}

		.steps {
			margin-bottom: 86rpx;

			.step-item {
				background: #F6F7FC;
				border-radius: 40rpx;
				padding: 46rpx 42rpx;
				margin-bottom: 32rpx;
				display: flex;
				align-items: center;
				position: relative;

				&:last-child {
					margin-bottom: 0;
				}

				.step-icon {
					width: 96rpx;
					height: 96rpx;
					margin-right: 48rpx;

					image {
						width: 100%;
						height: 100%;
					}
				}

				.step-content {
					flex: 1;
					display: flex;
					flex-direction: column;
					
					.step-top {
					  width: 101rpx;
					  height: 41rpx;
					  background: rgba(74, 99, 226, 0.1);
					  border-radius: 20rpx;
					  display: flex;
					  justify-content: center;
					  align-items: center;
					  margin-bottom: 32rpx;
					  text {
					    font-weight: bold;
					    font-size: 22rpx;
					    color: #2643D8;
					  }
					}

					.step-title {
						font-size: 32rpx;
						font-weight: bold;
						color: #000000;
						margin-bottom: 32rpx;
					}

					.step-desc {
						font-size: 28rpx;
						color: #868686;
					}
				}

				/* 步骤标签 */
				.step-label {
					position: absolute;
					top: 16rpx;
					left: 120rpx;
					width: 72rpx;
					height: 32rpx;
					background-color: #E6E8F5;
					border-radius: 16rpx;
					display: flex;
					justify-content: center;
					align-items: center;
					font-size: 22rpx;
					color: #7B83C2;
				}
			}
		}

		.notice {
			display: flex;
			flex-direction: column;
			.notice-title {
				font-weight: bold;
				font-size: 32rpx;
				color: #2C2C2C;
				margin-bottom: 36rpx;
			}

			.notice-desc {
				font-weight: bold;
				font-size: 26rpx;
				color: #5B5B5B;
				line-height: 52rpx;
			}
		}
	}

	/* 按钮组：整体定位到底部 */
	.btn-group {
		position: absolute;
		bottom: 98rpx;
		/* 距离页面底部 98rpx */
		left: 26rpx;
		right: 26rpx;
		display: flex;
		flex-direction: column;
		gap: 24rpx;
		/* 两个按钮之间的间距 */
	}
</style>