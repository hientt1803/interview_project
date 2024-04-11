package com.interview.controllers;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.interview.enums.Position;
import com.interview.interfaces.EmployeeService;
import com.interview.models.Employee;
import com.interview.utils.SessionUtils;
import com.interview.utils.exports.offices.CSVWriterUtility;
import com.interview.utils.exports.offices.EmployeeExcel;

import jakarta.servlet.http.HttpServletResponse;

@CrossOrigin("*")
@Controller
@RequestMapping("/employees")
public class EmployeeController {

	private final EmployeeService employeeService;
	private final SessionUtils sessionUtils;

	private EmployeeController(EmployeeService employeeService, SessionUtils sessionUtils) {
		this.employeeService = employeeService;
		this.sessionUtils = sessionUtils;
	}

	@GetMapping("/get-all")
	private ResponseEntity<?> getAll() {
		List<Employee> list = employeeService.getEmployees();
		return ResponseEntity.ok(list);
	}

	@GetMapping("/view-emp")
	private String showEmployees(Model model) {
		List<Employee> list = employeeService.getEmployees();
		model.addAttribute("employees", list);
		model.addAttribute("content", "employees/view-emp");

		return "app-layout";
	}

	@GetMapping("/add-emp")
	private String addEmployeeView(Model model) {
		model.addAttribute("positionList", Arrays.asList(Position.values()));
		model.addAttribute("employee", new Employee());

		model.addAttribute("content", "employees/create");

		return "app-layout";
	}

	/**
	 * Saves an employee to the database.
	 *
	 * @param employee           the Employee object to be saved
	 * @param redirectAttributes the RedirectAttributes object used to add
	 *                           attributes for the redirect
	 * @param model              the Model object used to add attributes for the
	 *                           view
	 * @return the name of the layout template to be rendered
	 */
	@PostMapping("/add-emp")
	private String saveEmployee(@ModelAttribute("employee") Employee employee,
			RedirectAttributes redirectAttributes, Model model) {
		try {
			Employee savedEmp = employeeService.addEmployee(employee);
			if (savedEmp == null) {
				model.addAttribute("error", "An error occurred while saving the employee");
			}
			model.addAttribute("saveEmp", savedEmp);
			model.addAttribute("addEmpSuccess", true);
			sessionUtils.set("sessionMessage", "Create successfully");
		} catch (IllegalArgumentException e) {
			model.addAttribute("error", e.getMessage());
		}

		model.addAttribute("content", "employees/create");

		return "app-layout";
	}

	@GetMapping("/edit-emp/{id}")
	private String editEmployeeView(@PathVariable("id") Integer id, Model model) {

		try {
			Employee employee = employeeService.getEmployee(id);

			model.addAttribute("positionList", Arrays.asList(Position.values()));
			model.addAttribute("employee", employee);
		} catch (IllegalArgumentException e) {
			model.addAttribute("error", e.getMessage());
		}
		model.addAttribute("content", "employees/edit");

		return "app-layout";
	}

	/**
	 * Updates the details of an employee.
	 *
	 * @param employee the Employee object containing the updated details
	 * @param model    the Model object used to add attributes for the view
	 * @return the name of the layout template to be rendered
	 */
	@PostMapping("/update")
	private String editEmployeeView(@ModelAttribute("employee") Employee employee, Model model) {

		try {
			Employee updatedEmp = employeeService.updateEmployee(employee);

			model.addAttribute("saveEmp", updatedEmp);
			model.addAttribute("addEmpSuccess", true);
			model.addAttribute("employee", updatedEmp);
			sessionUtils.set("sessionMessage", "Update successfully");
		} catch (IllegalArgumentException e) {
			model.addAttribute("error", e.getMessage());
		}
		model.addAttribute("content", "employees/edit");

		return "app-layout";
	}

	/**
	 * Deletes an employee with the given employee ID.
	 *
	 * @param emp_id the ID of the employee to be deleted
	 * @return a ResponseEntity object with the appropriate status code and message
	 */
	@DeleteMapping("/delete-emp/{emp_id}")
	private ResponseEntity<?> destroyEmployee(@PathVariable("emp_id") Integer emp_id) {
		if (emp_id == null) {
			return ResponseEntity.status(404).body("Please provide EMP_ID");
		}

		try {
			employeeService.deleteEmployee(emp_id);
			sessionUtils.set("sessionMessage", "Delete successfully");
		} catch (IllegalArgumentException e) {
			return ResponseEntity.status(404).body(e.getMessage());
		}

		return ResponseEntity.status(204).body("Delete Employee success");
	}

	/**
	 * Generates an Excel file containing employee data and downloads it.
	 *
	 * @param model the Model object used to add attributes for the view
	 * @return the name of the layout template to be rendered
	 * @throws IOException if an I/O error occurs while generating the Excel file
	 */
	@GetMapping("/export/excel")
	public String writeExcel(Model model) throws IOException {
		List<Employee> employees = employeeService.getEmployees();

		File currDir = new File(".");
		String path = currDir.getAbsolutePath();
		String fileLocation = path.substring(0, path.length() - 1) + "employee_data_export.xlsx";

		EmployeeExcel.exportEmployeesToExcel(employees, fileLocation);

		sessionUtils.set("sessionMessage",
				"Download excel successfully! Please review your excel file in project root path!");
		model.addAttribute("content", "employees/view-emp");

		return "app-layout";
	}

	/**
	 * Generates a CSV report of employee details and downloads it.
	 * 
	 * @param response the HttpServletResponse object used to send the response back
	 *                 to the client
	 * @param model    the Model object used to add attributes for the view
	 * @return the name of the layout template to be rendered
	 */
	@GetMapping("/export/csv")
	public String employeeDetailsReport(HttpServletResponse response, Model model) {

		try {
			Random random = new Random();
			String fileType = "attachment; filename=employee_details_" + random.nextInt(1000) + ".csv";
			response.setHeader("Content-Disposition", fileType);
			response.setContentType("text/csv");

			CSVWriterUtility.employeeDetailReport(response,
					employeeService.getEmployees());
		} catch (Exception e) {
			System.out.println("****************************");
			System.out.println("Error: " + e.getMessage());
		}

		sessionUtils.set("sessionMessage",
				"Download CSV successfully! Please review your CSV file in download folder!");
		model.addAttribute("content", "employees/view-emp");

		return "app-layout";
	}

}
