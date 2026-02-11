<template>
	<view class="container">
		<web-view :src="decodedSignUrl" style="width: 100vw; height: 100vh;" @message="handleGetMessage" />
	</view>
</template>

<script>
	export default {
		data() {
			return {
				type: 1,
				orderId: '',
				decodedSignUrl: ''
			};
		},
		onLoad(options) {
			if (options.orderId) {
				this.orderId = options.orderId
			} else {
				uni.showToast({
					title: '无效订单',
					icon: 'none'
				});
				setTimeout(() => uni.navigateBack(), 1500);
				return;
			}

			if (options.type) {
				this.type = options.type;
			}

			if (options.signUrl) {
				this.decodedSignUrl = decodeURIComponent(options.signUrl);
			} else {
				uni.showToast({
					title: '无效链接',
					icon: 'none'
				});
				setTimeout(() => uni.navigateBack(), 1500);
			}
		},
		methods: {
			handleGetMessage(e) {
				console.log('收到 web-view 消息:', e);

				// 安全判断：确保 data 存在且为非空数组
				if (!e.detail || !Array.isArray(e.detail.data) || e.detail.data.length === 0) {
					return;
				}

				const message = e.detail.data[0];

				// 判断是否为 e签宝的成功回调（根据实际字段调整）
				if (message && message.result === 'success') {
					uni.showModal({
						title: '签署完成确认',
						content: '您已完成电子签署？',
						confirmText: '已完成',
						showCancel: false,
						success: (res) => {
							if (res.confirm) {
								// 用户点击“确认”
								this.jump();
							}
						},
						fail: (err) => {
							console.error('弹窗失败:', err);
							this.isSigning = false;
						}
					});
				}
			},
			jump() {
				if (this.type == 1) {
					uni.reLaunch({ // 签约成功，销毁页面栈，不允许再返回前面的操作
						url: `/pages/sign/success?orderId=${this.orderId}`
					});
				}
				if (this.type == 2) {
					uni.redirectTo({ // 解约成功
						url: `/pages/refund/cancel-success?orderId=${this.orderId}`
					});
				}
			}
		}
	};
</script>

<style scoped>
	.container {
		width: 100vw;
		height: 100vh;
		position: relative;
	}

	.tip {
		position: absolute;
		bottom: 20rpx;
		left: 0;
		right: 0;
		text-align: center;
		color: #666;
		font-size: 24rpx;
	}
</style>