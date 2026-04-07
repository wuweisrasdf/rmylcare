import request from '@/utils/request'

// 查询冻干粉订单列表
export function listFdp(query) {
  return request({
    url: '/system/fdp/list',
    method: 'get',
    params: query
  })
}

// 查询冻干粉订单详细
export function getFdp(id) {
  return request({
    url: '/system/fdp/' + id,
    method: 'get'
  })
}

// 新增冻干粉订单
export function addFdp(data) {
  return request({
    url: '/system/fdp',
    method: 'post',
    data: data
  })
}

// 修改冻干粉订单
export function updateFdp(data) {
  return request({
    url: '/system/fdp',
    method: 'put',
    data: data
  })
}

// 同步冻干粉订单
export function syncFdp(id) {
  return request({
    url: '/interface/order/syncOrder?orderId='+id,
    method: 'post'
  })
}

// 删除冻干粉订单
export function delFdp(id) {
  return request({
    url: '/system/fdp/' + id,
    method: 'delete'
  })
}
