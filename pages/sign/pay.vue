<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<view class="content-container">
			<view class="top">
				<image src="/static/icons/guide-top.png" mode="widthFix"></image>
				<text class="title">准备跳转至微信支付</text>
			</view>

			<view class="info">
				<view class="item">
					<text class="label">产品名称</text>
					<text class="value">胎盘冻干粉</text>
				</view>

				<!-- 分隔线 -->
				<view class="divider"></view>

				<view class="item">
					<text class="label">支付金额</text>
					<view class="price-section">
						<text class="price">¥19800.00</text>
					</view>
				</view>

				<view class="divider"></view>

				<view class="item">
					<text class="label">支付方式</text>
					<text class="value">微信支付</text>
				</view>
			</view>
			
			<view class="desc">
				<text class="desc-text">
					系统将自动跳转至微信支付界面，请完成支付操作。
					支付成功后将自动返回。
				</text>
			</view>
			
		</view>

		<!-- 按钮组容器 -->
		<view class="btn-group">
			<u-button class="secondary-btn" :custom-style="secondaryBtnStyle" @click="goPrev">
				返回修改
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
	}

	.info {
		background: #F6F7FC;
		border-radius: 40rpx;
		padding: 30rpx 60rpx;
		box-sizing: border-box;

		.item {
			display: flex;
			justify-content: space-between;
			align-items: center;

			.label {
				font-weight: 500;
				font-size: 28rpx;
				color: #888888;
			}

			.value {
				font-weight: bold;
				font-size: 28rpx;
				color: #151515;
				flex: 1;
				text-align: right;
			}
		}

		.divider {
			height: 2rpx;
			background: #161421;
			opacity: 0.1;
			margin: 30rpx 0;
		}

		.price-section {
			display: flex;
			flex-direction: column;
			align-items: flex-end;
		}

		.price {			
			font-weight: bold;
			font-size: 36rpx;
			color: #4A63E2;
		}
	}
	
	.desc{
		margin: 100rpx auto;
		font-weight: bold;
		font-size: 26rpx;
		color: #5B5B5B;
		line-height: 52rpx;
	}

	.btn-group {
		bottom: 98rpx;
		display: flex;
		flex-direction: column;
	}
</style>