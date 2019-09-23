package edu.hut.hz.service;

import com.baomidou.mybatisplus.extension.service.IService;
import edu.hut.hz.pojo.LoginMsg;
import edu.hut.hz.pojo.Msg;
import edu.hut.hz.pojo.Teacher;
import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Carlson
 * @since 2019-04-10
 */
public interface TeacherService extends IService<Teacher> {

    /**
     * @Description //老师登录
     * @Date 22:12 2019/4/3
     * @Author Carlson
     * @Param [user]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg teaLogin(LoginMsg user);

    /**
     * @Description //获取老师信息
     * @Date 23:14 2019/4/3
     * @Author Carlson
     * @Param [pn]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg teacherList(Integer pn);

    /**
     * @Description //老师信息更新
     * @Date 16:02 2019/4/4
     * @Author Carlson
     * @Param [multipartFile, teacher]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg teacherUpdate(MultipartFile multipartFile, Teacher teacher);

    /**
     * @Description //老师头像及密码修改
     * @Date 22:04 2019/4/5
     * @Author Carlson
     * @Param [multipartFile,teacher,newPassword]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg teacherAlter(MultipartFile imageFile, Teacher teacher, String newPassword) throws Exception;

    /**
     * @Description //老师课程获取
     * @Date 14:37 2019/4/11
     * @Author Carlson
     * @Param [teacher]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg teacherCourse(Teacher teacher);

    /**
     * @Description //删除一个老师信息
     * @Date 16:04 2019/4/14
     * @Author Carlson
     * @Param [String]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg teacherOneDelete(String tno);

    /**
     * @Description //单个老师信息新增
     * @Date 16:59 2019/4/15
     * @Author Carlson
     * @Param [teacher]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg teacherMsgAdd(Teacher teacher);

    /**
     * @Description //查询老师信息（可模糊查询）
     * @Date 22:56 2019/4/15
     * @Author Carlson
     * @Param [msg：查询的信息, pn：查询的类型]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg needTeacherMsg(String msg,Integer pn);

}
