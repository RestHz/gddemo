package edu.hut.hz.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.hut.hz.dao.ClasMapper;
import edu.hut.hz.dao.CourseMapper;
import edu.hut.hz.dao.ScoreMapper;
import edu.hut.hz.dao.StudentMapper;
import edu.hut.hz.pojo.*;
import edu.hut.hz.serviceimpl.TeacherServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import util.VerifyUtils;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName: TeacherController
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/4/13 15:13
 * @Version: 1.0
 **/
@Controller
public class TeacherController {

    @Autowired
    private TeacherServiceImpl teacherService;

    @Autowired
    ScoreMapper scoreMapper;

    @Autowired
    StudentMapper studentMapper;

    @Autowired
    CourseMapper courseMapper;

    @Autowired
    ClasMapper clasMapper;

    /**
     * 查询所有老师信息
     * @Param
     * @return
     **/
    @RequestMapping(value = "/teacherList/{pn}",method = RequestMethod.GET)
    public ModelAndView teacherList(@PathVariable("pn") Integer pn, HttpSession session){

        ModelAndView mav = new ModelAndView();

        boolean login = VerifyUtils.verifyLogin(session);
        if (login){
            mav.setViewName("redirect:login.jsp");
            mav.addObject("Fail","请先登录！");
            return mav;
        }

        Msg msg = teacherService.teacherList(pn);
        mav.setViewName("admin/teacherMain");
        mav.addObject("Teacher",msg);
        return mav;

    }

    /**
     * 查询一个老师信息
     * @Param
     * @return
     **/
    @RequestMapping(value = "/teacherOne/{tno}",method = RequestMethod.GET)
    @ResponseBody
    public Msg teacherOne(@PathVariable("tno") String tno){

        Teacher teacher = teacherService.getOne(new QueryWrapper<Teacher>().eq("tno", tno));
        return Msg.success().add("Teacher",teacher);
    }

    /**
     * 老师信息修改
     * @Param
     * @return
     **/
    @RequestMapping(value = "/teaUpdateGet/{tno}",method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView teaUpdateGet(@PathVariable("tno") String tno,HttpSession session){
        //返回信息
        ModelAndView mav = new ModelAndView();
        boolean login = VerifyUtils.verifyLogin(session);
        if (login){
            mav.setViewName("redirect:index.jsp");
            mav.addObject("Fail","请先登录！");
            return mav;
        }
        //返回更新页面
        mav.setViewName("teaUpdate");
        //设置数据
        Teacher teacher = teacherService.getById(tno);
        mav.addObject("Teacher",teacher);

        return mav;
    }

    /**
     * @Description //添加修改老师信息
     * @Param [multipartFile, teacher]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/newTeacherMsg",method = RequestMethod.POST)
    @ResponseBody
    public Msg teacherUpdate(MultipartFile multipartFile, Teacher teacher){
        return teacherService.teacherUpdate(multipartFile,teacher);
    }

    /**
     * @Description //老师信息修改(头像和密码修改)
     * @Date 22:00 2019/4/5
     * @Author Carlson
     * @Param [multipartFile, student]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/teacherMsgUpdate")
    @ResponseBody
    public Msg teacherAlter(@RequestParam(value = "imageFile", required = false, defaultValue = "") MultipartFile imageFile,
            Teacher teacher, @RequestParam(value = "newPwd", required = false, defaultValue = "") String newPwd){
        System.out.println(teacher);
        try {
            return teacherService.teacherAlter(imageFile,teacher, newPwd);
        } catch (Exception e) {
            System.out.println("文件流错误:"+e.getMessage());
        }
        return Msg.fail();
    }

    /**
     * @Description //老师信息删除
     * @Date 14:43 2019/4/14
     * @Author Carlson
     * @Param []
     * @return java.lang.String
     **/
    @RequestMapping(value = "/teacher/{tno}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg teacherDel(@PathVariable("tno")String tno){
        return teacherService.teacherOneDelete(tno);
    }

    /**
     * @Description //老师信息新增
     * @Date 17:02 2019/4/15
     * @Author Carlson
     * @Param [teacher]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/teacher",method = RequestMethod.POST)
    @ResponseBody
    public Msg teacherAdd(Teacher teacher){
        return teacherService.teacherMsgAdd(teacher);
    }

    /**
     * @Description //模糊查询老师信息
     * @Date 18:20 2019/4/15
     * @Author Carlson
     * @Param [msg]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/teacherSelect",method = RequestMethod.POST)
    public ModelAndView teacherSelMsg(String msg,Integer pn){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin/teacherMain");
        mav.addObject("Teacher",teacherService.needTeacherMsg(msg,pn));
        return mav;
    }

    @RequestMapping(value = "/teacher",method = RequestMethod.GET)
    public String teacher(){

        return "admin/teacherMain";

    }

    /**
     * @Description //成绩信息管理页面
     **/
    @RequestMapping(value = "/teaScoreManege")
    public ModelAndView teaScoreManege(String tno,Integer pn){
        ModelAndView mav = new ModelAndView();

        //引入分页插件
        //传入页码以及每页大小
        PageHelper.startPage(pn,7);
        //使用PageInfo包装查询结果
        List<Score> list = scoreMapper.selectList(new QueryWrapper<Score>().eq("tno", tno));
        //封装了页面详细信息，包括list数据库查询出的数据，第二参数传入连续显示的页数
        PageInfo page = new PageInfo(list,5);

        mav.setViewName("scoreTea");

        mav.addObject("ScoreList",page);
        mav.addObject("Tno",tno);
        return mav;
    }

    /**
     * @Description //家长根据班级名称获取老师姓名
     * @Date 14:38 2019/5/2
     * @Author Carlson
     * @Param [claName]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/userTeaList")
    @ResponseBody
    public Msg getTeaList(Clas claName){

        Clas cla_name = clasMapper.selectOne(new QueryWrapper<Clas>().eq("cla_name", claName.getClaName()));

        //获取用户列表
        List<Teacher> teaList1 = teacherService.list(new QueryWrapper<Teacher>().eq("cla_id", cla_name.getClaId()));
        if (teaList1.size() == 0){
            return Msg.fail().add("Fail","没有获取到用户信息");
        }
        List<Teacher> teaList = new ArrayList<>();
        for (Teacher teacher:teaList1) {
            Course course = courseMapper.selectById(teacher.getCno());
            Teacher teacher1 = teacher.setCourseName(course.getCourseName());
            teaList.add(teacher1);
        }
        return Msg.success().add("TeaList",teaList);
    }
}
