package edu.hut.hz.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.hut.hz.dao.*;
import edu.hut.hz.pojo.*;
import edu.hut.hz.service.TeacherService;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import util.EncryptionUtils;
import util.UpDownFileUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author Carlson
 * @since 2019-04-10
 */
@Service
public class TeacherServiceImpl extends ServiceImpl<TeacherMapper, Teacher> implements TeacherService {

    @Autowired
    private StudentMapper studentMapper;

    @Autowired
    private ModifyOperationServiceImpl modifyOperationService;



    @Autowired
    private CourseMapper courseMapper;

    @Autowired
    private ClasMapper clasMapper;

    @Autowired
    private TeacherMapper teacherMapper;

    @Autowired
    private UserMapper userMapper;

    /**
     * 老师登陆验证
     * @param
     * @return
     */
    @Override
    public Msg teaLogin(LoginMsg teacher) {
        //获取登录账号
        String account = teacher.getAccount();
        //查询账号
        QueryWrapper<Teacher> queryWrapper = new QueryWrapper<>();
        Teacher teacher1 = baseMapper.selectOne(queryWrapper.eq("tno", account));
        //账号存在
        if (teacher1 != null) {
            //验证密码
            String encryptionPwd = EncryptionUtils.md5(teacher.getPassword());
            //判断密码是否正确(有默认密码,修改后的密码会有MD5加密)
            if (teacher1.getTcPwd().equals(encryptionPwd) || teacher.getPassword().equals(teacher1.getTcPwd())) {
                String teaPicture = teacher1.getTcPicture();
                //判断是否有头像
                if (teaPicture != null && !"".equals(teaPicture)){
                    //如果有图片设置头像访问路径
                    teacher1.setTcPicture(UpDownFileUtils.DOMAIN + "image?imageName=" + teacher1.getTcPicture());
                }

                //查询老师是否是班主任
                Clas clas = clasMapper.selectOne(new QueryWrapper<Clas>().eq("cla_tno", teacher1.getTno()));

                return Msg.success().add("Success", "登录成功!").add("Role",teacher1.getRole()).add("TeacherMsg",teacher1).add("ClasMsg",clas);
            } else {
                return Msg.fail().add("Fail", "密码错误!");
            }
        }
        return Msg.fail().add("Fail", "账号不存在!");
    }

    /**
     * 所有老师信息
     * @Param
     * @return
     **/
    @Override
    public Msg teacherList(Integer pn) {
        //引入分页插件
        //传入页码以及每页大小
        PageHelper.startPage(pn,7);
        List<Teacher> list = baseMapper.selectList(new QueryWrapper<>());
        //使用PageInfo包装查询结果
        //封装了页面详细信息，包括list数据库查询出的数据，第二参数传入连续显示的页数
        PageInfo page = new PageInfo(list,5);
        return Msg.success().add("pageInfo",page);
    }

    /**
     * 更新老师信息
     * @param
     * @param
     * @return
     */
    @Override
    public Msg teacherUpdate(MultipartFile multipartFile, Teacher teacher) {

        /**
         * 更新一个老师信息
         */
        if (teacher != null && teacher.getTno() != ""){
            //判断是否有新信息
            Teacher teacher1 = baseMapper.selectById(teacher.getTno());
            if (teacher.equals(teacher1)){
                return Msg.fail().add("Fail","无信息更新!");
            }
            //更新信息
            int update = baseMapper.update(teacher,new QueryWrapper<Teacher>().eq("tno",teacher.getTno()));
            if (update > 0){
                return Msg.success().add("Success","更新数据成功!");
            }else {
                return Msg.fail().add("Fail","更新失败,请重试!");
            }
        }
        return Msg.fail().add("Fail","没有可以更新的老师!");
    }


    /**
     * 老师头像，密码修改
     * @param
     * @param
     * @param newPwd
     * @return
     * @throws Exception
     */
    @Override
    public Msg teacherAlter(MultipartFile imageFile, Teacher teacher, String newPwd) throws Exception{

        //获取账号和密码
        Teacher newMsg = teacher;
        //根据工号更新
        if (teacher.getTno() != null) {
            //根据学号获取老师信息
            Teacher teacherGet = baseMapper.selectOne(new QueryWrapper<Teacher>().
                    eq("tno", teacher.getTno()));
            //更新状态
            int update = 0;

            boolean flag = true;

            if (!imageFile.isEmpty() & !newPwd.isEmpty()){
                flag = false;
            }

            //修改头像
            if (!imageFile.isEmpty()) {
                //获取原有头像
                String picture = teacherGet.getTcPicture();
                //如果有头像则删除原有头像
                if (picture != null && !"".equals(picture)) {
                    File file = new File(UpDownFileUtils.IMAGE_FILE_DIR + picture);
                    file.delete();
                }
                //添加头像
                Msg msg = modifyOperationService.imageFileLoad(imageFile);
                //获得头像名并存入数据库
                String imageName = (String) msg.getMsgContent().get("HeadPortraitName");
                newMsg.setTcPicture(imageName);
                update = baseMapper.update(newMsg, new UpdateWrapper<Teacher>().eq("tno", teacher.getTno()));
                if (flag){
                    return updated(teacher, update);
                }
            }

            //修改密码
            if (!newPwd.isEmpty()) {
                //获取加密密码
                String oldPassword = EncryptionUtils.md5(teacher.getTcPwd());
                //根据账号密码查询是否正确
                Teacher teacher1 = baseMapper.selectOne(new QueryWrapper<Teacher>().
                        eq("tno", teacher.getTno()).eq("tc_pwd", teacher.getTcPwd()));
                Teacher teacher2 = baseMapper.selectOne(new QueryWrapper<Teacher>().
                        eq("tno", teacher.getTno()).eq("tc_pwd", oldPassword));
                if (teacher1 != null || teacher2 != null) {
                    //加密新密码
                    String newPassword = EncryptionUtils.md5(newPwd);
                    //用户数据更新
                    newMsg.setTcPwd(newPassword);
                    //更新密码和其他信息
                    update = baseMapper.update(newMsg, new UpdateWrapper<Teacher>().eq("tno", teacher.getTno()));

                    return updated(teacher,update);
                }
                return Msg.fail().add("Fail","密码错误！");
            }
            //只更新单个信息
            if (newPwd.isEmpty()) {
                newMsg.setTcPwd("");
                //更新其他信息
                update = baseMapper.update(newMsg, new UpdateWrapper<Teacher>().eq("tno", teacher.getTno()));
                return updated(teacher,update);
            }
        }
        return Msg.fail().add("Fail", "用户不存在!");
    }

