<template>
<view class="flow-container">
		<!-- 加载状态 -->
		<u-loading-page 
			:loading="loading" 
			loading-text="正在核对信息..." 
			icon-size="80"
			font-size="32"
		/>

		<!-- 内容区域 (加载完成后显示，虽然时间很短，但防止闪烁) -->
		<view class="content-wrapper" v-if="!loading">
			<view class="status-box">
			<!-- 	<image src="/static/icons/checking.png" mode="aspectFit" class="status-icon"></image> -->
				<text class="status-text">正在为您加载服务...</text>
			</view>
		</view>
	</view>
</template>

<script>
	import * as api from '@/utils/api.js'
	import {
		mapState
	} from 'vuex';
	
	
	export default {
		computed: {
			...mapState(['token', 'user'])
		},
		data() {
			return {
				loading: true,
				salesId: null,
				currentStatusId: null
			}
		},
		onLoad(){
			this.salesId = uni.getStorageSync('SCAN_SALES_ID');
			if (this.salesId && this.user) {
				this.checkOrderStatus();
			}
		},
		methods: {
			// 获取订单流程ID
			getCurrentStatusId(order) {
			    const progress = order?.orderProgress;
			    
			    if (!Array.isArray(progress) || progress.length === 0) {
			        return 0; // 默认为未签约
			    }
			
			    // 2. 从后往前遍历
			    // 找到第一个 Status 为 "1" (已完成) 的项
			    for (let i = progress.length - 1; i >= 0; i--) {
			        const step = progress[i];
			        
			        // 兼容 id 或 Id 字段
			        const stepIdVal = step.id || step.Id;
			        
			        // 获取 Status 字段
			        const statusVal = String(step.Status || '').trim();
			
			        // 核心判断：Status 必须为 "1"
			        if (statusVal === '1') {
			            // 找到了最后一个已完成的步骤，返回其 ID
			            return Number(stepIdVal);
			        }
			    }
			
			    // 3. 如果没有已完成的步骤，返回 0
			    return 0; 
			},
			
			// 检查订单状态
			async checkOrderStatus() {
				this.loading = true;
			
				try {
					// 调用接口获取当前用户所有订单
					const res = await api.getFdpOrderListForUser(this.user.userId, null, null);
			
					if (res.code !== 200) {
						throw new Error(res.msg || '获取订单失败');
					}
			
					const allOrders = res.rows || [];
			
					// 1. 筛选出当前销售人员 (salesId) 的订单
					const mySalesOrders = allOrders.filter(item => Number(item.salesId) === Number(this.salesId));
			
					if (mySalesOrders.length === 0) {
						// 没有该销售的订单，直接开始新流程
						this.goToIntro();
						return;
					}
			
					// 2. 按创建时间倒序排序，找到最新的一条
					// 确保 createTime 可比较，字符串格式 "YYYY-MM-DD HH:mm:ss" 可直接比较
					mySalesOrders.sort((a, b) => {
						return new Date(b.createTime).getTime() - new Date(a.createTime).getTime();
					});
			
					const latestOrder = mySalesOrders[0];
					console.log('最新订单:', latestOrder);
					const lastStatusId = this.getCurrentStatusId(latestOrder);
			
					// 3. 判断状态
					if ((latestOrder.proStatus == 2) || (latestOrder.proStatus == 1 && latestOrder.orderStatus==11 && lastStatusId < 8)) {
						// 发现未完成订单
						uni.showModal({
							title: '提示',
							//content: `您有一笔未完成的订单（单号：${latestOrder.orderCode}），是否继续处理该订单？`,
							content:'当前存在未完成协议',
							confirmText:'继续处理',
							cancelText: '重新签订',
							success: (modalRes) => {
								this.loading = false;
								if (modalRes.confirm) {
									// 用户选“是”：处理未完成订单
									this.handleUnfinishedOrder(latestOrder);
								} else if (modalRes.cancel) {
									// 用户选“否”：强制开始新流程
									this.goToIntro();
								}
							},
							fail: () => {
								this.loading = false;
								this.goToIntro(); // 弹窗失败默认走新流程
							}
						});
					} else {
						// 最新订单已完成，或没有未完成订单，直接新流程
						this.goToIntro();
					}
			
				} catch (error) {
					console.error('订单检查失败:', error);
					this.loading = false;
					uni.showToast({
						title: '网络异常，稍后重试',
						icon: 'none'
					});
					// 失败情况下，是否允许进入新流程？通常允许
					setTimeout(() => {
						this.goToIntro();
					}, 1500);
				}
			},
			// 处理未完成订单
			handleUnfinishedOrder(orderData) {
				const orderId = orderData.id;

				// 继续编辑
				if (orderData.proStatus == 2) {
					uni.redirectTo({
						url: `/pages/sign/confirm-price?orderId=${orderId}`
					})
				}
				
				// 去支付
				if (orderData.proStatus  == 1 && orderData.orderStatus == 11) {
					uni.redirectTo({
						url: `/pages/sign/success?orderId=${orderId}`
					})
				}
			},
			// 开始新流程
			goToIntro() {
				this.loading = false;
				uni.redirectTo({
					url: `/pages/index/intro`
				});
			}
		}
	}
</script>

<style lang="scss" scoped>
	.flow-container {
		min-height: 100vh;
		background-color: #F5F7FA;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.content-wrapper {
		width: 100%;
		display: flex;
		justify-content: center;
		animation: fadeIn 0.5s ease;
	}

	.status-box {
		display: flex;
		flex-direction: column;
		align-items: center;
	}

	.status-icon {
		width: 120rpx;
		height: 120rpx;
		margin-bottom: 30rpx;
		/* 如果没有具体图标，可以用一个占位圆 */
		border-radius: 50%;
		background-color: #E8ECF3; 
	}

	.status-text {
		font-size: 28rpx;
		color: #909399;
		font-weight: 500;
		letter-spacing: 1rpx;
	}

	@keyframes fadeIn {
		from { opacity: 0; transform: translateY(20rpx); }
		to { opacity: 1; transform: translateY(0); }
	}
</style>