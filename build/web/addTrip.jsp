<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Trip</title>
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #ffedbc 0%, #f8d3a0 100%);
                margin: 0;
                padding: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                flex-direction: column;
            }

            h1 {
                color: #f2594b; /* Màu nâu sẫm cho tiêu đề */
                text-align: center;
                font-size: 2.5rem;
                text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
                margin-top: 0;
                margin-bottom: 20px;
            }

            form {
                background-color: rgba(255, 255, 255, 0.9);
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                padding: 40px;
                max-width: 600px;
                width: 100%;
                transition: transform 0.3s ease;
            }

            form:hover {
                transform: scale(1.02);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            }

            label {
                font-weight: 600;
                display: block;
                margin: 10px 0 5px;
                color: #3b3a35;
                font-size: 1.2rem;
            }

            input[type="date"],
            input[type="time"],
            select {
                width: 100%;
                padding: 12px;
                margin-bottom: 20px;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                background-color: rgba(255, 255, 255, 0.7);
                box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }

            input[type="date"]:hover,
            input[type="time"]:hover,
            select:hover {
                background-color: rgba(255, 255, 255, 0.85);
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            }

            button {
                background-color: #ff8c00; /* Màu vàng cam */
                color: white;
                padding: 15px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-size: 18px;
                font-weight: bold;
                width: 100%;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                transition: all 0.3s ease;
            }

            button:hover {
                background-color: #ff7f00; /* Màu vàng cam đậm hơn */
                transform: scale(1.05);
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
            }

            .success {
                background-color: #4CAF50; /* Màu xanh lá biểu thị thành công */
                color: white; /* Màu chữ trắng */
                padding: 15px; /* Khoảng cách bên trong */
                border-radius: 8px; /* Các góc bo tròn */
                margin-bottom: 20px; /* Khoảng cách dưới */
                text-align: center; /* Canh giữa */
                font-size: 1.2rem; /* Cỡ chữ */
                font-weight: bold; /* In đậm */
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Đổ bóng */
                animation: fadeIn 0.5s ease-in-out; /* Hiệu ứng chuyển động khi xuất hiện */
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

        </style>
    </head>
    <body>
        <h1>Create a New Trip</h1>
        
        <c:set var="user" value="${sessionScope.account}" />

        <c:if test="${user != null && user.role != 'Manager'}">
            <c:redirect url="accdn.jsp"/>
        </c:if>
        
        <c:if test="${not empty successMessage}">
            <p class="success">${successMessage}</p>
        </c:if>

        <form id="tripForm" action="add" method="POST">
            <label for="tripDate">Trip Date:</label>
            <input type="date" id="tripDate" name="tripDate" required>

            <label for="departureTime">Departure Time:</label>
            <input type="time" id="departureTime" name="departureTime" required pattern="[0-9]{2}:[0-9]{2}">

            <label for="timePeriod">Time Period:</label>
            <select name="timePeriod" id="timePeriod">
                <option value="AM">Morning</option>
                <option value="PM">Afternoon</option>
            </select>

            <label for="driverID">Driver:</label>
            <select name="driverID" id="driverID" required>
                <c:forEach var="driver" items="${requestScope.drivers}">
                    <option value="${driver.id}">${driver.name}</option>
                </c:forEach>
            </select>

            <label for="busID">Bus:</label>
            <select name="busID" id="busID" required>
                <c:forEach var="bus" items="${requestScope.buses}">
                    <option value="${bus.busid}">${bus.license}</option>
                </c:forEach>
            </select>

            <input type="hidden" name="managerID" value="${managerAccount.accid}">

            <div style="display: flex; gap: 10px;">
                <button type="submit">Add Trip</button>
                <button type="button" onclick="window.location.href = 'home.jsp'">Back to Home</button>
            </div>
        </form>
    </body>
</html>
