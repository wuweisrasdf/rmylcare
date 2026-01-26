<template>
  <view class="container">

    <scroll-view scroll-y class="main-content">
      <!-- 头像区域 -->
      <view class="profile-item" @click="changeAvatar">
        <text class="label">头像</text>
        <view class="right">
          <image 
            class="avatar" 
            :src="userAvatar" 
            mode="aspectFill"
          />
          <u-icon name="arrow-right" size="28" color="#c0c4cc"></u-icon>
        </view>
      </view>

      <!-- 姓名（微信昵称） -->
	<view class="profile-item">
	  <text class="label">姓名</text>
	  <view class="right">
		<text class="value">{{ wechatName || '未获取' }}</text>
		<button 
			v-if="!wechatName"
		      class="mini-auth-btn"
		      @click="handleGetUserInfo"
		    >
		      获取
		</button>
		
	  </view>
	</view>

      <!-- 昵称 -->
      <view class="profile-item" @click="editNickname">
        <text class="label">昵称</text>
        <view class="right">
          <text class="value">{{ formData.nickname || '未设置' }}</text>
          <u-icon name="arrow-right" size="28" color="#c0c4cc"></u-icon>
        </view>
      </view>

      <!-- 手机号 -->
      <view class="profile-item" @click="editMobile">
        <text class="label">手机号</text>
        <view class="right">
          <text class="value">{{ formData.mobile || '未绑定' }}</text>
          <u-icon name="arrow-right" size="28" color="#c0c4cc"></u-icon>
        </view>
      </view>

      <!-- 邮箱 -->
      <view class="profile-item" @click="editEmail">
        <text class="label">邮箱</text>
        <view class="right">
          <text class="value">{{ formData.email || '未绑定' }}</text>
          <u-icon name="arrow-right" size="28" color="#c0c4cc"></u-icon>
        </view>
      </view>

      <!-- 分割线 -->
      <view class="divider"></view>

      <!-- 隐私政策 -->
      <view class="profile-item" @click="viewPrivacy">
        <text class="label">隐私政策</text>
        <u-icon name="arrow-right" size="28" color="#c0c4cc"></u-icon>
      </view>

      <!-- 用户协议 -->
      <view class="profile-item" @click="viewAgreement">
        <text class="label">用户服务协议</text>
        <u-icon name="arrow-right" size="28" color="#c0c4cc"></u-icon>
      </view>

      <!-- 分割线 -->
      <view class="divider"></view>

      <!-- 登录/退出按钮 -->
      <view class="profile-item" @click="toggleLogin">
        <text class="label logout">{{ isLogin ? '退出登录' : '立即登录' }}</text>
      </view>
    </scroll-view>

    <!-- 底部占位 -->
    <view style="height: 120rpx;"></view>

    <!-- uView 2 组件 -->
    <u-toast ref="uToast" />
    
    <!-- 修改昵称弹窗 -->
    <u-modal 
      :show="showNicknameModal" 
      title="修改昵称" 
      confirm-text="保存"
      @confirm="confirmNickname"
      @cancel="showNicknameModal = false"
	  showCancelButton="true"
	  @close="showNicknameModal = false"
    >
      <u--input 
        v-model="tempNickname" 
        placeholder="请输入昵称"
        border="none"
      />
    </u-modal>
	
	<!-- 修改手机号弹窗 -->
	<u-modal 
	  :show="showMobileModal" 
	  title="修改手机号" 
	  confirm-text="下一步"
	  @confirm="confirmMobile"
	  @cancel="showMobileModal = false"
	  showCancelButton="true"
	  @close="showMobileModal = false"
	>
	  <u--input 
	    v-model="tempMobile" 
	    placeholder="请输入新手机号"
	    type="number"
	    border="none"
	  />
	</u-modal>
	
	<!-- 修改邮箱弹窗 -->
	<u-modal 
	  :show="showEmailModal" 
	  title="修改邮箱" 
	  confirm-text="保存"
	  @confirm="confirmEmail"
	  @cancel="showEmailModal = false"
	  showCancelButton="true"
	@close="showEmailModal = false"
	>
	  <u--input 
	    v-model="tempEmail" 
	    placeholder="请输入邮箱地址"
	    border="none"
	  />
	</u-modal>
	
  </view>
</template>

<script>
import { mapState } from 'vuex'

