<template>
	<view class="order-detail-wrap">
    <u-sticky offset-top="0" bgColor="#f5f5f5">
      <view class="detail-top">
        协议编号：{{ contractData.orderCode }}
      </view>
    
      <view class="tab-wrap">
        <view class="tab-btn" :class="tabIndex == 0 ? 'tab-current' : ''" @click="tabClick(0)">基本信息</view>
        <view class="tab-btn" :class="tabIndex == 1 ? 'tab-current' : ''" @click="tabClick(1)">协议信息</view>
      </view>
    </u-sticky>
    <view class="list-wrap">
      <view class="card-list">
          <view class="card-list-item">
            <view class="tag" :class="proStatus(contractData.statusTxt).className || ''">
              {{proStatus(contractData.statusTxt).label || ''}}
            </view>
            <view class="user-info">
              <view class="avatar-name">
                <view class="dot"></view>
                <view class="name" v-if="tabIndex == 0">
                  {{contractData.motherName || ''}}
                </view>
                <view class="name" v-if="tabIndex == 1">
                  {{contractData.userName || ''}}
                </view>
              </view>
              <template v-if="tabIndex == 0">
                <view class="">电话号码：<text>{{contractData.motherPhonenumber}}</text></view>
                <view class="">证件类型：<text>{{idType(contractData.motherIdType)}}</text></view>
                <view class="" style="display: flex; align-item: center;">证件号：
                  <text style="padding-right: 20rpx;" v-if="showId">{{contractData.motherIdCode}}</text>
                  <text style="padding-right: 20rpx;" v-else>****************</text>
                  <!-- <u-icon :name="showId ? 'eye-fill' : 'eye-off'"
                    size="40"
                    color="#bbb"
                    @tap="showId = !showId"
                  ></u-icon> -->
                </view>
                <view class="">预产期：<text>{{contractData.dueDate}}</text></view>
                <view class="">预产医院：<text>{{contractData.hospitalName}}</text></view>
              </template>
              <template v-if="tabIndex == 1">
                <view class="">手机号：<text>{{contractData.phonenumber}}</text></view>
                <view class="">证件类型：<text>{{idType(contractData.idType)}}</text></view>
                <view class="" style="display: flex; align-item: center;">证件号：
                  <text style="padding-right: 20rpx;" v-if="showId">{{contractData.idCode}}</text>
                  <text style="padding-right: 20rpx;" v-else>****************</text>
                  <!-- <u-icon :name="showId ? 'eye-fill' : 'eye-off'"
                    size="40"
                    color="#bbb"
                    @tap="showId = !showId"
                  ></u-icon> -->
                </view>
                <view class="">电子邮件：<text>{{contractData.userEmail}}</text></view>
                <view class="">收货地址：<text>{{contractData.address}}</text></view>
                <view class="">协议金额：<text>￥{{priceFormat(contractData.priceOut, 2)}}</text></view>
              </template>
            </view>
          </view>
      </view>
    </view>
    <view class="list-wrap order-list">
      <view class="order-list-title">
        <view class="dot"></view>
        <view class="name">
          订单进度
        </view>
      </view>
      <view class="card-list order-step-wrap">
          <view class="card-list-item order-step-item">
            <!-- <view class="order-step-info-wrap step-finish">
              <image src="/static/images/order-step-yes.png" mode=""></image>
              <view class="order-step-info">
                <view class="step-line"></view>
                <view class="order-step-info-data">
                  <view class="step-name">
                    未签约
                  </view>
                  <view class="step-desc">
                    仅录入基本信息，未签字
                  </view>
                  <view class="bottom-line"></view>
                </view>
                <view class="date">
                  01-12
                </view>
              </view>
            </view>
            
            <view class="order-step-info-wrap step-current">
              <image src="/static/images/order-step-yes.png" mode=""></image>
              <view class="order-step-info">
                <view class="step-line"></view>
                <view class="order-step-info-data">
                  <view class="step-name">
                    已签约
                  </view>
                  <view class="step-desc">
                    您已成功签署协议并完成支付
                  </view>
                  <view class="bottom-line"></view>
                </view>
                <view class="date">
                  01-12
                </view>
              </view>
            </view>
            
            <view class="order-step-info-wrap">
              <image src="/static/images/order-step-not.png" mode=""></image>
              <view class="order-step-info">
                <view class="step-line"></view>
                <view class="order-step-info-data">
                  <view class="step-name">
                    已支付
                  </view>
                  <view class="step-desc">
                    您已完成支付
                  </view>
                  <view class="bottom-line"></view>
                </view>
                <view class="date">
                  01-12
                </view>
              </view>
            </view> -->
            <view class="order-step-info-wrap-for" v-for="(item, index) in progressData" :key="index">
              <template v-if="currentProgressIndex > index">
                <view class="order-step-info-wrap step-finish">
                  <image src="/static/images/order-step-yes.png" mode=""></image>
                  <view class="order-step-info">
                    <view class="step-line"></view>
                    <view class="order-step-info-data">
                      <view class="step-name">
                        {{item.OrderName}}
                      </view>
                      <view class="step-desc">
                        {{item.Desc || ''}}
                      </view>
                    </view>
                    <view class="bottom-line"></view>
                    <view class="date">
                      {{item.StatusDate || ''}}
                    </view>
                  </view>
                </view>
              </template>
              <template v-else-if="currentProgressIndex == index">
                <view class="order-step-info-wrap step-current">
                  <image src="/static/images/order-step-yes.png" mode=""></image>
                  <view class="order-step-info">
                    <view class="step-line"></view>
                    <view class="order-step-info-data">
                      <view class="step-name">
                        {{item.OrderName}}
                      </view>
                      <view class="step-desc">
                        {{item.Desc || ''}}
                      </view>
                    </view>
                    <view class="bottom-line"></view>
                    <view class="date">
                      {{item.StatusDate || '' || ''}}
                    </view>
                  </view>
                </view>
              </template>
              <template v-else>
                <view class="order-step-info-wrap">
                  <image src="/static/images/order-step-not.png" mode=""></image>
                  <view class="order-step-info">
                    <view class="step-line"></view>
                    <view class="order-step-info-data">
                      <view class="step-name">
                        {{item.OrderName}}
                      </view>
                      <view class="step-desc">
                        {{item.Desc || ''}}
                      </view>
                    </view>
                    <view class="bottom-line"></view>
                    <view class="date">
                      {{item.StatusDate || ''}}
                    </view>
                  </view>
                </view>
              </template>
            </view>
            
          </view>
          
      </view>
    </view>
    
	</view>
