<template>
  <div>
    <el-form
      class="detail-form-content"
      ref="ruleForm"
      :model="ruleForm"
      label-width="80px"
      style="background: transparent;"
    >
      <el-row>
        <!-- 动态显示：只有当 flag 为 'yonghu' 时，账号字段才会显示 -->
        <el-col :span="12">
          <el-form-item v-if="flag == 'yonghu'" label="账号" prop="zhanghao">
            <!-- 账号字段为只读，因为账号通常不可修改 -->
            <el-input
              v-model="ruleForm.zhanghao"
              readonly
              placeholder="账号"
              clearable
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item v-if="flag == 'yonghu'" label="姓名" prop="xingming">
            <el-input
              v-model="ruleForm.xingming"
              placeholder="姓名"
              clearable
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item v-if="flag == 'yonghu'" label="性别" prop="xingbie">
            <!-- 性别选择框，选项来自 yonghuxingbieOptions -->
            <el-select v-model="ruleForm.xingbie" placeholder="请选择性别">
              <el-option
                v-for="(item, index) in yonghuxingbieOptions"
                v-bind:key="index"
                :label="item"
                :value="item"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item v-if="flag == 'yonghu'" label="手机" prop="shouji">
            <el-input
              v-model="ruleForm.shouji"
              placeholder="手机"
              clearable
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item
            v-if="flag == 'yonghu'"
            label="身份证"
            prop="shenfenzheng"
          >
            <el-input
              v-model="ruleForm.shenfenzheng"
              placeholder="身份证"
              clearable
            ></el-input>
          </el-form-item>
        </el-col>
        <el-form-item v-if="flag == 'users'" label="用户名" prop="username">
          <el-input v-model="ruleForm.username" placeholder="用户名"></el-input>
        </el-form-item>
        <el-col :span="24">
          <el-form-item>
            <el-button type="primary" @click="onUpdateHandler">修 改</el-button>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
  </div>
</template>

<script>
// 数字，邮件，手机，url，身份证校验
import {
  isNumber,
  isIntNumer,
  isEmail,
  isMobile,
  isPhone,
  isURL,
  checkIdCard,
} from "@/utils/validate";

export default {
  data() {
    return {
      ruleForm: {}, // 存储表单数据的模型，所有字段与表单双向绑定
      flag: '', // 用于控制页面中不同的动态显示内容
      usersFlag: false,
      yonghuxingbieOptions: [], // 性别下拉框选项
    };
  },
  mounted() {
    // 动态获取当前的会话表类型，例如 'yonghu' 或 'users'
    var table = this.$storage.get("sessionTable");
    this.flag = table;

    // 向后端发送请求获取当前用户的会话信息
    this.$http({
      url: `${this.$storage.get("sessionTable")}/session`, // 请求路径
      method: "get",
    }).then(({ data }) => {
      // 如果请求成功，将后端返回的会话数据赋值到 ruleForm
      if (data && data.code === 0) {
        this.ruleForm = data.data;
      } else {
        // 如果失败，显示错误消息
        this.$message.error(data.msg);
      }
    });

    // 初始化性别选项
    this.yonghuxingbieOptions = "男,女,不详".split(",");
  },
  methods: {
    // 点击“修改”按钮时触发的处理逻辑
    onUpdateHandler() {
      // 校验表单字段，若不满足条件则提示错误信息并返回
      if (!this.ruleForm.zhanghao && "yonghu" == this.flag) {
        this.$message.error("账号不能为空");
        return;
      }
      if (!this.ruleForm.mima && "yonghu" == this.flag) {
        this.$message.error("密码不能为空");
        return;
      }
      if (!this.ruleForm.xingming && "yonghu" == this.flag) {
        this.$message.error("姓名不能为空");
        return;
      }
      if (
        "yonghu" == this.flag &&
        this.ruleForm.shouji &&
        !isMobile(this.ruleForm.shouji)
      ) {
        this.$message.error(`手机应输入手机格式`);
        return;
      }
      if (
        "yonghu" == this.flag &&
        this.ruleForm.shenfenzheng &&
        !checkIdCard(this.ruleForm.shenfenzheng)
      ) {
        this.$message.error(`身份证应输入身份证格式`);
        return;
      }
      if ("users" == this.flag && this.ruleForm.username.trim().length < 1) {
        this.$message.error(`用户名不能为空`);
        return;
      }

      // 将修改后的数据提交给后端
      this.$http({
        url: `${this.$storage.get("sessionTable")}/update`, // 动态请求路径
        method: "post",
        data: this.ruleForm, // 提交的数据
      }).then(({ data }) => {
        // 如果后端返回成功状态，显示成功消息
        if (data && data.code === 0) {
          this.$message({
            message: "修改信息成功",
            type: "success",
            duration: 1500,
            onClose: () => {},
          });
        } else {
          // 如果失败，显示错误消息
          this.$message.error(data.msg);
        }
      });
    },
  },
};
</script>

<style lang="scss" scoped>
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
.el-select-dropdown__item.selected {
  color: #3646f2;
  font-weight: bold;
}
</style>
