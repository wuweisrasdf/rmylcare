<template>
	<view class="container">
		<!-- 导航栏 -->
		<u-navbar 
			:fixed="true" 
			:autoBack="true" 
			title="重要文件待您确认" 
			leftIconSize="36" 
			leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }" 
			:safeAreaInsetTop="true"
		/>

		<!-- 内容区域 -->
		<!-- 关键修改：添加 :style 动态设置 paddingTop，防止被导航栏遮挡 -->
		<view class="content-wrapper" :style="{ paddingTop: navBarHeight + 'px' }">
			
			<!-- 引导文案：去掉左右边距 -->
			<view class="guide-text">
				<view class="guide-content">
					<u-icon name="info-circle" size="36" color="#67C23A"></u-icon>
					<text class="ml-20">为了保障您的合法权益，我们需要您花一点时间了解协议细节。请轻轻向下滑动，查看完整的合同。当您看到页面底部时，即可继续办理后续步骤。</text>
				</view>
			</view>

			<view class="image-list">
				<view v-for="(item, index) in loadedImages" :key="index" class="image-item">
					<image 
						:src="item.url" 
						mode="widthFix" 
						style="width: 100%; display: block; background-color: #f0f0f0;" 
						@load="onImageLoad" 
						@error="onImageError(index)"
					></image>
				</view>

				<view v-if="loadingMore" class="loading-more">
					<u-loading-icon mode="circle" size="28" color="#909399"></u-loading-icon>
					<text class="ml-20">加载更多图片...</text>
				</view>
				
				<!-- 底部垫高 -->
				<view style="height: 200rpx;"></view>
			</view>
		</view>

		<!-- 悬浮进度球 -->
		<view class="progress-tip" v-if="hasStartedScrolling && !hasReadComplete">
			<view class="progress-card">
				<view class="progress-header">
					<text class="progress-label">阅读进度</text>
					<text class="progress-value">{{ scrollProgress }}%</text>
				</view>
				<view class="progress-track">
					<view class="progress-fill" :style="{ width: scrollProgress + '%' }"></view>
				</view>
				<text class="progress-sub">还剩 {{ remainingPercent }}% 即可完成</text>
			</view>
		</view>

		<!-- 底部固定按钮 -->
		<view class="btn-group">
			<u-button :custom-style="prevBtnStyle" @click="goPrev">上一步</u-button>
			<view class="next-btn-wrapper">
				<view class="unlock-tip" v-if="!hasReadComplete">
					<u-icon name="lock" size="28" color="#FFFFFF"></u-icon>
					<text>阅读完合同后方可继续</text>
				</view>
				<u-button :custom-style="nextBtnStyle" @click="nextPage" :disabled="!hasReadComplete">
					{{ hasReadComplete ? '阅读完成，点击继续' : '阅读中...' }}
				</u-button>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		computed: {
			prevBtnStyle() {
				return {
					height: '98rpx',
					borderRadius: '49rpx',
					backgroundColor: '#FFFFFF',
					border: '2px solid rgba(142,142,142,0.5)',
					color: '#3D3D3D',
					fontSize: '32rpx',
					fontWeight: 'bold',
					marginRight: '26rpx',
					width: '200rpx',
				};
			},
			nextBtnStyle() {
				return {
					height: '98rpx',
					borderRadius: '49rpx',
					backgroundColor: this.hasReadComplete ? '#4A63E4' : '#D1D6F5',
					color: '#FFFFFF',
					fontSize: '32rpx',
					fontWeight: 'bold',
					width: '100%',
					border: 'none'
				};
			},
			remainingPercent() {
				return Math.max(0, 100 - this.scrollProgress);
			},
			hasStartedScrolling() {
				return this.scrollProgress > 0;
			}
		},

		data() {
			return {
				orderId: 0,
				allImages: [
					'https://dhm-test.rmylcare.com/uploadPath/download/contract_image/1.jpg',
					'https://dhm-test.rmylcare.com/uploadPath/download/contract_image/2.jpg',
					'https://dhm-test.rmylcare.com/uploadPath/download/contract_image/3.jpg',
					'https://dhm-test.rmylcare.com/uploadPath/download/contract_image/4.jpg',
					'https://dhm-test.rmylcare.com/uploadPath/download/contract_image/5.jpg',
					'https://dhm-test.rmylcare.com/uploadPath/download/contract_image/6.jpg',
					'https://dhm-test.rmylcare.com/uploadPath/download/contract_image/7.jpg',
					'https://dhm-test.rmylcare.com/uploadPath/download/contract_image/8.jpg',
					'https://dhm-test.rmylcare.com/uploadPath/download/contract_image/9.jpg',
					'https://dhm-test.rmylcare.com/uploadPath/download/contract_image/10.jpg'
				],
				loadedImages: [],
				scrollProgress: 0,
				hasReadComplete: false,
				loadingMore: false,
				
				// 滚动相关数据
				windowHeight: 0,
				contentHeight: 0,
				currentScrollTop: 0,
				navBarHeight: 0, // 新增：存储导航栏高度 (px)
				resizeTimer: null
			};
		},

		onLoad(options) {
			const systemInfo = uni.getSystemInfoSync();
			this.windowHeight = systemInfo.windowHeight;

			// 计算导航栏高度用于占位
			// u-navbar 默认高度通常是 44px (状态栏) + 44px (导航栏) = 88px 左右，具体取决于机型
			// 这里我们简单估算或使用 uni.getMenuButtonBoundingClientRect 获取更精确值
			// 为了兼容性，直接使用状态栏高度 + 默认导航高度 (44px)
			const statusBarHeight = systemInfo.statusBarHeight || 0;
			// 假设导航栏主体高度为 44px (标准值)，如有自定义需调整
			this.navBarHeight = statusBarHeight + 44; 

			if (options.orderId) {
				this.orderId = options.orderId;
			}

			this.loadedImages = this.allImages.map((url, index) => ({
				url,
				index,
				loaded: false,
				error: false,
			}));
			
			setTimeout(() => {
				this.updateContentHeight();
			}, 300);
		},

		onPageScroll(e) {
			this.currentScrollTop = e.scrollTop;
			this.calculateProgress();
		},

		onReachBottom() {
			this.checkCompletion();
		},

		methods: {
			updateContentHeight() {
				uni.createSelectorQuery().in(this).select('.content-wrapper').boundingClientRect((data) => {
					if (data && data.height) {
						this.contentHeight = data.height;
						this.calculateProgress();
					}
				}).exec();
			},

			calculateProgress() {
				if (!this.contentHeight || this.contentHeight <= this.windowHeight) {
					if (this.contentHeight > 0) {
						this.scrollProgress = 100;
						this.hasReadComplete = true;
					}
					return;
				}

				const maxScroll = this.contentHeight - this.windowHeight;
				let progress = (this.currentScrollTop / maxScroll) * 100;

				if (this.currentScrollTop >= maxScroll - 10) {
					progress = 100;
				}

				progress = Math.min(100, Math.max(0, Math.round(progress)));
				
				if (progress !== this.scrollProgress) {
					this.scrollProgress = progress;
				}

				if (progress === 100 && !this.hasReadComplete) {
					this.hasReadComplete = true;
				}
			},

			checkCompletion() {
				this.updateContentHeight();
				this.calculateProgress();
			},

			onImageLoad() {
				if (this.resizeTimer) clearTimeout(this.resizeTimer);
				this.resizeTimer = setTimeout(() => {
					this.updateContentHeight();
				}, 150);
			},

			onImageError(index) {
				this.$set(this.loadedImages[index], 'error', true);
			},

			goPrev() {
				uni.navigateBack();
			},

			nextPage() {
				if (!this.hasReadComplete) {
					uni.showToast({
						title: '请先滑动到底部完成阅读',
						icon: 'none'
					});
					this.updateContentHeight();
					return;
				}
				uni.redirectTo({
					url: `/pages/sign/confirm-price?orderId=${this.orderId}`
				});
			}
		}
	};
