<template>
	<view class="container">
		<!-- 主体内容区 -->
		<view class="content-wrapper">
			<!-- 成功图标 (带动画) -->
			<view class="icon-box">
				<image src="/static/icons/sign-success.png" mode="widthFix" class="success-icon"></image>
				<view class="ripple-effect"></view>
			</view>

			<!-- 标题 -->
			<text class="main-title">您已成功签约！</text>
			<text class="sub-title">正在为您准备支付环境...</text>

			<!-- 倒计时展示区 -->
			<view class="countdown-container">
				<!-- 环形进度条 (纯 CSS 实现) -->
				<view class="progress-ring">
					<svg width="120" height="120" viewBox="0 0 120 120" class="ring-svg">
						<!-- 背景圆环 -->
						<circle cx="60" cy="60" r="52" stroke="#F0F2F5" stroke-width="8" fill="none" />
						<!-- 进度圆环 (动态旋转) -->
						<circle 
							cx="60" 
							cy="60" 
							r="52" 
							stroke="#4A63E4" 
							stroke-width="8" 
							fill="none"
							stroke-dasharray="326" 
							stroke-dashoffset="326"
							:style="{ strokeDashoffset: dashOffset, transition: 'stroke-dashoffset 1s linear' }"
							transform="rotate(-90 60 60)"
							stroke-linecap="round"
						/>
					</svg>
					<!-- 中间数字 -->
					<view class="timer-text">
						<text class="num">{{ countdown }}</text>
						<text class="unit">s</text>
					</view>
				</view>
				
				<text class="tips-text">
					{{ countdown > 0 ? '自动发起支付' : '即将跳转...' }}
				</text>
			</view>

			<!-- 异常/手动干预区 (仅在非倒计时或出错时显示，或者始终显示一个小入口) -->
			<view class="action-area" v-if="!isAutoPaying || payError">
				<text class="manual-link" @click="toPay">
					{{ payError ? '支付准备失败，点击重试' : '不想等待？立即支付' }}
				</text>
			</view>
		</view>

		<!-- 底部版权或提示 (可选) -->
		<view class="footer-tip">
			<text>请勿关闭页面，以免订单失效</text>
		</view>
	</view>
</template>

<script>
	import * as api from '@/utils/api.js'
	import { mapState } from 'vuex'

	export default {
		data() {
			return {
				orderId: '',
				countdown: 5, // 倒计时秒数
				timer: null,
				isAutoPaying: false, // 是否正在自动流程中
				payError: false,     // 标记是否发生错误
				totalTime: 5
			};
		},
		computed: {
			...mapState(['user', 'token']),
			// 计算 SVG 圆环偏移量：周长 2*PI*R ≈ 326
			// offset = 周长 - (当前时间 / 总时间) * 周长
			dashOffset() {
				const circumference = 2 * Math.PI * 52; // 326.7
				const offset = circumference - (this.countdown / this.totalTime) * circumference;
				return offset;
			}
		},
		onLoad(options) {
			if (options.orderId) {
				this.orderId = options.orderId;
				this.startCountdown();
			} else {
				uni.showToast({ title: '订单号缺失', icon: 'none' });
			}
		},
		onUnload() {
			if (this.timer) clearTimeout(this.timer);
		},
		methods: {
			startCountdown() {
				this.isAutoPaying = true;
				this.payError = false;
				this.countdown = this.totalTime;

				// 预加载支付参数（可选优化：提前请求，倒计时结束时直接调起）
				this.preparePayment();

				this.timer = setInterval(() => {
					if (this.countdown > 1) {
						this.countdown--;
					} else {
						// 倒计时结束
						clearInterval(this.timer);
						this.countdown = 0;
						this.executePayment();
					}
				}, 1000);
			},

			// 预先获取支付参数，避免倒计时结束时网络卡顿
			async preparePayment() {
				if (!this.user.wxOpenId) return;
				try {
					const longId = this.user.wxOpenId.replace(/^"(.*)"$/, '$1');
					await api.createPayment({ longId, orderId: this.orderId });
					// 这里可以先存下参数，也可以等到 executePayment 再请求一次确保最新
				} catch (e) {
					console.log('预加载支付参数失败，将在点击或倒计时结束时重试');
				}
			},

			// 执行支付逻辑
			async executePayment() {
				if (!this.orderId) return;
				
				// 防止重复触发
				if (this.isProcessing) return;
				this.isProcessing = true;

				try {
					const longId = this.user.wxOpenId.replace(/^"(.*)"$/, '$1');
					const res = await api.createPayment({ longId, orderId: this.orderId });

					if (res.code !== 200 || !res.para) {
						throw new Error(res.msg || '获取支付参数失败');
					}

					const payData = res.para;
					
					// 调起微信支付
					await uni.requestPayment({
						timeStamp: String(payData.timeStamp),
						nonceStr: payData.nonceStr,
						package: payData.package,
						signType: payData.signType || 'MD5',
						paySign: payData.paySign
					});

					// 支付成功回调
					uni.showModal({
						title: '支付提示',
						content: '支付已完成？',
						showCancel: false,
						confirmText: '是的',
						success: () => {
							uni.redirectTo({
								url: '/pages/sign/pay-success?orderId=' + this.orderId
							});
						}
					});

				} catch (err) {
					this.isProcessing = false;
					this.isAutoPaying = false; // 停止自动流程
					this.payError = true;      // 显示错误状态

					if (err.errMsg && err.errMsg.includes('cancel')) {
						// 用户取消，通常不需要报错，但这里因为不是用户主动点的，所以提示一下
						uni.showToast({ title: '已取消支付', icon: 'none' });
					} else {
						uni.showToast({ title: '自动支付失败，请手动重试', icon: 'none' });
					}
				}
			},

			// 手动点击触发
			toPay() {
				if (this.timer) clearInterval(this.timer);
				this.isAutoPaying = false;
				this.executePayment();
			},

			viewOrder() {
				uni.redirectTo({ url: '/pages/order/order' });
			}
		}
	};
