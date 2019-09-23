package edu.hut.hz.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import edu.hut.hz.dao.CourseMapper;
import edu.hut.hz.dao.ScoreMapper;
import edu.hut.hz.pojo.Course;
import edu.hut.hz.pojo.Msg;
import edu.hut.hz.pojo.Score;
import edu.hut.hz.serviceimpl.CourseScoreServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import util.VerifyUtils;

import javax.servlet.http.HttpSession;

/**
 * @ClassName: CourseController
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/4/16 23:10
 * @Version: 1.0
 **/
@Controller
public class CourseScoreController {

    @Autowired
    CourseScoreServiceImpl courseScoreService;

    @Autowired
    CourseMapper courseMapper;

    @Autowired
    ScoreMapper scoreMapper;

    /**
     * 查询所有课程信息
     * @Param
     * @return
     **/
    @RequestMapping(value = "/courseList/{pn}",method = RequestMethod.GET)
    public ModelAndView courseList(@PathVariable("pn") Integer pn, HttpSession session){
        ModelAndView mav = new ModelAndView();

        boolean login = VerifyUtils.verifyLogin(session);
        if (login){
            mav.setViewName("redirect:login.jsp");
            mav.addObject("Fail","请先登录！");
            return mav;
        }

        Msg msg = courseScoreService.courseList(pn);
        mav.setViewName("admin/courseMain");
        mav.addObject("Course",msg);
        return mav;
    }

    /**
     * 查询所有成绩信息
     * @Param
     * @return
     **/
    @RequestMapping(value = "/scoreList/{pn}",method = RequestMethod.GET)
    public ModelAndView scoreList(@PathVariable("pn") Integer pn,HttpSession session){
        ModelAndView mav = new ModelAndView();

        boolean login = VerifyUtils.verifyLogin(session);
        if (login){
            mav.setViewName("redirect:login.jsp");
            mav.addObject("Fail","请先登录！");
            return mav;
        }

        Msg msg = courseScoreService.scoreList(pn);
        mav.setViewName("admin/scoreMain");
        mav.addObject("Score",msg);
        return mav;
    }

    /**
     * 查询一个课程信息
     * @Param
     * @return
     **/
    @RequestMapping(value = "/courseOne/{cno}",method = RequestMethod.GET)
    @ResponseBody
    public Msg courseOne(@PathVariable("cno") String cno){

        Course course = courseMapper.selectOne(new QueryWrapper<Course>().eq("cno", cno));
        return Msg.success().add("Course",course);
    }

    /**
     * 查询一个成绩信息
     * @Param
     * @return
     **/
    @RequestMapping(value = "/scoreOne/{scoreId}",method = RequestMethod.GET)
    @ResponseBody
    public Msg scoreOne(@PathVariable("scoreId") String scoreId){

        Score score = scoreMapper.selectOne(new QueryWrapper<Score>().eq("score_id", scoreId));
        return Msg.success().add("Score",score);
    }

    /**
     * @Description //添加修改课程信息
     * @Param [multipartFile, course]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/newCourseMsg",method = RequestMethod.POST)
    @ResponseBody
    public Msg courseUpdate(MultipartFile multipartFile, Course course){
        return courseScoreService.courseUpdate(multipartFile,course);
    }

    /**
     * @Description //添加修改成绩信息
     * @Param [multipartFile, score]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/newScoreMsg",method = RequestMethod.POST)
    @ResponseBody
    public Msg scoreUpdate(MultipartFile multipartFile, Score score){
        return courseScoreService.scoreUpdate(multipartFile,score);
    }

    /**
     * @Description //课程信息删除
     * @Date 14:43 2019/4/14
     * @Author Carlson
     * @Param []
     * @return java.lang.String
     **/
    @RequestMapping(value = "/course/{cno}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg courseDel(@PathVariable("cno")String cno){
        return courseScoreService.courseOneDelete(cno);
    }

    /**
     * @Description //成绩信息删除
     * @Date 14:43 2019/4/14
     * @Author Carlson
     * @Param []
     * @return java.lang.String
     **/
    @RequestMapping(value = "/score/{scoreId}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg scoreDel(@PathVariable("scoreId")Integer scoreId){
        return courseScoreService.scoreOneDelete(scoreId);
    }

    /**
     * @Description //课程信息新增
     * @Date 17:02 2019/4/15
     * @Author Carlson
     * @Param [course]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/course",method = RequestMethod.POST)
    @ResponseBody
    public Msg courseAdd(Course course){
        return courseScoreService.courseMsgAdd(course);
    }

    /**
     * @Description //成绩信息新增
     * @Date 17:02 2019/4/15
     * @Author Carlson
     * @Param [score]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/score",method = RequestMethod.POST)
    @ResponseBody
    public Msg scoreAdd(Score score){
        System.out.println(score);
        return courseScoreService.scoreMsgAdd(score);
    }

    /**
     * @Description //模糊查询课程信息
     * @Date 18:20 2019/4/15
     * @Author Carlson
     * @Param [msg]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/courseSelect",method = RequestMethod.POST)
    public ModelAndView courseSelMsg(String msg,Integer pn){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin/courseMain");
        mav.addObject("Course",courseScoreService.needCourseMsg(msg,pn));
        return mav;
    }

    /**
     * @Description //模糊查询成绩信息
     * @Date 18:20 2019/4/15
     * @Author Carlson
     * @Param [msg]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/scoreSelect",method = RequestMethod.POST)
    public ModelAndView scoreSelMsg(String msg,Integer pn){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin/scoreMain");
        mav.addObject("Score",courseScoreService.needScoreMsg(msg,pn));
        return mav;
    }
}
