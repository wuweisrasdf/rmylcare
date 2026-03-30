// utils/shareMixin.js
export default {
  onShareAppMessage(res) {
    // 获取当前页面路径和参数
    const pages = getCurrentPages();
    const currentPage = pages[pages.length - 1];
    const { route, options } = currentPage;

    // 拼接带参数的路径
    let path = `/${route}`;
    if (options && Object.keys(options).length > 0) {
      const query = Object.entries(options)
        .map(([key, value]) => `${key}=${encodeURIComponent(value)}`)
        .join('&');
      path += `?${query}`;
    }

    return {
      title: '智数健管',
      path: '/pages/index/index',
      imageUrl: '/static/logo.png' // 可选：分享封面图
    };
  }
}