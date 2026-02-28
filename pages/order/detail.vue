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
						{{ info.statusTxt }}
					</view>
					<view class="user-info">
						<template v-if="tabIndex == 0">
							<view class="avatar-name">
								<view class="dot"></view>
								<view class="name">
									{{ info.motherName }}
								</view>
							</view>
							<view class="">母亲信息：<text>{{ info.motherName }}</text></view>
							<view class="">手机号码：<text> {{ info.motherPhonenumber }}</text></view>
							<view class="">证件类型：<text>{{ info.motherIdType | getLabelById}}</text></view>
							<view class="id-cell">证件号：
								<text class="id-cell-text" v-if="showId">{{ info.motherIdCode }}</text>
								<text class="id-cell-text" v-else>{{ info.motherIdCode | idCardMask }}</text>
								<u-icon :name="showId ? 'eye-fill' : 'eye-off'" size="40" color="#bbb"
									@tap="showId = !showId"></u-icon>
							</view>
							<view class="">预产期：<text>{{ info.dueDate }}</text></view>
							<view class="">预产医院：<text>{{ info.hospitalName }}</text></view>
						</template>
						<template v-if="tabIndex == 1">
							<view class="avatar-name">
								<view class="dot"></view>
								<view class="name">
									{{ info.userName || '' }}
								</view>
							</view>
							<view class="">手机号：<text> {{ info.phonenumber }} </text></view>
							<view class="">证件类型：<text>{{ info.idType | getLabelById}}</text></view>
							<view class="id-cell">证件号：
								<text class="id-cell-text" v-if="showId">{{ info.idCode }}</text>
								<text class="id-cell-text" v-else>{{ info.idCode | idCardMask  }}</text>
								<u-icon :name="showId ? 'eye-fill' : 'eye-off'" size="40" color="#bbb"
									@tap="showId = !showId"></u-icon>
							</view>
							<view class="">电子邮件：<text>{{ info.userEmail || '' }}</text></view>
							<view class="">收货地址：<text>{{ info.address }}</text></view>
							<view class="">协议金额：<text>￥{{ info.priceOut }}</text></view>
						</template>
					</view>
				</view>
			</view>
		</view>
		
		<view class="cancel-btn" v-if="(currentStatusId == 8) || (currentStatusId >= 9 && info.priceOut > 0)">
			<u-button :custom-style="cancelBtnStyle" @click="unbindAgreement" v-if="currentStatusId == 8">
				协议解除
			</u-button>
			
			<u-button :custom-style="cancelBtnStyle" @click="refundProgress" v-if="currentStatusId >= 9 && info.priceOut > 0">
				退款进度
			</u-button>
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
					<view class="order-step-info-wrap-for" v-for="(item, index) in progressData" :key="index">
						<template v-if="currentProgressIndex > index">
							<view class="order-step-info-wrap step-finish">
								<image src="/static/images/order-step-yes.png" mode=""></image>
								<view class="order-step-info">
									<view class="step-line"></view>
									<view class="order-step-info-data">
										<view class="step-name">
											{{item.OrderName}}
										</view>
										<view class="step-desc">
											{{item.Desc}}
										</view>
									</view>
									<view class="bottom-line"></view>
									<view class="date">
										{{item.StatusDate | formatDate}}
									</view>
								</view>
							</view>
						</template>
						<template v-else-if="currentProgressIndex == index">
							<view class="order-step-info-wrap step-current">
								<image src="/static/images/order-step-yes.png" mode=""></image>
								<view class="order-step-info">
									<view class="step-line"></view>
									<view class="order-step-info-data">
										<view class="step-name">
											{{item.OrderName}}
										</view>
										<view class="step-desc">
											{{item.Desc}}
										</view>
									</view>
									<view class="bottom-line"></view>
									<view class="date">
										{{item.StatusDate | formatDate}}
									</view>
								</view>
							</view>
						</template>
						<template v-else>
							<view class="order-step-info-wrap">
								<image src="/static/images/order-step-not.png" mode=""></image>
								<view class="order-step-info">
									<view class="step-line"></view>
									<view class="order-step-info-data">
										<view class="step-name">
											{{item.OrderName}}
										</view>
										<view class="step-desc">
											{{item.Desc}}
										</view>
									</view>
									<view class="bottom-line"></view>
									<view class="date">
										{{item.StatusDate | formatDate}}
									</view>
								</view>
							</view>
						</template>
					</view>
				</view>
			</view>
		</view>

		<!-- 快速操作 -->
		<!-- 1-已签约、2-已付款、3-样本接收、4-病毒检测、5-制备完成、6-配送、7-已完成、8-申请解除、9-协议解除、10-已退款 -->
		<!-- 状态ID 大于1，显示“查看协议”，状态ID >= 8，显示解除协议，状态ID >=9，显示 退款中。 -->
		<view class="quick-actions-grid">
			<view class="action-card view-agreement" @click="viewAgreement" v-if="currentStatusId >= 1">
				<view class="card-content">
					<text class="card-title">查看协议</text>
					<text class="card-desc">查看已签署的电子协议</text>
				</view>
				<view class="card-arrow"></view>
			</view>
			
			<view class="action-card unbind-agreement" @click="unbindAgreement" v-if="currentStatusId == 8">
				<view class="card-content">
					<text class="card-title">协议解除</text>
					<text class="card-desc">申请协议解除和退费</text>
				</view>
				<view class="card-arrow"></view>
			</view>
			

			<view class="action-card refund-progress" @click="refundProgress" v-if="currentStatusId >= 9 && info.priceOut > 0">
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
					<text class="text">业务进度会随时变更，如有问题请联系客服。</text>
				</view>
				<view class="content-item">
					<view class="list-icon"></view>
					<text class="text">客服电话：010-85795849</text>
				</view>
			</view>

		</view>

		
		<!-- 底部按钮 - 修改为悬浮底部 -->
		<view class="btn-group" v-if="(info.proStatus == 2) || (info.proStatus == 1 && info.orderStatus==11  && currentStatusId < 8)">
		    <u-button :custom-style="nextBtnStyle" @click="toSign" v-if="info.proStatus == 2">
		        继续编辑
		    </u-button>
		    <u-button :custom-style="nextBtnStyle" @click="toPay" v-if="info.proStatus == 1 && info.orderStatus==11 && currentStatusId < 8">
		        去支付
		    </u-button>
		</view>
		
		<!-- 底部占位元素，避免内容被固定按钮遮挡 -->
		<view class="bottom-placeholder" v-if="(info.proStatus == 2) || (info.proStatus == 1 && info.orderStatus==11)"></view>

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
			// 计算容器顶部内边距（转为 rpx）
			containerPaddingTop() {
				// CustomBar 是 px，uni-app 中 1px = 2rpx
				const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
				//console.log(barHeight)
				return barHeight;
			},
			nextBtnStyle() {
				return {
					height: '98rpx',
					borderRadius: '49rpx',
					backgroundColor: '#4A63E4',
					color: '#FFFFFF',
					fontSize: '32rpx',
					fontWeight: 'bold',
				};
			},
			cancelBtnStyle(){
				return {
					height: '98rpx',
					borderRadius: '49rpx',
					backgroundColor: '#f9ae3d',
					color: '#FFFFFF',
					fontSize: '32rpx',
					fontWeight: 'bold',
				};
			},
			// currentStatusId() {
			// 	const progress = this.info?.orderProgress;
			// 	if (!Array.isArray(progress) || progress.length === 0) {
			// 		return 0; // 默认为未签约
			// 	}
			// 	const lastStep = progress[progress.length - 1];
			// 	console.log('lastStep', lastStep);
			// 	let stepid = 0
			// 	if (lastStep.id) {
			// 		stepid = Number(lastStep.id)
			// 	} else if (lastStep.Id) {
			// 		stepid = Number(lastStep.Id)
			// 	}
			// 	return stepid;
			// }
			currentStatusId() {
			    const progress = this.info?.orderProgress;
			    
			    // 1. 基础校验：必须是数组且不为空
			    if (!Array.isArray(progress) || progress.length === 0) {
			        return 0; 
			    }
			
			    // 2. 从后往前遍历 (因为最新的步骤通常在后面)
			    // 找到第一个 StatusDate 不为空、不为 null、且不仅仅是空格的项
			    for (let i = progress.length - 1; i >= 0; i--) {
			        const step = progress[i];
			        
			        // 兼容 id 或 Id 字段
			        const stepIdVal = step.id || step.Id;
			        
			        // 获取日期字符串，并去除首尾空格
			        const dateStr = (step.StatusDate || '').trim();
			
			        // 核心判断：日期必须有效
			        if (dateStr !== '') {
			            // 找到了最新的有效步骤，返回其 ID
			            return Number(stepIdVal);
			        }
			    }
			
			    // 3. 如果遍历完所有项，发现所有 StatusDate 都是空的
			    // 返回 0 或者你希望的默认状态 (例如返回第一项的 ID，或者 0)
			    return 0; 
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

				const length = idCard.length;
				
				// 返回相同长度的星号
				return '*'.repeat(length);

				// // 根据长度处理
				// if (idCard.length === 15) {
				// 	// 15位身份证：前6位 + 6个* + 后3位
				// 	return idCard.substring(0, 6) + '******' + idCard.substring(12);
				// } else if (idCard.length === 18) {
				// 	// 18位身份证：前6位 + 8个* + 后4位
				// 	return idCard.substring(0, 6) + '********' + idCard.substring(14);
				// } else {
				// 	// 其他长度：保留前2位和后2位，中间用*填充
				// 	const length = idCard.length;
				// 	if (length <= 4) {
				// 		return '*'.repeat(length); // 太短直接全部隐藏
				// 	}
				// 	const visibleStart = Math.min(2, Math.floor(length / 4));
				// 	const visibleEnd = Math.min(2, Math.floor(length / 4));
				// 	const hiddenLength = length - visibleStart - visibleEnd;
				// 	return (
				// 		idCard.substring(0, visibleStart) +
				// 		'*'.repeat(hiddenLength) +
				// 		idCard.substring(length - visibleEnd)
				// 	);
				// }
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
			},
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
		data() {
			return {
				orderId: '',
				tabIndex: 0,
				showId: false,
				cardListScrollTop: 0,
				cardList: [],
				info: {},
				currentProgressIndex: 0,
				progressData: [{
						OrderName: '未签约',
						Desc: '仅录入基本信息，未签字',
					},
					{
						OrderName: '已签约',
						Desc: '签约已完成',
					},
					{
						OrderName: '已付款',
						Desc: '支付已完成',
					},
					{
						OrderName: '样本接收',
						Desc: '样本已送达处理中心',
					},
					{
						OrderName: '病毒检测',
						Desc: '病毒检测已完成',
					},
					{
						OrderName: '制备完成',
						Desc: '产品已制备完成',
					},
					{
						OrderName: '配送',
						Desc: '产品已发出，请关注物流',
					},
					{
						OrderName: '已完成',
						Desc: '产品已签收',
					},
				], // 1-已签约、2-已付款、3-样本接收、4-病毒检测、5-制备完成、6-配送、7-已完成、8-申请解除、9-协议解除、10-已退款
				progressDataJiechu: [{
						OrderName: '申请解除',
						Desc: '已申请解除协议',
					},
					{
						OrderName: '协议解除',
						Desc: '协议已解除',
					},
					{
						OrderName: '已退款',
						Desc: '退款已到账',
					},
				],
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

						if (row.proStatus == 1) {
							row.statusClass = 'signed';
						} else if (row.proStatus == 3) {
							row.statusClass = 'unbound';
						} else {
							row.statusClass = 'unsigned';
						}

						this.info = row || {};

						if (this.info.orderProgress) {
							const exists = this.progressData.some(item => item.OrderName == this.info.statusTxt);


							//this.progressData = this.mergeStatuses(this.progressData, this.info.orderProgress);

							this.progressData = exists ? this.mergeStatuses(this.progressData, this.info
								.orderProgress) : this.mergeStatusesJiechu(this.info.orderProgress, this
									.progressDataJiechu, this.progressData);
						}
						this.setProgress();
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
			toSign() {
				uni.redirectTo({
					url: `/pages/sign/confirm-price?orderId=${this.orderId}&fromOrder=1`
				})
			},
			toPay() {
				uni.redirectTo({
					url: `/pages/sign/success?orderId=${this.orderId}`
				})
			},
			// 查看协议
			viewAgreement() {
				uni.navigateTo({
					url: `/pages/order/agreement?orderId=${this.orderId}`
				})
			},
			// 退款进度
			refundProgress() {
				uni.navigateTo({
					url: `/pages/refund/status?orderId=${this.orderId}`
				})
			},
			// 解除协议
			unbindAgreement() {
				uni.navigateTo({
					url: `/pages/refund/cancel-agreement?orderId=${this.orderId}`
				})
			},
			mergeStatuses(a, b) {
				// 将 b 转为 Map，key 是 OrderName
				const bMap = new Map(b.map(item => [item.OrderName, item]));

				// 遍历 a，对每个项：
				// - 如果 b 中有同名 OrderName，则合并字段
				// - 否则保留原样
				return a.map(aItem => {
					const bItem = bMap.get(aItem.OrderName);
					if (bItem) {
						// 合并：保留 aItem 所有字段，用 bItem 的字段覆盖或补充
						return {
							...aItem,
							...bItem
						};
					}
					return aItem;
				});
			},
			mergeStatusesJiechu(orderProgress, progressDataJiechu, progressData) {
				const jiechuMap = new Map(progressDataJiechu.map(i => [i.OrderName, i.Desc]));
				const mainDescMap = new Map(progressData.map(i => [i.OrderName, i.Desc]));
				const orderNames = new Set(orderProgress.map(i => i.OrderName));

				const result = orderProgress.map(item => {
					let desc = '';
					if (item.Desc != null && item.Desc.trim() !== '') {
						desc = item.Desc;
					} else if (jiechuMap.has(item.OrderName)) {
						desc = jiechuMap.get(item.OrderName) || '';
					} else if (mainDescMap.has(item.OrderName)) {
						desc = mainDescMap.get(item.OrderName);
					}
					return {
						...item,
						Desc: desc
					};
				});

				progressDataJiechu.forEach(item => {
					if (!orderNames.has(item.OrderName)) {
						result.push({
							...item,
							Desc: item.Desc || ''
						});
					}
				});

				return result;
			},
			setProgress() {
				// 样式一：只显示接口传过来的状态
				this.currentProgressIndex = -1; // 初始化为-1，表示未找到匹配项
				const orderNamesSet = new Set(this.info.orderProgress.map(item => item.OrderName));
			
				this.progressData = this.progressData.filter(item => orderNamesSet.has(item.OrderName));
				this.progressData.forEach((item, index) => {
					if (this.info.statusTxt === item.OrderName) {
						this.currentProgressIndex = index;
					}
				});
				
				// 样式二：显示接口传过来的状态和剩余状态
				// console.log('setProgress', this.progressData)
				// this.progressData.forEach((item, index) => {
				// 	if (this.info.statusTxt == item.OrderName) {
				// 		this.currentProgressIndex = index;
				// 		if (this.currentProgressIndex < index) {
				// 			item.isFinishStep;
				// 		}
				// 		if (this.currentProgressIndex > index) {
				// 			item.isCurrentStep;
				// 		}
				// 	}
				// });
			},
			currentStepStatus(index) {
				let result = '';
				if (this.currentProgressIndex < index) {
					result = 'step-finish';
				}
				if (this.currentProgressIndex == index) {
					result = 'step-current';
				}
				return result;
			}
		}
	};
