package edu.hut.hz.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.github.pagehelper.PageHelper;
import edu.hut.hz.dao.ClasMapper;
import edu.hut.hz.dao.InvestigateMapper;
import edu.hut.hz.dao.StudentMapper;
import edu.hut.hz.dao.TeacherMapper;
import edu.hut.hz.pojo.*;
import edu.hut.hz.serviceimpl.InvestigateServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import util.CalendarUtils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @ClassName: InvestigateController
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/4/27 15:00
 * @Version: 1.0
 **/

@Controller
public class InvestigateController {

    @Autowired
    InvestigateServiceImpl investigateService;

    @Autowired
    InvestigateMapper investigateMapper;

    @Autowired
    StudentMapper studentMapper;

    @Autowired
    ClasMapper clasMapper;

    @Autowired
    TeacherMapper teacherMapper;

    /**
     * 班级考勤
     * @Param
     * @return
     **/
    @RequestMapping(value = "/investigate")
    public ModelAndView investigateClas(Clas clas){
        ModelAndView mav = new ModelAndView();

        //根据班级跟班主任，获取班级学生考勤
        Msg msg = investigateService.investigateGet(clas);

        mav.addObject("Student",msg.getMsgContent().get("studentMsg"));
        mav.addObject("Clas",msg.getMsgContent().get("clasMsg"));
        mav.addObject("Teacher",msg.getMsgContent().get("teacherMsg"));

        Calendar calendar = Calendar.getInstance();
        mav.addObject("Year",calendar.getWeekYear());
        mav.addObject("Mouth",calendar.get(Calendar.MONTH)+1);
        mav.addObject("Day",calendar.get(Calendar.DAY_OF_MONTH));

        String week = CalendarUtils.weekDay();

        mav.addObject("WeekDay",week);

        mav.setViewName("/investigate/investigate");

        return mav;
    }

    /**
     * @Description //考勤信息添加
     * @Date 18:09 2019/4/27
     * @Author Carlson       
     * @Param []
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/investigateMsg",method = RequestMethod.POST)
    @ResponseBody
    public Msg investigateMsgAdd(Investigate investigate){

        //添加时间
        //设置日期格式
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String week = CalendarUtils.weekDay();
        // new Date()为获取当前系统时间，设置留言时间
        investigate.setAddTime(df.format(new Date())+" "+week);

        int insert = investigateMapper.insert(investigate);

        if (insert < 1){
            return Msg.fail().add("Fail","添加失败！");
        }
        return Msg.success().add("Success","添加成功！");
    }

    /**
     * @Description //考勤信息管理
     * @Date 18:09 2019/4/27
     * @Author Carlson
     * @Param []
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/investigateEdit",method = RequestMethod.POST)
    public ModelAndView investigateEdit(String tno , Integer pn){

        ModelAndView mav = new ModelAndView();

        //考勤统计
        Teacher teacher = teacherMapper.selectById(tno);
        Clas clas = clasMapper.selectById(teacher.getClaId());
        InvStatistic invStatistic = new InvStatistic();
        invStatistic.setClaName(clas.getClaName());
        invStatistic.setExamYear("2019");

        List<InvStatistic> invStaByWeek = investigateMapper.invStaByWeek(invStatistic);
        List<InvStatistic> invStaByMonth = investigateMapper.invStaByMonth(invStatistic);
        List<InvStatistic> invStaByMonthLastTerm = investigateMapper.invStaByMonthLastTerm(invStatistic);
        List<InvStatistic> invStaByNextTerm = investigateMapper.invStaByNextTerm(invStatistic);

        //返回信息
        mav.addObject("Investigate",investigateService.investigateList(tno,pn));
        mav.addObject("Tno",tno);
        mav.addObject("InvStaByWeek",invStaByWeek);
        mav.addObject("InvStaByMonth",invStaByMonth);
        mav.addObject("InvStaByLastTerm",invStaByMonthLastTerm);
        mav.addObject("InvStaByNextTerm",invStaByNextTerm);
        mav.addObject("InvStatistic",invStatistic);

        mav.setViewName("investigate/investigateEdit");
        return mav;
    }

    /**
     * @Description //获取一个考勤信息
     * @Date 18:09 2019/4/27
     * @Author Carlson
     * @Param []
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/investigateOne/{invId}",method = RequestMethod.GET)
    @ResponseBody
    public Msg investigateOne(@PathVariable("invId") Integer invId){

        Investigate investigate = investigateService.getById(invId);

        return Msg.success().add("Investigate",investigate);
    }

    /**
     * @Description //考勤信息修改
     * @Date 18:09 2019/4/27
     * @Author Carlson
     * @Param []
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/investigateUpdate",method = RequestMethod.POST)
    @ResponseBody
    public Msg investigateUpdate(Investigate investigate){
        //更新时间
        //设置日期格式
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String week = CalendarUtils.weekDay();
        // new Date()为获取当前系统时间，设置时间
        investigate.setAddTime(df.format(new Date())+" "+week);

        int update = investigateMapper.update(investigate, new UpdateWrapper<Investigate>().eq("inv_id", investigate.getInvId()));

        if (update < 1){
            return Msg.fail().add("Fail","修改失败！");
        }

        return Msg.success().add("Success","修改成功！");
    }

    /**
     * 考勤信息删除
     * @Param
     * @return
     **/
    @RequestMapping(value = "/investigate/{invId}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg investigateDelete(@PathVariable("invId") String invId){
        System.out.println(invId);

        int delete = investigateMapper.deleteById(invId);

        if (delete < 1){
            return Msg.fail().add("Fail","删除失败！");
        }

        return Msg.success().add("Success","删除成功！");
    }

    /**
     * 学生个人考勤信息
     * @Param
     * @return
     **/
    @RequestMapping(value = "/studentInvestigateMsg",method = RequestMethod.GET)
    public ModelAndView studentInvestigateMsg(String sno){
        ModelAndView mav = new ModelAndView();

        List<Investigate> investigateList = investigateMapper.selectList(new QueryWrapper<Investigate>().eq("sno", sno).orderByDesc("add_time"));
        if (investigateList.size() == 0){
            mav.addObject("InvestigateIsEmpty","此学生没有缺勤记录！");
        }

        //考勤统计
        Student student = studentMapper.selectById(sno);
        Clas clas = clasMapper.selectById(student.getClaId());
        InvStatistic invStatistic = new InvStatistic();
        invStatistic.setClaName(clas.getClaName());
        invStatistic.setExamYear("2019");
        invStatistic.setStuName(student.getStuName());

        List<InvStatistic> invStaByWeek = investigateMapper.invStaByWeek(invStatistic);
        List<InvStatistic> invStaByMonth = investigateMapper.invStaByMonth(invStatistic);
        List<InvStatistic> invStaByMonthLastTerm = investigateMapper.invStaByMonthLastTerm(invStatistic);
        List<InvStatistic> invStaByNextTerm = investigateMapper.invStaByNextTerm(invStatistic);

        mav.addObject("Investigate",investigateList);
        mav.addObject("InvStaByWeek",invStaByWeek);
        mav.addObject("InvStaByMonth",invStaByMonth);
        mav.addObject("InvStaByLastTerm",invStaByMonthLastTerm);
        mav.addObject("InvStaByNextTerm",invStaByNextTerm);
        mav.addObject("InvStatistic",invStatistic);
        mav.setViewName("/investigate/investigateOne");

        return mav;
    }
}
