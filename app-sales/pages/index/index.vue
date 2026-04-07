<template>
	<view class="container">
    <!-- <u-sticky offset-top="0" bgColor="#4A63E2">
      <view class="top-wrap">
        <view class="top-radius"></view>
      </view>
    </u-sticky> -->
    <view class="content-wrap">
      <view class="welcome">
        欢迎回来！
      </view>
      <view class="welcome-description">
        快速访问您的核心功能
      </view>
      
      <view class="card-wrap" v-if="isEmptyInfo(user)" @click="goPage('login/login')">
        <view class="avatar-wrap">
          <view class="avatar-and-name">
            <img src="/static/images/avatar-placeholder.png" />
            <view class="name-wrap">
              <view class="job">
                尚未登录
              </view>
              <view class="name">
                点击登录
              </view>
            </view>
          </view>
          
        </view>
      </view>
      <view class="card-wrap" v-else>
        <view class="avatar-wrap">
          <view class="avatar-and-name">
            <img :src="'/static/images/avatar-placeholder.png'" />
            <view class="name-wrap">
              <view class="job">
                <!-- 销售员 -->
                {{user.remark || '销售'}}
              </view>
              <view class="name">
                {{user.nickName}}
              </view>
            </view>
          </view>
          <view class="date-wrap">
            <view class="date-name">
              <u-icon name="calendar" color="#666" size="28"></u-icon>
              加入日期
            </view>
            <view class="date">
              {{creatTime(user.createTime)}}
            </view>
          </view>
        </view>
      </view>
      
      <view class="card-wrap" style="background-color: #FAFAFA; padding: 42rpx 24rpx;">
        <view class="list-wrap">
          <view class="list-item" @click="goPage('myqrcode/myqrcode')">
            <view class="list-item-name-wrap">
              <image src="/static/icons/qrcode-icon.png" mode="aspectFill" class="list-item-icon"></image>
              <view class="list-item-name" style="color: #000">
                我的专属二维码
              </view>
            </view>
            <view class="list-item-arr-wrap">
              <!-- <view class="list-item-arr-name">
                登录
              </view> -->
              <u-icon name="arrow-right" class="list-item-arr" color="#999"></u-icon>
            </view>
          </view>
          <view class="list-item" @click="goPage('order/order')">
            <view class="list-item-name-wrap">
              <image src="/static/icons/order-list-icon.png" mode="aspectFill" class="list-item-icon"></image>
              <view class="list-item-name" style="color: #000">
                订单列表
              </view>
            </view>
            <view class="list-item-arr-wrap">
              <!-- <view class="list-item-arr-name">
                邮箱
              </view> -->
              <u-icon name="arrow-right" class="list-item-arr" color="#999"></u-icon>
            </view>
          </view>
          <view class="list-item" @click="goPage('sales_order/order')">
            <view class="list-item-name-wrap">
              <image src="/static/icons/salses-optiunition.png" mode="aspectFill" class="list-item-icon"></image>
              <view class="list-item-name" style="color: #000">
                销售机会列表
              </view>
            </view>
            <view class="list-item-arr-wrap">
              <!-- <view class="list-item-arr-name">
                邮箱
              </view> -->
              <u-icon name="arrow-right" class="list-item-arr" color="#999"></u-icon>
            </view>
          </view>
        </view>
      </view>
      
      <view class="quick-tip-wrap">
        <view class="name">
          <view class="dot"></view>
          <view class="text">快速提示</view>
          
        </view>
        <view class="tips-wrap">
          <view class="tips">
            <view class="dot"></view>
            <view class="text">点击“我的专属二维码”，一键保存或分享给签约客户</view>
          </view>
          <view class="tips">
            <view class="dot"></view>
            <view class="text">点击“订单列表”查看和管理已签约客户</view>
          </view>
          <view class="tips">
            <view class="dot"></view>
            <view class="text">点击“销售机会列表”查看和管理未签约的客户</view>
          </view>
        </view>
      </view>
      
    </view>
		
		<TabBar :current-tab="currentTab"/>
	</view>
</template>

