package com.wzz.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.wzz.entity.ExamQuestion;

/**
 *
 *  9:04
 */
public interface ExamQuestionService extends IService<ExamQuestion> {

    ExamQuestion getExamQuestionByExamId(Integer examId);

}
