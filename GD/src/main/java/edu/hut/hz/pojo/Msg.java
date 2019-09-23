package edu.hut.hz.pojo;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName: Msg
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/3/23 20:07
 * @Version: 1.0
 **/
@Data
public class Msg {
    /**
     * 状态码
     */
    private int code;
    /**
     * 成功状态码:200
     */
    public static final int SUCCESSCODE=200;
    /**
     * 失败状态码:100
     */
    public static final int FAILCODE=100;

    /**
     *  用于提示信息
     */
    private String prompt;

    /**
     * 封装返回内容
     */
    private Map<String,Object> msgContent = new HashMap<>();

    /**
     * 处理成功所调用的方法
     **/
    public static Msg success(){
        Msg result = new Msg();
        result.setCode(SUCCESSCODE);
        result.setPrompt("处理成功!");
        return result;
    }

    /**
     * 处理失败所调用的方法
     **/
    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(FAILCODE);
        result.setPrompt("处理失败,请重试!");
        return result;
    }

    /**
     * 添加返回内容的方法
     */
    public Msg add(String key, Object value){
        this.getMsgContent().put(key,value);
        return this;
    }
}
