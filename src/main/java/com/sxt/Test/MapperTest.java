package com.sxt.Test;

import com.sxt.Dao.DepartmentMapper;
import com.sxt.Dao.EmployeeMapper;
import com.sxt.domain.Department;
import com.sxt.domain.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author: Future
 * @Date: 2021/11/30/15:35
 * 推荐使用Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 * 1.导入SpringTest模块     spring-test
 * 2.@ContextConfiguration指定Spring配置文件的位置
 * 3.直接AutoWired要使用的组件即可
 *
 * 测试Dao层的使用
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private SqlSession session;

    /**
     * 测试DepartmentMapper
     */
    @Test
    public void TestCRUD(){
        //1.插入部门数据
        /**
         * insert()是全字段插入
         * insertSelective()是有选择的插入，id是自增的，带了哪个值就插入哪个值
         */
        //departmentMapper.insertSelective(new Department(null,"开发部"));
        //departmentMapper.insertSelective(new Department(null,"测试部"));

        //2.生成员工数据,测试员工插入
        //employeeMapper.insertSelective(new Employee(null,"山鸡","M","shanji@qq.com",1));

        //3.批量插入多个员工，使用可以执行批量操作的SqlSession

        //使用for循环的不是实现批量操作，而是一次一次的执行，就是没有进行处理，只是简单插入
//        for (){
//            employeeMapper.insertSelective(new Employee(null,,"M","shanji@qq.com",1));
//        }

        //使用SqlSession创建的Mapper代理对象插入的数据是批量操作，在applicationContext中开启了批量操作
        //会在插入数据时进行处理，高效的执行批量更新操作
//        EmployeeMapper mapper = session.getMapper(EmployeeMapper.class);
//        for(int i=1;i<=1000;i++){
//            String uid = UUID.randomUUID().toString().substring(0,5) + i;
//            mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",1));
//        }
//        System.out.println("批量完成");

    }


}










