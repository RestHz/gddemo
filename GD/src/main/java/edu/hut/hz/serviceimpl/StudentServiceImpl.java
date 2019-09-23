package edu.hut.hz.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.hut.hz.dao.*;
import edu.hut.hz.pojo.*;
import edu.hut.hz.service.StudentService;
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
public class StudentServiceImpl extends ServiceImpl<StudentMapper, Student> implements StudentService {

    @Autowired
    private StudentMapper studentMapper;

    @Autowired
    private ModifyOperationServiceImpl modifyOperationService;

    @Autowired
    private ScoreMapper scoreMapper;

    @Autowired
    private CourseMapper courseMapper;

    @Autowired
    private ClasMapper clasMapper;

    @Autowired
    private TeacherMapper teacherMapper;

    @Autowired
    private UserMapper userMapper;

    /**
     * 学生登陆验证
     * @param stu
     * @return
     */
    @Override
    public Msg stuLogin(LoginMsg stu) {
        //获取登录账号
        String account = stu.getAccount();
        //查询账号
        QueryWrapper<Student> queryWrapper = new QueryWrapper<>();
        Student student = baseMapper.selectOne(queryWrapper.eq("sno", account));
        //账号存在
        if (student != null) {
            //验证密码
            String encryptionPwd = EncryptionUtils.md5(stu.getPassword());
            //判断密码是否正确(有默认密码,修改后的密码会有MD5加密)
            if (student.getStuPwd().equals(encryptionPwd) || stu.getPassword().equals(student.getStuPwd())) {
                String stuPicture = student.getStuPicture();
                //判断是否有头像
                if (stuPicture !=null){
                    //如果有图片设置头像访问路径
                    student.setStuPicture(UpDownFileUtils.DOMAIN + "image?imageName=" + student.getStuPicture());
                }
                return Msg.success().add("Success", "登录成功!").add("Role",student.getRole()).add("StudentMsg",student);
            } else {
                return Msg.fail().add("Fail", "密码错误!");
            }
        }
        return Msg.fail().add("Fail", "账号不存在!");
    }

    /**
     * 所有学生信息
     * @param pn
     * @return
     */
    @Override
    public Msg studentList(Integer pn) {
        //引入分页插件
        //传入页码以及每页大小
        PageHelper.startPage(pn,7);
        List<Student> list = baseMapper.selectList(new QueryWrapper<>());
        //使用PageInfo包装查询结果
        //封装了页面详细信息，包括list数据库查询出的数据，第二参数传入连续显示的页数
        PageInfo page = new PageInfo(list,5);
        return Msg.success().add("pageInfo",page);
    }

    /**
     * 更新学生信息
     * @param multipartFile
     * @param student
     * @return
     */
    @Override
    public Msg studentUpdate(MultipartFile multipartFile, Student student) {

        /**
         * 更新一个学生信息
         */
        if (student != null && student.getSno() != ""){
            //判断是否有新信息
            Student student1 = baseMapper.selectById(student.getSno());
            if (student.equals(student1)){
                return Msg.fail().add("Fail","无信息更新!");
            }
            //更新信息
            int update = baseMapper.update(student,new QueryWrapper<Student>().eq("sno",student.getSno()));
            if (update > 0){
                return Msg.success().add("Success","更新数据成功!");
            }else {
                return Msg.fail().add("Fail","更新失败,请重试!");
            }
        }
        return Msg.fail().add("Fail","没有可以更新的学生!");
    }

    /**
     * 学生头像，密码修改
     * @param imageFile
     * @param student
     * @param newPwd
     * @return
     * @throws Exception
     */
    @Override
    public Msg studentAlter(MultipartFile imageFile, Student student, String newPwd) throws Exception{

        //获取账号和密码
        Student newMsg = student;
        //根据学号更新
        if (!"".equals(student.getSno()) && student.getSno() != null){
            //根据学号获取学生信息
            Student studentGet = baseMapper.selectOne(new QueryWrapper<Student>().
                    eq("sno",student.getSno()));
            //更新状态
            int update = 0;

            boolean flag = true;

            if (!imageFile.isEmpty() & !newPwd.isEmpty()){
                flag = false;
            }

            //修改头像
            if (!imageFile.isEmpty()){
                //获取原有头像
                String picture = studentGet.getStuPicture();
                //如果有头像则删除原有头像
                if (picture != null && !"".equals(picture)){
                    File file = new File(UpDownFileUtils.IMAGE_FILE_DIR + picture);
                    file.delete();
                }
                //添加头像
                Msg msg = modifyOperationService.imageFileLoad(imageFile);
                //获得头像名并存入数据库
                String imageName = (String) msg.getMsgContent().get("HeadPortraitName");
                newMsg.setStuPicture(imageName);
                update = baseMapper.update(newMsg,new UpdateWrapper<Student>().eq("sno",student.getSno()));

                if (flag){
                    return updated(student,update);
                }
            }

            //修改密码
            if (!newPwd.isEmpty()){
                //获取加密密码
                String oldPassword = EncryptionUtils.md5(student.getStuPwd());
                //根据账号密码查询是否正确
                Student student1 = baseMapper.selectOne(new QueryWrapper<Student>().
                        eq("sno",student.getSno()).eq("stu_pwd",student.getStuPwd()));
                Student student2 = baseMapper.selectOne(new QueryWrapper<Student>().
                        eq("sno",student.getSno()).eq("stu_pwd",oldPassword));
                if (student2 != null || student1 != null){
                    //加密新密码
                    String newPassword = EncryptionUtils.md5(newPwd);
                    //用户数据更新
                    newMsg.setStuPwd(newPassword);
                    //更新密码和其他信息
                    update = baseMapper.update(newMsg,new UpdateWrapper<Student>().eq("sno",student.getSno()));

                    return updated(student,update);
                }
                return Msg.fail().add("Fail","密码错误！");
            }
            //只更新单个信息
            if (imageFile.isEmpty() && newPwd.isEmpty()){
                newMsg.setStuPwd("");
                //更新其他信息
                update = baseMapper.update(newMsg,new UpdateWrapper<Student>().eq("sno",student.getSno()));

                return updated(student,update);
            }

        }

        return Msg.fail().add("Fail","用户不存在!");

    }

