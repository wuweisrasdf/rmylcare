<template>

	<view class="order-detail-wrap" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" title="订单详情" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<u-sticky offset-top="0" bgColor="#f5f5f5">
			<view class="detail-top">
				协议编号：{{ info.orderCode }}
			</view>

			<view class="tab-wrap">
				<view class="tab-btn" :class="tabIndex == 0 ? 'tab-current' : ''" @click="tabClick(0)">基本信息</view>
				<view class="tab-btn" :class="tabIndex == 1 ? 'tab-current' : ''" @click="tabClick(1)">协议信息</view>
			</view>
		</u-sticky>
		<view class="list-wrap">
			<view class="card-list">
				<view class="card-list-item">
					<view class="tag">
						{{ info.statusName }}
					</view>
					<view class="user-info">
						<view class="avatar-name">
							<view class="dot"></view>
							<view class="name">
								{{ info.motherName }}
							</view>
						</view>
						<template v-if="tabIndex == 0">
							<view class="">母亲信息：<text>{{ info.motherName }}</text></view>
							<view class="">手机号码：<text> {{ info.phonenumber }}</text></view>
							<view class="">证件类型：<text>{{ info.idType | getLabelById}}</text></view>
							<view class="id-cell">证件号：
								<text class="id-cell-text" v-if="showId">{{ info.idCode }}</text>
								<text class="id-cell-text" v-else>{{ info.idCode | idCardMask }}</text>
								<u-icon :name="showId ? 'eye-fill' : 'eye-off'" size="40" color="#bbb"
									@tap="showId = !showId"></u-icon>
							</view>
							<view class="">预产期：<text>{{ info.dueDate }}</text></view>
							<view class="">预产医院：<text>{{ info.hospitalName }}</text></view>
						</template>
						<template v-if="tabIndex == 1">
