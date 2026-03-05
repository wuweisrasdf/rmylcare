<template>

	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="false" title="订单列表" leftIconSize="36" leftIconColor="#2C2C2C"
			@leftClick="goHome" :titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<view class="tab-switch">
			<view class="tab-item" :class="{ active: currentTab === 'inProgress' }" @click="switchTab('inProgress')">进行中
			</view>
			<view class="tab-item" :class="{ active: currentTab === 'completed' }" @click="switchTab('completed')">已完成
			</view>
		</view>

		<view v-if="filteredList.length > 0">
			<view class="content-container">
				<view v-for="(item, index) in filteredList" :key="index" class="order-card"
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
						<!-- 这里可以留空或放其他字段 -->
						<view class="field"></view>
					</view>

					<view class="hospital-row">
						<text class="label">预产医院:</text>
						<text class="hospital-value">{{ item.hospitalName }}</text>
					</view>
				</view>
			</view>
		</view>
		<view v-else style="padding-top:50%;">
			<u-empty text="暂无记录" mode="order" textSize="28" iconSize="90"></u-empty>

		</view>


		<!-- <view class="no-more" v-if="pageOptions.is_end">没有更多了</view> -->


		<!--   <TabBar :current-tab="currentTab"/> -->
	</view>


</template>

<script>
	import TabBar from '@/components/TabBar/TabBar.vue';
	import * as api from '@/utils/api.js'
	import {
		mapState
	} from 'vuex'

	export default {
		components: {
			TabBar
		},
		filters: {
			formatDate(value) {
			        if (!value) return '';
			        
			        const date = new Date(value);
			        
			        // 检查日期是否有效
			        if (isNaN(date.getTime())) {
			            // 如果解析失败，尝试直接截取字符串前10位作为兜底
			            return String(value).substring(0, 10);
			        }
			
			        const year = date.getFullYear();
			        // 月份需要 +1，且补零
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
			// 计算容器顶部内边距（转为 rpx）
			containerPaddingTop() {
				const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
				return barHeight;
			},
			// 根据 currentTab 过滤订单列表
			filteredList() {
				if (this.currentTab === 'inProgress') {
					return this.list.filter(item => !['已完成','协议解除', '已退款'].includes(item.statusTxt));
				} else {
					return this.list.filter(item => ['已完成','协议解除', '已退款'].includes(item.statusTxt));
				}
			}
		},
		// 下拉刷新
		onPullDownRefresh() {
			this.init()
			setTimeout(() => {
				uni.stopPullDownRefresh();
			}, 1000)
		},
		// 滚动到底部加载更多
		onReachBottom() {
			console.log("触底了")

			if (!this.pageOptions.is_end) {
				this.pageOptions.page++
				this.getList()
			}
		},
		onLoad() {
			this.init()
		},
		data() {
			return {
				currentTab: 'inProgress',
				pageOptions: {
					page: 1, // 当前页
					total: 0, // 总条数
					pageSize: 10, // 每页显示的数据
					is_end: false // 页面是否已加载完
				},
				list: []
			};
		},
		methods: {
			goHome() {
				uni.redirectTo({
					url: '/pages/index/index'
				})
			},
			switchTab(tab) {
				this.currentTab = tab;
			},
			// 重置分页数据
			resetPage() {
				this.pageOptions.page = 1
				this.pageOptions.total = 0
				this.pageOptions.is_end = false
				this.list = []
			},
			// 初始化
			init() {
				this.resetPage()
				this.getList()
			},
			showDetail(orderId) {
				uni.navigateTo({
					url: "/pages/order/detail?orderId=" + orderId
				})
			},
			async getList() {
				// uni.showLoading({
				// 	title: '数据加载中'
				// })

				try {
					const res = await api.getFdpOrderListForUser(this.user.userId,null,null);
					if (res.code !== 200) {
						//uni.hideLoading();
						uni.showToast({
							title: res.msg || '请求失败',
							icon: 'none'
						});
						return;
					}

					let rows = res.rows;
					this.pageOptions.total = res.total;

					if (rows && rows.length > 0) {
						const processedRows = rows.map(row => {
							
							if (row.proStatus == 2) {
								row.statusClass = 'unsigned';
							}else if (row.proStatus == 3) {
								row.statusClass = 'unbound';
							} else {
								row.statusClass = 'signed';
							}

							// 创建新的对象，保持原row的所有属性，添加新字段
							return {
								...row
							};
						});

						this.list.push(...processedRows);

						// 判断是否加载完毕
						if (this.list.length >= this.pageOptions.total || processedRows.length < this.pageOptions.pageSize) {
							this.pageOptions.is_end = true;
						}
					}
				} catch (error) {
					console.error('请求出错:', error);
					//uni.hideLoading();

					// uni.showToast({
					// 	title: '网络错误，请重试',
					// 	icon: 'none'
					// });
				}finally{
					//uni.hideLoading();
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
		height: 100vh;
		overflow-y: scroll;
	}

	.content-container {
		display: flex;
		justify-content: center;
		flex-direction: column;
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

	.order-card {
		padding: 36rpx 20rpx;
		margin-bottom: 40rpx;
		background: #FFFFFF;
		box-shadow: 0rpx 10rpx 26rpx 0rpx rgba(0, 88, 133, 0.08);
		border-radius: 40rpx;
		position: relative;
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
		text-align: center;
		padding-top: 8rpx;
		font-weight: bold;
		font-size: 24rpx;
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

	/* 修改 info-row 样式 */
	.info-row {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 10rpx 20rpx;
		/* 行间距10，列间距20 */
		padding-left: 18rpx;
		margin-bottom: 16rpx;
		/* 减小底部边距 */
	}

	.field {
		display: flex;
		align-items: center;
		min-height: 40rpx;
		/* 减小最小高度 */
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
		/* 重要：允许值区域压缩 */
	}

	/* 修改预产医院行样式 */
	.hospital-row {
		display: flex;
		align-items: center;
		/* 改为居中对齐，保持与其他行一致 */
		padding-left: 18rpx;
		margin-top: 8rpx;
		/* 减小顶部边距 */
		min-height: 40rpx;
		padding-right: 20rpx;
		/* 右侧增加内边距，防止文字贴边 */
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
		/* 右侧留出空间 */
	}

	.no-more {
		color: #aaaaaa;
		text-align: center;
		padding: 40rpx;
		margin: 40rpx auto;
	}
</style>