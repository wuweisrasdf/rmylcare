<template>
  <view class="container">
    <web-view :src="decodedSignUrl" style="width: 100vw; height: 100vh;" />
    <view class="tip">签署完成后请返回</view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      decodedSignUrl: ''
    };
  },
  onLoad(options) {
    if (options.signUrl) {
      this.decodedSignUrl = decodeURIComponent(options.signUrl);
    } else {
      uni.showToast({ title: '无效链接', icon: 'none' });
      setTimeout(() => uni.navigateBack(), 1500);
    }
  }
};
</script>

<style scoped>
.container {
  width: 100vw;
  height: 100vh;
  position: relative;
}
.tip {
  position: absolute;
  bottom: 20rpx;
  left: 0;
  right: 0;
  text-align: center;
  color: #666;
  font-size: 24rpx;
}
</style>