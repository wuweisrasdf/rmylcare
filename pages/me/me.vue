<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" title="我的" :titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }"
			:autoBack="false">
			<view slot="left"></view>
		</u-navbar>

		<!-- 头像区域 -->
		<view class="avatar-container">
			<!-- 		  <view v-if="!userAvatar" class="default-avatar" :style="{ width: '168rpx', height: '168rpx' }">
			  <text class="avatar-text">头像</text>
		  </view>
		  <image v-else class="avatar" :src="userAvatar" mode="aspectFill"></image> -->

			<image :src="'/static/images/avatar-placeholder.png'" class="avatar" mode="aspectFill" />
		</view>

		<!-- 功能卡片区域 -->
		<view class="cards-container">
			<!-- 订单查询 -->
			<view class="card-item" @click="goToOrderQuery">
				<view class="card-left">
					<image class="card-icon" src="/static/icons/order-query.png" mode="aspectFill"></image>
					<view class="card-content">
						<text class="card-title">订单详情</text>
						<text class="card-desc">实时查看订单进度</text>
					</view>
				</view>
				<text class="arrow-right">></text>
			</view>

			<!-- 个人中心 -->
			<view class="card-item" @click="goToPersonalCenter">
				<view class="card-left">
					<image class="card-icon" src="/static/icons/personal-center.png" mode="aspectFill"></image>
					<view class="card-content">
						<text class="card-title">个人中心</text>
						<text class="card-desc">管理个人信息</text>
					</view>
				</view>
				<text class="arrow-right">></text>
			</view>
		</view>

		<!-- 温馨提示区域 -->
		<view class="notice-container">
			<view class="notice-header">
				<view class="notice-icon"></view>
				<text class="notice-title">温馨提示</text>
			</view>

			<view class="notice-text">
				<text>如有任何问题，请联系客服团队。我们随时准备为您服务。</text>
			</view>
			<view class="notice-phone">
				<text>客服电话：010-85795849</text>
			</view>

		</view>

		<!-- 底部功能按钮区域 -->
		<view class="bottom-buttons">
			<view class="button-item">
				<text class="button-number">24/7</text>
				<text class="button-label">在线服务</text>
			</view>
			<view class="button-item">
				<text class="button-number">100%</text>
				<text class="button-label">安全保障</text>
			</view>
			<view class="button-item">
				<text class="button-number">快速</text>
				<text class="button-label">高效处理</text>
			</view>
		</view>


		<!-- 底部 tabbar -->
		<TabBar :current-tab="currentTab" />
	</view>
</template>

