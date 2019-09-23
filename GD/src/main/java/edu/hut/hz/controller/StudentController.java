package edu.hut.hz.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import edu.hut.hz.pojo.Msg;
import edu.hut.hz.pojo.Student;
import edu.hut.hz.pojo.Teacher;
import edu.hut.hz.serviceimpl.ModifyOperationServiceImpl;
import edu.hut.hz.serviceimpl.StudentServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import util.VerifyUtils;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * @ClassName: StudentController
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/4/3 16:21
 * @Version: 1.0
 **/
@Controller
public class StudentController {

    @Autowired
    StudentServiceImpl studentService;

    @Autowired
    ModifyOperationServiceImpl modifyOperationService;

    /**
     * @Description //查询所有学生分页信息
     * @Date 15:59 2019/4/4
     * @Author Carlson
     * @Param [pn]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/studentList/{pn}",method = RequestMethod.GET)
    public ModelAndView studentList(@PathVariable("pn")Integer pn, HttpSession session){
        ModelAndView mav = new ModelAndView();

        boolean login = VerifyUtils.verifyLogin(session);
        if (login){
            mav.setViewName("redirect:login.jsp");
            mav.addObject("Fail","请先登录！");
            return mav;
        }

        mav.setViewName("admin/studentMain");
        mav.addObject("Student",studentService.studentList(pn));
        return mav;
    }

    /**
     * @Description //根据学号查询一个学生信息
     * @Date 15:59 2019/4/4
     * @Author Carlson
     * @Param [pn]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/studentOne/{sno}",method = RequestMethod.GET)
    @ResponseBody
    public Msg studentList(@PathVariable("sno") String sno){

        Student student = studentService.getOne(new QueryWrapper<Student>().eq("sno", sno));
        return Msg.success().add("Student",student);
    }

    /**
     * 学生信息修改页面
     * @Param
     * @return
     **/
    @RequestMapping(value = "/stuUpdatePage/{sno}",method = RequestMethod.GET)
    public ModelAndView stuUpdatePage(@PathVariable("sno") String sno,HttpSession session){

        //返回信息
        ModelAndView mav = new ModelAndView();
        boolean login = VerifyUtils.verifyLogin(session);
        if (login){
            mav.setViewName("redirect:index.jsp");
            mav.addObject("Fail","请先登录！");
            return mav;
        }
        //返回更新页面
        mav.setViewName("stuUpdate");
        //设置数据
        Student student = studentService.getById(sno);
        mav.addObject("Student",student);

        return mav;
    }

    /**
     * @Description //添加修改学生信息
     * @Date 21:51 2019/4/5
     * @Author Carlson
     * @Param [multipartFile, student]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/newStudentMsg",method = RequestMethod.POST)
    @ResponseBody
    public Msg studentUpdate(MultipartFile multipartFile, Student student){
        return studentService.studentUpdate(multipartFile,student);
    }

    /**
     * @Description //学生信息修改(头像和密码修改)
     * @Date 22:00 2019/4/5
     * @Author Carlson       
     * @Param [multipartFile, student]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/studentMsg",method = RequestMethod.POST)
    @ResponseBody
    public Msg studentAlter(@RequestParam(value = "imageFile", required = false, defaultValue = "") MultipartFile imageFile,
                                     Student student, @RequestParam(value = "newPwd", required = false, defaultValue = "") String newPwd){


        try {
            return studentService.studentAlter(imageFile, student, newPwd);

        } catch (Exception e) {
            System.out.println("文件流错误:"+e.getMessage());
        }
        return Msg.fail();
    }

    /**
     * @Description //学生详细查询
     * @Date 14:35 2019/4/11
     * @Author Carlson
     * @Param [student]
     * @return void
     **/
    @RequestMapping(value = "/studentSelAll",method = RequestMethod.GET)
    public ModelAndView studentScoreSel(Student student){
        ModelAndView mav = new ModelAndView();
        Msg msg = studentService.studentScore(student);
        Msg msg1 = studentService.studentCourse(student);
        Msg msg2 = studentService.studentClass(student);
        mav.setViewName("admin/courseMain");
        mav.addObject("SCORE",msg.getMsgContent().get("Scores"));
        mav.addObject("COURSE",msg1.getMsgContent().get("Courses"));
        mav.addObject("CLASS",msg2.getMsgContent().get("Clas"));
        mav.addObject("TEACHER",msg2.getMsgContent().get("Teacher"));
        return mav;
    }

    /**
     * @Description //下载学生Excel表格
     * @Date 18:01 2019/4/6
     * @Author Carlson
     * @Param [response]
     * @return void
     **/
    @RequestMapping(value = "/studentAllMsg",method = RequestMethod.GET)
    public void studentAlter(HttpServletResponse response){
        modifyOperationService.excelDownLoad(response);
    }


    /**
     * @Description //学生信息删除
     * @Date 14:43 2019/4/14
     * @Author Carlson
     * @Param []
     * @return java.lang.String
     **/
    @RequestMapping(value = "/student/{sno}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg studentDel(@PathVariable("sno")String sno){
        return studentService.studentOneDelete(sno);
    }


    /**
     * @Description //学生信息新增
     * @Date 17:02 2019/4/15
     * @Author Carlson
     * @Param [student]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/student",method = RequestMethod.POST)
    @ResponseBody
    public Msg studentAdd(Student student){
        return studentService.studentMsgAdd(student);
    }


    /**
     * @Description //模糊查询学生信息
     * @Date 18:20 2019/4/15
     * @Author Carlson
     * @Param [msg]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/studentSelect",method = RequestMethod.POST)
    public ModelAndView studentSelMsg(String msg,Integer pn){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin/studentMain");
        mav.addObject("Student",studentService.needStudentMsg(msg,pn));
        return mav;
    }
}

