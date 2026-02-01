<template>
  <view class="container">
    <text class="title">合同信息</text>
    <view class="info">
      <text>签署人：张三</text>
      <text>金额：9999.00 元</text>
    </view>
    <button type="primary" @click="startSign">立即签署</button>
  </view>
</template>

<script>
export default {
  methods: {
    startSign() {
		const signUrl = `https://ish7439098939.smlh5.esign.cn/mesign/tosign?context=JK2pGItw9w&flowId=8eb769217f0b4a73946717140a4c3004&organ=false&appId=7439098939&linkSource=1&bizType=1&tsign_source_type=SIGN_LINK_XUANYUAN&tsign_source_detail=16R2mv%2F27h2Y5CkM9bwhboKyFgXZONHxNrf5C%2Bjoi%2Bfaw8ubLbwYCXev93sut1wb42ejKuV59T0HtaUnBVFhCZik%2FfFlfdjzW%2BuEmgXE5Lq0fJbzhQT%2FPpb3U7uJ%2BtF%2FGcDJFnsq2rO0%2FkXgo%2Bf4I%2F5oUaSJJr3mIbCpociono4UDSAg35f3KxbBTizAI3T5MQoTTrfCaUCaCGgljfs67%2B3tCUe0OeB0UyzPyTGMthPz6%2FbzZtV1UcsfNP%2FfGwMuV`;
		uni.navigateTo({
		  url: `/pages/sign/signature?signUrl=${encodeURIComponent(signUrl)}`
		});
		return;
		
		
        uni.showLoading({ title: '生成合同中...' });
    
        uni.request({
          url: 'http://127.0.0.1:8080/api/esign/start-sign',
          method: 'POST',
          data: {
            signerName: '张三',
            amount: '9999.00',
            mobile: '15801515490'
          },
          header: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then((res) => {
          //  res 就是响应对象（所有平台一致）
          console.log('请求成功:', res);
    
          if (res.statusCode === 200 && res.data.code === 200) {
            const signUrl = res.data.data;
            uni.navigateTo({
              url: `/pages/sign/signature?signUrl=${encodeURIComponent(signUrl)}`
            });
          } else {
            uni.showToast({
              title: res.data.msg || '请求失败',
              icon: 'none'
            });
          }
        }).catch((err) => {
          console.error('网络错误:', err);
          uni.showToast({ title: '网络错误', icon: 'none' });
        }).finally(() => {
          uni.hideLoading();
        });
      }
  }
};
</script>

<style scoped>
.container {
  padding: 60rpx;
}
.title {
  font-size: 36rpx;
  font-weight: bold;
  display: block;
  margin-bottom: 40rpx;
  text-align: center;
}
.info {
  background: #f5f5f5;
  padding: 30rpx;
  border-radius: 12rpx;
  margin-bottom: 60rpx;
}
.info text {
  display: block;
  margin: 10rpx 0;
  font-size: 30rpx;
}
button {
  width: 100%;
}
</style>