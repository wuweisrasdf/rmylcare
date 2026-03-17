<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar 
			:fixed="true" 
			:autoBack="false" 
			title="订单列表" 
			leftIconSize="36" 
			leftIconColor="#2C2C2C"
			@leftClick="goHome" 
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<view class="tab-switch">
			<view 
				class="tab-item" 
				:class="{ active: currentTab === 'inProgress' }" 
				@click="switchTab('inProgress')">
				进行中
			</view>
			<view 
				class="tab-item" 
				:class="{ active: currentTab === 'completed' }" 
				@click="switchTab('completed')">
				已完成
			</view>
		</view>

		<!-- 内容区域：使用 flex + overflow 控制滚动 -->
		<view class="content-container">
			<view v-if="filteredList.length > 0">
				<view 
					v-for="(item, index) in filteredList" 
					:key="index" 
					class="order-card"
					@click="showDetail(item.id)">
					
					<!-- 姓名 + 状态标签 -->
					<view class="header">
						<text class="name">{{ item.motherName }}</text>
						<view class="status-tag" :class="item.statusClass">
							{{ item.statusTxt }}
						</view>
					</view>

					<view class="info-row">
						<view class="field">
							<text class="label">预产期:</text>
							<text class="value">{{ item.dueDate }}</text>
						</view>
						<view class="field">
							<text class="label">协议号:</text>
							<text class="value">{{ item.orderCode }}</text>
						</view>
					</view>
					
					<view class="info-row">
						<view class="field">
							<text class="label">签约日期:</text>
							<text class="value">{{ item.signDate | formatDate }}</text>
						</view>
						<view class="field"></view>
					</view>

					<view class="hospital-row">
						<text class="label">预产医院:</text>
						<text class="hospital-value">{{ item.hospitalName }}</text>
					</view>
				</view>
			</view>

			<view v-if="filteredList.length === 0" class="empty-wrapper">
				<u-empty text="暂无记录" mode="order" textSize="28" iconSize="90"></u-empty>
			</view>
		</view>

		<!-- <view class="no-more" v-if="pageOptions.is_end">没有更多了</view> -->
	</view>
</template>

<script>
	import * as api from '@/utils/api.js'
	import { mapState } from 'vuex'

	export default {
		filters: {
			formatDate(value) {
				if (!value) return '';
				const date = new Date(value);
				if (isNaN(date.getTime())) {
					return String(value).substring(0, 10);
				}
				const year = date.getFullYear();
				const month = String(date.getMonth() + 1).padStart(2, '0');
				const day = String(date.getDate()).padStart(2, '0');
				return `${year}-${month}-${day}`;
			}
		},
		computed: {
			...mapState({
				user: state => state.user,
				token: state => state.token,
			}),
			containerPaddingTop() {
				const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
				return barHeight;
			},
			filteredList() {
				if (this.currentTab === 'inProgress') {
					return this.list.filter(item => !['已完成','协议解除', '已退款'].includes(item.statusTxt));
				} else {
					return this.list.filter(item => ['已完成','协议解除', '已退款'].includes(item.statusTxt));
				}
			}
		},
		onPullDownRefresh() {
			this.init();
			setTimeout(() => uni.stopPullDownRefresh(), 1000);
		},
		onReachBottom() {
			if (!this.pageOptions.is_end) {
				this.pageOptions.page++;
				this.getList();
			}
		},
		onLoad() {
			this.init();
		},
		data() {
			return {
				currentTab: 'inProgress',
				pageOptions: {
					page: 1,
					total: 0,
					pageSize: 10,
					is_end: false
				},
				list: []
			};
		},
		methods: {
			goHome() {
				uni.redirectTo({ url: '/pages/index/index' });
			},
			switchTab(tab) {
				this.currentTab = tab;
			},
			resetPage() {
				this.pageOptions.page = 1;
				this.pageOptions.total = 0;
				this.pageOptions.is_end = false;
				this.list = [];
			},
			init() {
				this.resetPage();
				this.getList();
			},
			showDetail(orderId) {
				uni.navigateTo({ url: `/pages/order/detail?orderId=${orderId}` });
			},
			async getList() {
				try {
					let userId = this.user.userId;
					const res = await api.getFdpOrderListForUser(userId, null, null);
					if (res.code !== 200) {
						uni.showToast({ title: res.msg || '请求失败', icon: 'none' });
						return;
					}

					let rows = res.rows;
					this.pageOptions.total = res.total;

					if (rows && rows.length > 0) {
						const processedRows = rows.map(row => {
							if (row.proStatus == 2) {
								row.statusClass = 'unsigned';
							} else if (row.proStatus == 3) {
								row.statusClass = 'unbound';
							} else {
								row.statusClass = 'signed';
							}
							return { ...row };
						});

						this.list.push(...processedRows);

						if (this.list.length >= this.pageOptions.total || processedRows.length < this.pageOptions.pageSize) {
							this.pageOptions.is_end = true;
						}
					}
				} catch (error) {
					console.error('请求出错:', error);
				}
			}
		}
	};
