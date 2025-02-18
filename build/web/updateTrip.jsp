<%-- 
    Document   : updateTrip
    Created on : Oct 23, 2024, 11:20:23 PM
    Author     : sonNH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #eef2f7;
                color: #333;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 50%;
                margin: 60px auto;
                background: #ffffff;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
                transition: box-shadow 0.3s ease;
            }

            .container:hover {
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            }

            h2 {
                font-size: 26px;
                margin-bottom: 20px;
                color: #2c3e50;
                text-align: center;
                font-weight: 600;
            }

            label {
                display: block;
                margin: 15px 0 5px;
                font-size: 15px;
                color: #34495e;
            }

            input[type="date"],
            input[type="time"],
            select {
                width: 100%;
                padding: 10px;
                border: 2px solid #bdc3c7;
                border-radius: 8px;
                font-size: 14px;
                background-color: #f9f9f9;
                transition: border-color 0.4s ease, background-color 0.4s ease;
            }

            input[type="date"]:focus,
            input[type="time"]:focus,
            select:focus {
                border-color: #3498db;
                background-color: #eaf4fb;
            }

            input[type="submit"],
            a.button,
            a.cancel {
                display: inline-block;
                padding: 12px 24px;
                margin-top: 25px;
                border-radius: 8px;
                background-color: #2980b9;
                color: #ffffff;
                font-size: 16px;
                text-align: center;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
                text-decoration: none;
                border: none;
            }

            input[type="submit"]:hover,
            a.button:hover,
            a.cancel:hover {
                background-color: #1abc9c;
                transform: translateY(-2px);
            }

            input[type="submit"]:active,
            a.button:active,
            a.cancel:active {
                transform: translateY(0);
            }

            .success {
                color: #27ae60;
                font-size: 14px;
                margin-bottom: 15px;
                text-align: center;
            }

            .error {
                color: #e74c3c;
                font-size: 14px;
                margin-bottom: 15px;
                text-align: center;
            }

        </style>
    </head>
    <body>

        <c:set var="user" value="${sessionScope.account}" />
        <c:if test="${user != null && user.role != 'Manager'}">
            <c:redirect url="accdn.jsp"/>
        </c:if>

        <div class="container">
            <h2>Update Trip Information</h2>
            <c:if test="${not empty success}">
                <p class="success">${requestScope.success}</p>
            </c:if>

            <c:if test="${not empty error}">    
                <p class="error">${requestScope.error}</p>
            </c:if>

            <form action="updatetrip" method="post">

                <input type="hidden" name="tid" value="${requestScope.tid}" />
                <input type="hidden" name="mid" value="${requestScope.mid}" />

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

                <input type="submit" value="Update Trip" />
                <a href="infor" class="cancel">Cancel</a>
                <a href="home.jsp" class="button">Back Home</a>
            </form>
        </div>
    </body>
</html>
