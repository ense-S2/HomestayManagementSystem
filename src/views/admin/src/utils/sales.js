import request from "@/utils/request";
import api from "@/utils/api";

// 获取销售统计数据
export function fetchSalesData(params) {
  return request({
    url: api.salesStats,
    method: "get",
    params,
  })
    .then((response) => {
      if (!response || !response.data) {
        throw new Error("后端返回空响应或格式不正确");
      }
      const { code = -1, message = "未知错误", data = {} } = response;
      if (code !== 200) {
        throw new Error(`后端错误: ${message}`);
      }
      return data;
    })
    .catch((error) => {
      console.error("fetchSalesData 错误:", error.message, error.stack);
      throw error;
    });
}

// 获取筛选后的订单数据
export function fetchFilteredOrders(params) {
  return request({
    url: api.salesFilter,
    method: "get",
    params,
  })
    .then((response) => {
      if (response.code !== 200) {
        throw new Error(`后端错误: ${response.message}`);
      }
      return response;
    })
    .catch((error) => {
      throw error;
    });
}
