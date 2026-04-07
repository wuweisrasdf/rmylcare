import request from '@/utils/request'

// 查询退款单列表
export function listRefund(query) {
  return request({
    url: '/system/refund/list',
    method: 'get',
    params: query
  })
}

// 查询退款单详细
export function getRefund(id) {
  return request({
    url: '/system/refund/' + id,
    method: 'get'
  })
}

// 审核退款单详细
export function checkRefund(data) {
  return request({
    url: '/system/refund/checkRefund',
	method: 'post',
	data: data
  })
}

export function syncRefund(id) {
  return request({
    url: '/system/refund/syncRefund',
	method: 'post',
	data: id
  })
}


// 新增退款单
export function addRefund(data) {
  return request({
    url: '/system/refund',
    method: 'post',
    data: data
  })
}

// 修改退款单
export function updateRefund(data) {
  return request({
    url: '/system/refund',
    method: 'put',
    data: data
  })
}

// 删除退款单
export function delRefund(id) {
  return request({
    url: '/system/refund/' + id,
    method: 'delete'
  })
}
