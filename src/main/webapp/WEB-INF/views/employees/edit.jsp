<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

    <div class="my-5">
      <a href="/employees/view-emp">                                  
        <button type="button" class="ms-auto text-white bg-[#050708] me-0 hover:bg-[#050708]/90 focus:ring-4 focus:outline-none focus:ring-[#050708]/50 font-medium rounded-lg text-sm px-5 py-2.5 text-center inline-flex items-center dark:focus:ring-[#050708]/50 dark:hover:bg-[#050708]/30 me-2 mb-2">
         comeback
          <svg class="w-4 h-4 ms-2 rtl:rotate-180" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 10">
              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5h12m0 0L9 1m4 4L9 9"/>
          </svg>
        </button>
      </a> 
    </div>
 
    <c:if test="${addEmpSuccess}">
      <span class="my-4 bg-green-100 text-green-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded dark:bg-green-900 dark:text-green-300">Successfully update Employee with Emp_ID: ${saveEmp.emp_id}</span>
    </c:if>
      
    <c:if test="${not empty error}">
      <span class="my-4 bg-red-100 text-red-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded dark:bg-red-900 dark:text-red-300">${error}</span>
    </c:if>
    
    <h3 class="text-3xl font-bold dark:text-white mb-3 mt-5">Update Employee</h3>
    <c:url var="update_emp_url" value="/employees/update"/>
    <form:form action="${update_emp_url}" id="employeeForm" method="POST" modelAttribute="employee">
        <div class="grid gap-6 mb-6 md:grid-cols-2">
        <form:input id="id" path="id" type="hidden" value="${employee.id}" />
          <div>
            <form:label path="emp_id" cssClass="block mb-2 text-sm font-medium text-gray-900 dark:text-white">ID: </form:label> 
            <form:input type="text" id="emp_id" path="emp_id" value="${employee.emp_id}" cssClass="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" />
            <span id="id_error" cssClass="text-red-600"></span>
          </div>
          <div>
            <form:label path="email" cssClass="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Email: </form:label> 
            <form:input type="email" id="email" path="email" value="${employee.email}" cssClass="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" />
            <span id="email_error" cssClass="text-red-600"></span>    
          </div>
          <div>
            <form:label path="name" cssClass="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Full Name: </form:label> 
            <form:input type="text" id="name" path="name" value="${employee.name}" cssClass="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" />
            <span id="name_error" cssClass="text-red-600"></span>
          </div>
          <div>
            <form:label path="phone_number" cssClass="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Phone Number: </form:label> 
            <form:input type="number" id="phone_number" path="phone_number" value="${employee.phone_number}" cssClass="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" />
            <span id="phone_error" cssClass="text-red-600"></span>
          </div>
          <div>
              <form:label path="position" cssClass="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Position: </form:label>
              <form:select path="position" id="position" cssClass="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                  <form:option value="" label="-- Select Position --" />
                  <form:options items="${positionList}" itemLabel="displayValue" itemValue="displayValue" />
              </form:select>
            <span id="position_error" cssClass="text-red-600"></span>
          </div>
        </div>
          <button type="submit" value="submit" class="text-white bg-[#050708] hover:bg-[#050708]/90 focus:ring-4 focus:outline-none focus:ring-dark-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-dark-600 dark:hover:bg-dark-700 dark:focus:ring-dark-800">Update</button>
    </form:form>

<script>
    document.getElementById("employeeForm").addEventListener("submit", function(event) {
    const id = document.getElementById("emp_id").value;
    const name = document.getElementById("name").value.trim();
    const email = document.getElementById("email").value;
    const phoneNumber = document.getElementById("phone_number").value.trim();
    const position = document.getElementById("position").value.trim();

        isValidEmail(email);
        isValidPhoneNumber(phoneNumber);

        if (id === '') {
            displayErrorMessage("id_error", "Employee ID cannot be empty");
            event.preventDefault();
        }else{
            displayErrorMessage("id_error", "");
        }
        if (name === '') {
            displayErrorMessage("name_error", "Name cannot be empty");
            event.preventDefault();
        }else{
            displayErrorMessage("name_error", "");
        }
        if (position === '') {
            displayErrorMessage("position_error", "Position must be selected");
            event.preventDefault();
        }else{
            displayErrorMessage("position_error", "");
        }

    });

    const isValidEmail = (email) => {
        const input = document.querySelector("#email");
        const display = document.querySelector("#email_error");
        if (!email.match(/[^\s@]+@[^\s@]+\.[^\s@]+/gi)) {
            display.innerHTML = email + ' is not a valid email! Email must be abc@gmail.com';
            event.preventDefault(); 
        } else {
            display.innerHTML = ''; 
        }
    }

    const isValidPhoneNumber = (phoneNumber) => {
        const input = document.querySelector("#phone");
        const display = document.querySelector("#phone_error");

        if (!phoneNumber.match(/^(\([0-9]{3}\) |[0-9]{3})[0-9]{3}[0-9]{4}/)) {
            display.innerHTML = phoneNumber + ' is not a valid phone number! Phone number must be 10 digit.';
            event.preventDefault(); 
        } else {
            display.innerHTML = '';
        }
    }

    function displayErrorMessage(elementId, message) {
        const display = document.getElementById(elementId);
        display.innerHTML = message;
    }
</script>