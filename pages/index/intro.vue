<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<view class="content-container">
			<text>产品宣传页</text>
		</view>

		<view class="btn-wrapper">
			<u-button class="next-btn" :custom-style="nextBtnStyle" @click="handleNext">
				下一步
			</u-button>
		</view>
	</view>
</template>

<script>
	export default {
		computed: {
			// 计算容器顶部内边距（转为 rpx）
			containerPaddingTop() {
				// CustomBar 是 px，uni-app 中 1px = 2rpx
				const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
				console.log(barHeight)
				return barHeight;
			},
			// 按钮自定义样式（uView2 推荐用 custom-style）
			nextBtnStyle() {
				return {
					height: '98rpx',
					borderRadius: '49rpx',
					backgroundColor: '#4A63E4',
					fontWeight: 'bold',
					fontSize: '32rpx',
					color: '#FFFFFF'
				};
			}
		},
		data() {
			return {

			};
		},
		onLoad() {

		},
		methods: {
			handleNext() {

				uni.navigateTo({
					url: '/pages/sign/guide'
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
		/* 主轴为垂直方向 */
	}

	.content-container {
		flex: 1;
		background-color: #f0f4ff;
		/* 默认占位背景色 */
		border-radius: 20rpx;
		margin-bottom: 260rpx;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.btn-wrapper {
		position: absolute;
		bottom: 98rpx;
		/* 距离页面底部 98rpx */
		left: 26rpx;
		right: 26rpx;
		height: 98rpx;
	}
</style>