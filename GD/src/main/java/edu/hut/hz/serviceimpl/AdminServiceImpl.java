package edu.hut.hz.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import edu.hut.hz.dao.AdminMapper;
import edu.hut.hz.pojo.Admin;
import edu.hut.hz.pojo.LoginMsg;
import edu.hut.hz.pojo.Msg;
import edu.hut.hz.service.AdminService;
import org.springframework.stereotype.Service;
import util.EncryptionUtils;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author Carlson
 * @since 2019-04-10
 */
@Service
public class AdminServiceImpl extends ServiceImpl<AdminMapper, Admin> implements AdminService {

    @Override
    public Msg adminLogin(LoginMsg admin) {
        //获取登录账号
        String account = admin.getAccount();
        //查询账号
        QueryWrapper<Admin> queryWrapper = new QueryWrapper<>();
        Admin admin1 = baseMapper.selectOne(queryWrapper.eq("account", account));
        //账号存在
        if (admin1 != null) {
            //验证密码
            String encryptionPwd = EncryptionUtils.md5(admin1.getPassword());
            //判断密码是否正确(有默认密码,修改后的密码会有MD5加密)
            if (encryptionPwd.equals(admin.getPassword()) || admin1.getPassword().equals(admin.getPassword())) {
                return Msg.success().add("Success", "登录成功!").add("Role",0).add("AdminMsg",admin1);
            } else {
                return Msg.fail().add("Fail", "密码错误!");
            }
        }
        return Msg.fail().add("Fail", "账号不存在!");
    }
}
