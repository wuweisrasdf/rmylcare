import { getRmyToken } from "@/utils/api";
export const getTime = () => {
	let nowDate = new Date();
	let year = nowDate.getFullYear();
	let month = nowDate.getMonth() + 1 < 10 ? "0" + (nowDate.getMonth() + 1) : nowDate.getMonth() + 1;
	let day = nowDate.getDate() < 10 ? "0" + nowDate.getDate() : nowDate.getDate();
	let hour = nowDate.getHours(); //获取系统时，
	let minute = nowDate.getMinutes(); //分
	let second = nowDate.getSeconds(); //秒

	let timeStr = hour + ':' + minute + ':' + second;
	let dateStr = year + "-" + month + "-" + day;

	return [dateStr, timeStr];
}

export const getTimeState = () => {
	// 获取当前时间
	let timeNow = new Date();
	// 获取当前小时
	let hours = timeNow.getHours();
	// 设置默认文字
	let state = ``;
	// 判断当前时间段
	if (hours >= 0 && hours <= 10) {
		state = `早上好!`;
	} else if (hours > 10 && hours < 14) {
		state = `中午好!`;
	} else if (hours >= 14 && hours <= 18) {
		state = `下午好!`;
	} else if (hours > 18 && hours <= 24) {
		state = `晚上好!`;
	}
	return state;
}

/**
 * 获取任意时间
 */
export const getDate = (date, AddDayCount) => {
	if (!date) {
		date = new Date()
	}
	if (typeof date !== 'object') {
		date = date.replace(/-/g, '/')
	}
	const dd = new Date(date)

	if (!AddDayCount) {
		AddDayCount = 0
	}

	dd.setDate(dd.getDate() + AddDayCount) // 获取AddDayCount天后的日期

	const y = dd.getFullYear()
	const m = dd.getMonth() + 1 < 10 ? '0' + (dd.getMonth() + 1) : dd.getMonth() + 1 // 获取当前月份的日期，不足10补0
	const d = dd.getDate() < 10 ? '0' + dd.getDate() : dd.getDate() // 获取当前几号，不足10补0
	return {
		fullDate: y + '-' + m + '-' + d,
		year: y,
		month: m,
		date: d,
		day: dd.getDay()
	}
}

// 播放mp3
export const playOnLine = (file_url) => {
	uni.showLoading({
		title: '播放中'
	});

	let src = $C.videoUrl + file_url
	console.log('音频')
	console.log(src)

	const Audio = uni.createInnerAudioContext();
	Audio.autoplay = true;
	Audio.src = src;
	//Audio.src = 'http://trialmatrix.huizhidi.com.cn:3001/mp3/a482ac37315741b092e53cd7ed66d0df.mp3';
	Audio.play(); //执行播放  
	Audio.onError((res) => {
		console.log(res.errMsg);
		console.log(res.errCode);
		uni.hideLoading();
	});
	Audio.onPause(function() {
		console.log('end');
		Audio.destroy();
		uni.hideLoading();
	});

	Audio.onEnded(function() {
		console.log('end');
		uni.hideLoading();
	});
}


//过滤手机输入法自带表情
export const utf16toEntities = (str) => {
	var patt = /[\ud800-\udbff][\udc00-\udfff]/g;
	// 检测utf16字符正则
	str = str.replace(patt, function(char) {
		var H, L, code;
		if (char.length === 2) {
			H = char.charCodeAt(0);
			// 取出高位
			L = char.charCodeAt(1);
			// 取出低位
			code = (H - 0xD800) * 0x400 + 0x10000 + L - 0xDC00;
			// 转换算法
			return "&#" + code + ";";
		} else {
			return char;
		}
	});
	return str;
}

// 用于反解开EMOJI编码后的字符串
export const uncodeUtf16 = (str) => {
	var reg = /\&#.*?;/g;
	var result = str.replace(reg, function(char) {
		var H, L, code;
		if (char.length == 9) {
			code = parseInt(char.match(/[0-9]+/g));
			H = Math.floor((code - 0x10000) / 0x400) + 0xD800;
			L = (code - 0x10000) % 0x400 + 0xDC00;
			return unescape("%u" + H.toString(16) + "%u" + L.toString(16));
		} else {
			return char;
		}
	});
	return result;
}

