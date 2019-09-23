package edu.hut.hz.service;

import com.baomidou.mybatisplus.extension.service.IService;
import edu.hut.hz.pojo.LoginMsg;
import edu.hut.hz.pojo.Msg;
import edu.hut.hz.pojo.Student;
import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Carlson
 * @since 2019-04-10
 */
public interface StudentService extends IService<Student> {
    /**
     * @Description //学生登录
     * @Date 22:12 2019/4/3
     * @Author Carlson
     * @Param [user]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg stuLogin(LoginMsg user);

    /**
     * @Description //获取学生信息
     * @Date 23:14 2019/4/3
     * @Author Carlson
     * @Param [pn]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg studentList(Integer pn);

    /**
     * @Description //学生信息更新
     * @Date 16:02 2019/4/4
     * @Author Carlson
     * @Param [multipartFile, student]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg studentUpdate(MultipartFile multipartFile, Student student);

    /**
     * @Description //学生头像及密码修改
     * @Date 22:04 2019/4/5
     * @Author Carlson
     * @Param [multipartFile,student,newPassword]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg studentAlter(MultipartFile multipartFile,Student student,String newPassword) throws Exception;

    /**
     * @Description //学生成绩获取
     * @Date 14:37 2019/4/11
     * @Author Carlson
     * @Param [student]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg studentScore(Student student);

    /**
     * @Description //学生课程获取
     * @Date 14:37 2019/4/11
     * @Author Carlson
     * @Param [student]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg studentCourse(Student student);

    /**
     * @Description //学生班级获取
     * @Date 14:37 2019/4/11
     * @Author Carlson
     * @Param [student]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg studentClass(Student student);


    /**
     * @Description //删除一个学生信息
     * @Date 16:04 2019/4/14
     * @Author Carlson
     * @Param [String]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg studentOneDelete(String sno);

    /**
     * @Description //单个学生信息新增
     * @Date 16:59 2019/4/15
     * @Author Carlson
     * @Param [student]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg studentMsgAdd(Student student);

    /**
     * @Description //查询学生信息（可模糊查询）
     * @Date 22:56 2019/4/15
     * @Author Carlson
     * @Param [msg：查询的信息, pn：查询的类型]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg needStudentMsg(String msg,Integer pn);
}
