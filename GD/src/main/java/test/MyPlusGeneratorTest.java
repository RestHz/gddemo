package test;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.annotation.IdType;
import org.junit.Test;

import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.GlobalConfig;
import com.baomidou.mybatisplus.generator.config.PackageConfig;
import com.baomidou.mybatisplus.generator.config.StrategyConfig;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;

/**
 * @ClassName: MyPlusGeneratorTest
 * @Description: MybatisPlus代码构造器使用
 *
 * @Author: Carlson
 * @Date 2019/3/23 16:13
 * @Version: 1.0
 **/
public class MyPlusGeneratorTest {

    @Test
    public void generateCode() {
       /* //管理员表
        generateByTables("admin");
        //班级表
        generateByTables("clas");
        //用户表
        generateByTables("user");
        //学生表
        generateByTables("student");
        //教师表
        generateByTables("teacher");
        //地址表
        //generateByTables("geo_position");
        //留言表
        generateByTables("communication");
        //课程表
        generateByTables("course");
        //课件表
        generateByTables("courseware");
        //考勤表
        generateByTables("investigate");
        //成绩表
        generateByTables("score");*/
        //课表
        generateByTables("schedule");
    }

    private void generateByTables(String tableNames) {
        //代码生成位置
        String OutputDir = "D:\\Java\\IHzProjects\\GDDome02\\src\\main\\java";
        //连接地址
        String dbUrl = "jdbc:mysql:///home_school?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=GMT";
        //设置父包
        String parentDao = "edu.hut.hz";

    //1.全局配置
        GlobalConfig config = new GlobalConfig();
               //是否支持AR模式
        config.setActiveRecord(true)
                //设置作者
                .setAuthor("Carlson")
                //设置生成代码位置
                .setOutputDir(OutputDir)
                //多次生成文件覆盖
                .setFileOverride(true)
                //主键策略
                .setIdType(IdType.AUTO)
                //生成mapper.xml映射文件
                .setBaseResultMap(true)
                //生成sql
                .setBaseColumnList(true);
        // 自定义文件命名，注意 %s 会自动填充表实体属性！
        config.setMapperName("%sMapper")
                .setXmlName("%sMapper")
                .setServiceName("%sService")
                .setServiceImplName("%sServiceImpl")
                .setControllerName("%sController");


    //2.数据源配置

        DataSourceConfig dataSourceConfig = new DataSourceConfig();
                        //设置数据库类型
        dataSourceConfig.setDbType(DbType.MYSQL)
                //设置数据连接信息
                .setUrl(dbUrl)
                .setUsername("root")
                .setPassword("123456")
                .setDriverName("com.mysql.cj.jdbc.Driver");


    //3.策略配置
        StrategyConfig strategyConfig = new StrategyConfig();
        strategyConfig
                //全局大写命名
                .setCapitalMode(true)
                //配置使用Lombok
                .setEntityLombokModel(true)
                //表明生成策略,驼峰命名
                .setNaming(NamingStrategy.underline_to_camel)
                //需要生成的表，多个表名传数组
                .setInclude(tableNames);

     //4.包配置
        PackageConfig packageConfig = new PackageConfig();
                      //设置父包
        packageConfig.setParent(parentDao)
                .setMapper("dao")
                .setXml("dao.mapper")
                .setService("service")
                .setServiceImpl("serviceimpl")
                .setController("controller")
                .setEntity("pojo");

    //5.整合配置
        AutoGenerator autoGenerator = new AutoGenerator();

        autoGenerator.setGlobalConfig(config)
                    .setDataSource(dataSourceConfig)
                    .setStrategy(strategyConfig)
                    .setPackageInfo(packageConfig);

     //6.执行
        autoGenerator.execute();
    }
}
