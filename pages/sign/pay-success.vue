<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<view class="content-container">
			<view class="top">
				<image src="/static/icons/sign-success.png" mode="widthFix"></image>
				<text class="title">支付成功！</text>
			</view>

			<view class="info">
				<view class="item">
					<text class="label">甲方名称</text>
					<text class="value">{{ info.userName }}</text>
				</view>

				<view class="item">
					<text class="label">产品名称</text>
					<text class="value">{{ info.productName }}</text>
				</view>

				<view class="item">
					<text class="label">签约金额</text>
					<text class="value">￥{{ info.price }}</text>
				</view>

				<view class="item">
					<text class="label">协议号</text>
					<text class="value">{{ info.orderCode }}</text>
				</view>

				<view class="item">
					<text class="label">支付时间</text>
					<text class="value">{{ info.payDate | formatDate }}</text>
				</view>
			</view>

			<!-- 			<view class="desc">
				<view class="desc-head">
					<view class="desc-icon"></view>
					<text class="desc-title">后续步骤</text>
				</view>
				<view class="desc-content">
					<view class="content-item">
						<view class="list-icon"></view>
						<text class="text">您可以随时查看业务进度</text>
					</view>
					<view class="content-item">
						<view class="list-icon"></view>
						<text class="text">胎盘接收后将实时接收更新状态</text>
					</view>
					<view class="content-item">
						<view class="list-icon"></view>
						<text class="text">重要通知将通过微信服务通知推送</text>
					</view>
				</view>

			</view> -->

			<view class="invoice">
				<u-form :model="form" ref="uForm" :rules="rules" label-width="auto" label-position="top">
					<u-form-item prop="invoiceType" label-position="top">
						<view slot="label" class="form-label">
							<text>请选择发票类型</text>
						</view>

						<u-radio-group v-model="form.invoiceType" @change="onInvoiceTypeChange" iconSize="24" size="32">
							<u-radio name="个人">个人</u-radio>
							<u-radio name="企业">企业</u-radio>
						</u-radio-group>
					</u-form-item>

					<u-form-item v-if="showEnterpriseFields" prop="invoiceTitle" required="true">
						<view slot="label" class="form-label">
							<text>企业名称</text>
							<text class="required-star">*</text>
						</view>
						<u-input v-model="form.invoiceTitle" placeholder="请输入企业名称" />
					</u-form-item>

					<u-form-item v-if="showEnterpriseFields" prop="taxId" required="true">
						<view slot="label" class="form-label">
							<text>公司税号</text>
							<text class="required-star">*</text>
						</view>
						<u-input v-model="form.taxId" placeholder="请输入公司税号" />
					</u-form-item>

					<u-form-item prop="email" required="true">
						<view slot="label" class="form-label">
							<text>接收邮箱</text>
							<text class="required-star">*</text>
						</view>
						<u-input v-model="form.email" placeholder="请输入接收电子发票的邮箱地址" />
					</u-form-item>
				</u-form>

			</view>

		</view>

		<!-- 按钮组容器 -->
		<view class="btn-group">
			<u-button :disabled="!isFormValid" :custom-style="primaryBtnStyle" @click="viewOrder">
				已填写发票信息，跳转至订单查看页
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
			},
			secondaryBtnStyle() {
				return {
					height: '98rpx',
					borderRadius: '49rpx',
					border: '2px solid rgba(142,142,142,0.5)',
					backgroundColor: 'transparent', // 透明背景
					fontWeight: 'bold',
					fontSize: '32rpx',
					color: '#3D3D3D'
				};
			},
			isFormValid() {
				const requiredFields = ['invoiceType', 'email'];
				if (this.form.invoiceType === '企业') {
					requiredFields.push('invoiceTitle', 'taxId');
				}
				return requiredFields.every(field => !!this.form[field]) && this.isEmailValid(this.form.email);
			},
			showEnterpriseFields() {
				return this.form.invoiceType === '企业';
			}
		},
		onReady() {
			// 设置验证规则
			this.$refs.uForm.setRules(this.rules);
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
				info: {
					userName: '', // 甲方姓名
					productName: '', // 产品名称
					price: 0, // 签约金额
					orderCode: '', // 协议号
					payDate: '', // 支付时间
				},
				form: {
					invoiceType: '个人', // 默认选择个人 1 个人 2 企业
					invoiceTitle: '',
					taxId: '',
					email: ''
				},
				rules: {
					invoiceType: [{
						required: true,
						message: '请选择发票类型',
						trigger: ['change']
					}],
					email: [{
							required: true,
							message: '邮箱不能为空',
							trigger: ['blur', 'change']
						},
						{
							validator: (rule, value, callback) => {
								if (!value || !value.trim()) {
									// 空值已在上一条 rule 检查，这里专注格式
									callback();
								} else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value.trim())) {
									callback(new Error('邮箱格式不正确'));
								} else {
									callback();
								}
							},
							trigger: ['blur', 'change']
						}
					],
					invoiceTitle: [{
						validator: (rule, value, callback) => {
							// 只有当发票类型是“企业”时才校验
							if (this.form.invoiceType === '企业') {
								if (!value || !value.trim()) {
									callback(new Error('企业名称不能为空'));
								} else {
									callback();
								}
							} else {
								callback(); // 非企业时不校验
							}
						},
						trigger: ['blur', 'change']
					}],
					taxId: [{
						validator: (rule, value, callback) => {
							// 只有当发票类型是“企业”时才校验
							if (this.form.invoiceType === '企业') {
								if (!value || !value.trim()) {
									callback(new Error('公司税号不能为空'));
								} else {
									callback();
								}
							} else {
								callback(); // 非企业时不校验
							}
						},
						trigger: ['blur', 'change']
					}]
				}
			};
		},
		methods: {
			async init() {
				this.info.userName = this.user.nickName;

				// 获取产品信息
				const productId = 1; // 固定值 1
				const res = await api.getProductById(productId);
				if (res.code == 200) {
					const data = res.data || {};
					this.info.productName = data.productName || '';
				}

				// 获取合同信息
				const result = await api.getFdpOrder(this.orderId);
				if (result.code == 200 && result.rows.length > 0) {
					const order = result.rows[0];

					this.info.price = order.priceOut;
					this.info.orderCode = order.orderCode; // 协议号
					this.info.payDate = order.payDate || ''; // 支付时间

					// 接收电子发票邮箱
					this.form.email = order.userEmail;
				}

			},
			// 查看订单
			async viewOrder() {
				try {
					await this.$refs.uForm.validate();
				} catch (errors) {
					uni.showToast({
						title: '请填写完整发票信息',
						icon: 'none'
					});
					return;
				}
				
				try {
					const invoiceType = this.form.invoiceType === '个人' ? 1 : 2;
					
					const params = {
					  email: this.form.email.trim(),
					  invoiceTitle: this.form.invoiceTitle.trim(),
					  invoiceType,
					  orderId: this.orderId,
					  taxId: this.form.taxId.trim()
					};
										
					const res = await api.updateInvoice(params);
					
					if (res.code === 200) {
					  uni.redirectTo({ url: `/pages/order/order` });
					}
				}catch (err) {
					console.log('err',err);
					// const msg = err.message ? err.message : '提交失败';
					// uni.showToast({
					// 	title: msg,
					// 	icon: 'none',
					// 	duration: 5000
					// });
				}
			},
			isEmailValid(email) {
				const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
				return re.test(email);
			},
			onInvoiceTypeChange(value) {
				// 清空企业相关字段
				if (value !== '企业') {
					this.form.invoiceTitle = '';
					this.form.taxId = '';
				}
			}
		}
	};
