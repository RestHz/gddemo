package edu.hut.hz.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import edu.hut.hz.pojo.Teacher;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author Carlson
 * @since 2019-04-10
 */
public interface TeacherMapper extends BaseMapper<Teacher> {

    /**
     * @Description //老师信息模糊查询
     * @Date 21:45 2019/4/16
     * @Author Carlson
     * @Param [msg]
     * @return java.util.List<edu.hut.hz.pojo.Teacher>
     **/
    List<Teacher> teacherNeedSelect(String msg);
}
