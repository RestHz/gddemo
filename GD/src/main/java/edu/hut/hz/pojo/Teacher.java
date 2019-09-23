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
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Teacher extends Model<Teacher> {

    private static final long serialVersionUID = 1L;

    /**
     * 教师编号
     */
    @TableId(value = "tno", type = IdType.INPUT)
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String tno;

    /**
     * 教师姓名
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String tcName;

    /**
     * 教师密码
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String tcPwd;

    /**
     * 教师性别
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String tcSex;

    /**
     * 教师年龄
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private Integer tcAge;

    /**
     * 邮箱
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String tcEmail;

    /**
     * 教师电话
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String tcPhone;

    /**
     * 教师照片
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String tcPicture;

    /**
     * 班级ID
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
    private Integer role = 2;
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String courseName;


    @Override
    protected Serializable pkVal() {
        return this.tno;
    }

}
