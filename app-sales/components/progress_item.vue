<template>
  <view>
    <image src="/static/images/order-step-not.png" mode="" class="step-icon"></image>
    <view class="order-step-info">
      <view class="step-line"></view>
      <view class="order-step-info-data">
        <view class="step-name">
          {{item.OrderName}}
        </view>
        <view class="step-desc">
          {{item.Desc}}
        </view>
        <view class="bottom-line"></view>
      </view>
      <view class="date">
        {{item.StatusDate}}
      </view>
    </view>
  </view>
</template>

<script>
  export default {
    name:"progress_item",
    props: {
      item: {
        OrderName: '',
        Desc: '',
        StatusDate: '',
      }
    },
    data() {
      return {
        
      };
    }
  }
</script>

<style lang="scss" scoped>

  .order-step-wrap {
    .order-step-item {
      position: relative;
      padding: 62rpx 56rpx;
      .step-icon {
        width: 52rpx;
        height: 52rpx;
        border-radius: 100%;
        position: absolute;
        z-index: 3;
        left: 56rpx;
      }
    }
    .order-step-info-wrap {
      &:last-child {
        .step-line {
          display: none;
        }
      }
    }
    .order-step-info {
      padding-left: 56rpx;
      display: flex;
      // align-items: center;
      justify-content: space-between;
      position: relative;
      padding-bottom: 76rpx;
      .date {
        font-weight: bold;
        font-size: 22rpx;
        color: #656565;
      }
      .step-line {
        position: absolute;
        width: 14rpx;
        background-color: #E8E8E8;
        height: calc(100% - 46rpx);
        left: 21rpx;
        top: 50rpx;
      }
      .order-step-info-data {
        font-weight: bold;
        font-size: 28rpx;
        color: #B6B6B6;
        margin-left: 56rpx;
        margin-top: -8rpx;
        position: relative;
        flex: 1;
        .step-name {
          font-size: 32rpx;
          color: #505050;
          padding-bottom: 20rpx;
        }
        .bottom-line {
          position: absolute;
          background: linear-gradient(90deg, transparent, rgba(74, 99, 228, 0.5) 50%, transparent 100%);
          height: 2rpx;
          left: -70rpx;
          right: -160rpx;
          bottom: -30rpx;
          display: none;
        }
      }
    }
    .step-finish {
      .step-name {
        color: #4A63E4 !important;
      }
      .step-line {
        background-color: #4A63E4;
      }
    }
    .step-current {
      .step-name {
        color: #4A63E4 !important;
      }
      .step-line {
        background-color:  #4A63E4;
        background: linear-gradient(180deg,rgba(74, 99, 228, 1) 0%, rgba(74, 99, 228, 1) 0%, rgba(232, 232, 232, 1) 45%, rgba(232, 232, 232, 1) 100%);
      }
      .step-desc {
        color: #98A1CF;
      }
      .bottom-line {
        display: block !important;
      }
    }
  }
</style>