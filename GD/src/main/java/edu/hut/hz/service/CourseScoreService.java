package edu.hut.hz.service;

import edu.hut.hz.pojo.Course;
import edu.hut.hz.pojo.Msg;
import edu.hut.hz.pojo.Score;
import org.springframework.web.multipart.MultipartFile;

/**
 * @Description: 课程及成绩服务
 * @Author: Carlson
 * @Date 2019/4/16 23:14
 **/
public interface CourseScoreService {

    /**
     * @Description //获取课程信息
     * @Date 23:14 2019/4/3
     * @Author Carlson
     * @Param [pn]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg courseList(Integer pn);

    /**
     * @Description //获取成绩信息
     * @Date 23:14 2019/4/3
     * @Author Carlson
     * @Param [pn]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg scoreList(Integer pn);

    /**
     * @Description //课程信息更新
     * @Date 16:02 2019/4/4
     * @Author Carlson
     * @Param [multipartFile, score]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg courseUpdate(MultipartFile multipartFile, Course course);

    /**
     * @Description //成绩信息更新
     * @Date 16:02 2019/4/4
     * @Author Carlson
     * @Param [multipartFile, score]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg scoreUpdate(MultipartFile multipartFile, Score score);


    /**
     * @Description //删除一个课程信息
     * @Date 16:04 2019/4/14
     * @Author Carlson
     * @Param [String]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg courseOneDelete(String cno);

    /**
     * @Description //删除一个成绩信息
     * @Date 16:04 2019/4/14
     * @Author Carlson
     * @Param [Integer]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg scoreOneDelete(Integer scoreId);

    /**
     * @Description //单个课程信息新增
     * @Date 16:59 2019/4/15
     * @Author Carlson
     * @Param [score]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg courseMsgAdd(Course course);

    /**
     * @Description //单个成绩信息新增
     * @Date 16:59 2019/4/15
     * @Author Carlson
     * @Param [score]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg scoreMsgAdd(Score score);

    /**
     * @Description //查询课程信息（可模糊查询）
     * @Date 22:56 2019/4/15
     * @Author Carlson
     * @Param [msg：查询的信息, pn：查询的类型]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg needCourseMsg(String msg,Integer pn);

    /**
     * @Description //查询成绩信息（可模糊查询）
     * @Date 22:56 2019/4/15
     * @Author Carlson
     * @Param [msg：查询的信息, pn：查询的类型]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg needScoreMsg(String msg,Integer pn);


    /**
     * @Description //查询一个学生所有信息
     * @Date 17:54 2019/4/20
     * @Author Carlson
     * @Param [sno, pn]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg scoreListBySno(String sno,Integer pn);
}
