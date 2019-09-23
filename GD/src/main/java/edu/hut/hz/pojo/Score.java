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
public class Score extends Model<Score> {

    private static final long serialVersionUID = 1L;

    /**
     * 成绩编号
     */
    @TableId(value = "score_id", type = IdType.AUTO)
    private Integer scoreId;

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
     * 课程名
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String courseName;

    /**
     * 班级名
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String claName;

    /**
     * 考生姓名
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String stuName;

    /**
     * 考试成绩
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private Double examScore;

    /**
     * 考试时间
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String examTime;

    /**
     * 上传教师编号
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String tno;

    /**
     * 学号
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String sno;

    /**
     * 课程编号
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String cno;


    @Override
    protected Serializable pkVal() {
        return this.scoreId;
    }

}
