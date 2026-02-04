<template>
  <view class="container" :style="{ paddingTop: containerPaddingTop }">
    <u-navbar
      :fixed="true"
      :autoBack="false"
      title="订单列表"
      :titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }"
    >
      <view slot="left"></view>
    </u-navbar>

    <view class="tab-switch">
      <view class="tab-item active">进行中</view>
      <view class="tab-item">已完成</view>
    </view>

    <view class="content-container">
      <view v-for="(item, index) in orderList" :key="index" class="order-card">
        <!-- 姓名 + 状态标签 -->
        <view class="header">
          <text class="name">{{ item.name }}</text>
          <view class="status-tag" :class="item.statusClass">
            {{ item.status }}
          </view>
        </view>

        <!-- 详细信息 -->
        <view class="info-row">
          <view class="field">
            <text class="label">预产期:</text>
            <text class="value">{{ item.dueDate }}</text>
          </view>
          <view class="field">
            <text class="label">预产医院:</text>
            <text class="value">{{ item.hospital }}</text>
          </view>
        </view>
        <view class="info-row">
          <view class="field">
            <text class="label">协议号:</text>
            <text class="value">{{ item.agreementNo }}</text>
          </view>
          <view class="field">
            <text class="label">签约日期:</text>
            <text class="value">{{ item.signDate }}</text>
          </view>
        </view>
      </view>
    </view>

    <TabBar :current-tab="currentTab"/>
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
      const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
      return barHeight;
    }
  },
  data() {
    return {
      currentTab: 1,
      orderList: [
        {
          name: '张菲',
          status: '已签约',
          statusClass: 'signed',
          dueDate: '2026-03-12',
          hospital: '朝阳医院',
          agreementNo: '2934054876',
          signDate: '2026-03-12'
        },
        {
          name: '张菲',
          status: '未签约',
          statusClass: 'unsigned',
          dueDate: '2026-03-12',
          hospital: '朝阳医院',
          agreementNo: '2934054876',
          signDate: '2026-03-12'
        },
        {
          name: '张菲',
          status: '已解约',
          statusClass: 'unbound',
          dueDate: '2026-03-12',
          hospital: '朝阳医院',
          agreementNo: '2934054876',
          signDate: '2026-03-12'
        }
      ]
    };
  },
  methods: {
  }
};
</script>

<style lang="scss" scoped>
.container {
  background-color: #F5F5F5;
  padding: 0rpx 26rpx 180rpx 26rpx;
  min-height: 100vh;
  box-sizing: border-box;
}

.content-container {
  display: flex;
  justify-content: center;
  flex-direction: column;
}

.tab-switch {
  display: flex;
  gap: 26rpx;
  margin: 60rpx 0;
  padding: 16rpx 0;
}

.tab-item {
  width: 160rpx;
  height: 60rpx;
  background: #FFFFFF;
  border-radius: 28rpx;
  font-weight: bold;
  font-size: 26rpx;
  color: #AEAEAE;
  text-align: center;
  line-height: 60rpx;
}

.tab-item.active {
  background: #EDEFF7;
  border: 2px solid #A4AFDE;
  color: #4A63E4;
}

.order-card {
  padding: 36rpx 20rpx;
  margin-bottom: 40rpx;
  background: #FFFFFF;
  box-shadow: 0rpx 10rpx 26rpx 0rpx rgba(0, 88, 133, 0.08);
  border-radius: 40rpx;
  position: relative;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 46rpx;
}

.name {
  font-weight: bold;
  font-size: 32rpx;
  color: #2C2C2C;
  position: relative;
  padding-left: 18rpx;
}

.name::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 6rpx;
  height: 28rpx;
  background: #4A63E4;
  border-radius: 3rpx;
}

.status-tag {
  position: absolute;
  right: -1px;
  top: -1px;
  width: 162rpx;
  height: 62rpx;
  font-size: 24rpx;
  font-weight: bold;
  text-align: center;
  background-repeat: no-repeat;
  background-size: contain;
  text-align: center;
  padding-top: 8rpx;
  font-weight: bold;
  font-size: 24rpx;
}

.status-tag.signed {
  background-image: url('/static/images/signed.png');
  color: #2449FF;
}

.status-tag.unsigned {
  background-image: url('/static/images/unsigned.png');
  color: #00A9E8;
}

.status-tag.unbound {
  background-image: url('/static/images/unbound.png');
  color: #FF9C00;
}

.info-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20rpx;
  padding-left: 18rpx;
  margin-bottom: 20rpx;
}

.field {
  display: flex;
  align-items: center;
  min-height: 56rpx;
}

.label {
  font-weight: bold;
  font-size: 26rpx;
  color: #969696;
  min-width: 120rpx;
  white-space: nowrap;
}

.value {
  font-weight: bold;
  font-size: 26rpx;
  color: #969696;
  flex: 1;
  padding-left: 12rpx;
  word-break: break-all;
}
</style>