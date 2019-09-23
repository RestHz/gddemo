package edu.hut.hz.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import edu.hut.hz.dao.ClasMapper;
import edu.hut.hz.dao.CourseMapper;
import edu.hut.hz.pojo.Clas;
import edu.hut.hz.pojo.Course;
import edu.hut.hz.pojo.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @ClassName: InformationController
 * @Description: 课程，班级，成绩
 * @Author: Carlson
 * @Date 2019/4/13 21:43
 * @Version: 1.0
 **/
@RestController
public class InformationController {
    
    @Autowired
    ClasMapper clasMapper;

    @Autowired
    CourseMapper courseMapper;

    @RequestMapping("/classList")
    public Msg getClassList(){

        List<Clas> clas = clasMapper.selectList(new QueryWrapper<>());

        return Msg.success().add("ClassList",clas);
    }


    @RequestMapping("/courseList")
    public Msg getCourseList(){

        List<Course> courses = courseMapper.selectList(new QueryWrapper<>());

        return Msg.success().add("CourseList",courses);
    }
}
