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
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class User extends Model<User> {

    private static final long serialVersionUID = 1L;

    /**
     * 用户账号
     */
    @TableId(value = "account", type = IdType.INPUT)
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String account;

    /**
     * 用户姓名
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String userName;

    /**
     * 用户密码
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String userPwd;

    /**
     * 用户性别
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String userSex;

    /**
     * 用户年龄
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private Integer userAge;

    /**
     * 邮箱
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String userEmail;

    /**
     * 用户电话
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String userPhone;

    /**
     * 用户住址
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String address;

    /**
     * 用户照片
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String userPicture;

    /**
     * 学生学号
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String sno;

    /**
     * 学生班级名
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String claName;

    /**
     * 学生姓名
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String stuName;

    /**
     * 与学生关系
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String relation;

    /**
     * 角色
     */
    @Builder.Default
    private Integer role = 3;




    @Override
    protected Serializable pkVal() {
        return this.account;
    }

}
