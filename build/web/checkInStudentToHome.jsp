<%-- 
    Document   : manageStudent
    Created on : Oct 19, 2024, 4:26:31 PM
    Author     : sonNH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Search Students</title>
        <style>
            /* Toàn bộ trang */
            body {
                font-family: 'Arial', sans-serif;
                background-color: #FFF9E6; /* Màu nền vàng pastel nhạt */
                color: #5A4A42; /* Màu chữ nâu nhẹ */
                margin: 0;
                padding: 0;
            }

            h2 {
                text-align: center;
                color: #D4905D; /* Màu cam pastel nổi bật */
                text-transform: uppercase;
                letter-spacing: 2px;
                margin-bottom: 20px;
            }

            /* Form */
            form {
                width: 50%;
                margin: 20px auto;
                padding: 20px;
                background-color: #FFF3D1; /* Màu vàng pastel */
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng */
            }

            label {
                font-weight: bold;
                color: #8C6E52; /* Màu cam đất */
                display: block;
                margin-bottom: 5px;
            }

            input[type="date"],
            input[type="time"],
            select {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #D4905D;
                border-radius: 5px;
                background-color: #FFF9E6;
                transition: border 0.3s ease;
            }

            input[type="date"]:focus,
            input[type="time"]:focus,
            select:focus {
                border-color: #D4905D; /* Hiệu ứng border khi focus */
            }

            button {
                padding: 10px 20px;
                background-color: #F5A25D; /* Màu cam pastel đậm */
                border: none;
                border-radius: 5px;
                color: white;
                font-size: 14px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.3s ease;
            }

            button:hover {
                background-color: #E98A42;
                transform: scale(1.05); /* Hiệu ứng hover phóng to */
            }

            button:focus {
                outline: none;
                box-shadow: 0px 0px 10px rgba(245, 162, 93, 0.6);
            }

            /* Bảng danh sách sinh viên */
            table {
                width: 90%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #FFF3D1;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            th, td {
                padding: 15px;
                text-align: center;
                border-bottom: 1px solid #D4905D;
            }

            th {
                background-color: #F7C690; /* Màu vàng pastel đậm */
                color: #5A4A42;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            td {
                background-color: #FFF9E6;
            }

            tr:hover {
                background-color: #FFE2A9; /* Hiệu ứng hover cho hàng bảng */
            }

            /* Hiệu ứng cho ảnh (nếu có) */
            td img {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
                transition: transform 0.3s ease;
            }

            td img:hover {
                transform: scale(1.2); /* Hiệu ứng hover cho ảnh */
            }

            /* Thông báo lỗi và thành công */
            p.error {
                color: #E57373; /* Màu đỏ cho lỗi */
                background-color: #FFEBEE;
                padding: 10px;
                border-radius: 5px;
                width: 50%;
                margin: 20px auto;
                text-align: center;
                box-shadow: 0px 4px 10px rgba(229, 115, 115, 0.3);
            }

            p.success {
                color: #4CAF50; /* Màu xanh cho thành công */
                background-color: #E8F5E9;
                padding: 10px;
                border-radius: 5px;
                width: 50%;
                margin: 20px auto;
                text-align: center;
                box-shadow: 0px 4px 10px rgba(76, 175, 80, 0.3);
            }

            /* Thay đổi kích thước và kiểu cho ô nhập giờ */
            input[type="text"]#currentTime {
                width: 100%; /* Đặt chiều rộng bằng 100% để khớp với các phần tử khác */
                padding: 10px; /* Thêm padding để có thêm không gian bên trong ô */
                margin-bottom: 20px; /* Đặt khoảng cách dưới cùng với các phần tử khác */
                border: 1px solid #D4905D; /* Viền giống như các phần tử khác */
                border-radius: 5px; /* Bo góc để giống với các phần tử khác */
                background-color: #FFF9E6; /* Màu nền giống với các ô nhập khác */
                transition: border 0.3s ease; /* Hiệu ứng chuyển đổi */
            }

            input[type="text"]#currentTime:focus {
                border-color: #D4905D; /* Màu viền khi ô được focus */
            }
        </style>


    </head>
    <body>

        <c:set var="user" value="${sessionScope.account}" />

        <c:if test="${user != null && user.role != 'Manager'}">
            <c:redirect url="accdn.jsp"/>
        </c:if>

        <h2>Search for Students</h2>
        <form action="check" method="post">

            <label for="tripDate">Trip Date:</label>
            <input type="date" id="tripDate" name="tripDate" value="${param.tripDate}" required><br><br>

            <label for="routeName">Route Name:</label>
            <select name="routeID" id="routeName" required>
                <c:forEach var="r" items="${requestScope.routeList}">
                    <option value="${r.rid}" <c:if test="${param.routeID == r.rid}">selected</c:if>>${r.name}</option>
                </c:forEach>
            </select>

            <label for="timePeriod">Time Period:</label>
            <select id="timePeriod" name="timePeriod">
                <option value="AM" <c:if test="${param.timePeriod == 'AM'}">selected</c:if>>Morning</option>
                <option value="PM" <c:if test="${param.timePeriod == 'PM'}">selected</c:if>>Afternoon</option>
                </select><br><br>

                <button type="submit">Search</button>
                <button type="button" onclick="window.location.href = 'statusStudent.jsp'">Change Check in Type</button>
                <button type="button" onclick="window.location.href = 'home.jsp'">Back To Home</button>
            </form>


        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>

        <c:if test="${not empty successMessage}">
            <p class="success">${successMessage}</p>
        </c:if>

        <c:if test="${not empty students}">


            <table>
                <tr>
                    <th>Student Name</th>
                    <th>Gender</th>
                    <th>Image</th>
                    <th>Date of Birth</th>
                    <th>Class</th>
                    <th>Drop Stop</th>
                    <th>Drop Time</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                <c:forEach var="student" items="${students}">
                    <tr>
                        <td>${student.name}</td>
                        <td>${student.gender}</td>
                        <td>${student.img}</td>
                        <td>${student.dob}</td>
                        <td>${student.classes}</td>
                        <td>${student.stopname}</td>

                    <form action="update" method="post">
                        <input type="hidden" name="studentID" value="${student.sid}">
                        <input type="hidden" name="timePeriod" value="${param.timePeriod}">
                        <input type="hidden" name="tripDate" value="${param.tripDate}">
                        <input type="hidden" name="routeID" value="${sessionScope.routeID}">

                        <td>
                            <input  style="margin-top: 15px;
                                    text-align: center;
                                    width: 70px" type="text" id="currentTime" name="currentTime" value="${currentTime}" readonly>
                        </td>

                        <td>
                            <select style="margin-top: 15px" id="Status" name="status">
                                <option value="onTheBus">On the Bus</option>
                                <option value="arrivedAtSchool">Arrived at School</option>
                                <option value="arrivedAtTheBusStation">arrived at the bus station</option>
                            </select>
                        </td>

                        <td>
                            <button style="margin-bottom: 7px" type="submit">Check in</button>
                        </td>
                    </form>
                </td
            </tr>
        </c:forEach>
    </table>
</c:if>

</body>
</html>



