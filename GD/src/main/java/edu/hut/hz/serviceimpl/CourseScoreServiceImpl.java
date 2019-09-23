package edu.hut.hz.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.hut.hz.dao.CourseMapper;
import edu.hut.hz.dao.ScoreMapper;
import edu.hut.hz.dao.StudentMapper;
import edu.hut.hz.dao.TeacherMapper;
import edu.hut.hz.pojo.*;
import edu.hut.hz.service.CourseScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName: CourseScoreServiceImpl
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/4/16 23:15
 * @Version: 1.0
 **/
@Service
public class CourseScoreServiceImpl implements CourseScoreService {

    @Autowired
    CourseMapper courseMapper;

    @Autowired
    ScoreMapper scoreMapper;

    @Autowired
    TeacherMapper teacherMapper;

    @Autowired
    StudentMapper studentMapper;

    /**
     * 所有课程信息
     * @Param
     * @return
     **/
    @Override
    public Msg courseList(Integer pn) {
        //引入分页插件
        //传入页码以及每页大小
        PageHelper.startPage(pn,7);
        List<Course> list = courseMapper.selectList(new QueryWrapper<>());
        //使用PageInfo包装查询结果
        //封装了页面详细信息，包括list数据库查询出的数据，第二参数传入连续显示的页数
        PageInfo page = new PageInfo(list,5);
        return Msg.success().add("pageInfo",page);
    }

    /**
     * 所有成绩信息
     * @Param
     * @return
     **/
    @Override
    public Msg scoreList(Integer pn) {
        //引入分页插件
        //传入页码以及每页大小
        PageHelper.startPage(pn,7);
        List<Score> list = scoreMapper.selectList(new QueryWrapper<>());
        //使用PageInfo包装查询结果
        //封装了页面详细信息，包括list数据库查询出的数据，第二参数传入连续显示的页数
        PageInfo page = new PageInfo(list,5);
        return Msg.success().add("pageInfo",page);
    }

    /**
     * 更新课程信息
     * @param multipartFile
     * @param
     * @return
     */
    @Override
    public Msg courseUpdate(MultipartFile multipartFile, Course course) {

        /**
         * 更新一个课程信息
         */
        if (course != null && !"".equals(course.getCno())){
            //判断是否有新信息
            Course course1 = courseMapper.selectById(course.getCno());
            if (course.equals(course1)){
                return Msg.fail().add("Fail","无信息更新!");
            }
            //更新信息
            int update = courseMapper.update(course,new QueryWrapper<Course>().eq("cno",course.getCno()));
            if (update > 0){
                return Msg.success().add("Success","更新数据成功!");
            }else {
                return Msg.fail().add("Fail","更新失败,请重试!");
            }
        }
        return Msg.fail().add("Fail","没有可以更新的课程!");
    }

    /**
     * 更新成绩信息
     * @param multipartFile
     * @param
     * @return
     */
    @Override
    public Msg scoreUpdate(MultipartFile multipartFile, Score score) {

        /**
         * 更新一个课程信息
         */
        if (score != null && !"".equals(score.getSno())){
            //更新信息
            int update = scoreMapper.update(score,new QueryWrapper<Score>().eq("score_id",score.getScoreId()));
            if (update > 0){
                return Msg.success().add("Success","更新数据成功!");
            }else {
                return Msg.fail().add("Fail","更新失败,请重试!");
            }
        }
        return Msg.fail().add("Fail","没有可以更新的成绩!");
    }

    /**
     * 根据课程号，删除课程基本信息和老师学生信息
     * @param
     * @return
     */
    @Override
    public Msg courseOneDelete(String cno){

        //先其他信息删除
        int delete2 = teacherMapper.delete(new QueryWrapper<Teacher>().eq("cno",cno));
        int delete3 = studentMapper.delete(new QueryWrapper<Student>().eq("cno", cno));
        //老师信息删除
        int delete1 = courseMapper.deleteById(cno);

        if (delete1 > 0 || delete2 > 0 || delete3 > 0){
            return Msg.success().add("Success","删除成功！");
        }
        return Msg.fail().add("Fail","删除失败！");
    }

    /**
     * 根据成绩编号，删除成绩
     * @param
     * @return
     */
    @Override
    public Msg scoreOneDelete(Integer scoreId){

        //成绩信息删除
        int delete1 = scoreMapper.delete(new QueryWrapper<Score>().eq("score_id",scoreId));

        if (delete1 > 0){
            return Msg.success().add("Success","删除成功！");
        }
        return Msg.fail().add("Fail","删除失败！");
    }

    /**
     * 添加课程
     * @Param
     * @return
     **/
    @Override
    public Msg courseMsgAdd(Course course){

        //判断课程号是否存在
        Course course1 = courseMapper.selectById(course.getCno());
        if (course1 != null){
            return Msg.fail().add("Fail","课程号已存在！");
        }
        //添加课程信息
        int insert = courseMapper.insert(course);
        if (insert > 0){
            return Msg.success().add("Success","添加成功！");
        }
        //添加失败
        return Msg.fail().add("Fail","添加失败！");
    }

