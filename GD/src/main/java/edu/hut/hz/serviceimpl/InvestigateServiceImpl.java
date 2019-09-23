package edu.hut.hz.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.hut.hz.dao.ClasMapper;
import edu.hut.hz.dao.StudentMapper;
import edu.hut.hz.dao.TeacherMapper;
import edu.hut.hz.pojo.*;
import edu.hut.hz.dao.InvestigateMapper;
import edu.hut.hz.service.InvestigateService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

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
public class InvestigateServiceImpl extends ServiceImpl<InvestigateMapper, Investigate> implements InvestigateService {

    @Autowired
    ClasMapper clasMapper;

    @Autowired
    TeacherMapper teacherMapper;

    @Autowired
    StudentMapper studentMapper;

    public Msg investigateGet(Clas clas){

        //班级信息
        Clas clas1 = clasMapper.selectOne(new QueryWrapper<Clas>().eq("cla_id", clas.getClaId()));

        if (clas1 == null){
            return Msg.fail().add("Fail","没有班级信息");
        }

        //班主任信息
        Teacher teacher = teacherMapper.selectById(clas1.getClaTno());

        //获取班级学生信息
        List<Student> students = studentMapper.selectList(new QueryWrapper<Student>().eq("cla_id", clas.getClaId()));

        return Msg.success().add("studentMsg",students).add("clasMsg",clas1).add("teacherMsg",teacher);

    }

    public Msg investigateList(String tno,Integer pn){

        //学生按星期统计

        //引入分页插件
        //传入页码以及每页大小
        PageHelper.startPage(pn,7);
        List<Investigate> list = baseMapper.selectList(new QueryWrapper<Investigate>().eq("tno", tno).orderByDesc("add_time"));
        //使用PageInfo包装查询结果
        //封装了页面详细信息，包括list数据库查询出的数据，第二参数传入连续显示的页数
        PageInfo page = new PageInfo(list,5);
        return Msg.success().add("pageInfo",page);
    }
}
