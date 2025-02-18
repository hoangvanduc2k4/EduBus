<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>List Trip</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f8f1e7; /* Light pastel orange */
                margin: 0;
                padding: 20px;
            }

            .form-container {
                background-color: #fff8e1; /* Very light pastel yellow */
                border-radius: 12px;
                box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
                padding: 30px;
                margin-bottom: 20px;
            }

            h2 {
                color: #f2594b;
                text-align: center;
                margin-bottom: 20px;
                font-size: 2em;
            }

            label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
                color: #555;
            }

            input[type="date"],
            select {
                width: calc(100% - 20px);
                padding: 12px;
                margin: 10px 0;
                border: 2px solid #FFB74D; /* Orange border */
                border-radius: 6px;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            input[type="date"]:focus,
            select:focus {
                border-color: #FF9800;
                box-shadow: 0 0 5px rgba(255, 152, 0, 0.5);
                outline: none;
            }

            input[type="submit"] {
                background-color: #FFB74D; /* Soft orange */
                color: #ffffff;
                padding: 12px 15px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            input[type="submit"]:hover {
                background-color: #FF9800; /* Darker orange */
                transform: translateY(-2px);
            }

            .table-container {
                margin-top: 20px;
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease; /* Transition for the table */
                border: 3px solid #FF9800; /* Darker orange border */
            }

            table:hover {
                transform: scale(1.02); /* Slight zoom effect on hover */
            }

            th, td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid #e0e0e0;
                transition: background-color 0.3s ease, transform 0.3s ease; /* Transition for rows */
            }

            th {
                background-color: #FFB74D; /* Soft orange */
                color: white;
                font-weight: bold;
                text-transform: uppercase; /* Uppercase for modern look */
                letter-spacing: 1px; /* Space between letters */
            }

            tr {
                transition: background-color 0.3s ease; /* Smooth transition for rows */
            }

            tr:nth-child(even) {
                background-color: #FFF3E0; /* Light pastel orange for even rows */
            }

            tr:nth-child(odd) {
                background-color: #FFE0B2; /* Slightly darker pastel orange for odd rows */
            }

            tr:hover {
                background-color: #FFD180; /* Brighter pastel orange on hover */
                transform: translateY(-2px); /* Slight lift effect */
            }

            .success {
                color: #28a745;
                font-weight: bold;
                text-align: center;
                margin: 10px 0;
                font-size: 1.1em;
            }

            .error {
                color: #dc3545;
                font-weight: bold;
                text-align: center;
                margin: 10px 0;
                font-size: 1.1em;
            }

            .button {
                display: inline-block;
                padding: 10px 15px;
                background-color: #FFB74D;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                margin: 5px 0;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            .button:hover {
                background-color: #FF9800;
                transform: translateY(-2px);
            }

        </style>
    </head>
    <body>

        <c:set var="user" value="${sessionScope.account}" />
        <c:if test="${user != null && user.role != 'Manager'}">
            <c:redirect url="accdn.jsp"/>
        </c:if>

        <form action="infor" method="post" class="form-container">
            <label for="searchDate">Tripdate:</label>
            <input type="date" id="searchDate" name="searchDate" required>

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

            <input type="hidden" name="managerID" value="${requestScope.managerId}">
            <input type="submit" value="Search">
        </form>

        <div class="head">
            <h2>Trip List</h2>
            <a id="nut3" class="button" href="home.jsp">BACK HOME</a>
            <a id="nut3" class="button" href="infor">ALL TRIP</a>
        </div>

        <c:if test="${not empty success}">
            <p class="success">${requestScope.success}</p>
        </c:if>

        <c:if test="${not empty error}">    
            <p class="error">${requestScope.error}</p>
        </c:if>

        <table>
            <tr>
                <th>Trip date</th>
                <th>Departure Time</th>
                <th>Time Period</th>
                <th>Driver Name</th>
                <th>Manager Name</th>
                <th>Bus License Plate</th>
                <th>Action</th> 
            </tr>

            <c:forEach var="trip" items="${trips}">
                <tr>
                    <td class="at">${trip.tripdate}</td>
                    <td class="at">${trip.departtime}</td>
                    <td class="at">${trip.timePeriod}</td>
                    <td class="at">${driverNames[trip.did]}</td>
                    <td class="at">${managerNames[trip.mid]}</td>
                    <td class="at">${busNames[trip.busid]}</td>
                    <td id="action">
                        <a id="nut1" class="button" href="updatetrip?tripID=${trip.tripid}&mid=${requestScope.mid}">Update</a> 
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
