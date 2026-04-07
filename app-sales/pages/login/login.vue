<template>
  <view class="login-container">
    <view class="logo-wrap">
      <!-- Logo -->
      <image src="/static/logo.png" mode="widthFix" class="logo" />
      <!-- 标题 -->
      <text class="title">智数健管销售端登录</text>
    </view>

    <!-- 表单 -->
    <!-- 注意，如果需要兼容微信小程序，最好通过setRules方法设置rules规则 -->
    <u--form labelPosition="top" labelWidth="auto" :model="formModel" :rules="rules" ref="formRef">
      <u-form-item label="账号" prop="account" ref="account">
        <u--input v-model="formModel.account" border="none" placeholder="请来输入账号"
          prefixIcon="/static/icons/username-icon.png"
          prefixIconStyle="font-size: 22px;color: #909399; width: 28rpx; height: 28rpx;"
          customStyle="background: #ccc; padding: 10rpx;"></u--input>
      </u-form-item>
      <u-form-item label="密码" prop="password" :password="!showPassword" ref="password">

        <!-- #ifndef APP-NVUE -->
        <u-input v-model="formModel.password" :password="!showPassword" border="none" placeholder="请来输入密码"
          prefixIcon="/static/icons/password-icon.png"
          prefixIconStyle="font-size: 22px;color: #909399; width: 28rpx; height: 28rpx;"
          customStyle="background: #ccc; padding: 10rpx;">
        <!-- #endif -->
          <!-- #ifdef APP-NVUE -->
          <u--input v-model="formModel.password" :password="!showPassword" border="none" placeholder="请来输入密码"
            prefixIcon="/static/icons/password-icon.png"
            prefixIconStyle="font-size: 22px;color: #909399; width: 28rpx; height: 28rpx;"
            customStyle="background: #ccc; padding: 10rpx;">
          <!-- #endif -->
            <template slot="suffix">
              <u-icon :name="showPassword ? 'eye-fill' : 'eye-off'" size="48" color="#999"
                @tap="togglePassword"></u-icon>
            </template>
        <!-- #ifndef APP-NVUE -->
        </u-input>
        <!-- #endif -->
        <!-- #ifdef APP-NVUE -->
        </u--input>
        <!-- #endif -->
      </u-form-item>
    </u--form>
    <!-- 登录按钮 -->
    <view class="login-btn">
      <u-button
      typw="primary"
      shape="circle"
      @click="onLogin()"
      customStyle="height: 98rpx; border-radius: 49rpx; background-color: #4A63E4; font-weight: bold; font-size: 32rpx; color: #fff;">登录</u-button>
    </view>
    
    <view class="back-to-home" @click="goHome">返回首页</view>
  </view>
</template>

<script>
  import {
    loginPwd
  } from '@/utils/api.js';
  export default {
    data() {
      return {
        formModel: {
          // account: '15888888888',
          // password: 'admin123'
          account: '',
          password: ''
        },
        rules: {
          'account': {
            type: 'string',
            required: true,
            message: '请填写账号',
            trigger: ['blur', 'change']
          },
          'password': {
            type: 'string',
            required: true,
            message: '请填写密码',
            trigger: ['blur', 'change']
          },
        },
        loading: false,
        showPassword: false // 控制密码可见性
      };
    },
    methods: {
			goHome() {
				uni.redirectTo({
					url: '/pages/index/index'
				})
			},
      togglePassword() {
        this.showPassword = !this.showPassword;
        if (this.showPassword) {
          this.formModel.password = this.formModel.password; // 可以用于触发视图更新
        }
      },
      onLogin() {
        this.$refs.formRef.validate().then(async () => {
          this.loading = true;
          console.log('loginpwd', {
            username: this.formModel.account,
            password: this.formModel.password,
          })
          const res = await loginPwd({
            username: this.formModel.account,
            password: this.formModel.password,
          });
          console.log('loginpwd')
          this.loading = false;
          if (res.code == 200) {
            this.$store.dispatch('login', res);
            uni.reLaunch({
              url: '/pages/index/index'
            })
          }
        }).catch(err => {
          console.log('验证失败:', err);
        });
      }
    },
    onLoad() {}
  };
</script>

<style lang="scss" scoped>
  .login-container {
    padding: 24rpx;

    ::v-deep .u-form-item__body__left {
      margin-bottom: 36rpx;
    }

    ::v-deep .u-form-item__body__left__content__label {
      font-size: 32rpx;
      color: #000;
    }

    ::v-deep .u-input__content {
      gap: 40rpx;
    }

    ::v-deep .u-input {
      padding: 26rpx 30rpx !important;
      border-radius: 20rpx !important;
      background: #F5F5F5 !important;
    }
  }

  .logo-wrap {

    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .logo {
    margin-top: 228rpx;
    width: 100rpx;
    height: 100rpx;
    margin-bottom: 30rpx;
  }

  .title {
    font-size: 44rpx;
    font-weight: bold;
    color: #000;
    margin-bottom: 134rpx;
    text-align: center;
  }

  .login-btn {
    margin-top: 140rpx;
  }
  
	.back-to-home {
		font-size: 28rpx;
		color: #878787;
		font-weight: bold;
		margin-top: 50rpx;
    text-align: center;
	}
</style>