<!-- 							<view class="">手机号：<text>12456734876</text></view>
							<view class="">证件类型：<text>身份证</text></view>
							<view class="" style="display: flex; align-item: center;">证件号：
								<text style="padding-right: 20rpx;" v-if="showId">232343343232423987</text>
								<text style="padding-right: 20rpx;" v-else>232***********987</text>
								<u-icon :name="showId ? 'eye-fill' : 'eye-off'" size="40" color="#bbb"
									@tap="showId = !showId"></u-icon>
							</view>
							<view class="">电子邮件：<text>222@22.com</text></view>
							<view class="">收货地址：<text>北京市朝阳医院</text></view>
							<view class="">协议金额：<text>￥123123.00</text></view> -->
						</template>
					</view>
				</view>
			</view>
		</view>
		
		<view class="list-wrap order-list">
			<view class="order-list-title">
				<view class="dot"></view>
				<view class="name">
					订单进度
				</view>
			</view>
			<view class="card-list order-step-wrap">
				<view class="card-list-item order-step-item">
					<view class="order-step-info-wrap step-finish" :class="info.proStatus == 2 ? 'step-current' :''">
						<image src="/static/images/order-step-yes.png" mode=""></image>
						<view class="order-step-info">
							<view class="step-line"></view>
							<view class="order-step-info-data">
								<view class="step-name">
									未签约
								</view>
								<view class="step-desc">
									仅录入基本信息，未签字
								</view>
								<view class="bottom-line"></view>
							</view>
							<view class="date">
								01-12
							</view>
						</view>
					</view>

					<view class="order-step-info-wrap " 
						:class="info.proStatus != 2 ? (info.orderStatus == 11 ? 'step-current' : 'step-finish') :''">
						<image v-if="info.proStatus != 2" src="/static/images/order-step-yes.png" mode=""></image>
						<image v-else src="/static/images/order-step-not.png" mode=""></image>
						<view class="order-step-info">
							<view class="step-line"></view>
							<view class="order-step-info-data">
								<view class="step-name">
									已签约
								</view>
								<view class="step-desc">
									您已成功签署协议并完成支付
								</view>
								<view class="bottom-line"></view>
							</view>
							<view class="date">
								01-12
							</view>
						</view>
					</view>

					<view class="order-step-info-wrap" :class="info.orderStatus != 11 ? (info.orderStatus == 1 ? 'step-current' : 'step-finish') : ''">
						<image v-if="info.orderStatus != 11" src="/static/images/order-step-yes.png" mode=""></image>
						<image v-else src="/static/images/order-step-not.png" mode=""></image>
						<view class="order-step-info">
							<view class="step-line"></view>
							<view class="order-step-info-data">
								<view class="step-name">
									已支付
								</view>
								<view class="step-desc">
									您已完成支付
								</view>
								<view class="bottom-line"></view>
							</view>
						</view>
					</view>

					<view class="order-step-info-wrap" :class="[2,3,12,13,14,15,16,17,8,9,10,4,5].includes(info.orderStatus) ? (info.orderStatus == 2 ? 'step-current' : 'step-finish') : ''">
						<image v-if="[2,3,12,13,14,15,16,17,8,9,10,4,5].includes(info.orderStatus)" src="/static/images/order-step-yes.png" mode=""></image>
						<image v-else src="/static/images/order-step-not.png" mode=""></image>
						<view class="order-step-info">
							<view class="step-line"></view>
							<view class="order-step-info-data">
								<view class="step-name">
									样本接收
								</view>
								<view class="step-desc">
									样本已送达我们的处理中心
								</view>
								<view class="bottom-line"></view>
							</view>
						</view>
					</view>

					<view class="order-step-info-wrap" :class="[3,12,13,14,15,16,17,8,9,10,4,5].includes(info.orderStatus) ? (info.orderStatus == 3 ? 'step-current' : 'step-finish') : ''">
						<image v-if="[3,12,13,14,15,16,17,8,9,10,4,5].includes(info.orderStatus)" src="/static/images/order-step-yes.png" mode=""></image>
						<image v-else src="/static/images/order-step-not.png" mode=""></image>
						<view class="order-step-info">
							<view class="step-line"></view>
							<view class="order-step-info-data">
								<view class="step-name">
									病毒检测
								</view>
								<view class="step-desc">
									**********************
								</view>
								<view class="bottom-line"></view>
							</view>
						</view>
					</view>

					<view class="order-step-info-wrap" :class="[12,13,14,15,16,17,8,9,10,4,5].includes(info.orderStatus) ? (info.orderStatus != 4 && info.orderStatus != 5 ? 'step-current' : 'step-finish') : ''">
						<image v-if="[12,13,14,15,16,17,8,9,10,4,5].includes(info.orderStatus)" src="/static/images/order-step-yes.png" mode=""></image>
						<image v-else src="/static/images/order-step-not.png" mode=""></image>
						<view class="order-step-info">
							<view class="step-line"></view>
							<view class="order-step-info-data">
								<view class="step-name">
									制备完成
								</view>
								<view class="step-desc">
									胎盘已送达我们的处理中心
								</view>
								<view class="bottom-line"></view>
							</view>
						</view>
					</view>

					<view class="order-step-info-wrap" :class="[4,5].includes(info.orderStatus) ? (info.orderStatus== 4 ? 'step-current' : 'step-finish') : ''">
						<image v-if="[4,5].includes(info.orderStatus)" src="/static/images/order-step-yes.png" mode=""></image>
						<image v-else src="/static/images/order-step-not.png" mode=""></image>
						<view class="order-step-info">
							<view class="step-line"></view>
							<view class="order-step-info-data">
								<view class="step-name">
									已配送
								</view>
								<view class="step-desc">
									产品已发出，请留意物流信息
								</view>
								<view class="bottom-line"></view>
							</view>
						</view>
					</view>

					<view class="order-step-info-wrap" :class="info.orderStatus == 5 ? 'step-current': ''">
						<image v-if="info.orderStatus == 5" src="/static/images/order-step-yes.png" mode=""></image>
						<image v-else src="/static/images/order-step-not.png" mode=""></image>
						<view class="order-step-info no-bottom">
							<view class="step-line"></view>
							<view class="order-step-info-data">
								<view class="step-name">
									已完成
								</view>
								<view class="step-desc">
									**********************
								</view>
								<view class="bottom-line"></view>
							</view>
						</view>
					</view>

				</view>

			</view>

		</view>

		<!-- 快速操作 -->
		<view class="quick-actions-grid">
			<view class="action-card view-agreement" @click="viewAgreement">
				<view class="card-content">
					<text class="card-title">查看协议</text>
					<text class="card-desc">查看已签署的电子协议</text>
				</view>
				<view class="card-arrow"></view>
			</view>

			<view class="action-card unbind-agreement" @click="unbindAgreement">
				<view class="card-content">
					<text class="card-title">协议解除</text>
					<text class="card-desc">申请协议解除和退费</text>

				</view>
				<view class="card-arrow"></view>
			</view>

			<view class="action-card refund-progress" @click="refundProgress">
				<view class="card-content">
					<text class="card-title">退款进度</text>
					<text class="card-desc">查看已退款的进度</text>
				</view>
				<view class="card-arrow"></view>
			</view>
		</view>

		<view class="desc">
			<view class="desc-head">
				<view class="desc-icon"></view>
				<text class="desc-title">温馨提示</text>
			</view>
			<view class="desc-content">
				<view class="content-item">
					<view class="list-icon"></view>
					<text class="text">业务进度会随时并更，如有问题请联系客服。</text>
				</view>
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
			// 计算容器顶部内边距（转为 rpx）
			containerPaddingTop() {
				// CustomBar 是 px，uni-app 中 1px = 2rpx
				const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
				console.log(barHeight)
				return barHeight;
			}
		},
		filters: {
			// 身份证号脱敏过滤器
			idCardMask(value) {
				if (!value || typeof value !== 'string') {
					return value || '';
				}

				// 移除所有空格
				const idCard = value.replace(/\s/g, '');

				// 根据长度处理
				if (idCard.length === 15) {
					// 15位身份证：前6位 + 6个* + 后3位
					return idCard.substring(0, 6) + '******' + idCard.substring(12);
				} else if (idCard.length === 18) {
					// 18位身份证：前6位 + 8个* + 后4位
					return idCard.substring(0, 6) + '********' + idCard.substring(14);
				} else {
					// 其他长度：保留前2位和后2位，中间用*填充
					const length = idCard.length;
					if (length <= 4) {
						return '*'.repeat(length); // 太短直接全部隐藏
					}
					const visibleStart = Math.min(2, Math.floor(length / 4));
					const visibleEnd = Math.min(2, Math.floor(length / 4));
					const hiddenLength = length - visibleStart - visibleEnd;
					return (
						idCard.substring(0, visibleStart) +
						'*'.repeat(hiddenLength) +
						idCard.substring(length - visibleEnd)
					);
				}
			},
			// 根据value获取label
			getLabelById(value) {
				if (value === undefined || value === null || value === '') {
					return '';
				}

				const options = [{
						value: '1',
						label: '身份证'
					},
					{
						value: '2',
						label: '护照'
					},
					{
						value: '3',
						label: '永久居留身份证'
					},
					{
						value: '4',
						label: '台湾来往大陆通行证'
					},
					{
						value: '5',
						label: '香港来往大陆通行证'
					},
					{
						value: '6',
						label: '澳门来往大陆通行证'
					},
					{
						value: '10',
						label: '其它'
					}
				];

				const option = options.find(item => String(item.value) === String(value));
				return option ? option.label : '';
			}
		},
		data() {
			return {
				orderId: '',
				tabIndex: 0,
				showId: false,
				cardListScrollTop: 0,
				cardList: [],
				info: {},

			};
		},
		onLoad(options) {
			if (options.orderId) {
				this.orderId = options.orderId
				this.init()
			}
		},
		methods: {
			async init() {
				const statuses = [{
						code: '1',
						status: '已签约',
						class: 'signed'
					},
					{
						code: '2',
						status: '未签约',
						class: 'unsigned'
					},
					{
						code: '3',
						status: '已解约',
						class: 'unbound'
					}
				];
				//（1-已签，2-未签，3-取消，4-终止）

				const res = await api.getFdpOrder(this.orderId);
				if (res.code == 200) {
					if (res.rows && res.rows.length > 0) {
						const row = res.rows[0];
						this.info = row || {};
						const matchedStatus = statuses.find(item => item.code === String(this.info
							.proStatus));
						
						//this.info.orderStatus = 4; //TODO 模拟数据

						this.info.statusName = matchedStatus ? matchedStatus.status : '未知状态';
						this.info.statusClass = matchedStatus ? matchedStatus.class : 'unknown';
					}
				}
			},
			tabClick(index) {
				this.tabIndex = index;
				this.cardListScrollTop = 0;
				this.cardList = [];
				this.loadmore();
			},
			scrolltolower() {
				this.loadmore();
			},
			loadmore() {
				for (let i = 0; i < 30; i++) {
					this.cardList.push({
						url: '/static/logo.png',
					});
				}
			},
			// 查看协议
			viewAgreement() {
				uni.navigateTo({
					url: "/pages/order/agreement"
				})
			},
			// 退款进度
			refundProgress() {
				uni.navigateTo({
					url: "/pages/refund/status"
				})
			},
			// 解除协议
			unbindAgreement() {
				uni.navigateTo({
					url: "/pages/refund/cancel-agreement"
				})
			}
		}
	};