</template>

<script>
import { contractDetail, getInfo2 } from '@/utils/api';

export default {
    data() {
      return {
        contractId: '',
        contractData: {},
        tabIndex: 0,
        showId: false,
        currentProgressIndex: 0,
        statusColumns: [
            [
              { id: 1, label: '已签约', className: '' },
              { id: 2, label: '已付款', className: '' },
              { id: 3, label: '样本接收', className: '' },
              { id: 4, label: '病毒检测', className: '' },
              { id: 5, label: '制备完成', className: '' },
              { id: 6, label: '配送', className: '' },
              { id: 7, label: '已完成', className: '' },
              { id: 8, label: '申请解除', className: 'yijieyue' },
              { id: 9, label: '协议解除', className: 'yijieyue' },
              { id: 10, label: '已退款', className: 'yijieyue', }
            ]
        ], // 1-已签约、2-已付款、3-样本接收、4-病毒检测、5-制备完成、6-配送、7-已完成、8-申请解除、9-协议解除、10-已退款。
        progressData: [
          {
            OrderName: '未签约',
            Desc: '仅录入基本信息，未签字',
          },
          {
            OrderName: '已签约',
            Desc: '签约已完成',
          },
          {
            OrderName: '已付款',
            Desc: '支付已完成',
          },
          {
            OrderName: '样本接收',
            Desc: '样本已送达处理中心',
          },
          {
            OrderName: '病毒检测',
            Desc: '病毒检测已完成',
          },
          {
            OrderName: '制备完成',
            Desc: '产品已制备完成',
          },
          {
            OrderName: '配送',
            Desc: '产品已发出，请关注物流',
          },
          {
            OrderName: '已完成',
            Desc: '产品已签收',
          },
        ], // 1-已签约、2-已付款、3-样本接收、4-病毒检测、5-制备完成、6-配送、7-已完成、8-申请解除、9-协议解除、10-已退款
        progressDataJiechu: [
          {
            OrderName: '申请解除',
            Desc: '',
          },
          {
            OrderName: '协议解除',
            Desc: '',
          },
          {
            OrderName: '已退款',
            Desc: '',
          },
        ],
      }
    },
    onLoad(options) {
      console.log(options)
      this.contractId = options.id;
    },
    onShow() {
      this.getDetail();
      // this.getTheInfo();
    },
    methods: {
      priceFormat(price) {
        return uni.$u.priceFormat(price, 2);
      },
      proStatus(statusTxt) {
        let result = {};
        this.statusColumns[0].forEach(item => {
          if (item.label == statusTxt) {
            result = item;
          }
        });
        console.log('proStatus', statusTxt, result)
        return result;
      },
      idType(type) {
        // 1-身份证、2-护照、3-永久居留身份证、4-台湾来往大陆通行证、5-香港来往大陆通行证、6-澳门来往大陆通行证、10-其它
        let result = '其它';
        if (type == 1) {
          result = '身份证';
        }
        if (type == 2) {
          result = '护照';
        }
        if (type == 3) {
          result = '永久居留身份证';
        }
        if (type == 4) {
          result = '台湾来往大陆通行证';
        }
        if (type == 5) {
          result = '香港来往大陆通行证';
        }
        if (type == 6) {
          result = '澳门来往大陆通行证';
        }
        return result;
      },
      tabClick(index) {
        this.tabIndex = index;
        // this.contractData = {};
        // this.getDetail();
      },
      async getTheInfo() {
        const res = await getInfo2({
          id: this.contractId,
        });
        if (res.code == 200) {
        }
      },
      async getDetail() {
        const res = await contractDetail({
          id: this.contractId,
        });
        if (res.code == 200) {
          this.contractData = res.rows[0];
          if (this.contractData.orderProgress) {
            
            const exists = this.progressData.some(item => item.OrderName == this.contractData.statusTxt);
            
            console.log(exists); // true 存在， false 不存在）
            this.progressData = exists ? this.mergeStatuses(this.progressData, this.contractData.orderProgress) : this.mergeStatusesJiechu(this.contractData.orderProgress, this.progressDataJiechu, this.progressData);
          }
          this.setProgress();
          
        }
      },
      mergeStatuses(a, b) {
        // 将 b 转为 Map，key 是 OrderName
        const bMap = new Map(b.map(item => [item.OrderName, item]));
      
        // 遍历 a，对每个项：
        // - 如果 b 中有同名 OrderName，则合并字段
        // - 否则保留原样
        return a.map(aItem => {
          const bItem = bMap.get(aItem.OrderName);
          if (bItem) {
            // 合并：保留 aItem 所有字段，用 bItem 的字段覆盖或补充
            return { ...aItem, ...bItem };
          }
          return aItem;
        });
      },
      mergeStatusesJiechu(orderProgress, progressDataJiechu, progressData) {
        const jiechuMap = new Map(progressDataJiechu.map(i => [i.OrderName, i.Desc]));
        const mainDescMap = new Map(progressData.map(i => [i.OrderName, i.Desc]));
        const orderNames = new Set(orderProgress.map(i => i.OrderName));
      
        const result = orderProgress.map(item => {
          let desc = '';
          if (item.Desc != null && item.Desc.trim() !== '') {
            desc = item.Desc;
          } else if (jiechuMap.has(item.OrderName)) {
            desc = jiechuMap.get(item.OrderName) || '';
          } else if (mainDescMap.has(item.OrderName)) {
            desc = mainDescMap.get(item.OrderName);
          }
          return { ...item, Desc: desc };
        });
      
        progressDataJiechu.forEach(item => {
          if (!orderNames.has(item.OrderName)) {
            result.push({ ...item, Desc: item.Desc || '' });
          }
        });
      
        return result;
      },
      setProgress() {
        console.log('setProgress', this.progressData)
        this.progressData.forEach((item, index) => {
          if (this.contractData.statusTxt == item.OrderName) {
            this.currentProgressIndex = index;
            if (this.currentProgressIndex < index) {
              item.isFinishStep;
            }
            if (this.currentProgressIndex > index) {
              item.isCurrentStep;
            }
          }
        });
      },
      currentStepStatus(index) {
        let result = '';
        if (this.currentProgressIndex < index) {
          result = 'step-finish';
        }
        if (this.currentProgressIndex == index) {
          result = 'step-current';
        }
        return result;
      },
    },
  }
