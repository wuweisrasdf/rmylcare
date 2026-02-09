<template>
  <view class="container" :style="{ paddingTop: containerPaddingTop }">
	<u-navbar
	  :fixed="true"
	  :autoBack="true"
	  title="个人中心"
	  leftIconSize="36" leftIconColor="#2C2C2C"
	  :titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }"
	>
	</u-navbar>
	
	<view class="user-info-container">
	    <!-- 姓名 -->
	    <view class="list-item">
	      <view class="item-left">
	        <image class="icon" src="/static/icons/user.png" mode="aspectFill"></image>
	        <text class="label">编号</text>
	      </view>
	      <view class="item-right">
	        <text class="value">{{ formData.userName || '未获取' }}</text>
	      <!--  <text class="arrow">></text> -->
	      </view>
	    </view>
	
	    <!-- 昵称 -->
	    <view class="list-item" @click="handleGetUserInfo">
	      <view class="item-left">
	        <image class="icon" src="/static/icons/nickname.png" mode="aspectFill"></image>
	        <text class="label">姓名</text>
	      </view>
	      <view class="item-right">
	        <text class="value">{{ formData.nickName || '未设置' }}</text>
	        <text class="arrow">></text>
	      </view>
	    </view>
	
	    <!-- 手机号 -->
	    <view class="list-item" @click="editMobile">
	      <view class="item-left">
	        <image class="icon" src="/static/icons/phone.png" mode="aspectFill"></image>
	        <text class="label">手机号</text>
	      </view>
	      <view class="item-right">
	        <text class="value">{{ formData.phonenumber || '未绑定' }}</text>
	        <text class="arrow">></text>
	      </view>
	    </view>
	
	    <!-- 邮箱 -->
	    <view class="list-item" @click="editEmail">
	      <view class="item-left">
	        <image class="icon" src="/static/icons/email.png" mode="aspectFill"></image>
	        <text class="label">邮箱</text>
	      </view>
	      <view class="item-right">
	        <text class="value">{{ formData.email || '未绑定' }}</text>
	        <text class="arrow">></text>
	      </view>
	    </view>
	
	    <!-- 隐私政策 -->
	    <view class="list-item" @click="viewPrivacy">
	      <view class="item-left">
	        <image class="icon" src="/static/icons/privacy.png" mode="aspectFill"></image>
	        <text class="label">隐私政策</text>
	      </view>
	      <view class="item-right">
	        <text class="arrow">></text>
	      </view>
	    </view>
	
	    <!-- 用户服务协议 -->
	    <view class="list-item" @click="viewAgreement">
	      <view class="item-left">
	        <image class="icon" src="/static/icons/agreement.png" mode="aspectFill"></image>
	        <text class="label">用户服务协议</text>
	      </view>
	      <view class="item-right">
	        <text class="arrow">></text>
	      </view>
	    </view>
	
	    <!-- 退出 -->
	    <view class="list-item" @click="logout">
	      <view class="item-left">
	        <image class="icon" src="/static/icons/logout.png" mode="aspectFill"></image>
	        <text class="label">退出</text>
	      </view>
	      <view class="item-right">
	        <text class="arrow">></text>
	      </view>
	    </view>
	  </view>

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
import * as api from '@/utils/api.js'
import { mapState } from 'vuex'

