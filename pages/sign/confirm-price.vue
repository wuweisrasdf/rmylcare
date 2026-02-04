<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" title="价格确认" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<view class="content-container">
			<view class="info">
				<view class="item">
					<text class="label">产品名称</text>
					<text class="value">{{ productInfo.productName }}</text>
				</view>

				<!-- 分隔线 -->
				<view class="divider"></view>

				<!-- 服务费用 -->
				<view class="item">
					<text class="label">服务费用</text>
					<view class="price-section">
						<text class="price">¥{{ productInfo.price }}</text>

					</view>
				</view>

				<view class="payment-type">
					<text>一次性支付</text>
				</view>

			</view>
		</view>

		<!-- 底部按钮 -->
		<view class="btn-group">
			<u-button :custom-style="prevBtnStyle" @click="goPrev">
				上一步
			</u-button>
			<u-button :custom-style="nextBtnStyle" @click="submit">
				确认价格，去签字
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
			prevBtnStyle() {
				return {
					height: '98rpx',
					borderRadius: '49rpx',
					backgroundColor: '#FFFFFF',
					border: '2px solid rgba(142,142,142,0.5)',
					color: '#3D3D3D',
					fontSize: '32rpx',
					fontWeight: 'bold',
					marginRight: '26rpx',
				};
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
			}
		},
		onLoad() {
			this.init();
		},
		onShow() {
			// 如果刚从签署页返回，检查订单是否已签署
			if (this.isSigning) {
				// 增加一个提示框，避免直接跳转，会影响性能
				uni.showModal({
					title: '签署完成确认',
					content: '您已完成电子签署？',
					confirmText: '已完成',
					cancelText: '取消',
					success: (res) => {
						if (res.confirm) {
							// 用户点击“确认”
							this.checkIfSigned();
						} else if (res.cancel) {
							// 用户点击“取消”，可选：重置状态或不做处理
							this.isSigning = false;
						}
					},
					fail: (err) => {
						console.error('弹窗失败:', err);
						this.isSigning = false;
					}
				});
			}
		},
		data() {
			return {
				productInfo: {
					id: '',
					productName: '',
					price: '',
					navbar: '',
					details: ''
				},
				motherInfo: {},
				motherId: 0, // 产妇id
				salesId: 0, // 销售id
				orderId: '', // 订单id
				isSigning: false, // 标记是否刚从签署页返回
			};
		},
		methods: {
			async init() {
				// 获取产品信息
				const productId = 1; // 固定值 1
				const res = await api.getProductById(productId);
				if (res.code == 200) {
					const data = res.data || {};
					this.productInfo = {
						id: data.id != null ? data.id : '',
						productName: data.productName || '',
						price: data.price != null ? data.price : '',
						navbar: data.navbar || '',
						details: data.details || ''
					};
				}

				// 读取产妇和甲方信息
				const result = await api.getMotherAndUser();
				if (result.code == 200) {
					const motherInfo = result.mother && result.mother.length > 0 ? result.mother[0] : {};
					this.motherInfo = motherInfo
					this.motherId = motherInfo.id || 0
				}

				this.salesId = uni.getStorageSync('SCAN_SALES_ID') || 0; // 销售id 从storage 获取
			},
			// 提交数据生成合同
			async submit() {
				const now = new Date();
				const today =
					`${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')}`;

				const params = {
					motherId: this.motherId, // 母亲id
					orderStatus: 11, // 订单状态 11-未交费
					priceOut: this.productInfo.price, // 费用
					proCode: "", // 订单编号
					proStatus: 2, // 协议状态 2-未签
					recordStatus: 1, // 记录状态 1-有效
					signDate: today,
					userId: this.user.userId, // 当前用户id
					salesId: this.salesId // 销售id
				};

				const res = await api.createFdpOrder(params);
				if (res.code == 200) {
					console.log('pdfcreate:', res)
					if (res.id) {
						this.orderId = res.id;
						this.getSignUrl()
					}
				}
			},
			// 获取签名URL
			async getSignUrl() {
				const orderId = this.orderId;
				const params = {
					orderId: orderId,
					returnURL: api.signReturnUrl,
					signType: '1', // 签约=1，解约=2
					signerName: this.user.nickName, // 当前登录用户的昵称
					signerPhone: this.user.phonenumber, // 当前用户的手机号
				}

				uni.showLoading({
					title: '正在生成签署链接...',
					mask: true // 防止用户点击穿透
				});

				try {
					const res = await api.getSignUrl(params);

					uni.hideLoading();

					if (res.code == 200) {
						console.log('getSignUrl:', res)
						if (res.signUrl) {
							this.isSigning = true; // 标记即将进入签署流程
							uni.navigateTo({
								url: `/pages/sign/signature?signUrl=${encodeURIComponent(res.signUrl)}`
							});
							return;
						}
					}
				} catch (err) {
					uni.hideLoading();

					console.log("签名失败：", err)
					uni.showToast({
						title: "手机号需要实名认证",
						icon: 'none'
					});
				}
			},
			// 从e签宝回退后，检查是否签字成功
			async checkIfSigned() {
				try {
					const orderId = this.orderId;

					const res = await api.getFdpOrder(orderId);
					if (res.code == 200 && res.rows.length > 0) {
						const order = res.rows[0];
						if (order.proStatus == 1) { // proStatus == 1 已签署
							this.isSigning = false;
							uni.redirectTo({
								url: `/pages/sign/success?orderId=${this.orderId}`
							});
						} else {
							// 可选：如果未签署，提示用户
							uni.showToast({
								title: '未完成签署',
								icon: 'none'
							});
							this.isSigning = false;
						}
					}

				} catch (err) {
					console.error('检查签署状态失败:', err);
					this.isSigning = false;
				}
			}
		}
	};
</script>

<style lang="scss" scoped>
	.container {
		background-color: #ffffff;
		padding: 0 26rpx;
		min-height: 100vh;
		box-sizing: border-box;
		position: relative;
		display: flex;
		flex-direction: column;
	}

	.content-container {
		flex: 1;
		margin-top: 74rpx;
		box-sizing: border-box;
	}

	.info {
		background: #F6F7FC;
		border-radius: 40rpx;
		padding: 50rpx 40rpx;
		box-sizing: border-box;
		margin-bottom: 80rpx;

		.item {
			display: flex;
			justify-content: space-between;
			align-items: center;
			margin-bottom: 40rpx;

			.label {
				font-weight: 500;
				font-size: 30rpx;
				color: #727272;
			}

			.value {
				font-weight: 800;
				font-size: 30rpx;
				color: #151515;
				flex: 1;
				text-align: right;
			}
		}

		.divider {
			height: 2rpx;
			background: #161421;
			opacity: 0.1;
			margin-bottom: 40rpx;
		}

		.price-section {
			display: flex;
			flex-direction: column;
			align-items: flex-end;
		}

		.price {
			font-weight: 800;
			font-size: 44rpx;
			color: #4A63E2;
		}
	}

	.payment-type {
		width: 100%;
		text-align: right;
		//font-weight: 500;
		font-size: 24rpx;
		color: #4A63E2;
		margin-top: -10rpx;
	}

	.btn-group {
		display: flex;
		justify-content: space-between;
		margin-bottom: 120rpx;
	}
</style>