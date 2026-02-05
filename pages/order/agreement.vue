<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" title="电子协议" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<view class="content-container">
			<view class="info" @click="viewPdf">
				<view class="item">
					<text class="title">人民医疗胎盘冻干粉储存服务协议</text>
					<text class="sign-btn">签约协议</text>
				</view>
				<view class="item">
					<text class="label">协议版本</text>
					<text class="value">V1.0 </text>
				</view>
				<view class="bottom-line"></view>

				<view class="item">
					<text class="label">发布日期</text>
					<text class="value">2026-02-13</text>
				</view>
			</view>
			
			<view class="info">
				<view class="item">
					<text class="title">人民医疗胎盘冻干粉储存服务协议</text>
					<text class="refund-btn">解约协议</text>
				</view>
				<view class="item">
					<text class="label">协议版本</text>
					<text class="value">V1.0 </text>
				</view>
				<view class="bottom-line"></view>
			
				<view class="item">
					<text class="label">发布日期</text>
					<text class="value">2026-02-13</text>
				</view>
			</view>
			
<!-- 			<view class="pdf-container">
				<web-view :src="pdfUrl" />
			</view> -->
			
		</view>

			<view class="btn-group">
				<u-button :custom-style="primaryBtnStyle" @click="goHome">
					返回首页
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
			}
		},
		onLoad(options) { //options.orderId = 17;
			if (options.orderId) {
				this.orderId = options.orderId;
				//this.init();
			}
			
			// todo 测试
			//this.previewPdf();
		},
		data() {
			return {
				orderId: '', // 订单id
				//pdfUrl: 'https://esignoss.esign.cn/7439098939/ec005696-779a-4c8a-8a40-e001bdaf54eb/%E7%94%B5%E5%AD%90%E5%90%88%E5%90%8C.pdf?Expires=1770265515&OSSAccessKeyId=LTAI4G23YViiKnxTC28ygQzF&Signature=9mvxpitB83xJ5wD44wqw3tAEa8g%3D',
				pdfUrl: '',
			};
		},
		methods: {
			async init() {

			},
			async viewPdf(){
				let orderId = this.orderId;
				orderId = 17; // TODO 模拟 orderId
				const res = await api.downloadSignedFile(orderId);
				if (res.code == 200) {
					this.pdfUrl = res.downloadUrl;
					this.previewPdf();
				}
			},
			async previewPdf() {
			      try {
			        // 1. 下载文件到本地临时路径
			        const res = await uni.downloadFile({
			          url: this.pdfUrl
			        });
			
			        if (res.statusCode === 200) {
			          // 2. 打开文档（小程序会自动调用内置 PDF 阅读器）
			          uni.openDocument({
			            filePath: res.tempFilePath,
			            fileType: 'pdf',
			            success: () => {
			              console.log('PDF 打开成功');
			            },
			            fail: (err) => {
			              console.error('打开 PDF 失败', err);
			              uni.showToast({ title: '无法打开协议', icon: 'none' });
			            }
			          });
			        } else {
			          uni.showToast({ title: '协议加载失败', icon: 'none' });
			        }
			      } catch (err) {
			        console.error('下载 PDF 出错', err);
			        uni.showToast({ title: '网络错误', icon: 'none' });
			      }
			    },
			goPrev() {
				uni.navigateBack();
			},
			goHome() {
				uni.redirectTo({
					url: "/pages/index/index"
				})
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
		display: flex;
		flex-direction: column;

		.info {
			background: #F6F7FC;
			border-radius: 40rpx;
			box-sizing: border-box;
			margin-bottom: 50rpx;

			.item {
				display: flex;
				justify-content: space-between;
				align-items: center;
				padding: 30rpx;
				
				.title{
					font-weight: 800;
					font-size: 32rpx;
					color: #151515;
				}

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

	.sign-btn {
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
	
	.refund-btn {
		background-color: red;
		border-radius: 25rpx;
		font-weight: 500;
		font-size: 26rpx;
		color: #FFFFFF;
		width: 162rpx;
		height: 54rpx;
		text-align: center;
		line-height: 54rpx;
	}

	.btn-group {
		display: flex;
		flex-direction: column;
		gap: 22rpx;
		width: 100%;
		margin: 50rpx auto 120rpx;
	}
	
	.pdf-container {
	  flex: 1;
	  margin-top: 50rpx;
	  width: 100%;
	  height: 0; /* 防止 web-view 塌陷 */
	  background-color: #f9f9f9;
	
	//   ::v-deep(web-view) {
	//     width: 100%;
	//     height: 100%;
	//   }
	}
</style>