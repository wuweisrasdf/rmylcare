<template>
  <view class="container">
    <!-- 注意：web-view 必须占满全屏 -->
    <web-view 
      :src="decodedSignUrl" 
      @message="onMessage"
      style="width: 100vw; height: 100vh;"
    />
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
      uni.showToast({ title: '无效的签署链接', icon: 'none' });
      setTimeout(() => uni.navigateBack(), 1500);
    }
  },
  methods: {
    onMessage(e) {
      const msg = e.detail.data?.[0];
      if (!msg) return;

      try {
        const payload = typeof msg === 'string' ? JSON.parse(msg) : msg;
        switch (payload.type) {
          case 'SIGN_SUCCESS':
            uni.showToast({ title: '签署成功！', icon: 'success' });
            setTimeout(() => uni.navigateBack(), 1500);
            break;
          case 'SIGN_CANCEL':
            uni.navigateBack();
            break;
          case 'SIGN_ERROR':
            uni.showToast({ title: '签署失败', icon: 'error' });
            uni.navigateBack();
            break;
        }
      } catch (err) {
        console.error('解析消息失败:', err);
      }
    }
  }
};
</script>

<style scoped>
.container {
  width: 100vw;
  height: 100vh;
  overflow: hidden;
}
</style>