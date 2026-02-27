<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">

		<!-- 多张图片展示 - 无间距，不预览 -->
		<view class="detail-images" v-if="detailImages.length > 0">
			<view class="image-item" v-for="(img, index) in detailImages" :key="index">
				<u-image :src="img" width="100%" height="auto" mode="widthFix" :lazy-load="true">
					<template v-slot:loading>
						<u-loading-icon color="red"></u-loading-icon>
					</template>
				</u-image>
			</view>
		</view>

		<view class="btn-group">
			<u-button class="next-btn" :custom-style="nextBtnStyle" @click="handleNext">
				下一步
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
				detailImages: [], // 存储多张图片
			};
		},
		onLoad() {
			this.init();
		},
		methods: {
			async init() {
				// 获取产品信息
				const productId = 1; // 固定值 1
				const res = await api.getProductById(productId);
				if (res.code == 200) {
					const data = res.data || {};

					// 处理 details 字段
					let detailsArray = [];
					try {
						detailsArray = JSON.parse(data.details);
					} catch (e) {
						console.error('details 字段不是合法的 JSON 字符串', e);
						detailsArray = [];
					}

					console.log('detailsArray:', detailsArray);
					this.detailImages = detailsArray;
				}
			},
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
		padding-bottom: 170rpx;
	}

	/* 多张图片展示样式 - 无间距 */
	.detail-images {
		// 移除容器内边距的影响
		margin-left: -26rpx;
		margin-right: -26rpx;
		width: calc(100% + 52rpx); // 补偿左右内边距
	}

	.image-item {
		// 移除所有间距
		line-height: 0; // 防止图片间出现空白
		font-size: 0; // 防止图片间出现空白
	}

	.btn-group {
		position: fixed;
		background-color: #ffffff;
		left:0;
		right:0;
		bottom:0;
		z-index: 999;
		box-shadow: 0 -4rpx 1rpx rgba(0, 0, 0, 0.05);
		padding: 30rpx 26rpx;
		//padding-bottom: calc(24rpx + env(safe-area-inset-bottom));
		display: flex;
		justify-content: center;
		box-sizing: border-box;
	}
</style>