/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Host           : localhost:3306
 Source Schema         : exam_system

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 03/04/2023 14:00:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer`  (
  `id` int(50) NOT NULL AUTO_INCREMENT COMMENT '答案表的主键',
  `all_option` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '当前题目所有答案的信息',
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '答案的图片路径',
  `analysis` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '答案解析',
  `question_id` int(50) NOT NULL COMMENT '对应题目的id',
  `true_option` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '正确的选项对应的下标',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `question_id`(`question_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of answer
-- ----------------------------
INSERT INTO `answer` VALUES (1, '1,2', 'https://wangsiryun.oss-cn-beijing.aliyuncs.com/images/upload/2020-10-26/b1535亚索锐雯.jpg', '1', 5, '0');
INSERT INTO `answer` VALUES (3, '语文,数学,英语,选修课', ',', NULL, 6, '0,1,2');
INSERT INTO `answer` VALUES (10, '0,1', '', '111', 11, '0');
INSERT INTO `answer` VALUES (11, '11,16', '', '16', 12, '1');
INSERT INTO `answer` VALUES (12, '9,8', '', '9', 13, '0');
INSERT INTO `answer` VALUES (13, '4,3', 'https://wangsiryun.oss-cn-beijing.aliyuncs.com/images/upload/2020-10-27/1950327D.jpg', '4', 14, '0');
INSERT INTO `answer` VALUES (14, '18,11', 'https://wangsiryun.oss-cn-beijing.aliyuncs.com/images/upload/2020-10-27/583a91522134986336591.jpg', '18', 15, '0');
INSERT INTO `answer` VALUES (15, '1', '', '1', 16, '0');
INSERT INTO `answer` VALUES (16, '4,3', '', '4', 17, '0');
INSERT INTO `answer` VALUES (17, '1,2,3,4', ',,,', NULL, 18, '0,1');
INSERT INTO `answer` VALUES (18, '奇数,偶数', '', '奇数', 19, '0');
INSERT INTO `answer` VALUES (19, '奇数,偶数', '', '奇数', 20, '0');
INSERT INTO `answer` VALUES (20, '111,222,333', '', NULL, 21, '0,1,2');
INSERT INTO `answer` VALUES (21, '1', '', '1', 22, '0');
INSERT INTO `answer` VALUES (22, '', '', '', 23, '0');

-- ----------------------------
-- Table structure for exam
-- ----------------------------
DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam`  (
  `exam_id` int(50) NOT NULL AUTO_INCREMENT,
  `exam_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '考试名称',
  `exam_desc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '考试描述',
  `type` int(15) NOT NULL DEFAULT 1 COMMENT '1完全公开  2需要密码',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '需要密码考试的密码',
  `duration` int(50) NOT NULL COMMENT '考试时长',
  `start_time` date NULL DEFAULT NULL COMMENT '考试开始时间',
  `end_time` date NULL DEFAULT NULL COMMENT '考试结束时间',
  `total_score` int(30) NOT NULL COMMENT '考试总分',
  `pass_score` int(30) NOT NULL COMMENT '考试通过线',
  `status` int(15) NOT NULL DEFAULT 1 COMMENT '1有效 2无效',
  PRIMARY KEY (`exam_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exam
-- ----------------------------
INSERT INTO `exam` VALUES (9, '小学入学考试', '对小学生做一个评估', 1, NULL, 1, '2023-04-01', '2023-11-01', 10, 6, 1);
INSERT INTO `exam` VALUES (10, '多选题练习考试', '滴滴', 1, NULL, 1, '2023-04-01', '2023-11-01', 2, 1, 1);
INSERT INTO `exam` VALUES (11, '测试123', '2113', 1, '12345', 1, '2023-04-01', '2023-11-01', 1, 1, 1);
INSERT INTO `exam` VALUES (12, '全能考试', '啥都考', 1, NULL, 4, '2023-04-01', '2023-11-01', 12, 7, 1);
INSERT INTO `exam` VALUES (13, '过期的考试', '测试过期', 1, NULL, 1, '2023-04-01', '2023-11-01', 3, 1, 1);
INSERT INTO `exam` VALUES (14, '阿达', '阿达', 1, NULL, 1, '2023-04-01', '2023-11-01', 3, 1, 1);
INSERT INTO `exam` VALUES (15, 'test', 'desc', 1, NULL, 2, '2023-04-01', '2023-11-01', 10, 1, 1);

