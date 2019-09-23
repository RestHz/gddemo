package edu.hut.hz.pojo;

import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author Carlson
 * @since 2019-04-10
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Course extends Model<Course> {

    private static final long serialVersionUID = 1L;

    /**
     * 课程编号
     */
    @TableId(value = "cno", type = IdType.INPUT)
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String cno;

    /**
     * 课程名
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String courseName;

    /**
     * 学时
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private Integer courseTime;




    @Override
    protected Serializable pkVal() {
        return this.cno;
    }

}
