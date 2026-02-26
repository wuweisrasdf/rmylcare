<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" title="电子协议" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<view class="content-container">
			<!-- 加载中状态 -->
			  <u-loading-page 
			    v-if="loading" 
			    loadingText="协议查询中..." 
			    :loading="true"
			    iconSize="48"
				fontSize="32"
			    color="#4A63E4"
			    style="height: 100%;"
			  />
			
			<!-- 协议列表 -->
			<view v-else class="protocol-list">
				<!-- 签约协议 -->
				<view class="protocol-card" v-if="signUrl" @click="viewPdf(1)">
					<view class="protocol-header">
						<view class="protocol-icon signed">
							<u-icon name="file-text-fill" size="40" color="#fff"></u-icon>
						</view>
						<view class="protocol-info">
							<view class="protocol-title">签约协议</view>
							<view class="protocol-desc">查看您签署的正式协议</view>
						</view>
					</view>
					<view class="protocol-status">
						<view class="status-tag signed-tag">已签署</view>
						<u-icon name="arrow-right" size="28" color="#999"></u-icon>
					</view>
				</view>

				<!-- 解约协议 -->
				<view class="protocol-card" v-if="unsignUrl" @click="viewPdf(2)">
					<view class="protocol-header">
						<view class="protocol-icon unsign">
							<u-icon name="close-circle-fill" size="40" color="#fff"></u-icon>
						</view>
						<view class="protocol-info">
							<view class="protocol-title">解约协议</view>
							<view class="protocol-desc">查看解约相关协议文件</view>
						</view>
					</view>
					<view class="protocol-status">
						<view class="status-tag unsign-tag">已解约</view>
						<u-icon name="arrow-right" size="28" color="#999"></u-icon>
					</view>
				</view>

				<!-- 空状态 -->
				<view class="empty-state" v-if="!signUrl && !unsignUrl">
					<u-empty text="暂无协议文件" mode="file" iconSize="120"></u-empty>
				</view>
			</view>

			<!-- 协议说明 -->
			<view v-if="!loading" class="protocol-tips">
				<view class="tips-header">
					<u-icon name="info-circle-fill" size="32" color="#4A63E4"></u-icon>
					<text class="tips-title">温馨提示</text>
				</view>
				<view class="tips-content">
					<text>• 点击上方卡片可查看协议详情</text>
					<text>• 如需下载保存，请在预览页面操作</text>
					<text>• 客服电话：010-85795849</text>
				</view>
			</view>
		</view>

		<!-- 底部按钮 - 恢复原样 -->
		<view class="btn-group">
			<u-button :custom-style="primaryBtnStyle" @click="goHome">
				返回首页
			</u-button>
		</view>
	</view>
</template>

<script>
	import * as api from '@/utils/api.js'
	import {
		mapState
	} from 'vuex'

	export default {
		computed: {
			...mapState({
				user: state => state.user,
				token: state => state.token,
			}),
			containerPaddingTop() {
				const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
				return barHeight;
			},
			primaryBtnStyle() {
				return {
					height: '98rpx',
					borderRadius: '49rpx',
					backgroundColor: '#4A63E4',
					fontWeight: 'bold',
					fontSize: '32rpx',
					color: '#FFFFFF'
				};
			}
		},
		onLoad(options) {
			if (options.orderId) {
				this.orderId = options.orderId;
				this.init();
			}
		},
		data() {
			return {
				orderId: '',
				signUrl: '',
				unsignUrl: '',
				loading: false
			};
		},
		methods: {
			async init() {
				this.loading = true;
				try {
					const res = await api.downloadSignedFile(this.orderId);
					if (res.code == 200) {
						if (res.downloadUrl1) {
							this.signUrl = res.downloadUrl1;
						}
						if (res.downloadUrl2) {
							this.unsignUrl = res.downloadUrl2;
						}
						
						// 如果没有协议
						if (!this.signUrl && !this.unsignUrl) {
							uni.showToast({
								title: '当前订单暂无协议',
								icon: 'none'
							});
						}
					} else {
						uni.showToast({
							title: res.msg || '加载失败',
							icon: 'none'
						});
					}
				} catch (error) {
					console.error('加载协议失败:', error);
					uni.showToast({
						title: '网络错误',
						icon: 'none'
					});
				} finally {
					this.loading = false;
				}
			},
			
			async viewPdf(type) {
				let pdfUrl = type == 1 ? this.signUrl : this.unsignUrl;
				if (!pdfUrl) return;

				uni.showLoading({
					title: '加载协议中...'
				});

				try {
					const res = await uni.downloadFile({
						url: pdfUrl
					});

					if (res.statusCode === 200) {
						uni.openDocument({
							filePath: res.tempFilePath,
							fileType: 'pdf',
							success: () => {
								console.log('PDF打开成功');
							},
							fail: (err) => {
								console.error('打开PDF失败', err);
								uni.showToast({
									title: '无法打开协议文件',
									icon: 'none'
								});
							}
						});
					} else {
						uni.showToast({
							title: '协议加载失败',
							icon: 'none'
						});
					}
				} catch (err) {
					console.error('下载PDF出错', err);
					uni.showToast({
						title: '网络错误',
						icon: 'none'
					});
				} finally {
					uni.hideLoading();
				}
			},
			
			goHome() {
				uni.redirectTo({
					url: "/pages/index/index"
				});
			}
		}
	};
