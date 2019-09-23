package edu.hut.hz.dao;

import edu.hut.hz.pojo.Student;
import edu.hut.hz.pojo.User;
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
public interface UserMapper extends BaseMapper<User> {
    /**
     * @Description //模糊查询
     * @Author Carlson
     **/
    List<User> userNeedMsg(String msg);
}
