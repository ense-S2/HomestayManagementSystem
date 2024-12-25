<template>
  <div class="main-content">
    <!-- 列表页 -->
    <el-form :inline="true" :model="searchForm" class="form-content">
      <el-row
        :gutter="20"
        class="slt"
        :style="{
          justifyContent:
            contents.searchBoxPosition == '1'
              ? 'flex-start'
              : contents.searchBoxPosition == '2'
              ? 'center'
              : 'flex-end',
        }"
      >
        <el-form-item :label="contents.inputTitle == 1 ? '起始时间' : ''">
          <el-date-picker
            v-if="contents.inputIcon == 1 && contents.inputIconPosition == 1"
            prefix-icon="el-icon-time"
            v-model="searchForm.startTime"
            placeholder="选择起始时间"
            value-format="yyyy-MM-dd HH:mm:ss"
            clearable
          ></el-date-picker>
          <el-date-picker
            v-if="contents.inputIcon == 1 && contents.inputIconPosition == 2"
            suffix-icon="el-icon-time"
            v-model="searchForm.startTime"
            placeholder="选择起始时间"
            value-format="yyyy-MM-dd HH:mm:ss"
            clearable
          ></el-date-picker>
          <el-date-picker
            v-if="contents.inputIcon == 0"
            v-model="searchForm.startTime"
            placeholder="选择起始时间"
            value-format="yyyy-MM-dd HH:mm:ss"
            clearable
          ></el-date-picker>
        </el-form-item>
        <el-form-item :label="contents.inputTitle == 1 ? '截止时间' : ''">
          <el-date-picker
            v-if="contents.inputIcon == 1 && contents.inputIconPosition == 1"
            prefix-icon="el-icon-time"
            v-model="searchForm.endTime"
            placeholder="选择截止时间"
            value-format="yyyy-MM-dd HH:mm:ss"
            clearable
          ></el-date-picker>
          <el-date-picker
            v-if="contents.inputIcon == 1 && contents.inputIconPosition == 2"
            suffix-icon="el-icon-time"
            v-model="searchForm.endTime"
            placeholder="选择截止时间"
            value-format="yyyy-MM-dd HH:mm:ss"
            clearable
          ></el-date-picker>
          <el-date-picker
            v-if="contents.inputIcon == 0"
            v-model="searchForm.endTime"
            placeholder="选择截止时间"
            value-format="yyyy-MM-dd HH:mm:ss"
            clearable
          ></el-date-picker>
        </el-form-item>
        <el-form-item>
          <el-button
            v-if="
              contents.searchBtnIcon == 1 &&
              contents.searchBtnIconPosition == 1
            "
            icon="el-icon-search"
            type="success"
            :style="{
              height: contents.searchBtnHeight,
              color: contents.searchBtnFontColor,
              fontSize: contents.searchBtnFontSize,
              borderWidth: contents.searchBtnBorderWidth,
              borderStyle: contents.searchBtnBorderStyle,
              borderColor: contents.searchBtnBorderColor,
              borderRadius: contents.searchBtnBorderRadius,
              backgroundColor: contents.searchBtnBgColor,
            }"
            @click="search()"
          >{{ contents.searchBtnFont == 1 ? "查询" : "" }}</el-button>
          <el-button
            v-if="
              contents.searchBtnIcon == 1 &&
              contents.searchBtnIconPosition == 2
            "
            type="success"
            :style="{
              height: contents.searchBtnHeight,
              color: contents.searchBtnFontColor,
              fontSize: contents.searchBtnFontSize,
              borderWidth: contents.searchBtnBorderWidth,
              borderStyle: contents.searchBtnBorderStyle,
              borderColor: contents.searchBtnBorderColor,
              borderRadius: contents.searchBtnBorderRadius,
              backgroundColor: contents.searchBtnBgColor,
            }"
            @click="search()"
          >
            {{ contents.searchBtnFont == 1 ? "查询" : "" }}
            <i class="el-icon-search el-icon--right" />
          </el-button>
          <el-button
            v-if="contents.searchBtnIcon == 0"
            type="success"
            :style="{
              height: contents.searchBtnHeight,
              color: contents.searchBtnFontColor,
              fontSize: contents.searchBtnFontSize,
              borderWidth: contents.searchBtnBorderWidth,
              borderStyle: contents.searchBtnBorderStyle,
              borderColor: contents.searchBtnBorderColor,
              borderRadius: contents.searchBtnBorderRadius,
              backgroundColor: contents.searchBtnBgColor,
            }"
            @click="search()"
          >{{ contents.searchBtnFont == 1 ? "查询" : "" }}</el-button>
        </el-form-item>
      </el-row>
    </el-form>
    <!-- 数据展示部分 -->
    <div>
      <el-tabs v-model="activeTab" @tab-click="tabChange">
        <el-tab-pane label="柱状图" name="bar">
          <div ref="barChart" style="height: 400px;"></div>
        </el-tab-pane>
        <el-tab-pane label="饼状图" name="pie">
          <div ref="pieChart" style="height: 400px;"></div>
        </el-tab-pane>
        <el-tab-pane label="折线图" name="line">
          <div ref="lineChart" style="height: 400px;"></div>
        </el-tab-pane>
      </el-tabs>
    </div>
    <!-- 销售记录表 -->
    <div class="table-content tables">
      <el-table
        :data="displayedData"
        border
        style="width: 100%"
        v-loading="tableLoading"
      >
        <el-table-column prop="kefangbianhao" label="客房编号" />
        <el-table-column prop="kefangleixing" label="客房类型" />
        <el-table-column prop="xiaoshoue" label="销售额" />
        <el-table-column prop="ruzhushijian" label="入住时间" />
      </el-table>

      <!-- 分页器 -->
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handlePageChange"
        :current-page="currentPage"
        :page-size="pageSize"
        :page-sizes="[5, 10, 20, 50]"
        :total="totalData"
        background
        layout="total, sizes, prev, pager, next, jumper"
        class="pagination"
      />
    </div>
  </div>
