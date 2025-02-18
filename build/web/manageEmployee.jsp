<%-- 
    Document   : manageEmployee
    Created on : Oct 27, 2024, 8:13:13 PM
    Author     : sonNH
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Employees</title>

        <style>
            /* General Styling */
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #fff8e1; /* Light pastel background color */
                margin: 0;
                padding: 40px;
                color: #333;
                line-height: 1.6;
            }

            /* Header Styling */
            h1 {
                color: #ff9e00; /* Dark yellow for the title */
                text-align: center;
                margin-bottom: 40px;
                font-size: 36px;
                letter-spacing: 1px;
                font-weight: 700;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
            }

            /* Button Styling */
            .back-home-btn, .back-statistic-btn, .add-employee-btn, .action-btn {
                background-color: #ffb300; /* Pastel orange for buttons */
                color: white;
                padding: 10px 20px;
                border-radius: 8px;
                text-decoration: none;
                font-size: 16px;
                display: inline-flex;
                align-items: center;
                transition: background-color 0.3s ease, transform 0.3s ease;
                border: none; /* Remove border */
                margin-bottom: 20px; /* Space between buttons */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .back-home-btn:hover, .back-statistic-btn:hover, .add-employee-btn:hover, .action-btn:hover {
                background-color: #ff9e00; /* Color when hovered */
                transform: translateY(-2px);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            }

            /* Form Styling */
            form {
                text-align: center;
                margin-bottom: 30px;
            }

            /* Search Container */
            .search-container {
                display: flex; /* Use flexbox for alignment */
                justify-content: center; /* Center items horizontally */
                flex-wrap: wrap; /* Allow wrapping on small screens */
            }

            /* Search Inputs */
            form input[type="text"],
            form input[type="date"],
            form select {
                padding: 10px;
                font-size: 16px;
                border: 1px solid #ddd;
                border-radius: 5px;
                margin: 5px; /* Reduced margin for better spacing */
                width: 150px; /* Set a fixed width for better alignment */
            }

            .search-bar input[type="submit"] {
                background-color: #ffb300;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.3s ease;
                margin-left: 10px; /* Add space between input fields and button */
            }

            /* Table Styling */
            .styled-table {
                width: 100%;
                border-collapse: collapse;
                margin: 25px 0;
                font-size: 18px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                border-radius: 12px;
                overflow: hidden;
                background-color: white; /* Background color for table */
            }

            .styled-table thead {
                background-color: #f8cba6; /* Light yellow for table header */
                color: #333; /* Dark color for header text */
            }

            .styled-table th, .styled-table td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid #dddddd; /* Bottom border for cells */
            }

            .styled-table tbody tr {
                transition: background-color 0.3s;
            }

            .styled-table tbody tr:nth-of-type(even) {
                background-color: #fff3e0; /* Background color for even rows */
            }

            .styled-table tbody tr:hover {
                background-color: #ffb300; /* Background color when hovering over a row */
                color: white; /* White text when hovering */
            }

            .styled-table tbody tr:last-of-type {
                border-bottom: 2px solid #ffb300; /* Bottom border for the last row */
            }

            /* Profile Image Styling */
            .profile-img {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid #ffb300; /* Border for profile image */
            }

            /* Search Bar Styling */
            .search-bar {
                margin: 20px auto;
                text-align: center;
            }

            .search-bar input[type="text"] {
                padding: 10px;
                font-size: 16px;
                width: 80%; /* Set width for search input */
                border: 1px solid #ddd;
                border-radius: 5px;
                margin-right: 10px; /* Space between search input and search button */
            }

            .search-bar input[type="submit"] {
                background-color: #ffb300;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.3s ease;
            }

            .search-bar input[type="submit"]:hover {
                background-color: #ff9e00; /* Color when hovered */
                transform: translateY(-2px);
            }

            /* Media Queries for Responsiveness */
            @media (max-width: 768px) {
                .styled-table {
                    font-size: 14px;
                }

                .add-employee-btn, .action-btn {
                    font-size: 14px;
                    padding: 8px 16px;
                }

                .search-bar input[type="text"] {
                    width: 90%; /* Change width for small screens */
                }

                form input[type="text"],
                form input[type="date"],
                form select {
                    width: 100%; /* Change width for form inputs on small screens */
                    margin-bottom: 10px; /* Space between inputs */
                }
            }

        </style>
    </head>
    <body>

        <c:set var="user" value="${sessionScope.account}" />

        <c:if test="${user != null && user.role != 'Admin'}">
            <c:redirect url="accdn.jsp"/>
        </c:if>

        <a href="home.jsp" class="back-home-btn">
            <span class="icon">🏠</span> Home
        </a>

        <a href="statistic" class="back-statistic-btn">
            <span class="icon">📊</span> Dashboard
        </a>

        <a href="manae" class="back-home-btn">
            <span class="icon">👨‍💼</span> All Employees
        </a>

        <h1>Manage Employees</h1>

        <form action="manae" method="POST" style="text-align: center; margin-bottom: 30px;">
            <input type="text" name="name" placeholder="Name" />
            <input type="text" name="phone" placeholder="Phone" />
            <select name="gender">
                <option value="">Gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
            </select>
            <select name="role" required="">
                <option value="">Role</option>
                <option value="Driver">Driver</option>
                <option value="Manager">Manager</option>
            </select>
            <input type="date" name="dob" placeholder="Date of Birth" />
            <input type="submit" value="Search" class="action-btn" />
        </form>

        <table class="styled-table">
            <thead>
                <tr>
                    <th>MANAGER NAME</th>
                    <th>PHONE</th>
                    <th>IMAGE</th>
                    <th>GENDER</th>
                    <th>DATE OF BIRTH</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="m" items="${list2}">
                    <tr>
                        <td>${m.name}</td>
                        <td>${m.phone}</td>
                        <td><img src="${m.img}" alt="Manager Image" class="profile-img"></td>
                        <td>${m.gender}</td>
                        <td>${m.dob}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <table class="styled-table">
            <thead>
                <tr>
                    <th>DRIVER NAME</th>
                    <th>PHONE</th>
                    <th>IMAGE</th>
                    <th>GENDER</th>
                    <th>DATE OF BIRTH</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="d" items="${list1}">
                    <tr>
                        <td>${d.name}</td>
                        <td>${d.phone}</td>
                        <td><img src="${d.img}" alt="Driver Image" class="profile-img"></td>
                        <td>${d.gender}</td>
                        <td>${d.dob}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </body>
</html>