</script>

<style lang="scss" scoped>
	.order-detail-wrap {
		min-height: 100vh;
		/* 关键：撑满整个视口 */
		background-color: #f5f5f5;
		/* 这才是你看到的背景 */
		box-sizing: border-box;
		padding-bottom: 120rpx;

		.detail-top {
			font-weight: bold;
			font-size: 32rpx;
			color: #2C2C2C;
			padding: 0 26rpx;
			padding-top: 40rpx;
			background: #f5f5f5;
		}
	}

	.tab-wrap {
		display: flex;
		align-items: center;
		gap: 26rpx;
		margin-top: 34rpx;
		padding: 0 26rpx;
		padding-bottom: 24rpx;
		background-color: #f5f5f5;
	}

	.tab-btn {
		font-weight: bold;
		font-size: 26rpx;
		padding: 0 40rpx;
		height: 58rpx;
		line-height: 58rpx;
		border-radius: 50rpx;
		background: #fff;
		color: #AEAEAE;
		border: 2px solid transparent;
	}

	.tab-current {
		background: #EDEFF7;
		color: #4A63E4;
		border: 2px solid #A4AFDE;
	}

	.id-cell {
		display: flex;
		align-item: center;

		.id-cell-text {
			padding-right: 20rpx;
		}
	}


	.list-wrap {
		.card-list {
			margin-top: -24rpx;
		}

		.card-list-item {
			position: relative;
			padding: 34rpx 46rpx;
			color: #666;
			font-size: 28rpx;
			background-color: #fff;
			box-shadow: 0rpx 10rpx 26rpx 0rpx rgba(0, 88, 133, 0.08);
			border-radius: 40rpx;
			margin: 32rpx 24rpx 0 24rpx;

			.tag {
				position: absolute;
				right: -1px;
				top: -1px;
				width: 162rpx;
				height: 62rpx;
				background: url('/static/images/signed.png') no-repeat;
				background-size: contain;
				text-align: center;
				padding-top: 8rpx;
				font-weight: bold;
				font-size: 24rpx;
				color: #2449FF;

				&.weiqianyue {
					background: url('/static/images/unsigned.png') no-repeat;
					background-size: contain;
					color: #00C2D6;
				}

				&.yijieyue {
					background: url('/static/images/unbound.png') no-repeat;
					background-size: contain;
					color: #FFAA12;
				}
			}

			.user-info {
				display: flex;
				flex-direction: column;
				gap: 36rpx;
				font-weight: bold;
				font-size: 26rpx;
				color: #969696;

				.avatar-name {
					display: flex;
					align-items: center;
					gap: 18rpx;
					padding-bottom: 12rpx;

					.dot {
						width: 6rpx;
						height: 28rpx;
						background: #4A63E4;
						border-radius: 3rpx;
					}

					.name {
						font-weight: bold;
						font-size: 28rpx;
						color: #2c2c2c;
					}
				}
			}
		}

		.order-list-title {
			margin-top: 78rpx;
			display: flex;
			align-items: center;
			gap: 18rpx;
			padding-left: 26rpx;
			padding-right: 26rpx;
			padding-bottom: 12rpx;

			.dot {
				width: 6rpx;
				height: 28rpx;
				background: #4A63E4;
				border-radius: 3rpx;
			}

			.name {
				font-weight: bold;
				font-size: 28rpx;
				color: #2c2c2c;
			}
		}
	}

	.order-step-wrap {
		.order-step-item {
			position: relative;
			padding: 62rpx 56rpx;

			image {
				width: 52rpx;
				height: 52rpx;
				border-radius: 100%;
				position: absolute;
				z-index: 3;
				left: 56rpx;
			}
		}

		.order-step-info-wrap {
			&:last-child {
				.step-line {
					display: none;
				}
			}
		}

		.order-step-info {
			padding-left: 56rpx;
			display: flex;
			// align-items: center;
			justify-content: space-between;
			position: relative;
			padding-bottom: 76rpx;

			.date {
				font-weight: bold;
				font-size: 22rpx;
				color: #656565;
			}

			.step-line {
				position: absolute;
				width: 14rpx;
				background-color: #E8E8E8;
				height: calc(100% - 46rpx);
				left: 21rpx;
				top: 50rpx;
			}

			.order-step-info-data {
				font-weight: bold;
				font-size: 28rpx;
				color: #B6B6B6;
				margin-left: 56rpx;
				margin-top: -8rpx;
				position: relative;

				.step-name {
					font-size: 32rpx;
					color: #505050;
					padding-bottom: 20rpx;
				}

				.bottom-line {
					position: absolute;
					background: linear-gradient(90deg, transparent, rgba(74, 99, 228, 0.5) 50%, transparent 100%);
					height: 2rpx;
					left: -70rpx;
					right: -160rpx;
					bottom: -30rpx;
					display: none;
				}
			}


		}

		.no-bottom {
			padding-bottom: 0;
		}



		.step-finish {
			.step-name {
				color: #4A63E4 !important;
			}

			.step-line {
				background-color: #4A63E4;
			}
		}

		.step-current {
			.step-name {
				color: #4A63E4 !important;
			}

			.step-line {
				background-color: #4A63E4;
				background: linear-gradient(180deg, rgba(74, 99, 228, 1) 0%, rgba(74, 99, 228, 1) 0%, rgba(232, 232, 232, 1) 45%, rgba(232, 232, 232, 1) 100%);
			}

			.step-desc {
				color: #98A1CF;
			}

			.bottom-line {
				display: block !important;
			}
		}
	}


	.desc {
		margin: 70rpx 26rpx 0;

		.desc-head {
			display: flex;
			flex-direction: row;
			align-items: center;

			.desc-icon {
				width: 6rpx;
				height: 28rpx;
				background: #4A63E4;
				border-radius: 3rpx;
				margin-right: 24rpx;
			}

			.desc-title {
				font-weight: bold;
				font-size: 32rpx;
				color: #2C2C2C;
			}
		}

		.desc-content {
			margin-top: 52rpx;

			.content-item {
				display: flex;
				flex-direction: row;
				align-items: center;

				.list-icon {
					width: 12rpx;
					height: 12rpx;
					background: #4A63E4;
					border-radius: 50%;
					margin-right: 18rpx;
					margin-left: 24rpx;
				}

				.text {
					font-weight: bold;
					font-size: 26rpx;
					color: #5B5B5B;
				}
			}
		}

	}


	.quick-actions-grid {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 32rpx;
		padding: 0 26rpx;
		margin-top: 60rpx;

		// 第3项放在第一列
		.action-card:nth-child(3) {
			grid-column: 1;
		}

		.action-card {
			width: 338rpx;
			height: 218rpx;
			background-color: #EDEFF7;
			background-repeat: no-repeat;
			background-position: bottom right;
			background-size: contain;
			border-radius: 20rpx;
			position: relative;
			overflow: hidden;
			box-shadow: 0rpx 10rpx 26rpx 0rpx rgba(0, 88, 133, 0.08);

			.card-content {
				padding: 36rpx 30rpx;
				height: 100%;
				display: flex;
				flex-direction: column;
			}

			.card-title {
				font-size: 32rpx;
				font-weight: bold;
				color: #505050;
			}

			.card-desc {
				font-size: 24rpx;
				font-weight: bold;
				color: #9F9F9F;
				margin-top: 20rpx;
			}

			.card-arrow {
				position: absolute;
				bottom: 36rpx;
				left: 30rpx;
				width: 42rpx;
				height: 14rpx;
				background-image: url('/static/images/quick-arrow.png');
				background-repeat: no-repeat;
				background-size: contain;
				z-index: 2;
			}
		}

		// 背景图分别定义
		.view-agreement {
			background-image: url('/static/images/view-agreement.png');
		}

		.unbind-agreement {
			background-image: url('/static/images/unbind-agreement.png');
		}

		.refund-progress {
			background-image: url('/static/images/refund-progress.png');
		}
	}
</style>