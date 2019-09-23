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
 * @since 2019-04-18
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Schedule extends Model<Schedule> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "schedule_id", type = IdType.AUTO)
    private Integer scheduleId;

    /**
     * 星期
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String week;

    /**
     * 第一节课
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String firstLesson;

    /**
     * 第二节课
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String secondLesson;

    /**
     * 第三节课
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String thirdLesson;

    /**
     * 第四节课
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String fourthLesson;

    /**
     * 第五节课
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String fifthLesson;

    /**
     * 第六节课
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String sixthLesson;

    /**
     * 第七节课
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String seventhLesson;

    /**
     * 第八节课
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String eighthLesson;

    /**
     * 学年
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String examYear;

    /**
     * 学期
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String examTerm;

    /**
     * 班级ID
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private Integer claId;

    /**
     * 备注
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String status;


    @Override
    protected Serializable pkVal() {
        return this.scheduleId;
    }

}