//对字符串进行加密       	
export const compileStr = (code) => {
	var c = String.fromCharCode(code.charCodeAt(0) + code.length);
	for (var i = 1; i < code.length; i++) {
		c += String.fromCharCode(code.charCodeAt(i) + code.charCodeAt(i - 1));
	}
	return escape(c);
}




//字符串进行解密 
export const uncompileStr = (code) => {
	code = unescape(code);
	var c = String.fromCharCode(code.charCodeAt(0) - code.length);
	for (var i = 1; i < code.length; i++) {
		c += String.fromCharCode(code.charCodeAt(i) - c.charCodeAt(i - 1));
	}
	return c;
}

/**
 * 查看文档
 * @param fileName 完整url
 */
export const showDoc = (fileName) => {
	const fileTypes = ['doc', 'xls', 'ppt', 'pdf', 'docx', 'xlsx', 'pptx']; //允许文件类型
	const imageTypes = ["jpg", "jpeg", "png"]; //允许图片类型
	const fileType = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();

	// 文档下载
	if (fileTypes.indexOf(fileType) != -1) {
		uni.showLoading({
			title: '文件加载中'
		});
		const downloadTask = uni.downloadFile({
			url: fileName,
			success: (result) => {
				if (result.statusCode === 200) {
					console.log('下载成功');
					console.log(result);
		
					let filePath = result.tempFilePath;
					uni.openDocument({
						fileType: fileType,
						filePath: filePath,
						success: function(rs) {
							console.log("打开文档成功");
						},
						fail: function(r) {
							console.log("打开文档失败");
						}
					});
				}
			},
			complete: () => {
				uni.hideLoading();
			},
			timeout: () => {
				uni.hideLoading();
			}
		});
	}
	else if (imageTypes.indexOf(fileType) != -1) {
		wx.previewImage({
			current: fileName, // 当前显示图片的http链接
			urls: [fileName] // 需要预览的图片http链接列表
		})
	}else{
		uni.showToast({
			title: '不支持预览',
			icon:'none',
			duration: 2000
		});
		return false;
	}
}

// 解析url字符串拼装为对象
export const parseUrl = (url) => {
	let res = {};
	if (url.indexOf('?') > -1) {
		// 例： http://yicun.xinyuchuangzhi.com?deviceId=1234567812345678&type=1
		
		//下面这个方法是方便收集成对象做的工具类
		const query = (url.split('?')[1] || '').trim().replace(/^(\?|#|&)/, '');
		if (query) {
			query.split('&').forEach(param => {
				const parts = param.replace(/\+/g, ' ').split('=')
				const key = decodeURIComponent(parts.shift())
				const val = parts.length > 0 ? decodeURIComponent(parts.join('=')) : null
				if (res[key] === undefined) {
				  res[key] = val
				} else if (Array.isArray(res[key])) {
				  res[key].push(val)
				} else {
				  res[key] = [res[key], val]
				}
			})
		}
	}else{
		// 例： deviceId=1234567812345678&type=1&now=2692626
		const strArr = url.split("&").map(item => item.split("="));
		strArr.forEach(item =>{
			res[item[0]] = item[1];
		});
	}
	
	return res;
}

// 在 methods 或者 utils 文件夹中的工具函数文件里定义
export function debounce(func, wait) {
	let timeout;
	return function(...args) {
	  const context = this;
	  clearTimeout(timeout);
	  timeout = setTimeout(() => func.apply(context, args), wait);
	};
  }

export function timeString(timeStr) {
  return timeStr ? timeStr.substring(0, 10) : '--';
}


// Token存储和管理相关变量
let cachedToken = null;
let expiresOn = null;

// 检查token是否过期
export function isTokenExpired() {
  if (!expiresOn) {
    return true; // 如果没有过期时间，认为已过期
  }
  
  const now = new Date();
  const expireTime = new Date(expiresOn);
  return now >= expireTime;
}

// 获取有效的token，如果过期则重新获取
export async function getValidToken() {
  // 如果缓存中有有效token，直接返回
  if (cachedToken && !isTokenExpired()) {
    return {
      access_token: cachedToken,
      expires_on: expiresOn
    };
  }
  
  // 否则重新获取token
  try {
    const response = await getRmyToken({
      client_id: '',
      client_secret: ''
    });
    
    // 更新缓存
    cachedToken = response.access_token;
    expiresOn = response.expires_on;
    
    return {
      access_token: cachedToken,
      expires_on: expiresOn
    };
  } catch (error) {
    console.error('获取token失败:', error);
    throw error;
  }
}