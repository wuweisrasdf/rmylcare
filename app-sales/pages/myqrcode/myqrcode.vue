<template>
	<view class="container">
    
    <view class="content-wrap">
      <view class="welcome">
        您的专属签约二维码
      </view>
      <view class="welcome-description">
        分享此二维码给用户
      </view>
      
      <view class="qrcode-card-wrap">
        <!-- <image :src="userAvatar"></image> -->
        <image :src="'/static/images/avatar-placeholder.png'"></image>
        <view class="username">
          {{user.nickName || ''}} : {{user.userName || ''}}
        </view>
        <view class="description">
          <view class="">
            此二维码与你的员工工号绑定，
          </view>
          <view class="">
          用于识别和订单追踪
          </view>
        </view>
        <view class="qrcode">
          <image :src="imageUrl"></image>
        </view>
      </view>
      
      <view class="btn-wrap">
        <u-button type="default" shape="circle" size="large" 
        customStyle="height: 104rpx; background: #5ac725; border-radius: 52rpx; font-weight: bold; font-size: 32rpx; color: #ffffff; border: transparent;" 
        @click="downloadImage"
        >
        保存图片
        </u-button>
        <u-button type="default" shape="circle" size="large" 
        customStyle="position: relative; height: 102rpx; background: #4A63E4; border-radius: 51rpx; font-weight: bold; font-size: 32rpx; color: #FFFFFF; border: transparent;"
        @click="qrcodeToUser"
        >
        <!-- <button open-type="share" style="position: absolute; z-index: 1; top: 0; left: 0; right: 0; bottom: 0; opacity: 0;">分享给好友</button> -->
        分享二维码
        </u-button>
        <!-- <u-button type="default" shape="circle" size="large" color="#5686ff;" @click="downloadImage">保存二维码</u-button> -->
      </view>
    </view>
		
	</view>
</template>

