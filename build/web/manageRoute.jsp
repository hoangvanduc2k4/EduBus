<%-- 
    Document   : manageRoute
    Created on : Oct 29, 2024, 11:24:50 AM
    Author     : sonNH
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Route Management</title>

        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa; /* Màu nền nhẹ */
                margin: 0;
                padding: 20px;
                color: #333; /* Màu chữ chính */
            }

            h1 {
                text-align: center;
                margin-bottom: 20px;
                color: #FFB300; /* Màu vàng cho tiêu đề */
                font-size: 2.5em; /* Kích thước chữ lớn hơn */
                display: inline-block; /* Để chiều rộng tự động theo nội dung */
                margin: 0; /* Xóa khoảng cách mặc định */
                display: flex;
                justify-content: center;    
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                background-color: rgba(255, 255, 255, 0.95); /* Nền bảng trắng với độ trong suốt */
                border-radius: 10px; /* Bo góc cho bảng */
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2); /* Đổ bóng nhẹ */
            }

            th, td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid #ddd; /* Đường viền dưới nhẹ */
            }

            thead {
                background-color: #FF9800; /* Màu cam cho tiêu đề */
                color: white; /* Màu chữ trắng */
            }

            tr:hover {
                background-color: rgba(255, 239, 153, 0.6); /* Màu nền khi di chuột qua hàng */
            }

            td.at {
                font-weight: bold;
                color: #555; /* Màu chữ tối cho các ô dữ liệu */
            }

            /* Button Styles */
            .button {
                display: inline-block;
                padding: 10px 20px;
                font-size: 16px;
                color: #ffffff; /* Màu chữ trắng */
                background-color: #FFC107; /* Màu vàng cho nút */
                border: none;
                border-radius: 5px;
                text-decoration: none;
                margin: 10px 5px; /* Cách giữa các nút */
                transition: background-color 0.3s ease, transform 0.2s ease;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            }

            .button:hover {
                background-color: #FFA000; /* Màu vàng đậm hơn khi hover */
                transform: translateY(-2px);
            }

            .button:active {
                transform: translateY(1px);
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
            }

            /* Home and Statistic Buttons */
            .back-home-btn, .back-statistic-btn {
                display: inline-block;
                margin: 10px;
                padding: 10px 15px;
                background-color: #FF9800; /* Màu cam cho nút */
                color: white; /* Màu chữ trắng */
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .back-home-btn:hover, .back-statistic-btn:hover {
                background-color: #F57C00; /* Màu cam đậm hơn khi hover */
            }

            .icon {
                margin-right: 5px;
            }

            /* Responsive Styling */
            @media screen and (max-width: 768px) {
                table {
                    font-size: 14px;
                }

                .button {
                    width: 100%;
                    text-align: center;
                }
            }

        </style>
    </head>
    <body>

        <c:set var="user" value="${sessionScope.account}" />

        <c:if test="${user != null && user.role != 'Admin'}">
            <c:redirect url="accdn.jsp"/>
        </c:if>
        
        <h1>LIST ROUTES</h1>

        <!-- Nút thêm và quay lại được đặt ở đầu -->
        <div style="text-align: center; display: flex; justify-content: start">
            <a id="nut1" class="button" href="addRoute.jsp">Add Route</a>
            <a href="home.jsp" class="back-home-btn">
                <span class="icon">🏠</span> Home
            </a>
            <a href="statistic" class="back-statistic-btn">
                <span class="icon">📊</span> Dashboard
            </a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Route Name</th>
                    <th>Stop Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${routes}">
                    <tr>
                        <td class="at">${r.name}</td>
                        <td class="at">${r.road}</td>
                        <td class="at">
                            <a id="nut1" class="button" href="updater?rid=${r.rid}">Update</a> 
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </body>
</html>
