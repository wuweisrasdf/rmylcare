<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<view class="content-container">
			<view class="top">
				<image src="/static/icons/sign-success.png" mode="widthFix"></image>
				<text class="title">支付成功！</text>
			</view>

			<view class="info">
				<view class="item">
					<text class="label">甲方名称</text>
					<text class="value">张三</text>
				</view>

				<view class="item">
					<text class="label">产品名称</text>
					<text class="value">胎盘冻干粉</text>
				</view>

				<view class="item">
					<text class="label">签约金额</text>
					<text class="value">￥19800</text>
				</view>

				<view class="item">
					<text class="label">协议号</text>
					<text class="value">D356834</text>
				</view>

				<view class="item">
					<text class="label">支付时间</text>
					<text class="value">2026-02-16 15:00</text>
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
			<u-button :custom-style="secondaryBtnStyle" @click="">
				查看订单
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
		
		.desc-content{
			margin-top:52rpx;
			.content-item{
				display: flex;
				flex-direction: row;
				align-items: center;
				margin-bottom: 20rpx;
				.list-icon{
					width: 12rpx;
					height: 12rpx;
					background: #4A63E4;
					border-radius: 50%;
					margin-right: 18rpx;
				}
				.text{
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