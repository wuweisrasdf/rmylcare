<template>
  <view class="container">
    <u-sticky offset-top="0" bgColor="">
    <view class="fliter-wrap">
      <u--input
        border="none"
        shape="circle"
        prefixIcon="search"
        prefixIconStyle="font-size: 44rpx;color: #909399"
        placeholder="请输入姓名或电话"
        customStyle="height: 72rpx; background: #F5F5F5; border-radius: 36rpx; padding: 0 44rpx;"
        :clearable="true"
        v-model="keyword"
      ></u--input>
      <view class="date-wrap">
        <view class="label">
          预产期
        </view>
        <view class="date-range">
          <view class="date" @click="date1Show = true">
            <text v-if="date1Value">{{date1Value}}</text>
            <text v-else style="color: #838383">未选择</text>
          </view>
          至
          <view class="date" @click="date2Show = true">
            <text v-if="date2Value">{{date2Value}}</text>
            <text v-else style="color: #838383">未选择</text>
          </view>
        </view>
        <u-icon name="trash" color="#999" size="36" @click="resetDate"></u-icon>
        <u-button text="筛选" shape="circle" size="small" color="#2449FF; font-size: 26rpx; font-weight: bold; border-radius: 28rpx; width: auto;" @click="filterSubmit"></u-button>
      </view>
    </view>
    
    <!-- <view class="list-wrap">
      <view class="tab-wrap">
        <view class="tab-btn" :class="tabIndex == 0 ? 'tab-current' : ''" @click="tabClick(0)">签约前</view>
        <view class="tab-btn" :class="tabIndex == 1 ? 'tab-current' : ''" @click="tabClick(1)">签约后</view>
      </view>
    </view> -->
    </u-sticky>
    
    <view class="card-wrap" :style="cardList.length ? '' : 'background: none;'">
      <view class="card-list" v-if="cardList.length">
      <u-list @scrolltolower="scrolltolower" :scroll-top="cardListScrollTop" ref="uListRef">
        <u-list-item v-for="(item, index) in cardList" :key="index">
          <view class="card-list-item" :style="index == 0 ? 'margin-top: 6rpx' : ''" @click="goDetail(item)">
            <view class="tag weiqianyue">
              未签约
            </view>
            <view class="user-info">
              <view class="avatar-name">
                <image src="/static/icons/avatar-placeholder.png"></image>
                <view class="name">
                  {{item.motherName}}
                </view>
              </view>
              <view class="">母亲电话：<text>{{item.phonenumber}}</text></view>
              <view class="">预产医院：<text>{{item.hospitalName}}</text></view>
              <view class="">预产期：<text>{{item.dueDate}}</text></view>
            </view>
          </view>
        </u-list-item>
      </u-list>
      </view>
      <view v-else style="padding-top:50%;">
        <u-empty text="暂无记录" mode="order" textSize="28" iconSize="90"></u-empty>

      </view>
    </view>
    
    <u-datetime-picker
    ref="datetimePicker"
      :show="date1Show"
      :value="date1Value"
      :minDate="minDate"
      :visibleItemCount="7"
      mode="date"
      @cancel="date1Show = false"
      @confirm="date1Confirm"
    ></u-datetime-picker>
    <u-datetime-picker
    ref="datetimePicker"
      :show="date2Show"
      :value="date2Value"
      :minDate="minDate"
      :visibleItemCount="7"
      mode="date"
      @cancel="date2Show = false"
      @confirm="date2Confirm"
    ></u-datetime-picker>
    <u-picker :show="statusShow" :columns="statusColumns" keyName="label" @cancel="statusShow = false" @confirm="statusConfirm"></u-picker>
  </view>
</template>

