<template>
	<view class="">	
		<u-loading-page 
			loading-mode="spinner" 
			loading-text="loading..." 
			font-size="36"
			icon-size="80"
			:loading="loading">
		</u-loading-page>
	</view>
</template>

<script>
	import { mapGetters } from 'vuex';

export default {
    computed: {
        ...mapGetters(['isLogined'])
	},
    data(){
        return {
            loading: true
        }
    },
    methods:{

    },
	onLoad() {
		// 是否登录
		if (this.isLogined) {
		  uni.reLaunch({
			url: '/pages/index/index' // 已登录 → 跳转首页
		  });
		  return;
		} else {
			// 未登录 → 跳转登录页
			uni.reLaunch({ url: '/pages/login/login' });
		  }
	}
}
</script>

<style scoped>

</style>