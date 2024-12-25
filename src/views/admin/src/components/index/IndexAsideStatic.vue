<template>
  <!-- 侧边栏组件，宽度固定为210px -->
  <el-aside class="index-aside" width="210px">
    <!-- 内容容器，包含菜单列表 -->
    <div class="index-aside-inner menulist">
      <!-- 使用 v-for 循环遍历 menuList 数组，根据当前角色显示对应的菜单项 -->
      <div
        v-for="item in menuList"
        :key="item.roleName"
        v-if="role == item.roleName"
        class="menulist-item"
      >
        <!-- 图片展示区域 -->
        <div class="menulistImg">
          <el-image
            :src="require('@/assets/img/hust.png')"
            :style="{
              padding: '0',
              boxShadow: '0 0 6px rgba(0,0,0,0)',
              margin: '0 50px 0 0',
              borderColor: 'rgba(0,0,0,0)',
              borderRadius: '0',
              borderWidth: '0',
              width: '80%',
              borderStyle: 'solid',
              height: 'auto',
            }"
            fit="cover"
          />
        </div>

        <!-- 菜单组件，模式根据条件判断是水平还是垂直，默认展开唯一子菜单，初始激活项为0 -->
        <el-menu
          :mode="2 == 1 ? 'horizontal' : 'vertical'"
          :unique-opened="true"
          class="el-menu-demo"
          default-active="0"
        >
          <!-- 首页菜单项，点击时调用 menuHandler 方法 -->
          <el-menu-item index="0" @click="menuHandler('')" style="font-weight: bold;">
            <i v-if="true" class="el-icon-menu el-icon-s-home" />首页*
          </el-menu-item>

          <!-- 个人中心子菜单 -->
          <el-submenu :index="1 + ''" style="font-weight: bold;">
            <template slot="title" >
              <i v-if="true" class="el-icon-menu el-icon-user-solid" />
              <span>个人中心</span>
            </template>
            <!-- 修改密码菜单项，点击时调用 menuHandler 方法 -->
            <el-menu-item :index="1 - 1" @click="menuHandler('updatePassword')"
              >修改密码</el-menu-item
            >
            <!-- 查看个人信息菜单项，点击时调用 menuHandler 方法 -->
            <el-menu-item :index="1 - 2" @click="menuHandler('center')"
              >查看个人信息</el-menu-item
            >
          </el-submenu>

          <!-- 动态生成的子菜单，根据 item.backMenu 数据循环渲染 -->
          <el-submenu
            v-for="(menu, index) in item.backMenu"
            :key="menu.menu"
            :index="index + 2 + ''"
			style="font-weight: bold;"
          >
            <template slot="title">
              <i v-if="true" class="el-icon-menu" :class="icons[index]" />
              <span>{{ menu.menu }}</span>
            </template>
            <!-- 子菜单下的子项，根据 menu.child 数据循环渲染 -->
            <el-menu-item
              v-for="(child, sort) in menu.child"
              :key="sort"
              :index="index + 2 + '-' + sort"
              @click="menuHandler(child.tableName)"
            >
              {{ child.menu }}
            </el-menu-item>
          </el-submenu>
        </el-menu>
      </div>
    </div>
  </el-aside>
</template>

