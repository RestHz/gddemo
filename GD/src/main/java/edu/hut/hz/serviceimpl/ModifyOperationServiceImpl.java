package edu.hut.hz.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import edu.hut.hz.dao.ClasMapper;
import edu.hut.hz.dao.CourseMapper;
import edu.hut.hz.dao.ScheduleMapper;
import edu.hut.hz.dao.ScoreMapper;
import edu.hut.hz.pojo.*;
import edu.hut.hz.service.ModifyOperationService;
import org.apache.commons.io.FileUtils;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import util.ExtensionNameUtils;
import util.UpDownFileUtils;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @ClassName: ModifyOperationServiceImpl
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/4/5 16:28
 * @Version: 1.0
 **/
@Service
public class ModifyOperationServiceImpl implements ModifyOperationService {

    @Autowired
    StudentServiceImpl studentService;

    @Autowired
    ScheduleMapper scheduleMapper;

    @Autowired
    TeacherServiceImpl teacherService;

    @Autowired
    CourseMapper courseMapper;

    @Autowired
    ClasMapper clasMapper;

    @Autowired
    ScoreMapper scoreMapper;

    @Override
    public Msg imageFileLoad(MultipartFile file) throws Exception{

        //上传图片
        if (file != null){

            //获取文件类型
            ExtensionNameUtils.formatName extName = ExtensionNameUtils.determineExtName(file);

            if (extName != ExtensionNameUtils.formatName.Images){
                return Msg.fail().add("FileError","请上传图片!{\"jpg\",\"bmp\",\"jpeg\",\"png\"}");
            }

            //创建头像名加扩展名
            String fileName = UUID.randomUUID().toString().replaceAll("-","")+"."+ ExtensionNameUtils.fileSuffixName;
            //存储图片到文件夹
            InputStream inputStream = null;
            try {
                inputStream = file.getInputStream();
                FileUtils.copyInputStreamToFile(inputStream,
                        new File(UpDownFileUtils.IMAGE_FILE_DIR + fileName));
            } catch (IOException e) {
                e.printStackTrace();
            }finally {
                inputStream.close();
            }
            //返回头像名
            return Msg.success().add("HeadPortraitName",fileName);
        }
        return Msg.fail().add("Fail","请求错误!");
    }

