<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" title="阅读授权书" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }" />

		<!-- 内容区域 -->
		<scroll-view class="content-container" scroll-y="true">

			<!-- 美化后的合同卡片 -->
			<view class="contract-card" @click="previewContract">
				<!-- 左侧图标区 -->
				<view class="card-icon-box">
					<view class="icon-bg"></view>
					<u-icon name="file-text" size="48" color="#4A63E4" bold></u-icon>
				</view>

				<!-- 右侧内容区 -->
				<view class="card-content">
					<view class="card-title">查看授权书和合同</view>
					<view class="card-desc">请点击查看并仔细阅读协议内容</view>

					<!-- 状态标签 -->
					<view class="card-tag">
						<u-icon name="info-circle" size="24" color="#4A63E4"></u-icon>
						<text>点击预览</text>
					</view>
				</view>

				<!-- 右侧箭头 -->
				<view class="card-arrow">
					<u-icon name="arrow-right" size="30" color="#C0C4CC"></u-icon>
				</view>
			</view>

			<!-- 提示文本 -->
			<view class="tips-section">
				<u-icon name="info-circle" size="32" color="#F59E42"></u-icon>
				<text class="tips-text">请务必仔细阅读合同条款，确认无误后点击下方同意按钮</text>
			</view>

		</scroll-view>

		<!-- 底部按钮 (移除了倒计时逻辑，始终可用) -->
		<view class="btn-group">
			<u-button :custom-style="prevBtnStyle" @click="goPrev">
				上一步
			</u-button>
			<u-button :custom-style="nextBtnStyle" @click="nextPage">
				已阅读并同意
			</u-button>
		</view>
	</view>
</template>

<script>
	import $C from '@/utils/config.js';

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
					//backgroundColor: this.countdown > 0 ? '#D1D6F5' : '#4A63E4',
					backgroundColor: '#4A63E4',
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
				orderId: 0,
				imgUrl: '',
				pdfUrl1: 'https://dhm-test.rmylcare.com/uploadPath/upload/contract1.pdf',
				pdfUrl2: 'https://dhm-test.rmylcare.com/uploadPath/upload/contract2.pdf'
			};
		},
		onLoad(options) {
			if (options.orderId) {
				this.orderId = options.orderId;
			} else {
				uni.showToast({
					title: "获取订单失败",
					icon: 'none'
				});
			}
			//this.startCountdown();
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
			previewContract() {
				uni.showLoading({
					title: '加载合同中...',
					mask: true
				});

				let fileUrl = this.imgUrl + this.pdfUrl1;

				wx.downloadFile({
					url: fileUrl,
					success: (res) => {
						if (res.statusCode === 200) {
							const filePath = res.tempFilePath;
							wx.openDocument({
								filePath: filePath,
								showMenu: true,
								success: () => {
									console.log('打开文档成功');
								},
								fail: (err) => {
									uni.showToast({
										title: '打开文件失败',
										icon: 'none'
									});
									console.error(err);
								},
								complete: () => {
									uni.hideLoading();
								}
							});
						} else {
							uni.hideLoading();
							uni.showToast({
								title: '文件下载失败',
								icon: 'none'
							});
						}
					},
					fail: (err) => {
						uni.hideLoading();
						uni.showToast({
							title: '网络错误',
							icon: 'none'
						});
						console.error(err);
					}
				});
			},
			goPrev() {
				uni.navigateBack();
			},
			nextPage() {
				//if (this.countdown > 0) return; // 安全兜底
				// uni.navigateTo({
				// 	url: `/pages/sign/agreement?orderId=${this.orderId}` // 用户服务授权协议
				// });
				uni.redirectTo({
					url: `/pages/sign/confirm-price?orderId=${this.orderId}` // 确认价格并签字
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
        margin-top: 74rpx; /* 保持原间距 */
        padding: 40rpx 30rpx;
        box-sizing: border-box;
    }

    /* --- 合同卡片样式 --- */
    .contract-card {
        background: #FFFFFF;
        border-radius: 24rpx;
        padding: 40rpx 30rpx;
        display: flex;
        align-items: center;
        box-shadow: 0 8rpx 24rpx rgba(74, 99, 228, 0.08);
        border: 2rpx solid #EDEFF5;
        margin-bottom: 40rpx;
        position: relative;
        overflow: hidden;
        
        /* 点击态 */
        &:active {
            background-color: #F5F7FA;
            transform: scale(0.98);
            transition: all 0.1s;
        }

        .card-icon-box {
            position: relative;
            width: 100rpx;
            height: 100rpx;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-right: 30rpx;
            flex-shrink: 0;

            .icon-bg {
                position: absolute;
                width: 100%;
                height: 100%;
                background-color: rgba(74, 99, 228, 0.1);
                border-radius: 50%;
            }
        }

        .card-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;

            .card-title {
                font-size: 32rpx;
                font-weight: bold;
                color: #2C2C2C;
                margin-bottom: 12rpx;
            }

            .card-desc {
                font-size: 26rpx;
                color: #909399;
                margin-bottom: 16rpx;
            }

            .card-tag {
                display: flex;
                align-items: center;
                font-size: 24rpx;
                color: #4A63E4; /* 改为蓝色，表示可操作 */
                font-weight: 500;
                
                text {
                    margin-left: 6rpx;
                }
            }
        }

        .card-arrow {
            margin-left: 20rpx;
            opacity: 0.6;
        }
    }

    /* --- 提示区域样式 --- */
    .tips-section {
        display: flex;
        align-items: flex-start;
        background-color: #FFF7E6;
        padding: 30rpx;
        border-radius: 16rpx;
        border: 1rpx solid #FFE7BA;

        .tips-text {
            margin-left: 16rpx;
            font-size: 26rpx;
            color: #E6A23C;
            line-height: 1.5;
            flex: 1;
        }
    }

    .btn-group {
        display: flex;
        justify-content: space-between;
        margin-bottom: 120rpx;
        margin-top: 40rpx; /* 稍微增加上方间距，因为去掉了倒计时区域 */
    }
</style>