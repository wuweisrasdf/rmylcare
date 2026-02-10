<template>
	<view class="tabbar">
		<view class="tabbar-item" :class="{ 'active': currentTab === index }" v-for="(item, index) in tabList"
			:key="index" @click="handleTabClick(index)">
			<image :src="currentTab === index ? item.selectedIcon : item.icon" mode="widthFix" class="tab-icon"></image>
			<text class="tab-text">{{ item.name }}</text>
		</view>
	</view>
</template>

<script>
	import {
		mapGetters
	} from 'vuex';

	export default {
		name: 'TabBar',
		props: {
			// 当前激活的 tab 索引
			currentTab: {
				type: Number,
				default: 0
			}
		},
		computed: {
			...mapGetters(['isLogined'])
		},
		data() {
			return {
				tabList: [{
						pagePath: '/pages/index/index',
						icon: '/static/tabbar/home.png', // 未选中图标路径
						selectedIcon: '/static/tabbar/home-active.png', // 选中图标路径
						name: '首页'
					},
					{
						pagePath: '/pages/order/order',
						icon: '/static/tabbar/order.png',
						selectedIcon: '/static/tabbar/order-active.png',
						name: '订单'
					},
					{
						pagePath: '/pages/me/me',
						icon: '/static/tabbar/my.png',
						selectedIcon: '/static/tabbar/my-active.png',
						name: '我的'
					}
				]
			};
		},
		methods: {
			handleTabClick(index) { //if (this.isLogined) {
				const currentPage = this.tabList[this.currentTab]?.pagePath;
				const targetPage = this.tabList[index].pagePath;

				if (index !== 0 && !this.isLogined) {
					// 未登录，跳转到登录页
					uni.redirectTo({
						url: '/pages/login/login'
					});
					return;
				}

				if (index === this.currentTab) {
					// 点击当前 tab：滚动到顶部
					uni.pageScrollTo({
						scrollTop: 0,
						duration: 300
					});
				} else if (targetPage === currentPage) {
					// 安全兜底：理论上不会发生
					uni.pageScrollTo({
						scrollTop: 0,
						duration: 300
					});
				} else {
					uni.redirectTo({
						url: targetPage
					});

				}
			}
		}
	};
</script>

<style lang="scss" scoped>
	.tabbar {
		position: fixed;
		bottom: 0;
		left: 0;
		right: 0;
		height: 140rpx;
		background-color: #ffffff;
		border-top: 1px solid #e5e5e5;
		display: flex;
		justify-content: space-around;
		align-items: center;
		z-index: 999;
		/* 适配 iPhone 底部安全区 */
		padding-bottom: env(safe-area-inset-bottom);
	}

	.tabbar-item {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		padding: 0 20rpx;
		height: 100%;
	}

	.tab-icon {
		width: 70rpx;
		height: auto;
	}

	.tab-text {
		font-size: 32rpx;
		color: #727272;
		/* 默认颜色为未激活状态的颜色 */
		font-weight: bold;
	}

	.tabbar-item.active .tab-text {
		color: #4A63E2;
		/* 激活状态的颜色 */
	}
</style>