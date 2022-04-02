package com.sxt.Test;

import com.github.pagehelper.PageInfo;
import com.sxt.domain.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author: Future
 * @Date: 2021/12/01/9:04
 * 使用Spring测试模块提供的测试请求功能，测试crud请求的正确性
 * Spring4测试的时候，需要Servlet3.0的支持
 *
 * "file:src/main/webapp/WEB-INF/SpringMVC.xml"
 */
@WebAppConfiguration    //通过这个注解就可以拿到MVC的ioc容器
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:SpringMVC.xml"})
public class MvcTest {

    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;

    //传入SpringMvc的ioc
    @Autowired  //不是从Spring的Ioc中拿，而是在SpringMVC的ioc容器中拿
    WebApplicationContext context;

    //初始化MockMvc
    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }


    /**
     * get()，传入需要请求的地址
     * param()  传入一对键值对
     * params() 传递多个键值对
     */
    @Test
    public void testPage() throws Exception{
        //模拟请求，拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps")
                .param("pn", "1")).andReturn();

        //请求成功以后，request域中会有pageInfo，取出pageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");

        System.out.println("当前页码："+pi.getPageNum());
        System.out.println("总页码："+pi.getPages());
        System.out.println("总记录数："+pi.getTotal());

        //获取连续的页数
        int[] nums = pi.getNavigatepageNums();
        for(int num:nums){
            System.out.println(" "+num);
        }

        //获取员工的数据
        //直接将List强制成Employee类型的List
        List<Employee> list = pi.getList();
        for(Employee employee:list){
            System.out.println("id："+employee.getEmpId()+"==>"+employee.getEmpName());
        }

    }





}
