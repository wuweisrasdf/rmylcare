<template>
	<view class="login-container">
		<!-- Logo -->
		<view class="logo-section">
			<image :src="logoUrl" class="logo" mode="widthFix" />

			<text class="logo-text">智数健管</text>
		</view>

		<!-- 一键登录按钮 -->
		<view class="login-btn-section" :style="{paddingBottom: isRedirecting ? '134rpx' : '78rpx'}">
			<button class="login-btn" open-type="getPhoneNumber" @getphonenumber="onGetPhoneNumber"
				:disabled="!isAgreed">
				一键登录
			</button>
			
			<view v-if="isRedirecting" class="redirect-text">
				<u-loading-icon size="28"></u-loading-icon>
				<text class="loading-text">{{loadingText}}</text>
			</view>
		</view>

		<!-- 协议提示 -->
		<view class="agreement-container">
			<view class="link-section">
				<u-checkbox-group v-model="agreeList" @change="toggleAgree">
					<u-checkbox name="agree" shape="square" active-color="#4A63E2" size="32" iconSize="24"
						labelSize="28" label="我已阅读并同意" />
				</u-checkbox-group>
				<navigator url="/pages/agreement/agreement" class="link-item">
					<text class="link-text">《用户协议》</text>
				</navigator>
				<text class="separator">·</text>
				<navigator url="/pages/agreement/privacy" class="link-item">
					<text class="link-text">《隐私政策》</text>
				</navigator>
			</view>

			<text class="agreement-text" @click="goHome">返回首页</text>
		</view>



		<!-- 底部说明 -->
		<text class="footer-text">
			首次登录将自动创建账户，如有问题，请联系客服
		</text>

	</view>
</template>

<script>
	import * as api from '@/utils/api.js'
	import {
		mapGetters
	} from 'vuex';

	import privacyAgreenPop from '@/components/privacyAgreenPop/privacyAgreenPop.vue';

	export default {
		components: {
			privacyAgreenPop
		},
		computed: {
			...mapGetters(['isLogined']),
			// 新增：判断是否已同意协议
			isAgreed() {
				return this.agreeList.includes('agree');
			}
		},
		data() {
			return {
				logoUrl: '/static/logo.png', // 替换为你的 logo 路径
				isRedirecting: false,
				loadingText: "正在登录中...",
				privacyWxPopShow: false,
				agreeList: [], // 存放被选中的 name 值
			};
		},
		onLoad() {
			// 是否登录
			if (this.isLogined) {
				uni.redirectTo({
					url: '/pages/index/index' // 替换为你的首页路径
				});
				return;
			}
		},
		methods: {
			goHome() {
				uni.redirectTo({
					url: '/pages/index/index'
				})
			},
			toggleAgree(e) {
				console.log('e', e)
			},
			// 获取手机号授权
			async onGetPhoneNumber(e) {
				if (!this.isAgreed) {
					uni.showToast({
						title: '请先同意用户协议和隐私政策',
						icon: 'none'
					});
					return;
				}

				if (e.detail.errMsg !== "getPhoneNumber:ok") {
					uni.showToast({
						title: '授权失败',
						icon: 'none'
					});
					return;
				}

				let code2 = '';
				try {
					const loginRes = await uni.login();
					code2 = loginRes.code;
				} catch (err) {
					console.error('获取登录 code 失败', err);
					uni.showToast({
						title: '登录初始化失败',
						icon: 'none'
					});
					return;
				}


				// 2. 准备数据
				const {
					encryptedData,
					iv,
					code
				} = e.detail;

				// 3. 发送给后端（关键！三个参数都要传）
				try {
					this.isRedirecting = true;
					this.loadingText = "正在登录中...";

					const params = {
						code,
						encryptedData,
						iv,
						code2 // 用于获取 openid
					};
					const res = await api.getwxphone(params);

					// console.log('res',res);

					if (res.code == 200) {
						const token = res.token;
						const phone = res.phone;

						uni.setStorageSync('token', token || '');
						if (token) {
							uni.setStorageSync('token', token);
							this.getUserInfo();
						}
					}
				} catch (err) {
					console.log('err', err);
					console.log(`encryptedData=${encryptedData}&code=${code}&iv=${iv}&code2=${code2}`)
					let msg = err.message || '网络错误'
					uni.showToast({
						title: msg,
						icon: 'none',
						duration: 5000
					});
				} finally {
					this.isRedirecting = false;
				}
			},
			// token获取用户信息
			async getUserInfo() {
				const res = await api.getUserDetail();
				if (res.code == 200) {
					const user = res.user;
					console.log('user', user);
					this.$store.dispatch('login', {
						user
					});

					// 是否来自扫描二维码
					const fromScan = uni.getStorageSync('FROM_SCAN');

					uni.showToast({
						title: '登录成功',
						icon: 'success'
					});

					// 跳转首页（清除登录页，防止返回）
					setTimeout(() => {
						if (fromScan) {
							// 是从扫码进入的 → 跳签约页
							uni.removeStorageSync('FROM_SCAN');
							uni.redirectTo({
								url: '/pages/index/flow'
							});
						} else {
							// 普通打开 → 跳首页
							uni.redirectTo({
								url: '/pages/index/index' // 替换为你的首页路径
							});
						}
					}, 800); // 短暂延迟，确保 toast 显示完成

				}
				//console.log("获取用户信息失败")
			}

			//-- end
		}
	}