</template>

<script>
import * as echarts from "echarts";
import { fetchSalesData } from "@/utils/sales";

export default {
  data() {
    return {
      searchForm: {
        startTime: "",
        endTime: "",
      },
      activeTab: "bar",
      salesData: [], // 原始数据
      displayedData: [], // 当前页展示的数据
      tableLoading: false,
      currentPage: 1, // 当前页码
      pageSize: 10, // 每页显示条数
      totalData: 0, // 总数据量
      contents: {
        searchBoxPosition: "1",
        searchBtnFont: "1",
        searchBtnIcon: "1",
        searchBtnIconPosition: "1",
        inputIcon: "1",
        inputIconPosition: "1",
        inputTitle: "1",
        searchBtnHeight: "40px",
        searchBtnFontColor: "#333",
        searchBtnFontSize: "14px",
        searchBtnBorderWidth: "1px",
        searchBtnBorderStyle: "solid",
        searchBtnBorderColor: "#DCDFE6",
        searchBtnBorderRadius: "4px",
        searchBtnBgColor: "#fff",
      },
    };
  },
  methods: {
    async search() {
      if (!this.searchForm.startTime || !this.searchForm.endTime) {
        this.$message.warning("请选择时间范围！");
        return;
      }
      this.tableLoading = true;
      try {
        const { salesStats } = await fetchSalesData({
          startTime: this.searchForm.startTime,
          endTime: this.searchForm.endTime,
        });

        // 表格数据：直接赋值
        this.salesData = Object.entries(salesStats).map(([key, value]) => ({
          kefangbianhao: value.kefangbianhao,
          kefangleixing: value.kefangleixing,
          xiaoshoue: value.salesAmount,
          ruzhushijian: value.ruzhushijian,
          xiaoshouCount: 1,
        }));

        // 数据加工：按客房编号统计销售额总和和订单数
        const chartDataMap = {};
        this.salesData.forEach((item) => {
          const { kefangbianhao, xiaoshoue } = item;
          if (!chartDataMap[kefangbianhao]) {
            chartDataMap[kefangbianhao] = {
              kefangbianhao,
              salesAmount: 0,
              salesCount: 0,
            };
          }
          chartDataMap[kefangbianhao].salesAmount += xiaoshoue;
          chartDataMap[kefangbianhao].salesCount += 1;
        });
        this.chartData = Object.values(chartDataMap); // 加工后的数据用于图表

        // 分页相关
        this.totalData = this.salesData.length; // 数据总数
        this.updateDisplayedData(); // 初始化当前页数据

        // 渲染图表
        this.renderCurrentTab();
      } catch (error) {
        console.error("数据加载失败:", error.message);
        this.$message.error("数据加载失败，请稍后重试！");
      } finally {
        this.tableLoading = false;
      }
    },

    renderCurrentTab() {
      if (this.activeTab === "bar") this.renderBarChart();
      if (this.activeTab === "pie") this.renderPieChart();
      if (this.activeTab === "line") this.renderLineChart();
    },

    renderBarChart() {
      const chart = echarts.init(this.$refs.barChart);

      // 图表使用 chartData
      const sortedData = [...this.chartData].sort((a, b) => {
        return parseInt(a.kefangbianhao.match(/\d+/)) - parseInt(b.kefangbianhao.match(/\d+/));
      });

      const xData = sortedData.map((item) => item.kefangbianhao);
      const yData = sortedData.map((item) => item.salesAmount);

      chart.setOption({
        color: ['#2c64bd'],
        title: {
          text: '客房销售额统计',
          left: 'center',
          textStyle: { fontSize: 16 },
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: { type: 'shadow' },
        },
        xAxis: {
          type: 'category',
          data: xData,
          name: '客房编号',
          nameLocation: 'middle',
          nameTextStyle: { padding: 20 },
        },
        yAxis: {
          type: 'value',
          name: '销售额',
          nameTextStyle: { padding: 10 },
        },
        series: [
          {
            type: 'bar',
            data: yData,
            barWidth: 50,
          },
        ],
      });
    },

    renderPieChart() {
      // 初始化图表实例
      const chart = echarts.getInstanceByDom(this.$refs.pieChart) || echarts.init(this.$refs.pieChart);

      // 处理数据
      const data = this.chartData.map((item) => ({
          name: item.kefangbianhao,
          value: item.salesAmount,
      }));

      // 设置选项
      chart.setOption({
          title: {
              text: '各客房销售额占比', // 设置标题
              left: 'center', // 标题居中
              textStyle: {
                  fontSize: 16, // 标题字体大小
                  color: '#333', // 标题颜色
              },
          },
          tooltip: {
              trigger: 'item', // 提示框触发方式
              formatter: '{a} <br/>{b}: {c} ({d}%)', // 提示框格式
          },
          color: ['#2c64bd', '#516a93', '#6993d5', '#2a91d5', '#4db5a9', '#fff', '#e0b388'], 
          series: [
              {
                  name: '销售额占比', // 图例名称
                  type: 'pie', // 设置为饼状图
                  radius: '50%', // 饼图半径
                  data: data, // 数据
                  label: {
                      formatter: '{b}: {d}%', // 标签显示格式
                      color: '#333', // 标签文字颜色
                  },
              },
          ],
      });
    },

    renderLineChart() {
      // 初始化图表实例
      const chart = echarts.getInstanceByDom(this.$refs.lineChart) || echarts.init(this.$refs.lineChart);

      // 按客房编号分类并提取时间和订单数量数据
      const groupedData = {};
      const totalOrdersByDate = {}; // 用于记录每个时间点的总订单数量

      this.salesData.forEach((item) => {
          const { kefangbianhao, ruzhushijian } = item;
          const date = new Date(ruzhushijian).toISOString().split('T')[0]; // 格式化为日期
          if (!groupedData[kefangbianhao]) {
              groupedData[kefangbianhao] = {};
          }
          if (!groupedData[kefangbianhao][date]) {
              groupedData[kefangbianhao][date] = 0;
          }
          groupedData[kefangbianhao][date] += 1; // 累计同一天的订单数量

          // 累计总订单数量
          if (!totalOrdersByDate[date]) {
              totalOrdersByDate[date] = 0;
          }
          totalOrdersByDate[date] += 1;
      });

      // 提取所有的时间点（横坐标）
      const allDates = Array.from(
          new Set(
              this.salesData.map((item) => new Date(item.ruzhushijian).toISOString().split('T')[0])
          )
      ).sort(); // 按时间排序

      // 构建系列数据
      const series = Object.entries(groupedData)
          .sort(([a], [b]) => a.localeCompare(b)) // 按客房编号升序排列
          .map(([kefangbianhao, salesByDate]) => {
              const data = allDates.map((date) => salesByDate[date] || 0); // 对每个日期填充订单数量，缺失补零
              return {
                  name: kefangbianhao, // 图例名称
                  type: 'line', // 折线图
                  data, // 对应时间点的订单数量数据
                  smooth: true, // 曲线平滑
              };
          });

      // 添加总订单数量的线
      const totalOrdersData = allDates.map((date) => totalOrdersByDate[date] || 0);
      series.push({
          name: '总订单数量',
          type: 'line',
          data: totalOrdersData,
          smooth: true,
          lineStyle: {
              color: '#E87F9D',
              width: 2, // 设置线宽
          },
          itemStyle: {
              color: '#e2d7cf', // 设置点颜色
          },
      });

      // 配置图表
      chart.setOption({
          title: {
              text: '各客房类型订单数量变化趋势',
              left: 'center',
              textStyle: {
                  fontSize: 16,
              },
          },
          tooltip: {
              trigger: 'axis',
              axisPointer: {
                  type: 'line', // 指示器为线
              },
          },
          legend: {
              data: [...Object.keys(groupedData).sort(), '总订单数量'], // 图例内容为客房编号（升序）和总订单数量
              top: '10%',
          },
          color: ['#9bacc7', '#254e7a', '#F9D3E3', '#95D3D2', '#2c64bd', '#FDDB76', '#E87F9D'], // 图例颜色
          xAxis: {
              type: 'category',
              data: allDates, // 时间轴
              name: '时间',
              nameLocation: 'end',
              nameTextStyle: { padding: 20 },
              axisLabel: {
                  rotate: 45, // 标签旋转 45 度
                  margin: 20,
              },
          },
          yAxis: {
              type: 'value',
              name: '订单数量', // 修改纵坐标为订单数量
              nameTextStyle: { padding: 10 },
          },
          dataZoom: [
              {
                  type: 'slider', // 滑动条
                  show: true,
                  xAxisIndex: 0, // 针对第一个 x 轴
                  start: 0, // 数据窗口范围的起始百分比
                  end: 100, // 数据窗口范围的结束百分比
                  height: 10,
                  bottom: 70,
              },
              {
                  type: 'inside', // 内部缩放
                  xAxisIndex: 0,
                  start: 0,
                  end: 50,
              },
          ],
          grid: {
            bottom: 80, // 增加底部留白以避免重叠
         },
          series, // 各客房类型的订单数量数据
      });
    },

    updateDisplayedData() {
      const start = (this.currentPage - 1) * this.pageSize;
      const end = start + this.pageSize;
      this.displayedData = this.salesData.slice(start, end);
    },

    handlePageChange(page) {
      this.currentPage = page;
      this.updateDisplayedData();
    },

    handleSizeChange(size) {
      this.pageSize = size;
      this.updateDisplayedData();
    },

    tabChange(tab) {
      if (!this.chartData.length) {
          this.$message.warning("请先查询数据！");
          return;
      }
      setTimeout(() => {
          if (tab.name === "bar") this.renderBarChart();
          if (tab.name === "pie") this.renderPieChart();
          if (tab.name === "line") this.renderLineChart();
      }, 0); // 确保 DOM 渲染完成
    },
  },
};
</script>

<style scoped>
.main-content,
.form-content {
  background-color: transparent !important; /* 设置为透明背景 */
}

.slt {
  margin: 0 !important;
  display: flex;
}

.el-form-item .el-input__inner,
.el-form-item .el-date-editor {
  height: 40px;
  border-radius: 4px;
}
</style>