package com.sxt.Controller;

import com.sxt.Service.DepartmentService;
import com.sxt.domain.Department;
import com.sxt.domain.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author: Future
 * @Date: 2021/12/03/10:09
 *
 * 处理和部门有关的请求
 */
@Controller
public class DepartmentController {


    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有的部门信息
     */
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        //查询所有的部门信息
        List<Department> departments = departmentService.getAllDepts();

        return Msg.success().add("depts",departments);
    }


}
