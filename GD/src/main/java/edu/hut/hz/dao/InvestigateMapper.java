package edu.hut.hz.dao;

import edu.hut.hz.pojo.InvStatistic;
import edu.hut.hz.pojo.Investigate;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author Carlson
 * @since 2019-04-10
 */
public interface InvestigateMapper extends BaseMapper<Investigate> {

    List<InvStatistic> invStaByWeek(InvStatistic invStatistic);

    List<InvStatistic> invStaByMonth(InvStatistic invStatistic);

    List<InvStatistic> invStaByMonthLastTerm(InvStatistic invStatistic);

    List<InvStatistic> invStaByNextTerm(InvStatistic invStatistic);

}
