<template>
  <el-container>
    <el-header height="220">
      <el-select @change="typeChange" clearable v-model="queryInfo.examType" placeholder="select exam type">
        <el-option
          v-for="item in examType"
          :key="item.type"
          :label="item.info"
          :value="item.type">
        </el-option>
      </el-select>

      <el-input v-model="queryInfo.examName" placeholder="exam name" @blur="getExamInfo"
                style="margin-left: 5px;width: 220px"
                prefix-icon="el-icon-search"></el-input>
    </el-header>

    <el-main>

      <el-table
        ref="questionTable"
        highlight-current-row
        v-loading="loading"
        :border="true"
        :data="examInfo"
        tooltip-effect="dark"
        style="width: 100%;">

        <el-table-column align="center" label="exam name">
          <template slot-scope="scope">
            {{ scope.row.examName }}
          </template>
        </el-table-column>

        <el-table-column align="center" label="exam type">
          <template slot-scope="scope">
            {{ scope.row.type === 1 ? 'public' : 'need password' }}
          </template>
        </el-table-column>

        <el-table-column align="center" label="exam time">
          <template slot-scope="scope">
            {{
              scope.row.startTime !== 'null' && scope.row.endTime !== 'null' ?
                scope.row.startTime + ' ~' + scope.row.endTime : '不限时'
            }}
          </template>
        </el-table-column>

        <el-table-column align="center" label="exam length">
          <template slot-scope="scope">
            {{ scope.row.duration + 'mins' }}
          </template>
        </el-table-column>

        <el-table-column align="center" prop="totalScore" label="total score"></el-table-column>

        <el-table-column align="center" prop="passScore" label="passing score"></el-table-column>

        <el-table-column align="center" label="operate">
          <template slot-scope="scope">
            <el-button size="small" :disabled="!checkExam(scope.row)" @click="toStartExam(scope.row)"
                       :icon="checkExam(scope.row) ? 'el-icon-caret-right' : 'el-icon-close'"
                       :type="checkExam(scope.row) ? 'primary' : 'info'">
              {{ checkExam(scope.row) ? 'to exam' : 'currently unavailable' }}
            </el-button>
          </template>
        </el-table-column>

      </el-table>

      <!--分页-->
      <el-pagination style="margin-top: 25px"
                     @size-change="handleSizeChange"
                     @current-change="handleCurrentChange"
                     :current-page="queryInfo.pageNo"
                     :page-sizes="[10, 20, 30, 50]"
                     :page-size="queryInfo.pageSize"
                     layout="total, sizes, prev, pager, next, jumper"
                     :total="total">
      </el-pagination>
    </el-main>
    <el-dialog
      title="exam tips"
      :visible.sync="startExamDialog" center
      width="50%">

      <el-alert
        title="Exam will begin after you click 'begin', please be honest!"
        type="error">
      </el-alert>

      <el-card style="margin-top: 25px">
        <span>exam name: </span>{{ currentSelectedExam.examName }}
        <br>
        <span>exam description: </span>{{ currentSelectedExam.examDesc }}
        <br>
        <span>exam length: </span>{{ currentSelectedExam.duration + 'mins' }}
        <br>
        <span>total score: </span>{{ currentSelectedExam.totalScore }}
        <br>
        <span>passing score: </span>{{ currentSelectedExam.passScore }}
        <br>
        <span>exam type: </span> {{ currentSelectedExam.type === 2 ? 'password required' : 'public' }}
        <br>
      </el-card>


      <span slot="footer" class="dialog-footer">
    <el-button @click="startExamDialog = false">return</el-button>
    <el-button type="primary" @click="$router.push('/exam/'+ currentSelectedExam.examId)">begin</el-button>
  </span>
    </el-dialog>
  </el-container>
</template>

<script>
import exam from '@/api/exam'

export default {
  name: 'ExamOnline',
  data () {
    return {
      queryInfo: {
        'examType': null,
        'startTime': null,
        'endTime': null,
        'examName': null,
        'pageNo': 0,
        'pageSize': 10
      },
      //表格是否在加载
      loading: true,
      //考试类型信息
      examType: [
        {
          info: '公开考试',
          type: 1
        },
        {
          info: '需要密码',
          type: 2
        }
      ],
      //考试信息
      examInfo: [],
      //查询到的考试总数
      total: 0,
      //开始考试的提示框
      startExamDialog: false,
      //当前选中的考试的信息
      currentSelectedExam: {}
    }
  },
  created () {
    this.getExamInfo()
  },
  methods: {
    //考试类型搜索
    typeChange (val) {
      this.queryInfo.examType = val
      this.getExamInfo()
    },
    //查询考试信息
    getExamInfo () {
      exam.getExamInfo(this.queryInfo).then((resp) => {
        if (resp.code === 200) {
          resp.data.data.forEach(item => {
            item.startTime = String(item.startTime).substring(0, 10)
            item.endTime = String(item.endTime).substring(0, 10)
          })
          this.examInfo = resp.data.data
          this.total = resp.data.total
          this.loading = false
        }
      })
    },
    //分页页面大小改变
    handleSizeChange (val) {
      this.queryInfo.pageSize = val
      this.getExamInfo()
    },
    //分页插件的页数
    handleCurrentChange (val) {
      this.queryInfo.pageNo = val
      this.getExamInfo()
    },
    //去考试准备页面
    toStartExam (row) {
      if (row.type === 2) {
        this.$prompt('please provide exam password', 'Tips', {
          confirmButtonText: 'confirm',
          cancelButtonText: 'cancel',
        }).then(({ value }) => {
          if (value === row.password) {
            this.startExamDialog = true
            this.currentSelectedExam = row
          } else {
            this.$message.error('password error o(╥﹏╥)o')
          }
        }).catch(() => {
        })
      } else {
        this.startExamDialog = true
        this.currentSelectedExam = row
      }
    }
  },
  computed: {
    //检查考试的合法性
    checkExam (row) {
      return (row) => {
        let date = new Date()
        if (row.status === 2) return false
        if (row.startTime === 'null' && row.endTime === 'null') {
          return true
        } else if (row.startTime === 'null') {
          return date < new Date(row.endTime)
        } else if (row.endTime === 'null') {
          return date > new Date(row.startTime)
        } else if (date > new Date(row.startTime) && date < new Date(row.endTime)) return true
      }
    }
  }
}
</script>

<style scoped lang="scss">
@import "../../assets/css/student/examOnline";
</style>
