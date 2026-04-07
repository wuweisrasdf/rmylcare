import request from '@/utils/request'

// 查询冻干粉订单退款列表
export function listReturn(query) {
  return request({
    url: '/system/return/list',
    method: 'get',
    params: query
  })
}

// 查询冻干粉订单退款详细
export function getReturn(id) {
  return request({
    url: '/system/return/' + id,
    method: 'get'
  })
}

// 新增冻干粉订单退款
export function addReturn(data) {
  return request({
    url: '/system/return',
    method: 'post',
    data: data
  })
}

// 修改冻干粉订单退款
export function updateReturn(data) {
  return request({
    url: '/system/return',
    method: 'put',
    data: data
  })
}

// 删除冻干粉订单退款
export function delReturn(id) {
  return request({
    url: '/system/return/' + id,
    method: 'delete'
  })
}
