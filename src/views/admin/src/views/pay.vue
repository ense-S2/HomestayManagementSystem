<template>
  <div class="container">
    <!-- 提示用户在确认支付前核对订单信息 -->
    <el-alert
      title="确认支付前请先核对订单信息"
      type="success"
      :closable="false"
    ></el-alert>

    <!-- 支付方式选择区域 -->
   <div class="pay-type-content">
      <div class="pay-type-item">
        <el-radio v-model="type" label="微信支付"></el-radio>
        <img src="@/assets/img/test/weixin.png" alt />
      </div>
      <div class="pay-type-item">
        <el-radio v-model="type" label="支付宝支付"></el-radio>
        <img src="@/assets/img/test/zhifubao.png" alt />
      </div>
      <div class="pay-type-item">
        <el-radio v-model="type" label="建设银行"></el-radio>
        <img src="@/assets/img/test/jianshe.png" alt />
      </div>
      <div class="pay-type-item">
        <el-radio v-model="type" label="农业银行"></el-radio>
        <img src="@/assets/img/test/nongye.png" alt />
      </div>
      <div class="pay-type-item">
        <el-radio v-model="type" label="中国银行"></el-radio>
        <img src="@/assets/img/test/zhongguo.png" alt />
      </div>
      <div class="pay-type-item">
        <el-radio v-model="type" label="交通银行"></el-radio>
        <img src="@/assets/img/test/jiaotong.png" alt />
      </div>
    </div>

   
     <!-- 支付方式选择区域 -->
     <div class="pay-type-content">
      <el-select v-model="type" placeholder="请选择支付方式">
        <el-option label="微信支付" value="微信支付"></el-option>
        <el-option label="支付宝支付" value="支付宝支付"></el-option>
        <el-option label="建设银行" value="建设银行"></el-option>
        <el-option label="农业银行" value="农业银行"></el-option>
        <el-option label="中国银行" value="中国银行"></el-option>
        <el-option label="交通银行" value="交通银行"></el-option>
      </el-select>
    </div>

 
    <!-- 按钮区域，包含确认支付和返回按钮 -->
    <div class="buton-content">
      <el-button @click="submitTap" type="primary">确认支付</el-button>
      <el-button @click="back()">返回</el-button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      name: "", // 收款人姓名（当前代码中未使用）
      account: "", // 收款账号（当前代码中未使用）
      type: "", // 支付方式
      table: "", // 存储的支付表名
      obj: "", // 存储的支付对象
    };
  },
  mounted() {
    // 初始化时从存储中获取支付表名和支付对象
    let table = this.$storage.get("paytable");
    let obj = this.$storage.getObj("payObject");
    this.table = table;
    this.obj = obj;
  },
  methods: {
    submitTap() {
      // 验证是否选择了支付方式
      if (!this.type) {
        this.$message.error("请选择支付方式");
        return;
      }

      // 确认支付对话框
      this.$confirm(`确定支付?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      }).then(() => {
        // 更新支付状态为已支付，并发送更新请求
        this.obj.ispay = "已支付";
        this.$http({
          url: `${this.table}/update`,
          method: "post",
          data: this.obj,
        }).then(({ data }) => {
          if (data && data.code === 0) {
            // 支付成功后显示消息并返回上一页
            this.$message({
              message: "支付成功",
              type: "success",
              duration: 1500,
              onClose: () => {
                this.$router.go(-1);
              },
            });
          } else {
            // 支付失败显示错误信息
            this.$message.error(data.msg);
          }
        });
      });
    },
    back() {
      // 返回上一页
      this.$router.go(-1);
    },
  },
};
</script>

<style lang="scss" scoped>
/* 容器样式 */
.container {
  margin: 10px;
  font-size: 14px;

  /* 提示信息样式 */
  .el-alert {
    width: 100%;
    background-color: ''; /* 背景色 */
    border: 1px solid ''; /* 边框色 */
    color: #0067c0; /* 文字颜色 */
    padding: 15px; /* 内边距 */
    margin-bottom: 15px; /* 底部外边距 */
    border-radius: 4px; /* 圆角边框 */
    font-size: 16px; /* 字体大小 */
    font-weight: bold; /* 字体加粗 */
  }

  /* 支付方式选择区域样式 */
  .pay-type-content {
    display: flex;
    align-items: center;
    margin-top: 20px;
    flex-wrap: wrap;

    .pay-type-item {
      display: flex;
      align-items: center;
      justify-content: space-between;
      width: 300px;
      margin: 20px;
      border: 1px solid #879ff0;
      padding: 20px;
    }

    .el-select {
      width: 300px;
      margin: 20px;
    }
  }

  /* 按钮区域样式 */
  .buton-content {
    margin: 20px;
  }
}

/* 按钮样式 */
.el-button {
  background-color: #2c64bd;
  border-color: #3646f2;
  color: #fff;
  font-size: 14px;
  font-weight: bold;

  &:hover {
    background-color: #00a884;
    border-color: #00a884;
  }
}
</style>