<script>
// import dayjs from 'dayjs';
import { mapState } from 'vuex';
import {contractList} from '@/utils/api.js';
export default {
  components: {
  },
  data() {
    return {
      keyword: '',
      date1Show: false,
      date1Value: '',
      date2Show: false,
      date2Value: '',
      minDate: new Date('2026-01-01').getTime(),
      orderStatus: '',
      statusShow: false,
      statusColumns: [
          [
            {
              label: '已签约',
              id: 1111
            },
            {
              label: '未签约',
              id: 2222
            },
            {
              label: '已解约',
              id: 3333
            },
          ]
      ],
      tabIndex: 0,
      cardListScrollTop: 0,
      cardList: [],
      total: 0,
    };
  },
  computed: {
    // 从 store 映射 user 对象
    ...mapState(['user']),
    orderStatusName() {
      let result = '';
      this.statusColumns[0].forEach((item)=>{
        if (item.id == this.orderStatus) {
          result = item.label;
        }
      });
      return result;
    },
    minDateTimestamp() {
      return new Date(this.date2Value).getTime()
    },
    maxDateTimestamp() {
      return new Date(this.date1Value).getTime()
    },
  },
  onLoad() {
    console.log('onload', this.user)
    if (this.isEmptyInfo(this.user)) {
      uni.redirectTo({
        url: '/pages/login/login'
      });
    } else {
      this.loadmore();
    }
  },
  onShow() {

  },
  methods: {
    date1Confirm(e) {
      // console.log(e, dayjs(e.value).format('YYYY-MM-DD'))
      this.date1Value = uni.$u.timeFormat(e.value, 'yyyy-mm-dd')
      // console.log(this.date1Value)
      this.date1Show = false;
    },
    date2Confirm(e) {
      this.date2Value = uni.$u.timeFormat(e.value, 'yyyy-mm-dd')
      this.date2Show = false;
    },
    statusConfirm(e) {
      console.log(e)
      this.orderStatus = e.value[0].id;
      this.statusShow = false;
    },
    dayjsFormat(date) {
      // return dayjs(new Date(date)).format('YYYY-MM-DD')
    },
    resetDate() {
      // this.date1Value = uni.$u.timeFormat(new Date(), 'yyyy-mm-dd');
      // this.date2Value = uni.$u.timeFormat(new Date(), 'yyyy-mm-dd');
      this.date1Value = '';
      this.date2Value = '';
    },
    filterSubmit() {
      if (new Date(this.date1Value).getTime() > new Date(this.date2Value).getTime()) {
        uni.showToast({
          title: '开始日期不能大于结束日期',
          icon: 'none'
        });
        return false;
      }
      console.log(this.keyword, this.date1Value, this.date2Value, this.orderStatus)
      this.total = 0;
      this.loadmore();
    },
    tabClick(index) {
      this.tabIndex = index;
      this.cardListScrollTop = 0;
      this.cardList = [];
      this.loadmore();
    },
    scrolltolower() {
      if (this.cardList.length >= this.total) {
        return;
      }
      this.loadmore();
    },
    async loadmore() {
      /* for (let i = 0; i < 30; i++) {
        this.cardList.push({
          url: '/static/logo.png',
        });
      } */
      // http://localhost:81/dev-api/system/fdp/list4user?userId=1&dueDateEnd=2026-03-01&dueDateBegin=2026-01-01
      const res = await contractList({
        salesId: this.user.userId,
        dueDateBegin: this.date1Value,
        dueDateEnd: this.date2Value,
      });
      if (res.code == 200) {
        this.cardList = [];
        this.total = 0;
        const timeout = setTimeout(() => {
          res.rows.forEach(item => {
            if (item.statusTxt == '未签约') {
              this.cardList.push(item);
              this.total++;
            }
          });
          if (this.keyword != '') {
            this.total = 0;
            const filterData = [];
            this.cardList.forEach(item => {
              if (item.phonenumber.includes(this.keyword) || item.motherName.includes(this.keyword)) {
                filterData.push(item);
                this.total++;
              }
            });
            this.cardList = filterData;
          }
          clearTimeout(timeout);
        }, 10);
      }
    },
    proStatus(status) {
      //（1-已签,2-未签,3-取消,4-终止）
      let result = {
        className: 'yijieyue',
        name: '已终止',
      };
      if (status == 1) {
        result = {
          className: '',
          name: '已签约',
        };
      }
      if (status == 2) {
        result = {
          className: 'weiqianyue',
          name: '未签约',
        };
      }
      if (status == 3) {
        result = {
          className: 'yijieyue',
          name: '已取消',
        };
      }
      return result;
    },
    goDetail(item) {
      uni.navigateTo({
        url: `/pages/sales_order/detail?id=${item.id}`
      })
    },
  }
};
</script>
<style lang="scss" scoped>
  .container {
    min-height: 100vh;
    background-color: #F5F5F5;
    box-sizing: border-box;
  }
  .fliter-wrap {
    height: 190rpx;
    padding: 26rpx;
    background-color: #fff;
      ::v-deep .u-icon__icon {
        font-size: 32rpx !important;
      }
      
      ::v-deep .u-input__content__prefix-icon .u-icon__icon {
        font-size: 48rpx !important;
      }
    .date-wrap, .order-status-wrap {
      margin-top: 40rpx;
      display: flex;
      align-items: center;
      gap: 10rpx;
      font-weight: bold;
      font-size: 26rpx;
      color: #393939;
      line-height: 72rpx;
      .label {
        width: 120rpx;
      }
    }
    .date-range {
      flex: 1;
      display: flex;
      align-items: center;
      gap: 14rpx;
      .date {
        flex: 1;
        height: 56rpx;
        background: #F5F5F5;
        border-radius: 28rpx;
        font-weight: bold;
        font-size: 26rpx;
        color: #838383;
        line-height: 56rpx;
        padding: 0 20rpx;
        text-align: center;
        white-space: nowrap;
      }
    }
    .order-status-wrap {
      margin-top: 20rpx;
      display: flex;
      align-items: center;
    }
    .status {
      flex: 1;
      height: 56rpx;
      background: #F5F5F5;
      border-radius: 28rpx;
      font-weight: bold;
      font-size: 26rpx;
      color: #838383;
      line-height: 56rpx;
      padding: 0 20rpx;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }
  }
  .list-wrap {
    background-color: #F5F5F5;
    .tab-wrap {
      display: flex;
      align-items: center;
      gap: 26rpx;
      margin-top: 34rpx;
      padding: 0 26rpx;
      padding-bottom: 24rpx;
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
      border: 2rpx solid transparent;
    }
    .tab-current {
      background: #EDEFF7;
      color: #4A63E4;
      border: 2rpx solid #A4AFDE;
    }
    }
    .card-wrap {
      
        margin: 0;
        padding: 40rpx 0rpx;
        border-radius: 40rpx;
        background: #F2F4FA;
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
          gap: 26rpx;
          image{
            width: 72rpx;
            height: 72rpx;
            border-radius: 50%;
          }
          .name {
            font-weight: bold;
            font-size: 28rpx;
            color: #000000;
          }
        }
      }
    }
  }
</style>