package com.interview.interfaces;

import java.util.List;
import com.interview.models.Employee;

public interface EmployeeService {
    public List<Employee> getEmployees();

    public Employee getEmployee(Integer id);

    public Employee addEmployee(Employee employee);

    public Employee updateEmployee(Employee employee);
    
    public void deleteEmployee(Integer id);
}