</script>

<style lang="scss" scoped>
	.container {
		min-height: 100vh;
		background-color: #FFFFFF;
		display: flex;
		flex-direction: column;
		align-items: center;
		padding-top: 15vh; // 顶部留白
		box-sizing: border-box;
	}

	.content-wrapper {
		display: flex;
		flex-direction: column;
		align-items: center;
		width: 100%;
		animation: fadeIn 0.8s ease-out;
	}

	/* 图标与涟漪动画 */
	.icon-box {
		position: relative;
		display: flex;
		justify-content: center;
		align-items: center;
		margin-bottom: 40rpx;

		.success-icon {
			width: 160rpx;
			height: 160rpx;
			z-index: 2;
			animation: popIn 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
		}

		.ripple-effect {
			position: absolute;
			width: 160rpx;
			height: 160rpx;
			border-radius: 50%;
			background-color: rgba(74, 99, 228, 0.1);
			z-index: 1;
			animation: ripple 2s infinite;
		}
	}

	.main-title {
		font-size: 40rpx;
		font-weight: 800;
		color: #151515;
		margin-bottom: 16rpx;
		letter-spacing: 1rpx;
	}

	.sub-title {
		font-size: 28rpx;
		color: #909399;
		margin-bottom: 60rpx;
	}

	/* 倒计时圆环 */
	.countdown-container {
		display: flex;
		flex-direction: column;
		align-items: center;
		margin-bottom: 40rpx;
	}

	.progress-ring {
		position: relative;
		width: 120px;
		height: 120px;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.ring-svg {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
	}

	.timer-text {
		display: flex;
		align-items: baseline;
		justify-content: center;
		z-index: 10;

		.num {
			font-size: 48px;
			font-weight: bold;
			color: #4A63E4;
			line-height: 1;
			font-family: DINAlternate-Bold, sans-serif; /* 如果有数字字体更好 */
		}

		.unit {
			font-size: 24rpx;
			color: #C0C4CC;
			margin-left: 4rpx;
			font-weight: 500;
		}
	}

	.tips-text {
		margin-top: 24rpx;
		font-size: 26rpx;
		color: #909399;
		letter-spacing: 1rpx;
	}

	/* 手动操作区 */
	.action-area {
		margin-top: 40rpx;
		height: 40rpx; /* 占位防止跳动 */

		.manual-link {
			font-size: 26rpx;
			color: #4A63E4;
			text-decoration: underline;
			text-underline-offset: 4rpx;
			opacity: 0.8;
			padding: 10rpx 20rpx;
			border-radius: 30rpx;
			background-color: rgba(74, 99, 228, 0.05);
		}
	}

	.footer-tip {
		position: absolute;
		bottom: 60rpx;
		font-size: 24rpx;
		color: #C0C4CC;
	}

	/* 动画定义 */
	@keyframes popIn {
		0% { transform: scale(0); opacity: 0; }
		100% { transform: scale(1); opacity: 1; }
	}

	@keyframes fadeIn {
		0% { opacity: 0; transform: translateY(20rpx); }
		100% { opacity: 1; transform: translateY(0); }
	}

	@keyframes ripple {
		0% { transform: scale(1); opacity: 0.6; }
		100% { transform: scale(2.5); opacity: 0; }
	}
</style>