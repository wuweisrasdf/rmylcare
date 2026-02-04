/**
 * 客户信息中断续填 Storage 封装
 * 支持按 formId 隔离、自动过期、便捷读写
 */

const STORAGE_PREFIX = 'form_draft_'; // 前缀，避免冲突
const DEFAULT_EXPIRE_DAYS = 7; // 默认7天过期

/**
 * 保存草稿
 * @param {string} formId - 表单唯一标识，如 'customer_info', 'loan_apply'
 * @param {object} data - 要保存的表单数据
 * @param {number} expireDays - 过期天数（可选，默认7天）
 */
export function saveDraft(formId, data, expireDays = DEFAULT_EXPIRE_DAYS) {
  if (!formId || typeof formId !== 'string') {
    console.warn('[saveDraft] formId is required and must be a string');
    return false;
  }
  
  try {
    const key = STORAGE_PREFIX + formId;
    const payload = {
      data,
      savedAt: Date.now(),
      expireAt: Date.now() + expireDays * 24 * 60 * 60 * 1000
    };
    uni.setStorageSync(key, payload);
    console.log(`[Storage] 草稿已保存: ${formId}`);
    return true;
  } catch (e) {
    console.error('[saveDraft] 保存失败:', e);
    return false;
  }
}

/**
 * 读取草稿（自动过滤过期数据）
 * @param {string} formId - 表单唯一标识
 * @returns {object|null} 返回数据对象，或 null（无有效草稿）
 */
export function getDraft(formId) {
  if (!formId || typeof formId !== 'string') {
    console.warn('[getDraft] formId is required and must be a string');
    return null;
  }

  try {
    const key = STORAGE_PREFIX + formId;
    const payload = uni.getStorageSync(key);

    if (!payload || typeof payload !== 'object') {
      return null;
    }

    // 检查是否过期
    if (payload.expireAt && Date.now() > payload.expireAt) {
      // 自动清理过期数据
      removeDraft(formId);
      console.log(`[Storage] 草稿已过期并清理: ${formId}`);
      return null;
    }

    return payload.data;
  } catch (e) {
    console.error('[getDraft] 读取失败:', e);
    return null;
  }
}

/**
 * 清除指定草稿
 * @param {string} formId
 */
export function removeDraft(formId) {
  if (!formId || typeof formId !== 'string') return;
  try {
    const key = STORAGE_PREFIX + formId;
    uni.removeStorageSync(key);
    console.log(`[Storage] 草稿已清除: ${formId}`);
  } catch (e) {
    console.error('[removeDraft] 清除失败:', e);
  }
}

/**
 * 清除所有草稿（谨慎使用，如用户登出时）
 */
export function clearAllDrafts() {
  try {
    const storageInfo = uni.getStorageInfoSync();
    const keysToRemove = storageInfo.keys.filter(key => 
      key.startsWith(STORAGE_PREFIX)
    );
    keysToRemove.forEach(key => {
      uni.removeStorageSync(key);
    });
    console.log(`[Storage] 所有草稿已清除 (${keysToRemove.length} 项)`);
  } catch (e) {
    console.error('[clearAllDrafts] 清除失败:', e);
  }
}

/*
<template>
  <view>
    <input v-model="formData.name" placeholder="姓名" />
    <input v-model="formData.phone" placeholder="手机号" />
    <button @click="submit">提交</button>
    <button @click="clearDraft">放弃填写</button>
  </view>
</template>

<script>
import { saveDraft, getDraft, removeDraft } from '@/utils/storage.js';

const FORM_ID = 'customer_basic_info'; // 表单唯一ID

export default {
  data() {
    return {
      formData: {
        name: '',
        phone: ''
      }
    };
  },

  onLoad() {
    // 页面加载时尝试恢复草稿
    const draft = getDraft(FORM_ID);
    if (draft) {
      this.formData = { ...this.formData, ...draft };
      console.log('已恢复草稿:', draft);
    }
  },

  onUnload() {
    // 页面卸载前自动保存（用户点击返回/关闭）
    this.autoSave();
  },

  methods: {
    autoSave() {
      // 只保存非空数据
      if (this.formData.name || this.formData.phone) {
        saveDraft(FORM_ID, this.formData);
      }
    },

    submit() {
      // 提交成功后清除草稿
      // this.$api.submitCustomer(this.formData).then(() => {
        removeDraft(FORM_ID);
        uni.showToast({ title: '提交成功' });
        uni.navigateBack();
      // });
    },

    clearDraft() {
      removeDraft(FORM_ID);
      this.formData = { name: '', phone: '' };
      uni.showToast({ title: '已放弃填写' });
    }
  },

  // 监听输入变化，可选：实时保存（防丢失）
  watch: {
    formData: {
      handler(newVal) {
        // 防抖保存（可选）
        clearTimeout(this.saveTimer);
        this.saveTimer = setTimeout(() => {
          if (newVal.name || newVal.phone) {
            saveDraft(FORM_ID, newVal);
          }
        }, 1000);
      },
      deep: true
    }
  }
};
</script>
*/