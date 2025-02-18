<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
        <title>Attendance Tracking</title>
        <style>
            body {
                background-image: url('image/bus.jpg');
                font-family: Arial, sans-serif;
            }
            .container {
                margin-top: 50px;
            }
            .attendance-form {
                flex: 0 0 20%;
                max-width: 20%;
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                margin-right: 20px;
            }
            .student-list {
                flex: 1;
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }
            h2 {
                margin-bottom: 20px;
                text-align: center;
                color: #FFCD01; /* Dark yellow for title */
            }
            .form-group label {
                font-weight: bold;
                color: #856404;
            }
            button {
                width: 100%;
                background-color: #FFCD01; /* Yellow for button */
                border: none;
                color: #fff;
            }
            button:hover {
                background-color: #e0a800; /* Darker yellow on hover */
            }
            .form-control:focus {
                border-color: #ffc107;
                box-shadow: 0 0 5px rgba(255, 193, 7, 0.5);
            }
            .alert {
                display: none; /* Hide alert by default */
            }
            /* Table styling */
            .table th, .table td {
                white-space: nowrap; /* Prevent wrapping */
            }
            @media (max-width: 768px) {
                .attendance-form {
                    max-width: 100%; /* Use full width on small screens */
                    margin-right: 0;
                }
                .student-list {
                    margin-top: 20px; /* Space above student list */
                }
            }
        </style>
    </head>
    <body>
        <c:set var="user" value="${sessionScope.account}" />

        <c:if test="${user != null && user.role != 'Parent'}">
            <c:redirect url="home.jsp"/>
        </c:if>
        <jsp:include page="header1.jsp"/>

        <br/>
        <br/>
        <c:if test="${not empty errorMessage}">
            <div id="errorDiv" style="padding: 10px; background-color: red; color: white; text-align: center; border-radius: 5px; margin-bottom: 10px;">
                ${errorMessage}
            </div>
            <script>
                setTimeout(function () {
                    document.getElementById("errorDiv").style.display = "none";
                }, 3000);
            </script>
        </c:if>
        <div class="container d-flex" style="background-color: #FFE082; ">
            <div class="attendance-form">
                <h2><i class="fas fa-bell"></i> Attendance</h2>
                <div class="alert alert-success" id="successAlert">Successfully!</div>
                <form id="statusForm" method="post" action="attend">
                    <input type="hidden" name="action" value="attend" />
                    <div class="form-group">
                        <label for="date">Date:</label>
                        <input type="date" class="form-control" id="date" name="dob" value="${dob}" required/>
                    </div>
                    <div class="form-group">
                        <label for="timePeriod">Time Period:</label>
                        <select class="form-control" id="timePeriod" name="tp" required>
                            <option ${tp == 'AM' ? 'selected' : ''} value="AM">AM</option>
                            <option ${tp == 'PM' ? 'selected' : ''} value="PM">PM</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="studentName">Student Name:</label>
                        <select class="form-control" id="studentName" name="name" required>
                            <option value="" disabled selected>Select a student</option>
                            <c:forEach items="${lists}" var="o" >
                                <option ${name == o.sid ? 'selected' : ''} value="${o.sid}">${o.name}</option>

                            </c:forEach>                      
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="status">Status:</label>
                        <select class="form-control" id="status" name="attend" required>
                            <option  ${attend == 'Present' ? 'selected' : ''} value="Present">Present</option>
                            <option  ${attend == 'Absent' ? 'selected' : ''} value="Absent">Absent</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="guardian">Pick/Drop Person:</label>
                        <select class="form-control" id="guardian" name="pr" required>
                            <option value="" disabled selected>Select a guardian</option>
                            <c:forEach items="${listp}" var="o">
                                <option ${pr == o.pid ? 'selected' : ''} value="${o.pid}">${o.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-warning">Submit</button>            
                </form>
            </div>
            <div class="student-list flex-grow-1">
                <h2>Student Status</h2>
                <form id="searchForm" method="post" action="attend"> 
                    <input type="hidden" name="action" value="search" />
                    <div class="form-group">
                        <label for="searchDate">Search by Date:</label>
                        <input type="date" class="form-control" id="searchDate" name="ad" value="${ad}" onchange="return this.closest('form').submit()">
                    </div>
                    <!--                 <button type="submit" class="btn btn-warning"><i class="fas fa-search"></i> Search</button>           -->
                </form>

                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Status</th>
                            <th>Shift</th>
                            <th>Estimated Pick</th>
                            <th>Estimated Drop</th>
                            <th>Real Pick</th>
                            <th>Real Drop</th>
                            <th>Guardian</th>
                            <th>Attend</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${lista}" var="attendance">
                            <tr style="background-color: ${attendance.attend == 'Absent' ? '#ffcccc' : '#ccffcc'};">
                                <td>${attendance.name}</td>
                                <td>${attendance.status}</td>
                                <td>${attendance.tp}</td>
                                <td>${attendance.pe == null ? 'N/A' : attendance.pe}</td> <!-- Estimated Pick Time -->
                                <td>${attendance.de == null ? 'N/A' : attendance.de}</td> <!-- Estimated Drop Time -->
                                <td>${attendance.pt == null ? 'N/A' : attendance.pt}</td> <!-- Real Pick Time -->
                                <td>${attendance.dt == null ? 'N/A' : attendance.dt}</td> <!-- Real Drop Time -->
                                <td>${attendance.pname}</td> 
                                <td>${attendance.attend}</td> 
                                <td>
                                    <form action="attend" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete"/>
                                        <input type="hidden" name="aid" value="${attendance.aid}" />
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this record?');">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <br/>

        <jsp:include page="footer.jsp"/>

        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>


    </body>
</html>




