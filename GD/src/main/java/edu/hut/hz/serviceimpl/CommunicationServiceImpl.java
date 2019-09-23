package edu.hut.hz.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.org.apache.regexp.internal.RE;
import edu.hut.hz.dao.CommunicationMapper;
import edu.hut.hz.dao.TeacherMapper;
import edu.hut.hz.dao.UserMapper;
import edu.hut.hz.pojo.*;
import edu.hut.hz.service.CommunicationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author Carlson
 * @since 2019-04-10
 */
@Service
public class CommunicationServiceImpl extends ServiceImpl<CommunicationMapper, Communication> implements CommunicationService {

    @Autowired
    TeacherMapper teacherMapper;

    @Autowired
    UserMapper userMapper;

    /**
     * 所有留言信息
     * @Param
     * @return
     **/
    @Override
    public Msg senderCommunicationList(String sender,Integer pn,Integer orderByType) {

        if (orderByType == null){
            return Msg.fail().add("Fail","请传出排序类型");
        }

        if (sender == null || "".equals(sender)){
            return Msg.fail().add("Fail","请输入发送者账号！");
        }

        //返回分页信息
        PageInfo page;
        //返回的数据
        List<Communication> list = new ArrayList<>();

        //默认按发送时间降序排序，第一条为最新发送
        if (orderByType == 0){
            //引入分页插件
            //传入页码以及每页大小
            PageHelper.startPage(pn,5);

            //查询发送人所有留言信息,并按添加时间排序
            list = baseMapper.selectList(new QueryWrapper<Communication>().
                    eq("sender",sender).
                    or().eq("recipient", sender).
                    orderByDesc("add_time"));

        }

        //按回复时间降序排序，第一条为最新回复
        if (orderByType == 1){
            //引入分页插件
            //传入页码以及每页大小
            PageHelper.startPage(pn,5);

            list = baseMapper.selectList(new QueryWrapper<Communication>().
                    eq("sender",sender).
                    or().eq("recipient", sender).
                    orderByDesc("reply_time"));
        }

        //按状态为未读的发送时间降序排序
        if (orderByType == 2){
            //引入分页插件
            //传入页码以及每页大小
            PageHelper.startPage(pn,5);

            list = baseMapper.selectList(new QueryWrapper<Communication>().
                    eq("sender",sender).
                    or().eq("recipient", sender).
                    eq("cw_status","未读").
                    orderByDesc("add_time"));
        }

        //按状态为已回复的回复时间降序排序
        if (orderByType == 3){
            //引入分页插件
            //传入页码以及每页大小
            PageHelper.startPage(pn,5);

            list = baseMapper.selectList(new QueryWrapper<Communication>().
                    eq("sender",sender).
                    or().eq("recipient", sender).
                    eq("cw_status","已回复").
                    orderByDesc("reply_time"));
        }

        //关于我的留言
        if (orderByType == 4){
            //引入分页插件
            //传入页码以及每页大小
            PageHelper.startPage(pn,5);

            list = baseMapper.selectList(new QueryWrapper<Communication>().
                    eq("recipient",sender).
                    eq("cw_status","未读").
                    orderByDesc("add_time"));

        }

        //查询结果为空
        if (list == null){
            return Msg.fail().add("Fail","没有关于【"+sender+"】的留言信息！");
        }

        //使用PageInfo包装查询结果
        //封装了页面详细信息，包括list数据库查询出的数据，第二参数传入连续显示的页数
        page = new PageInfo(list,3);

        return Msg.success().add("pageInfo",page).add("orderByType",orderByType);
    }

    /**
     * 发送人信息
     * @Param
     * @return
     **/
    @Override
    public Msg senderMsg(String sender) {

        //留言人为老师
        Teacher teacher = teacherMapper.selectOne(new QueryWrapper<Teacher>().eq("tno", sender));

        if (teacher != null){
            return Msg.success().add("SenderName",teacher.getTcName()).add("SenderAccount",teacher.getTno());
        }

        //留言人为家长
        User user = userMapper.selectOne(new QueryWrapper<User>().eq("account", sender));

        if (user != null){
            return Msg.success().add("SenderName",user.getUserName()).add("SenderAccount",user.getAccount());
        }
        return Msg.fail().add("Fail","没有 "+sender+" 发送人信息！");
    }

    /**
     * 根据留言编号删除信息
     * @param
     */
    @Override
    public Msg communicationOneDelete(String cmId){

        //删除
        int delete1 = baseMapper.delete(new QueryWrapper<Communication>().eq("cm_id",cmId));

        if (delete1 > 0){
            return Msg.success().add("Success","删除成功！");
        }
        return Msg.fail().add("Fail","删除失败！");
    }

    /**
     * 添加一条留言信息
     * @Param
     * @return
     **/
    @Override
    public Msg communicationMsgAdd(Communication communication){

        //判断接收人是否存在
        Integer tnoCount = teacherMapper.selectCount(new QueryWrapper<Teacher>().eq("tno", communication.getRecipient()));
        Integer userCount = userMapper.selectCount(new QueryWrapper<User>().eq("account", communication.getRecipient()));
        if (tnoCount < 1 & userCount < 1){
            return Msg.fail().add("Fail","不存在接收者，请输入正确信息！");
        }

        //设置日期格式
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        // new Date()为获取当前系统时间，设置留言时间
        communication.setAddTime(df.format(new Date()));

        //保存留言信息
        boolean insert = save(communication);
        if (insert){
            return Msg.success().add("Success","留言成功！");
        }
        //添加失败
        return Msg.fail().add("Fail","留言失败！");
    }

    /**
     * 留言回复，或修改
     * @Param
     * @return
     **/
    @Override
    public Msg replyMessage(Communication communication) {

        //如果回复内容为空，则为修改留言信息
        if (communication.getReplyContent() == null || "".equals(communication.getReplyContent())){
            //更新时间
            //设置日期格式
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            // new Date()为获取当前系统时间，设置留言时间
            communication.setAddTime(df.format(new Date()));
            int update = baseMapper.updateById(communication);
            if (update > 0){
                return Msg.success().add("Success","修改成功！");
            }
            return Msg.fail().add("Fail","修改失败！");
        }

        //留言回复
        //设置回复时间
        //设置日期格式
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        // new Date()为获取当前系统时间，设置留言时间
        communication.setReplyTime(df.format(new Date()));
        //设置留言状态
        communication.setCwStatus("已回复");

        int update1 = baseMapper.updateById(communication);

        if (update1 > 0){
            return Msg.success().add("Success","已回复！");
        }
        return Msg.fail().add("Fail","回复失败，请重试！");
    }


}
