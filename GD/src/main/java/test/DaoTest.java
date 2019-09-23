package test;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import edu.hut.hz.dao.CommunicationMapper;
import edu.hut.hz.dao.InvestigateMapper;
import edu.hut.hz.dao.StudentMapper;
import edu.hut.hz.pojo.Communication;
import edu.hut.hz.pojo.InvStatistic;
import edu.hut.hz.pojo.Student;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @ClassName: DaoTest
 * @Description: 测试与数据库连接
 * @Author: Carlson
 * @Date 2019/4/10 15:02
 * @Version: 1.0
 **/
public class DaoTest {

    @Test
    public void studentMapperTest(){
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");

        StudentMapper studentMapper = ioc.getBean("studentMapper", StudentMapper.class);

        List<Student> students = studentMapper.selectList(new QueryWrapper<>());

        for (Student s:students) {
            System.out.println(s);
        }
        List<Student> students1 = studentMapper.studentNeedSelect("长沙");
        for (Student s:students) {
            System.out.println(s);
        }
    }
    
    @Test
    public void pojoTest(){
        Student student = new Student();
        if (student == null){
            System.out.println(student);
            System.out.println(true);
        }
        System.out.println(student == null);
        System.out.println(student != null);
        System.out.println(student.getSno());
        System.out.println(student);
        System.out.println(false);
    }

    @Test
    public void calenderTest(){
        Calendar instance = Calendar.getInstance();

        System.out.println(instance.getWeekYear());
        System.out.println(instance.get(Calendar.MONTH)+1);
        System.out.println(instance.get(Calendar.DAY_OF_MONTH));
        System.out.println(instance.get(Calendar.DAY_OF_WEEK));
        int weekDay = instance.get(Calendar.DAY_OF_WEEK);
        String week = "";
        if (Calendar.MONDAY == weekDay){
            week =  "星期一";
        }
        if (Calendar.TUESDAY == weekDay){
            week =  "星期二";
        }
        if (Calendar.WEDNESDAY == weekDay){
            week =  "星期三";
        }
        if (Calendar.THURSDAY == weekDay){
            week =  "星期四";
        }
        if (Calendar.FRIDAY == weekDay){
            week =  "星期四";
        }
        System.out.println(week);
    }

    @Test
    public void dataTest(){
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");

        CommunicationMapper communicationMapper = ioc.getBean("communicationMapper", CommunicationMapper.class);

        Communication communication = new Communication();
        communication.setCmTitle("001");
        communication.setRecipient("001");
        //设置日期格式
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        // new Date()为获取当前系统时间，设置留言时间
        communication.setAddTime(df.format(new Date()));
        int insert = communicationMapper.insert(communication);
        System.out.println(insert);

    }

    @Test
    public void invStaMapper(){
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");

        InvestigateMapper investigateMapper = ioc.getBean("investigateMapper", InvestigateMapper.class);
        InvStatistic invStatistic = new InvStatistic();
        invStatistic.setStuName("牧田");
        invStatistic.setClaName("高一1902");
        List<InvStatistic> invStatistics = investigateMapper.invStaByWeek(invStatistic);
        List<InvStatistic> invStatisticmon = investigateMapper.invStaByMonth(invStatistic);

        for (InvStatistic i:invStatistics) {
            System.out.println(i);
        }
        for (InvStatistic i:invStatisticmon) {
            System.out.println(i);
        }
        invStatistic.setExamYear("2019");
        investigateMapper.invStaByMonthLastTerm(invStatistic);
        investigateMapper.invStaByNextTerm(invStatistic);
    }
}
