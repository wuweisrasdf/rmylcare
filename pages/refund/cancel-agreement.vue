<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" title="解除协议签署" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<view class="content">
			<view class="content-head">
				<view class="content-head-icon"></view>
				<text class="content-head-title">请仔细阅读协议内容，确认无误后进行签署</text>
			</view>
			<scroll-view class="content-container" scroll-y="true">
				<view class="auth-content">
					<text class="title">人民医疗胎盘冻干粉储存服务解除协议</text>
					<text class="paragraph">
						欢迎您使用本平台提供的孕产服务。请您仔细阅读以下条款，特别是免除或者限制责任的条款、法律适用和争议解决条款。
						当您勾选“已阅读并同意”时，即表示您已充分理解并接受本协议全部内容。
					</text>
					<text class="paragraph">
						一、服务内容
						本平台为您提供孕期信息管理、医院预约、合同签署等服务。您需如实提供个人信息，并确保其真实、准确、完整。
					</text>
					<text class="paragraph">
						二、信息使用
						您授权我方在服务过程中收集、存储、使用您的姓名、身份证号、联系方式、预产期等信息，仅用于本服务目的。
					</text>
					<text class="paragraph">
						三、隐私保护
						我们将严格遵守《个人信息保护法》，采取合理措施保护您的信息安全，未经您同意不得向第三方披露。
					</text>
					<text class="paragraph">
						四、免责声明
						如因不可抗力或您提供信息错误导致服务中断或损失，我方不承担责任。
					</text>
					<text class="paragraph">
						五、协议修改
						我们有权根据业务调整更新本协议，更新后将通过平台公告方式通知，请您定期查阅。
					</text>
					<text class="paragraph">
						六、法律适用
						本协议适用中华人民共和国法律。如发生争议，双方应友好协商；协商不成的，提交平台所在地法院诉讼解决。
					</text>
					<text class="paragraph">
						七、生效条件
						本协议自您点击“已阅读并同意”之日起生效。
					</text>
					<text class="paragraph">
						请您务必认真阅读以上内容。继续操作即视为您已完全理解并同意本授权书所有条款。
					</text>
					<!-- 再加一段撑高度 -->
					<text class="paragraph" v-for="i in 5" :key="i">
						这是额外的占位段落 {{ i }}，用于确保内容超出屏幕高度，触发滚动效果。
						请滑动页面以完整阅读授权书内容。系统将强制要求您阅读满 10 秒钟。
					</text>
				</view>
			</scroll-view>

		</view>


		<view class="btn-group">
			<u-button :custom-style="primaryBtnStyle" @click="toSign">
				去签字
			</u-button>
			<u-button :custom-style="secondaryBtnStyle" @click="goPrev">
				取消
			</u-button>
		</view>

		<view class="desc">
			<text class="text">提交后，您的解除协议将生效，退款将在7个工作日内处理。</text>
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
			primaryBtnStyle() {
				return {
					height: '98rpx',
					borderRadius: '49rpx',
					backgroundImage: 'url(/static/images/sign-btn.png)',
					backgroundSize: 'auto',
					backgroundRepeat: 'no-repeat',
					backgroundPosition: 'center',
					color: '#FFFFFF',
					fontWeight: 'bold',
					fontSize: '32rpx',
					display: 'flex',
					justifyContent: 'center',
					alignItems: 'center',
					border: 'none',
					padding: '0 20rpx',
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
			}
		},
		onLoad(options) {
			if (options.orderId) {
				this.orderId = options.orderId;
				this.init();
			}
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
				orderId: '', // 订单id
				isSigning: false, // 标记是否刚从签署页返回
			};
		},
		methods: {
			async init() {},
			goPrev() {
				uni.navigateBack();
			},
			goHome() {
				uni.redirectTo({
					url: "/pages/index/index"
				})
			},
			// 去签字
			toSign(){
				this.checkIfSigned(); // TODO 测试流程
				//this.isSigning = true;
				
				//TODO 走签字流程
			},
			// 从e签宝回退后，检查是否签字成功
			async checkIfSigned() {
				//TODO 测试
				
				uni.redirectTo({
					url: `/pages/refund/progress?orderId=${this.orderId}`
				});
				
				return;
				
				
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
		flex-grow: 1;
		padding-top: 76rpx;

		.info {
			background: #F6F7FC;
			border-radius: 40rpx;
			padding: 40rpx;
			box-sizing: border-box;

			.item {
				display: flex;
				justify-content: space-between;
				align-items: center;
				padding: 30rpx 0;

				.label {
					font-weight: 500;
					font-size: 28rpx;
					color: #727272;
				}

				.value {
					font-weight: 500;
					font-size: 28rpx;
					color: #000000;
					flex: 1;
					text-align: right;
				}

				.price {
					font-weight: 800;
					font-size: 48rpx;
					color: #4A63E2;
					line-height: 1.2;
				}
			}

			.item:first-child {
				padding-top: 0;
				padding-bottom: 0;
			}

			.item:last-child {
				padding-bottom: 0;
			}

			.bottom-line {
				width: 100%;
				height: 2rpx;
				background: #161421;
				opacity: 0.1;
			}

		}
	}

	.content {
		padding: 50rpx 0;
		flex: 1;
		display: flex;
		flex-direction: column;
	}

	.content-head {
		display: flex;
		flex-direction: row;
		align-items: center;

		.content-head-icon {
			width: 6rpx;
			height: 28rpx;
			background: #4A63E4;
			border-radius: 3rpx;
			margin-right: 24rpx;
		}

		.content-head-title {
			font-weight: bold;
			font-size: 32rpx;
			color: #2C2C2C;
		}
	}

	.content-main {
		padding: 40rpx;
		margin-top: 50rpx;
		background: #F7F7F7;
		border-radius: 40rpx;
		flex: 1;
	}

	.refund-btn {
		background-image: url('/static/images/refund-btn.png');
		background-size: 100% 100%;
		font-weight: 500;
		font-size: 26rpx;
		color: #FFFFFF;
		width: 162rpx;
		height: 54rpx;
		text-align: center;
		line-height: 54rpx;
	}



	.desc {
		margin: 70rpx auto;
		text-align: center;

		.text {
			font-weight: 500;
			font-size: 24rpx;
			color: #2449FF;
		}
	}

	.btn-group {
		display: flex;
		flex-direction: column;
		gap: 22rpx;
	}
	
	
	.content-container {
	    flex: 1;
	    background-color: #f9fbff;
	    border-radius: 20rpx;
	    margin-top: 74rpx;
	    padding: 40rpx 30rpx;
	    box-sizing: border-box;
	}
	
	.auth-content {
	    .title {
	        font-size: 36rpx;
	        font-weight: bold;
	        color: #000000;
	        display: block;
	        margin-bottom: 30rpx;
			text-align: center;
	    }
	    .paragraph {
	        font-size: 28rpx;
	        color: #333333;
	        line-height: 1.6;
	        display: block;
	        margin-bottom: 24rpx;
	        text-align: justify;
	    }
	}
</style>