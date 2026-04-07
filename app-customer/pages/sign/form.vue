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
							:custom-style="inputStyle" @input="handleMotherNameInput" />
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
								:custom-style="inputStyle" @input="handleMotherIdCodeInput" />
						</u-form-item>
					</view>
				</view>

				<!-- 母亲手机号 -->
				<view class="form-item">
					<u-form-item prop="motherPhone"  required  class="custom-form-item">
						<view slot="label" class="form-label">
							<text>母亲手机号</text>
							<text class="required-star">*</text>
						</view>
						<u--input v-model="formData.motherPhone" placeholder="请输入手机号" border="none" height="80"
							:custom-style="inputStyle" @input="handleMotherPhoneInput" />
					</u-form-item>
				</view>

				<!-- 预产医院 -->
				<view class="form-item">
					<u-form-item prop="hospitalName" required class="custom-form-item">
						<view slot="label" class="form-label">
							<text>预产医院</text>
							<text class="required-star">*</text>
						</view>

						<view class="date-picker-input" @click="goToHospitalSelect">
							<text>{{ formData.hospitalName || '请选择预产医院' }}</text>
							<u-icon name="arrow-right" color="#999" size="36"></u-icon>
						</view>
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
								<text class="hint">关系是配偶，需填写</text>
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

				<!-- 邮箱 -->
				<view class="form-item">
					<u-form-item prop="userEmail" required class="custom-form-item">
						<view slot="label" class="form-label">
							<text>邮箱</text>
							<text class="required-star">*</text>
						</view>
						<u--input v-model="formData.userEmail" placeholder="请输入邮箱" border="none" height="80"
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
						<u--input v-model="formData.address" placeholder="请输入详细收货地址" border="none" height="80"
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
					motherRelation: '1', // 甲方与产妇关系 1-本人、2-丈夫
					userId: '', // 甲方ID
					nickName: '', // 甲方姓名
					userIdType: '1', // 甲方证件类型
					userIdCode: '',
					userPhone: '',
					userEmail: '', // 甲方邮箱
					address: ''
				},
				rules: {
					motherName: [{
						required: true,
						message: '请填写母亲姓名',
						trigger: 'blur'
					}, {
						min: 2,
						max: 50,
						message: '姓名长度必须在 2 到 50 个字符之间',
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
					}, {
						min: 2,
						max: 50,
						message: '姓名长度必须在 2 到 50 个字符之间',
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
							pattern: /^1[3-9]\d{9}$/,
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
							required: true,
							message: '请填写电话号码',
							trigger: 'blur'
						},
						{
							pattern: /^1[3-9]\d{9}$/,
							message: '请输入正确的手机号码',
							trigger: 'blur'
						}
					],
					motherEmail: [{
						type: 'email',
						message: '请输入正确的邮箱地址',
						trigger: 'blur'
					}],
					userEmail: [{
						required: true,
						type: 'email',
						message: '请输入正确的邮箱地址',
						trigger: 'blur'
					}],
					motherIdCode: [{
							required: true,
							message: '请填写证件号码',
							trigger: 'blur'
						},
						// 【新增】身份证格式校验器
						{
							validator: (rule, value, callback) => {
								// 只有当证件类型是身份证 且 有值时才校验
								if (this.formData.motherIdType === '1' && value) {
									if (!this.isValidIdCard(value)) {
										callback(new Error('母亲身份证号码格式不正确'));
									} else {
										callback();
									}
								} else {
									callback();
								}
							},
							trigger: 'blur'
						}
					],
					userIdCode: [{
							required: true,
							message: '请填写证件号码',
							trigger: 'blur'
						},
						// 【新增】身份证格式校验器
						{
							validator: (rule, value, callback) => {
								// 只有当证件类型是身份证 且 有值时才校验
								if (this.formData.userIdType === '1' && value) {
									if (!this.isValidIdCard(value)) {
										callback(new Error('甲方身份证号码格式不正确'));
									} else {
										callback();
									}
								} else {
									callback();
								}
							},
							trigger: 'blur'
						}
					]
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
				minDate: new Date().getTime(), // 预产期最小日期
				maxDate: new Date('2035-12-31').getTime(), // 预产期最大日期
				showDatePicker: false,
				orderId: 0, // 订单id
				salesId: 0, // 销售ID
				productInfo: {
					id: '',
					productName: '',
					price: '',
					navbar: '',
					details: ''
				},
				orderInfo: {}
			};
		},
		onReady() {
			// 设置验证规则
			this.$refs.uForm.setRules(this.rules);
		},
		onLoad(options) {
			if (options.orderId) {
				this.orderId = options.orderId
			} else {
				// 新增订单，从storage 获取 销售id
				this.salesId = uni.getStorageSync('SCAN_SALES_ID') || 0;
			}

			uni.$on('selectHospital', (hospital) => {
				this.formData.hospitalName = hospital;
			});

			this.init();

		},
		onUnload() {
			uni.$off('selectHospital'); // 销毁
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

					this.loadFormData();
				}
			},
			// 如果是修改未签约的订单，则加载已添加的数据
			async loadFormData() {
				this.resetForm();

				// 如果没有 orderId，说明是新建流程，保持空表单
				if (!this.orderId) return;


				try {
					// 1. 通过 orderId 获取订单详情（含 motherId）
					const orderRes = await api.getFdpOrder(this.orderId);
					if (orderRes.code !== 200 || !orderRes.rows?.[0]) {
						uni.showToast({
							title: '订单信息获取失败',
							icon: 'none'
						});
						return;
					}

					const order = orderRes.rows[0];
					const motherId = order.motherId;
					if (!motherId) {
						uni.showToast({
							title: '订单未关联产妇',
							icon: 'none'
						});
						return;
					}

					// 已签约订单，不允许修改
					if (order.proStatus != 2) {
						uni.showToast({
							title: '已签约订单，不允许修改',
							icon: 'none',
							duration: 3000
						});
						return;
					}

					// if (order.signDate) { // order.signDate 这个不靠谱
					// 	uni.showToast({
					// 		title: '该订单已签约',
					// 		icon: 'none'
					// 	});
					// 	return;
					// }

					// 2. 获取产妇和甲方信息
					const res = await api.getMotherAndUser();
					if (res.code !== 200) return;

					// 3. 查找匹配的产妇
					const motherInfo = Array.isArray(res.mother) ?
						res.mother.find(m => String(m.id) === String(motherId)) || null :
						null;

					if (!motherInfo) {
						uni.showToast({
							title: '产妇信息不存在',
							icon: 'none'
						});
						return;
					}

					// 4. 甲方信息
					const userInfo = res.user || {};

					// 5. 填充表单
					Object.assign(this.formData, {
						motherId: motherInfo.id,
						motherName: motherInfo.motherName || '',
						motherIdType: motherInfo.idType && motherInfo.idType !== '0' ? motherInfo.idType : '1',
						motherIdCode: motherInfo.idCode || '',
						motherPhone: motherInfo.phonenumber || '',
						motherEmail: motherInfo.email || '',
						hospitalName: motherInfo.hospitalName || '',
						dueDate: motherInfo.dueDate || '',
						address: motherInfo.address || '',
						motherRelation: motherInfo.motherRelation || '1',

						// 甲方（用户）信息
						userId: userInfo.userId || '',
						nickName: userInfo.nickName || '',
						userIdType: (userInfo.idType && userInfo.idType !== '0') ? userInfo.idType : '1',
						userIdCode: userInfo.idCode || '',
						userPhone: userInfo.phonenumber || '',
						userEmail: userInfo.email || '',
					});

				} catch (err) {
					console.error('加载表单数据失败:', err);
				}
			},
			// 重置表单
			resetForm() {
				this.formData = {
					motherId: 0,
					motherName: '',
					motherIdType: '1',
					motherIdCode: '',
					motherPhone: '',
					motherEmail: '',
					hospitalName: '',
					dueDate: '',
					address: '',
					motherRelation: '1',
					userId: '',
					nickName: '',
					userIdType: '1',
					userIdCode: '',
					userPhone: '',
					userEmail: ''
				};
			},
			// 母亲姓名输入时同步
			handleMotherNameInput(val) {
				if (this.formData.motherRelation === '1') {
					this.formData.nickName = val;
				}
			},

			// 母亲证件类型变化时同步（注意：picker 是点击选择，不是 input）
			handleMotherIdTypeChange(val) {
				if (this.formData.motherRelation === '1') {
					this.formData.userIdType = val;
				}
			},

			// 母亲证件号码输入时同步
			handleMotherIdCodeInput(val) {
				if (this.formData.motherRelation === '1') {
					this.formData.userIdCode = val;
				}
			},

			// 母亲手机号输入时同步
			handleMotherPhoneInput(val) {
				if (this.formData.motherRelation === '1') {
					this.formData.userPhone = val;
				}
			},

			// 母亲邮箱输入时同步（如果你有母亲邮箱字段）
			handleMotherEmailInput(val) {
				if (this.formData.motherRelation === '1') {
					this.formData.userEmail = val;
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
					this.formData.userEmail = '';
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

					if (this.formData.motherRelation === '1') {
						this.formData.userIdType = selectedValue;
					}
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
			goToHospitalSelect() {
				uni.navigateTo({
					url: '/pages/sign/hospital-select'
				});
			},
			goPrev() {
				uni.navigateBack();
			},
			// 身份证合法性校验（18位）
			isValidIdCard(idCard) {
				// 转换为大写
				const cardId = String(idCard).toUpperCase();

				// 正则验证基本格式
				const regx = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/;
				if (!regx.test(cardId)) {
					return false;
				}

				// 分割数组
				let arr_split = [];

				if (cardId.length === 18) {
					// 检查18位
					// 校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
					const arr_int = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
					const arr_ch = ['1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'];
					let sign = 0;

					for (let i = 0; i < 17; i++) {
						const b = parseInt(cardId[i], 10);
						const w = arr_int[i];
						sign += b * w;
					}

					const n = sign % 11;
					const val_num = arr_ch[n];

					// 校验码验证
					if (val_num !== cardId.substr(17, 1)) {
						return false;
					} else {
						return true;
					}

				} else if (cardId.length === 15) {
					// 检查15位
					const regx15 = /^(\d{6})+(\d{2})+(\d{2})+(\d{2})+(\d{3})$/;
					const match = cardId.match(regx15);

					if (!match) {
						return false;
					}

					// 检查生日日期是否正确
					const dtm_birth = '19' + match[2] + '-' + match[3] + '-' + match[4];
					const birthDate = new Date(dtm_birth);

					// 验证日期有效性（模仿PHP的strtotime行为）
					if (this.isValidDate(birthDate, dtm_birth)) {
						return true;
					} else {
						return false;
					}
				}

				return false;
			},
			/**
			 * 辅助函数：验证日期是否有效（模仿PHP的strtotime行为）
			 */
			isValidDate(date, dateString) {
				// 检查日期对象是否有效
				if (Object.prototype.toString.call(date) !== '[object Date]' || isNaN(date.getTime())) {
					return false;
				}

				// 验证日期格式是否匹配
				const parts = dateString.split('-');
				if (parts.length !== 3) return false;

				const year = parseInt(parts[0], 10);
				const month = parseInt(parts[1], 10);
				const day = parseInt(parts[2], 10);

				// 检查日期是否与输入一致
				if (date.getFullYear() !== year ||
					(date.getMonth() + 1) !== month ||
					date.getDate() !== day) {
					return false;
				}

				// 检查月份和日期的合理性
				if (month < 1 || month > 12 || day < 1 || day > 31) {
					return false;
				}

				// 检查特定月份的天数
				const daysInMonth = new Date(year, month, 0).getDate();
				if (day > daysInMonth) {
					return false;
				}

				return true;
			},
			async submitForm() {
				// 表单验证
				try {
					await this.$refs.uForm.validate();
				} catch (errors) {
					uni.showToast({
						title: '请填写完整信息',
						icon: 'none'
					});
					return;
				}

				// 身份证校验
				let errorMsg = '';
				if (this.formData.motherIdType === '1' && !this.isValidIdCard(this.formData.motherIdCode)) {
					errorMsg = '母亲身份证号码格式不正确';
				}
				if (!errorMsg && this.formData.userIdType === '1' && !this.isValidIdCard(this.formData.userIdCode)) {
					errorMsg = '甲方身份证号码格式不正确';
				}
				if (errorMsg) {
					uni.showToast({
						title: errorMsg,
						icon: 'none'
					});
					return;
				}

				// 显示 loading，覆盖整个提交+创建订单+跳转流程
				uni.showLoading({
					title: '保存中...',
					mask: true
				});

				try {
					// 1. 保存母亲和用户信息
					const motherId = await this.saveMotherAndUser();
					if (!motherId) return; // 错误已在内部处理并 hideLoading

					// 2. 如果是新订单，创建 PDF 订单
					if (!this.orderId) {
						const newOrderId = await this.createPdfOrder(motherId);
						if (!newOrderId) return;
						this.orderId = newOrderId;
					}

					// 3. 获取最新用户信息并跳转
					await this.finalizeAndNavigate();

				} catch (err) {
					console.error('整体提交流程异常:', err);
					uni.hideLoading();
					uni.showToast({
						title: '操作失败，请重试',
						icon: 'none'
					});
				}
			},
			// 仅保存数据，返回 motherId 或 null
			async saveMotherAndUser() {
				this.formData.userId = this.user?.userId || "";
				try {
					const res = await api.updateMotherAndUser(this.formData);
					if (res.code === 200 && res.motherId) {
						this.formData.motherId = res.motherId;
						return res.motherId;
					} else {
						uni.hideLoading();
						uni.showToast({
							title: res.msg || '保存信息失败',
							icon: 'none'
						});
						return null;
					}
				} catch (err) {
					uni.hideLoading();
					uni.showToast({
						title: '网络错误，请重试',
						icon: 'none'
					});
					return null;
				}
			},
			async createPdfOrder(motherId) {
				const now = new Date();
				const today =
					`${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')} ${String(now.getHours()).padStart(2, '0')}:${String(now.getMinutes()).padStart(2, '0')}:${String(now.getSeconds()).padStart(2, '0')}`;

				const params = {
					motherId: motherId, // 母亲id
					orderStatus: 11, // 订单状态 11-未交费
					priceOut: this.productInfo.price, // 费用
					proCode: "", // 订单编号
					proStatus: 2, // 协议状态 2-未签
					recordStatus: 1, // 记录状态 1-有效
					signDate: today,
					userId: this.user.userId, // 当前用户id
					salesId: this.salesId // 销售id
				};

				try {
					const res = await api.createFdpOrder(params);
					if (res.code === 200 && res.id) {
						return res.id;
					} else {
						uni.hideLoading();
						uni.showToast({
							title: res.msg || '创建订单失败',
							icon: 'none'
						});
						return null;
					}
				} catch (err) {
					uni.hideLoading();
					uni.showToast({
						title: '创建订单时网络错误',
						icon: 'none'
					});
					return null;
				}
			},
			// 最终获取用户信息并跳转
			async finalizeAndNavigate() {
				try {
					const res = await api.getUserDetail();
					if (res.code === 200) {
						this.$store.dispatch('updateUserInfo', {
							user: res.user
						});
					}
				} catch (err) {
					console.warn('获取用户详情失败，但不影响跳转');
				}

				// 所有操作完成，隐藏 loading 并跳转
				uni.hideLoading();
				uni.showToast({
					title: '保存成功',
					icon: 'success'
				});

				setTimeout(() => {
					uni.navigateTo({
						url: `/pages/sign/auth?orderId=${this.orderId}`
					});
				}, 1000);
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