<script>
import menu from "@/utils/menu";
export default {
  data() {
    return {
      menuList: [],
      dynamicMenuRoutes: [],
      role: "",
      icons: [
        "el-icon-s-cooperation",
        "el-icon-s-order",
        "el-icon-s-platform",
        "el-icon-s-fold",
        "el-icon-s-unfold",
        "el-icon-s-operation",
        "el-icon-s-promotion",
        "el-icon-s-release",
        "el-icon-s-ticket",
        "el-icon-s-management",
        "el-icon-s-open",
        "el-icon-s-shop",
        "el-icon-s-marketing",
        "el-icon-s-flag",
        "el-icon-s-comment",
        "el-icon-s-finance",
        "el-icon-s-claim",
        "el-icon-s-custom",
        "el-icon-s-opportunity",
        "el-icon-s-data",
        "el-icon-s-check",
        "el-icon-s-grid",
        "el-icon-menu",
        "el-icon-chat-dot-square",
        "el-icon-message",
        "el-icon-postcard",
        "el-icon-position",
        "el-icon-microphone",
        "el-icon-close-notification",
        "el-icon-bangzhu",
        "el-icon-time",
        "el-icon-odometer",
        "el-icon-crop",
        "el-icon-aim",
        "el-icon-switch-button",
        "el-icon-full-screen",
        "el-icon-copy-document",
        "el-icon-mic",
        "el-icon-stopwatch",
      ],
      menulistStyle: "vertical",
      menulistBorderBottom: {},
    };
  },
  mounted() {
    const menus = menu.list();
    if (menus) {
      this.menuList = menus;
    } else {
      let params = {
        page: 1,
        limit: 1,
        sort: "id",
      };
      this.$http({
        url: "menu/list",
        method: "get",
        params: params,
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.menuList = JSON.parse(data.data.list[0].menujson);
          this.$storage.set("menus", this.menuList);
        }
      });
    }
    this.role = this.$storage.get("role");
  },
  created() {
    setTimeout(() => {
      this.menulistStyleChange();
    }, 10);
    this.icons.sort(() => {
      return 0.5 - Math.random();
    });
    this.lineBorder();
  },
  methods: {
    lineBorder() {
      let style = "vertical";
      let w = "0px";
      let s = "solid";
      let c = "#ccc";
      if (style == "vertical") {
        this.menulistBorderBottom = {
          borderBottomWidth: w,
          borderBottomStyle: s,
          borderBottomColor: c,
        };
      } else {
        this.menulistBorderBottom = {
          borderRightWidth: w,
          borderRightStyle: s,
          borderRightColor: c,
        };
      }
    },
    menuHandler(name) {
      let router = this.$router;
      name = "/" + name;
      router.push(name);
    },
    // 菜单
    setMenulistHoverColor() {
      let that = this;
      return;
      this.$nextTick(() => {
        document.querySelectorAll(".menulist .el-menu-item").forEach((el) => {
          el.addEventListener("mouseenter", (e) => {
            e.stopPropagation();
            el.style.backgroundColor = "rgba(104, 223, 240, 1)";
          });
          el.addEventListener("mouseleave", (e) => {
            e.stopPropagation();
            // el.style.backgroundColor = "#424A5D"
            el.style.background = "none";
          });
          el.addEventListener("focus", (e) => {
            e.stopPropagation();
            el.style.backgroundColor = "rgba(104, 223, 240, 1)";
          });
        });
        document
          .querySelectorAll(".menulist .el-submenu__title")
          .forEach((el) => {
            el.addEventListener("mouseenter", (e) => {
              e.stopPropagation();
              el.style.backgroundColor = "rgba(104, 223, 240, 1)";
            });
            el.addEventListener("mouseleave", (e) => {
              e.stopPropagation();
              // el.style.backgroundColor = "#424A5D"
              el.style.background = "none";
            });
          });
      });
    },
    setMenulistIconColor() {
      this.$nextTick(() => {
        document
          .querySelectorAll(
            ".menulist .el-submenu__title .el-submenu__icon-arrow"
          )
          .forEach((el) => {
            el.style.color = "rgba(153, 153, 153, 1)";
          });
      });
    },
    menulistStyleChange() {
      this.setMenulistIconColor();
      this.setMenulistHoverColor();
      this.setMenulistStyleHeightChange();
      let str = "2";
      if (1 == str) {
        this.$nextTick(() => {
          document
            .querySelectorAll(".el-container .el-container")
            .forEach((el) => {
              el.style.display = "block";
              el.style.paddingTop = "60px"; // header 高度
            });
          document.querySelectorAll(".el-aside").forEach((el) => {
            el.style.width = "100%";
            el.style.height = "100%";
            el.style.paddingTop = "0";
          });
          document
            .querySelectorAll(".index-aside .index-aside-inner")
            .forEach((el) => {
              el.style.paddingTop = "0";
              el.style.width = "100%";
            });
        });
      }
      if (2 === str) {
        this.$nextTick(() => {
          document
            .querySelectorAll(".index-aside .index-aside-inner")
            .forEach((el) => {
              el.style.paddingTop = "60px";
            });
        });
      }
    },
    setMenulistStyleHeightChange() {
      return;
      this.$nextTick(() => {
        document
          .querySelectorAll(".menulist-item>.el-menu--horizontal>.el-menu-item")
          .forEach((el) => {
            el.style.height = "60px";
            el.style.lineHeight = "60px";
          });
        document
          .querySelectorAll(
            ".menulist-item>.el-menu--horizontal>.el-submenu>.el-submenu__title"
          )
          .forEach((el) => {
            el.style.height = "60px";
            el.style.lineHeight = "60px";
          });
      });
    },
  },
};
</script>
<style lang="scss" scoped>
.el-container {
  display: block;
}
.index-aside {
  position: relative;
  overflow: hidden;
  display: flex;
  flex-wrap: wrap;

  .menulistImg {
    font-size: 0;
    box-sizing: border-box;
    text-align: left;

    .el-image {
      margin: 10px;
      width: 50px;
      height: auto;
      border-radius: 100%;
      box-shadow: 0 0 6px rgba(0, 0, 0, 0);
    }
  }

  .index-aside-inner {
    height: 100%;
    margin-right: -17px;
    margin-bottom: -17px;
    overflow: scroll;
    overflow-x: hidden !important;
    padding-top: 60px;
    box-sizing: border-box;

    &:focus {
      outline: none;
    }

    & /deep/ .el-menu {
      border: 0;
      background-color: transparent;
    }
  }

  .index-aside .index-aside-inner.menulist {
    height: 100% !important;
  }
  .menulist-item {
    width: 250px;
    padding: 15px 20px;
    margin: 0;
    border-radius: 0;
    border-width: 0 !important;
    border-style: solid !important;
    border-color: rgba(232, 18, 18, 0.3) !important;
    background: rgb(0, 79, 145) !important;
    box-shadow: 0 0 6px rgba(30, 144, 255, 0.2);
    box-sizing: border-box;
  }
  .el-menu-demo {
    box-sizing: border-box;
    min-height: calc(100vh - 60px);

    & > .el-menu-item {
      width: auto;
      height: auto !important;
      line-height: 34px !important; //首页1高度
      padding: 10px 22px 10px 10px; //上右下左菜单间距
      margin: 0 10px 0 0;
      color: rgb(200, 242, 248); //首页1颜色
      font-size: 16px;
      border-radius: 0px;
      border-width: 0;
      border-style: solid;
      border-color: #ffffff !important;
      background-color: rgb(0, 79, 145) !important;
      box-shadow: 0 0 0px rgba(255, 255, 255, 0);
      box-sizing: initial;
      display: flex;
      align-items: center;
      justify-content: flex-start;
      box-sizing: border-box;

      .el-icon-menu {
        margin: 0 5px 0 0;
        padding: 0;
        width: 24px;
        line-height: 24px;
        color: rgb(222, 251, 220); //图标颜色
        font-size: 16px;
        border-radius: 0;
        border-width: 0;
        border-style: solid;
        border-color: #fff;
        background-color: rgba(255, 255, 255, 0);
        box-shadow: 0 0 6px rgba(255, 255, 255, 0);
      }
    }

    .el-submenu {
      margin: 0 10px 0 0;
    }

    & /deep/ .el-submenu__title {
      width: auto;
      height: auto !important;
      line-height: 34px !important;
      padding: 10px 22px 10px 10px;
      color: rgb(248, 246, 253); //除了首页1之外父选项的颜色
      font-size: 14px;
      border-radius: 0px;
      border-width: 0;
      border-style: solid;
      border-color: #fff !important;
      background-color: rgb(0, 79, 145) !important;
      box-shadow: 0 0 0px rgba(255, 255, 255, 0);
      box-sizing: initial;
      display: flex;
      align-items: center;
      justify-content: flex-start;
      box-sizing: border-box;

      .el-icon-menu {
        margin: 0 5px 0 0;
        padding: 0;
        width: 24px;
        line-height: 24px;
        color: rgb(216, 211, 250);
        font-size: 16px;
        border-radius: 0;
        border-width: 0;
        border-style: solid;
        border-color: #fff;
        background-color: rgb(0, 79, 145);
        box-shadow: 0 0 6px rgba(255, 255, 255, 0);
      }

      .el-submenu__icon-arrow {
        margin: 0 10px 0 0;
        padding: 0;
        width: 12px;
        line-height: 12px;
        color: rgba(191, 191, 191, 1) !important;
        font-size: 12px;
        border-radius: 0;
        border-width: 0;
        border-style: solid;
        border-color: #fff;
        background-color: rgba(255, 255, 255, 0);
        box-shadow: 0 0 6px rgba(255, 255, 255, 0);
        position: absolute;
        top: 50%;
        right: 0;
        transform: translateY(-50%);
        text-align: center;
        display: block;
      }
    }

    & /deep/ .el-menu.el-menu--inline {
      width: auto;
      height: auto;
      padding: 0;
      margin: 0;
      border-radius: 4px;
      border-width: 0;
      border-style: solid;
      border-color: rgba(0, 0, 0, 0.3);
      background-color: #fff;
      box-shadow: 0 0 0px rgba(0, 0, 0, 0.3);

      .el-menu-item {
        width: 100%;
        height: 44px;
        line-height: 44px;
        padding: 0 0 0 40px !important;
        margin: 0;
        color: rgba(255, 255, 255, 1) !important;
        font-size: 14px;
        border-radius: 0;
        border-width: 0;
        border-style: solid;
        border-color: rgba(0, 0, 0, 0);
        background-color: rgb(0, 79, 145) !important;
        box-shadow: 0 0 6px rgba(30, 144, 255, 0);
        text-align: left;
        min-width: auto;

        &.is-active {
          width: 100%;
          height: 44px;
          line-height: 44px;
          padding: 0 !important;
          margin: 0;
          color: rgba(255, 255, 255, 1) !important;
          font-size: 14px;
          border-radius: 0;
          border-width: 0;
          border-style: solid;
          border-color: rgba(0, 0, 0, 0);
          background-color: rgba(221, 221, 221, 1) !important;
          box-shadow: 0 0 6px rgba(30, 144, 255, 0);
          text-align: center;
        }

        &:hover {
          width: 100%;
          height: 44px;
          line-height: 44px;
          padding: 0 0 0 40px !important;
          margin: 0;
          color: rgba(0, 0, 0, 1) !important;
          font-size: 14px;
          border-radius: 0;
          border-width: 0;
          border-style: solid;
          border-color: rgba(0, 0, 0, 0);
          background-color: rgba(221, 221, 221, 1) !important;
          box-shadow: 0 0 6px rgba(30, 144, 255, 0);
          text-align: left;
        }
      }
    }
  }
}
</style>
<style>
.el-menu--horizontal .el-menu--popup {
  width: auto;
  height: auto;
  padding: 0;
  margin: 0;
  border-radius: 4px;
  border-width: 0;
  border-style: solid;
  border-color: rgba(0, 0, 0, 0.3);
  background-color: #fff;
  box-shadow: 0 0 0px rgba(0, 0, 0, 0.3);
  min-width: auto;
}
.el-menu--horizontal .el-menu--popup .el-menu-item {
  width: 100%;
  height: 44px;
  line-height: 44px;
  padding: 0 0 0 40px;
  margin: 0;
  color: rgba(255, 255, 255, 1) !important;
  font-size: 14px;
  border-radius: 0;
  border-width: 0;
  border-style: solid;
  border-color: rgba(0, 0, 0, 0);
  background-color: rgb(0,79,145) !important;
  box-shadow: 0 0 6px rgba(30, 144, 255, 0);
  text-align: left;
  min-width: auto;
}
.el-menu--horizontal .el-menu--popup .el-menu-item:hover {
  width: 100%;
  height: 44px;
  line-height: 44px;
  padding: 0 0 0 40px;
  margin: 0;
  color: rgba(0, 0, 0, 1) !important;
  font-size: 14px;
  border-radius: 0;
  border-width: 0;
  border-style: solid;
  border-color: rgba(0, 0, 0, 0);
  background-color: rgba(221, 221, 221, 1) !important;
  box-shadow: 0 0 6px rgba(30, 144, 255, 0);
  text-align: left;
}
</style>