export default {
  computed: {
	...mapState({
		user: state => state.user,
		token: state => state.token
	}),

	// 计算容器顶部内边距（转为 rpx）
	containerPaddingTop() {
	  // CustomBar 是 px，uni-app 中 1px = 2rpx
	  const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
	  console.log(barHeight)
	  return barHeight;
	}
  },
  data() {
    return {
      formData: {
		userName: '', // 微信姓名
        nickName: '', // 昵称
        phonenumber: '', // 电话
        email: '' // 邮箱
      },
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
		this.formData.userName = this.user.userName || '';
        this.formData.nickName = this.user.nickName || '';
        this.formData.phonenumber = this.user.phonenumber || '';
        this.formData.email = this.user.email || '';
		
		// 重置本地状态
		this.wechatNickname = '';
		this.tempNickname = '';
		this.tempMobile = '';
		this.tempEmail = '';
      }
    },

	handleGetUserInfo() {
	  // 判断是否有已存在的微信姓名
	  const hasUserName = this.user && this.user.nickName;
	
	  if (!hasUserName) {
	    // 没有姓名：直接获取，不弹确认框
	    console.log('当前无微信姓名，直接获取...');
	    this._triggerGetUserProfile();
	  } else {
	    // 已有姓名：弹出确认框，询问是否重新获取
	    uni.showModal({
	      title: '提示',
	      content: '是否获取微信姓名？',
	      confirmText: '确定',
	      cancelText: '取消',
	      success: (res) => {
	        if (res.confirm) {
	          console.log('用户同意重新获取微信姓名');
	          this._triggerGetUserProfile();
	        }
	      }
	    });
	  }
	},
	
	// 抽离获取逻辑，避免重复代码
	_triggerGetUserProfile() {
	  if (typeof uni.getUserProfile === 'function') {
	    this.useUniGetUserProfile();
	  } else if (wx && typeof wx.getUserProfile === 'function') {
	    this.useWxGetUserProfile();
	  } else {
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
		  this.formData.nickName = this.wechatNickname
		  this.saveUserInfo({userName: this.wechatNickname});
	      
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
	
	// 保存用户信息
	async saveUserInfo(options) {
		
		const params = {
			userId: this.user.userId, 
			userName: options.userName || this.user.userName,
			phonenumber: options.phonenumber || this.user.phonenumber,
			email: options.email || this.user.email,
			password: ""
		};
		
		try {
			const res = await api.updateUser(params);
			
			if (res.code == 200) {
				this.updateUserInfo();
			}
		} catch(err) {
			console.log('err',err);
			uni.showToast({ title: '网络错误', icon: 'none' });
		}
	},
	// 更新用户信息
	async updateUserInfo(){
		const res = await api.getUserDetail();
		if (res.code == 200) {
			const user = res.user;
			this.$store.dispatch('updateUserInfo',{user});
			
			uni.showToast({ title: '更新成功', icon: 'success' });
		}
		console.log("获取用户信息失败")
	},

    // --- 昵称 ---
    editNickname() {
      this.tempNickname = this.formData.nickName;
      this.showNicknameModal = true;
    },
    confirmNickname() {
      const val = this.tempNickname.trim();
      if (!val) {
        uni.showToast({ title: '昵称不能为空', icon: 'none' });
        return;
      }
      this.formData.nickName = val;
      this.showNicknameModal = false;
	  this.saveUserInfo({nickName: this.formData.nickName});
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
      this.formData.phonenumber = val;
      this.showMobileModal = false;
      this.saveUserInfo({phonenumber: this.formData.phonenumber});
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
      this.saveUserInfo({email: this.formData.email});
    },

    viewPrivacy() {
      uni.navigateTo({ url: '/pages/agreement/privacy' });
    },

    viewAgreement() {
      uni.navigateTo({ url: '/pages/agreement/agreement' });
    },

    logout() {
	  uni.showModal({
	    title: '提示',
	    content: '确定退出吗？',
	    confirmText: '确定',
	    cancelText: '取消',
	    success: (res) => {
	      if (res.confirm) {
	        this._logout();
	      }
	    }
	  });
    },
	async _logout(){
		const res = await api.logout('');
		if (res.code == 200) {
			  this.$store.dispatch('logout');
			  uni.showToast({ title: '已退出登录', icon: 'success' });
			  // 返回首页
			  setTimeout(() => {
				uni.reLaunch({ url: '/pages/login/login' });
			  }, 1000);
		}
	}
  }
};
</script>

<style lang="scss" scoped>
.container {
  background-color: #ffffff;
  /* 使用 padding-bottom 为 TabBar 留出空间 */
  padding: 0rpx 26rpx 180rpx;
  min-height: 100vh;
  box-sizing: border-box; /* 确保 padding 包含在 100vh 内 */
}

.user-info-container {
  background: #F5F5F7;
  border-radius: 40rpx;
  margin-top: 96rpx;
  padding: 0rpx 48rpx;
}

.list-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 36rpx 0;
  position: relative;

  &:not(:last-child)::after {
    content: '';
    position: absolute;
    right: 0;
    bottom: 0;
    left: 0;
    height: 2rpx;
    background: #ACACAC;
    opacity: 0.2;
  }
}

.item-left {
  display: flex;
  align-items: center;
  gap: 30rpx;
}

.icon {
  width: 38rpx;
  height: 38rpx;
}

.label {
  font-weight: bold;
  font-size: 32rpx;
  color: #000000;
}

.item-right {
  display: flex;
  align-items: center;
  gap: 10rpx;
  justify-content: flex-end;
}

.value {
  font-weight: 500;
  font-size: 28rpx;
  color: #ACACAC;
  line-height: 58rpx;
}

.arrow {
  font-weight: 400;
  font-size: 36rpx;
  color: #161421;
  line-height: 58rpx;
  opacity: 0.5;
}

</style>