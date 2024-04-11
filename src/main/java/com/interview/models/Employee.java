package com.interview.models;

import java.io.Serializable;

import org.springframework.format.annotation.NumberFormat;

import com.interview.enums.Position;

import jakarta.persistence.*;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
@Entity
@Table(name = "Employee")
public class Employee implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id")
    private Integer id;

    @Column(name = "emp_id")
    private String emp_id;

    @Column(name = "name")
    private String name;

    @Column(name = "phone_number")
    @NumberFormat
    private String phone_number;

    @Column(name = "position")
    @Enumerated(EnumType.STRING)
    private Position position;

    @Column(name = "email")
    private String email;

    @Override
    public String toString() {
        return "Employee [emp_id=" + emp_id + ", name=" + name + ", phone=" + phone_number + ", position= " + position
                + ",email=" + email + "]";
    }

}