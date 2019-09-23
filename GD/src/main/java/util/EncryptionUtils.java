package util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

/**
 * @ClassName: EncryptionUtils
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/4/3 22:21
 * @Version: 1.0
 **/
public class EncryptionUtils {

    public static String md5(String password){
        try {
            //创建MD5算法
            MessageDigest md = MessageDigest.getInstance("md5");
            //通过MD5计算摘要
            byte[] digest = md.digest(password.getBytes("utf-8"));
            //使用BASE64编码,  a-z A-Z 0-9 / *
            String encryptionPwd = Base64.getEncoder().encodeToString(digest);
            //返回加密密码
            return encryptionPwd;
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return null;
    }
}
