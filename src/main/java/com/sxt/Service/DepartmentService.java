package com.sxt.Service;

import com.sxt.domain.Department;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author: Future
 * @Date: 2021/12/03/10:10
 */
@Service
public interface DepartmentService {

    List<Department> getAllDepts();

}
