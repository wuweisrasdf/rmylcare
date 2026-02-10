<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		
		<u-image :src="promoImage" width="100%" height="auto" mode="widthFix" v-if="promoImage" :lazy-load="true">
			<!-- 加载中提示 -->
			<template v-slot:loading>
				<u-loading-icon color="red"></u-loading-icon>
			</template>
		
		</u-image>

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
				promoImage: '',
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

					let navbarArray;
					try {
						navbarArray = JSON.parse(data.navbar);
					} catch (e) {
						console.error('navbar 字段不是合法的 JSON 字符串', e);
						navbarArray = []; // 容错处理
					}
					console.log(navbarArray);

					this.promoImage = navbarArray[2] && navbarArray[2].prod || '';
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
		padding-bottom: 100rpx;
	}
	
	.btn-group {
		margin-top: 50rpx;
		display: flex;
		justify-content: center;
	}
</style>