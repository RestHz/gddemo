package edu.hut.hz.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
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
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Admin extends Model<Admin> {

    private static final long serialVersionUID = 1L;

    /**
     * 管理员帐号
     */
    @TableId(value = "account", type = IdType.AUTO)
    private String account;

    /**
     * 管理员姓名
     */
    private String name;

    /**
     * 管理员密码
     */
    private String password;

    /**
     * 管理员电话
     */
    private String telephone;


    @Override
    protected Serializable pkVal() {
        return this.account;
    }

}
