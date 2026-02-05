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
				imageUrl1: 'https://nimg.ws.126.net/?url=http%3A%2F%2Fpic-bucket.ws.126.net%2Fphoto%2F0001%2F2025-03-11%2FJQCKPMN900AN0001NOS.jpg&thumbnail=750x2147483647&quality=75&type=webp',
				imageUrl2: 'https://nimg.ws.126.net/?url=http%3A%2F%2Fpic-bucket.ws.126.net%2Fphoto%2F0001%2F2025-03-08%2FJQ4IS4MV00AN0001NOS.jpg&thumbnail=750x2147483647&quality=75&type=webp',
			}
		},
		onLoad(options) {
			if (options.type) {
				if (options.type == 1) {
					this.title = '成人优因'
					this.promoImage = this.imageUrl1
				} else {
					this.title = '细胞囊泡'
					this.promoImage = this.imageUrl2
				}

			}
		},
		methods: {

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