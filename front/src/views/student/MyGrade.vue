<template>
  <el-container
    v-loading="loadingCertificate"
    element-loading-text="拼命加载证书中"
    element-loading-spinner="el-icon-loading">
    <el-header height="210">
      <!--操作的下拉框-->
      <el-select @change="operation" clearable v-model="queryInfo.examId"
                 placeholder="Please select the test" style="margin-bottom: 25px;">
        <el-option v-for="(item,index) in allExamInfo" :key="index" :label="item.examName"
                   :value="parseInt(item.examId)">
          <span style="float: left">{{ item.examName }}</span>
        </el-option>
      </el-select>

    </el-header>

    <el-main>
      <el-table
        ref="questionTable"
        highlight-current-row
        v-loading="loading"
        :border="true"
        :data="grade"
        tooltip-effect="dark"
        style="width: 100%;">

        <el-table-column align="center" prop="examName" label="Examination title"></el-table-column>
        <el-table-column align="center" prop="examTime" label="Examination time"></el-table-column>
        <el-table-column align="center" prop="logicScore" label="Logical score"></el-table-column>
        <el-table-column align="center" prop="passScore" label="Pass line"></el-table-column>
        <el-table-column align="center" label="Total score">
          <template slot-scope="scope">
            {{ scope.row.totalScore === null ? 'Not yet reviewed' : scope.row.totalScore }}
          </template>
        </el-table-column>

        <el-table-column align="center" label="Pass or not">
          <template slot-scope="scope">

            <div v-if="isOrNotPassExam(scope.row)">
              <span style="color: limegreen">Pass</span>
            </div>

            <span v-if="!isOrNotPassExam(scope.row)" style="color: red">Not passed</span>
          </template>
        </el-table-column>

        <el-table-column align="center" label="Operation">
          <template slot-scope="scope">
            <el-button round size="small" type="primary" icon="el-icon-info"
                       @click="$router.push('/examResult/'+scope.row.recordId)">Detail
            </el-button>
            <el-button round size="small" type="danger" icon="el-icon-error" @click="showErrorQuestion(scope.row)">Mistakes
            </el-button>
          </template>
        </el-table-column>
      </el-table>

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

    <el-dialog title="Detail" center :visible.sync="errorQuestionDialog">
      <el-card>
        <!--题目信息-->
        <div v-for="(item,index) in questionInfo" :key="index" style="margin-top: 15px">
          <div>
            <i class="num">{{ index + 1 }}</i>
            <span v-if="item.questionType === 1">【Single choice】</span>
            <span v-else-if="item.questionType === 2">【Multiple choice】</span>
            <span v-else-if="item.questionType === 3">【True or false】</span>
            <span>{{ item.questionContent }}</span>
          </div>
          <!--题目中的配图-->
          <img v-for="url in item.images" :src="url" title="点击查看大图" alt="目图片"
               style="width: 100px;height: 100px;cursor: pointer" @click="showBigImg(url)">

          <!--单选 和 判断 的答案列表-->
          <div style="margin-top: 25px"
               v-show="item.questionType === 1 || item.questionType === 3">
            <div class="el-radio-group">
              <label v-for="(i2,index2) in item.answer"
                     :class="String(index2) === userAnswer[index] && i2.isTrue === 'true' ?
                      'activeAndTrue' : String(index2) === userAnswer[index] ? 'active' :
                       i2.isTrue === 'true' ? 'true' : ''">
                <span>{{ optionName[index2] + '、' + i2.answer }}</span>
                <img style="position: absolute;left:100%;top:50%;transform: translateY(-50%);
                  width: 40px;height: 40px;float: right;cursor: pointer;" title="点击查看大图"
                     v-if="i2.images !== null"
                     v-for="i3 in i2.images" :src="i3" alt="" @mouseover="showBigImg(i3)">
              </label>
            </div>
          </div>

          <!--多选的答案列表-->
          <div style="margin-top: 25px" v-show="item.questionType === 2">
            <div class="el-radio-group">
              <label v-for="(i2,index2) in item.answer"
                     :class="(userAnswer[index]+'').indexOf(index2+'') !== -1 && i2.isTrue === 'true'
                     ? 'activeAndTrue' : (userAnswer[index]+'').indexOf(index2+'') !== -1 ? 'active' :
                       i2.isTrue === 'true' ? 'true' : ''">
                <span>{{ optionName[index] + '、' + i2.answer }}</span>
                <img style="position: absolute;left:100%;top:50%;transform: translateY(-50%);
                  width: 40px;height: 40px;float: right;cursor: pointer;" title="点击查看大图"
                     v-if="i2.images !== null"
                     v-for="i3 in i2.images" :src="i3" alt="" @mouseover="showBigImg(i3)">
              </label>
            </div>
          </div>

        </div>

      </el-card>
      <div slot="footer" class="dialog-footer">
        <el-button @click="errorQuestionDialog = false">取 消</el-button>
        <el-button type="primary" @click="errorQuestionDialog = false">确 定</el-button>
      </div>
    </el-dialog>
    <!--图片回显-->
    <el-dialog :visible.sync="bigImgDialog" @close="bigImgDialog = false">
      <img style="width: 100%" :src="bigImgUrl">
    </el-dialog>
  </el-container>
