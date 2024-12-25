<template>
  <div class="content">
    <div
      class="text main-text"
      :style="{
        padding: '0',
        boxShadow: '0 0 6px rgba(0,0,0,.1)',
        margin: '0 auto',
        borderColor: 'rgba(0,0,0,.3)',
        backgroundColor: '',
        color: '#0067C0',
        borderRadius: '6px',
        borderWidth: '0',
        width: 'auto',
        lineHeight: '64px',
        fontSize: '50px',
        borderStyle: 'solid',
      }"
    >
      您好，欢迎使用hust{{ this.$project.projectName }}！
      <img src="@/assets/img/homepic.jpg" alt="Home Picture" style="margin-top: 20px; max-width: 100%;" />
    </div>
  </div>
</template>
<script>
import router from "@/router/router-static";
export default {
  data() {
    return {};
  },
  mounted() {
    this.init();
  },
  methods: {
    init() {
      if (this.$storage.get("Token")) {
        this.$http({
          url: `${this.$storage.get("sessionTable")}/session`,
          method: "get",
        }).then(({ data }) => {
          if (data && data.code != 0) {
            router.push({ name: "login" });
          }
        });
      } else {
        router.push({ name: "login" });
      }
    },
  },
};
</script>

<style lang="scss" scoped>
.content {
  display: flex;
  align-items: center;
  flex-direction: column;
  width: 100%;
  height: 100%;
  min-height: 500px;
  text-align: center;
  background: transparent;
  .main-text {
    font-size: 38px;
    font-weight: bold;
    margin-top: 15%;
  }
  .text {
    font-size: 24px;
    font-weight: bold;
    color: #333;
  }
}
</style>