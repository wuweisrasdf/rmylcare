import Vue from 'vue'
import Vuex from 'vuex'
import {
	appx
} from './modules/app.js'
import {
	clearAllDrafts
} from '@/utils/storage.js';

Vue.use(Vuex)

// 保存用户认证信息到 storage
function saveAuthToStorage({
	user,
	token,
	role
}) {
	try {
		uni.setStorageSync('token', token || '')
		uni.setStorageSync('user', JSON.stringify(user || {}))
		uni.setStorageSync('role', role || '')
	} catch (e) {
		console.error('保存用户信息到 storage 失败', e)
	}
}

// 清除所有认证相关 storage
function clearAuthStorage() {
	const keys = [
		'user',
		'token',
		'role',
		'login_cache_username',
		'login_cache_password',
		'login_cache_expired',
		// 扫码相关存储
		'SCAN_SALES_ID',
		'FROM_SCAN'
	]
	keys.forEach(key => {
		try {
			uni.removeStorageSync(key)
		} catch (e) {
			console.warn(`清除 storage key "${key}" 失败`, e)
		}
	})
}

export default new Vuex.Store({
	modules: {
		appx
	},
	getters: {
		isLogined: (state) => !!state.token,
	},
	// state 全局数据
	state: {
		user: null,
		token: null,
		role: null,
		socket: null,
	},
	// 所有状态变更必须通过 mutations
	// 通过 commit 调用 mutation
	// storage 通过 saveAuthToStorage
	mutations: {
		SET_AUTH(state, {
			user,
			token,
			role
		}) {
			state.user = user
			state.token = token
			state.role = role
		},
		CLEAR_AUTH(state) {
			state.user = null
			state.token = null
			state.role = null
		},
		SET_USER(state, user) {
			state.user = user
		},
		SET_TOKEN(state, token) {
			state.token = token
		}
	},
	// actions的每一个函数，都将 Vuex.Store对象的上下文，作为第一个参数， {state} 从上下文环境中解构出 state
	// 通过 dispatch 调用 action
	actions: {
		// 验证是否登录
		authMethod({
			state
		}, callback) {
			if (!state.user) {
				return false;
			}

			if (typeof callback === 'function') {
				callback()
			}

			return true;
		},

		// 初始化用户登录状态
		initUser({
			commit
		}) {
			try {
				let u = uni.getStorageSync('user')
				const t = uni.getStorageSync('token')
				const r = uni.getStorageSync('role')

				if (u) {
					// 安全解析 user
					const user = typeof u === 'string' ? JSON.parse(u) : u

					commit('SET_AUTH', {
						user,
						token: t,
						role: r
					})

					return true
				}
			} catch (e) {
				console.error('初始化用户状态失败', e)
				// 清理可能损坏的缓存
				clearAuthStorage()
			}

			return false // 未登录或初始化失败
		},

		// 退出登录
		logout({
			commit
		}) {
			commit('CLEAR_AUTH')
			clearAuthStorage()

			// 清除所有表单草稿
			clearAllDrafts();
		},

		// 登录
		login({
			commit
		}, options) {
			if (!options?.user) return

			const user = options.user
			const token = uni.getStorageSync('token') // 从本地缓存中获取token
			const role = '' // TODO 从user中获取role

			commit('SET_AUTH', {
				user,
				token,
				role
			})
			saveAuthToStorage({
				user,
				token,
				role
			})
		},

		// 更新用户信息
		updateUserInfo({
			commit,
			state
		}, options) {
			if (!options?.user) return false;

			const user = options.user
			commit('SET_USER', user)
			saveAuthToStorage({
				user,
				token: state.token,
				role: state.role
			})

			return true;
		}
	}
})