</script>

<style lang="scss" scoped>
	page {
		background-color: #F5F5F5;
	}

	.container {
		background-color: #F5F5F5;
		padding: 0rpx 26rpx;
		display: flex;
		flex-direction: column;
		min-height: 100vh; /* 替代 height: 100vh */
		box-sizing: border-box;
	}

	.tab-switch {
		display: flex;
		gap: 26rpx;
		margin: 30rpx 0;
		padding: 16rpx 0;
	}

	.tab-item {
		width: 160rpx;
		height: 60rpx;
		background: #FFFFFF;
		border-radius: 28rpx;
		font-weight: bold;
		font-size: 26rpx;
		color: #AEAEAE;
		text-align: center;
		line-height: 60rpx;
	}

	.tab-item.active {
		background: #EDEFF7;
		border: 2px solid #A4AFDE;
		color: #4A63E4;
	}

	/* 👇 关键：内容容器负责滚动 */
	.content-container {
		flex: 1;
		display: flex;
		flex-direction: column;
		overflow-y: auto;
		touch-action: pan-y; /* 防止 iOS 手势冲突 */
		padding: 0 26rpx; /* 保持左右边距 */
	}

	.empty-wrapper {
		flex: 1;
		display: flex;
		justify-content: center;
		align-items: center;
		padding-top: 200rpx; /* 可选：避免太靠上 */
	}

	.order-card {
		padding: 36rpx 20rpx;
		margin-bottom: 40rpx;
		background: #FFFFFF;
		box-shadow: 0rpx 10rpx 26rpx 0rpx rgba(0, 88, 133, 0.08);
		border-radius: 40rpx;
		position: relative;
		/* 👇 解决 iOS 滚动卡顿 */
		transform: translateZ(0);
		will-change: transform;
	}

	.header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 30rpx;
	}

	.name {
		font-weight: bold;
		font-size: 32rpx;
		color: #2C2C2C;
		position: relative;
		padding-left: 18rpx;
	}

	.name::before {
		content: '';
		position: absolute;
		left: 0;
		top: 50%;
		transform: translateY(-50%);
		width: 6rpx;
		height: 28rpx;
		background: #4A63E4;
		border-radius: 3rpx;
	}

	.status-tag {
		position: absolute;
		right: -1px;
		top: -1px;
		width: 162rpx;
		height: 62rpx;
		font-size: 24rpx;
		font-weight: bold;
		text-align: center;
		background-repeat: no-repeat;
		background-size: contain;
		padding-top: 8rpx;
	}

	.status-tag.signed {
		background-image: url('/static/images/signed.png');
		color: #2449FF;
	}

	.status-tag.unsigned {
		background-image: url('/static/images/unsigned.png');
		color: #00A9E8;
	}

	.status-tag.unbound {
		background-image: url('/static/images/unbound.png');
		color: #FF9C00;
	}

	.info-row {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 10rpx 20rpx;
		padding-left: 18rpx;
		margin-bottom: 16rpx;
	}

	.field {
		display: flex;
		align-items: center;
		min-height: 40rpx;
	}

	.label {
		font-weight: bold;
		font-size: 26rpx;
		color: #969696;
		min-width: 120rpx;
		white-space: nowrap;
		flex-shrink: 0;
	}

	.value {
		font-weight: bold;
		font-size: 26rpx;
		color: #969696;
		flex: 1;
		padding-left: 12rpx;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		min-width: 0;
	}

	.hospital-row {
		display: flex;
		align-items: center;
		padding-left: 18rpx;
		margin-top: 8rpx;
		min-height: 40rpx;
		padding-right: 20rpx;
	}

	.hospital-row .label {
		font-weight: bold;
		font-size: 26rpx;
		color: #969696;
		min-width: 120rpx;
		white-space: nowrap;
		flex-shrink: 0;
	}

	.hospital-value {
		font-weight: bold;
		font-size: 26rpx;
		color: #969696;
		flex: 1;
		padding-left: 12rpx;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		padding-right: 20rpx;
	}

	.no-more {
		color: #aaaaaa;
		text-align: center;
		padding: 40rpx;
		margin: 40rpx auto;
	}
</style>