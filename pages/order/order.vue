<template>
  <view class="container">
    <!-- 页面内容 -->
    
    <!-- 底部tabbar -->
    <TabBar :current-tab="currentTab"/>
  </view>
</template>

<script>
import TabBar from '@/components/TabBar/TabBar.vue';

export default {
  components: {
    TabBar
  },
  data() {
    return {
      currentTab: 1
    };
  },
  onShow() {

  },
  methods: {
    handleSwitchTab(index) {
      this.currentTab = index;
      if (index === 0) {
        uni.switchTab({ url: '/pages/index/index' });
      } else if (index === 1) {
        // 已经是订单页，不需要跳转
      } else if (index === 2) {
        uni.switchTab({ url: '/pages/profile/profile' });
      }
    }
  }
};
</script>