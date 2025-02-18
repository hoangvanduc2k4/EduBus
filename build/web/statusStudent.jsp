<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Attendance</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #fff8e1; /* Pastel background color */
                margin: 20px;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            h1 {
                color: #ff8c00; /* Title color */
            }
            .button-container {
                display: flex;
                justify-content: center;
                margin-top: 30px;
                gap: 20px; /* Thêm khoảng cách giữa các nút */
            }
            .card-button {
                background-color: #ffcc80; /* Card background */
                border: 1px solid #ffb74d;
                border-radius: 15px; /* Rounded corners for card style */
                width: 200px;
                height: 250px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1); /* Subtle shadow effect */
                transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth transition */
                text-decoration: none; /* Remove underline from links */
                color: #ffffff; /* Text color */
                font-size: 18px;
                cursor: pointer;
            }
            .card-button:hover {
                transform: translateY(-10px); /* Lift effect on hover */
                box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2); /* Stronger shadow on hover */
            }
            .card-button span {
                font-weight: bold;
                font-size: 24px;
                margin-top: 10px;
            }
            .card-button::before {
                content: '🚌'; /* Icon for card */
                font-size: 48px;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <c:set var="user" value="${sessionScope.account}" />

        <c:if test="${user != null && user.role != 'Manager'}">
            <c:redirect url="accdn.jsp"/>
        </c:if>
        
        <h1>Student Attendance</h1>
        <div class="button-container">
            <a href="check?action=attendance&value=toSchool" class="card-button">
                <span>To School</span>
            </a>
            <a href="check?action=attendance&value=toHome" class="card-button">
                <span>To Home</span>
            </a>
        </div>
    </body>
</html>
