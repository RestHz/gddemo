package edu.hut.hz.controller;

import edu.hut.hz.pojo.Msg;
import edu.hut.hz.serviceimpl.ModifyOperationServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import util.UpDownFileUtils;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

/**
 * @ClassName: FileUpDownController
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/4/6 18:03
 * @Version: 1.0
 **/
@Controller
@RequestMapping("/file")
public class FileUpDownController {

    @Autowired
    ModifyOperationServiceImpl modifyOperationService;

    @RequestMapping(value = "/image", method = RequestMethod.GET)
    public void imageFileDown(@RequestParam(value = "imageName")String file,
                              HttpServletResponse response){
        response.setContentType("image/jpeg");
        FileInputStream fileInputStream = null;
        try {
            fileInputStream = new FileInputStream(
                    new File(UpDownFileUtils.IMAGE_FILE_DIR + file));
            StreamUtils.copy(fileInputStream,
                    response.getOutputStream());
        }catch (Exception e){
            System.out.println("文件流错误:"+e.getMessage());
        }finally {
            try {
                fileInputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }

    /**
     * 课表
     * @Param
     * @return
     **/
    @RequestMapping(value = "/scheduleModelDown")
    public void scheduleModelDown(HttpServletResponse response){
        modifyOperationService.scheduleModelDownLoad(response);
    }
    @RequestMapping(value = "/scheduleUpLoad",method = RequestMethod.POST)
    @ResponseBody
    public Msg scheduleUpLoad(@RequestParam(defaultValue = "") MultipartFile scheduleFile){
        if (scheduleFile.isEmpty()){
            return Msg.fail().add("Fail","请上传文件");
        }
        try {
            return modifyOperationService.scheduleUpLoad(scheduleFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Msg.fail().add("Fail","文件解析错误!");
    }

    /**
     * 成绩模板
     * @Param
     * @return
     **/
    @RequestMapping(value = "/scoreModelDown")
    public void scoreModelDown(HttpServletResponse response,String tno){
        System.out.println(tno);
        modifyOperationService.scoreModelDown(response,tno);
    }
    @RequestMapping(value = "/scoreUpLoad",method = RequestMethod.POST)
    @ResponseBody
    public Msg scoreUpLoad(@RequestParam(defaultValue = "") MultipartFile scoreFile,String tno){
        if (scoreFile.isEmpty()){
            return Msg.fail().add("Fail","请上传文件");
        }
        try {
            return modifyOperationService.scoreUpLoad(scoreFile,tno);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Msg.fail().add("Fail","文件解析错误!");
    }


}
