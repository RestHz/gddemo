package edu.hut.hz.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import edu.hut.hz.dao.InvestigateMapper;
import edu.hut.hz.dao.ScoreMapper;
import edu.hut.hz.pojo.*;
import edu.hut.hz.serviceimpl.LoginServiceImpl;
import edu.hut.hz.serviceimpl.ScheduleServiceImpl;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import util.UpDownFileUtils;
import util.VerifyUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description //登录控制器
 * @Date 16:13 2019/4/3
 * @Author Carlson       
 * @Param 
 * @return 
 **/

@Controller
public class LoginController {

    @Resource
    private LoginServiceImpl loginService;

    @Autowired
    private ScoreMapper scoreMapper;

    @Autowired
    private InvestigateMapper investigateMapper;

    @Autowired
    private ScheduleServiceImpl scheduleService;

    @RequestMapping("/login")
    public ModelAndView login(LoginMsg loginMsg, HttpServletRequest request,HttpSession session){
        System.out.println("==================");
        System.out.println(loginMsg);

        //定义返回结果
        ModelAndView mav = new ModelAndView();

        if (loginMsg.getRole() == null){
            mav.setViewName("redirect:index.jsp");
            mav.addObject("LoginMsg","请先登录！");
            return mav;
        }

        //用户加入session
        session.setAttribute("Login",loginMsg);

        //登陆结果
        Msg msg = loginService.login(loginMsg, request);
        int code = msg.getCode();

        if (code == Msg.SUCCESSCODE){
            //管理员
            if (msg.getMsgContent().get("Role").equals(0)){
                //管理员页面
                mav.setViewName("admin/adminTest");
                //管理员信息
                mav.addObject("adminMsg",msg.getMsgContent().get("AdminMsg"));
                return mav;
            }
            //学生
            if (msg.getMsgContent().get("Role").equals(1)){
                //学生信息

                Student student = (Student)msg.getMsgContent().get("StudentMsg");

                Msg allMsg = studentAllMsg(student);

                Object scoreList = allMsg.getMsgContent().get("ScoreMsg");
                Object yearTermList = allMsg.getMsgContent().get("ExamYearTerm");
                Object statisticList = allMsg.getMsgContent().get("Statistic");
                Object stuStatisticList = allMsg.getMsgContent().get("StuStatistic");


                mav.addObject("studentMsg",student);
                mav.addObject("ScoreMsg",scoreList);
                mav.addObject("ExamYearTerm",yearTermList);
                mav.addObject("Statistic",statisticList);
                mav.addObject("StuStatistic",stuStatisticList);
                //学生页面
                mav.setViewName("student");
                return mav;
            }
            if (msg.getMsgContent().get("Role").equals(2)){
                //教师信息
                mav.addObject("teacherMsg",msg.getMsgContent().get("TeacherMsg"));
                //班级信息
                mav.addObject("clasMsg",msg.getMsgContent().get("ClasMsg"));
                //教师页面
                mav.setViewName("teacher");
                return mav;
            }
            if (msg.getMsgContent().get("Role").equals(3)){
                //家长信息
                User userOut = (User) msg.getMsgContent().get("UserMsg");
                //判断是否有头像
                if (userOut.getUserPicture() != null && !"".equals(userOut.getUserPicture())){
                    //如果有图片设置头像访问路径
                    userOut.setUserPicture(UpDownFileUtils.DOMAIN + "image?imageName=" + userOut.getUserPicture());
                }
                mav.addObject("userMsg",userOut);
                //学生信息
                Student student = (Student) msg.getMsgContent().get("StudentMsg");
                //家长页面
                mav.setViewName("user");
                Msg allMsg = studentAllMsg(student);

                Object scoreList = allMsg.getMsgContent().get("ScoreMsg");
                Object yearTermList = allMsg.getMsgContent().get("ExamYearTerm");
                Object statisticList = allMsg.getMsgContent().get("Statistic");
                Object stuStatisticList = allMsg.getMsgContent().get("StuStatistic");

                Integer claId = student.getClaId();
                Msg msgSchedule = scheduleService.scheduleOneClass(claId);

                if (msgSchedule.getCode() == 200){
                    //返回对应班级课表
                    mav.addObject("ScheduleMsg",msgSchedule.getMsgContent().get("scheduleList"));
                    //返回班级信息
                    mav.addObject("ClassMsg",msgSchedule.getMsgContent().get("clas"));
                    //返回学年学期信息
                    mav.addObject("YearTermsMsg",msgSchedule.getMsgContent().get("yearTerms"));

                }else {
                    //返回失败结果
                    mav.addObject("Fail",msgSchedule.getMsgContent().get("Fail"));
                }
                mav.addObject("studentMsg",student);
                mav.addObject("ScoreMsg",scoreList);
                mav.addObject("ExamYearTerm",yearTermList);
                mav.addObject("Statistic",statisticList);
                mav.addObject("StuStatistic",stuStatisticList);
                return mav;
            }
            return mav;
        }else {
            if (loginMsg.getRole() == 0){
                //错误信息
                mav.addObject("ERROR",msg);
                //错误页面
                mav.setViewName("forward:admin.jsp");
                return mav;
            }
            //错误信息
            mav.addObject("ERROR",msg);
            //错误页面
            mav.setViewName("forward:index.jsp");
            return mav;
        }
    }

    @RequestMapping(value = "/loginOut")
    public String loginOut(HttpServletRequest request,HttpSession session){
        //清除session
        session.setAttribute("Login",null);
        request.setAttribute("checkCode","");
        return "redirect:index.jsp";
    }

    private Msg studentAllMsg(Student student){

        Msg msg = new Msg();

        //成绩信息
        List<Score> yearTermList = scoreMapper.selectList(new QueryWrapper<Score>().
                groupBy("exam_year").groupBy("exam_term"));
        List<Score> scoreList = new ArrayList<>();
        List<Statistic> stuStatisticList = new ArrayList<>();
        for (Score s:yearTermList) {
            List<Score> scoreList1 = scoreMapper.selectList(new QueryWrapper<Score>().
                    eq("sno", student.getSno()).eq("exam_year",s.getExamYear()).
                    eq("exam_term",s.getExamTerm()));
            scoreList.addAll(scoreList1);
            Statistic statistic = new Statistic();
            //个人成绩统计
            Double stuScoreSum = scoreMapper.stuScoreSum(s);
            Double stuScoreAvg = scoreMapper.stuScoreAvg(s);
            statistic.setStaName(student.getStuName());
            statistic.setStaMaxData(stuScoreSum);
            statistic.setStaAvgData(stuScoreAvg);
            stuStatisticList.add(statistic);
        }

        //科目统计
        List<Score> courseScoreList = scoreMapper.selectList(new QueryWrapper<Score>().groupBy("course_name").
                groupBy("exam_year").groupBy("exam_term"));
        List<Statistic> statisticList = new ArrayList<>();
        for (Score cs:courseScoreList) {
            Double max = scoreMapper.scoreMax(cs);
            Double avg = scoreMapper.scoreAvg(cs);
            Statistic statistic = new Statistic();
            statistic.setStaName(cs.getCourseName());
            statistic.setStaMaxData(max);
            statistic.setStaAvgData(avg);
            statisticList.add(statistic);
        }

        msg.add("studentMsg",student);
        msg.add("ScoreMsg",scoreList);
        msg.add("ExamYearTerm",yearTermList);
        msg.add("Statistic",statisticList);
        msg.add("StuStatistic",stuStatisticList);

        return msg;
    }
}