<script>
	import {
		mapState
	} from 'vuex'

	import TabBar from '@/components/TabBar/TabBar.vue';

	export default {
		components: {
			TabBar
		},
		computed: {
			// 从 store 映射 user 对象
			...mapState(['user']),

			// 计算属性：返回有效的头像URL
			userAvatar() {
				// 检查 user 是否存在，以及 avatar 字段是否有有效值
				if (this.user && this.user.avatar) {
					// 如果 avatar 是一个完整的 URL (http/https)，直接返回
					if (this.user.avatar.startsWith('http')) {
						return this.user.avatar;
					}
					// 如果 avatar 是一个相对路径（可能性小），也返回
					return this.user.avatar;
				}
				// 否则，返回 null 表示没有头像
				return null;
			},
			// 计算容器顶部内边距（转为 rpx）
			containerPaddingTop() {
				// CustomBar 是 px，uni-app 中 1px = 2rpx
				const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
				console.log(barHeight)
				return barHeight;
			}
		},
		data() {
			return {
				currentTab: 2
			};
		},
		onLoad(options) {

		},
		methods: {
			// 个人信息
			goToPersonalCenter() {
				uni.navigateTo({
					url: "/pages/me/profile"
				})
			},
			// 跳转到订单列表页面
			goToOrderQuery() {
				uni.navigateTo({
					url: "/pages/order/order"
				})
			},

			// 更换头像
			changeAvatar() {
				uni.chooseImage({
					count: 1,
					sizeType: ['compressed'],
					sourceType: ['album', 'camera'],
					success: (res) => {
						const tempFilePath = res.tempFilePaths[0];
						// 立即更新本地预览
						const localAvatar = tempFilePath;
						console.log('【已选头像】本地路径:', tempFilePath);
						// 调用上传接口，成功后 dispatch updateUserInfo
					},
					fail: (err) => {
						console.error('选择头像失败', err);
					}
				});
			}
		}

	};
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

	.avatar-container {
		display: flex;
		justify-content: center;
		padding-bottom: 94rpx;
		background-color: #ffffff;
		margin-top: 78rpx;
		//padding-top: 78rpx;
	}

	.default-avatar {
		width: 168rpx;
		height: 168rpx;
		background: #161421;
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;

		.avatar-text {
			font-weight: 500;
			font-size: 36rpx;
			color: #F2F4FA;
			line-height: 72rpx;
		}
	}

	.avatar {
		width: 160rpx;
		height: 160rpx;
		border-radius: 50%;
		background-color: #e0f7f7;
		overflow: hidden;
	}

	.cards-container {
		// padding: 0 30rpx;
		// margin-bottom: 40rpx;
	}

	.card-item {
		display: flex;
		align-items: center;
		padding: 40rpx 42rpx;
		margin-bottom: 24rpx;
		background: #F2F4FA;
		border-radius: 40rpx;
	}


	.card-left {
		display: flex;
		align-items: center;
		flex: 1;
		min-width: 0;
	}

	.card-icon {
		width: 68rpx;
		height: 68rpx;
		margin-right: 40rpx;
	}

	.card-content {
		display: flex;
		flex-direction: column;
	}

	.card-title {
		font-weight: bold;
		font-size: 36rpx;
		color: #000000;
		line-height: 1.2;
	}

	.card-desc {
		font-weight: 500;
		font-size: 26rpx;
		color: #676767;
		line-height: 1.2;
		margin-top: 24rpx;
	}

	.arrow-right {
		font-weight: 400;
		font-size: 36rpx;
		color: #161421;
		opacity: 0.5;
		flex-shrink: 0;
		/* 不允许被压缩 */
		margin-left: 16rpx;
		align-self: center;
		/* ← 关键！强制垂直居中 */
		line-height: 1;
		/* 避免额外行高影响 */
	}

	.notice-container {
		margin-top: 88rpx;
	}

	.notice-header {
		display: flex;
		flex-direction: row;
		align-items: center;
		margin-bottom: 0;
	}

	.notice-icon {
		width: 6rpx;
		height: 28rpx;
		background: #4A63E4;
		border-radius: 3rpx;
	}

	.notice-title {
		font-weight: bold;
		font-size: 32rpx;
		color: #2C2C2C;
		margin-left: 20rpx;
	}

	.notice-text {
		font-weight: bold;
		font-size: 26rpx;
		color: #5B5B5B;
		margin-left: 20rpx;
		margin-top: 44rpx;
		line-height: 1.6;
	}
	
	.notice-phone {
		font-weight: bold;
		font-size: 26rpx;
		color: #5B5B5B; /* 电话颜色突出显示 */
		margin-left: 20rpx;
		margin-top: 20rpx;
		line-height: 1.6;
	}

	.bottom-buttons {
		display: flex;

		margin-top: 70rpx;
		gap: 20rpx;
	}

	.button-item {
		display: flex;
		flex-direction: column;
		align-items: center;
		background: #F2F4FA;
		border-radius: 26rpx;
		padding: 46rpx 0 28rpx;
		flex: 1;
		min-width: 0;


	}

	.button-number {
		font-weight: bold;
		font-size: 44rpx;
		color: #4A63E2;
		line-height: 52rpx;
	}

	.button-label {
		font-weight: bold;
		font-size: 28rpx;
		color: #161421;
		margin-top: 24rpx;
	}
</style>