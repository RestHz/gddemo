package edu.hut.hz.dao;

import edu.hut.hz.pojo.Student;
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
public interface StudentMapper extends BaseMapper<Student> {
    /**
     * @Description //更新一条数据
     * @Date 16:46 2019/4/4
     * @Author Carlson
     * @Param [student]
     * @return int
     **/
    int studentOneUpdate(Student student);

    /**
     * @Description //模糊查询
     * @Date 21:40 2019/4/16
     * @Author Carlson
     * @Param [msg]
     * @return java.util.List<edu.hut.hz.pojo.Student>
     **/
    List<Student> studentNeedSelect(String msg);
}