</script>

<style lang="scss" scoped>
	.container {
		background-color: #F5F7FA;
		min-height: 100vh;
		display: flex;
		flex-direction: column;
	}

	.content-container {
		flex: 1;
		padding: 30rpx;
		padding-bottom: 160rpx;
	}

	.protocol-list {
		display: flex;
		flex-direction: column;
		gap: 30rpx;
	}

	.protocol-card {
		background: #FFFFFF;
		border-radius: 24rpx;
		padding: 32rpx;
		display: flex;
		justify-content: space-between;
		align-items: center;
		box-shadow: 0 6rpx 20rpx rgba(0, 0, 0, 0.04);
		transition: all 0.3s ease;
		
		&:active {
			transform: translateY(-4rpx);
			box-shadow: 0 10rpx 30rpx rgba(0, 0, 0, 0.08);
		}
	}

	.protocol-header {
		display: flex;
		align-items: center;
		flex: 1;
	}

	.protocol-icon {
		width: 80rpx;
		height: 80rpx;
		border-radius: 20rpx;
		display: flex;
		align-items: center;
		justify-content: center;
		margin-right: 24rpx;
		
		&.signed {
			background: linear-gradient(135deg, #4A63E4, #6B8EFF);
		}
		
		&.unsign {
			background: linear-gradient(135deg, #FF6B6B, #FF8E8E);
		}
	}

	.protocol-info {
		flex: 1;
	}

	.protocol-title {
		font-size: 32rpx;
		font-weight: bold;
		color: #2C2C2C;
		margin-bottom: 8rpx;
	}

	.protocol-desc {
		font-size: 26rpx;
		color: #999999;
	}

	.protocol-status {
		display: flex;
		align-items: center;
		gap: 16rpx;
	}

	.status-tag {
		padding: 8rpx 20rpx;
		border-radius: 20rpx;
		font-size: 24rpx;
		font-weight: bold;
		
		&.signed-tag {
			background: rgba(74, 99, 228, 0.1);
			color: #4A63E4;
		}
		
		&.unsign-tag {
			background: rgba(255, 107, 107, 0.1);
			color: #FF6B6B;
		}
	}

	.empty-state {
		padding: 80rpx 0;
	}

	.protocol-tips {
		margin-top: 50rpx;
		background: #FFFFFF;
		border-radius: 20rpx;
		padding: 30rpx;
		box-shadow: 0 4rpx 16rpx rgba(0, 0, 0, 0.04);
	}

	.tips-header {
		display: flex;
		align-items: center;
		margin-bottom: 24rpx;
		
		.tips-title {
			font-size: 30rpx;
			font-weight: bold;
			color: #2C2C2C;
			margin-left: 12rpx;
		}
	}

	.tips-content {
		display: flex;
		flex-direction: column;
		gap: 16rpx;
		
		text {
			font-size: 26rpx;
			color: #666666;
			line-height: 1.6;
			position: relative;
			padding-left: 20rpx;
			
			&::before {
				content: '';
				position: absolute;
				left: 0;
				top: 50%;
				transform: translateY(-50%);
				width: 8rpx;
				height: 8rpx;
				background: #4A63E4;
				border-radius: 50%;
			}
		}
	}

	/* 底部按钮样式 - 恢复原样 */
	.btn-group {
		display: flex;
		flex-direction: column;
		gap: 22rpx;
		width: 100%;
		margin: 50rpx auto 120rpx;
		padding: 0 26rpx;
		box-sizing: border-box;
	}

	.loading-container {
		display: flex;
		align-items: center;
		justify-content: center;
		height: 200rpx;
		
		.loading-text {
			margin-left: 20rpx;
			font-size: 28rpx;
			color: #666;
		}
	}
</style>