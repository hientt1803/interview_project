package com.interview.services;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.interview.interfaces.EmployeeService;
import com.interview.models.Employee;
import com.interview.repository.EmployeeRepository;

@Service
public class EmployeeServiceImlp implements EmployeeService {

    private final EmployeeRepository employeeRepository;

    private EmployeeServiceImlp(EmployeeRepository employeeRepository) {
        this.employeeRepository = employeeRepository;
    }

    @Override
    public List<Employee> getEmployees() {
        try {
            List<Employee> employees = employeeRepository.findAll(Sort.by("name").ascending());

            // employees.forEach((emp) -> {
            //     System.out.println(emp.toString());
            // });

            return employees;
        } catch (Exception e) {
            throw new UnsupportedOperationException("Unimplemented method 'getEmployees'");
        }
    }

    @Override
    public Employee getEmployee(Integer id) {
        Optional<Employee> existingEmployee = employeeRepository.findById(id);

        if (!existingEmployee.isPresent()) {
            throw new IllegalArgumentException("Employee with emp_id " + id + " not exists");
        }

        return existingEmployee.get();
    }

    @Override
    public Employee addEmployee(Employee employee) {

        if (employee == null) {
            throw new IllegalArgumentException("Employee object cannot be null");
        }

        Optional<Employee> existingEmployeeById = employeeRepository.findByEmpId(employee.getEmp_id());
        if (existingEmployeeById.isPresent()) {
            throw new IllegalArgumentException("Employee with emp_id " + employee.getEmp_id() + " already exists");
        }

        Optional<Employee> existingEmployee = employeeRepository.findByEmail(employee.getEmail());
        if (existingEmployee.isPresent()) {
            throw new IllegalArgumentException("Email already exists");
        }

        Optional<Employee> existingEmployeeByPhone = employeeRepository.findByPhone_number(employee.getPhone_number());
        if (existingEmployeeByPhone.isPresent()) {
            throw new IllegalArgumentException("Phone number " + employee.getPhone_number() + " already exists");
        }

        // System.out.println("employee:" + employee);
        final Employee createdEmp = employeeRepository.save(employee);
        return createdEmp;
    }

    @Override
    public Employee updateEmployee(Employee employee) {
        if (employee == null) {
            throw new IllegalArgumentException("Employee object cannot be null");
        }

        Optional<Employee> existingEmployeeById = employeeRepository.findById(employee.getId());
        if (!existingEmployeeById.isPresent()) {
            throw new IllegalArgumentException("Employee with ID " + employee.getId() + " not found");
        }

        Employee existingEmployee = existingEmployeeById.get();

        // check emp_id
        if (!existingEmployee.getEmp_id().equals(employee.getEmp_id())) {
            Optional<Employee> employeeWithNewEmpId = employeeRepository.findByEmpId(employee.getEmp_id());
            if (employeeWithNewEmpId.isPresent()) {
                throw new IllegalArgumentException("Employee with emp_id " + employee.getEmp_id() + " already exists");
            }
        }

        // check_email
        if (!existingEmployee.getEmail().equals(employee.getEmail())) {
            Optional<Employee> employeeWithNewEmail = employeeRepository.findByEmail(employee.getEmail());
            if (employeeWithNewEmail.isPresent()) {
                throw new IllegalArgumentException("Email already exists");
            }
        }

        /**
         * Checks if the phone number of the existing employee is different from the
         * phone number of the new employee.
         * If they are different, checks if there is already an employee with the new
         * phone number.
         * If an employee with the new phone number exists, throws an
         * IllegalArgumentException with an error message.
         */
        if (!existingEmployee.getPhone_number().equals(employee.getPhone_number())) {
            Optional<Employee> employeeWithNewPhone = employeeRepository.findByPhone_number(employee.getPhone_number());
            if (employeeWithNewPhone.isPresent()) {
                throw new IllegalArgumentException("Phone number " + employee.getPhone_number() + " already exists");
            }
        }

        final Employee updatedEmp = employeeRepository.save(employee);
        return updatedEmp;
    }

    @Override
    public void deleteEmployee(Integer id) {
        Optional<Employee> existingEmployeeById = employeeRepository.findById(id);

        if (!existingEmployeeById.isPresent()) {
            throw new IllegalArgumentException("Employee with emp_id " + id + " not exist");
        }

        employeeRepository.deleteById(id);
    }

}