</template>

<script>
import grade from '@/api/grade'
import exam from '@/api/exam'
import question from '@/api/question'
import constants from '@/utils/constants'

export default {
  name: 'MyGrade',
  data() {
    return {
      queryInfo: {
        pageNo: 1,
        pageSize: 10,
        username: localStorage.getItem('username')
      },
      //我的成绩
      grade: [],
      //所有的考试信息
      allExamInfo: [],
      //成绩总数
      total: 0,
      //表格数据加载
      loading: true,
      //错题的详细信息
      errorQuestionDialog: false,
      //当前考试的题目
      questionInfo: [],
      //当前用户的答案
      userAnswer: [],
      //答案的选项名abcd数据
      optionName: ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'],
      //大图的对话图片地址
      bigImgUrl: '',
      bigImgDialog: false,
      //加载证书的数据加载动画
      loadingCertificate: false
    }
  },
  created() {
    this.getMyGrade()
  },
  methods: {
    getMyGrade() {
      grade.getMyGrade(this.queryInfo).then((resp) => {
        if (resp.code === 200) {
          this.grade = resp.data.data
          this.total = resp.data.total
          this.getAllExamInfo()
          this.loading = false
        }
      })
    },
    setExamName() {
      this.grade.forEach(item => {
        this.allExamInfo.forEach(i2 => {
          if (item.examId === i2.examId) {
            this.$set(item, 'examName', i2.examName)
            this.$set(item, 'passScore', i2.passScore)
          }
        })
        if (!item.examName) {
          this.$set(item, 'examName', constants.defaultExamName)
        }
      })
    },
    getAllExamInfo() {
      exam.allExamInfo().then((resp) => {
        if (resp.code === 200) {
          this.allExamInfo = resp.data
          this.setExamName()
        }
      })
    },
    operation(v) {
      if (v === '') this.queryInfo.examId = null
      this.getMyGrade()
    },
    //分页页面大小改变
    handleSizeChange(val) {
      this.queryInfo.pageSize = val
      this.getMyGrade()
    },
    //分页插件的页数
    handleCurrentChange(val) {
      this.queryInfo.pageNo = val
      this.getMyGrade()
    },
    //根据ids查询题目信息
    async getQuestionInfoByIds(questionIds) {
      await question.getQuestionByIds({ids: questionIds}).then((resp) => {
        if (resp.code === 200) {
          this.questionInfo = resp?.data?.data || []
          //重置问题的顺序 单选 多选 判断 简答
          this.questionInfo = this.questionInfo.sort(function (a, b) {
            return a.questionType - b.questionType
          })
        }
      })
    },
    showErrorQuestion(row) {
      if (row.errorQuestionIds === null) {
        this.$message.warning('当前考试没有逻辑错题O(∩_∩)O~')
      } else {
        this.userAnswer = row.userAnswers.split('-')
        this.getQuestionInfoByIds(row.errorQuestionIds)
        this.errorQuestionDialog = true
      }
    },
    //点击展示高清大图
    showBigImg(url) {
      this.bigImgUrl = url
      this.bigImgDialog = true
    },
    // 获取专属证书
    getCertificate(recordId, examName) {
      this.loadingCertificate = true
      grade.getCertificate({
        'examRecordId': recordId,
        'examName': examName
      }).then(res => {
        const binaryData = []
        binaryData.push(res)
        //获取blob链接
        this.pdfUrl = window.URL.createObjectURL(new Blob(binaryData, {type: 'application/pdf'}))
        // 证书创建完毕,动画结束
        this.loadingCertificate = false
        window.open(this.pdfUrl)
      }).catch((res) => {
        this.$notify({
          title: 'Tips',
          message: '证书获取失败,请稍后再试',
          type: 'error',
          duration: 2000
        })
        this.loadingCertificate = false
      })
    }
  },
  computed: {
    //是否通过考试
    isOrNotPassExam(row) {
      return (row) => {
        let flag = false
        this.allExamInfo.forEach(item => {
          if (item.examId === row.examId) {
            flag = row.totalScore >= item.passScore
          }
        })
        return flag
      }
    }
  }
}
</script>

<style scoped lang="scss">
@import "../../assets/css/student/myGrade";
</style>
