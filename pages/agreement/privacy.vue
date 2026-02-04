<template>
  <view class="container" :style="{ paddingTop: containerPaddingTop }">
	<u-navbar
	  :fixed="true"
	  :autoBack="true"
	  title="隐私政策"
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

<style scoped>
</style>