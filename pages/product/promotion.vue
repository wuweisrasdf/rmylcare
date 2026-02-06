<template>
	<view class="container" :style="{ paddingTop: containerPaddingTop }">
		<u-navbar
		  :fixed="true"
		  :autoBack="true"
		  :title="title"
		  leftIconSize="36" leftIconColor="#2C2C2C"
		  :titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }"
		>
		</u-navbar>
		
		<u-image :src="promoImage" width="100%" height="auto" mode="widthFix"  v-if="promoImage"
			:lazy-load="true">
			<!-- 加载中提示 -->
			<template v-slot:loading>
			  <u-loading-icon color="red"></u-loading-icon>
			</template>

		</u-image>
		
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
		},
		data() {
			return {
				title: '产品宣传',
				promoImage: '',
				type: 0,
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
					
					if (this.type == 1) {
						this.title = '成人优因';
						this.promoImage = data.navbar || '';
					} else {
						this.title = '细胞囊泡'
						this.promoImage = data.details || '';
					}
				}
			}
		}
	}
</script>

<style scoped>
	.container {
		background-color: #ffffff;
		padding: 0 26rpx;
		min-height: 100vh;
	}

	.status {
		text-align: center;
		padding: 60rpx 40rpx;
		color: #888;
	}

	.error {
		color: #e74c3c;
	}
</style>