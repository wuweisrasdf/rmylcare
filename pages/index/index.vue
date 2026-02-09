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

			<!-- 两个按钮卡片 -->
			<view class="btn-container">
				<view class="btn-card" @click="goToPromotion(1)">
					<text class="btn-title">保障计划 Pro</text>
					<view class="btn-content">
						<image src="/static/icons/wave.png" class="btn-icon" mode="aspectFit" />
						<text class="btn-text">成人优因</text>
					</view>
				</view>

				<view class="btn-card" @click="goToPromotion(2)">
					<text class="btn-title">唤醒肌肤神奇之旅</text>
					<view class="btn-content">
						<image src="/static/icons/molecule.png" class="btn-icon" mode="aspectFit" />
						<text class="btn-text">细胞囊泡</text>
					</view>
				</view>
			</view>
			
			<button @click="toSign" style="margin-top: 30rpx;">测试签约</button>
		</view>

		<TabBar :current-tab="currentTab" />
	</view>
</template>

<script>
	import TabBar from '@/components/TabBar/TabBar.vue';

	export default {
		components: {
			TabBar
		},
		computed: {
			// 计算容器顶部内边距（转为 rpx）
			containerPaddingTop() {
				// CustomBar 是 px，uni-app 中 1px = 2rpx
				const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
				return barHeight;
			}
		},
		data() {
			return {
				currentTab: 0,
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
			toSign(){
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
		/* 使用 padding-bottom 为 TabBar 留出空间 */
		padding: 0rpx 26rpx 180rpx 26rpx;
		/* bottom padding >= TabBar高度(100rpx) + 安全区(～40rpx) */
		min-height: 100vh;
		box-sizing: border-box;
		/* 确保 padding 包含在 100vh 内 */
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
		/* 根据图片实际比例选择： */
		object-fit: contain;
		/* 推荐：如果图片不能裁剪 */
		/* object-fit: cover; */
		/* 如果允许裁剪，且必须填满 */
		background-color: #f8f8f8;
		/* 防止加载失败时白屏 */
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

	.btn-container {
		margin-top: 58rpx;
		display: flex;
		gap: 30rpx;
		width: 100%;
		justify-content: space-between;
	}

	.btn-card {
		flex: 1;
		padding: 40rpx 30rpx;
		background: #F2F4FA;
		border-radius: 40rpx;
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
	}

	.btn-icon {
		width: 52rpx;
		height: 52rpx;
		margin-right: 46rpx;
	}

	.btn-text {
		font-weight: bold;
		font-size: 36rpx;
		color: #000000;
	}
</style>