    private Msg updated(Teacher teacher,int update){
        //获取新信息
        //根据学号获取老师信息
        Teacher teacherOut = baseMapper.selectOne(new QueryWrapper<Teacher>().
                eq("tno",teacher.getTno()));
        //判断是否有头像
        if (teacherOut.getTcPicture() != null && !"".equals(teacherOut.getTcPicture())){
            //如果有图片设置头像访问路径
            teacherOut.setTcPicture(UpDownFileUtils.DOMAIN + "image?imageName=" + teacherOut.getTcPicture());
        }
        //更新成功
        if (update > 0) {
            return Msg.success().add("Success","更新完毕!").add("teacherMsg",teacherOut);
        }else {
            return Msg.fail().add("Fail","更新失败,请重试!").add("teacherMsg",teacherOut);
        }
    }

    @Override
    public Msg teacherCourse(Teacher teacher) {
        return null;
    }

    /**
     * 根据老师工号，删除老师基本信息和课件
     * @param
     */
    @Override
    public Msg teacherOneDelete(String tno){


        //老师信息删除
        int delete1 = baseMapper.deleteById(tno);

        if (delete1 > 0){
            return Msg.success().add("Success","删除成功！");
        }
        return Msg.fail().add("Fail","删除失败！");
    }

    /**
     * 添加一个老师
     * @Param
     * @return
     **/
    @Override
    public Msg teacherMsgAdd(Teacher teacher){

        //判断工号是否存在
        Teacher teacher1 = baseMapper.selectById(teacher.getTno());
        if (teacher1 != null){
            return Msg.fail().add("Fail","工号已存在！");
        }
        //添加老师信息
        boolean insert = save(teacher);
        if (insert){
            return Msg.success().add("Success","添加成功！");
        }
        //添加失败
        return Msg.fail().add("Fail","添加失败！");
    }

    /**
     * 查询需要的老师信息(可模糊查询)
     * @Param
     * @return
     **/
    @Override
    public Msg needTeacherMsg(String msg,Integer pn){

        //查询数据
        List<Teacher> teachers = new ArrayList<>();

        if (pn == 0){
            //模糊查询
            List<Teacher> teacherList = teacherMapper.teacherNeedSelect(msg);
            if (teacherList != null){
                //添加查询数据
                teachers.addAll(teacherList);
            }
        }

        if (pn == 1){
            //查询工号
            List<Teacher> teacherList1 = list(new QueryWrapper<Teacher>().eq(true, "tno",msg));
            if (teacherList1 != null){
                //添加查询数据
                teachers.addAll(teacherList1);
            }
        }

        if (pn == 2){
            //查询姓名
            List<Teacher> teacherList2 = baseMapper.selectList(new QueryWrapper<Teacher>().eq("tc_name", msg));
            if (teacherList2 != null){
                teachers.addAll(teacherList2);
            }
        }

        if (pn == 3) {
            //查询性别
            List<Teacher> teacherList3 = baseMapper.selectList(new QueryWrapper<Teacher>().eq("tc_sex",msg));
            if (teacherList3 != null){
                teachers.addAll(teacherList3);
            }
        }

        if (pn == 4) {
            //查询课程
            List<Teacher> teacherList4 = baseMapper.selectList(new QueryWrapper<Teacher>().eq("cno", msg));
            if (teacherList4 != null){
                teachers.addAll(teacherList4);
            }
        }

        //查询出数据返回
        if (teachers != null){
            //引入分页插件
            //传入页码以及每页大小
            PageHelper.startPage(1,teachers.size());
            //使用PageInfo包装查询结果
            //封装了页面详细信息，包括list数据库查询出的数据，第二参数传入连续显示的页数
            PageInfo page = new PageInfo(teachers,1);
            return Msg.success().add("pageInfo",page);
        }
        return Msg.fail().add("Fail","没有查询到关于: ” "+msg+" “ 的数据");
    }












}