</script>

<style lang="scss" scoped>
	.container {
		background-color: #ffffff;
		padding: 0 74rpx;
		min-height: 100vh;
		box-sizing: border-box;
		position: relative;
		display: flex;
		flex-direction: column;
	}

	.content-container {
		.top {
			display: flex;
			flex-direction: column;
			justify-content: center;
			align-items: center;
			text-align: center;

			image {
				width: 100rpx;
				height: 100rpx;
				margin-bottom: 40rpx;
			}

			.title {
				font-weight: 800;
				font-size: 32rpx;
				color: #000000;
				margin-bottom: 40rpx;
				text-align: center;
			}
		}
	}

	.info {
		background: #F6F7FC;
		border-radius: 40rpx;
		padding: 0 60rpx;
		box-sizing: border-box;
		padding-top: 50rpx;

		.item {
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding-bottom: 50rpx;

			.label {
				font-weight: 500;
				font-size: 28rpx;
				color: #B0B0B0;
			}

			.value {
				font-weight: 500;
				font-size: 28rpx;
				color: #151515;
				flex: 1;
				text-align: right;
			}
		}

	}

	.desc {
		margin: 116rpx 26rpx;

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
				margin-bottom: 20rpx;

				.list-icon {
					width: 12rpx;
					height: 12rpx;
					background: #4A63E4;
					border-radius: 50%;
					margin-right: 18rpx;
				}

				.text {
					font-weight: bold;
					font-size: 26rpx;
					color: #5B5B5B;
				}
			}
		}

	}

	.btn-group {
		display: flex;
		flex-direction: column;
		gap: 22rpx;
		margin: 100rpx 0;
	}

	.invoice {
		margin-top: 50rpx;
	}

	.u-form {
		margin-top: 40rpx;
	}

	.form-label {
		display: flex;
		align-items: center;
		font-weight: bold;
		font-size: 28rpx;
		color: #000000;
		margin-bottom: 28rpx;

		.required-star {
			color: #ff4444;
			margin-left: 4rpx;
		}
	}

	.u-form-item {
		margin-bottom: 20rpx;
	}

	::v-deep .u-radio {
		margin-right: 320rpx !important;
	}

	// 最后一个 radio 不需要右边距（可选）
	::v-deep .u-radio:last-child {
		margin-right: 0 !important;
	}
</style>