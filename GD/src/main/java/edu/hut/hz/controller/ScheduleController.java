package edu.hut.hz.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import edu.hut.hz.dao.ClasMapper;
import edu.hut.hz.pojo.Msg;
import edu.hut.hz.pojo.Schedule;
import edu.hut.hz.serviceimpl.ScheduleServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import util.VerifyUtils;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author Carlson
 * @since 2019-04-18
 */
@Controller
public class ScheduleController {

    @Autowired
    ScheduleServiceImpl scheduleService;

    @Autowired
    ClasMapper clasMapper;

    /**
     * 查询所有课表信息
     * @Param
     * @return
     **/
    @RequestMapping(value = "/scheduleList/{pn}",method = RequestMethod.GET)
    public ModelAndView scheduleList(@PathVariable("pn") Integer pn, HttpSession session){
        ModelAndView mav = new ModelAndView();

        boolean login = VerifyUtils.verifyLogin(session);
        if (login){
            mav.setViewName("redirect:login.jsp");
            mav.addObject("Fail","请先登录！");
            return mav;
        }

        Msg msg = scheduleService.scheduleList(pn);
        mav.setViewName("admin/scheduleMain");
        mav.addObject("Schedule",msg);
        return mav;

    }

    /**
     * 添加一个课表信息
     * @Param
     * @return
     **/
    @RequestMapping(value = "/schedule",method = RequestMethod.POST)
    @ResponseBody
    public Msg scheduleAddOne(@RequestBody List<Schedule> list){
        for (Schedule s:list
             ) {
            System.out.println(s);
        }
        return null;
    }


    /**
     * @Description //获取对应班级课表
     * @Date 21:05 2019/4/20
     * @Author Carlson
     * @Param [claId]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = "/scheduleOne",method = RequestMethod.GET)
    public ModelAndView scheduleOneGet(Integer claId){
        ModelAndView mav = new ModelAndView();

        Msg msg = scheduleService.scheduleOneClass(claId);

        if (msg.getCode() == Msg.SUCCESSCODE){
            //返回对应班级课表
            mav.addObject("Schedule",msg.getMsgContent().get("scheduleList"));
            //返回班级信息
            mav.addObject("Clas",msg.getMsgContent().get("clas"));
            //返回学年学期信息
            mav.addObject("YearTerms",msg.getMsgContent().get("yearTerms"));

        }else {
            //返回失败结果
            mav.addObject("Fail",msg.getMsgContent().get("Fail"));
        }

        mav.setViewName("schedule");
        return mav;
    }

    @RequestMapping(value = "/scheduleOne",method = RequestMethod.POST)
    @ResponseBody
    public Msg scheduleOneDelete(String claId,String examYear,String examTerm){
        System.out.println(claId);

        boolean remove = scheduleService.remove(new QueryWrapper<Schedule>().eq("cla_id", claId)
                .eq("exam_year", examYear).eq("exam_term", examTerm));
        if (remove){
            return Msg.success().add("Success","已成功删除此课表");
        }
        return Msg.fail().add("Fail","删除失败！");
    }
}

