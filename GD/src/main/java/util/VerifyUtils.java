package util;

import edu.hut.hz.pojo.LoginMsg;

import javax.servlet.http.HttpSession;

/**
 * @ClassName: VerifyUtils
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/4/24 21:03
 * @Version: 1.0
 **/
public class VerifyUtils {

    /**
     * 确认登录
     **/
    public static boolean verifyLogin(HttpSession session){
        LoginMsg login = (LoginMsg)session.getAttribute("Login");
        if (login == null){
            return true;
        }
        return false;
    }

}
