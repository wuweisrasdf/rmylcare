import request from '@/utils/request'

// 查询付款单列表
export function listPayment(query) {
  return request({
    url: '/system/payment/list',
    method: 'get',
    params: query
  })
}

// 查询付款单详细
export function getPayment(id) {
  return request({
    url: '/system/payment/' + id,
    method: 'get'
  })
}

// 新增付款单
export function addPayment(data) {
  return request({
    url: '/system/payment',
    method: 'post',
    data: data
  })
}

// 修改付款单
export function updatePayment(data) {
  return request({
    url: '/system/payment',
    method: 'put',
    data: data
  })
}

// 删除付款单
export function delPayment(id) {
  return request({
    url: '/system/payment/' + id,
    method: 'delete'
  })
}
