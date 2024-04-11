<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>

        <%-- Tailwind --%>
        <script src="https://cdn.tailwindcss.com"></script>

        <%-- Flowbite --%>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css"  rel="stylesheet" />

        <%-- Jquery --%>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

        <%-- Data Table --%>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.9.2/css/bulma.min.css" rel="stylesheet">
        <link href="https://cdn.datatables.net/v/bm/jq-3.7.0/dt-2.0.3/fh-4.0.1/r-3.0.1/sc-2.4.1/sp-2.3.0/sr-1.4.0/datatables.min.css" rel="stylesheet">
        <script src="https://cdn.datatables.net/v/bm/jq-3.7.0/dt-2.0.3/fh-4.0.1/r-3.0.1/sc-2.4.1/sp-2.3.0/sr-1.4.0/datatables.min.js"></script>
    </head>

    <style>
        body{
            overflow:hidden;
        }

        .toast {
            position: absolute;
            top: 0;
            right: 3.5rem;
            transform: translateX(200%);
            z-index: 100;
            top: 3.5rem;
            transition: all 0.5s;
        }

        .toast.show {
            transform: translateX(0);
        }

        th.dt-center, td.dt-center { text-align: center; }
    </style>

    <body class="over-flow-hidden">
        
        <div class="container mx-auto px-3">
            <!-- Include your navbar here -->
            <jsp:include page="../layout/navbar/navbar.jsp"/>

            <!-- Main content -->
            <div class="container">
                <!-- Include dynamic content -->
                <jsp:include page="./${content}.jsp"/>
            </div>

            <!-- Include your footer here -->
            <jsp:include page="../layout/footer/footer.jsp"/>
        
        
            <%-- Toast --%>
            <c:if test="${not empty sessionMessage}">
                <div id="toast-success" class="toast ${not empty sessionMessage ? "show" : ""} flex items-center w-full max-w-xs p-4 mb-4 text-gray-500 bg-white rounded-lg shadow dark:text-gray-400 dark:bg-gray-800" role="alert">
                    <div class="inline-flex items-center justify-center flex-shrink-0 w-8 h-8 text-green-500 bg-green-100 rounded-lg dark:bg-green-800 dark:text-green-200">
                        <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5Zm3.707 8.207-4 4a1 1 0 0 1-1.414 0l-2-2a1 1 0 0 1 1.414-1.414L9 10.586l3.293-3.293a1 1 0 0 1 1.414 1.414Z"/>
                        </svg>
                        <span class="sr-only">Check icon</span>
                    </div>
                    <div class="ms-3 text-sm font-normal">${sessionMessage}.</div>
                    <button type="button" class="ms-auto -mx-1.5 -my-1.5 bg-white text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1.5 hover:bg-gray-100 inline-flex items-center justify-center h-8 w-8 dark:text-gray-500 dark:hover:text-white dark:bg-gray-800 dark:hover:bg-gray-700" data-dismiss-target="#toast-success" aria-label="Close">
                        <span class="sr-only">Close</span>
                        <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                        </svg>
                    </button>
                </div>
                
                <% session.removeAttribute("sessionMessage"); %>
              
                <script>
                    setTimeout(() => {
                        const toast = document.querySelector('.toast');
                        toast.classList.remove('show');
                    }, 6000);
                </script>

            </c:if>

        </div>
        
       <%-- Flowbite --%>
       <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
    </body>
</html>