export default {
  computed: {
    ...mapState(['user', 'token']),
    isLogin() {
      return !!this.token && this.user
    },
    userAvatar() {
      if (this.localAvatar) return this.localAvatar; // 优先使用本地选择的头像
      if (this.user?.avatar) {
        // 如果是完整 URL 直接用，否则拼接（根据你后端返回格式调整）
        return this.user.avatar.startsWith('http') 
          ? this.user.avatar 
          : 'https://' + this.user.avatar;
      }
      return '/static/images/avatar-placeholder.png';
    },
    wechatName() {
      return this.wechatNickname || this.user?.wechat_nickname || this.user?.nickname || '';
    }
  },
  data() {
    return {
      formData: {
        nickname: '',
        mobile: '',
        email: ''
      },
	  localAvatar: '',
	  // 微信昵称（临时）
	   wechatNickname: '',
      // 昵称
      tempNickname: '',
      showNicknameModal: false,
      // 手机号
      tempMobile: '',
      showMobileModal: false,
      // 邮箱
      tempEmail: '',
      showEmailModal: false,
    };
  },
  onLoad() {
    this.initData();
  },
  methods: {
    initData() {
      if (this.user) {
        this.formData.nickname = this.user.nickname || '';
        this.formData.mobile = this.user.mobile || '';
        this.formData.email = this.user.email || '';
		
		// 重置本地状态
		this.localAvatar = '';
		this.wechatNickname = '';
      }
    },

    // ========== 功能方法（占位，无真实 API 调用）==========
	handleGetUserInfo() {
	  console.log('点击获取用户信息');
	  
	  // 先检查是否支持
	  if (typeof uni.getUserProfile === 'function') {
		this.useUniGetUserProfile();
	  } else if (wx.getUserProfile) {
		// 使用微信原生 API
		this.useWxGetUserProfile();
	  } else {
		// 都不支持，提示升级
		uni.showModal({
		  title: '提示',
		  content: '当前微信版本过低，请升级微信后重试',
		  showCancel: false
		});
	  }
	},
	
	// 获取用户信息
	useUniGetUserProfile() {
	  uni.getUserProfile({
	    desc: '用于完善会员资料',
	    success: (res) => {
	      console.log('uni.getUserProfile 成功:', res);
	      const { nickName, avatarUrl } = res.userInfo;
	      this.wechatNickname = nickName;
	      //this.localAvatar = avatarUrl;
		  this.saveUserInfo(nickName);
	      
	      uni.showToast({
	        title: '获取成功',
	        icon: 'success'
	      });
	    },
	    fail: (err) => {
	      console.error('获取失败:', err);
	      uni.showToast({
	        title: err.errMsg || '获取失败',
	        icon: 'none'
	      });
	    }
	  });
	},
	

	saveUserInfo(nickName) {
	    // 这里调用你的API接口
	    console.log('保存用户信息到后端:', nickName);
	    
		// 2. 【占位】提交到后端保存（重要！）
		// TODO: 调用你的更新接口，例如：
		// this.$http.post('/api/user/update', {
		//   nickname: nickName,
		//   avatar: avatarUrl
		// }).then(res => {
		//   // 成功后更新 Vuex 的 user 数据
		//   this.$store.commit('UPDATE_USER', { nickname: nickName, avatar: avatarUrl });
		// });
	  },

    changeAvatar() {
		uni.chooseImage({
			count: 1,
			sizeType: ['compressed'],
			sourceType: ['album', 'camera'],
			success: (res) => {
			  const tempFilePath = res.tempFilePaths[0];
			  // 立即更新本地预览
			  this.localAvatar = tempFilePath;
			  console.log('【已选头像】本地路径:', tempFilePath);
			  // TODO: 调用上传接口，成功后 dispatch updateUserInfo
			},
			fail: (err) => {
			  console.error('选择头像失败', err);
			}
		});
    },

    // --- 昵称 ---
    editNickname() {
		console.log('【点击昵称】准备打开弹窗')
      this.tempNickname = this.formData.nickname;
      this.showNicknameModal = true;
    },
    confirmNickname() {
      const val = this.tempNickname.trim();
      if (!val) {
        uni.showToast({ title: '昵称不能为空', icon: 'none' });
        return;
      }
      this.formData.nickname = val;
      this.showNicknameModal = false;
      console.log('【待提交】昵称:', this.formData.nickname);
      // TODO: 调用 updateUser 接口
    },

    // --- 手机号 ---
    editMobile() {
      this.tempMobile = this.formData.mobile;
      this.showMobileModal = true;
    },
    confirmMobile() {
      const val = this.tempMobile.trim();
      if (!val) {
        uni.showToast({ title: '请输入手机号', icon: 'none' });
        return;
      }
      // 简单校验（实际应更严格）
      const phoneReg = /^1[0-9]\d{9}$/;
      if (!phoneReg.test(val)) {
        uni.showToast({ title: '手机号格式不正确', icon: 'none' });
        return;
      }
      this.formData.mobile = val;
      this.showMobileModal = false;
      console.log('【待提交】手机号:', this.formData.mobile);
      // TODO: 跳转到验证码验证页 或 调用绑定接口
    },

    // --- 邮箱 ---
    editEmail() {
      this.tempEmail = this.formData.email;
      this.showEmailModal = true;
    },
    confirmEmail() {
      const val = this.tempEmail.trim();
      if (!val) {
        uni.showToast({ title: '请输入邮箱', icon: 'none' });
        return;
      }
      // 邮箱正则（简化版）
      const emailReg = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailReg.test(val)) {
        uni.showToast({ title: '邮箱格式不正确', icon: 'none' });
        return;
      }
      this.formData.email = val;
      this.showEmailModal = false;
      console.log('【待提交】邮箱:', this.formData.email);
      // TODO: 调用绑定邮箱接口（通常需发送验证码）
    },

    viewPrivacy() {
      console.log('【占位】跳转隐私政策页面');
      uni.navigateTo({ url: '/pages/agreement/privacy' });
    },

    viewAgreement() {
      console.log('【占位】跳转用户协议页面');
      uni.navigateTo({ url: '/pages/agreement/agreement' });
    },

    toggleLogin() {
      if (this.isLogin) {
        // 退出登录
        this.$store.dispatch('logout');
        uni.showToast({ title: '已退出登录', icon: 'success' });
        // 清空本地状态
		this.localAvatar = '';
		this.wechatNickname = '';
		this.formData = { nickname: '', mobile: '', email: '' };
		// 返回首页
		setTimeout(() => {
		  uni.redirectTo({ url: '/pages/login/login' });
		}, 1000);
      } else {
        // 跳转登录页
        uni.redirectTo({ url: '/pages/login/login' });
      }
    }
  }
};
</script>

