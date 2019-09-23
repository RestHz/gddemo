package edu.hut.hz.pojo;

import lombok.Data;

/**
 * @ClassName: LoginMsg
 * @Description: 获取登录数据
 * @Author: Carlson
 * @Date 2019/4/3 13:57
 * @Version: 1.0
 **/
@Data
public class LoginMsg {

    /**
     * @Description //登录账号
     * @Date 13:59 2019/4/3
     * @Author Carlson
     * @Param
     * @return
     **/
    private String account;

     /**
      * @Description //登录密码
      * @Date 14:00 2019/4/3
      * @Author Carlson
      * @Param
      * @return
      **/
     private String password;

     /**
      * @Description //登录身份
      * @Date 14:01 2019/4/3
      * @Author Carlson
      * @Param
      * @return
      **/
     private Integer role;

}
