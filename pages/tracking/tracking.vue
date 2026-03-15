<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" title="物流信息" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<view class="content-container">
			<!-- 物流信息列表 -->
<view class="logistics-list">
	<view class="steps-container">
		<view 
			v-for="(item, index) in logisticsList" 
			:key="index"
			class="step-item"
		>
			<!-- 左侧步骤节点 -->
			<view class="step-node">
				<view class="node-dot"></view>
				<!-- 竖线（除了最后一项） -->
				<view v-if="index < logisticsList.length - 1" class="node-line"></view>
			</view>

			<!-- 右侧内容 -->
			<view class="step-content">
				<text class="info-title">{{ item.title }}</text>
				<text class="info-time">{{ item.time }}</text>
			</view>
		</view>
	</view>
</view>

			<!-- 无物流信息提示 -->
			<view v-if="!logisticsList.length" class="no-data">
				<text>暂无物流信息</text>
			</view>
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
				logisticsList: [] // 物流信息数组
			};
		},
		methods: {
			async init() {
				try {
					// 模拟数据（实际项目中请替换为 API 调用）
					this.logisticsList = [
						{
							status: '●',
							title: '您的订单已发货完成',
							time: '2025-12-10 12:04:14'
						},
						{
							status: '●',
							title: '您的订单已打包完成',
							time: '2025-12-10 12:04:15'
						},
						{
							status: '●',
							title: '商家已发货，正在通知圆通快递取件',
							time: '2025-12-10 12:04:16'
						},
						{
							status: '●',
							title: '您的快件在【湖南省长沙市金州开发区】已揽收，揽收人：彭源（13973122213）',
							time: '2025-12-11 04:37:57'
						},
						{
							status: '●',
							title: '您的快件已经到达【长沙转运中心】，【物流问题无需找商家或平台，请致电（专属热线:95554）更快解决】',
							time: '2025-12-11 05:51:23'
						},
						{
							status: '●',
							title: '您的快件离开【长沙转运中心】，已发往【北京转运中心】。预计【12月13日】到达【北京市】，因运输距离较远，预计将在【13日晚上】为您更新快件状态，请您放心！',
							time: '2025-12-11 21:39:04'
						},
						{
							status: '●',
							title: '您的快件已经到达【北京转运中心】，【物流问题无需找商家或平台，请致电（专属热线:95554）更快解决】',
							time: '2025-12-13 04:02:05'
						}
					];

					// 示例：如果要调用真实接口
					// const res = await api.getLogistics(this.orderId);
					// if (res.code === 200) {
					//   this.logisticsList = res.data;
					// }
				} catch (error) {
					console.error('获取物流信息失败:', error);
				}
			}
		}
	};
</script>

<style lang="scss" scoped>
	.container {
		background-color: #F5F7FA;
		padding: 0 26rpx;
		min-height: 100vh;
		box-sizing: border-box;
		position: relative;
		display: flex;
		flex-direction: column;
	}

	.content-container {
		flex: 1;
		padding-top: 30rpx;
	}

	.logistics-list {
		background-color: #FFFFFF;
		border-radius: 16rpx;
		box-shadow: 0 4rpx 16rpx rgba(0, 0, 0, 0.08);
		padding: 30rpx 24rpx;
		margin-bottom: 30rpx;
	}
	
	.steps-container {
		display: flex;
		flex-direction: column;
	}
	
	.step-item {
		display: flex;
		margin-bottom: 32rpx;
	
		&:last-child {
			margin-bottom: 0;
		}
	}
	
	.step-node {
		display: flex;
		flex-direction: column;
		align-items: center;
		margin-right: 24rpx;
		min-width: 36rpx;
	}
	
	.node-dot {
		width: 16rpx;
		height: 16rpx;
		border-radius: 50%;
		background-color: #4A63E4;
		z-index: 2;
	}
	
	.node-line {
		width: 2rpx;
		flex: 1;
		background-color: #E5E5E5;
		margin-top: 8rpx;
	}
	
	.step-content {
		flex: 1;
	}
	
	.info-title {
		font-size: 28rpx;
		color: #2C2C2C;
		line-height: 1.4;
	}
	
	.info-time {
		font-size: 24rpx;
		color: #888888;
		margin-top: 8rpx;
		display: block;
	}
</style>