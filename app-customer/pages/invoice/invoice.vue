<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" title="发票管理" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<view class="content-container">
			<view class="notice-card tips">
				<text class="notice-text">
					您的订单将在完成后开具发票，请耐心等待。如需修改发票抬头，请在签收前进行修改。
				</text>
			</view>

			<view class="invoice">
				<u-form :model="form" ref="uForm" :rules="rules" label-width="auto" label-position="top">
					<u-form-item prop="invoiceType" label-position="top">
						<view slot="label" class="form-label">
							<text>请选择发票类型</text>
						</view>

						<u-radio-group v-model="form.invoiceType" @change="onInvoiceTypeChange" iconSize="24" size="32" :disabled="currentStatusId >= 7">
							<u-radio name="个人">个人</u-radio>
							<u-radio name="企业">企业</u-radio>
						</u-radio-group>
					</u-form-item>

					<u-form-item prop="invoiceTitle" required="true">
						<view slot="label" class="form-label">
							<text>发票抬头</text>
							<text class="required-star">*</text>
						</view>
						<u-input v-model="form.invoiceTitle" 
						 :placeholder="form.invoiceType === '个人' ? '个人' : '请输入企业名称'"
						 :disabled="form.invoiceType === '个人' || currentStatusId >= 7" />
					</u-form-item>

					<u-form-item v-if="showEnterpriseFields" prop="taxId" required="true">
						<view slot="label" class="form-label">
							<text>公司税号</text>
							<text class="required-star">*</text>
						</view>
						<u-input v-model="form.taxId" placeholder="请输入公司税号" :disabled="currentStatusId >= 7" />
					</u-form-item>

					<u-form-item prop="email" required="true">
						<view slot="label" class="form-label">
							<text>接收邮箱</text>
							<text class="required-star">*</text>
						</view>
						<u-input v-model="form.email" placeholder="请输入接收电子发票的邮箱地址" />
					</u-form-item>
				</u-form>

				<view class="save-btn-wrapper">
					<u-button :custom-style="saveBtnStyle" @click="saveInvoiceInfo" :disabled="!isFormValid">
						保存
					</u-button>
				</view>
			</view>

			<view class="desc">
				<view class="desc-head">
					<view class="desc-icon"></view>
					<text class="desc-title">提示</text>
				</view>
				<view class="desc-content">
					<view class="content-item">
						<!-- <view class="list-icon"></view> -->
						<text class="text">当下方按钮变为蓝色时，表示发票已开具。请点击按钮，系统将自动把发票推送到接收邮箱。</text>
					</view>
				</view>
			</view>
		</view>

		<view class="btn-group">
			<u-button :custom-style="primaryBtnStyle" @click="sendInvoice" :disabled="!canSend">
				发送到邮箱
			</u-button>
			<u-button :custom-style="prevBtnStyle" @click="goPrev">
				返回订单详情
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
			saveBtnStyle() {
				return {
					height: '70rpx', // 调整高度
					borderRadius: '35rpx',
					backgroundColor: '#4A63E4',
					color: '#FFFFFF',
					fontSize: '26rpx',
					fontWeight: 'bold',
					width: '300rpx',
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
			},
			// 是否可以发送邮件
			canSend(){
				return this.invoiceUploaded && this.isEmailValid(this.form.email);
			}
		},
		onReady() {
			// 设置验证规则
			this.$refs.uForm.setRules(this.rules);
		},
		onLoad(options) {
			if (options.invoiceUploaded === 'true'){
				this.invoiceUploaded = true;
			}
			
			if (options.currentStatusId) {
				this.currentStatusId = options.currentStatusId;
			}
			if (options.orderId) {
				this.orderId = options.orderId;
				this.init();
			}
		},
		data() {
			return {
				orderId: '',
				invoiceUploaded: false,
				issued: false, // 是否已开发票
				savedInvoiceTitle: '', // 用于缓存企业信息
				form: {
					invoiceType: '个人', // 默认选择个人 1 个人 2 企业
					invoiceTitle: '个人',
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
				try {
					const res = await api.getInvoice(this.orderId);
					if (res.code == 200) {
						this.form.taxId = res.taxId || '';
						this.form.email = res.email || '';
						this.form.invoiceTitle = res.invoiceTitle || '';
						this.form.invoiceType = res.invoiceType == '2' ? '企业' : '个人';
						
						// 缓存企业抬头（用于切换恢复）
						if (this.form.invoiceType === '企业') {
							this.savedInvoiceTitle = this.form.invoiceTitle;
						}
					}
				} catch (error) {
					console.error('失败:', error);
				}
			},
			goPrev() {
				uni.navigateBack({
					delta: 1
				})
			},
			isEmailValid(email) {
				const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
				return re.test(email);
			},
			onInvoiceTypeChange(value) {
				if (value === '个人') {
					this.savedInvoiceTitle = this.form.invoiceTitle;
					this.form.invoiceTitle = '个人';
				} else {
					this.form.invoiceTitle = this.savedInvoiceTitle || '';
				}
			},
			// 保存发票信息
			async saveInvoiceInfo() {
				try {
					let invoiceType = 2;
					let invoiceTitle = this.form.invoiceTitle.trim();
					let taxId = this.form.taxId.trim();
					
					if (this.form.invoiceType === '个人') {
						invoiceType = 1;
						invoiceTitle = '个人';
						taxId = '';
					}else{
						this.savedInvoiceTitle = invoiceTitle;
					}

					const params = {
						email: this.form.email.trim(),
						invoiceTitle,
						invoiceType,
						orderId: this.orderId,
						taxId: taxId
					};

					const res = await api.updateInvoice(params);

					if (res.code === 200) {
						uni.showToast({
							title: '操作成功',
							icon: 'success'
						});
					}
				} catch (err) {
					console.log('err', err);
				}
			},
			// 发送发票到接收邮箱
			async sendInvoice() {
				const params = {
					email: this.form.email.trim(),
					orderId: this.orderId
				};
				
				if (!params.email) {
					uni.showToast({
						title: '邮箱不能为空',
						icon: 'none'
					});
					return;
				}

				const res = await api.sendInvoice(params);
				if (res.code == 200) {
					uni.showToast({
						title: '操作成功',
						icon: 'success'
					});
				} else {
					uni.showToast({
						title: res.msg || '操作失败',
						icon: 'none'
					});
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
	}

	.btn-group {
		display: flex;
		flex-direction: column;
		gap: 22rpx;
		width: 100%;
		margin: 50rpx auto 120rpx;
		padding: 0 26rpx;
		box-sizing: border-box;
	}

	.invoice {
		margin-top: 50rpx;
		background-color: #FFFFFF; // 背景颜色
		border-radius: 16rpx; // 圆角
		box-shadow: 0 4rpx 16rpx rgba(0, 0, 0, 0.08); // 阴影效果
		padding: 30rpx; // 内边距
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

	.notice-card {
		display: flex;
		align-items: flex-start;
		background-color: #F0F5FF;
		border-radius: 16rpx;
		padding: 24rpx;
		margin: 30rpx 0;
	}

	.tips {
		background-color: #FFF8E1;
	}

	.notice-text {
		font-size: 28rpx;
		color: #333333;
		line-height: 2;
		flex: 1;
	}


	.desc {
		margin-top: 50rpx;
		background-color: #FFFFFF;
		border-radius: 16rpx;
		padding: 24rpx;

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
			margin-top: 30rpx;

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
					line-height: 1.8;
				}
			}
		}

	}
	
	.save-btn-wrapper{
		margin: 30rpx 0;
	}
</style>