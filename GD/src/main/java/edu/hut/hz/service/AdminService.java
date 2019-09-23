package edu.hut.hz.service;

import com.baomidou.mybatisplus.extension.service.IService;
import edu.hut.hz.pojo.Admin;
import edu.hut.hz.pojo.LoginMsg;
import edu.hut.hz.pojo.Msg;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Carlson
 * @since 2019-04-10
 */
public interface AdminService extends IService<Admin> {

    /**
     * @Description //管理员登录
     * @Date 22:12 2019/4/3
     * @Author Carlson
     * @Param [user]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg adminLogin(LoginMsg admin);
}
