import axios from "axios";
import base from "@/utils/base";
import storage from "@/utils/storage";
import router from "@/router/router-static"; // 如果有静态路由

// 创建 Axios 实例
const request = axios.create({
  baseURL: base.get().url, // 设置基础 URL
  timeout: 10000, // 超时时间
  headers: {
    "Content-Type": "application/json;charset=utf-8",
  },
});

// 请求拦截器
request.interceptors.request.use(
  (config) => {
    // 添加 Token 到请求头
    const token = storage.get("Token");
    if (token) {
      config.headers["Token"] = token;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// 响应拦截器
request.interceptors.response.use(
  (response) => {
    // 如果响应包含自定义错误码，处理相应逻辑
    if (response.data && response.data.code === 401) {
      // Token 失效，跳转到登录页
      router.push({ name: "login" });
    }
    return response.data; // 直接返回数据部分
  },
  (error) => {
    return Promise.reject(error);
  }
);

export default request;
