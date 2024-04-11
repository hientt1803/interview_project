<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="mt-5">
    <a href="/employees/add-emp">                                  
        <button type="button" class="ms-auto text-white bg-[#050708] me-0 hover:bg-[#050708]/90 focus:ring-4 focus:outline-none focus:ring-[#050708]/50 font-medium rounded-lg text-sm px-5 py-2.5 text-center inline-flex items-center dark:focus:ring-[#050708]/50 dark:hover:bg-[#050708]/30 me-2 mb-2">
            Register new employee
            <svg class="w-4 h-4 ms-2 rtl:rotate-180" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 10">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5h12m0 0L9 1m4 4L9 9"/>
            </svg>
        </button>
    </a> 
</div>

</br>

<div class="w-100 mt-8">
    <h4 class="font-bold">#Toolbar</h4>
    <div class="d-flex gap-3">
        <a href="/employees/export/excel" class="mb-2">                                  
            <button type="button" class="py-2.5 px-5 me-2 mb-2 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100 dark:focus:ring-gray-700 dark:bg-gray-800 
                        dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700">
                Export data to excel 
            </button>
        </a> 
        <a href="/employees/export/csv" class="mb-2">          
            <button type="button" class="text-gray-900 bg-gray-100 hover:bg-gray-200 focus:ring-4 focus:outline-none focus:ring-gray-100 font-medium rounded-lg text-sm px-5 py-2.5 text-center inline-flex items-center dark:focus:ring-gray-500 me-2 mb-2">
                Export CVS file
            </button>
        </a> 
    </div>
</div>

<div class="relative overflow-x-auto mt-3">
    <table id="employeeTable" class="w-full text-sm text-left rtl:text-right text-gray-500 shadow-md dark:text-gray-400">
        <caption class="p-5 text-lg font-semibold text-left rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800">
            Employee Tables
            <p class="mt-1 text-sm font-normal text-gray-500 dark:text-gray-400">Browse a list of Employee.</p>
        </caption>
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 bg-dark-700 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                    Emp_ID
                </th>
                <th scope="col" class="px-6 py-3">
                    Position
                </th>
                <th scope="col" class="px-6 py-3">
                    Name
                </th>
                <th scope="col" class="px-6 py-3">
                    Phone_number
                </th>
                <th scope="col" class="px-6 py-3">
                    Email
                </th>
                <th scope="col" class="px-6 py-3">
                    Actions
                </th>
            </tr>
        </thead>
        <tbody>
         
        </tbody>
    </table>
</div>

<script>
    // Init table with DataTable
    const initTable = ()=>{
            $(document).ready(function() {
            $.ajax({
                type: 'GET',
                url: `http://localhost:8080/employees/get-all`,
                retrieve: true,
                destroy: true,
                success: function(res) {
                    console.log(res); 
                    $('#employeeTable').DataTable({
                        data: res,
                        columns: [
                            {
                                data: "emp_id",
                                render: function(data, type, row) {
                                    return '<td class="px-6 py-4 mx-auto px-auto font-medium text-gray-900 whitespace-nowrap dark:text-white">'+data+'</td>';
                                }
                            },
                            {
                                data: "position",
                                render: function(data, type, row) {
                                    switch(data){
                                        case 'DEVELOPER':
                                            return `<td class="px-6 py-4">Lập trình viên</td>`;
                                        case 'MANAGER':
                                            return `<td class="px-6 py-4">Quản lý</td>`;
                                        case 'TESTER':
                                            return `<td class="px-6 py-4">Kiểm thử viên</td>`;
                                        case 'DESIGNER':
                                            return `<td class="px-6 py-4">Thiết kế viên</td>`;
                                        default:
                                            return `<td class="px-6 py-4">Không xác định</td>`;
                                    }
                                }
                            },
                            {
                                data: "name",
                                render: function(data, type, row) {
                                    return '<td class="px-6 py-4">'+data+'</td>';
                                }
                            },
                            {
                                data: "phone_number",
                                render: function(data, type, row) {
                                    return '<td class="px-6 py-4">'+data+'</td>';
                                }
                            },
                            {
                                data: "email",
                                render: function(data, type, row) {
                                    return '<td class="px-6 py-4">'+data+'</td>';
                                }
                            },
                            {
                                data: null,
                                render: function(data, type, row) {
                                    return '<td class="flex gap-2 items-center justify-center">' +               
                                            '<a href="/employees/edit-emp/' + row.id + '"' + 
                                                ' class="font-medium text-blue-600 dark:text-blue-500 hover:underline">' +
                                                '<button type="button" class="py-2.5 px-5 me-2 mb-2 text-sm font-medium text-gray-900 focus:outline-none bg-white' +
                                                    ' rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100' + 
                                                    ' dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700">' +
                                                'Edit' +
                                                '</button>' +
                                            '</a>' +
                                            
                                            '<button data-modal-target="popup-modal#' + row.id + '" data-modal-toggle="popup-modal#' + row.id + '" type="button" class="focus:outline-none text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-red-300' + 
                                                ' font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900">' +
                                            'Delete' +
                                            '</button>' +   

                                            '<!-- Model -->' +
                                            '<div id="popup-modal#' + row.id + '" tabindex="-1" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">' +
                                                '<div class="relative p-4 w-full max-w-md max-h-full">' +
                                                    '<div class="relative bg-white rounded-lg shadow dark:bg-gray-700">' +
                                                        '<button type="button" class="absolute top-3 end-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white" data-modal-hide="popup-modal#' + row.id + '">' +
                                                            '<svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">' +
                                                                '<path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>' +
                                                            '</svg>' +
                                                            '<span class="sr-only">Close modal</span>' +
                                                        '</button>' +
                                                        '<div class="p-4 md:p-5 text-center">' +
                                                            '<svg class="mx-auto mb-4 text-gray-400 w-12 h-12 dark:text-gray-200" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">' +
                                                                '<path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 11V6m0 8h.01M19 10a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"/>' +
                                                            '</svg>' +
                                                            '<h3 class="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">Are you sure you want to delete ' + row.name + '?</h3>' +
                                                            '<button data-modal-hide="popup-modal#' + row.id + '" type="button" data-emp-id="' + row.id + '" class="deleted-form text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center">' +
                                                                'Yes, I\'m sure' +
                                                            '</button>' +
                                                            '<button data-modal-hide="popup-modal#' + row.id + '" type="button" class="py-2.5 px-5 ms-3 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700">No, cancel</button>' +
                                                        '</div>' +
                                                    '</div>' +
                                                '</div>' +
                                            '</div>' +
                                        '</td>';
                                }
                            }
                        ],
                        "aaSorting": [],
                        "columnDefs": [
                            {"className": "dt-center", "targets": "_all"}
                        ],
                    });
                },
                error: function(xhr, status, error) {
                    console.log('Có lỗi xảy ra: ' + error);
                }
            });
        });
    }

    initTable()

    // Action perform
    $(document).on('click', '.deleted-form', function(event) {
        event.preventDefault();
        const empId = $(this).data('emp-id');
        deleteEmployee(empId);
    });

    const deleteEmployee = async (emp_id) => {
        console.log(Number(emp_id));
        try {
            const res = await fetch(`/employees/delete-emp/` + Number(emp_id), {
                method: 'DELETE'
            });

            console.log(res);
            if (res.status === 204) {
                //initTable();
                console.log('deleted');
                window.location.href = "http://localhost:8080/employees/view-emp";
            } else if(res.status === 404){
                console.log('Có lỗi xảy ra: ' + error, false);
            }
        } catch (error) {
           console.log('Có lỗi xảy ra: ' + error, false);
        }
    }
</script>
