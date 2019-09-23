package edu.hut.hz.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import edu.hut.hz.pojo.Score;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author Carlson
 * @since 2019-04-10
 */
public interface ScoreMapper extends BaseMapper<Score> {

    /**
     * @Description //成绩信息模糊查询
     * @Date 21:45 2019/4/16
     * @Author Carlson
     * @Param [msg]
     * @return java.util.List<edu.hut.hz.pojo.Teacher>
     **/
    List<Score> scoreNeedSelect(String msg);

    Double scoreMax(Score score);
    Double scoreAvg(Score score);

    Double stuScoreSum(Score score);
    Double stuScoreAvg(Score score);
}
