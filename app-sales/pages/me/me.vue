<template>
  <view class="container">
    <!-- <u-sticky offset-top="0" bgColor="">
      <view class="top-wrap">
        <view class="top-radius"></view>
      </view>
    </u-sticky> -->
    <view class="my-page">
      <!-- 头像区域 -->
      <view class="avatar-container">
        <!-- 显示头像 -->
        <image 
          v-if="userAvatar" 
          :src="'/static/images/avatar-placeholder.png'" 
          class="avatar" 
          mode="aspectFill"
        />
        
        <!-- 获取头像按钮 -->
        <!-- <button 
          v-if="!isEmptyInfo(user)"
          open-type="chooseAvatar" 
          @chooseavatar="onChooseAvatar"
          class="avatar-btn"
        >
        </button> -->
      </view>
      
      <template v-if="!isEmptyInfo(user)">
      <view class="card-title">
        基本信息
      </view>
      <view class="card-wrap">
          <view class="list-wrap">
            <!-- <view class="list-item" @click="popChangeDialog('username')"> -->
            <view class="list-item">
              <view class="list-item-name-wrap">
                <image src="/static/icons/username.png" mode="aspectFill" class="list-item-icon"></image>
                <view class="list-item-name">
                  姓名
                </view>
              </view>
              <view class="list-item-arr-wrap">
                <view class="list-item-arr-name">
                  {{user.nickName || '姓名'}}
                </view>
                <!-- <u-icon name="arrow-right" class="list-item-arr" color="#999"></u-icon> -->
              </view>
            </view>
            <view class="list-item" @click="popChangeDialog('email')">
              <view class="list-item-name-wrap">
                <image src="/static/icons/email.png" mode="aspectFill" class="list-item-icon"></image>
                <view class="list-item-name">
                  邮箱
                </view>
              </view>
              <view class="list-item-arr-wrap">
                <view class="list-item-arr-name">
                  {{user.email || '邮箱'}}
                </view>
                <u-icon name="arrow-right" class="list-item-arr" color="#999"></u-icon>
              </view>
            </view>
            <view class="list-item" @click="popChangeDialog('phone')">
              <view class="list-item-name-wrap">
                <image src="/static/icons/phone.png" mode="aspectFill" class="list-item-icon"></image>
                <view class="list-item-name">
                  联系电话
                </view>
              </view>
              <view class="list-item-arr-wrap">
                <view class="list-item-arr-name">
                  {{user.phonenumber || '联系电话'}}
                </view>
                <u-icon name="arrow-right" class="list-item-arr" color="#999"></u-icon>
              </view>
            </view>
          </view>
      </view>
      </template>

      
      <view class="card-title">
        账户与安全
      </view>
      <view class="card-wrap">
          <view class="list-wrap">
            <view class="list-item" @click="loginClick()">
              <view class="list-item-name-wrap">
                <image src="/static/icons/username.png" mode="aspectFill" class="list-item-icon"></image>
                <view class="list-item-name" style="color: #333">
                  {{!isEmptyInfo(user) ? '退出登录' : '登录'}}
                </view>
              </view>
              <view class="list-item-arr-wrap">
                <!-- <view class="list-item-arr-name">
                  登录
                </view> -->
                <u-icon name="arrow-right" class="list-item-arr" color="#999"></u-icon>
              </view>
            </view>
            <view v-if="!isEmptyInfo(user)" class="list-item" @click="popChangeDialog('password')">
              <view class="list-item-name-wrap">
                <image src="/static/icons/password.png" mode="aspectFill" class="list-item-icon"></image>
                <view class="list-item-name" style="color: #333">
                  修改密码
                </view>
              </view>
              <view class="list-item-arr-wrap">
                <!-- <view class="list-item-arr-name">
                  邮箱
                </view> -->
                <u-icon name="arrow-right" class="list-item-arr" color="#999"></u-icon>
              </view>
            </view>
          </view>
      </view>

      <!-- 弹出窗口 -->
      <view class="popdialog-wrap">
        <u-modal :show="popChangeDialogShow" :showCancelButton="true" @confirm="popChangeDialogConfirm" @cancel="popChangeDialogShow = false" 
        :title="popChangeDialogName"
        confirmColor="#fff"
        >
          <view class="slot-content">
            <u--form
                labelPosition="top"
                labelWidth="auto"
                :model="formModel"
                :rules="rules"
                ref="formRef"
            >
              <u-form-item
                  label=" "
                  prop="username"
                  ref="username"
                  v-if="popChangeDialogType == 'username'"
              >
                <u--input
                    v-model="formModel.username"
                    border="none"
                    placeholder="输入姓名"
                    :clearable="true"
                    customStyle="background: #eee; padding: 10rpx 20rpx; border-radius: 20rpx;"
                ></u--input>
              </u-form-item>
              
              <u-form-item
                  label=" "
                  type="email"
                  prop="email"
                  ref="email"
                  v-if="popChangeDialogType == 'email'"
              >
                <u--input
                    v-model="formModel.email"
                    border="none"
                    placeholder="输入邮箱"
                    :clearable="true"
                    customStyle="background: #eee; padding: 10rpx 20rpx; border-radius: 20rpx;"
                ></u--input>
              </u-form-item>
              
              <u-form-item
                  label=" "
                  type="number"
                  prop="phone"
                  ref="phone"
                  v-if="popChangeDialogType == 'phone'"
              >
                <u--input
                    v-model="formModel.phone"
                    border="none"
                    placeholder="输入联系电话"
                    :clearable="true"
                    customStyle="background: #eee; padding: 10rpx 20rpx; border-radius: 20rpx;"
                ></u--input>
              </u-form-item>
              
              <u-form-item
                  label=" "
                  prop="password"
                  ref="password"
                  v-if="popChangeDialogType == 'password'"
              >
                <u--input
                    v-model="formModel.password"
                    border="none"
                    placeholder="输入原密码"
                    :clearable="true"
                    customStyle="background: #eee; padding: 10rpx 20rpx; border-radius: 20rpx;"
                ></u--input>
              </u-form-item>
              <u-form-item
                  label=" "
                  prop="newPassword"
                  ref="newPassword"
                  v-if="popChangeDialogType == 'password'"
              >
                <u--input
                    v-model="formModel.newPassword"
                    border="none"
                    placeholder="输入新密码"
                    :clearable="true"
                    customStyle="background: #eee; padding: 10rpx 20rpx; border-radius: 20rpx;"
                ></u--input>
                <view class="input-tip">
                  新密码不能少于6位，且必须包含字母，数字和特殊字符
                </view>
              </u-form-item>
              <u-form-item
                  label=" "
                  prop="verifyPassword"
                  ref="verifyPassword"
                  v-if="popChangeDialogType == 'password'"
              >
                <u--input
                    v-model="formModel.verifyPassword"
                    border="none"
                    placeholder="再次输入新密码"
                    :clearable="true"
                    customStyle="background: #eee; padding: 10rpx 20rpx; border-radius: 20rpx;"
                ></u--input>
              </u-form-item>
              
              <!-- <u-form-item
                  label=" "
                  prop="code"
                  ref="code"
                  v-if="['phone', 'password'].indexOf(popChangeDialogType) > -1"
              >
                <u--input
                  v-model="formModel.code"
                  border="none"
                    placeholder="输入验证码"
                  :clearable="true"
                  customStyle="background: #eee; padding: 10rpx 20rpx; border-radius: 20rpx;"
                ></u--input>
                <u-button
                  slot="right"
                  @tap="getCode"
                  :text="tips"
                  type="success"
                  size="small"
                  :disabled="disabled1"
                  customStyle="background: #5686ff; border: none; border-radius: 20rpx; margin-left: 10rpx;"
                ></u-button>
              </u-form-item> -->
              
            </u--form>
          </view>
        </u-modal>
      </view>
    
      <u-code
        ref="uCode"
        @change="codeChange"
        seconds="60"
        @start="disabled1 = true"
        @end="disabled1 = false"
      ></u-code>
      
      <TabBar :current-tab="currentTab"/>
      
    </view>

  </view>
