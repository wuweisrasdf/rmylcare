<template>
  <view class="hospital-select-page" :style="{ paddingTop: containerPaddingTop }">

	<u-navbar :fixed="true" :autoBack="true" title="选择预产医院" leftIconSize="36" leftIconColor="#2C2C2C"
		:titleStyle="{ fontWeight: 'bold', fontSize: '36rpx', color: '#2C2C2C' }">
	</u-navbar>

    <!-- 搜索框 -->
    <view class="search-container">
      <u-search
		searchIconSize="44"
        v-model="keyword"
        placeholder="请输入医院名称"
        shape="round"
        clearable
        :show-action="false"
        height="72"
        @input="onSearchInput"
      />
    </view>

    <!-- 加载中 -->
    <view v-if="loading" class="loading">
     <u-loading-icon mode="circle" size="36"></u-loading-icon>
    </view>

    <!-- 医院列表 -->
    <scroll-view
      v-else
      scroll-y
      class="hospital-list"
      :style="{ height: listHeight + 'px' }"
    >
      <view
        v-for="(hospital, index) in filteredList"
        :key="index"
        class="hospital-item"
        @click="selectHospital(hospital)"
      >
        {{ hospital }}
      </view>

      <!-- 空状态 -->
      <u-empty
		textSize="28" iconSize="90"
        v-if="filteredList.length === 0"
        text="未找到相关医院"
        mode="data"
        margin-top="200"
      />
    </scroll-view>
  </view>
</template>

<script>

import  { getHospitalList }  from '@/utils/api.js'

export default {
  data() {
    return {
      loading: true,
      allHospitals: [],
      keyword: '',
      listHeight: 500 // 默认高度，onReady 中动态计算
    };
  },

  computed: {
	// 计算容器顶部内边距（转为 rpx）
	containerPaddingTop() {
		// CustomBar 是 px，uni-app 中 1px = 2rpx
		const barHeight = (this.CustomBar || 0) * 2 + 'rpx';
		console.log(barHeight)
		return barHeight;
	},
    filteredList() {
      if (!this.keyword.trim()) {
        return this.allHospitals;
      }
      const k = this.keyword.toLowerCase();
      return this.allHospitals.filter(hospital =>
        hospital.toLowerCase().includes(k)
      );
    }
  },

  async onLoad() {
    await this.loadHospitals();
  },

  onReady() {
    // 动态计算列表高度（避开 navbar + search）
    const systemInfo = uni.getSystemInfoSync();
    this.listHeight = systemInfo.windowHeight - 140; // navbar(44px) + search(72px) + padding
  },

  methods: {
    async loadHospitals() {
      this.loading = true;
      try {
        const res = await getHospitalList();
        if (res.code === 200 && Array.isArray(res.hospitalList)) {
          this.allHospitals = res.hospitalList
		  
		  //TODO 因为接口返回是空，提供以下测试数据
		  // if (this.allHospitals.length == 0) {
			 //  this.allHospitals = ["北京明德医院",
			 //      "北京大学首钢医院",
			 //      "北京和睦家中西医结合医院",
			 //      "北京市海淀区妇幼保健院",
			 //      "首都医科大学附属北京佑安医院",
			 //      "北京市海淀医院（北京大学第三医院海淀院区）",
			 //      "北京市垂杨柳医院",
			 //      "四季青医院",
			 //      "北京积水潭医院（新龙泽院区）",
			 //      "北京嘉禾妇儿医院",
			 //      "北京通用航天医院",
			 //  "北京万柳美中宜和妇儿医院"];
		  // }

        } else {
          uni.showToast({ title: '医院列表为空', icon: 'none' });
        }
      } catch (err) {
        console.error('加载医院失败:', err);
        uni.showToast({ title: '加载失败，请重试', icon: 'none' });
      } finally {
        this.loading = false;
      }
    },

    onSearchInput() {
      // 实时搜索已在 computed 中处理，此处可留空
    },

    selectHospital(hospital) {
      uni.$emit('selectHospital', hospital);

      uni.navigateBack();
    }
  }
};
</script>

<style scoped>
.hospital-select-page {
  background-color: #f8f8f8;
  height: 100vh;
}

.search-container {
  padding: 20rpx 30rpx;
}

.hospital-list {
  padding: 0 30rpx 30rpx;
  width: 100%;
  box-sizing: border-box;
}

.hospital-item {
  background: #ffffff;
  border-radius: 16rpx;
  padding: 28rpx 32rpx;
  margin-top: 24rpx;
  font-size: 32rpx;
  color: #333333;
  box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.05);
}

.hospital-item:active {
  background-color: #f0f9ff;
}

.loading {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 60vh;
}
</style>