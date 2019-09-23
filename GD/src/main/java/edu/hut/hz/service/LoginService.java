package edu.hut.hz.service;

import edu.hut.hz.pojo.LoginMsg;
import edu.hut.hz.pojo.Msg;

import javax.servlet.http.HttpServletRequest;

/**
 * @Description: 登录验证及判断
 * @Author: Carlson
 * @Date 2019/4/3 15:26
 **/
public interface LoginService {

    Msg login(LoginMsg loginMsg, HttpServletRequest request);
}
