package com.sxt.Service.impl;

import com.sxt.Dao.EmployeeMapper;
import com.sxt.Service.EmployeeService;
import com.sxt.domain.Employee;
import com.sxt.domain.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author: Future
 * @Date: 2021/11/30/16:42
 */
@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    @Override
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);//查询所有用户，不需要条件
    }

    @Override
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @Override
    public boolean checkName(String empName) {
        EmployeeExample example = new EmployeeExample();
        //创建查询条件
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);

        //countByExample()是获取指定的条件在数据库出现的次数
        long count = employeeMapper.countByExample(example);

        return count == 0;
    }

    /**
     * 根据id查询员工
     * @param id
     * @return
     */
    @Override
    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    /**
     * 更新员工信息
     * @param employee
     */
    @Override
    public void updateEmp(Employee employee) {
        //updateByPrimaryKeySelective，根据主键有选择的更新，就是不为空的字段进行更新
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 删除指定的员工
     * @param id
     */
    @Override
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //delete from employee where empId in(?,?,?);
        criteria.andEmpIdIn(ids);

        employeeMapper.deleteByExample(example);
    }


}