</script>

<style lang="scss" scoped>
  .order-detail-wrap {
      min-height: 100vh; /* 关键：撑满整个视口 */
      background-color: #f5f5f5; /* 这才是你看到的背景 */
      box-sizing: border-box;
      padding-top: 20rpx;
      margin-top: -20rpx;
      .detail-top {
        font-weight: bold;
        font-size: 32rpx;
        color: #2C2C2C;
        padding: 0 26rpx;
        padding-top: 78rpx;
        background: #f5f5f5;
      }
  }
    .tab-wrap {
      display: flex;
      align-items: center;
      gap: 26rpx;
      margin-top: 34rpx;
      padding: 0 26rpx;
      padding-bottom: 24rpx;
      background-color: #f5f5f5;
    }
    .tab-btn {
      font-weight: bold;
      font-size: 26rpx;
      padding: 0 40rpx;
      height: 58rpx;
      line-height: 58rpx;
      border-radius: 50rpx;
      background: #fff;
      color: #AEAEAE;
      border: 2px solid transparent;
    }
    .tab-current {
      background: #EDEFF7;
      color: #4A63E4;
      border: 2px solid #A4AFDE;
    }
  .list-wrap {
    .card-list {
      margin-top: -24rpx;
    }
    .card-list-item {
      position: relative;
      padding: 34rpx 46rpx;
      color: #666;
      font-size: 28rpx;
      background-color: #fff;
      box-shadow: 0rpx 10rpx 26rpx 0rpx rgba(0,88,133,0.08);
      border-radius: 40rpx;
      margin: 32rpx 24rpx 0 24rpx;
      .tag {
        position: absolute;
        right: -1px;
        top: -1px;
        width: 162rpx;
        height: 62rpx;
        background: url('/static/images/yiqianyue.png') no-repeat;
        background-size: contain;
        text-align: center;
        padding-top: 8rpx;
        font-weight: bold;
        font-size: 24rpx;
        color: #2449FF;
        &.weiqianyue {
          background: url('/static/images/weiqianyue.png') no-repeat;
          background-size: contain;
          color: #00C2D6;
        }
        &.yijieyue {
          background: url('/static/images/yijieyue.png') no-repeat;
          background-size: contain;
          color: #FFAA12;
        }
      }
      .user-info {
        display: flex;
        flex-direction: column;
        gap: 36rpx;
        font-weight: bold;
        font-size: 26rpx;
        color: #969696;
        .avatar-name {
          display: flex;
          align-items: center;
          gap: 18rpx;
          padding-bottom: 12rpx;
          .dot{
            width: 6rpx;
            height: 28rpx;
            background: #4A63E4;
            border-radius: 3rpx;
          }
          .name {
            font-weight: bold;
            font-size: 28rpx;
            color: #2c2c2c;
          }
        }
      }
    }
    
    .order-list-title {
      margin-top: 78rpx;
      display: flex;
      align-items: center;
      gap: 18rpx;
      padding-left: 26rpx;
      padding-right: 26rpx;
      padding-bottom: 12rpx;
      .dot{
        width: 6rpx;
        height: 28rpx;
        background: #4A63E4;
        border-radius: 3rpx;
      }
      .name {
        font-weight: bold;
        font-size: 28rpx;
        color: #2c2c2c;
      }
    }
  }
  .order-step-wrap {
    .order-step-item {
      position: relative;
      padding: 62rpx 56rpx;
      image {
        width: 52rpx;
        height: 52rpx;
        border-radius: 100%;
        position: absolute;
        z-index: 3;
        left: 56rpx;
      }
    }
    .order-step-info-wrap-for {
      &:last-child {
        .step-line {
          display: none;
        }
      }
    }
    .order-step-info {
      padding-left: 56rpx;
      display: flex;
      // align-items: center;
      justify-content: space-between;
      position: relative;
      padding-bottom: 76rpx;
      .date {
        font-weight: bold;
        font-size: 22rpx;
        color: #656565;
        position: absolute;
        right: 0;
      }
      .step-line {
        position: absolute;
        width: 14rpx;
        background-color: #E8E8E8;
        height: calc(100% - 46rpx);
        left: 21rpx;
        top: 50rpx;
      }
      .order-step-info-data {
        font-weight: bold;
        font-size: 28rpx;
        color: #B6B6B6;
        margin-left: 56rpx;
        margin-top: -8rpx;
        position: relative;
        .step-name {
          font-size: 32rpx;
          color: #505050;
          padding-bottom: 20rpx;
        }
      }
      .bottom-line {
        position: absolute;
        background: linear-gradient(90deg, transparent, rgba(74, 99, 228, 0.5) 50%, transparent 100%);
        height: 2rpx;
        left: 40rpx;
        right: -40rpx;
        bottom: 40rpx;
        display: none;
      }
    }
    .step-finish {
      .step-name {
        color: #4A63E4 !important;
      }
      .step-line {
        background-color: #4A63E4;
      }
    }
    .step-current {
      .step-name {
        color: #4A63E4 !important;
      }
      .step-line {
        background-color:  #4A63E4;
        background: linear-gradient(180deg,rgba(74, 99, 228, 1) 0%, rgba(74, 99, 228, 1) 0%, rgba(232, 232, 232, 1) 45%, rgba(232, 232, 232, 1) 100%);
      }
      .step-desc {
        color: #98A1CF;
      }
      .bottom-line {
        display: block !important;
      }
    }
  }
</style>