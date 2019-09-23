package edu.hut.hz.service;

import com.baomidou.mybatisplus.extension.service.IService;
import edu.hut.hz.pojo.LoginMsg;
import edu.hut.hz.pojo.Msg;
import edu.hut.hz.pojo.User;
import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Carlson
 * @since 2019-04-10
 */
public interface UserService extends IService<User> {

    /**
     * @Description //家长注册
     * @Date 21:29 2019/4/17
     * @Author Carlson
     * @Param []
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg userRegister(User user);


    /**
     * @Description //家长登录
     * @Date 22:12 2019/4/3
     * @Author Carlson
     * @Param [user]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg userLogin(LoginMsg user);

    /**
     * @Description //家长信息修改
     * @Date 22:12 2019/4/3
     * @Author Carlson
     * @Param [imageFile,user,newPwd]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg userUpdate(MultipartFile imageFile,User user, String newPwd)throws Exception;
}
