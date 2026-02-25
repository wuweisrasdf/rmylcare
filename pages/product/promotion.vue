<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar :fixed="true" :autoBack="true" :title="title" leftIconSize="36" leftIconColor="#2C2C2C"
			:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
		</u-navbar>

		<u-image :src="promoImage" width="100%" height="auto" mode="widthFix" v-if="promoImage" :lazy-load="true">
			<!-- 加载中提示 -->
			<template v-slot:loading>
				<u-loading-icon color="red"></u-loading-icon>
			</template>

		</u-image>


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
				type: 0,
				servicePhone: '010-85795849', // 客服电话
			}
		},
		onLoad(options) {
			if (options.type) {
				this.type = options.type;
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
					//console.log(navbarArray);

					if (this.type == 1) {
						this.title = '成人优因';
						this.promoImage = navbarArray[0] && navbarArray[0].bar  || '';
					} else if (this.type == 2) {
						this.title = '细胞囊泡'
						this.promoImage = navbarArray[1] && navbarArray[1].dtl  || '';
					} else if (this.type == 3) {
						this.title = '胎盘冻干粉'
						this.promoImage = navbarArray[2] && navbarArray[2].prod  || '';
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
			}
		}
	}
</script>

<style scoped>
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
</style>