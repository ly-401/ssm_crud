package com.sxt.Service.impl;

import com.sxt.Dao.DepartmentMapper;
import com.sxt.Service.DepartmentService;
import com.sxt.domain.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author: Future
 * @Date: 2021/12/03/10:11
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> getAllDepts() {
        return departmentMapper.selectByExample(null);
    }


}
