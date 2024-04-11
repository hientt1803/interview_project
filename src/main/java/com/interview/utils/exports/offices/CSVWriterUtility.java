package com.interview.utils.exports.offices;

import java.io.IOException;
import java.util.List;

import org.supercsv.cellprocessor.FmtBool;
import org.supercsv.cellprocessor.FmtDate;
import org.supercsv.cellprocessor.Optional;
import org.supercsv.cellprocessor.constraint.NotNull;
import org.supercsv.cellprocessor.constraint.UniqueHashCode;
import org.supercsv.cellprocessor.ift.CellProcessor;
import org.supercsv.io.CsvBeanWriter;
import org.supercsv.io.ICsvBeanWriter;
import org.supercsv.prefs.CsvPreference;

import com.interview.models.Employee;

import jakarta.servlet.http.HttpServletResponse;

public class CSVWriterUtility {

    /**
     * Returns an array of CellProcessors used for processing CSV data.
     *
     * @return an array of CellProcessors
     */
    private static CellProcessor[] getProcessors() {

        final CellProcessor[] processors = new CellProcessor[] {
                new UniqueHashCode(), // employee No
                new NotNull(),
                new NotNull(),
                new NotNull(),
                new NotNull(),
                new NotNull(),
        };

        return processors;
    }

    /**
     * Generates a CSV report of employee details and writes it to the provided
     * HttpServletResponse.
     *
     * @param response  the HttpServletResponse object to write the CSV report to
     * @param employees the list of Employee objects to include in the report
     */
    public static void employeeDetailReport(HttpServletResponse response, List<Employee> employees) {

        if (employees.isEmpty()) {
            System.out.println("No employees to write to CSV.");
            return;
        }

        try (ICsvBeanWriter beanWriter = new CsvBeanWriter(response.getWriter(),
                CsvPreference.STANDARD_PREFERENCE)) {

            final String[] header = new String[] { "id", "emp_id", "position", "name", "email", "phone_number" };

            final CellProcessor[] processors = getProcessors();

            // set Header
            beanWriter.writeHeader(header);

            // Set data
            for (Employee emp : employees) {
                beanWriter.write(emp, header, processors);
            }

            response.getWriter().flush();
        } catch (IOException e) {
            System.out.println("****************************");
            System.out.println("Error: " + e.getMessage());
        }
    }
}