</template>

<script>
  import {putUserDetailByUid, getUserDetailByUid, getUserDetail, sendvcode, checkvcode, uploadURL, loginPwd, logout} from '@/utils/api.js'
	import { mapState } from 'vuex'
	
	import TabBar from '@/components/TabBar/TabBar.vue';
	
	export default {
		components: {
		    TabBar
		},
		computed: {
		    // 从 store 映射 user 对象
		    ...mapState(['user']),
		    
		    // 计算属性：返回有效的头像URL
		    userAvatar() {
		      // 检查 user 是否存在，以及 avatar 字段是否有有效值
		      if (this.user && this.user.avatar) {
		        // 如果 avatar 是一个完整的 URL (http/https)，直接返回
		        if (this.user.avatar.startsWith('http')) {
		          return this.user.avatar;
		        }
		        // 如果 avatar 是一个相对路径（可能性小），也返回
		        return this.user.avatar;
		      }
		      // 否则，返回默认头像
		      return '/static/images/avatar-placeholder.png';
		    }
		  },
		data() {
			return {
				currentTab: 1,
        popChangeDialogType: 'username',
        popChangeDialogShow: false,
        popChangeDialogName: '修改姓名',
        
				disabled1: false,
        tips: '获取验证码',
        formModel: {
          username: '',
          email: '',
          phone: '',
          password: '',
          newPassword: '',
          verifyPassword: '',
          code: '',
        },
        rules: {
          'username': {
            type: 'string',
            required: true,
            message: '请填写姓名',
            trigger: ['blur', 'change']
          },
          'email': [
            {
              type: 'string',
              required: true,
              message: '请正确填写邮箱',
              trigger: ['blur', 'change'],
              type: 'email'
            },
            {
              validator: (rule, value, callback) => {
                console.log(rule, value)
                // 返回true表示校验通过，返回false表示不通过
                // uni.$u.test.email()就是返回true或者false的
                return uni.$u.test.email(value);
              },
              trigger: ['blur', 'change'],
              message: '手机号格式不正确'
            },
          ],
          'phone': [
            {
              required: true,
              message: '请填写联系电话',
              trigger: ['blur', 'change'],
            },
            {
              validator: (rule, value, callback) => {
                console.log(rule, value)
                // 返回true表示校验通过，返回false表示不通过
                // uni.$u.test.mobile()就是返回true或者false的
                return uni.$u.test.mobile(value);
              },
              trigger: ['blur', 'change'],
              message: '手机号格式不正确'
            },
          ],
          'code': {
            type: 'string',
            required: true,
            message: '请填写验证码',
            trigger: ['blur']
          },
          'password': {
            type: 'string',
            required: true,
            message: '请填写原密码',
            trigger: ['blur', 'change']
          },
          'newPassword': [
            {
              type: 'string',
              required: true,
              message: '请填写新密码',
              trigger: ['blur', 'change']
            },
            {
              validator: (rule, value, callback) => {
                console.log(rule, value)
                // 不能少于6位，且必须包含字母，数字和特殊字符
                // 返回true表示校验通过，返回false表示不通过
                return /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]).{6,}$/.test(value);
              },
              trigger: ['blur', 'change'],
              message: '新密码不能少于6位，且必须包含字母，数字和特殊字符'
            },
          ],
          'verifyPassword': [
            {
              type: 'string',
              required: true,
              message: '请再次填写新密码',
              trigger: ['blur', 'change']
            },
            {
              validator: (rule, value, callback) => {
                console.log(rule, value)
                // 返回true表示校验通过，返回false表示不通过
                return this.isSameNewPassword();
              },
              trigger: ['blur', 'change'],
              message: '两次密码不一致，请重新输入'
            },
          ],
        },
			};
		},
		onLoad(options) {
      this.$refs.formRef.setRules(this.rules)
		},
		methods: {
      async loginClick() {
        if (this.isEmptyInfo(this.user)) {
          uni.reLaunch({
            url: '/pages/login/login'
          })
        } else {
          const res = await logout();
          if (res.code == 200) {
            this.$store.dispatch('logout');
            uni.reLaunch({
              url: '/pages/index/index'
            })
          }
        }
      },
      popChangeDialog(type) {
        this.popChangeDialogType = type;
        this.popChangeDialogShow = true;
        if (type == 'username') {
          this.formModel.username = this.user.nickName || '';
          this.popChangeDialogName = '修改姓名';
        }
        if (type == 'email') {
          this.formModel.email = this.user.email || '';
          this.popChangeDialogName = '修改邮箱';
        }
        if (type == 'phone') {
          this.formModel.phone = this.user.phonenumber || '';
          this.popChangeDialogName = '联系电话';
        }
        if (type == 'login') {
          this.popChangeDialogName = '修改登录';
        }
        if (type == 'password') {
          this.popChangeDialogName = '修改密码';
          this.formModel.password = '';
          this.formModel.newPassword = '';
          this.formModel.verifyPassword = '';
        }
      },
      popChangeDialogConfirm() {
        this.$refs.formRef.validate().then(async () => {
          console.log('this.formModel', this.formModel)
          // if (['phone', 'password'].indexOf(this.popChangeDialogType) > -1) {
          //   const res = checkvcode({
          //     phonenumber: this.formModel.phone,
          //     vcode: this.formModel.code
          //   });
          //   if (res.code == 200) {
          //     this.modifyUserInfo();
          //   } else {
          //     this.$refs.uCode.reset();
          //     this.disabled1 = false;
          //   }
          // } else {
          //   this.modifyUserInfo();
          // }
          if (['password'].indexOf(this.popChangeDialogType) > -1) {
            console.log({
              username: this.user.userName,
              password: this.formModel.password,
            });
            // return false;
            const res = await loginPwd({
              username: this.user.userName,
              password: this.formModel.password,
            });
            if (res.code == 200) {
              this.$store.dispatch('login', res);
              this.getUserDetailFunc();
            } else {
              // this.$refs.uCode.reset();
              // this.disabled1 = false;
              uni.showToast({
                title: '原密码错误',
                icon: 'error'
              })
            }
          } else {
            this.modifyUserInfo([this.popChangeDialogType]);
          }
        }).catch(err => {
          console.log('验证失败:', err);
        });
      },
      async getUserDetailFunc() {
        const res = await getUserDetail();
        if (res.code == 200) {
          this.$store.dispatch('updateUserInfo', res);
          this.modifyUserInfo(['password']);
        }
      },
      async modifyUserInfo(arr) {
        console.log('modifyUserInfo', arr)
        this.popChangeDialogShow = false;
        let params = {
          // userId: this.user.userId,  
          // // password: this.formModel.newPassword,
          // phonenumber: this.formModel.phone || this.user.phonenumber,
          // email: this.formModel.email || this.user.email,
          // userName: this.user.userName,
        };
        if (arr.indexOf('phone') > -1) {
          params = {
            userId: this.user.userId,
            phonenumber: this.formModel.phone,
            userName: this.user.userName,
            // userName: 'JCH1255',
          };
        }
        if (arr.indexOf('email') > -1) {
          params = {
            userId: this.user.userId,
            email: this.formModel.email,
            userName: this.user.userName,
            // userName: 'JCH1255',
          };
        }
        if (arr.indexOf('password') > -1) {
          // params.password = this.formModel.newPassword;
          params = {
            userId: this.user.userId,
            password: this.formModel.newPassword,
            userName: this.user.userName,
            // userName: 'JCH1255',
          };
        }
        // return false;
        const res = await putUserDetailByUid(params);
        this.popChangeDialogShow = false;
        // return;
        if (res.code == 200) {
          uni.showToast({
            title: '修改成功',
            icon: 'success'
          })
          this.updateUserInfo(params);
        }
      },
      async updateUserInfo(params) {
        /* const res = await getUserDetailByUid(this.user.userId);
        if (res.code == 200) {
          this.$store.dispatch('updateUserInfo', res);
        } */
        let obj = this.user;
        if (['email'].indexOf(this.popChangeDialogType) > -1) {
          obj.email = params.email;
        }
        if (['phone'].indexOf(this.popChangeDialogType) > -1) {
          obj.phonenumber = params.phonenumber;
        }
        console.log('updateUserInfo obj = ', obj)
        this.$store.dispatch('updateUserInfo', { user: obj, token: this.$store.state.token, role: this.$store.state.token });
      },
			codeChange(text) {
				this.tips = text;
			},
			async getCode() {
        console.log(this.$refs.uCode.canGetCode)
				if (this.$refs.uCode.canGetCode) {
					// 模拟向后端请求验证码
					uni.showLoading({
						title: '正在获取验证码'
					})
          const res = await sendvcode({
            phonenumber: this.formModel.phone
          });
          if (res.code == 200) {
            uni.hideLoading();
            // 这里此提示会被this.start()方法中的提示覆盖
            uni.$u.toast('验证码已发送');
            // 通知验证码组件内部开始倒计时
            this.$refs.uCode.start();
          }
            // this.$refs.uCode.start();
				} else {
					uni.$u.toast('倒计时结束后再发送');
				}
			},
      onChooseAvatar(e) {
        console.log('onChooseAvatar', e)
        const { avatarUrl } = e.detail;
        // this.avatarUrl = avatarUrl;

        // 如果需要上传到服务器：
        this.uploadAvatar(avatarUrl);
      },

      // 可选：上传头像到服务器
      uploadAvatar(tempFilePath) {
        // const res = uploadURL()
        console.log({
          url: uploadURL,
          filePath: tempFilePath,
          name: 'avatar',
          formData: {
            'user_id': this.user.userId,
            'token': this.$store.state.token,
            'from': 'wx',
          }})
        uni.uploadFile({
          url: uploadURL,
          filePath: tempFilePath,
          name: 'avatar',
          formData: {
            'user_id': this.user.userId,
            'token': this.$store.state.token,
            'from': 'wx',
          },
          success: (uploadFileRes) => {
            // 处理返回的正式头像 URL
            //console.log(uploadFileRes.data); uploadFileRes.data.url
            console.log('上传成功', uploadFileRes);
            // 调用 store 中的 mutation 来更新用户信息
            const userData = Object.assign(this.user || {}, {avatar: uploadFileRes})
            this.$store.dispatch('updateUserInfo', { user: userData, token: this.$store.state.token, role: this.$store.state.role });
            console.log(userData, this.user)
          },
          fail: (err) => {
            console.error('上传失败', err);
            uni.showToast({
              title: '头像上传失败',
              icon: 'error'
            })
          }
        });
      },
      isSameNewPassword() {
        return this.formModel.newPassword === this.formModel.verifyPassword;
      },
		}

	};
