<script>
  import { getProductById } from '@/utils/api.js';
	export default {
    data() {
      return {
        globalPolling: null,
      }
    },
		onLaunch: function() {
			console.log('App Launch')
      this.$store.dispatch('initUser');
		},
		onShow: function() {
			console.log('App Show')
      this.$store.dispatch('initUser');
      // console.log('onShow', this.$store.state.user)
      
      // 请求这个只是为了保持token的有效性
      // this.startGlobalPolling();
		},
		onHide: function() {
			console.log('App Hide')
      // 小程序进入后台时暂停（节省资源）
      // this.stopGlobalPolling();
		},
    methods: {
      startGlobalPolling() {
        // 防止重复启动
        if (this.globalPolling) return;
        this.globalPolling = setInterval(function (){
          if (uni.getStorageSync('token')) {
            getProductById(1);
          }
        }, 600000);
      },
      stopGlobalPolling() {
        if (this.globalPolling) {
          clearInterval(this.globalPolling);
          this.globalPolling = null;
        }
      },
    },
    onUnload() {
      // this.stopGlobalPolling();
    }
	}
</script>

<style lang="scss">
	@import "uview-ui/index.scss";
  .card-wrap {
    margin-top: 78rpx;
    padding: 40rpx 24rpx;
    border-radius: 40rpx;
    // background: #F6F7FC;
    background: #F2F4FA;
    
  }
  .list-wrap {
    display: flex;
    flex-direction: column;
    gap: 20rpx;
    .list-item {
      background: #F2F4FA;
      padding: 20rpx;
      border-radius: 40rpx;
      display: flex;
      flex: 1;
      gap: 20rpx;
      justify-content: space-between;
      .list-item-name-wrap {
        display: flex;
        align-items: center;
        gap: 20rpx;
        .list-item-icon {
          width: 60rpx;
          height: 60rpx;
          border-radius: 100%;
        }
        .list-item-name {
          font-size: 32rpx;
          color: #999;
          font-weight: bold;
        }
      }
      .list-item-arr-wrap {
        display: flex;
        align-items: center;
        .list-item-arr-name {
          font-size: 32rpx;
          color: #333;
        }
        .list-item-arr {
          font-size: 32rpx;
          color: #999;
        }
      }
    }
  }
  .popdialog-wrap {
    ::v-deep .u-modal {
      border-radius: 30rpx !important;
    }
    ::v-deep .u-popup__content {
      border-radius: 30rpx !important;
    }
    ::v-deep .u-line {
      display: none;
    }
    ::v-deep .u-modal__button-group {
      gap: 40rpx;
    }
    ::v-deep .u-modal__button-group__wrapper--confirm {
      background-color: #5686ff;
    }
    .slot-content {
      width: 100%;
      .tip-text {
        margin-top: 10rpx;
        color: #5686ff;
        font-size: 24rpx;
      }
      ::v-deep .u-icon__icon {
        font-size: 24rpx !important;
      }
    }
  }
  
</style>
