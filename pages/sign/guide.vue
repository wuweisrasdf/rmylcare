<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<view class="content-container">
			<!-- 签约须知 - 替换原有的top -->
			<view class="notice-header">
				<view class="notice-header-content">
					<view class="notice-title-container">
						<text class="notice-title-main">签约须知</text>

					</view>
					<view class="notice-desc">
						请确保您已准备好证件号、手机号等必要信息。整个签约过程约需5-10分钟。
					</view>
				</view>
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
					border: '2px solid rgba(142,142,142,0.5)',
					backgroundColor: 'transparent',
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
		display: flex;
		flex-direction: column;
	}

	.content-container {
		flex: 1;
		padding-bottom: 40rpx;
	}

	/* 签约须知头部 - 美化样式 */
	.notice-header {

		text-align: center;
		margin: 30rpx 0 50rpx 0;
		padding: 0 20rpx;

		.notice-header-content {
			position: relative;
			z-index: 2;
		}

		.notice-title-container {
			margin-bottom: 24rpx;

			.notice-title-main {
				font-weight: 800;
				font-size: 40rpx;
				color: #2C2C2C;
				margin-bottom: 24rpx;
				position: relative;
				display: inline-block;

				&::after {
					content: '';
					position: absolute;
					bottom: -12rpx;
					left: 50%;
					transform: translateX(-50%);
					width: 60rpx;
					height: 4rpx;
					background: linear-gradient(90deg, transparent, #4A63E4, transparent);
					border-radius: 2rpx;
				}
			}


		}

		.notice-desc {
			font-size: 28rpx;
			color: #5B5B5B;
			line-height: 48rpx;
			padding: 0 30rpx;
		}

		/* 装饰元素 */
		.notice-decoration {
			position: absolute;
			top: 0;
			right: 0;
			bottom: 0;
			width: 200rpx;
			pointer-events: none;

			.decoration-circle {
				position: absolute;
				top: -30rpx;
				right: -30rpx;
				width: 160rpx;
				height: 160rpx;
				border-radius: 50%;
				background: linear-gradient(135deg, rgba(74, 99, 228, 0.1) 0%, rgba(74, 99, 228, 0.05) 100%);
				z-index: 1;
			}

			.decoration-line {
				position: absolute;
				bottom: 30rpx;
				right: 40rpx;
				width: 80rpx;
				height: 4rpx;
				background: linear-gradient(90deg, #4A63E4 0%, rgba(74, 99, 228, 0.2) 100%);
				border-radius: 2rpx;
				transform: rotate(-15deg);
			}
		}
	}

	.steps {
		margin-bottom: 40rpx;

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
		}
	}

	/* 按钮组 */
	.btn-group {
		margin: 30rpx 0 50rpx 0;
		display: flex;
		flex-direction: column;
		gap: 24rpx;
	}
</style>