package edu.hut.hz.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import edu.hut.hz.dao.StudentMapper;
import edu.hut.hz.dao.UserMapper;
import edu.hut.hz.pojo.Clas;
import edu.hut.hz.pojo.Msg;
import edu.hut.hz.pojo.User;
import edu.hut.hz.serviceimpl.CourseScoreServiceImpl;
import edu.hut.hz.serviceimpl.ModifyOperationServiceImpl;
import edu.hut.hz.serviceimpl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import util.VerifyUtils;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @ClassName: UserController
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/4/17 21:26
 * @Version: 1.0
 **/
@Controller
public class UserController {


    @Autowired
    UserServiceImpl userService;

    @Autowired
    ModifyOperationServiceImpl modifyOperationService;

    @Autowired
    CourseScoreServiceImpl courseScoreService;

    @Autowired
    StudentMapper studentMapper;

    @Autowired
    UserMapper userMapper;

    /**
     * @Description //家长注册
     * @Date 15:04 2019/4/20
     * @Author Carlson       
     * @Param [user]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/register",method = RequestMethod.POST)
    @ResponseBody
    public Msg register(User user){
        return userService.userRegister(user);
    }


    /***
     * @Description //家长信息修改页面获取
     * @Date 15:34 2019/4/20
     * @Author Carlson
     * @Param [account]
     * @return java.lang.String
     **/
    @RequestMapping(value = "/userUpdateGet",method = RequestMethod.POST)
    public ModelAndView userUpdateGet(String account, HttpSession session){
        //返回信息
        ModelAndView mav = new ModelAndView();
        boolean login = VerifyUtils.verifyLogin(session);
        if (login){
            mav.setViewName("redirect:index.jsp");
            mav.addObject("Fail","请先登录！");
            return mav;
        }
        //返回更新页面
        mav.setViewName("userUpdate");
        //设置数据
        User user = userService.getById(account);
        mav.addObject("User",user);

        return mav;
    }

    /***
     * @Description //家长信息修改确认
     * @Date 15:34 2019/4/20
     * @Author Carlson
     * @Param [account]
     * @return java.lang.String
     **/
    @RequestMapping(value = "/userUpdate",method = RequestMethod.POST)
    @ResponseBody
    public Msg userUpdate(@RequestParam(value = "imageFile", required = false, defaultValue = "") MultipartFile imageFile,
            User user, @RequestParam(value = "newPwd", required = false, defaultValue = "") String newPwd){

        try {
            return userService.userUpdate(imageFile,user,newPwd);

        } catch (Exception e) {
            System.out.println("文件流错误:"+e.getMessage());
        }
        return Msg.fail();
    }

    /***
     * @Description //家长头像修改确认
     * @Date 15:34 2019/4/20
     * @Author Carlson
     * @Param [file]
     **/
    @RequestMapping(value = "/userImageUpdate",method = RequestMethod.POST)
    @ResponseBody
    public Msg userImageUpdate(@RequestParam(value = "file") MultipartFile file){
        String imageName = "";
        try {
            Msg msg = modifyOperationService.imageFileLoad(file);
            imageName = (String) msg.getMsgContent().get("HeadPortraitName");
            System.out.println(imageName);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Msg.success().add("Success",imageName);
    }


    /**
     * @Description //家长获取学生成绩信息
     * @Date 17:32 2019/4/20
     * @Author Carlson
     * @Param [sno, pn]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping("/stuScore")
    public ModelAndView studentScoreGet(String sno,Integer pn){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("score");
        mav.addObject("Score",courseScoreService.scoreListBySno(sno,pn));
        return mav;
    }


    /**
     * @Description //老师根据班级名称获取家长姓名
     * @Date 14:38 2019/5/2
     * @Author Carlson
     * @Param [claName]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/teaUserList")
    @ResponseBody
    public Msg getUserList(Clas claName){
        //获取用户列表
        List<User> userList = userService.list(new QueryWrapper<User>().eq("cla_name", claName.getClaName()));
        if (userList.size() == 0){
            return Msg.fail().add("Fail","没有获取到用户信息");
        }
        return Msg.success().add("UserList",userList);
    }


    /**
     * @Description //获取需要的用户信息
     * @Date 14:38 2019/5/2
     * @Author Carlson
     * @Param [claName]
     * @return edu.hut.hz.pojo.Msg
     **/
    @RequestMapping(value = "/userMsgNeed")
    @ResponseBody
    public Msg userMsgNeed(String needMsg){
        System.out.println(needMsg);
        //获取用户列表
        List<User> userList = userMapper.userNeedMsg(needMsg);

        if (userList.size() == 0){
            return Msg.fail().add("Fail","没有查询到有关 "+needMsg+" 的信息");
        }
        return Msg.success().add("Success",userList);
    }

}
