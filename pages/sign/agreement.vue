<template>
    <view class="container" :style="{ paddingTop: containerPaddingTop }">
        <u-navbar
          :fixed="true"
          :autoBack="true"
          title="阅读协议"
          leftIconSize="36" leftIconColor="#2C2C2C"
          :titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }"
        >
        </u-navbar>
        
        <scroll-view class="content-container" scroll-y="true">
            <view class="auth-content">
                <text class="title">用户服务授权协议</text>
                <text class="paragraph">
                    欢迎您使用本平台提供的孕产服务。请您仔细阅读以下条款，特别是免除或者限制责任的条款、法律适用和争议解决条款。
                    当您勾选“已阅读并同意”时，即表示您已充分理解并接受本协议全部内容。
                </text>
                <text class="paragraph">
                    一、服务内容  
                    本平台为您提供孕期信息管理、医院预约、合同签署等服务。您需如实提供个人信息，并确保其真实、准确、完整。
                </text>
                <text class="paragraph">
                    二、信息使用  
                    您授权我方在服务过程中收集、存储、使用您的姓名、身份证号、联系方式、预产期等信息，仅用于本服务目的。
                </text>
                <text class="paragraph">
                    三、隐私保护  
                    我们将严格遵守《个人信息保护法》，采取合理措施保护您的信息安全，未经您同意不得向第三方披露。
                </text>
                <text class="paragraph">
                    四、免责声明  
                    如因不可抗力或您提供信息错误导致服务中断或损失，我方不承担责任。
                </text>
                <text class="paragraph">
                    五、协议修改  
                    我们有权根据业务调整更新本协议，更新后将通过平台公告方式通知，请您定期查阅。
                </text>
                <text class="paragraph">
                    六、法律适用  
                    本协议适用中华人民共和国法律。如发生争议，双方应友好协商；协商不成的，提交平台所在地法院诉讼解决。
                </text>
                <text class="paragraph">
                    七、生效条件  
                    本协议自您点击“已阅读并同意”之日起生效。
                </text>
                <text class="paragraph">
                    请您务必认真阅读以上内容。继续操作即视为您已完全理解并同意本授权书所有条款。
                </text>
                <!-- 再加一段撑高度 -->
                <text class="paragraph" v-for="i in 5" :key="i">
                    这是额外的占位段落 {{ i }}，用于确保内容超出屏幕高度，触发滚动效果。
                    请滑动页面以完整阅读授权书内容。系统将强制要求您阅读满 10 秒钟。
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
                    url: `/pages/sign/confirm-price?orderId=${this.orderId}`
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