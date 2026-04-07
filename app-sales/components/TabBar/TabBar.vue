<template>
  <view class="tabbar">
    <view class="tabbar-item" v-for="(item, index) in tabList" :key="index" @click="handleTabClick(index)">
      <image :src="currentTab === index ? item.selectedIcon : item.icon" mode="widthFix" class="tab-icon"></image>
      <text class="tab-text" :class="currentTab === index ? 'active' : ''">{{ item.name }}</text>
    </view>
  </view>
</template>

<script>
export default {
  name: 'TabBar',
  props: {
    // 当前激活的 tab 索引
    currentTab: {
      type: Number,
      default: 0
    }
  },
  data() {
    return {
      tabList: [
        {
          pagePath: '/pages/index/index',
          icon: '/static/tabbar/home.png', // 未选中图标路径
          selectedIcon: '/static/tabbar/home-active.png', // 选中图标路径
          name: '首页'
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
    handleTabClick(index) {
	  const currentPage = this.tabList[this.currentTab]?.pagePath;
	  const targetPage = this.tabList[index].pagePath;

	  if (index === this.currentTab) {
		// 点击当前 tab：滚动到顶部
		uni.pageScrollTo({ scrollTop: 0, duration: 300 });
	  } else if (targetPage === currentPage) {
		// 安全兜底：理论上不会发生
		uni.pageScrollTo({ scrollTop: 0, duration: 300 });
	  } else {
		// 跳转到其他 tab 页面
		uni.reLaunch({
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
  // border-top: 1px solid #e5e5e5;
  display: flex;
  justify-content: space-around;
  align-items: center;
  box-shadow: 0rpx 0rpx 20rpx 0rpx rgba(35,80,162,0.12);
  z-index: 999;
/* 适配 iPhone 底部安全区 */
padding-bottom: env(safe-area-inset-bottom);
}

.tabbar-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  // padding: 20rpx 0 28rpx 0;
  height: 100%;
}

.tab-icon {
  width: 40rpx;
  height: 40rpx;
  margin-bottom: 14rpx;
}
.tab-text {
  font-size: 32rpx;
  color: #757575;
  font-weight: bold;
  &.active {
    color: #4A63E2;
  }
}
</style>