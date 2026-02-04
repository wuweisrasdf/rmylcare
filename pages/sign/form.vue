<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" title="客户信息录入" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }" />

		<!-- 母亲基本信息 -->
		<view class="top-section">
			<text class="title">母亲基本信息</text>
			<text class="desc">请准确填写以下信息</text>
		</view>

		<!-- 只保留一个 u--form -->
		<u--form :model="formData" :rules="rules" ref="uForm" label-width="auto" label-position="top">
			<view class="content-section">
				<!-- 母亲姓名 -->
				<view class="form-item">
					<u-form-item prop="motherName" required class="custom-form-item">
						<view slot="label" class="form-label">
							<text>母亲姓名</text>
							<text class="required-star">*</text>
						</view>
						<u--input v-model="formData.motherName" placeholder="请输入母亲姓名" border="none"
							:custom-style="inputStyle" />
					</u-form-item>
				</view>

				<!-- 证件类型 + 证件号码 -->
				<view class="form-item double">
					<view class="">
						<u-form-item prop="motherIdType" required class="custom-form-item">
							<view slot="label" class="form-label">
								<text>证件类型</text>
								<text class="required-star">*</text>
							</view>

							<view class="custom-input" @click="openPicker('mother')"
								:style="{ width: '136rpx', paddingRight: '30rpx' }">
								<scroll-view scroll-x="true" style="width: 100%; white-space: nowrap;"
									class="scroll-view">
									<text>{{ getLabelById(formData.motherIdType, 'mother') || '请选择证件类型' }}</text>
								</scroll-view>
								<u-icon name="arrow-down" size="32" color="#2c2c2c" class="arrow-icon" />
							</view>

						</u-form-item>
					</view>
					<view class="half">
						<u-form-item prop="motherIdCode" required class="custom-form-item">
							<view slot="label" class="form-label">
								<text>证件号码</text>
								<text class="required-star">*</text>
							</view>
							<u--input v-model="formData.motherIdCode" placeholder="请输入证件号码" border="none"
								:custom-style="inputStyle" />
						</u-form-item>
					</view>
				</view>

				<!-- 母亲手机号 -->
				<view class="form-item">
					<u-form-item prop="motherPhone" class="custom-form-item">
						<view slot="label" class="form-label">
							<text>母亲手机号</text>
						</view>
						<u--input v-model="formData.motherPhone" placeholder="请输入手机号" border="none" height="80"
							:custom-style="inputStyle" />
					</u-form-item>
				</view>

				<!-- 预产医院 -->
				<view class="form-item">
					<u-form-item prop="hospitalName" required class="custom-form-item">
						<view slot="label" class="form-label">
							<text>预产医院</text>
							<text class="required-star">*</text>
						</view>
						<u--input v-model="formData.hospitalName" placeholder="请输入预产医院" border="none" height="80"
							:custom-style="inputStyle" />
					</u-form-item>
				</view>

				<!-- 预产期 -->
				<view class="form-item">
					<u-form-item prop="dueDate" required class="custom-form-item">
						<view slot="label" class="form-label">
							<text>预产期</text>
							<text class="required-star">*</text>
						</view>

						<view class="date-picker-input" @click="openDatePicker">
							<text>{{ formData.dueDate || '请选择预产期' }}</text>
							<image src="/static/icons/calendar.png" class="calendar-icon" />
						</view>

					</u-form-item>
				</view>

				<!-- 母亲邮箱 -->
				<view class="form-item">
					<u-form-item prop="motherEmail" class="custom-form-item">
						<view slot="label" class="form-label">
							<text>母亲邮箱</text>
						</view>
						<u--input v-model="formData.motherEmail" placeholder="请输入邮箱" border="none" height="80"
							:custom-style="inputStyle" />
					</u-form-item>
				</view>
			</view>

			<!-- 甲方基本信息 -->
			<view class="main-section">
				<text class="title">甲方基本信息</text>
			</view>

			<view class="content-section">
				<!-- 与母亲的关系 -->
				<view class="form-item">
					<u-form-item prop="motherRelation" required class="custom-form-item">
						<view slot="label" class="form-label">
							<text>与母亲的关系</text>
							<text class="required-star">*</text>
						</view>
						<view class="radio-section">
							<u-radio-group size="36" iconSize="30" v-model="formData.motherRelation"
								class="radio-group">
								<u-radio :name="'1'" label="本人" shape="circle" active-color="#4A63E4" labelSize="32"
									labelColor="#000000" :customStyle="{marginRight: '80rpx'}"
									@change="handleRelationChange('1')" />

								<u-radio :name="'2'" label="配偶" shape="circle" active-color="#4A63E4" labelSize="32"
									labelColor="#000000" @change="handleRelationChange('2')" />
							</u-radio-group>
						</view>

					</u-form-item>
				</view>

				<!-- 甲方姓名 -->
				<view class="form-item">
					<u-form-item prop="nickName" required class="custom-form-item">
						<view slot="label" class="form-label hint-wrapper">
							<text>甲方姓名</text>
							<text class="required-star">*</text>

							<view class="">
								<text class="hint">关系是丈夫，需填写</text>
							</view>
						</view>
						<u--input v-model="formData.nickName" placeholder="请输入甲方姓名" border="none"
							:custom-style="inputStyle" />

					</u-form-item>
				</view>

				<!-- 甲方证件类型 + 证件号码 -->
				<view class="form-item double">
					<view class="">
						<u-form-item prop="userIdType" required class="custom-form-item">
							<view slot="label" class="form-label">
								<text>证件类型</text>
								<text class="required-star">*</text>
							</view>

							<view class="custom-input" @click="openPicker('user')"
								:style="{ width: '136rpx', paddingRight: '30rpx' }">
								<scroll-view scroll-x="true" style="width: 100%; white-space: nowrap;"
									class="scroll-view">
									<text>{{ getLabelById(formData.userIdType, 'user') || '请选择证件类型' }}</text>
								</scroll-view>
								<u-icon name="arrow-down" size="32" color="#2c2c2c" class="arrow-icon" />
							</view>


						</u-form-item>
					</view>

					<view class="half">
						<u-form-item prop="userIdCode" required class="custom-form-item">
							<view slot="label" class="form-label">
								<text>证件号码</text>
								<text class="required-star">*</text>
							</view>
							<u--input v-model="formData.userIdCode" placeholder="请输入证件号码" border="none" height="80"
								:custom-style="inputStyle" />
						</u-form-item>
					</view>
				</view>

				<!-- 电话号码 -->
				<view class="form-item">
					<u-form-item prop="userPhone" required class="custom-form-item">
						<view slot="label" class="form-label">
							<text>电话号码</text>
							<text class="required-star">*</text>
						</view>
						<u--input v-model="formData.userPhone" placeholder="请输入电话号码" border="none" height="80"
							:custom-style="inputStyle" />
					</u-form-item>
				</view>

				<!-- 地址 -->
				<view class="form-item">
					<u-form-item prop="address" required class="custom-form-item">
						<view slot="label" class="form-label">
							<text>地址</text>
							<text class="required-star">*</text>
						</view>
						<u--input v-model="formData.address" placeholder="请输入详细地址" border="none" height="80"
							:custom-style="inputStyle" />
					</u-form-item>
				</view>
			</view>
		</u--form>

		<!-- 底部按钮 -->
		<view class="btn-group">
			<u-button :custom-style="prevBtnStyle" @click="goPrev">
				上一步
			</u-button>
			<u-button :custom-style="nextBtnStyle" @click="submitForm">
				下一步
			</u-button>
		</view>

		<!-- 证件类型选择器 -->
		<u-picker :show="showPicker" :columns="pickerList" keyName="label" @confirm="onPickerConfirm"
			@cancel="showPicker = false" @close="showPicker = false"></u-picker>

		<!-- 预产期日期选择器 -->
		<u-datetime-picker mode="date" :show="showDatePicker" :min-date="minDate" :max-date="maxDate"
			@confirm="onDateConfirm" @cancel="showDatePicker = false" @close="showDatePicker = false" />
	</view>
