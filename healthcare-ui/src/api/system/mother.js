import request from '@/utils/request'

// 查询产妇信息列表
export function listMother(query) {
  return request({
    url: '/system/mother/list',
    method: 'get',
    params: query
  })
}

// 查询产妇信息详细
export function getMother(id) {
  return request({
    url: '/system/mother/' + id,
    method: 'get'
  })
}

// 新增产妇信息
export function addMother(data) {
  return request({
    url: '/system/mother',
    method: 'post',
    data: data
  })
}

// 修改产妇信息
export function updateMother(data) {
  return request({
    url: '/system/mother',
    method: 'put',
    data: data
  })
}

// 删除产妇信息
export function delMother(id) {
  return request({
    url: '/system/mother/' + id,
    method: 'delete'
  })
}
