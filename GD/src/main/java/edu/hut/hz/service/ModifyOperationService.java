package edu.hut.hz.service;

import edu.hut.hz.pojo.Msg;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;

/**
 * @ClassName: ModifyOperationService
 * @Description: 信息的修改或获取,文件的上传或下载
 * @Author: Carlson
 * @Date 2019/4/5 16:24
 * @Version: 1.0
 **/
public interface ModifyOperationService {

    /**
     * @Description //头像的上传
     * @Date 14:07 2019/4/5
     * @Author Carlson
     * @Param [file, name, response]
     * @return edu.hut.hz.pojo.Msg
     **/
    Msg imageFileLoad(MultipartFile file) throws Exception;


    /**
     * @Description //学生资料下载（Excel）
     * @Date 15:53 2019/4/6
     * @Author Carlson
     * @Param [response]
     * @return void
     **/
    void excelDownLoad(HttpServletResponse response);

}
