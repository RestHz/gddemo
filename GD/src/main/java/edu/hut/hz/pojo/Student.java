package edu.hut.hz.pojo;

import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.*;
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
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Student extends Model<Student> {

    private static final long serialVersionUID = 1L;

    /**
     * 学号
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    @TableId(value = "sno", type = IdType.INPUT)
    private String sno;

    /**
     * 学生姓名
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String stuName;

    /**
     * 学生密码
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String stuPwd;

    /**
     * 学生性别
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String stuSex;

    /**
     * 年龄
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private Integer stuAge;

    /**
     * 邮箱
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String stuEmail;

    /**
     * 学生电话
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String stuPhone;

    /**
     * 学生住址
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String stuAddress;

    /**
     * 学生照片
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String stuPicture;

    /**
     * 年级
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String grade;

    /**
     * 班级编号
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private Integer claId;

    /**
     * 课程编号
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String cno;

    /**
     * 角色
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    @Builder.Default
    private Integer role = 1;




    @Override
    protected Serializable pkVal() {
        return this.sno;
    }

}
