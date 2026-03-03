<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" :title="title" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<view class="content">
			<!-- 单张图片展示 (type 1 和 2) -->
			<view class="single-image">
				<u-image :src="promoImage" width="100%" height="auto" mode="widthFix" v-if="promoImage && type != 3"
					:showLoading="true">
					<template v-slot:loading>
						<view class="loading-placeholder">加载中...</view>
					</template>
				</u-image>
			</view>

			<!-- 多张图片展示 (type 3) -->
			<view class="detail-images" v-if="type == 3 && detailImages.length > 0">
				<view class="image-item" v-for="(img, index) in detailImages" :key="index">
					<u-image :src="img" width="100%" height="auto" mode="widthFix" :showLoading="true">
						<template v-slot:loading>
							<view class="loading-placeholder">加载中...</view>
						</template>
					</u-image>
				</view>
			</view>
			
			<!-- 底部占位符：确保内容足够长，或者作为滚动的终点参考 -->
			<view style="height: 50rpx;"></view>
		</view>

		<!-- 客服电话按钮：通过 v-if 或 opacity 控制显示 -->
		<view class="btn-group" :class="{ 'btn-visible': isBtnVisible }" v-if="isBtnVisible">
			<u-button :custom-style="primaryBtnStyle" @click="callService">联系客服</u-button>
		</view>
		
		<!-- 可选：如果希望按钮一直存在但透明，直到滚动到底部才变不透明，可以使用下面的方式代替上面的 v-if -->
		<!-- 
		<view class="btn-group" :style="{ opacity: isBtnVisible ? 1 : 0, pointerEvents: isBtnVisible ? 'auto' : 'none' }">
			<u-button ...>联系客服</u-button>
		</view> 
		-->
	</view>
</template>

<script>
	import * as api from '@/utils/api.js'
	import { mapState } from 'vuex'

	export default {
		data() {
			return {
				title: '产品宣传',
				promoImage: '',
				detailImages: [],
				type: 0,
				servicePhone: '010-85795849',
				
				// 【新增】控制按钮显示的状态
				isBtnVisible: false,
				// 【新增】页面内容总高度
				contentHeight: 0,
				// 【新增】屏幕高度
				windowHeight: 0
			}
		},
		computed: {
			containerPaddingTop() {
				const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
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
		onLoad(options) {
			// 获取屏幕高度
			const sysInfo = uni.getSystemInfoSync();
			this.windowHeight = sysInfo.windowHeight;
			
			if (options.type) {
				this.type = parseInt(options.type);
				this.init();
			}
		},
		// 【新增】监听页面滚动
		onPageScroll(e) {
			const scrollTop = e.scrollTop;
			// 判断逻辑：滚动距离 + 屏幕高度 >= 内容总高度 - 缓冲区域(例如 100px)
			// 注意：这里需要等待内容渲染完成后 contentHeight 才有值
			if (this.contentHeight > 0) {
				// 转换为 px 进行比较 (假设 rpx 基于 750 宽屏，简单起见直接用 px 逻辑)
				// 如果 contentHeight 是 px，scrollTop 也是 px
				const threshold = 100; // 提前 100px 显示，或者设为 0 严格到底
				if (scrollTop + this.windowHeight >= this.contentHeight - threshold) {
					if (!this.isBtnVisible) this.isBtnVisible = true;
				} else {
					// 如果希望滚上去后按钮消失，打开下面这行；如果希望出现后不消失，则保持 false
					// this.isBtnVisible = false; 
				}
			}
		},
		methods: {
			async init() {
				const productId = 1;
				const res = await api.getProductById(productId);
				if (res.code == 200) {
					const data = res.data || {};
					let navbarArray = [];
					try { navbarArray = JSON.parse(data.navbar); } catch (e) {}
					
					let detailsArray = [];
					try { detailsArray = JSON.parse(data.details); } catch (e) {}

					if (this.type == 1) {
						this.title = '基因检测';
						this.promoImage = navbarArray[0] && navbarArray[0].bar || '';
					} else if (this.type == 2) {
						this.title = '细胞囊泡';
						this.promoImage = navbarArray[1] && navbarArray[1].dtl || '';
					} else if (this.type == 3) {
						this.title = '胎盘冻干粉';
						this.detailImages = detailsArray;
					}
					
					// 【重要】数据加载完成后，延迟一点获取内容高度
					// 因为图片加载可能需要时间，这里先获取一个初始高度，图片加载完可能会变
					this.$nextTick(() => {
						this.updateContentHeight();
					});
				}
			},
			// 【新增】获取内容高度
			updateContentHeight() {
				const query = uni.createSelectorQuery().in(this);
				query.select('.content').boundingClientRect(data => {
					if (data) {
						this.contentHeight = data.height;
						// 获取高度后立即检查一次，防止首屏内容就很长导致按钮不显示
						this.checkScrollStatus();
					}
				}).exec();
			},
			// 【新增】手动检查一次状态（用于初始化时）
			checkScrollStatus() {
				// 获取当前滚动位置
				uni.pageScrollTo({
					duration: 0,
					success: () => {
						// 这里的逻辑稍微有点绕，因为 pageScrollTo 会触发 onPageScroll
						// 简单做法：直接假设如果内容高度小于屏幕高度，直接显示按钮
						if (this.contentHeight <= this.windowHeight) {
							this.isBtnVisible = true;
						}
					}
				});
			},
			callService() {
				uni.makePhoneCall({
					phoneNumber: this.servicePhone,
					success: () => console.log('拨打电话成功'),
					fail: (err) => console.error('拨打电话失败:', err)
				});
			},
			previewSingleImage() {
				if (!this.promoImage) return;
				uni.previewImage({ urls: [this.promoImage] });
			},
			previewImage(index) {
				if (!this.detailImages.length) return;
				uni.previewImage({ urls: this.detailImages, current: index });
			}
		}
	}
</script>

<style lang="scss" scoped>
	.container {
		background-color: #ffffff;
		padding: 0;
		min-height: 100vh;
		display: flex;
		flex-direction: column;
	}

	.content {
		flex: 1;
		width: 100%;
	}

	.btn-group {
		margin: 40rpx 26rpx 90rpx;
		display: flex;
		justify-content: center;
		flex-shrink: 0;
		
		/* 动画效果：淡入 */
		opacity: 0;
		transform: translateY(20rpx);
		transition: all 0.3s ease;
		
		&.btn-visible {
			opacity: 1;
			transform: translateY(0);
		}
	}

	.detail-images,
	.single-image {
		width: 100%;
		height: auto;
	}

	.image-item {
		line-height: 0;
		font-size: 0;
	}
	
	.loading-placeholder {
		height: 300rpx;
		display: flex;
		justify-content: center;
		align-items: center;
		color: #999;
		background-color: #f5f5f5;
	}
</style>