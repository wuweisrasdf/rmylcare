<template>
  <view class="my-page">
    <!-- 头像区域 -->
    <view class="avatar-container">
      <image class="avatar" :src="userAvatar" mode="aspectFill"></image>
    </view>

    <!-- 功能卡片区域 -->
    <view class="cards-container">
      <!-- 订单查询 -->
      <view class="card-item" @click="goToOrderQuery">
		<view class="card-left">
		  <image class="card-icon" src="/static/icons/order-query.png" mode="aspectFill"></image>
		  <view class="card-content">
			<text class="card-title">订单查询</text>
			<text class="card-desc">实时查看订单进度</text>
		  </view>
		</view>
        <image class="arrow-right" src="/static/icons/arrow-right.png" mode="aspectFill"></image>
      </view>

      <!-- 个人中心 -->
      <view class="card-item" @click="goToPersonalCenter">
        <view class="card-left">
          <image class="card-icon" src="/static/icons/personal-center.png" mode="aspectFill"></image>
          <view class="card-content">
            <text class="card-title">个人中心</text>
            <text class="card-desc">管理个人信息</text>
          </view>
        </view>
        <image class="arrow-right" src="/static/icons/arrow-right.png" mode="aspectFill"></image>
      </view>
    </view>

    <!-- 温馨提示区域 -->
    <view class="notice-container">
      <view class="notice-header">
        <image class="notice-icon" src="/static/icons/notice.png" mode="aspectFill"></image>
        <text class="notice-title">温馨提示</text>
      </view>

	<text class="notice-text">如有任何问题，请联系客服团队。我们随时准备为您服务。</text>

    </view>

    <!-- 底部功能按钮区域 -->
    <view class="bottom-buttons">
      <view class="button-item">
        <text class="button-number">24/7</text>
        <text class="button-label">在线服务</text>
      </view>
      <view class="button-item">
        <text class="button-number">100%</text>
        <text class="button-label">安全保障</text>
      </view>
      <view class="button-item">
        <text class="button-number">快速</text>
        <text class="button-label">高效处理</text>
      </view>
    </view>
	

    <!-- 底部 tabbar -->
    <TabBar :current-tab="currentTab" />
  </view>
</template>

<script>
	import { mapState } from 'vuex'
	
	import TabBar from '@/components/TabBar/TabBar.vue';
	
	export default {
		components: {
		    TabBar
		},
		computed: {
		    // 从 store 映射 user 对象
		    ...mapState(['user']),
		    
		    // 计算属性：返回有效的头像URL
		    userAvatar() {
		      // 检查 user 是否存在，以及 avatar 字段是否有有效值
		      if (this.user && this.user.avatar) {
		        // 如果 avatar 是一个完整的 URL (http/https)，直接返回
		        if (this.user.avatar.startsWith('http')) {
		          return this.user.avatar;
		        }
		        // 如果 avatar 是一个相对路径（可能性小），也返回
		        return this.user.avatar;
		      }
		      // 否则，返回默认头像
		      return '/static/images/avatar-placeholder.png';
		    }
		  },
		data() {
			return {
				currentTab: 2
			};
		},
		onLoad(options) {

		},
		methods: {
			// 个人信息
			goToPersonalCenter(){
				uni.navigateTo({
					url : "/pages/me/profile"
				})
			},
			// 跳转到订单列表页面
			goToOrderQuery(){
				uni.navigateTo({
					url : "/pages/order/order"
				})
			}
		}

	};
</script>
<style lang="scss" scoped>
	.my-page {
	  background-color: #f5f5f5;
	  /* 使用 padding-bottom 为 TabBar 留出空间 */
	  padding: 40rpx 30rpx 140rpx; /* bottom padding >= TabBar高度(100rpx) + 安全区(～40rpx) */
	  min-height: 100vh;
	  box-sizing: border-box; /* 确保 padding 包含在 100vh 内 */
	}
	
	.avatar-container {
	  display: flex;
	  justify-content: center;
	  margin-bottom: 60rpx;
	}
	
	.avatar {
	  width: 160rpx;
	  height: 160rpx;
	  border-radius: 50%;
	  background-color: #e0f7f7;
	  overflow: hidden;
	}
		
	.cards-container {
	  padding: 0 30rpx;
	  margin-bottom: 40rpx;
	}
	
	.card-item {
	  display: flex;
	  align-items: center;

	  background-color: white;
	  border-radius: 16rpx;
	  padding: 30rpx 24rpx;
	  margin-bottom: 24rpx;
	  box-shadow: 0 4rpx 20rpx rgba(0, 0, 0, 0.04);
	}
	
	
	.card-left {
	  display: flex;
	  align-items: center;
	  flex: 1;
	  min-width: 0;
	}
		
	.card-icon {
	  width: 86rpx;
	  height: 86rpx;
	  border-radius: 16rpx;
	  background-color: #e8f4ff;
	  margin-right: 20rpx;
	}
	
	.card-content {
		display: flex;
		flex-direction: column;
	}
	
	.card-title {
	  font-size: 28rpx;
	  color: #333333;
	  font-weight: 500;
	  line-height: 1.4;
	}
	
	.card-desc {
	  font-size: 24rpx;
	  color: #999999;
	  margin-top: 4rpx;
	}
	
	.arrow-right {
	  width: 32rpx;
	  height: 32rpx;
	  opacity: 0.5;
	  flex-shrink: 0;
	  margin-left: 16rpx;
	}
	
	.notice-container {
	  background-color: #f0f8f0;
	  border-radius: 16rpx;
	  margin: 0 30rpx 40rpx;
	  padding: 28rpx 24rpx;
	}
	
	.notice-header {
	  display: flex;
	  align-items: center;
	  margin-bottom: 16rpx;
	}
	
	.notice-icon {
	  width: 32rpx;
	  height: 32rpx;
	  margin-right: 12rpx;
	}
	
	.notice-title {
	  font-size: 28rpx;
	  color: #333333;
	  font-weight: 500;
	}
		
	.notice-text {
	  font-size: 26rpx;
	  color: #666666;
	  line-height: 1.5;
	}
	
	.bottom-buttons {
	  display: flex;
	  justify-content: space-between;
	  padding: 0 30rpx;
	  gap: 20rpx;
	}
	
	.button-item {
	  display: flex;
	  flex-direction: column;
	  align-items: center;
	  background-color: white;
	  border-radius: 16rpx;
	  padding: 32rpx 20rpx;
	  flex: 1;
	  min-width: 0;
	}
	
	.button-number {
	  font-size: 32rpx;
	  font-weight: 700;
	  color: #007aff;
	  margin-bottom: 8rpx;
	}
	
	.button-item:nth-child(2) .button-number {
	  color: #07c160 !important; // 微信绿或可自定义绿色
	}
	
	.button-label {
	  font-size: 26rpx;
	  color: #999999;
	  margin-top: 4rpx;
	}
	
</style>