</script>

<style lang="scss" scoped>
	.container {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
		background-color: #FFFFFF;
		box-sizing: border-box;
		/* 底部留白给按钮 */
		//padding-bottom: 180rpx; 
	}

	.content-wrapper {
		width: 100%;
		/* padding-top 由 JS 动态控制，防止被 navbar 遮挡 */
		box-sizing: border-box;
	}

	.guide-text {
		/* 修改：去掉左右 margin，只保留上下或内部 padding */
		padding: 30rpx 0; 
		background-color: #E8F5E9;
		/* margin: 20rpx;  <-- 删除这行，去掉左右边距 */
		margin-bottom: 20rpx; /* 只保留底部间距，如果需要的话，或者完全去掉 */
		
		.guide-content {
			display: flex;
			align-items: flex-start;
			font-size: 28rpx;
			color: #2C3E50;
			line-height: 1.6;
			word-wrap: break-word;
			/* 如果文字需要贴边，去掉 ml-20 或者在这里控制 */
			padding: 0 20rpx; /* 给文字内部一点点呼吸感，如果不想要完全贴边可设为 0 */
		}
	}

	.progress-tip {
		position: fixed;
		right: 30rpx;
		bottom: 280rpx;
		z-index: 999;
		width: 240rpx;
		pointer-events: none;

		.progress-card {
			background: rgba(255, 255, 255, 0.95);
			backdrop-filter: blur(10px);
			-webkit-backdrop-filter: blur(10px);
			border-radius: 24rpx;
			padding: 24rpx;
			box-shadow: 0 8rpx 32rpx rgba(74, 99, 228, 0.15);
			border: 1rpx solid rgba(255, 255, 255, 0.8);
			display: flex;
			flex-direction: column;
			gap: 12rpx;

			.progress-header {
				display: flex;
				justify-content: space-between;
				align-items: center;

				.progress-label {
					font-size: 24rpx;
					color: #909399;
					font-weight: 500;
				}

				.progress-value {
					font-size: 32rpx;
					font-weight: bold;
					color: #4A63E4;
					line-height: 1;
				}
			}

			.progress-track {
				width: 100%;
				height: 12rpx;
				background-color: #EDEFF5;
				border-radius: 6rpx;
				overflow: hidden;

				.progress-fill {
					height: 100%;
					background: linear-gradient(90deg, #4A63E4, #7C93F0);
					border-radius: 6rpx;
					transition: width 0.2s ease-out;
				}
			}

			.progress-sub {
				font-size: 22rpx;
				color: #C0C4CC;
				text-align: right;
			}
		}
	}

	.image-list {
		/* 修改：去掉左右 padding，实现无边距 */
		padding: 0 0 40rpx 0; 
		width: 100%;
		box-sizing: border-box;
	}

	.image-item {
		margin-bottom: 0; /* 图片之间如果需要间距，可以在 image 标签加 margin，或者这里加 */
		/* 如果图片之间不需要缝隙，设为 0；如果需要，可以设为 2rpx 等 */
		width: 100%;
		background-color: #ffffff;
		
		image {
			display: block;
			width: 100%;
		}
	}

	.loading-more {
		display: flex;
		align-items: center;
		justify-content: center;
		padding: 30rpx;
		color: #999;
		font-size: 28rpx;
	}

	.btn-group {
		position: fixed;
		bottom: 0;
		left: 0;
		right: 0;
		z-index: 1000;
		background-color: #FFFFFF;
		box-shadow: 0 -4rpx 20rpx rgba(0, 0, 0, 0.05);
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 24rpx 26rpx;
		padding-bottom: calc(24rpx + env(safe-area-inset-bottom));

		.next-btn-wrapper {
			flex: 1;
			position: relative;
			margin-left: 26rpx;

			.unlock-tip {
				position: absolute;
				top: -70rpx;
				left: 50%;
				transform: translateX(-50%);
				background-color: rgba(0, 0, 0, 0.7);
				color: #FFFFFF;
				padding: 12rpx 28rpx;
				border-radius: 40rpx;
				font-size: 24rpx;
				white-space: nowrap;
				display: flex;
				align-items: center;
				gap: 8rpx;
				z-index: 20;
				backdrop-filter: blur(10px);
				animation: fadeInUp 0.3s ease-out;
			}
		}
	}

	.ml-20 {
		margin-left: 20rpx;
	}
	
	@keyframes fadeInUp {
		from { opacity: 0; transform: translate(-50%, 10rpx); }
		to { opacity: 1; transform: translate(-50%, 0); }
	}
</style>