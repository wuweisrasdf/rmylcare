import {isEmpty} from 'lodash';

export const globalMixin = {
  methods: {
    isEmptyInfo(info) {
      return isEmpty(info);
    },
  }
};