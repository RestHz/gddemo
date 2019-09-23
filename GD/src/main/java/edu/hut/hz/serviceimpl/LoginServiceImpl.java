package edu.hut.hz.serviceimpl;

import edu.hut.hz.pojo.LoginMsg;
import edu.hut.hz.pojo.Msg;
import edu.hut.hz.service.LoginService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * @ClassName: LoginServiceImpl
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/4/3 15:29
 * @Version: 1.0
 **/
@Service
public class LoginServiceImpl implements LoginService {

    @Resource
    private UserServiceImpl userService;

    @Resource
    private StudentServiceImpl studentService;

    @Resource
    private TeacherServiceImpl teacherService;

    @Resource
    AdminServiceImpl adminService;

    @Override
    public Msg  login(LoginMsg loginMsg, HttpServletRequest request) {
        //获取角色
        Integer role = loginMsg.getRole();
        //验证码验证
        String sessionCode = (String) request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        String checkCode = request.getParameter("checkCode");
/**
 **  Sign  **
 **/        if (checkCode != null && checkCode.equals(sessionCode)) {
            //登录验证
            switch (role){
                /**
                 * @Description //管理员登录
                 * @Author Carlson
                 **/
                case 0:
                   return adminService.adminLogin(loginMsg);

                /**
                 * @Description //学生登录
                 * @Author Carlson
                 **/
                case 1:
                    return studentService.stuLogin(loginMsg);

                /**
                 * @Description //老师登录
                 * @Author Carlson
                 **/
                case 2:
                    return teacherService.teaLogin(loginMsg);

                /**
                 * @Description //家长登录
                 * @Author Carlson
                 **/
                case 3:
                    return userService.userLogin(loginMsg);

                default:
                    return Msg.fail().add("Fail","请输入正确信息!");
            }
        } else {
            return Msg.fail().add("Fail","验证码错误!");
        }
    }
}
