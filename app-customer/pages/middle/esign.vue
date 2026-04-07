<template>
	<view class="container">
		<view class="loading-content">
			<view class="image-content">
				<image src="/static/loading.svg" class="image" mode="widthFix"></image>
			</view>
			<view class="loading-tect-content">
				<text class="loading-text">加载中</text>
			</view>
		</view>
		<view class="btn-content">
			<text>如未成功跳转，</text>
			<text class="btn-click" @click="goFaceAuth">点击此处</text>
			<text>手动跳转</text>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			bizToken: '',
			redirectUrl: '',
			goFaceDone: false,
			hasProcessedResult: false // 【新增】防止重复处理
		}
	},
	
	onLoad(e) {
		console.log('---middle onLoad', e)
		this.bizToken = e.bizToken || ''
		this.redirectUrl = decodeURIComponent(e.redirectUrl || '')
		
		// 重置处理标志
		this.hasProcessedResult = false
		
		// 在数据设置完成后调用跳转
		this.goFaceAuth()
	},
	
	onShow() {
		console.log('---middle onShow', this.goFaceDone, this.hasProcessedResult)
		
		// 防止从实名/意愿页进入后直接返回
		if (!this.goFaceDone) return
		
		// 【关键修改】防止重复处理
		if (this.hasProcessedResult) return
		
		// #ifdef MP-WEIXIN
		this.handleFaceResult()
		// #endif
	},
	
	methods: {
		goFaceAuth() {
			const self = this
			
			if (!this.bizToken) {
				console.error('bizToken为空')
				return
			}
			
			// #ifdef MP-WEIXIN
			uni.navigateToMiniProgram({
				appId: 'wx1cf2708c2de46337',
				path: `/pages/face/index?bizToken=${this.bizToken}`,
				success: (res) => {
					self.goFaceDone = true
					console.log('跳转公证签成功', res)
				},
				fail: (err) => {
					console.error('跳转公证签失败', err)
					// 跳转失败时，可以提示用户手动重试
					uni.showToast({
						title: '跳转失败，请点击手动跳转',
						icon: 'none',
						duration: 3000
					})
				}
			})
			// #endif
		},
		
		handleFaceResult() {
			try {
				const options = this.getEnterOptions()
				console.log('---返回参数', options)
				
				// 从公证签小程序返回
				if (options && options.scene === 1038) {
					// 【关键修改】标记已处理
					this.hasProcessedResult = true
					
					// 获取返回的数据
					const extraData = options.referrerInfo?.extraData
					
					if (extraData && extraData.faceResult) {
						// 刷脸成功
						console.log('刷脸成功', extraData.faceResult)
						
						const pages = getCurrentPages()
						const prevPage = pages[pages.length - 2]
						
						if (prevPage && typeof prevPage.reloadPage === 'function') {
							const targetUrl = this.redirectUrl + `&timeStamp=${new Date().getTime()}`
							prevPage.reloadPage(targetUrl)
							
							// 【关键】使用 setTimeout 确保刷新完成后再返回
							setTimeout(() => {
								// 直接返回上一页（签署页）
								uni.navigateBack({
									delta: 1,
									success: () => {
										console.log('成功返回签署页')
									}
								})
							}, 100) // 短暂延迟确保刷新方法执行
						} else {
							console.error('上一页没有 reloadPage 方法')
							// 降级处理：直接返回
							uni.navigateBack({ delta: 1 })
						}
					} else {
						// 用户取消刷脸，直接返回
						console.log('用户取消刷脸')
						uni.navigateBack({ delta: 1 })
					}
				}
			} catch (error) {
				console.error('处理刷脸结果出错', error)
				// 出错时也返回，避免卡在中间页
				uni.navigateBack({ delta: 1 })
			}
		},
		
		getEnterOptions() {
			// #ifdef MP-WEIXIN
			try {
				// 使用 wx.getEnterOptionsSync 获取启动参数
				const options = wx.getEnterOptionsSync()
				return options
			} catch (e) {
				console.error('获取启动参数失败', e)
				return null
			}
			// #endif
			return null
		}
	}
}
</script>

<style scoped>
.container {
	width: 100%;
	height: 100vh;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	background-color: #FFFFFF;
	box-sizing: border-box;
}

.loading-content {
	text-align: center;
	width: 100%;
}

.image-content {
	display: flex;
	justify-content: center;
}

.image {
	width: 172rpx;
	height: 186rpx;
}

.loading-tect-content {
	font-size: 28rpx;
	margin-top: 48rpx;
	color: #333;
	text-align: center;
}

.btn-content {
	font-size: 28rpx;
	color: #333;
	margin-top: 24rpx;
	text-align: center;
}

.btn-click {
	color: #095fe0;
	padding: 0 10rpx;
	display: inline-block;
}
</style>