<script>
import dayjs from 'dayjs';
import {isEmpty} from 'lodash';
import { getUserDetail } from '@/utils/api.js';
	import TabBar from '@/components/TabBar/TabBar.vue';
  
  import { mapState } from 'vuex';
	
	export default {
		components: {
		  TabBar
		},
		data() {
			return {
				currentTab: 0,
			}
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
      },
    },
		async onLoad() {
      if (this.isEmptyInfo(this.user)) {
        const res = await getUserDetail();
        if (res.code == 200) {
          this.$store.dispatch('updateUserInfo', res);
        }
      }
		},
		methods: {
      creatTime(timeStr) {
        if (!timeStr) {
          return '--'
        }
        return dayjs(new Date(timeStr)).format('YYYY-MM-DD');
      },
      goPage(page) {
        if (this.isEmptyInfo(this.user)) {
          uni.redirectTo({
            url: '/pages/login/login'
          })
        } else if (page) {
          uni.navigateTo({
            url: `/pages/${page}`,
          })
        }
      },
			/* onShareAppMessage() {
				  return {
					title: '科数健管 - 冻干粉服务',
					path: '/pages/product/detail?productId=123',
					imageUrl: '/static/share.jpg' // 可选：分享封面图
				  }
				} */
		}
	}
</script>
<style>
  page, body {
    /* background-color: #4A63E2; */
  }
</style>
<style lang="scss" scoped>
  .container {
    background-color: #fff;
  }
  .top-wrap {
    background-color: #4A63E2;
    margin-top: 0 -26rpx;
    .top-radius {
      height: 40rpx;
      background-color: #fff;
      border-radius: 40rpx 40rpx 0 0;
    }
  }
  .content-wrap {
    padding: 0 26rpx;
    // height: calc(100vh - 100rpx);
    // overflow-y: auto;
    padding-top: 110rpx;
    .welcome {
      color: #000;
      font-size: 40rpx;
      margin-left: 16rpx;
    }
    .welcome-description {
      margin-top: 32rpx;
      color: #6C6C6C;
      font-size: 32rpx;
      margin-left: 16rpx;
    }
    .card-wrap {
      margin-top: 78rpx;
      padding: 48rpx 16px;
      border-radius: 40rpx;
      background: #F6F7FC;
      // display: flex;
      // align-items: center;
      // justify-content: space-between;
      .avatar-wrap {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 30rpx;
        font-size: 36rpx;
        .avatar-and-name {
          display: flex;
          gap: 20rpx;
          image {
            width: 107rpx;
            height: 107rpx;
            border-radius: 50%;
          }
          .name-wrap{
            display: flex;
            flex-direction: column;
            justify-content: center;
            gap: 8rpx;
            font-weight: bold;
            .name {
              font-size: 28rpx;
              color: #737373;
            }
          }
        }
        .date-wrap {
          display: flex;
          flex-direction: column;
          justify-content: center;
          gap: 6rpx;
          font-size: 24rpx;
          font-weight: bold;
          .date-name {
            font-size: 24rpx;
            color: #737373;
            display: flex;
            gap: 6rpx;
          }
        }
      }
    }
    .list-item {
      background-color: #F2F4FA;
      ::v-deep .u-cell {
        background: #F2F4FA;
        border-radius: 40rpx;
        margin-top: 20rpx;
        &:first-child {
          margin-top: 0;
        }
      }
      
    }
    .quick-tip-wrap {
      padding-bottom: 240rpx;
      margin-top: 63rpx;
      .name {
        display: flex;
        align-items: center;
        gap: 10rpx;
        .dot {
          background: #4A63E4;
          width: 6rpx;
          height: 28rpx;
          border-radius: 3rpx;
        }
      }
      .tips-wrap {
        margin-left: 20rpx;
        margin-top: 52rpx;
        display: flex;
        flex-direction: column;
        gap: 10rpx;
      }
      .tips {
        display: flex;
        align-items: center;
        gap: 10rpx;
        font-size: 24rpx;
        color: #5B5B5B;
        .dot {
          background: #4A63E4;
          width: 9rpx;
          height: 9rpx;
          border-radius: 50%;
        }
      }
    }
  }
</style>
