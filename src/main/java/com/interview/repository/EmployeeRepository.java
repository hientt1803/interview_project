package com.interview.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.interview.models.Employee;

public interface EmployeeRepository extends JpaRepository<Employee, Integer> {
    @Query("SELECT e FROM Employee e WHERE e.emp_id = :emp_id")
    Optional<Employee> findByEmpId(@Param("emp_id") String emp_id);

    @Query("SELECT e FROM Employee e WHERE e.email = :email")
    Optional<Employee> findByEmail(@Param("email") String email);

    @Query("SELECT e FROM Employee e WHERE e.phone_number = :phone_number")
    Optional<Employee> findByPhone_number(@Param("phone_number") String phone_number);
}
