package test;


import edu.hut.hz.serviceimpl.AdminServiceImpl;
import edu.hut.hz.serviceimpl.StudentServiceImpl;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * @ClassName: ServiceTest
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/4/10 16:59
 * @Version: 1.0
 **/
public class ServiceTest {
    
    @Test
    public void adminServiceTest(){
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");

        AdminServiceImpl adminServiceImpl = ioc.getBean("adminServiceImpl", AdminServiceImpl.class);

        System.out.println(adminServiceImpl.getClass());
    }

    @Test
    public void studentServiceTest(){
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");

        StudentServiceImpl studentServiceImpl = ioc.getBean("studentServiceImpl", StudentServiceImpl.class);

        studentServiceImpl.needStudentMsg("1840",0);
        studentServiceImpl.needStudentMsg("法律",2);
        studentServiceImpl.needStudentMsg("1840",1);
    }
}