</script>

<style lang="scss" scoped>
	.login-container {
		background: #ffffff;
		display: flex;
		flex-direction: column;
		align-items: center;
		position: relative;
		padding: 60rpx 25rpx;
		justify-content: space-between; // 确保内容在垂直方向上均匀分布，使footer-text处于底部
		min-height: 100vh; // 最小高度设置为视窗高度，保证即使内容少也能撑满屏幕高度
	}

	/* Logo区域 */
	.logo-section {
		text-align: center;
		margin-top: 180rpx;
		display: flex;
		flex-direction: column;
	}

	.logo {
		width: 102rpx;
		height: 96rpx;
		margin: 0 auto;
	}

	.logo-text {
		font-weight: 800;
		font-size: 44rpx;
		color: #000000;
		line-height: 72rpx;
		margin-top: 30rpx;
	}

	/* 登录按钮区域 */
	.login-btn-section {
		width: 100%;
		display: flex;
		justify-content: center;
		//padding: 78rpx 0rpx 134rpx;
		padding: 78rpx 0rpx;
		border-radius: 20rpx;
		background-color: #F8F9FD;
		margin-top: 176rpx;
		flex-direction: column;
		position: relative;
	}

	.redirect-text {
		position: absolute;
		bottom: 48rpx;
		width: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.login-btn {
		width: 538rpx;
		height: 98rpx;
		border-radius: 52rpx;
		background-color: #4A63E4;
		color: #fff;
		font-size: 36rpx;
		border: none;
		outline: none;

	}
	
	wx-button[disabled]:not([type]), wx-button[disabled][type=default] {
	    background-color: #A4AFEB;
		color: #ffffff;
	}

	.loading-text {
		font-size: 28rpx;
		color: #666;
		text-align: center;
		margin-left: 20rpx;
	}

	.agreement-container {
		display: flex;
		flex-direction: column;
		align-items: center;
		margin-top: 112rpx;
	}

	.agreement-text {
		font-size: 28rpx;
		color: #878787;
		font-weight: bold;
		margin-top: 50rpx;
	}

	.link-section {
		display: flex;
		align-items: center; // 垂直居中对齐
		//gap: 10rpx; // 元素之间的间距
		flex-wrap: nowrap; // 防止换行
	}

	.u-checkbox {
		margin-right: 10rpx;
		/* 给复选框右侧添加一些间距 */
	}

	.link-item {
		text-decoration: none;
		display: flex;
		align-items: center; // 垂直居中对齐链接文本
	}

	.link-text {
		font-size: 28rpx;
		color: #4A63E2;
		font-weight: bold;
		line-height: 1.2; // 调整行高以匹配其他文本
	}

	.separator {
		font-size: 28rpx;
		color: #4A63E2;
		font-weight: bold;
	}

	.footer-text {
		text-align: center;
		margin-top: auto; // 这个属性很重要，它会把footer-text推到父容器的最底部
		margin-bottom: 78rpx;

		font-weight: bold;
		font-size: 26rpx;
		color: #9F9F9F;
		line-height: 52rpx;
	}
</style>