</script>

<style lang="scss" scoped>
	.order-detail-wrap {
		min-height: 100vh;
		background-color: #f5f5f5;
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

.btn-group {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    display: flex;
    justify-content: space-between;
    padding: 20rpx 26rpx 30rpx;
    background-color: #f5f5f5;
    box-shadow: 0 -4rpx 20rpx rgba(0, 0, 0, 0.05);
    z-index: 100;
    
    // 确保按钮占据固定宽度
    .u-btn {
        flex: 1;
        
        &:first-child {
            margin-right: 20rpx;
        }
    }
}

// 底部占位元素，高度与固定按钮组一致
.bottom-placeholder {
    height: 148rpx; // 与 .btn-group 的高度保持一致
    width: 100%;
}


	.order-step-wrap {
		.order-step-item {
			position: relative;
			padding: 62rpx 56rpx 0;

			image {
				width: 52rpx;
				height: 52rpx;
				border-radius: 100%;
				position: absolute;
				z-index: 3;
				left: 56rpx;
			}
		}

		.order-step-info-wrap-for {
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
				position: absolute;
				right: 0;
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
			}

			.bottom-line {
				position: absolute;
				background: linear-gradient(90deg, transparent, rgba(74, 99, 228, 0.5) 50%, transparent 100%);
				height: 2rpx;
				left: 40rpx;
				right: -40rpx;
				bottom: 40rpx;
				display: none;
			}
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
	
	.cancel-btn{
		margin: 70rpx 40rpx 0;
	}
</style>