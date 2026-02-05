<template>

	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" title="订单列表" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<view v-if="list.length > 0">
			<view class="tab-switch">
				<view class="tab-item active">进行中</view>
				<view class="tab-item">已完成</view>
			</view>

			<view class="content-container">
				<view v-for="(item, index) in list" :key="index" class="order-card" @click="showDetail(item.orderId)">
					<!-- 姓名 + 状态标签 -->
					<view class="header">
						<text class="name">{{ item.name }}</text>
						<view class="status-tag" :class="item.statusClass">
							{{ item.status }}
						</view>
					</view>

					<!-- 详细信息 -->
					<view class="info-row">
						<view class="field">
							<text class="label">预产期:</text>
							<text class="value">{{ item.dueDate }}</text>
						</view>
						<view class="field">
							<text class="label">预产医院:</text>
							<text class="value">{{ item.hospital }}</text>
						</view>
					</view>
					<view class="info-row no-bottom">
						<view class="field">
							<text class="label">协议号:</text>
							<text class="value">{{ item.agreementNo }}</text>
						</view>
						<view class="field">
							<text class="label">签约日期:</text>
							<text class="value">{{ item.signDate }}</text>
						</view>
					</view>
				</view>
			</view>
		</view>
		<view v-else>
			<u-empty text="暂无记录" mode="order" textSize="28" iconSize="90"></u-empty>
		</view>
		

		<view class="no-more" v-if="pageOptions.is_end">没有更多了</view>


		<!--   <TabBar :current-tab="currentTab"/> -->
	</view>
	

</template>

<script>
	import TabBar from '@/components/TabBar/TabBar.vue';

	export default {
		components: {
			TabBar
		},
		computed: {
			// 计算容器顶部内边距（转为 rpx）
			containerPaddingTop() {
				const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
				return barHeight;
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
			// if (this.list.length < this.pageOptions.page * this.pageOptions.pageSize) {
			// 	return this.pageOptions.is_end = true
			// }

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
				currentTab: 1,
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
			showDetail(orderId){
				uni.navigateTo({
					url: "/pages/order/detail?orderId=" + orderId
				})
			},
			getList() {
				const newData = this.generateMockData(this.pageOptions.page);
				this.list = [...this.list, ...newData];
				this.pageOptions.total = 20;

				// 判断是否加载完毕
				if (this.list.length >= this.pageOptions.total || newData.length < this.pageOptions.pageSize) {
					this.pageOptions.is_end = true;
				}

				/*
				uni.showLoading({
					title: '数据加载中'
				})
				api.getList(this.token, this.pageOptions.page, this.pageOptions.pageSize).then(res => {
					let data = res.data;
					this.pageOptions.total = data.total
					if (data.data && data.data.length > 0) {
						this.list.push(...data.data);
					}
				}).finally(() => {
					uni.hideLoading();
				});
				*/
			},
			// 模拟生成分页数据
			generateMockData(page) {
				const statuses = [{
						status: '已签约',
						class: 'signed'
					},
					{
						status: '未签约',
						class: 'unsigned'
					},
					{
						status: '已解约',
						class: 'unbound'
					}
				];
				const names = ['张菲', '李婷', '王芳', '赵敏', '刘洋'];
				const hospitals = ['朝阳医院', '协和医院', '妇幼保健院', '人民医院'];

				const list = [];
				for (let i = 0; i < this.pageOptions.pageSize; i++) {
					const idx = (page - 1) * this.pageOptions.pageSize + i;
					list.push({
						orderId: i + 1,
						name: names[idx % names.length],
						status: statuses[idx % statuses.length].status,
						statusClass: statuses[idx % statuses.length].class,
						dueDate: `2026-03-${12 + (idx % 5)}`,
						hospital: hospitals[idx % hospitals.length],
						agreementNo: `${2934054876 + idx}`,
						signDate: `2026-03-${10 + (idx % 7)}`
					});
				}
				return list;
			}
		}
	};
</script>

<style lang="scss" scoped>
	page{
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
		margin-bottom: 46rpx;
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

	.info-row {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 20rpx;
		padding-left: 18rpx;
		margin-bottom: 20rpx;
	}

	.no-bottom {
		margin-bottom: 0;
	}

	.field {
		display: flex;
		align-items: center;
		min-height: 56rpx;
	}

	.label {
		font-weight: bold;
		font-size: 26rpx;
		color: #969696;
		min-width: 120rpx;
		white-space: nowrap;
	}

	.value {
		font-weight: bold;
		font-size: 26rpx;
		color: #969696;
		flex: 1;
		padding-left: 12rpx;
		word-break: break-all;
	}
	.no-more{
		color: #aaaaaa;
		text-align: center;
		padding: 40rpx;
		margin: 40rpx auto;
	}

</style>