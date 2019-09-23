package edu.hut.hz.service;

import com.baomidou.mybatisplus.extension.service.IService;
import edu.hut.hz.pojo.Msg;
import edu.hut.hz.pojo.Schedule;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Carlson
 * @since 2019-04-18
 */
public interface ScheduleService extends IService<Schedule> {

    /**
     * @Description //获取课表信息
     * @Date 23:14 2019/4/3
     * @Author Carlson
     * @Param [pn]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg scheduleList(Integer pn);

    /**
     * @Description //课表信息更新
     * @Date 16:02 2019/4/4
     * @Author Carlson
     * @Param [teacher]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg scheduleUpdate(Schedule schedule);

    /**
     * @Description //单个课表信息新增
     * @Date 16:59 2019/4/15
     * @Author Carlson
     * @Param [schedule]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg scheduleMsgAdd(Schedule schedule);

    /**
     * @Description //删除一个课表
     * @Date 16:04 2019/4/14
     * @Author Carlson
     * @Param [String]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg scheduleOneDelete(String scheduleId);

    /**
     * @Description //查询课表信息
     * @Date 22:56 2019/4/15
     * @Author Carlson
     * @Param [msg：查询的信息, pn：查询的类型]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg needScheduleMsg(String msg, Integer pn);

    /**
     * @Description //一个班的课表信息
     * @Date 22:56 2019/4/15
     * @Author Carlson
     * @Param [claId]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg scheduleOneClass(Integer claId);
}
