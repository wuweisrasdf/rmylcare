<template>
	<view class="container">

		
		<TabBar :current-tab="currentTab"/>
	</view>
</template>

<script>
	import TabBar from '@/components/TabBar/TabBar.vue';
	
	export default {
		components: {
		  TabBar
		},
		data() {
			return {
				currentTab: 0
			}
		},
		onLoad() {

		},
		methods: {
			onShareAppMessage() {
				  return {
					title: '科数健管 - 冻干粉服务',
					path: '/pages/product/detail?productId=123',
					imageUrl: '/static/share.jpg' // 可选：分享封面图
				  }
				}
		}
	}
</script>

<style>
	.content {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
	}

	.logo {
		height: 200rpx;
		width: 200rpx;
		margin-top: 200rpx;
		margin-left: auto;
		margin-right: auto;
		margin-bottom: 50rpx;
	}

	.text-area {
		display: flex;
		justify-content: center;
	}

	.title {
		font-size: 36rpx;
		color: #8f8f94;
	}
</style>
