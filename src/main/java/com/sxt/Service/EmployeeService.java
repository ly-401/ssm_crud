package com.sxt.Service;

import com.sxt.domain.Employee;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author: Future
 * @Date: 2021/11/30/16:40
 */
@Service
public interface EmployeeService {

    /**
     * 查询所有员工
     * @return
     */
    List<Employee> getAll();


    void saveEmp(Employee employee);


    boolean checkName(String empName);

    Employee getEmp(Integer id);


    void updateEmp(Employee employee);

    void deleteEmp(Integer id);

    void deleteBatch(List<Integer> ids);

}
