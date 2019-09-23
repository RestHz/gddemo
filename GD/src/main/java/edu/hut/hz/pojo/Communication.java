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
import java.sql.Date;

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
public class Communication extends Model<Communication> {

    private static final long serialVersionUID = 1L;

    /**
     * 编号
     */
    @TableId(value = "cm_id", type = IdType.AUTO)
    private Integer cmId;

    /**
     * 标题
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String cmTitle;

    /**
     * 消息内容
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String content;

    /**
     * 回复内容
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String replyContent;

    /**
     * 留言人
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String sender;

    /**
     * 接收者
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String recipient;

    /**
     * 发送时间
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String addTime;

    /**
     * 回复时间
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String replyTime;

    /**
     * 信息状态
     */
    @TableField(strategy = FieldStrategy.NOT_EMPTY)
    private String cwStatus;


    @Override
    protected Serializable pkVal() {
        return this.cmId;
    }

}