    private Msg updated(Student student,int update){
        //获取新信息
        //根据学号获取学生信息
        Student studentOut = baseMapper.selectOne(new QueryWrapper<Student>().
                eq("sno",student.getSno()));
        //判断是否有头像
        if (studentOut.getStuPicture() != null && !"".equals(studentOut.getStuPicture())){
            //如果有图片设置头像访问路径
            studentOut.setStuPicture(UpDownFileUtils.DOMAIN + "image?imageName=" + studentOut.getStuPicture());
        }
        //更新成功
        if (update > 0) {
            return Msg.success().add("Success","更新完毕!").add("studentMsg",studentOut);
        }else {
            return Msg.fail().add("Fail","更新失败,请重试!").add("studentMsg",studentOut);
        }
    }

    /**
     * 学生成绩查询
     * @param student
     * @return
     */
    @Override
    public Msg studentScore(Student student) {

        List<Score> scores = scoreMapper.selectList(new QueryWrapper<Score>().eq("sno", student.getSno()));
        return Msg.success().add("Scores",scores);
    }

    /**
     * 学生课程查询
     * @param student
     * @return
     */
    @Override
    public Msg studentCourse(Student student) {
        List<Course> courses = courseMapper.selectList(new QueryWrapper<Course>().eq("cno", student.getCno()));
        return Msg.success().add("Courses",courses);
    }

    /**
     * 学生班级查询
     * @param student
     * @return
     */
    @Override
    public Msg studentClass(Student student) {
        Clas clas = clasMapper.selectOne(new QueryWrapper<Clas>().eq("cla_id", student.getClaId()));
        Teacher teacher = teacherMapper.selectOne(new QueryWrapper<Teacher>().eq("tno", clas.getClaTno()));
        return Msg.success().add("Clas",clas).add("Teacher",teacher);
    }

    /**
     * 根据学生学号，删除学生基本信息和成绩
     * @param sno
     * @return
     */
    @Override
    public Msg studentOneDelete(String sno){

        //先学生成绩删除
        int delete2 = scoreMapper.delete(new QueryWrapper<Score>().eq("sno",sno));
        //先家长信息删除
        int delete3 = userMapper.delete(new QueryWrapper<User>().eq("sno",sno));
        //学生信息删除
        int delete1 = baseMapper.deleteById(sno);

        if (delete1 > 0 || delete2 > 0 || delete3 > 0){
            return Msg.success().add("Success","删除成功！");
        }
        return Msg.fail().add("Fail","删除失败！");
    }

    /**
     * 添加一个学生
     * @Param
     * @return
     **/
    @Override
    public Msg studentMsgAdd(Student student){

        //判断学号是否存在
        Student student1 = baseMapper.selectById(student.getSno());
        if (student1 != null){
            return Msg.fail().add("Fail","学号已存在！");
        }
        //添加学生信息
        boolean insert = save(student);
        if (insert){
            return Msg.success().add("Success","添加成功！");
        }
        //添加失败
        return Msg.fail().add("Fail","添加失败！");
    }

    /**
     * 查询需要的学生信息(可模糊查询)
     * @Param
     * @return
     **/
    @Override
    public Msg needStudentMsg(String msg,Integer pn){

        //查询数据
        List<Student> students = new ArrayList<>();

        if (pn == 0){
            List<Student> studentList = studentMapper.studentNeedSelect(msg);
            if (studentList != null){
                //添加查询数据
                students.addAll(studentList);
            }
        }

        if (pn == 1){
            //查询学号
            List<Student> studentList1 = baseMapper.selectList(new QueryWrapper<Student>().eq("sno", msg));
            if (studentList1 != null){
                //添加查询数据
                students.addAll(studentList1);
            }
        }

        if (pn == 2){
            //查询姓名
            List<Student> studentList2 = baseMapper.selectList(new QueryWrapper<Student>().eq("stu_name", msg));
            if (studentList2 != null){
                students.addAll(studentList2);
            }
        }

        if (pn == 3) {
            //查询性别
            List<Student> studentList3 = baseMapper.selectList(new QueryWrapper<Student>().eq("stu_sex",msg));
            if (studentList3 != null){
                students.addAll(studentList3);
            }
        }

        if (pn == 4) {
            //查询年级
            List<Student> studentList4 = baseMapper.selectList(new QueryWrapper<Student>().eq("grade", msg));
            if (studentList4 != null){
               students.addAll(studentList4);
            }
        }

        if (pn == 5) {
            //查询班级
            List<Student> studentList5 = baseMapper.selectList(new QueryWrapper<Student>().eq("cla_id", msg));
            if (studentList5 != null){
                students.addAll(studentList5);
            }
        }

        //查询出数据返回
        if (students != null){
            //引入分页插件
            //传入页码以及每页大小
            PageHelper.startPage(1,students.size());
            //使用PageInfo包装查询结果
            //封装了页面详细信息，包括list数据库查询出的数据，第二参数传入连续显示的页数
            PageInfo page = new PageInfo(students,1);
            return Msg.success().add("pageInfo",page);
        }

        return Msg.fail().add("Fail","没有查询到关于: ” "+msg+"  的数据");
    }
}
