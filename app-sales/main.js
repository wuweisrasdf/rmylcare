import App from './App'

import Vue from 'vue'
import './uni.promisify.adaptor'

import uView from "uview-ui";
Vue.use(uView);

uni.$u.config.unit = 'rpx' // uView默认单位为 rpx

import store from 'store/index.js'
Vue.prototype.$store = store


Vue.config.productionTip = false


import mpShare from 'uview-ui/libs/mixin/mpShare.js';
Vue.mixin(mpShare);
import { globalMixin } from '@/utils/globalMixin.js';
// 添加全局混入
Vue.mixin(globalMixin);
// 分享
import shareMixin from '@/utils/shareMixin.js';
Vue.mixin(shareMixin);


App.mpType = 'app'
const app = new Vue({
  ...App
})


app.$mount()
