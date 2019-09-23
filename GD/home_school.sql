/*
Navicat MySQL Data Transfer

Source Server         : GD
Source Server Version : 50724
Source Host           : 127.0.0.1:3306
Source Database       : home_school

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2019-05-21 20:46:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `account` varchar(20) NOT NULL COMMENT '管理员帐号',
  `name` varchar(25) NOT NULL COMMENT '管理员姓名',
  `password` varchar(255) NOT NULL COMMENT '管理员密码',
  `telephone` varchar(11) DEFAULT NULL COMMENT '管理员电话',
  PRIMARY KEY (`account`),
  UNIQUE KEY `account` (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('huz', 'hz', 'hz123456', '187');

-- ----------------------------
-- Table structure for clas
-- ----------------------------
DROP TABLE IF EXISTS `clas`;
CREATE TABLE `clas` (
  `cla_id` int(20) NOT NULL COMMENT '班级号',
  `cla_name` varchar(50) NOT NULL COMMENT '班级名',
  `cla_tno` varchar(11) DEFAULT NULL COMMENT '班主任',
  PRIMARY KEY (`cla_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of clas
-- ----------------------------
INSERT INTO `clas` VALUES ('10010', '高一1901', '9102560010');
INSERT INTO `clas` VALUES ('10011', '高一1902', '9102560009');
INSERT INTO `clas` VALUES ('10012', '高一1903', null);
INSERT INTO `clas` VALUES ('10013', '高一1904', null);
INSERT INTO `clas` VALUES ('10014', '高一1905', null);
INSERT INTO `clas` VALUES ('10015', '高一1906', null);
INSERT INTO `clas` VALUES ('20010', '高二1801', ' ');
INSERT INTO `clas` VALUES ('20011', '高二1802', ' ');
INSERT INTO `clas` VALUES ('20012', '高二1803', null);
INSERT INTO `clas` VALUES ('20013', '高二1804', null);
INSERT INTO `clas` VALUES ('20014', '高二1805', null);
INSERT INTO `clas` VALUES ('20015', '高二1806', null);
INSERT INTO `clas` VALUES ('30010', '高三1701', null);
INSERT INTO `clas` VALUES ('30011', '高三1702', null);
INSERT INTO `clas` VALUES ('30012', '高三1703', null);
INSERT INTO `clas` VALUES ('30013', '高三1704', null);
INSERT INTO `clas` VALUES ('30014', '高三1705', null);
INSERT INTO `clas` VALUES ('30015', '高三1706', null);

-- ----------------------------
-- Table structure for communication
-- ----------------------------
DROP TABLE IF EXISTS `communication`;
CREATE TABLE `communication` (
  `cm_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `cm_title` varchar(50) NOT NULL COMMENT '标题',
  `content` text COMMENT '消息内容',
  `reply_content` text COMMENT '回复内容',
  `sender` varchar(25) DEFAULT NULL COMMENT '留言人',
  `recipient` varchar(25) NOT NULL COMMENT '接收者',
  `add_time` datetime NOT NULL COMMENT '发送时间',
  `reply_time` datetime DEFAULT NULL COMMENT '回复时间',
  `cw_status` varchar(25) DEFAULT '未读' COMMENT '信息状态',
  PRIMARY KEY (`cm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of communication
-- ----------------------------
INSERT INTO `communication` VALUES ('1', 'test0', '要求', '好的', '18408300002', '9102560010', '2019-04-12 00:00:00', '2019-04-24 14:50:01', '已回复');
INSERT INTO `communication` VALUES ('2', 'Test', '老师Test', null, '123456', '9102560010', '2019-04-24 15:36:02', null, '未读');
INSERT INTO `communication` VALUES ('4', 'Test02', 'Test02', 'ok', '123456', '9102560010', '2019-04-22 00:00:00', '2019-04-24 14:55:27', '已回复');
INSERT INTO `communication` VALUES ('5', 'tewt', 'tsetasat', null, '123456', '9102560010', '2019-04-23 22:39:08', null, '未读');
INSERT INTO `communication` VALUES ('6', 'sfasf', 'adsfa', 'sggsdfgsdg', '123456', '9102560010', '2019-04-24 15:28:04', '2019-04-24 15:28:30', '已回复');
INSERT INTO `communication` VALUES ('8', 'sdfasdfasdfa', 'asdfasfas', null, '123456', '9102560010', '2019-04-24 15:46:52', null, '未读');
INSERT INTO `communication` VALUES ('9', 'sdfasdf', 'adfafa', null, '123456', '9102560010', '2019-04-24 15:47:16', null, '未读');
INSERT INTO `communication` VALUES ('10', 'adsfaf', 'asdfasfaf', null, '123456', '9102560010', '2019-04-24 15:48:41', null, '未读');
INSERT INTO `communication` VALUES ('11', '2019 4 26', 'test', '1235467891', '123456', '9102560010', '2019-04-26 00:22:10', '2019-05-06 13:59:59', '已回复');
INSERT INTO `communication` VALUES ('12', 'test', 'test426', 'tset', '123456', '9102560010', '2019-04-26 10:59:24', '2019-04-26 10:59:53', '已回复');
INSERT INTO `communication` VALUES ('13', 'test', '426 2256', null, '9102560010', '123456', '2019-04-26 22:58:53', null, '未读');
INSERT INTO `communication` VALUES ('14', '001', null, null, null, '001', '2019-05-01 13:31:28', null, '未读');
INSERT INTO `communication` VALUES ('15', '516', '托尔斯泰', null, '123456', '9102560010', '2019-05-16 20:59:36', null, '未读');
INSERT INTO `communication` VALUES ('16', '5162', '特色t', '是的', '123456', '9102560010', '2019-05-16 21:06:14', '2019-05-16 21:12:44', '已回复');
INSERT INTO `communication` VALUES ('17', '5169', '阿斯顿级', null, '9102560010', '123456', '2019-05-16 21:13:27', null, '未读');
INSERT INTO `communication` VALUES ('18', '无双', '天行', null, '9102560010', '123456', '2019-05-16 21:16:08', null, '未读');
INSERT INTO `communication` VALUES ('19', 'aadf', 'dfaadf', null, '123456', '9102560009', '2019-05-16 21:18:21', null, '未读');
INSERT INTO `communication` VALUES ('20', 'dxczgd', 'adfasf', null, '123456', '9102560023', '2019-05-16 21:22:47', null, '未读');
INSERT INTO `communication` VALUES ('21', ' ertu', 'afdsf ', null, '123456', '9102560027', '2019-05-16 21:24:03', null, '未读');
INSERT INTO `communication` VALUES ('22', '期末考试', '学生本次考试成绩不好', '没关系，继续努力', '123456', '9102560022', '2019-05-16 22:29:26', '2019-05-16 22:29:57', '已回复');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `cno` varchar(11) NOT NULL COMMENT '课程编号',
  `course_name` varchar(50) NOT NULL COMMENT '课程名',
  `course_time` int(5) NOT NULL COMMENT '学时',
  PRIMARY KEY (`cno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('0110111', '数学', '48');
INSERT INTO `course` VALUES ('0110112', '语文', '48');
INSERT INTO `course` VALUES ('0110113', '英语', '48');
INSERT INTO `course` VALUES ('0110114', '化学', '30');
INSERT INTO `course` VALUES ('0110115', '生物', '30');
INSERT INTO `course` VALUES ('0110116', '物理', '30');
INSERT INTO `course` VALUES ('0110117', '历史', '30');
INSERT INTO `course` VALUES ('0110118', '政治', '30');
INSERT INTO `course` VALUES ('0110119', '地理', '30');
INSERT INTO `course` VALUES ('0110120', '体育', '15');

-- ----------------------------
-- Table structure for investigate
-- ----------------------------
DROP TABLE IF EXISTS `investigate`;
CREATE TABLE `investigate` (
  `inv_id` int(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `sno` varchar(11) NOT NULL COMMENT '缺勤学生学号',
  `stu_name` varchar(25) NOT NULL COMMENT '学生姓名',
  `cla_name` varchar(50) NOT NULL COMMENT '学生班级名',
  `add_time` varchar(50) NOT NULL COMMENT '日期',
  `situation` varchar(50) NOT NULL DEFAULT '已到' COMMENT '情况',
  `remark` text COMMENT '备注',
  `tno` varchar(11) NOT NULL COMMENT '班主任',
  `tc_name` varchar(25) NOT NULL COMMENT '上传者',
  PRIMARY KEY (`inv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of investigate
-- ----------------------------
INSERT INTO `investigate` VALUES ('2', '19018300002', '陈衍暖', '高一1901', '2019-05-08 星期三', '请假', '', '9102560010', '赵王');
INSERT INTO `investigate` VALUES ('3', '19018300004', '雷友水', '高一1901', '2019-05-08 星期三', '请假', '', '9102560010', '赵王');
INSERT INTO `investigate` VALUES ('4', '19018300005', '陈茗卓', '高一1901', '2019-04-27 星期六', '请假', '肚子痛', '9102560010', '赵王');
INSERT INTO `investigate` VALUES ('5', '19018300001', '牧田', '高一1901', '2019-05-08 星期三', '请假', null, '9102560010', '赵王');
INSERT INTO `investigate` VALUES ('6', '19018300001', '牧田', '高一1901', '2019-05-10 星期五', '请假', null, '9102560010', '赵王');
INSERT INTO `investigate` VALUES ('8', '19018300001', '牧田', '高一1901', '2019-05-10 星期五', '请假', null, '9102560010', '赵王');
INSERT INTO `investigate` VALUES ('9', '19018300001', '牧田', '高一1901', '2019-05-10 星期五', '旷课', null, '9102560010', '赵王');
INSERT INTO `investigate` VALUES ('10', '19018300001', '牧田', '高一1901', '2019-05-10 星期五', '旷课', null, '9102560010', '赵王');
INSERT INTO `investigate` VALUES ('11', '19018300004', '雷友水', '高一1901', '2019-05-10 星期五', '旷课', null, '9102560010', '赵王');
INSERT INTO `investigate` VALUES ('13', '19018300002', '陈衍暖', '高一1901', '2019-05-12 星期日', '请假', null, '9102560010', '赵王');
INSERT INTO `investigate` VALUES ('14', '19018300002', '陈衍暖', '高一1901', '2019-05-12 星期日', '旷课', null, '9102560010', '赵王');
INSERT INTO `investigate` VALUES ('15', '19018300001', '牧田', '高一1901', '2019-05-13 星期一', '旷课', null, '9102560010', '赵王');
INSERT INTO `investigate` VALUES ('16', '19018300004', '雷友水', '高一1901', '2019-05-13 星期一', '迟到', null, '9102560010', '赵王');
INSERT INTO `investigate` VALUES ('17', '19018300001', '牧田', '高一1901', '2019-05-13 星期一', '旷课', null, '9102560010', '赵王');
INSERT INTO `investigate` VALUES ('18', '19018300001', '牧田', '高一1901', '2019-05-13 星期一', '迟到', null, '9102560010', '赵王');

-- ----------------------------
-- Table structure for schedule
-- ----------------------------
DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule` (
  `schedule_id` int(25) NOT NULL AUTO_INCREMENT,
  `week` varchar(25) CHARACTER SET utf8 DEFAULT NULL COMMENT '星期',
  `first_lesson` varchar(25) CHARACTER SET utf8 DEFAULT NULL COMMENT '第一节课',
  `second_lesson` varchar(25) CHARACTER SET utf8 DEFAULT NULL COMMENT '第二节课',
  `third_lesson` varchar(25) CHARACTER SET utf8 DEFAULT NULL COMMENT '第三节课',
  `fourth_lesson` varchar(25) CHARACTER SET utf8 DEFAULT NULL COMMENT '第四节课',
  `fifth_lesson` varchar(25) CHARACTER SET utf8 DEFAULT NULL COMMENT '第五节课',
  `sixth_lesson` varchar(25) CHARACTER SET utf8 DEFAULT NULL COMMENT '第六节课',
  `seventh_lesson` varchar(25) CHARACTER SET utf8 DEFAULT NULL COMMENT '第七节课',
  `eighth_lesson` varchar(25) CHARACTER SET utf8 DEFAULT NULL COMMENT '第八节课',
  `exam_year` varchar(25) CHARACTER SET utf8 DEFAULT NULL COMMENT '学年',
  `exam_term` varchar(25) CHARACTER SET utf8 DEFAULT NULL COMMENT '学期',
  `cla_id` int(20) DEFAULT NULL COMMENT '班级ID',
  `status` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`schedule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of schedule
-- ----------------------------
INSERT INTO `schedule` VALUES ('1', '星期一', '数学', '语文', '历史', '数学', '物理', '生物', '地理', '物理', '2019-2020', '上学期', '10010', null);
INSERT INTO `schedule` VALUES ('2', '星期二', '语文', '数学', '历史', '物理', '数学', '地理', '生物', '物理', '2019-2020', '上学期', '10010', null);
INSERT INTO `schedule` VALUES ('3', '星期三', '历史', '数学', '语文', '数学', '物理', '生物', '地理', '化学', '2019-2020', '上学期', '10010', null);
INSERT INTO `schedule` VALUES ('4', '星期四', '语文', '历史', '语文', '数学', '生物', '英语', '英语', '政治', '2019-2020', '上学期', '10010', null);
INSERT INTO `schedule` VALUES ('5', '星期五', '数学', '历史', '语文', '生物', '数学', '物理', '英语', '英语', '2019-2020', '上学期', '10010', null);
INSERT INTO `schedule` VALUES ('6', '星期一', '语文', '历史', '化学', '历史', '体育', '政治', '物理', '生物', '2018-2019', '下学期', '10010', null);
INSERT INTO `schedule` VALUES ('7', '星期二', '生物', '物理', '物理', '化学', '历史', '地理', '数学', '语文', '2018-2019', '下学期', '10010', null);
INSERT INTO `schedule` VALUES ('8', '星期三', '语文', '语文', '英语', '数学', '化学', '政治', '历史', '体育', '2018-2019', '下学期', '10010', null);
INSERT INTO `schedule` VALUES ('9', '星期四', '地理', '数学', '政治', '历史', '化学', '物理', '生物', '数学', '2018-2019', '下学期', '10010', null);
INSERT INTO `schedule` VALUES ('10', '星期五', '英语', '英语', '数学', '物理', '语文', '生物', '化学', '体育', '2018-2019', '下学期', '10010', null);
INSERT INTO `schedule` VALUES ('22', '星期一', '语文', '历史', '数学', '语文', '生物', '地理', '英语', '数学', '2019-2020', '上学期', '10011', null);
INSERT INTO `schedule` VALUES ('23', '星期二', '历史', '物理', '语文', '数学', '英语', '化学', '英语', '政治', '2019-2020', '上学期', '10011', null);
INSERT INTO `schedule` VALUES ('24', '星期三', '数学', '物理', '生物', '体育', '化学', '数学', '化学', '地理', '2019-2020', '上学期', '10011', null);
INSERT INTO `schedule` VALUES ('25', '星期四', '地理', '生物', '化学', '数学', '历史', '政治', '语文', '英语', '2019-2020', '上学期', '10011', null);
INSERT INTO `schedule` VALUES ('26', '星期五', '历史', '物理', '体育', '物理', '生物', '化学', '生物', '数学', '2019-2020', '上学期', '10011', null);

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score` (
  `score_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '成绩编号',
  `exam_year` varchar(20) DEFAULT NULL COMMENT '学年',
  `exam_term` varchar(20) DEFAULT NULL COMMENT '学期',
  `course_name` varchar(50) NOT NULL COMMENT '课程名',
  `cla_name` varchar(50) NOT NULL COMMENT '班级名',
  `stu_name` varchar(25) NOT NULL COMMENT '考生姓名',
  `exam_score` decimal(10,2) DEFAULT NULL COMMENT '考试成绩',
  `exam_time` datetime DEFAULT NULL COMMENT '考试时间',
  `tno` varchar(11) NOT NULL COMMENT '上传教师编号',
  `sno` varchar(11) NOT NULL COMMENT '学号',
  `cno` varchar(11) NOT NULL COMMENT '课程编号',
  PRIMARY KEY (`score_id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES ('1', '2019-2020', '上学期', '语文', '高一1901', '牧田', '108.00', '2019-05-11 14:22:47', '9102560010', '19018300001', '0110112');
INSERT INTO `score` VALUES ('2', '2019-2020', '上学期', '语文', '高一1901', '陈衍暖', '98.00', '2019-05-11 14:22:47', '9102560010', '19018300002', '0110112');
INSERT INTO `score` VALUES ('3', '2019-2020', '上学期', '语文', '高一1901', '傅利', '95.00', '2019-05-11 14:22:47', '9102560010', '19018300003', '0110112');
INSERT INTO `score` VALUES ('4', '2019-2020', '上学期', '语文', '高一1901', '雷友水', '73.50', '2019-05-11 14:22:47', '9102560010', '19018300004', '0110112');
INSERT INTO `score` VALUES ('5', '2019-2020', '上学期', '语文', '高一1901', '陈茗卓', '68.00', '2019-05-11 14:22:47', '9102560010', '19018300005', '0110112');
INSERT INTO `score` VALUES ('6', '2019-2020', '上学期', '语文', '高一1901', '史霄灼', '72.00', '2019-05-11 14:22:47', '9102560010', '19018300006', '0110112');
INSERT INTO `score` VALUES ('7', '2019-2020', '上学期', '语文', '高一1901', '杜文渊', '88.00', '2019-05-11 14:22:47', '9102560010', '19018300007', '0110112');
INSERT INTO `score` VALUES ('8', '2019-2020', '上学期', '语文', '高一1901', '杜永强', '86.00', '2019-05-11 14:22:47', '9102560010', '19018300008', '0110112');
INSERT INTO `score` VALUES ('9', '2019-2020', '上学期', '语文', '高一1901', '高桂清', '99.00', '2019-05-11 14:22:47', '9102560010', '19018300009', '0110112');
INSERT INTO `score` VALUES ('10', '2019-2020', '上学期', '语文', '高一1901', '李振云', '97.00', '2019-05-11 14:22:47', '9102560010', '19018300010', '0110112');
INSERT INTO `score` VALUES ('11', '2019-2020', '上学期', '语文', '高一1901', '王桂香', '102.00', '2019-05-11 14:22:47', '9102560010', '19018300011', '0110112');
INSERT INTO `score` VALUES ('12', '2019-2020', '上学期', '语文', '高一1901', '刘东', '98.00', '2019-05-11 14:22:47', '9102560010', '19018300012', '0110112');
INSERT INTO `score` VALUES ('13', '2019-2020', '上学期', '数学', '高一1901', '牧田', '103.00', '2019-05-11 14:38:10', '9102560009', '19018300001', '0110111');
INSERT INTO `score` VALUES ('14', '2019-2020', '上学期', '数学', '高一1901', '陈衍暖', '112.00', '2019-05-11 14:38:10', '9102560009', '19018300002', '0110111');
INSERT INTO `score` VALUES ('15', '2019-2020', '上学期', '数学', '高一1901', '傅利', '98.50', '2019-05-11 14:38:10', '9102560009', '19018300003', '0110111');
INSERT INTO `score` VALUES ('16', '2019-2020', '上学期', '数学', '高一1901', '雷友水', '97.00', '2019-05-11 14:38:10', '9102560009', '19018300004', '0110111');
INSERT INTO `score` VALUES ('17', '2019-2020', '上学期', '数学', '高一1901', '陈茗卓', '110.00', '2019-05-11 14:38:10', '9102560009', '19018300005', '0110111');
INSERT INTO `score` VALUES ('18', '2019-2020', '上学期', '数学', '高一1901', '史霄灼', '103.00', '2019-05-11 14:38:10', '9102560009', '19018300006', '0110111');
INSERT INTO `score` VALUES ('19', '2019-2020', '上学期', '数学', '高一1901', '杜文渊', '89.00', '2019-05-11 14:38:10', '9102560009', '19018300007', '0110111');
INSERT INTO `score` VALUES ('20', '2019-2020', '上学期', '数学', '高一1901', '杜永强', '96.00', '2019-05-11 14:38:10', '9102560009', '19018300008', '0110111');
INSERT INTO `score` VALUES ('21', '2019-2020', '上学期', '数学', '高一1901', '高桂清', '86.00', '2019-05-11 14:38:10', '9102560009', '19018300009', '0110111');
INSERT INTO `score` VALUES ('22', '2019-2020', '上学期', '数学', '高一1901', '李振云', '99.00', '2019-05-11 14:38:10', '9102560009', '19018300010', '0110111');
INSERT INTO `score` VALUES ('23', '2019-2020', '上学期', '数学', '高一1901', '王桂香', '103.00', '2019-05-11 14:38:10', '9102560009', '19018300011', '0110111');
INSERT INTO `score` VALUES ('24', '2019-2020', '上学期', '数学', '高一1901', '刘东', '114.00', '2019-05-11 14:38:10', '9102560009', '19018300012', '0110111');
INSERT INTO `score` VALUES ('25', '2019-2020', '上学期', '英语', '高一1901', '牧田', '101.50', '2019-05-11 21:02:19', '9102560011', '19018300001', '0110113');
INSERT INTO `score` VALUES ('26', '2019-2020', '上学期', '英语', '高一1901', '陈衍暖', '98.00', '2019-05-11 21:02:19', '9102560011', '19018300002', '0110113');
INSERT INTO `score` VALUES ('27', '2019-2020', '上学期', '英语', '高一1901', '傅利', '96.50', '2019-05-11 21:02:19', '9102560011', '19018300003', '0110113');
INSERT INTO `score` VALUES ('28', '2019-2020', '上学期', '英语', '高一1901', '雷友水', '114.00', '2019-05-11 21:02:19', '9102560011', '19018300004', '0110113');
INSERT INTO `score` VALUES ('29', '2019-2020', '上学期', '英语', '高一1901', '陈茗卓', '103.00', '2019-05-11 21:02:19', '9102560011', '19018300005', '0110113');
INSERT INTO `score` VALUES ('30', '2019-2020', '上学期', '英语', '高一1901', '史霄灼', '88.00', '2019-05-11 21:02:19', '9102560011', '19018300006', '0110113');
INSERT INTO `score` VALUES ('31', '2019-2020', '上学期', '英语', '高一1901', '杜文渊', '69.00', '2019-05-11 21:02:19', '9102560011', '19018300007', '0110113');
INSERT INTO `score` VALUES ('32', '2019-2020', '上学期', '英语', '高一1901', '杜永强', '98.00', '2019-05-11 21:02:19', '9102560011', '19018300008', '0110113');
INSERT INTO `score` VALUES ('33', '2019-2020', '上学期', '英语', '高一1901', '高桂清', '96.00', '2019-05-11 21:02:19', '9102560011', '19018300009', '0110113');
INSERT INTO `score` VALUES ('34', '2019-2020', '上学期', '英语', '高一1901', '李振云', '89.00', '2019-05-11 21:02:19', '9102560011', '19018300010', '0110113');
INSERT INTO `score` VALUES ('35', '2019-2020', '上学期', '英语', '高一1901', '王桂香', '99.00', '2019-05-11 21:02:19', '9102560011', '19018300011', '0110113');
INSERT INTO `score` VALUES ('36', '2019-2020', '上学期', '英语', '高一1901', '刘东', '101.00', '2019-05-11 21:02:19', '9102560011', '19018300012', '0110113');
INSERT INTO `score` VALUES ('37', '2019-2020', '上学期', '化学', '高一1901', '牧田', '78.00', '2019-05-11 21:07:11', '9102560022', '19018300001', '0110114');
INSERT INTO `score` VALUES ('38', '2019-2020', '上学期', '化学', '高一1901', '陈衍暖', '88.00', '2019-05-11 21:07:11', '9102560022', '19018300002', '0110114');
INSERT INTO `score` VALUES ('39', '2019-2020', '上学期', '化学', '高一1901', '傅利', '60.00', '2019-05-11 21:07:11', '9102560022', '19018300003', '0110114');
INSERT INTO `score` VALUES ('40', '2019-2020', '上学期', '化学', '高一1901', '雷友水', '75.00', '2019-05-11 21:07:11', '9102560022', '19018300004', '0110114');
INSERT INTO `score` VALUES ('41', '2019-2020', '上学期', '化学', '高一1901', '陈茗卓', '69.00', '2019-05-11 21:07:11', '9102560022', '19018300005', '0110114');
INSERT INTO `score` VALUES ('42', '2019-2020', '上学期', '化学', '高一1901', '史霄灼', '56.00', '2019-05-11 21:07:11', '9102560022', '19018300006', '0110114');
INSERT INTO `score` VALUES ('43', '2019-2020', '上学期', '化学', '高一1901', '杜文渊', '89.00', '2019-05-11 21:07:11', '9102560022', '19018300007', '0110114');
INSERT INTO `score` VALUES ('44', '2019-2020', '上学期', '化学', '高一1901', '杜永强', '90.00', '2019-05-11 21:07:11', '9102560022', '19018300008', '0110114');
INSERT INTO `score` VALUES ('45', '2019-2020', '上学期', '化学', '高一1901', '高桂清', '79.00', '2019-05-11 21:07:11', '9102560022', '19018300009', '0110114');
INSERT INTO `score` VALUES ('46', '2019-2020', '上学期', '化学', '高一1901', '李振云', '64.00', '2019-05-11 21:07:11', '9102560022', '19018300010', '0110114');
INSERT INTO `score` VALUES ('47', '2019-2020', '上学期', '化学', '高一1901', '王桂香', '63.00', '2019-05-11 21:07:11', '9102560022', '19018300011', '0110114');
INSERT INTO `score` VALUES ('48', '2019-2020', '上学期', '化学', '高一1901', '刘东', '76.00', '2019-05-11 21:07:11', '9102560022', '19018300012', '0110114');
INSERT INTO `score` VALUES ('49', '2019-2020', '上学期', '生物', '高一1901', '牧田', '68.00', '2019-05-11 21:08:52', '9102560023', '19018300001', '0110115');
INSERT INTO `score` VALUES ('50', '2019-2020', '上学期', '生物', '高一1901', '陈衍暖', '78.00', '2019-05-11 21:08:52', '9102560023', '19018300002', '0110115');
INSERT INTO `score` VALUES ('51', '2019-2020', '上学期', '生物', '高一1901', '傅利', '77.00', '2019-05-11 21:08:52', '9102560023', '19018300003', '0110115');
INSERT INTO `score` VALUES ('52', '2019-2020', '上学期', '生物', '高一1901', '雷友水', '66.00', '2019-05-11 21:08:52', '9102560023', '19018300004', '0110115');
INSERT INTO `score` VALUES ('53', '2019-2020', '上学期', '生物', '高一1901', '陈茗卓', '65.00', '2019-05-11 21:08:52', '9102560023', '19018300005', '0110115');
INSERT INTO `score` VALUES ('54', '2019-2020', '上学期', '生物', '高一1901', '史霄灼', '78.00', '2019-05-11 21:08:52', '9102560023', '19018300006', '0110115');
INSERT INTO `score` VALUES ('55', '2019-2020', '上学期', '生物', '高一1901', '杜文渊', '56.00', '2019-05-11 21:08:52', '9102560023', '19018300007', '0110115');
INSERT INTO `score` VALUES ('56', '2019-2020', '上学期', '生物', '高一1901', '杜永强', '48.00', '2019-05-11 21:08:52', '9102560023', '19018300008', '0110115');
INSERT INTO `score` VALUES ('57', '2019-2020', '上学期', '生物', '高一1901', '高桂清', '69.00', '2019-05-11 21:08:52', '9102560023', '19018300009', '0110115');
INSERT INTO `score` VALUES ('58', '2019-2020', '上学期', '生物', '高一1901', '李振云', '67.00', '2019-05-11 21:08:52', '9102560023', '19018300010', '0110115');
INSERT INTO `score` VALUES ('59', '2019-2020', '上学期', '生物', '高一1901', '王桂香', '73.00', '2019-05-11 21:08:52', '9102560023', '19018300011', '0110115');
INSERT INTO `score` VALUES ('60', '2019-2020', '上学期', '生物', '高一1901', '刘东', '70.00', '2019-05-11 21:08:52', '9102560023', '19018300012', '0110115');
INSERT INTO `score` VALUES ('61', '2019-2020', '上学期', '物理', '高一1901', '牧田', '68.00', '2019-05-11 21:12:26', '9102560024', '19018300001', '0110116');
INSERT INTO `score` VALUES ('62', '2019-2020', '上学期', '物理', '高一1901', '陈衍暖', '66.00', '2019-05-11 21:12:26', '9102560024', '19018300002', '0110116');
INSERT INTO `score` VALUES ('63', '2019-2020', '上学期', '物理', '高一1901', '傅利', '78.00', '2019-05-11 21:12:26', '9102560024', '19018300003', '0110116');
INSERT INTO `score` VALUES ('64', '2019-2020', '上学期', '物理', '高一1901', '雷友水', '89.00', '2019-05-11 21:12:26', '9102560024', '19018300004', '0110116');
INSERT INTO `score` VALUES ('65', '2019-2020', '上学期', '物理', '高一1901', '陈茗卓', '68.00', '2019-05-11 21:12:26', '9102560024', '19018300005', '0110116');
INSERT INTO `score` VALUES ('66', '2019-2020', '上学期', '物理', '高一1901', '史霄灼', '56.00', '2019-05-11 21:12:26', '9102560024', '19018300006', '0110116');
INSERT INTO `score` VALUES ('67', '2019-2020', '上学期', '物理', '高一1901', '杜文渊', '45.00', '2019-05-11 21:12:26', '9102560024', '19018300007', '0110116');
INSERT INTO `score` VALUES ('68', '2019-2020', '上学期', '物理', '高一1901', '杜永强', '63.00', '2019-05-11 21:12:26', '9102560024', '19018300008', '0110116');
INSERT INTO `score` VALUES ('69', '2019-2020', '上学期', '物理', '高一1901', '高桂清', '52.00', '2019-05-11 21:12:26', '9102560024', '19018300009', '0110116');
INSERT INTO `score` VALUES ('70', '2019-2020', '上学期', '物理', '高一1901', '李振云', '74.00', '2019-05-11 21:12:26', '9102560024', '19018300010', '0110116');
INSERT INTO `score` VALUES ('71', '2019-2020', '上学期', '物理', '高一1901', '王桂香', '62.00', '2019-05-11 21:12:26', '9102560024', '19018300011', '0110116');
INSERT INTO `score` VALUES ('72', '2019-2020', '上学期', '物理', '高一1901', '刘东', '56.00', '2019-05-11 21:12:26', '9102560024', '19018300012', '0110116');
INSERT INTO `score` VALUES ('73', '2019-2020', '上学期', '历史', '高一1901', '牧田', '78.00', '2019-05-11 21:13:54', '9102560025', '19018300001', '0110117');
INSERT INTO `score` VALUES ('74', '2019-2020', '上学期', '历史', '高一1901', '陈衍暖', '88.00', '2019-05-11 21:13:54', '9102560025', '19018300002', '0110117');
INSERT INTO `score` VALUES ('75', '2019-2020', '上学期', '历史', '高一1901', '傅利', '64.00', '2019-05-11 21:13:54', '9102560025', '19018300003', '0110117');
INSERT INTO `score` VALUES ('76', '2019-2020', '上学期', '历史', '高一1901', '雷友水', '96.00', '2019-05-11 21:13:54', '9102560025', '19018300004', '0110117');
INSERT INTO `score` VALUES ('77', '2019-2020', '上学期', '历史', '高一1901', '陈茗卓', '89.00', '2019-05-11 21:13:54', '9102560025', '19018300005', '0110117');
INSERT INTO `score` VALUES ('78', '2019-2020', '上学期', '历史', '高一1901', '史霄灼', '92.00', '2019-05-11 21:13:54', '9102560025', '19018300006', '0110117');
INSERT INTO `score` VALUES ('79', '2019-2020', '上学期', '历史', '高一1901', '杜文渊', '78.00', '2019-05-11 21:13:54', '9102560025', '19018300007', '0110117');
INSERT INTO `score` VALUES ('80', '2019-2020', '上学期', '历史', '高一1901', '杜永强', '86.00', '2019-05-11 21:13:54', '9102560025', '19018300008', '0110117');
INSERT INTO `score` VALUES ('81', '2019-2020', '上学期', '历史', '高一1901', '高桂清', '75.00', '2019-05-11 21:13:54', '9102560025', '19018300009', '0110117');
INSERT INTO `score` VALUES ('82', '2019-2020', '上学期', '历史', '高一1901', '李振云', '68.00', '2019-05-11 21:13:54', '9102560025', '19018300010', '0110117');
INSERT INTO `score` VALUES ('83', '2019-2020', '上学期', '历史', '高一1901', '王桂香', '69.00', '2019-05-11 21:13:54', '9102560025', '19018300011', '0110117');
INSERT INTO `score` VALUES ('84', '2019-2020', '上学期', '历史', '高一1901', '刘东', '79.00', '2019-05-11 21:13:54', '9102560025', '19018300012', '0110117');
INSERT INTO `score` VALUES ('85', '2019-2020', '上学期', '政治', '高一1901', '牧田', '89.00', '2019-05-11 21:15:29', '9102560026', '19018300001', '0110118');
INSERT INTO `score` VALUES ('86', '2019-2020', '上学期', '政治', '高一1901', '陈衍暖', '68.00', '2019-05-11 21:15:29', '9102560026', '19018300002', '0110118');
INSERT INTO `score` VALUES ('87', '2019-2020', '上学期', '政治', '高一1901', '傅利', '79.00', '2019-05-11 21:15:29', '9102560026', '19018300003', '0110118');
INSERT INTO `score` VALUES ('88', '2019-2020', '上学期', '政治', '高一1901', '雷友水', '92.00', '2019-05-11 21:15:29', '9102560026', '19018300004', '0110118');
INSERT INTO `score` VALUES ('89', '2019-2020', '上学期', '政治', '高一1901', '陈茗卓', '87.00', '2019-05-11 21:15:29', '9102560026', '19018300005', '0110118');
INSERT INTO `score` VALUES ('90', '2019-2020', '上学期', '政治', '高一1901', '史霄灼', '82.00', '2019-05-11 21:15:29', '9102560026', '19018300006', '0110118');
INSERT INTO `score` VALUES ('91', '2019-2020', '上学期', '政治', '高一1901', '杜文渊', '86.00', '2019-05-11 21:15:29', '9102560026', '19018300007', '0110118');
INSERT INTO `score` VALUES ('92', '2019-2020', '上学期', '政治', '高一1901', '杜永强', '88.00', '2019-05-11 21:15:29', '9102560026', '19018300008', '0110118');
INSERT INTO `score` VALUES ('93', '2019-2020', '上学期', '政治', '高一1901', '高桂清', '67.00', '2019-05-11 21:15:29', '9102560026', '19018300009', '0110118');
INSERT INTO `score` VALUES ('94', '2019-2020', '上学期', '政治', '高一1901', '李振云', '78.00', '2019-05-11 21:15:29', '9102560026', '19018300010', '0110118');
INSERT INTO `score` VALUES ('95', '2019-2020', '上学期', '政治', '高一1901', '王桂香', '74.00', '2019-05-11 21:15:29', '9102560026', '19018300011', '0110118');
INSERT INTO `score` VALUES ('96', '2019-2020', '上学期', '政治', '高一1901', '刘东', '65.00', '2019-05-11 21:15:29', '9102560026', '19018300012', '0110118');
INSERT INTO `score` VALUES ('97', '2019-2020', '上学期', '地理', '高一1901', '牧田', '78.00', '2019-05-11 21:18:26', '9102560027', '19018300001', '0110119');
INSERT INTO `score` VALUES ('98', '2019-2020', '上学期', '地理', '高一1901', '陈衍暖', '85.00', '2019-05-11 21:18:26', '9102560027', '19018300002', '0110119');
INSERT INTO `score` VALUES ('99', '2019-2020', '上学期', '地理', '高一1901', '傅利', '68.00', '2019-05-11 21:18:26', '9102560027', '19018300003', '0110119');
INSERT INTO `score` VALUES ('100', '2019-2020', '上学期', '地理', '高一1901', '雷友水', '79.00', '2019-05-11 21:18:26', '9102560027', '19018300004', '0110119');
INSERT INTO `score` VALUES ('101', '2019-2020', '上学期', '地理', '高一1901', '陈茗卓', '69.00', '2019-05-11 21:18:26', '9102560027', '19018300005', '0110119');
INSERT INTO `score` VALUES ('102', '2019-2020', '上学期', '地理', '高一1901', '史霄灼', '68.00', '2019-05-11 21:18:26', '9102560027', '19018300006', '0110119');
INSERT INTO `score` VALUES ('103', '2019-2020', '上学期', '地理', '高一1901', '杜文渊', '92.00', '2019-05-11 21:18:26', '9102560027', '19018300007', '0110119');
INSERT INTO `score` VALUES ('104', '2019-2020', '上学期', '地理', '高一1901', '杜永强', '69.00', '2019-05-11 21:18:26', '9102560027', '19018300008', '0110119');
INSERT INTO `score` VALUES ('105', '2019-2020', '上学期', '地理', '高一1901', '高桂清', '89.00', '2019-05-11 21:18:26', '9102560027', '19018300009', '0110119');
INSERT INTO `score` VALUES ('106', '2019-2020', '上学期', '地理', '高一1901', '李振云', '79.00', '2019-05-11 21:18:26', '9102560027', '19018300010', '0110119');
INSERT INTO `score` VALUES ('107', '2019-2020', '上学期', '地理', '高一1901', '王桂香', '82.00', '2019-05-11 21:18:26', '9102560027', '19018300011', '0110119');
INSERT INTO `score` VALUES ('108', '2019-2020', '上学期', '地理', '高一1901', '刘东', '80.00', '2019-05-11 21:18:26', '9102560027', '19018300012', '0110119');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `sno` varchar(11) NOT NULL COMMENT '学号',
  `stu_name` varchar(25) NOT NULL COMMENT '学生姓名',
  `stu_pwd` varchar(255) NOT NULL DEFAULT '111111' COMMENT '学生密码',
  `stu_sex` char(2) DEFAULT '男' COMMENT '学生性别',
  `stu_age` int(3) NOT NULL COMMENT '年龄',
  `stu_email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `stu_phone` varchar(11) DEFAULT NULL COMMENT '学生电话',
  `stu_address` varchar(255) DEFAULT NULL COMMENT '学生住址',
  `stu_picture` varchar(255) DEFAULT NULL COMMENT '学生照片',
  `grade` varchar(50) DEFAULT NULL COMMENT '年级',
  `cla_id` int(11) NOT NULL COMMENT '班级编号',
  `cno` varchar(11) NOT NULL COMMENT '课程编号',
  `role` tinyint(4) DEFAULT '1' COMMENT '角色',
  `message_id` int(20) DEFAULT NULL COMMENT '消息ID',
  PRIMARY KEY (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('19018300001', '牧田', '4QrcOUm6Wau+VuBX8g+IPg==', '女', '15', '12944@qq.com', '15826594815', '广东', 'f58497787c3b4cee83b87b37fcc5b0c7.jpg', '高一', '10010', '0110', '1', null);
INSERT INTO `student` VALUES ('19018300002', '陈衍暖', 'lueSGJZetyySpUndWjMBEg==', '男', '16', '465468@qq.com', '15856458135', '广东', '126e12d9cd004c66bfc822f875944712.jpeg', '高一', '10010', '0110111', '1', null);
INSERT INTO `student` VALUES ('19018300003', '傅利', '111111', '女', '16', '18428@qq.com', '13620698264', '广东', null, '高一', '10010', '0110111', '1', null);
INSERT INTO `student` VALUES ('19018300004', '雷友水', '111111', '男', '15', '784168@qq.com', '15813582462', '广东', null, '高一', '10010', '0110111', '1', null);
INSERT INTO `student` VALUES ('19018300005', '陈茗卓', '111111', '女', '16', '77852168@qq.com', '15843692064', '广东', null, '高一', '10010', '0110111', '1', null);
INSERT INTO `student` VALUES ('19018300006', '史霄灼', '111111', '男', '16', '246541@qq.com', '15843698222', '广东', null, '高一', '10010', '0110111', '1', null);
INSERT INTO `student` VALUES ('19018300007', '杜文渊', '111111', '男', '16', '2564611@qq.com', '15843698204', '长沙', null, '高一', '10010', '0110111', '1', null);
INSERT INTO `student` VALUES ('19018300008', '杜永强', '111111', '男', '16', '115664@qq.com', '15843698230', '广东', null, '高一', '10010', '0110111', '1', null);
INSERT INTO `student` VALUES ('19018300009', '高桂清', '111111', '男', '16', '11561165@qq.com', '15843698269', '北京', null, '高一', '10010', '0110111', '1', null);
INSERT INTO `student` VALUES ('19018300010', '李振云', '111111', '男', '15', '658971@168.com', '16845781245', '广东', null, '高一', '10010', '0110111', '1', null);
INSERT INTO `student` VALUES ('19018300011', '王桂香', '111111', '女', '15', '2864857@qq.com', '18745125623', '广东', null, '高一', '10010', '0110111', '1', null);
INSERT INTO `student` VALUES ('19018300012', '刘东', '111111', '男', '16', '157489113@qq.com', '16878542132', '广东', null, '高一', '10010', '0110111', '1', null);

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `tno` varchar(11) NOT NULL COMMENT '教师编号',
  `tc_name` varchar(25) NOT NULL COMMENT '教师姓名',
  `tc_pwd` varchar(255) NOT NULL DEFAULT '123456' COMMENT '教师密码',
  `tc_sex` char(2) DEFAULT 'm' COMMENT '教师性别',
  `tc_age` int(3) DEFAULT NULL COMMENT '教师年龄',
  `tc_email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `tc_phone` varchar(11) DEFAULT NULL COMMENT '教师电话',
  `tc_picture` varchar(255) DEFAULT NULL COMMENT '教师照片',
  `cla_id` int(20) DEFAULT NULL COMMENT '班级ID',
  `cno` varchar(11) NOT NULL COMMENT '课程编号',
  `role` tinyint(4) DEFAULT '2' COMMENT '角色',
  `course_name` varchar(50) DEFAULT NULL COMMENT '消息ID',
  PRIMARY KEY (`tno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('9102560009', '孙丽萍', '123456', '女', '33', null, null, null, '10010', '0110111', '2', null);
INSERT INTO `teacher` VALUES ('9102560010', '赵王', '123456', '男', '35', '8645272@qq.com', '15623567845', 'c7677b9ad16347b0b47116d806f9c4a0.jpg', '10010', '0110112', '2', null);
INSERT INTO `teacher` VALUES ('9102560011', '李伟', '123456', '男', '33', '123586@qq.com', '16845611234', null, '10010', '0110113', '2', null);
INSERT INTO `teacher` VALUES ('9102560022', '江铃', '123456', '女', '34', '259651@qq.com', '18645671234', null, '10010', '0110114', '2', null);
INSERT INTO `teacher` VALUES ('9102560023', '刘武', '123456', '男', '42', '685249@qq.com', '18745128956', null, '10010', '0110115', '2', null);
INSERT INTO `teacher` VALUES ('9102560024', '王利祥', '123456', '男', '25', null, null, null, '10010', '0110116', '2', null);
INSERT INTO `teacher` VALUES ('9102560025', '鹿林', '123456', '女', '30', '30300@qq.com', '16912347894', null, '10010', '0110117', '2', null);
INSERT INTO `teacher` VALUES ('9102560026', '李开英', '123456', '男', '32', null, null, null, '10010', '0110118', '2', null);
INSERT INTO `teacher` VALUES ('9102560027', '李载誉', '123456', '男', '30', null, null, null, '10010', '0110119', '2', null);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `account` varchar(255) NOT NULL COMMENT '用户账号',
  `user_name` varchar(25) NOT NULL COMMENT '用户姓名',
  `user_pwd` varchar(255) NOT NULL COMMENT '用户密码',
  `user_sex` char(2) DEFAULT 'm' COMMENT '用户性别',
  `user_age` int(3) DEFAULT NULL COMMENT '用户年龄',
  `user_email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `user_phone` varchar(11) NOT NULL COMMENT '用户电话',
  `user_picture` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL COMMENT '用户住址',
  `sno` varchar(11) NOT NULL COMMENT '学生学号',
  `cla_name` varchar(50) DEFAULT NULL COMMENT '学生班级名',
  `stu_name` varchar(25) DEFAULT NULL COMMENT '学生姓名',
  `relation` varchar(10) DEFAULT NULL COMMENT '与学生关系',
  `role` tinyint(4) DEFAULT '3' COMMENT '角色',
  `message_id` int(20) DEFAULT NULL COMMENT '消息ID',
  PRIMARY KEY (`account`),
  UNIQUE KEY `account` (`account`),
  KEY `fk_user_student` (`sno`),
  CONSTRAINT `fk_user_student` FOREIGN KEY (`sno`) REFERENCES `student` (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('123456', '牧尘', '123456', '男', '23', '6588452@qq.com', '15864986532', 'd233d9af86e44fdc921f72b186ef308d.jpeg', '湖南', '19018300001', '高一1901', '牧田', '父亲', '3', null);
