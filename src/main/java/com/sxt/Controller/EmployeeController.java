package com.sxt.Controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sxt.Service.EmployeeService;
import com.sxt.domain.Employee;
import com.sxt.domain.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author: Future
 * @Date: 2021/11/30/16:34
 *
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    /**
     * 使用ResponseBody注解需要导入三组依赖包
     * 由ajax请求到，自动将返回值打包成json对象，并响应到指定ajax请求的事件中
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody   //该注解能将返回的对象自动转为json字符串
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        //引入PageHelper分页插件
        //在查询之前只需要调用，传入页面，以及每页的大小
        PageHelper.startPage(pn,5);//参数1：要查询的页数，参数2：每页要展示的数量
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> employees =  employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        //封装了详细的分页信息，包括有我们查询出来的信息
        /**
         * PageInfo()的构造方法，第一个参数是封装打包的数据，第二个参数连续显示的页数，当前页为中心页
         */
        PageInfo page = new PageInfo(employees,5);

        return Msg.success().add("pageInfo",page);
    }



    /**
     * 查询员工数据(分页查询)
     * //如果没有传递当前页，默认是第一页
     * @return
     */
    //@RequestMapping("/emps")
//    public String findAEmployees(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
//        //引入PageHelper分页插件
//        //在查询之前只需要调用，传入页面，以及每页的大小
//        PageHelper.startPage(pn,5);//参数1：要查询的页数，参数2：每页要展示的数量
//        //startPage后面紧跟的这个查询就是一个分页查询
//        List<Employee> employees =  employeeService.getAll();
//        //使用PageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
//        //封装了详细的分页信息，包括有我们查询出来的信息
//        /**
//         * PageInfo()的构造方法，第一个参数是封装打包的数据，第二个参数连续显示的页数，当前页为中心页
//         */
//        PageInfo page = new PageInfo(employees,5);
//        //将page对象存储到request域中
//        model.addAttribute("pageInfo",page);
//
//        return "list";
//    }


    /**
     * 员工保存
     *
     * 1.要支持JSR303校验
     * 2.导入Hibernate-Validator的坐标
     *
     * @Valid注解：使用在方法参数前，用于将前端传递过来的数据进行后端校验
     * BindingResult对，获取校验的结果
     *
     *
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result .hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            //提取校验失败后的错误信息message
            Map<String,Object> map = new HashMap<String, Object>();
            //报错信息就是实体类中注解配置的
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                //将指定的字段名和错误的信息存储到map集合中
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }

            return Msg.fail().add("errorFields",map);
        }else {
            //校验成功
            //保存员工信息
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }


    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkName")
    public Msg checkName(@RequestParam("empName") String empName){
        //先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if(!empName.matches(regx)){
            //匹配失败
            return Msg.fail().add("va_msg","用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }

        //数据库用户名重复校验
        boolean flag = employeeService.checkName(empName);

        if(flag){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名不可用");
        }

    }

    /**
     * 查询指定员工信息
     * @PathVariable注解：是指定我们从路径中获取id值
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        //查询到员工信息
        Employee emp = employeeService.getEmp(id);

        return Msg.success().add("emp",emp);
    }

    /**
     * 更新员工信息
     *
     * 如果直接发送ajax=PUT形式的请求
     * 封装的数据
     *Employee{empId=2, empName='null', gender='null', email='null', dId=null, department=null}
     *
     * 问题：
     *  请求体中有数据
     *  但是Employee对象封装不上
     *  update tbl_emp where emp_id = 2
     *
     *  原因：
     *      Tomcat的问题
     *          1.将请求体中的数据，封装一个map
     *          2.request.getParameter("empName)就会从这个map
     *          3.SpringMVC封装POJO对象的时候。会把POJO中每个属性的值，调用request.getParameter("email);
     *          但事实是从request中获取不到
     *
     *   AJAX发送PUT请求引发的血案
     *      PUT请求，请求体中的数据，request.getParameter("empName)方法拿不到
     *   原因：Tomcat一看是PUT请求就不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
     *
     *
     * 解决方法：
     *      SpringMVC提供了一个过滤器 HTTpPUTFormContentFilter
     * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
     *      就需要在web.xml中配置 HTTpPUTFormContentFilter过滤器
     *      作用：将请求体中的数据解析包装成一个map。request被重写包装,
     *      request.getParameter()被重写，就会从自己封装的map中取数据
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee, HttpServletRequest request){
        System.out.println("gender："+request.getParameter("gender"));

        System.out.println("将要更新的员工数据："+employee);

        //更新员工的数据
        employeeService.updateEmp(employee);

        return Msg.success();
    }


    /**
     * 删除指定的员工(单个)
     * @PathVariable注解：从路径中取出id的值封装到方法的参数中
     *
     * @param id
     * @return
     */
//    @ResponseBody
//    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
//    public Msg deleteEmpById(@PathVariable("id") Integer id){
//        employeeService.deleteEmp(id);
//
//        return Msg.success();
//    }


    /**
     *单个和批量二合一
     * 批量删除：1-2-3
     * 单个删除：1
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            //批量删除
            //以-进行分割
            String[] str_ids = ids.split("-");
            List<Integer> del_ids = new ArrayList<Integer>();
            for (String id : str_ids) {
                del_ids.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(del_ids);

        }else {
            //单个删除
            employeeService.deleteEmp(Integer.parseInt(ids));
        }

        return Msg.success();
    }


}