</template>

<script>
	import * as api from '@/utils/api.js'
	import { mapState } from 'vuex'
	
	export default {
		computed: {
			...mapState({
				user: state => state.user,
				token: state => state.token,
			}),
			containerPaddingTop() {
				return (this.CustomBar || 0) * 2 + 'rpx';
			},
			inputStyle() {
				return {
					backgroundColor: '#EDEDED',
					borderRadius: '20rpx',
					padding: '30rpx'
				};
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
		data() {
			return {
				formData: {
					motherId: 0,
					motherName: '',
					motherIdType: '1', // 母亲证件类型 1 身份证
					motherIdCode: '',
					motherPhone: '',
					motherEmail: '', // 产妇邮箱
					hospitalName: '', // 预产医院
					dueDate: '', // 预产期  datetime
					motherRelation: '2', // 甲方与产妇关系 1-本人、2-丈夫
					userId: '', // 甲方ID
					nickName: '', // 甲方姓名
					userIdType: '1', // 甲方证件类型
					userIdCode: '',
					userPhone: '',
					address: ''
				},
				rules: {
					motherName: [{
						required: true,
						message: '请填写母亲姓名',
						trigger: 'blur'
					}],
					motherIdType: [{
						required: true,
						message: '请选择证件类型',
						trigger: 'change'
					}],
					motherIdCode: [{
						required: true,
						message: '请填写证件号码',
						trigger: 'blur'
					}],
					hospitalName: [{
						required: true,
						message: '请填写预产医院',
						trigger: 'blur'
					}],
					dueDate: [{
						required: true,
						message: '请选择预产期',
						trigger: 'change'
					}],
					motherRelation: [{
						required: true,
						message: '请选择与母亲的关系',
						trigger: 'change'
					}],
					nickName: [{
						required: true,
						message: '请填写甲方姓名',
						trigger: 'blur'
					}],
					userIdType: [{
						required: true,
						message: '请选择证件类型',
						trigger: 'change'
					}],
					userIdCode: [{
						required: true,
						message: '请填写证件号码',
						trigger: 'blur'
					}],
					userPhone: [{
							required: true,
							message: '请填写电话号码',
							trigger: 'blur'
						},
						{
							pattern: /^1[0-9]\d{9}$/,
							message: '请输入正确的手机号码',
							trigger: 'blur'
						}
					],
					address: [{
						required: true,
						message: '请填写地址',
						trigger: 'blur'
					}],
					motherPhone: [{
						pattern: /^1[0-9]\d{9}$/,
						message: '请输入正确的手机号码',
						trigger: 'blur'
					}],
					motherEmail: [{
						type: 'email',
						message: '请输入正确的邮箱地址',
						trigger: 'blur'
					}]
				},
				idTypeOptions: [{
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
				],
				showPicker: false,
				currentPickerFor: '',
				pickerList: [],
				minDate: new Date('2020-01-01').getTime(), // 预产期最小日期
				maxDate: new Date('2030-12-31').getTime(), // 预产期最大日期
				showDatePicker: false
			};
		},
		onReady() {
			// 设置验证规则
			this.$refs.uForm.setRules(this.rules);
		},
		onLoad() {
			this.loadFormData();
		},
		methods: {
			async loadFormData() {
				try {
					const res = await api.getMotherAndUser();
					if (res.code === 200) {
						const motherInfo = res.mother && res.mother.length > 0 ? res.mother[0] : {};
						const userInfo = res.user || {};
						// 手动映射字段到 formData
						this.formData = {
							...this.formData,

							// 母亲信息
							motherId: motherInfo.id || 0,
							motherName: motherInfo.motherName || '',
							motherIdType: (motherInfo.idType && motherInfo.idType !== '0') ? motherInfo.idType : '1',
							motherIdCode: motherInfo.idCode || '',
							motherPhone: motherInfo.phonenumber || '',
							motherEmail: motherInfo.email || '',
							hospitalName: motherInfo.hospitalName || '',
							dueDate: motherInfo.dueDate || '',
							address: motherInfo.address || '',

							// 甲方（用户）信息
							userId: userInfo.userId || '',
							nickName: userInfo.nickName || '',
							userIdType: (userInfo.idType && userInfo.idType !== '0') ? userInfo.idType : '1',
							userIdCode: userInfo.idCode || '',
							userPhone: userInfo.phonenumber || '',
							motherRelation: motherInfo.motherRelation || '1'
						};
					}
				} catch (err) {
					console.error('加载表单数据失败:', err);
				}
			},
			handleRelationChange(value) {
				if (value === '1') { // 如果选择的是本人
					this.formData.nickName = this.formData.motherName;
					this.formData.userIdType = this.formData.motherIdType;
					this.formData.userIdCode = this.formData.motherIdCode;
					this.formData.userPhone = this.formData.motherPhone;
				} else {
					this.formData.nickName = ''; // 清空甲方姓名
					this.formData.userIdType = '1';
					this.formData.userIdCode = '';
					this.formData.userPhone = '';
				}
			},
			getLabelById(value, type) {
				const item = this.idTypeOptions.find(opt => opt.value === value);
				return item ? item.label : '请选择证件类型';
			},
			openPicker(type) {
				this.currentPickerFor = type;
				this.pickerList = [this.idTypeOptions.map(item => item.label)];
				this.showPicker = true;
			},
			onPickerConfirm(e) {
				const index = e.indexs[0];
				const selectedValue = this.idTypeOptions[index].value;
				if (this.currentPickerFor === 'mother') {
					this.formData.motherIdType = selectedValue;
				} else {
					this.formData.userIdType = selectedValue;
				}
				this.showPicker = false;
			},
			openDatePicker() {
				this.showDatePicker = true;
			},
			onDateConfirm(e) {
				// e = { value: 1609430400000, mode: 'date' }
				const timestamp = e.value; // 这是一个时间戳（毫秒）
				const date = new Date(timestamp);

				const year = date.getFullYear();
				const month = String(date.getMonth() + 1).padStart(2, '0'); // getMonth() 返回 0-11
				const day = String(date.getDate()).padStart(2, '0');

				this.formData.dueDate = `${year}-${month}-${day}`;
				this.showDatePicker = false;
			},
			showHint() {
				uni.showToast({
					title: '若为配偶，请填写甲方信息',
					icon: 'none'
				});
			},
			goPrev() {
				uni.navigateBack();
			},
			submitForm() {
				// 统一验证整个表单
				this.$refs.uForm.validate().then(res => {
					// 手动校验证件号长度（仅当证件类型为身份证时）
					let errorMsg = '';

					// 母亲证件号校验
					if (this.formData.motherIdType === '1') {
						if (!this.formData.motherIdCode || this.formData.motherIdCode.length !== 18) {
							errorMsg = '母亲身份证号码必须为18位';
						}
					}

					// 甲方证件号校验
					if (!errorMsg && this.formData.userIdType === '1') {
						if (!this.formData.userIdCode || this.formData.userIdCode.length !== 18) {
							errorMsg = '甲方身份证号码必须为18位';
						}
					}

					if (errorMsg) {
						uni.showToast({
							title: errorMsg,
							icon: 'none'
						});
						return;
					}


					this._submit();
				}).catch(errors => {
					uni.showToast({
						title: '请填写完整信息',
						icon: 'none'
					});
				});

			},
			async _submit() {
				this.formData.userId = this.user?.userId || ""
				console.log('提交数据:', this.formData);

				const params = this.formData;

				try {
					const res = await api.updateMotherAndUser(params);

					if (res.code == 200) {
						uni.showToast({
							title: '保存成功',
							icon: 'success'
						});
						setTimeout(() => {
							// 授权书页
							uni.navigateTo({
								url: "/pages/sign/auth"
							})
						}, 1000)
					}
				} catch (err) {
					console.log(err);
					uni.showToast({
						title: '提交失败',
						icon: 'none'
					});
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
	}

	.top-section,
	.main-section {
		display: flex;
		flex-direction: column;
		align-items: center;
		margin: 50rpx auto;

		.title {
			font-weight: bold;
			font-size: 36rpx;
			color: #000000;
		}
	}

	.top-section {
		.title {
			line-height: 66rpx;
		}

		.desc {
			font-weight: bold;
			font-size: 30rpx;
			color: #9A9A9A;
			line-height: 66rpx;
		}
	}

	.content-section {
		background: #F6F7FC;
		border-radius: 20rpx;
		padding: 40rpx 30rpx;
		margin-bottom: 60rpx;
	}

	.form-item {
		margin-bottom: 40rpx;

		&.double {
			display: flex;
			gap: 20rpx;

			.half {
				flex: 1;
			}
		}
	}

	.btn-group {
		display: flex;
		justify-content: space-between;
		margin-bottom: 120rpx;
		margin-top: 60rpx;
	}

	.radio-section {
		padding-left: 30rpx;
	}


	.form-label {
		display: flex;
		align-items: center;
		font-weight: bold;
		font-size: 32rpx;
		color: #000000;
		margin-bottom: 28rpx;
		padding-left: 30rpx;

		.required-star {
			color: #ff4444;
			margin-left: 4rpx;
		}
	}

	.hint-wrapper {
		position: relative;
	}

	.hint {
		position: absolute;
		right: 0;
		bottom: 0;
		font-weight: bold;
		font-size: 28rpx;
		color: #4A63E2;
	}

	.custom-input {
		display: flex;
		justify-content: space-between;
		align-items: center;
		background-color: #EDEDED;
		border-radius: 20rpx;
		padding: 30rpx;
		font-size: 28rpx;
		color: #646464;
		position: relative; // 确保子元素可以使用绝对定位
		width: 136rpx; // 固定宽度
		overflow: hidden; // 防止内容溢出
		white-space: nowrap; // 不换行
		text-overflow: ellipsis; // 超出显示省略号
	}

	.arrow-icon {
		margin-left: auto; // 将图标推到最右侧
		margin-right: -30rpx; // 调整图标的位置以适应padding-right
	}

	.scroll-view {
		flex: 1;
		white-space: nowrap;
		overflow-x: auto;
		-webkit-overflow-scrolling: touch;
		/* iOS 兼容 */
		padding-right: 20rpx;
		/* 留出空间给滚动条 */
	}

	.date-picker-input {
		background-color: #EDEDED;
		border-radius: 20rpx;
		padding: 30rpx;
		display: flex;
		align-items: center;
		justify-content: space-between;
		font-size: 28rpx;
		color: #646464;
	}

	.calendar-icon {
		width: 32rpx;
		height: 32rpx;
	}
</style>