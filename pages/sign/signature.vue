<template>
	<view class="container">
		<web-view :src="decodedSignUrl" style="width: 100vw; height: 100vh;" @message="handleGetMessage" />
		<view v-if="isReloading" class="reload-tip">页面刷新中...</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				type: 1,
				orderId: '',
				decodedSignUrl: '',
				isReloading: false, // 刷新状态提示
				templateIds: [
					"YnLqN20dZlxS-LlCHfdvxokPKrp0uSfUbZHyjiNIzFQ", // 待付款提醒
					"IjovGGgSUVmHQL0MePBzbShAAxnRzhVGRkGrA5KrPNE", // 订单取消通知 
				],
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
			/**
			 * 【新增】供中间页调用的刷新方法
			 * 当从公证签小程序刷脸返回后，中间页会调用此方法刷新 web-view
			 */
			reloadPage(url) {
				console.log('---signature reloadPage 被调用', url);
				if (url) {
					this.isReloading = true;
					// 更新 web-view 的 src 触发刷新
					this.decodedSignUrl = url;
					// 延迟关闭提示
					setTimeout(() => {
						this.isReloading = false;
					}, 1000);
				}
			},
			jump() {
				let templateId = '';
				if (this.type == 1) {
					templateId = this.templateIds[0];
				}
				if (this.type == 2) {
					templateId = this.templateIds[1];
				}

				uni.requestSubscribeMessage({
					tmplIds: [templateId],
					success: (res) => {
						console.log('订阅结果:', res);
						// 可选：记录 accept 状态用于按钮展示（此处可忽略）
					},
					fail: (err) => {
						console.warn('订阅失败:', err);
						// 即使失败也不阻塞跳转，保证核心流程
					},
					complete: () => {
						// 无论成功失败，都执行跳转
						this.performJump();
					}
				});
			},
			performJump() {
				if (this.type == 1) {
					uni.reLaunch({
						url: `/pages/sign/success?orderId=${this.orderId}`
					});
				} else if (this.type == 2) {
					uni.redirectTo({
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

	.reload-tip {
		position: fixed;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		background: rgba(0, 0, 0, 0.7);
		color: white;
		padding: 20rpx 40rpx;
		border-radius: 40rpx;
		font-size: 28rpx;
		z-index: 999;
	}
</style>