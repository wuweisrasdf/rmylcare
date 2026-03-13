<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="false" title="智数健管"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
			<view slot="left"></view>
		</u-navbar>

		<view class="content-container">
			<image src="/static/images/aboutus.png" class="aboutus" mode="widthFix" lazy-load="true"></image>

			<view class="company-name">
				人民医疗管理有限公司_
			</view>
			<view class="company-desc">
				人民医疗管理有限公司成立于2018年。<br />
				是一家以提供全面医疗健康管理服务为核心业务的专业医疗管理企业。公司致力于整合优质医疗资源，打造高品质的医疗服务平台，为广大人民群众提供全方位、全周期的医疗服务。业务领域方面，人民医疗涵盖基因检测、医疗健康等相关管理、运营及咨询的医疗服务输出。
			</view>


<!-- 			<button @click="toSign" style="margin-top: 50rpx;">测试签约</button> -->

			<view class="btn-container">
				<!-- 第一行：原有的两个卡片 -->
				<view class="btn-row">
					<view class="btn-card" @click="goToPromotion(3)">
						<text class="btn-title">1V1私人订制</text>
						<view class="btn-content">
							<!-- 请替换为实际的图标路径 -->
							<image src="/static/icons/molecule.png" class="btn-icon" mode="aspectFit" />
							<text class="btn-text">胎盘冻干粉</text>
						</view>
					</view>

					<view class="btn-card" @click="goToPromotion(1)">
						<text class="btn-title">评估个人患病风险</text>
						<view class="btn-content">
							<image src="/static/icons/wave.png" class="btn-icon" mode="aspectFit" />
							<text class="btn-text">基因检测</text>
						</view>
					</view>

				</view>

				<!-- 第二行：新增的卡片 (左对齐) -->
				<view class="btn-row single-card-row">
					<view class="btn-card" @click="goToPromotion(2)">
						<text class="btn-title">唤醒肌肤神奇之旅</text>
						<view class="btn-content">
							<image src="/static/icons/molecule.png" class="btn-icon" mode="aspectFit" />
							<text class="btn-text">细胞囊泡</text>
						</view>
					</view>
				</view>
			</view>
		</view>

		<TabBar :current-tab="currentTab" />
	</view>
</template>

<script>
	import TabBar from '@/components/TabBar/TabBar.vue';

	import {
		mapGetters
	} from 'vuex';

	export default {
		components: {
			TabBar
		},
		computed: {
			...mapGetters(['isLogined']),

			// 计算容器顶部内边距（转为 rpx）
			containerPaddingTop() {
				// CustomBar 是 px，uni-app 中 1px = 2rpx
				const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
				return barHeight;
			}
		},
		data() {
			return {
				currentTab: 0
			}
		},
		onLoad() {

		},
		methods: {
			// 产品宣传
			goToPromotion(type) {
				uni.navigateTo({
					url: `/pages/product/promotion?type=${type}`
				})
			},
			onShareAppMessage() {
				return {
					title: '科数健管 - 冻干粉服务',
					path: '/pages/product/detail?productId=123',
					imageUrl: '/static/share.jpg' // 可选：分享封面图
				}
			},
			toSign() {
				if (!this.isLogined) {
					uni.redirectTo({
						url: `/pages/login/login`
					})
					return;
				}

				uni.setStorageSync('SCAN_SALES_ID', 1); // 模拟销售
				uni.navigateTo({
					url: `/pages/index/intro`
				})
			}
		}
	}
</script>

<style lang="scss" scoped>
	.container {
		background-color: #ffffff;
		padding: 0rpx 26rpx 220rpx 26rpx;
		min-height: 100vh;
		box-sizing: border-box;
	}

	.content-container {
		margin-top: 68rpx;
		display: flex;
		justify-content: center;
		flex-direction: column;
	}

	.aboutus {
		width: 704rpx;
		height: 276.6rpx;
		object-fit: contain;
		background-color: #f8f8f8;
	}

	.company-name {
		font-weight: bold;
		font-size: 34rpx;
		color: #000000;
		margin-top: 20rpx;
	}

	.company-desc {
		margin-top: 40rpx;
		font-weight: bold;
		font-size: 28rpx;
		color: #959595;
		line-height: 58rpx;
	}

	/* --- 修改开始：仅调整布局逻辑 --- */
	.btn-container {
		margin-top: 58rpx;
		display: flex;
		flex-direction: column;
		gap: 30rpx;
		width: 100%;
	}

	.btn-row {
		display: flex;
		width: 100%;
		gap: 30rpx;

		/* 第一行：两个卡片平分 */
		&:not(.single-card-row) {
			justify-content: space-between;

			.btn-card {
				flex: 1;
				/* 自动占满剩余空间 */
				width: auto;
			}
		}

		/* 第二行：单个卡片居中 */
		&.single-card-row {
			justify-content: flex-start;

			.btn-card {
				/* 核心修复：强制宽度等于第一行单个卡片的宽度 */
				/* 算法：(100% 总宽 - 30rpx 间隙) / 2 */
				width: calc((100% - 30rpx) / 2);
				flex: none;
				/* 禁止 flex 自动伸缩，严格遵循 width */
			}
		}
	}

	.btn-card {
		/* 保留你原有的所有视觉样式 */
		padding: 40rpx 30rpx;
		background: #F2F4FA;
		border-radius: 40rpx;
		display: flex;
		flex-direction: column;
		justify-content: center;
		/* 新增：防止内容溢出导致高度不一致 */
		box-sizing: border-box;
	}

	.btn-title {
		font-weight: 500;
		font-size: 26rpx;
		color: #676767;
		line-height: 1.2;
	}

	.btn-content {
		display: flex;
		margin-top: 28rpx;
		align-items: center;
		/* 确保图标文字垂直对齐 */
	}

	.btn-icon {
		width: 52rpx;
		height: 52rpx;
		margin-right: 46rpx;
		flex-shrink: 0;
		/* 防止图标被压缩 */
	}

	.btn-text {
		font-weight: bold;
		font-size: 36rpx;
		color: #000000;
		/* 防止文字过长换行破坏布局 */
		white-space: nowrap;
	}

	/* --- 修改结束 --- */
</style>