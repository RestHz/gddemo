package edu.hut.hz.pojo;

import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import java.time.LocalDate;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

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
public class Investigate extends Model<Investigate> {

    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @TableId(value = "inv_id", type = IdType.AUTO)
    private Integer invId;

    /**
     * 缺勤学生学号
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String sno;

    /**
     * 学生姓名
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String stuName;

    /**
     * 学生班级名
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String claName;

    /**
     * 日期
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String addTime;

    /**
     * 情况
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String situation;

    /**
     * 备注
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String remark;

    /**
     * 班主任
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String tno;

    /**
     * 上传者
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String tcName;


    @Override
    protected Serializable pkVal() {
        return this.invId;
    }

}