-- ----------------------------
-- Table structure for exam_question
-- ----------------------------
DROP TABLE IF EXISTS `exam_question`;
CREATE TABLE `exam_question`  (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `question_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '考试的题目id列表',
  `exam_id` int(50) NOT NULL COMMENT '考试的id',
  `scores` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '每一题的分数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exam_question
-- ----------------------------
INSERT INTO `exam_question` VALUES (5, '12,13,15,3,6,8,18,11,19,14', 9, '1,1,1,1,1,1,1,1,1,1');
INSERT INTO `exam_question` VALUES (6, '6,18', 10, '1,1');
INSERT INTO `exam_question` VALUES (7, '3', 11, '1');
INSERT INTO `exam_question` VALUES (8, '3,6,8,11,12,13,14,15,18,19,20,21', 12, '1,1,1,1,1,1,1,1,1,1,1,1');
INSERT INTO `exam_question` VALUES (9, '18,19,15', 13, '1,1,1');
INSERT INTO `exam_question` VALUES (12, '3,21,22', 14, '1,1,1');
INSERT INTO `exam_question` VALUES (13, '11,8,3,12,13,14,18,15,19,6', 15, '1,1,1,1,1,1,1,1,1,1');

-- ----------------------------
-- Table structure for exam_record
-- ----------------------------
DROP TABLE IF EXISTS `exam_record`;
CREATE TABLE `exam_record`  (
  `record_id` int(50) NOT NULL AUTO_INCREMENT COMMENT '考试记录的id',
  `user_id` int(50) NOT NULL COMMENT '考试用户的id',
  `user_answers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户的答案列表',
  `credit_img_url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '考试诚信截图',
  `exam_id` int(50) NOT NULL COMMENT '考试的id',
  `logic_score` int(50) NULL DEFAULT NULL COMMENT '考试的逻辑得分(除简答)',
  `exam_time` datetime(0) NOT NULL COMMENT '考试时间',
  `question_ids` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '考试的题目信息',
  `total_score` int(50) NULL DEFAULT NULL COMMENT '考试总分数 (逻辑+简答)',
  `error_question_ids` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户考试的错题',
  PRIMARY KEY (`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exam_record
-- ----------------------------
INSERT INTO `exam_record` VALUES (1, 1, '1-1-0-1-0-1,2-1,2-1-java是全世界最好的语言.jpg-小学是童年', NULL, 9, 3, '2023-04-01 19:28:40', '11,13,14,12,15,6,18,19,3,8', 5, '11,13,6,18,19,14');
INSERT INTO `exam_record` VALUES (2, 1, '1', NULL, 11, 0, '2023-04-01 19:28:40', '3', 1, NULL);
INSERT INTO `exam_record` VALUES (3, 1, '0-1-0-0-0-0,1,2-0,1-0,1,2-0-0-12345-56', NULL, 12, 10, '2023-04-01 19:28:40', '11,12,13,14,15,6,18,21,19,20,3,8', 12, NULL);
INSERT INTO `exam_record` VALUES (4, 2, '0-0-0-1-0-0,1,2-0,1-0-wqe-eqweq', NULL, 9, 8, '2023-04-01 19:28:40', '11,13,14,12,15,6,18,19,3,8', 10, NULL);
INSERT INTO `exam_record` VALUES (5, 2, '0,1,2-1,2', NULL, 10, 1, '2023-04-01 19:28:40', '6,18', 1, '18');
INSERT INTO `exam_record` VALUES (6, 1, '0-0-0-0-1-1-2-1-23-156', NULL, 9, 5, '2023-04-01 19:28:40', '11,15,13,14,12,18,6,19,3,8', NULL, '18,6,19');
INSERT INTO `exam_record` VALUES (7, 1, '0-0-0-1-0-0,1,2-0,1-0-java-大大', NULL, 9, 8, '2023-04-01 19:28:40', '11,13,14,12,15,6,18,19,3,8', NULL, NULL);
INSERT INTO `exam_record` VALUES (9, 1, '0-1-0-0-0-1-2-1-是-sad', NULL, 9, 3, '2023-04-01 19:28:40', '11,13,14,12,15,6,18,19,3,8', NULL, '13,12,6,18,19');
INSERT INTO `exam_record` VALUES (10, 1, '0-0-0-0-0-1,3-1,2,3-1-656', NULL, 9, 4, '2023-04-01 19:28:40', '12,13,15,11,14,6,18,19,3,8', 6, '12,6,18,19');
INSERT INTO `exam_record` VALUES (14, 1, '0-1-0-1-1-1--1 -', NULL, 9, 1, '2023-04-01 19:28:40', '12,11,14,13,15,6,18,19,3,8', NULL, '12,11,13,15,6,18,19');
INSERT INTO `exam_record` VALUES (15, 2, '1-0-0 - - - - - -', NULL, 9, 2, '2023-04-01 19:28:40', '12,13,15,11,14,6,18,19,3,8', 4, '15,11,14,6,18,19');
INSERT INTO `exam_record` VALUES (16, 1, '- - - - - - - - - - - -  - - - - - - - - - - - -', NULL, 12, 0, '2023-04-01 19:28:40', '11,12,13,14,15,6,18,21,19,20,3,8', NULL, '11,12,13,14,15,6,18,21,19,20');
INSERT INTO `exam_record` VALUES (17, 1, '0------0,1,2----java web-php web', NULL, 12, 1, '2023-04-01 19:28:40', '11,12,13,14,15,6,18,21,19,20,3,8', NULL, '12,13,14,15,6,18,21,19,20');
INSERT INTO `exam_record` VALUES (18, 1, '0,1,2-0,1', NULL, 10, 2, '2023-04-01 19:28:40', '6,18', NULL, NULL);
INSERT INTO `exam_record` VALUES (23, 2, '--1-0-1-2-3-0--wwww', '', 15, 2, '2023-04-03 11:13:16', '11,12,13,14,15,6,18,19,3,8', NULL, '11,12,13,15,6,18');
INSERT INTO `exam_record` VALUES (24, 2, '0-0,1-2222', '', 14, 1, '2023-04-03 11:20:28', '22,21,3', NULL, '21');
INSERT INTO `exam_record` VALUES (25, 2, '0-1', '', 10, 0, '2023-04-03 11:22:28', '6,18', NULL, '6,18');
INSERT INTO `exam_record` VALUES (26, 2, '0,1-0,1', '', 10, 1, '2023-04-03 12:47:30', '6,18', 1, '6');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `n_id` int(64) NOT NULL AUTO_INCREMENT COMMENT '系统公告id',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告内容',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '公告创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新此公告时间',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '0(不是当前系统公告) 1(是当前系统公告)',
  PRIMARY KEY (`n_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `qu_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '问题内容',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `create_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
  `qu_type` int(10) NOT NULL COMMENT '问题类型 1单选 2多选 3判断 4简答',
  `level` int(10) NOT NULL DEFAULT 1 COMMENT '题目难度 1简单 2中等 3困难',
  `image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图片',
  `qu_bank_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属题库id',
  `qu_bank_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属题库名称',
  `analysis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '解析',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES (3, '实现web后端的语言', '2023-04-01 19:28:40', 'wzz', 4, 2, NULL, '1,2,5', '小学数学题库,生活小常识,java开发', '解析');
INSERT INTO `question` VALUES (6, '以下哪些语言是必修课', '2023-04-01 19:28:40', 'wzz', 2, 1, NULL, '1,5', '小学数学题库,java开发', '语文 数学 英语');
INSERT INTO `question` VALUES (8, '说说小学是什么样的?', '2023-04-01 19:28:40', 'wzz', 4, 3, NULL, '1,5', '小学数学题库,java开发', '说亲身经历即可');
INSERT INTO `question` VALUES (11, '1-1', '2023-04-01 19:28:40', 'wzz', 1, 1, NULL, '1,5', '小学数学题库,java开发', '0');
INSERT INTO `question` VALUES (12, '8+8', '2023-04-01 19:28:40', 'wzz', 1, 3, NULL, '1,5', '小学数学题库,java开发', '16');
INSERT INTO `question` VALUES (13, '1 * 9', '2023-04-01 19:28:40', 'wzz', 1, 1, NULL, '1,5', '小学数学题库,java开发', '9');
INSERT INTO `question` VALUES (14, '2+2', '2023-04-01 19:28:40', 'wzz', 1, 1, 'https://wangsiryun.oss-cn-beijing.aliyuncs.com/images/upload/2020-10-27/e4f71d9b67b4a15ce2ec638c908b00dc506ab.png', '1,5', '小学数学题库,java开发', '4');
INSERT INTO `question` VALUES (15, '9+9', '2023-04-01 19:28:40', 'wzz', 1, 1, 'https://wangsiryun.oss-cn-beijing.aliyuncs.com/images/upload/2020-10-27/47ccdd9b67b4a15ce2ec638c908b00dc506ab.png', '1,5', '小学数学题库,java开发', '18');
INSERT INTO `question` VALUES (18, '最接近0的两个数', '2023-04-01 19:28:40', 'wzz', 2, 2, NULL, '1', '小学数学题库', '1和2');
INSERT INTO `question` VALUES (19, '1是不是奇数', '2023-04-01 19:28:40', 'wzz', 3, 1, NULL, '1', '小学数学题库', '是');
INSERT INTO `question` VALUES (20, '9是奇数还是偶数', '2023-04-01 19:28:40', 'wzz', 3, 1, NULL, '1', '小学数学题库', '奇数');
INSERT INTO `question` VALUES (21, '哪几个是三位数', '2023-04-01 19:28:40', 'wzz', 2, 1, NULL, '1,2', '小学数学题库,生活小常识', '数数');
INSERT INTO `question` VALUES (22, '测试', '2023-04-01 19:28:40', 'wzz', 1, 1, NULL, '2', '生活小常识', '测试');

-- ----------------------------
-- Table structure for question_bank
-- ----------------------------
DROP TABLE IF EXISTS `question_bank`;
CREATE TABLE `question_bank`  (
  `bank_id` int(40) NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`bank_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question_bank
-- ----------------------------
INSERT INTO `question_bank` VALUES (1, '小学数学题库');
INSERT INTO `question_bank` VALUES (2, '生活小常识');
INSERT INTO `question_bank` VALUES (5, 'java开发');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `role_id` int(10) NOT NULL DEFAULT 1 COMMENT '1(学生) 2(教师) 3(管理员)',
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `true_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` int(10) NOT NULL DEFAULT 1 COMMENT '用户是否被禁用 1正常 2禁用',
  `create_date` datetime(0) NOT NULL COMMENT '用户创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 1, 'admin', 'admin', 'ea48576f30be1669971699c09ad05c94', '123456', 1, '2023-04-01 19:28:40');
INSERT INTO `user` VALUES (2, 1, 'test', '学生王某', 'ea48576f30be1669971699c09ad05c94', '123456', 1, '2023-04-01 19:28:40');
INSERT INTO `user` VALUES (3, 1, 'tea', '教师', 'ea48576f30be1669971699c09ad05c94', '123456', 1, '2023-04-01 19:28:40');
INSERT INTO `user` VALUES (4, 1, 'lx', '刘熙', 'ea48576f30be1669971699c09ad05c94', '123456', 1, '2023-04-01 19:28:40');
INSERT INTO `user` VALUES (5, 1, 'mc', '马冲', 'ea48576f30be1669971699c09ad05c94', '123456', 1, '2023-04-01 19:28:40');
INSERT INTO `user` VALUES (6, 1, 'amao', '阿毛', 'ea48576f30be1669971699c09ad05c94', '123456', 1, '2023-04-01 19:28:40');
INSERT INTO `user` VALUES (8, 1, 'mq', 'sada', 'ea48576f30be1669971699c09ad05c94', '123456', 1, '2023-04-01 19:28:40');
INSERT INTO `user` VALUES (9, 1, 'shepi', '蛇皮', 'ea48576f30be1669971699c09ad05c94', '123456', 1, '2023-04-01 19:28:40');
INSERT INTO `user` VALUES (10, 1, 'zzb', '张智博', 'ea48576f30be1669971699c09ad05c94', '123456', 1, '2023-04-01 19:28:40');
INSERT INTO `user` VALUES (11, 1, 'pgl', '潘广隆', 'ea48576f30be1669971699c09ad05c94', '123456', 1, '2023-04-01 19:28:40');
INSERT INTO `user` VALUES (12, 1, 'wjh', '王建欢', 'ea48576f30be1669971699c09ad05c94', '123456', 1, '2023-04-01 19:28:40');
INSERT INTO `user` VALUES (13, 1, 'll', '丽丽', 'ea48576f30be1669971699c09ad05c94', '123456', 1, '2023-04-01 19:28:40');
INSERT INTO `user` VALUES (14, 1, 'xx', '小熊', 'ea48576f30be1669971699c09ad05c94', '123456', 1, '2023-04-01 19:28:40');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` int(10) NOT NULL,
  `role_id` int(10) NOT NULL DEFAULT 1 COMMENT '1学生 2教师 3超级管理员',
  `role_name` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `menu_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主页的菜单信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, 1, '学生', '[{\"topMenuName\":\"在线考试\",\"topIcon\":\"el-icon-menu\",\"submenu\":[{\"name\":\"在线考试\",\"icon\":\"el-icon-s-promotion\",\"url\":\"/examOnline\"},{\"name\":\"我的成绩\",\"icon\":\"el-icon-trophy\",\"url\":\"/myGrade\"},{\"name\":\"我的题库\",\"icon\":\"el-icon-notebook-2\",\"url\":\"/myQuestionBank\"}]}]');
INSERT INTO `user_role` VALUES (2, 2, '教师', '[{\"topMenuName\":\"考试管理\",\"topIcon\":\"el-icon-bangzhu\",\"submenu\":[{\"name\":\"题库管理\",\"icon\":\"el-icon-aim\",\"url\":\"/questionBankMange\"},{\"name\":\"试题管理\",\"icon\":\"el-icon-news\",\"url\":\"/questionManage\"},{\"name\":\"考试管理\",\"icon\":\"el-icon-tickets\",\"url\":\"/examManage\"},{\"name\":\"阅卷管理\",\"icon\":\"el-icon-view\",\"url\":\"/markManage\"}]},{\"topMenuName\":\"考试统计\",\"topIcon\":\"el-icon-pie-chart\",\"submenu\":[{\"name\":\"统计总览\",\"icon\":\"el-icon-data-line\",\"url\":\"/staticOverview\"}]}]');
INSERT INTO `user_role` VALUES (3, 3, '超级管理员', '[{\"topMenuName\":\"在线考试\",\"topIcon\":\"el-icon-menu\",\"submenu\":[{\"name\":\"在线考试\",\"icon\":\"el-icon-s-promotion\",\"url\":\"/examOnline\"},{\"name\":\"我的成绩\",\"icon\":\"el-icon-trophy\",\"url\":\"/myGrade\"},{\"name\":\"我的题库\",\"icon\":\"el-icon-notebook-2\",\"url\":\"/myQuestionBank\"}]},{\"topMenuName\":\"考试管理\",\"topIcon\":\"el-icon-bangzhu\",\"submenu\":[{\"name\":\"题库管理\",\"icon\":\"el-icon-aim\",\"url\":\"/questionBankMange\"},{\"name\":\"试题管理\",\"icon\":\"el-icon-news\",\"url\":\"/questionManage\"},{\"name\":\"考试管理\",\"icon\":\"el-icon-tickets\",\"url\":\"/examManage\"},{\"name\":\"阅卷管理\",\"icon\":\"el-icon-view\",\"url\":\"/markManage\"}]},{\"topMenuName\":\"考试统计\",\"topIcon\":\"el-icon-pie-chart\",\"submenu\":[{\"name\":\"统计总览\",\"icon\":\"el-icon-data-line\",\"url\":\"/staticOverview\"}]},{\"topMenuName\":\"系统设置\",\"topIcon\":\"el-icon-setting\",\"submenu\":[{\"name\":\"公告管理\",\"icon\":\"el-icon-bell\",\"url\":\"/noticeManage\"},{\"name\":\"角色管理\",\"icon\":\"el-icon-s-custom\",\"url\":\"/roleManage\"},{\"name\":\"用户管理\",\"icon\":\"el-icon-user-solid\",\"url\":\"/userManage\"}]}]');

SET FOREIGN_KEY_CHECKS = 1;
