package edu.hut.hz.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import edu.hut.hz.dao.CommunicationMapper;
import edu.hut.hz.dao.TeacherMapper;
import edu.hut.hz.dao.UserMapper;
import edu.hut.hz.pojo.Communication;
import edu.hut.hz.pojo.Msg;
import edu.hut.hz.pojo.Teacher;
import edu.hut.hz.pojo.User;
import edu.hut.hz.serviceimpl.CommunicationServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import util.UpDownFileUtils;
import util.VerifyUtils;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @ClassName: CommunicationController
 * @Description: 留言功能
 * @Author: Carlson
 * @Date 2019/4/12 13:22
 * @Version: 1.0
 **/
@Controller
public class CommunicationController {

    @Autowired
    CommunicationServiceImpl communicationService;

    @Autowired
    CommunicationMapper communicationMapper;

    @Autowired
    TeacherMapper teacherMapper;

    @Autowired
    UserMapper userMapper;

    /**
     * @Description //获取需要留言者留言信息
     * @Date 16:14 2019/4/23
     * @Author Carlson
     * @Param [sender, pn]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping("/communication")
    public ModelAndView communication(String sender, Integer pn, Integer orderByType, HttpSession session){

        ModelAndView mav = new ModelAndView();

        boolean login = VerifyUtils.verifyLogin(session);
        if (login){
            mav.setViewName("redirect:index.jsp");
            mav.addObject("Fail","请先登录！");
            return mav;
        }

        //获取发送者的留言信息
        Msg msg = communicationService.senderCommunicationList(sender, pn,orderByType);
        mav.addObject("Communication",msg.getMsgContent().get("pageInfo"));
        //获取发送人信息
        mav.addObject("SenderMsg",communicationService.senderMsg(sender));
        //排序条件
        mav.addObject("OrderByType",msg.getMsgContent().get("orderByType"));
        //发送人身份
        Integer tnoCount = teacherMapper.selectCount(new QueryWrapper<Teacher>().eq("tno", sender));
        if (tnoCount > 0){
            //老师身份
            mav.addObject("SenderType","Teacher");
        }else {
            //家长身份
            mav.addObject("SenderType","Parent");
        }

        //错误信息
        mav.addObject("ERROR",msg.getMsgContent().get("Fail"));
        mav.setViewName("communication/communication");
        return mav;
    }



    /**
     * @Description //留言，添加留言信息到数据库
     * @Date 16:15 2019/4/23
     * @Author Carlson
     * @Param [communication]
     * @return void
     **/
    @RequestMapping(value = "/communicationMsg",method = RequestMethod.POST)
    @ResponseBody
    public Msg communicationAdd(Communication communication){
        System.out.println("=====================");
        System.out.println(communication);
        return communicationService.communicationMsgAdd(communication);
    }

    @RequestMapping("/communicationSel")
    public ModelAndView communicationGet(Communication communication){
        ModelAndView mav = new ModelAndView();
        List<Communication> communicationList = communicationMapper.selectList(new QueryWrapper<Communication>().eq("sender", communication.getSender()));
        for (Communication c:communicationList) {
            System.out.println(c);
        }

        mav.setViewName("communication/communication");
        mav.addObject("CommunicationMsg",communicationList);

        return mav;
    }

    /**
     * @Description //获取留言板
     * @Date 16:16 2019/4/23
     * @Author Carlson
     * @Param []
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = "/messageBoard",method = RequestMethod.GET)
    public ModelAndView messageBoard(String sender,String recipient){

        ModelAndView mav = new ModelAndView();
        //留言人
        mav.addObject("Sender",sender);
        //接收人
        mav.addObject("Recipient",recipient);
        //留言页面
        mav.setViewName("/communication/messageBoard");
        return mav;
    }

    /**
     * 留言信息查看
     * @Param
     * @return
     **/
    @RequestMapping(value = "/communicationOne",method = RequestMethod.GET)
    public ModelAndView communicationOne(String cmId,Integer condition){

        ModelAndView mav = new ModelAndView();
        //返回此条留言信息
        Communication communication = communicationService.getById(cmId);
        mav.addObject("CommunicationOne",communication);
        //1：为自己的留言只能查看、修改；2：为他人留言可回复
        mav.addObject("Condition",condition);
        //返回页面
        mav.setViewName("/communication/detailMessage");
        String sender = communication.getSender();
        String recipient = communication.getRecipient();
        //发送人身份
        Integer tnoCount = teacherMapper.selectCount(new QueryWrapper<Teacher>().eq("tno", sender));
        if (tnoCount > 0){
            //老师身份
            mav.addObject("SenderType","Teacher");
            Teacher teacherSender = teacherMapper.selectById(sender);

            User userRec = userMapper.selectById(recipient);

            mav.addObject("teacherSender",teacherSender);
            mav.addObject("userRec",userRec);
        }else {
            //家长身份
            mav.addObject("SenderType", "Parent");
            User userSender = userMapper.selectById(sender);

            Teacher teacherRec = teacherMapper.selectById(recipient);
            mav.addObject("userSender",userSender);
            mav.addObject("teacherRec",teacherRec);
        }

        return mav;
    }

    /**
     * 留言回复
     *
     * @Param
     * @return
     **/
    @RequestMapping(value = "/communicationReply",method = RequestMethod.POST)
    @ResponseBody
    public Msg communicationReply(Communication communication){

        return communicationService.replyMessage(communication);
    }

    /**
     * @Description //留言信息删除
     * @Date 14:43 2019/4/14
     * @Author Carlson
     * @Param []
     * @return java.lang.String
     **/
    @RequestMapping(value = "/communicationMsg/{cmId}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg communicationDel(@PathVariable("cmId")String cmId){
        return communicationService.communicationOneDelete(cmId);
    }

}