    @Override
    public void excelDownLoad(HttpServletResponse response) {
        //得到员工信息
        List<Student> studentsList = studentService.list();
        /**
         * 创建工作薄,创建样式
         */
        //97-03版
        //创建一个工作薄
        XSSFWorkbook wb = new XSSFWorkbook();
        //创建表样式
        XSSFCellStyle style_content = wb.createCellStyle();
        //下边框
        style_content.setBorderBottom(BorderStyle.THIN);

        //水平对齐方式
        style_content.setAlignment(HorizontalAlignment.CENTER);
        //垂直居中
        style_content.setVerticalAlignment(VerticalAlignment.CENTER);

        //创建设置字体样式
        XSSFFont font_content = wb.createFont();
        font_content.setFontName("宋体");
        font_content.setFontHeightInPoints((short)11);
        style_content.setFont(font_content);

        /**
         * 创建表,设置表及样式
         */
        //创建一个工作表
        XSSFSheet sheet = wb.createSheet("学生信息");
        //设置行高
        sheet.setDefaultRowHeight((short)800);
        //创建一行,行的索引是从0开始,写标题
        //标题
        String[] title = {"学号","姓名","性别","年级","班级","邮箱","电话","地址","课程号"};
        //列宽度
        int[] width = {5000,4000,1500,3000,5000,7000,5000,8000,5000};
        XSSFRow row = sheet.createRow(0);
        //创建表头
        XSSFCell cell = null;
        for (int i = 0;i<title.length;i++){
            //创建一列,列的索引是从0开始
            cell = row.createCell(i);
            cell.setCellValue(title[i]);
            //设置单元格样式
            cell.setCellStyle(style_content);
            //设置宽度
            sheet.setColumnWidth(i,width[i]);
        }
        //导出内容
        int rowCount = 1;
        for (Student stu : studentsList) {
            row = sheet.createRow(rowCount);
            row.createCell(0).setCellValue(stu.getSno());
            row.createCell(1).setCellValue(stu.getStuName());
            row.createCell(2).setCellValue(stu.getStuSex());
            row.createCell(3).setCellValue(stu.getGrade());
            row.createCell(4).setCellValue(stu.getClaId());
            row.createCell(5).setCellValue(stu.getStuEmail());
            row.createCell(6).setCellValue(stu.getStuPhone());
            row.createCell(7).setCellValue(stu.getStuAddress());
            row.createCell(8).setCellValue(stu.getCno());
            rowCount++;
        }

        try {
            String filename = "学生表.xlsx";
            //输出前设置响应格式
            response.setHeader("Content-Disposition","attachment;filename="+
                    new String(filename.getBytes(),"ISO-8859-1"));

            //输出响应文件
            wb.write(response.getOutputStream());

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 课表模板
     * @Param
     * @return
     **/
    public void scheduleModelDownLoad(HttpServletResponse response) {

        /**
         * 创建工作薄,创建样式
         */
        //创建一个工作薄

        XSSFWorkbook wb = new XSSFWorkbook();
        //创建表样式
        XSSFCellStyle style_content = wb.createCellStyle();
        //下边框
        style_content.setBorderBottom(BorderStyle.THIN);

        //水平对齐方式
        style_content.setAlignment(HorizontalAlignment.CENTER);
        //垂直居中
        style_content.setVerticalAlignment(VerticalAlignment.CENTER);

        //创建设置字体样式
        XSSFFont font_content = wb.createFont();
        font_content.setFontName("宋体");
        font_content.setFontHeightInPoints((short)11);
        style_content.setFont(font_content);

        /**
         * 创建表,设置表及样式
         */
        //创建一个工作表
        XSSFSheet sheet = wb.createSheet("课表模板");
        //设置行高
        sheet.setDefaultRowHeight((short)800);
        sheet.setDefaultColumnWidth((short)1500);
        //创建一行,行的索引是从0开始,写标题
        XSSFRow row = sheet.createRow(0);
        //创建表头
        XSSFCell cell = null;

        //创建一列,列的索引是从0开始
        cell = row.createCell(0);
        cell.setCellValue("学年:");
        cell = row.createCell(2);
        cell.setCellValue("学期:");
        cell = row.createCell(4);
        cell.setCellValue("班级号:");
        //设置单元格样式
        cell.setCellStyle(style_content);

        //导出内容
        row = sheet.createRow(1);
        for (int i = 1; i <= 8; i++) {
            row.createCell(i).setCellValue("第 "+i+" 节课");
        }
        row = sheet.createRow(2);
        row.createCell(0).setCellValue("星期一");
        row = sheet.createRow(3);
        row.createCell(0).setCellValue("星期二");
        row = sheet.createRow(4);
        row.createCell(0).setCellValue("星期三");
        row = sheet.createRow(5);
        row.createCell(0).setCellValue("星期四");
        row = sheet.createRow(6);
        row.createCell(0).setCellValue("星期五");

        try {
            String filename = "请按课表模板填写信息.xlsx";
            //输出前设置响应格式
            response.setHeader("Content-Disposition","attachment;filename="+
                    new String(filename.getBytes(),"ISO-8859-1"));

            //输出响应文件
            wb.write(response.getOutputStream());

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 课表解析保存
     * @Param
     * @return
     **/
    public Msg scheduleUpLoad(MultipartFile scheduleFile)throws Exception{
        InputStream inputStream = scheduleFile.getInputStream();

        //创建工作薄
        XSSFWorkbook wb = new XSSFWorkbook(inputStream);
        //创建表
        XSSFSheet sheet = wb.getSheetAt(0);
        //读取数据
        //获取最后一行
        int lastRow = sheet.getLastRowNum();
        int result = 0;
        Schedule schedule = null;
        String examYear = sheet.getRow(0).getCell(1).getStringCellValue();
        String examTerm = sheet.getRow(0).getCell(3).getStringCellValue();
        double numericCellValue = sheet.getRow(0).getCell(5).getNumericCellValue();
        Integer claId = (int)numericCellValue;

        Integer count = 0;
        for (int i=2;i<=lastRow;i++){
            //创建对象,获取值
            schedule = new Schedule();
            schedule.setExamYear(examYear);
            schedule.setExamTerm(examTerm);
            schedule.setClaId(claId);
            schedule.setWeek(sheet.getRow(i).getCell(0).getStringCellValue());
            schedule.setFirstLesson(sheet.getRow(i).getCell(1).getStringCellValue());
            schedule.setSecondLesson(sheet.getRow(i).getCell(2).getStringCellValue());
            schedule.setThirdLesson(sheet.getRow(i).getCell(3).getStringCellValue());
            schedule.setFourthLesson(sheet.getRow(i).getCell(4).getStringCellValue());
            schedule.setFifthLesson(sheet.getRow(i).getCell(5).getStringCellValue());
            schedule.setSixthLesson(sheet.getRow(i).getCell(6).getStringCellValue());
            schedule.setSeventhLesson(sheet.getRow(i).getCell(7).getStringCellValue());
            schedule.setEighthLesson(sheet.getRow(i).getCell(8).getStringCellValue());

            //判断此课表是否存在
            if (i == 2){
                count=scheduleMapper.selectCount(new QueryWrapper<Schedule>().eq("exam_year",examYear).
                        eq("exam_term",examTerm).eq("cla_id",claId));
            }
            if (count > 0){
                //存在
                return Msg.fail().add("Fail","课表已存在");
            }else{
                //新增
                result = scheduleMapper.insert(schedule);
                if (result < 1){
                    return Msg.fail().add("Fail","添加失败！");
                }
            }
        }

        return Msg.success().add("Success","课表添加成功！");
    }


    /**
     * 成绩模板
     * @Param
     * @return
     **/
    public void scoreModelDown(HttpServletResponse response,String tno) {

        Teacher teacher = teacherService.getById(tno);
        List<Student> studentList = studentService.list(new QueryWrapper<Student>().eq("cla_id", teacher.getClaId()));
        Course course = courseMapper.selectById(teacher.getCno());
        List<Schedule> scheduleList = scheduleMapper.selectList(new QueryWrapper<Schedule>().groupBy("exam_year").groupBy("exam_term").orderByDesc("exam_year"));

        Schedule schedule = scheduleList.get(0);
        Clas clas = clasMapper.selectById(schedule.getClaId());

        //创建一个工作薄

        XSSFWorkbook wb = new XSSFWorkbook();

        /**
         * 创建表,设置表及样式
         */
        //创建一个工作表
        XSSFSheet sheet = wb.createSheet("成绩模板");
        sheet.autoSizeColumn(1, true);
        //设置行高
        sheet.setDefaultRowHeight((short)800);
        sheet.setDefaultColumnWidth((short)1500);
        //创建一行,行的索引是从0开始,写标题
        XSSFRow row;
        //创建表头
        //创建一列,列的索引是从0开始
        row = sheet.createRow(0);
        row.createCell(0).setCellValue("学年:");
        row.createCell(1).setCellValue(schedule.getExamYear());
        row.createCell(2).setCellValue("学期:");
        row.createCell(3).setCellValue(schedule.getExamTerm());

        //创建标题,列的索引是从1开始
        row = sheet.createRow(1);
        row.createCell(0).setCellValue("班级编号");
        row.createCell(1).setCellValue("学号");
        row.createCell(2).setCellValue("考生姓名");
        row.createCell(3).setCellValue("考试科目");
        row.createCell(4).setCellValue("成绩");

        int rowCount = 2;
        //导出内容
        for (Student student : studentList) {
            row = sheet.createRow(rowCount);
            row.createCell(0).setCellValue(student.getClaId());
            row.createCell(1).setCellValue(student.getSno());
            row.createCell(2).setCellValue(student.getStuName());
            row.createCell(3).setCellValue(course.getCourseName());
            rowCount++;
        }

        try {
            String filename = clas.getClaName()+":"+course.getCourseName()+"成绩填写表.xlsx";
            //输出前设置响应格式
            response.setHeader("Content-Disposition","attachment;filename="+
                    new String(filename.getBytes(),"ISO-8859-1"));

            //输出响应文件
            wb.write(response.getOutputStream());

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    /**
     * 成绩解析保存
     * @Param
     * @return
     **/
    public Msg scoreUpLoad(MultipartFile scoreFile,String tno)throws Exception{
        InputStream inputStream = scoreFile.getInputStream();

        //创建工作薄
        XSSFWorkbook wb = new XSSFWorkbook(inputStream);
        //创建表
        XSSFSheet sheet = wb.getSheetAt(0);
        //读取数据
        //获取最后一行
        int lastRow = sheet.getLastRowNum();
        int result = 0;
        Score score = null;
        String examYear = sheet.getRow(0).getCell(1).getStringCellValue();
        String examTerm = sheet.getRow(0).getCell(3).getStringCellValue();
        String courseName = sheet.getRow(2).getCell(3).getStringCellValue();
        Course course = courseMapper.selectOne(new QueryWrapper<Course>().eq("course_name", courseName));
        double numericCellValue = sheet.getRow(2).getCell(0).getNumericCellValue();
        Integer claId = (int)numericCellValue;
        Clas clas = clasMapper.selectById(claId);
        //设置日期格式
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        // new Date()为获取当前系统时间，设置留言时间
        String addTime = df.format(new Date());

        Integer count = 0;
        for (int i=2;i<=lastRow;i++){
            //创建对象,获取值
            score = new Score();
            score.setExamYear(examYear);
            score.setExamTerm(examTerm);
            score.setClaName(clas.getClaName());
            score.setSno(sheet.getRow(i).getCell(1).getStringCellValue());
            score.setStuName(sheet.getRow(i).getCell(2).getStringCellValue());
            score.setCourseName(sheet.getRow(i).getCell(3).getStringCellValue());
            score.setExamScore(sheet.getRow(i).getCell(4).getNumericCellValue());
            score.setExamTime(addTime);
            score.setCno(course.getCno());
            score.setTno(tno);

            if (i==2){
                //判断此课表是否存在
                count=scoreMapper.selectCount(new QueryWrapper<Score>().eq("exam_year",examYear).
                        eq("exam_term",examTerm).eq("course_name",courseName).
                        eq("cla_name",clas.getClaName()));
            }
            if (count > 0){
                //存在
                return Msg.fail().add("Fail","成绩已上传");
            }else{
                //新增
                result = scoreMapper.insert(score);
                if (result < 1){
                    return Msg.fail().add("Fail","添加失败！");
                }
            }
        }

        return Msg.success().add("Success","成绩上传成功！");
    }
}