</script>
<style>
  page, body {
    /* background-color: #4A63E2; */
  }
</style>
<style lang="scss" scoped>
  .container {
    background-color: #fff;
  }
  .top-wrap {
    background-color: #4A63E2;
    margin-top: 0 -26rpx;
    .top-radius {
      height: 40rpx;
      background-color: #fff;
      border-radius: 40rpx 40rpx 0 0;
    }
  }
	.my-page {
	  padding: 0 26rpx;
	  min-height: 100vh;
	  box-sizing: border-box; /* 确保 padding 包含在 100vh 内 */
	}
  
  .input-tip {
    color: #767a82;
    font-size: 26rpx;
  }
	
	.avatar-container {
    
	  display: flex;
	  justify-content: center;
	  margin: 60rpx 0;
    position: relative;
	}
	
	.avatar {
	  width: 160rpx;
	  height: 160rpx;
	  border-radius: 50%;
	  background-color: #e0f7f7;
	  overflow: hidden;
	}
  .avatar-btn {
    opacity: 0;
        position: absolute;
        width: 160rpx;
        height: 160rpx;
        border-radius: 50%;
  }
  .card-title {
    margin-top: 100rpx;
    font-size: 36rpx;
    color: #666;
  }
  .card-wrap {
    margin-top: 20rpx;
    background-color: #FAFAFA;
    padding: 40rpx 24rpx;
  }
</style>
