package edu.hut.hz.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.hut.hz.dao.ClasMapper;
import edu.hut.hz.dao.ScheduleMapper;
import edu.hut.hz.pojo.Clas;
import edu.hut.hz.pojo.Msg;
import edu.hut.hz.pojo.Schedule;
import edu.hut.hz.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author Carlson
 * @since 2019-04-18
 */
@Service
public class ScheduleServiceImpl extends ServiceImpl<ScheduleMapper, Schedule> implements ScheduleService {

    @Autowired
    ClasMapper clasMapper;

    /**
     * 所有课表信息
     * @Param
     * @return
     **/
    @Override
    public Msg scheduleList(Integer pn) {
        //引入分页插件
        //传入页码以及每页大小
        PageHelper.startPage(pn,7);
        //按班级分组
        List<Schedule> list = baseMapper.selectList(new QueryWrapper<Schedule>().groupBy("cla_id"));
        //查询出班级名称
        List<Clas> clasList = new ArrayList<>(list.size());
        for (Schedule s:list) {
            Clas clas = clasMapper.selectById(s.getClaId());
            clasList.add(clas);
        }
        //使用PageInfo包装查询结果
        //封装了页面详细信息，包括list数据库查询出的数据，第二参数传入连续显示的页数
        PageInfo page = new PageInfo(list,5);
        return Msg.success().add("pageInfo",page).add("clasList",clasList);
    }

    @Override
    public Msg scheduleUpdate(Schedule schedule) {
        return null;
    }

    @Override
    public Msg scheduleMsgAdd(Schedule schedule) {
        return null;
    }

    @Override
    public Msg scheduleOneDelete(String scheduleId) {
        return null;
    }

    @Override
    public Msg needScheduleMsg(String msg, Integer pn) {
        return null;
    }


    /**
     * @Description //班级课表获取
     * @Date 23:08 2019/4/20
     * @Author Carlson
     * @Param [claId]
     * @return edu.hut.hz.pojo.Msg
     **/
    @Override
    public Msg scheduleOneClass(Integer claId) {
        
        //获取班级信息
        Clas clas1 = clasMapper.selectById(claId);

        //按班级分组,所有课表
        List<Schedule> scheduleList = baseMapper.selectList(new QueryWrapper<Schedule>().eq("cla_id",claId));

        if (scheduleList == null){
            return Msg.fail().add("Fail","没有 "+clas1.getClaId()+" : "+clas1.getClaName()+" 的班级课表");
        }

        //查询各个学年学期
        List<Schedule> yearTerms = baseMapper.selectList(new QueryWrapper<Schedule>().groupBy("exam_year").groupBy("exam_term"));

        return Msg.success().add("scheduleList",scheduleList).add("yearTerms",yearTerms).add("clas",clas1);
    }
}