<style lang="scss" scoped>
.container {
  background-color: #f5f5f5;
  min-height: 100vh;
}

/* 自定义导航栏 */
.custom-nav {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 88rpx; /* 状态栏(44px) + 导航栏(44px) ≈ 88rpx */
  padding: 0 30rpx;
  background-color: #ffffff;
  box-shadow: 0 2rpx 12rpx rgba(0, 0, 0, 0.05);
  position: sticky;
  top: 0;
  z-index: 999;
}

.nav-title {
  font-size: 36rpx;
  font-weight: 600;
  color: #333333;
}

.main-content {
  padding: 20rpx 0;
}

.profile-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 32rpx 30rpx;
  background-color: #ffffff;
  margin: 0 20rpx 20rpx;
  border-radius: 16rpx;
  box-shadow: 0 2rpx 12rpx rgba(0, 0, 0, 0.03);
}

.label {
  font-size: 32rpx;
  color: #333333;
  font-weight: 500;
}

.logout {
  color: #ff3b30;
}

.right {
  display: flex;
  align-items: center;
  gap: 16rpx;
}

.value {
  font-size: 30rpx;
  color: #999999;
  max-width: 300rpx;
  text-align: right;
  overflow: hidden;
  text-overflow: ellipsis;
}

.avatar {
  width: 80rpx;
  height: 80rpx;
  border-radius: 50%;
  background-color: #f0f0f0;
}

.divider {
  height: 20rpx;
  background-color: #f5f5f5;
  margin: 20rpx 0;
}

// 小型授权按钮样式
.mini-auth-btn {
  width: auto;
  height: 48rpx;
  min-width: 80rpx;
  padding: 0 16rpx;
  font-size: 24rpx;
  line-height: 48rpx;
  color: #fff;
  background-color: #5ac725;;
  border: 1rpx solid #5ac725;;
  border-radius: 8rpx;
  outline: none;
  box-shadow: none;
  -webkit-tap-highlight-color: transparent;

  // 关键：清除微信 button 默认边框
  &::after {
    border: none;
  }
}
</style>