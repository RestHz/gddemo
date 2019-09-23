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
public class Clas extends Model<Clas> {

    private static final long serialVersionUID = 1L;

    /**
     * 班级号
     */
    @TableId(value = "cla_id", type = IdType.AUTO)
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private Integer claId;

    /**
     * 班级名
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String claName;

    /**
     * 班主任
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String claTno;


    @Override
    protected Serializable pkVal() {
        return this.claId;
    }

}