<script>
  import { mapState } from 'vuex';
  import { getwxqrcode } from '@/utils/api.js';
	
	export default {
		components: {
		},
		data() {
			return {
				// imageUrl: '/static/logo.png'
				imageUrl: ''
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
      }
    },
		onLoad() {
      if (this.isEmptyInfo(this.user)) {
        uni.redirectTo({
          url: '/pages/login/login'
        })
      } else {
        this.getUserQrcode();
      }
		},
      // 启用分享（必须）
    /* onShareAppMessage(res) {
      return {
        title: '人民医疗销客户端',
        imageUrl: this.imageUrl,
        // path: '/pages/index/index', // 当前小程序的路径（可选）
        // 0 - 微信小程序正式版 ；1 - 微信小程序开发版；2 - 微信小程序体验版
        type: 2, 
        
        // 👇 关键：指定跳转到其他小程序
        extraData: {
          'salesId': this.user.userId,
        }, // 可选，传递给目标小程序的数据
        
        // 目标小程序的 AppID 和页面路径
        targetAppId: 'wxe83a3700d3b60132', // 替换为目标小程序的 AppID
        targetType: 'miniProgram',          // 固定值
        targetPath: `pages/index/scan?salesId=${this.user.userId}` // 目标小程序的页面路径（可带参数）
      };
    }, */
		methods: {
      async getUserQrcode() {
        const res = await getwxqrcode({
          userId: this.user.userId,
        });
        if (res.code == 200) {
          this.imageUrl = res.qrcode;
        }
      },
      async downloadImage() {
        try {
          // 1. 检查是否已授权相册权限
          const authStatus = await this.checkPhotoAuth();
          if (!authStatus) {
            uni.showToast({ title: '未授权相册权限', icon: 'none' });
            return;
          }

          // 2. 下载图片到本地临时路径
          const tempFilePath = await this.downloadFile(this.imageUrl);
          
          // 3. 保存到相册
          await this.saveImage(tempFilePath);
          
          uni.showToast({ title: '保存成功', icon: 'success' });
        } catch (err) {
          console.error('保存失败:', err);
          uni.showToast({ title: '保存失败', icon: 'none' });
        }
      },

      // 检查并申请相册权限
      checkPhotoAuth() {
        return new Promise((resolve) => {
          uni.getSetting({
            success: (res) => {
              if (res.authSetting['scope.writePhotosAlbum']) {
                resolve(true); // 已授权
              } else {
                // 未授权，请求授权
                uni.authorize({
                  scope: 'scope.writePhotosAlbum',
                  success: () => resolve(true),
                  fail: () => {
                    // 引导用户手动开启权限
                    uni.showModal({
                      title: '权限提示',
                      content: '需要相册权限才能保存图片，请到设置中开启',
                      showCancel: true,
                      confirmText: '去设置',
                      success: (modalRes) => {
                        if (modalRes.confirm) {
                          uni.openSetting({
                            success: (settingRes) => {
                              const granted = settingRes.authSetting['scope.writePhotosAlbum'];
                              resolve(granted);
                            }
                          });
                        } else {
                          resolve(false);
                        }
                      }
                    });
                  }
                });
              }
            },
            fail: () => resolve(false)
          });
        });
      },

      // 下载文件
      downloadFile(url) {
        return new Promise((resolve, reject) => {
          uni.downloadFile({
            url: url,
            success: (res) => {
              if (res.statusCode === 200) {
                resolve(res.tempFilePath);
              } else {
                reject(new Error('下载失败：statusCode ≠ 200'));
              }
            },
            fail: (err) => {
              reject(err);
            }
          });
        });
      },

      // 保存图片到相册
      saveImage(filePath) {
        return new Promise((resolve, reject) => {
          uni.saveImageToPhotosAlbum({
            filePath: filePath,
            success: () => resolve(),
            fail: (err) => reject(err)
          });
        });
      },
      qrcodeToUser() {
        uni.downloadFile({
          url: this.imageUrl,
          success(res) {
            uni.showShareImageMenu({
              path: res.tempFilePath
            })
          }
        });
      },
      
      goSharePage() {
        console.log('跳转到客户端小程序的二维展示页')
        // https://your-domain.com/pages/index/scan?salesId=123
        uni.navigateToMiniProgram({
          appId: 'wxe83a3700d3b60132',
          path: 'pages/index/scan',
          extraData: {
            'salesId': this.user.userId
          },
        })
      },
		},
    
	}
</script>

<style lang="scss" scoped>
  .container {
    min-height: 100vh;
    padding: 0 40rpx;
    background-color: #F7F7F7;
    // border-radius: 20rpx 20rpx 0 0;
  }
  .content-wrap {
    // height: calc(100vh - 100rpx);
    // overflow-y: auto;
    padding-top: 100rpx;
    text-align: center;
    .welcome {
      font-weight: bold;
      font-size: 40rpx;
      color: #2C2C2C;
    }
    .welcome-description {
      margin-top: 28rpx;
      font-weight: 500;
      font-size: 28rpx;
      color: #898989;
    }
    
    .qrcode-card-wrap {
      margin-top: 122rpx;
      background-color: #fff;
      box-shadow: 0rpx 0rpx 36rpx 0rpx rgba(0,97,87,0.09);
      border-radius: 80rpx;
      display: flex;
      flex-direction: column;
      align-items: center;
      width: 670rpx;
      height: 674rpx;
      image {
        width: 115rpx;
        height: 115rpx;
        border-radius: 100%;
        margin-top: -60rpx;
      }
      .username {
        font-weight: bold;
        font-size: 32rpx;
        color: #313131;
        line-height: 72rpx;
        margin-top: 12rpx;
      }
      .description {
        margin-top: 52rpx;
        font-weight: bold;
        font-size: 28rpx;
        color: #9A9A9A;
        line-height: 48rpx;
      }
      .qrcode {
        image {
          width: 180rpx;
          height: 180rpx;
          margin-top: 114rpx;
          border-radius: 0;
        }
      }
    }
    .btn-wrap {
      display: flex;
      flex-direction: row;
      align-items: center;
      justify-content: center;
      gap: 20rpx;
      margin-top: 140rpx;
    }
  }
</style>
