<template>
  <view class="container" :style="{ paddingTop: containerPaddingTop }">
	<u-navbar
	  :fixed="true"
	  :autoBack="true"
	  title="订单详情"
	  leftIconSize="36" leftIconColor="#2C2C2C"
	  :titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }"
	>
	</u-navbar>
  </view>
</template>

<script>
export default {
  computed: {
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
		
	};
  },
  onLoad() {

  },
  methods: {
  }
};

</script>

<style lang="scss" scoped>
.container {
  background-color: #ffffff;
  padding: 0rpx 26rpx 180rpx 26rpx;
  min-height: 100vh;
  box-sizing: border-box;
}

.content-container {
  display: flex;
  justify-content: center;
  flex-direction: column;
}
	
</style>