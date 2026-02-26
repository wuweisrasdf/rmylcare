<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" :title="title" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<!-- 单张图片展示 (type 1 和 2) -->
		<view class="single-image">
			<u-image :src="promoImage" width="100%" height="auto" mode="widthFix" v-if="promoImage && type != 3"
				:lazy-load="true">
				<template v-slot:loading>
					<u-loading-icon color="red"></u-loading-icon>
				</template>
			</u-image>
		</view>

		<!-- 多张图片展示 (type 3) -->
		<view class="detail-images" v-if="type == 3 && detailImages.length > 0">
			<view class="image-item" v-for="(img, index) in detailImages" :key="index">
				<u-image :src="img" width="100%" height="auto" mode="widthFix" :lazy-load="true">
					<template v-slot:loading>
						<u-loading-icon color="red"></u-loading-icon>
					</template>
				</u-image>
			</view>
		</view>

		<!-- 客服电话按钮 -->
		<view class="btn-group">
			<u-button :custom-style="primaryBtnStyle" @click="callService">联系客服</u-button>
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
			// 计算容器顶部内边距（转为 rpx）
			containerPaddingTop() {
				// CustomBar 是 px，uni-app 中 1px = 2rpx
				const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
				console.log(barHeight)
				return barHeight;
			},
			primaryBtnStyle() {
				return {
					height: '98rpx',
					borderRadius: '49rpx',
					backgroundColor: '#4A63E4',
					color: '#FFFFFF',
					fontWeight: 'bold',
					fontSize: '32rpx',
					display: 'flex',
					justifyContent: 'center',
					alignItems: 'center',
					border: 'none',
					padding: '0 20rpx',
				};
			}
		},
		data() {
			return {
				title: '产品宣传',
				promoImage: '',
				detailImages: [], // 存储多张图片
				type: 0,
				servicePhone: '010-85795849', // 客服电话
			}
		},
		onLoad(options) {
			if (options.type) {
				this.type = parseInt(options.type); // 确保是数字类型
				this.init();
			}
		},
		methods: {
			async init() {
				// 获取产品信息
				const productId = 1; // 固定值 1
				const res = await api.getProductById(productId);
				if (res.code == 200) {
					const data = res.data || {};

					let navbarArray;
					try {
						navbarArray = JSON.parse(data.navbar);
					} catch (e) {
						console.error('navbar 字段不是合法的 JSON 字符串', e);
						navbarArray = []; // 容错处理
					}

					// 处理 details 字段
					let detailsArray = [];
					try {
						detailsArray = JSON.parse(data.details);
					} catch (e) {
						console.error('details 字段不是合法的 JSON 字符串', e);
						detailsArray = [];
					}

					console.log('detailsArray:', detailsArray);

					if (this.type == 1) {
						//this.title = '成人优因';
						this.title = '基因检测';
						this.promoImage = navbarArray[0] && navbarArray[0].bar || '';
					} else if (this.type == 2) {
						this.title = '细胞囊泡';
						this.promoImage = navbarArray[1] && navbarArray[1].dtl || '';
					} else if (this.type == 3) {
						this.title = '胎盘冻干粉';
						// type 3 使用 details 数组中的所有图片
						this.detailImages = detailsArray;
					}
				}
			},
			callService() {
				uni.makePhoneCall({
					phoneNumber: this.servicePhone, // 客服电话
					success: () => {
						console.log('拨打电话成功');
					},
					fail: (err) => {
						console.error('拨打电话失败:', err);
					}
				});
			},
			// 预览单张图片
			previewSingleImage() {
				if (!this.promoImage) return;
				this.previewImageWithOptions([this.promoImage], 0);
			},
			// 预览多张图片中的某一张
			previewImage(index) {
				if (!this.detailImages.length) return;
				this.previewImageWithOptions(this.detailImages, index);
			},
			// 通用的图片预览方法
			previewImageWithOptions(urls, currentIndex) {
				uni.previewImage({
					urls: urls,
					current: urls[currentIndex],
					longPressActions: {
						itemList: ['发送给朋友', '保存图片', '收藏'],
						success: (data) => {
							console.log('用户选择了：' + data.index);
						},
						fail: (err) => {
							console.log(err.errMsg);
						}
					}
				});
			}
		}
	}
</script>

<style lang="scss" scoped>
	.container {
		background-color: #ffffff;
		padding: 0 26rpx;
		min-height: 100vh;
		padding-bottom: 100rpx;
	}

	.status {
		text-align: center;
		padding: 60rpx 40rpx;
		color: #888;
	}

	.error {
		color: #e74c3c;
	}

	.btn-group {
		margin-top: 50rpx;
		display: flex;
		justify-content: center;
	}

	.single-image {
		margin-left: -26rpx;
		margin-right: -26rpx;
		width: calc(100% + 52rpx); // 补偿左右内边距
	}

	/* 多张图片展示样式 */
	.detail-images {
		margin-left: -26rpx;
		margin-right: -26rpx;
		width: calc(100% + 52rpx); // 补偿左右内边距
	}



	.image-item {
		// 移除所有间距
		line-height: 0; // 防止图片间出现空白
		font-size: 0; // 防止图片间出现空白

		// 移除边框圆角和阴影
		// border-radius: 16rpx;
		// overflow: hidden;
		// box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.05);
	}

	.image-item:last-child {
		margin-bottom: 0;
	}
</style>