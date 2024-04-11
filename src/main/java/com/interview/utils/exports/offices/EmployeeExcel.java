package com.interview.utils.exports.offices;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

import org.dhatim.fastexcel.Workbook;
import org.dhatim.fastexcel.Worksheet;

import com.interview.models.Employee;

public class EmployeeExcel {

    /**
     * Exports a list of employees to an Excel file.
     *
     * @param employees    the list of employees to export
     * @param fileLocation the location of the Excel file to export to
     * @throws IOException if there is an error writing to the file
     */
    public static void exportEmployeesToExcel(List<Employee> employees, String fileLocation) throws IOException {
        try (OutputStream os = Files.newOutputStream(Paths.get(fileLocation));
                Workbook wb = new Workbook(os, "EmployeeReport", "1.0")) {
            Worksheet ws = wb.newWorksheet("Employees");

            ws.width(0, 10);
            ws.width(1, 15);
            ws.width(2, 25);
            ws.width(3, 20);
            ws.width(4, 20);
            ws.width(5, 30);

            ws.range(0, 0, 0, 5).style().fontName("Arial").fontSize(16).bold().fillColor("3366FF").set();
            ws.value(0, 0, "ID");
            ws.value(0, 1, "Employee ID");
            ws.value(0, 2, "Name");
            ws.value(0, 3, "Phone Number");
            ws.value(0, 4, "Position");
            ws.value(0, 5, "Email");

            int rowIndex = 2;
            for (Employee employee : employees) {
                ws.range(rowIndex, 0, rowIndex, 5).style().wrapText(true).set();
                ws.value(rowIndex, 0, employee.getId());
                ws.value(rowIndex, 1, employee.getEmp_id());
                ws.value(rowIndex, 2, employee.getName());
                ws.value(rowIndex, 3, employee.getPhone_number());
                ws.value(rowIndex, 4, employee.getPosition().toString());
                ws.value(rowIndex, 5, employee.getEmail());

                rowIndex++;
            }
        }
    }
}