    /**
     * 添加成绩
     * @Param
     * @return
     **/
    @Override
    public Msg scoreMsgAdd(Score score){

        //判断学生，课程是否存在
        Course course = courseMapper.selectOne(new QueryWrapper<Course>().eq("course_name", score.getCourseName()));

        Student student = studentMapper.selectOne(new QueryWrapper<Student>().eq("stu_name", score.getStuName()));

        if (course == null){
            return Msg.fail().add("Fail","课程不存在！");
        }
        if (student == null){
            return Msg.fail().add("Fail","无此学生！");
        }

        //判断学生是否选此课程
        Integer selectCount = studentMapper.selectCount(new QueryWrapper<Student>().
                eq("sno", student.getSno()).eq("cno", course.getCno()));

        if (selectCount < 1){
            return Msg.fail().add("Fail",score.getStuName()+"学生没有选择"+score.getCourseName()+"课程,没有成绩！");
        }

        //获取课程教师信息
        Teacher teacher = teacherMapper.selectOne(new QueryWrapper<Teacher>().eq("cno", course.getCno()));

        //完善成绩信息
        score.setCno(course.getCno());
        score.setSno(student.getSno());
        score.setTno(teacher.getTno());

        //添加成绩信息
        int insert = scoreMapper.insert(score);
        if (insert > 0){
            return Msg.success().add("Success","添加成功！");
        }
        //添加失败
        return Msg.fail().add("Fail","添加失败！");
    }

    /**
     * 查询需要的课程信息(可模糊查询)
     * @Param
     * @return
     **/
    @Override
    public Msg needCourseMsg(String msg,Integer pn){

        //查询数据
        List<Course> courses = new ArrayList<>();

        if (pn == 0){
            //模糊查询
            List<Course> courseList1 = courseMapper.courseNeedSelect(msg);
            if (!courseList1.isEmpty()){
                //添加查询数据
                courses.addAll(courseList1);
            }
        }

        if (pn == 1){
            //查询课程号
            List<Course> courseList2 = courseMapper.selectList(new QueryWrapper<Course>().eq(true, "cno",msg));
            if (!courseList2.isEmpty()){
                //添加查询数据
                courses.addAll(courseList2);
            }
        }

        if (pn == 2){
            //查询课程名
            List<Course> courseList3 = courseMapper.selectList(new QueryWrapper<Course>().eq(true, "course_name",msg));
            if (!courseList3.isEmpty()){
                courses.addAll(courseList3);
            }
        }

        //查询出数据返回
        if (!courses.isEmpty()){
            //引入分页插件
            //传入页码以及每页大小
            PageHelper.startPage(1,courses.size());
            //使用PageInfo包装查询结果
            //封装了页面详细信息，包括list数据库查询出的数据，第二参数传入连续显示的页数
            PageInfo page = new PageInfo(courses,1);
            return Msg.success().add("pageInfo",page);
        }
        return Msg.fail().add("Fail","没有查询到关于: ” "+msg+" “ 的数据");
    }

    /**
     * 查询需要的成绩信息(可模糊查询)
     * @Param
     * @return
     **/
    @Override
    public Msg needScoreMsg(String msg,Integer pn){

        //查询数据
        List<Score> scores = new ArrayList<>();

        if (pn == 0){
            //模糊查询
            List<Score> scoreList1 = scoreMapper.scoreNeedSelect(msg);
            if (!scoreList1.isEmpty()){
                //添加查询数据
                scores.addAll(scoreList1);
            }
        }

        if (pn == 1){
            //查询学年成绩
            List<Score> scoreList2 = scoreMapper.selectList(new QueryWrapper<Score>().eq("exam_year",msg));
            if (!scoreList2.isEmpty()){
                //添加查询数据
                scores.addAll(scoreList2);
            }
        }

        if (pn == 2){
            //查询学期
            List<Score> scoreList3 = scoreMapper.selectList(new QueryWrapper<Score>().eq("exam_term",msg));
            if (!scoreList3.isEmpty()){
                scores.addAll(scoreList3);
            }
        }

        if (pn == 3){
            //查询课程成绩
            List<Score> scoreList4 = scoreMapper.selectList(new QueryWrapper<Score>().eq("course_name",msg));
            if (!scoreList4.isEmpty()){
                scores.addAll(scoreList4);
            }
        }

        if (pn == 4){
            //查询班级成绩
            List<Score> scoreList5 = scoreMapper.selectList(new QueryWrapper<Score>().eq("cla_name",msg));
            if (!scoreList5.isEmpty()){
                scores.addAll(scoreList5);
            }
        }

        if (pn == 5){
            //查询学生成绩
            List<Score> scoreList6 = scoreMapper.selectList(new QueryWrapper<Score>().eq("stu_name",msg));
            if (!scoreList6.isEmpty()){
                scores.addAll(scoreList6);
            }
        }

        //查询出数据返回
        if (!scores.isEmpty()){
            //引入分页插件
            //传入页码以及每页大小
            PageHelper.startPage(1,scores.size());
            //使用PageInfo包装查询结果
            //封装了页面详细信息，包括list数据库查询出的数据，第二参数传入连续显示的页数
            PageInfo page = new PageInfo(scores,1);
            return Msg.success().add("pageInfo",page);
        }
        return Msg.fail().add("Fail","没有查询到关于: ” "+msg+" “ 的数据");
    }


    /**
     * 一个学生所有课程信息
     * @Param
     * @return
     **/
    @Override
    public Msg scoreListBySno(String sno,Integer pn) {
        //引入分页插件
        //传入页码以及每页大小
        PageHelper.startPage(pn,7);
        List<Score> list = scoreMapper.selectList(new QueryWrapper<Score>().eq("sno",sno));
        //学生信息
        Student student = studentMapper.selectById(sno);
        //使用PageInfo包装查询结果
        //封装了页面详细信息，包括list数据库查询出的数据，第二参数传入连续显示的页数
        PageInfo page = new PageInfo(list,5);
        return Msg.success().add("pageInfo",page).add("student",student);
    }
}
