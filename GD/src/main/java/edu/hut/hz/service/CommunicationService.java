package edu.hut.hz.service;

import com.baomidou.mybatisplus.extension.service.IService;
import edu.hut.hz.pojo.Communication;
import edu.hut.hz.pojo.Msg;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Carlson
 * @since 2019-04-10
 */
public interface CommunicationService extends IService<Communication> {

    /**
     * @Description //获取发送者留言信息
     * @Date 17:55 2019/4/22
     * @Author Carlson
     * @Param [sender,pn,orderByType]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg senderCommunicationList(String sender,Integer pn,Integer orderByType);


    /**
     * @Description //发送者的信息
     * @Date 18:13 2019/4/22
     * @Author Carlson
     * @Param [sender]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg senderMsg(String sender);

    /**
     * @Description //删除一条留言信息
     * @Date 16:04 2019/4/14
     * @Author Carlson
     * @Param [String]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg communicationOneDelete(String cmId);

    /**
     * @Description //留言信息新增
     * @Date 16:59 2019/4/15
     * @Author Carlson
     * @Param [teacher]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg communicationMsgAdd(Communication communication);

    /**
     * @Description //回复留言
     * @Date 21:25 2019/4/23
     * @Author Carlson
     * @Param [communication]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg replyMessage(Communication communication);
}
