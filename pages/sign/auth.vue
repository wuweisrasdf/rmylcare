<template>
    <view class="container" :style="{ paddingTop: containerPaddingTop }">
        <u-navbar
          :fixed="true"
          :autoBack="true"
          title="阅读授权书"
          leftIconSize="36" leftIconColor="#2C2C2C"
          :titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }"
        >
        </u-navbar>
        
        <scroll-view class="content-container" scroll-y="true">
            <view class="auth-content">
              <text class="title">用户授权书</text>
              
              <text class="paragraph">
                尊敬的用户：感谢您选择“智数健管”平台（由人民医疗管理有限公司运营）提供的孕产健康管理服务。为保障您的合法权益，请您在使用本服务前，认真阅读并充分理解以下授权条款。当您勾选“已阅读并同意”时，即视为您已完全知悉、理解并自愿接受本授权书全部内容。
              </text>
            
              <text class="paragraph">
                一、授权目的  
                您授权人民医疗管理有限公司（以下简称“我们”或“平台”）在为您提供孕期建档、医院预约、电子签约、健康随访等服务过程中，依法收集、存储、使用、传输您的个人信息，包括但不限于：姓名、性别、身份证号码、手机号码、预产期、预产医院、常住地址、健康状况等必要信息。
              </text>
            
              <text class="paragraph">
                二、授权范围  
                您授权我们：
                （1）将您的信息用于身份核验、服务履约、订单管理及售后服务；
                （2）在必要范围内与合作医疗机构、物流服务商、支付机构等第三方共享信息，以完成服务交付；
                （3）基于改善服务质量、开展健康评估等目的，在匿名化或去标识化前提下进行数据分析。
              </text>
            
              <text class="paragraph">
                三、隐私保护承诺  
                我们严格遵守《中华人民共和国个人信息保护法》《数据安全法》等法律法规，采取加密存储、访问控制、安全审计等技术和管理措施，防止您的信息泄露、篡改或丢失。未经您明确同意，我们不会向无关第三方披露您的敏感个人信息。
              </text>
            
              <text class="paragraph">
                四、特别提示  
                您理解并同意：如因您提供虚假、错误或不完整信息，或未及时更新信息，导致服务无法正常提供或产生纠纷，相关责任由您自行承担。因不可抗力（如自然灾害、网络故障、政策调整等）导致服务中断的，平台不承担违约责任。
              </text>
            
              <text class="paragraph">
                五、授权期限  
                本授权自您点击“已阅读并同意”之日起生效，持续至您注销账户或服务关系终止后法律法规要求的最短保存期限届满为止。
              </text>
            
              <text class="paragraph">
                六、权利声明  
                您有权随时通过“我的-设置”查看、更正、删除个人信息，或撤回部分授权（但可能影响服务使用）。如对本授权有疑问，可联系客服电话：010-85795849 或邮箱：medical@rmylcare.com。
              </text>
            
              <text class="paragraph">
                请您务必审慎阅读、充分理解上述条款。继续操作即表明您已完全同意本授权书所有内容，并自愿承担相应法律后果。
              </text>
            </view>
        </scroll-view>
        
        <view class="reading-time">
            <view v-if="showLoading">
                <u-loading-icon size="28"></u-loading-icon>
            </view>
            <view class="reading-text">阅读时间 <text class="countdown">{{ countdown }}</text> 秒</view>
        </view>

        <!-- 底部按钮 -->
        <view class="btn-group">
            <u-button :custom-style="prevBtnStyle" @click="goPrev">
                上一步
            </u-button>
            <u-button 
                :custom-style="nextBtnStyle" 
                @click="nextPage"
                :disabled="countdown > 0"
            >
                已阅读并同意
            </u-button>
        </view>
    </view>
</template>

<script>
    export default {
        computed: {
            containerPaddingTop() {
                const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
                return barHeight;
            },
            prevBtnStyle() {
                return {
                    height: '98rpx',
                    borderRadius: '49rpx',
                    backgroundColor: '#FFFFFF',
                    border: '2px solid rgba(142,142,142,0.5)',
                    color: '#3D3D3D',
                    fontSize: '32rpx',
                    fontWeight: 'bold',
                    marginRight: '26rpx',
                };
            },
            nextBtnStyle() {
                return {
                    height: '98rpx',
                    borderRadius: '49rpx',
                    backgroundColor: this.countdown > 0 ? '#D1D6F5' : '#4A63E4',
                    color: '#FFFFFF',
                    fontSize: '32rpx',
                    fontWeight: 'bold',
                };
            }
        },
        data() {
            return {
                showLoading: true,
                countdown: 10,
                timer: null,
				orderId: 0
            };
        },
        onLoad(options) {
			if (options.orderId) {
				this.orderId = options.orderId;
			}else{
				uni.showToast({
					title: "获取订单失败",
					icon: 'none'
				});
			}
            this.startCountdown();
        },
        onUnload() {
            // 页面卸载时清除定时器，防止内存泄漏
            if (this.timer) {
                clearInterval(this.timer);
                this.timer = null;
            }
        },
        methods: {
            startCountdown() {
                this.timer = setInterval(() => {
                    if (this.countdown > 0) {
                        this.countdown--;
                    } else {
                        clearInterval(this.timer);
                        this.timer = null;
                        this.showLoading = false;
                    }
                }, 1000);
            },
            goPrev() {
                uni.navigateBack();
            },
            nextPage() {
                if (this.countdown > 0) return; // 安全兜底
                uni.navigateTo({
                    url: `/pages/sign/agreement?orderId=${this.orderId}`
                });
            }
        }
    };
</script>

<style lang="scss" scoped>
    .container {
        background-color: #ffffff;
        padding: 0 26rpx;
        min-height: 100vh;
        box-sizing: border-box;
        position: relative;
        display: flex;
        flex-direction: column;
    }

    .content-container {
        flex: 1;
        background-color: #f9fbff;
        border-radius: 20rpx;
        margin-top: 74rpx;
        padding: 40rpx 30rpx;
        box-sizing: border-box;
    }

    .auth-content {
        .title {
            font-size: 36rpx;
            font-weight: bold;
            color: #000000;
            display: block;
            margin-bottom: 30rpx;
        }
        .paragraph {
            font-size: 28rpx;
            color: #333333;
            line-height: 1.6;
            display: block;
            margin-bottom: 24rpx;
            text-align: justify;
        }
    }

    .reading-time {
        display: flex;
        flex-direction: row;
        margin: 46rpx auto;
        justify-content: center;
        align-items: center;
    }

    .reading-text {
        margin-left: 20rpx;
        font-size: 28rpx;
        color: #666666;
    }

    .countdown {
        color: #4A63E2;
        font-size: 32rpx;
        font-weight: bold;
    }

    .btn-group {
        display: flex;
        justify-content: space-between;
        margin-bottom: 120rpx;
    }
</style> 