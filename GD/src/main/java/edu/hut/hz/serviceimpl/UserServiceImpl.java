package edu.hut.hz.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import edu.hut.hz.dao.StudentMapper;
import edu.hut.hz.dao.TeacherMapper;
import edu.hut.hz.dao.UserMapper;
import edu.hut.hz.pojo.*;
import edu.hut.hz.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import util.EncryptionUtils;
import util.UpDownFileUtils;

import java.io.File;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author Carlson
 * @since 2019-04-10
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Autowired
    StudentMapper studentMapper;

    @Autowired
    TeacherMapper teacherMapper;

    @Autowired
    ModifyOperationServiceImpl modifyOperationService;

    /**
     * @Description //用户注册
     * @Param [user, sno]
     * @return edu.hut.hz.pojo.Msg
     **/
    @Override
    public Msg userRegister(User user) {

        //是否输入学号
        if(user.getAccount()== null || "".equals(user.getAccount()) || user.getSno()==null || "".equals(user.getSno())){
            return Msg.fail().add("Fail","请输入账号和学生学号！");
        }

        //是否填入信息
        if (user.getUserPwd() == null || "".equals(user.getUserPwd())) {
            return Msg.fail().add("Fail","请输入密码！");
        }
        if (user.getUserName() == null || "".equals(user.getUserName())) {
            return Msg.fail().add("Fail","请输入姓名！");
        }
        if (user.getUserPhone() == null || "".equals(user.getUserPhone())) {
            return Msg.fail().add("Fail","请输入电话！");
        }

        //确认学号
        Integer studentCount = studentMapper.selectCount(new QueryWrapper<Student>().eq("sno",user.getSno()));
        if (studentCount < 1){
            return Msg.fail().add("Fail","不存在此学生，请重试！");
        }

        //确认用户名不存在
        Integer userCount = baseMapper.selectCount(new QueryWrapper<User>().eq("account", user.getAccount()));
        Integer snoCount = studentMapper.selectCount(new QueryWrapper<Student>().eq("sno", user.getAccount()));
        Integer tnoCount = teacherMapper.selectCount(new QueryWrapper<Teacher>().eq("tno", user.getAccount()));

        if (userCount > 0 || snoCount > 0 || tnoCount > 0){
            return Msg.fail().add("Fail","账号已存在，请更改为其他账号！");
        }

        //保存用户信息
        int insert = baseMapper.insert(user);

        if (insert > 0){
            return Msg.success().add("Success","注册成功，请去登录！");
        }

        return Msg.fail().add("Fail","注册失败，请重试！");
    }

    /**
     * 家长登陆验证
     * @param user
     * @return
     */
    @Override
    public Msg userLogin(LoginMsg user) {
        //获取登录账号
        String account = user.getAccount();
        //查询账号
        User user1 = baseMapper.selectOne(new QueryWrapper<User>().eq("account", account));
        //账号存在
        if (user1 != null) {
            //验证密码
            String encryptionPwd = EncryptionUtils.md5(user.getPassword());
            //判断密码是否正确(有默认密码,修改后的密码会有MD5加密)
            if (encryptionPwd.equals(user1.getUserPwd()) || user.getPassword().equals(user1.getUserPwd())) {
                //获取学生信息
                Student student = studentMapper.selectById(user1.getSno());
                //判断是否有头像
                if (student.getStuPicture() != null && !"".equals(student.getStuPicture())){
                    //如果有图片设置头像访问路径
                    student.setStuPicture(UpDownFileUtils.DOMAIN + "image?imageName=" + student.getStuPicture());
                }
                return Msg.success().add("Success", "登录成功!").add("Role",user1.getRole()).add("UserMsg",user1).add("StudentMsg",student);
            } else {
                return Msg.fail().add("Fail", "密码错误!");
            }
        }
        return Msg.fail().add("Fail", "账号不存在!");
    }

    /**
     * 家长信息修改
     * @Param
     * @return
     **/
    @Override
    public Msg userUpdate(MultipartFile imageFile, User user, String newPwd) throws Exception {

        //获取账号和密码
        User newMsg = user;
        //根据账号更新
        if (!"".equals(user.getAccount()) && user.getAccount() != null){
            //根据账号获取家长信息
            User userGet = baseMapper.selectOne(new QueryWrapper<User>().
                    eq("account",user.getAccount()));

            //更新状态
            int update = 0;

            boolean flag = true;

            if (!imageFile.isEmpty() & !newPwd.isEmpty()){
                flag = false;
            }

            //修改头像
            if (!imageFile.isEmpty()){
                //获取原有头像
                String picture = userGet.getUserPicture();
                //如果有头像则删除原有头像
                if (picture != null && !"".equals(picture)){
                    File file = new File(UpDownFileUtils.IMAGE_FILE_DIR + picture);
                    file.delete();
                }
                //添加头像
                Msg msg = modifyOperationService.imageFileLoad(imageFile);
                //获得头像名并存入数据库
                String imageName = (String) msg.getMsgContent().get("HeadPortraitName");
                newMsg.setUserPicture(imageName);
                update = baseMapper.update(newMsg,new UpdateWrapper<User>().eq("account",user.getAccount()));

                if (flag){
                    return updated(user,update);
                }
            }

            //修改密码
            if (!newPwd.isEmpty() && userGet != null){
                //获取加密密码
                String oldPassword = EncryptionUtils.md5(user.getUserPwd());

                //判断老密码是否正确，正确则更新
                if (userGet.getUserPwd().equals(oldPassword) || userGet.getUserPwd().equals(user.getUserPwd())){
                    //加密新密码
                    String newPassword = EncryptionUtils.md5(newPwd);
                    //用户数据更新
                    newMsg.setUserPwd(newPassword);
                    //更新密码和其他信息
                    update = baseMapper.update(newMsg,new UpdateWrapper<User>().eq("account",user.getAccount()));
                    return updated(user,update);
                }
                return Msg.fail().add("Fail","密码错误！");
            }
            //只更新单个信息
            if (imageFile.isEmpty() && newPwd.isEmpty()){
                newMsg.setUserPwd("");
                //更新其他信息
                update = baseMapper.update(newMsg,new UpdateWrapper<User>().eq("account",user.getAccount()));

                return updated(user,update);
            }
        }

        return Msg.fail().add("Fail","用户不存在!");

    }

    private Msg updated(User user,int update){
        //获取新信息
        //根据学号获取学生信息
        User userOut = baseMapper.selectOne(new QueryWrapper<User>().
                eq("account",user.getAccount()));
        //判断是否有头像
        if (userOut.getUserPicture() != null && !"".equals(userOut.getUserPicture())){
            //如果有图片设置头像访问路径
            userOut.setUserPicture(UpDownFileUtils.DOMAIN + "image?imageName=" + userOut.getUserPicture());
        }
        //更新成功
        if (update > 0) {
            return Msg.success().add("Success","更新完毕!").add("userMsg",userOut);
        }else {
            return Msg.fail().add("Fail","更新失败,请重试!").add("userMsg",userOut);
        }
    }
}
