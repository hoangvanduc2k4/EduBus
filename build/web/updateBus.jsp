<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Danh sách xe buýt</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #fff3e0; /* Màu nền pastel */
            color: #4e342e; /* Màu chữ tối */
            margin: 0;
            padding: 20px;
            transition: background-color 0.3s;
        }
        h1 {
            text-align: center;
            color: #ffb300; /* Màu vàng rực rỡ */
            margin-bottom: 20px;
            font-size: 2.5em; /* Kích thước chữ lớn */
            transition: color 0.3s;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden; /* Bo góc cho bảng */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Bóng cho bảng */
        }
        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ffb300; /* Đường viền vàng */
            transition: background-color 0.3s;
        }
        th {
            background-color: #ffcc80; /* Màu vàng nhạt cho tiêu đề bảng */
            color: #4e342e;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #ffe0b2; /* Màu nền bảng pastel cho hàng chẵn */
        }
        tr:hover {
            background-color: #ffe57f; /* Màu nền bảng khi hover */
        }
        input[type="submit"], .back-button {
            background-color: #ffb300; /* Nền nút vàng */
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 20px;
            display: inline-block;
            text-decoration: none; /* Bỏ gạch chân cho nút quay về */
            transition: background-color 0.3s, transform 0.2s; /* Hiệu ứng cho nút */
        }
        input[type="submit"]:hover, .back-button:hover {
            background-color: #ffa000; /* Nền nút khi hover */
            transform: scale(1.05); /* Hiệu ứng phóng to khi hover */
        }
        .update-message, .error-message {
            text-align: center;
            font-weight: bold;
            margin-top: 20px;
            transition: color 0.3s;
        }
        .update-message {
            color: green;
        }
        .error-message {
            color: red; /* Màu chữ thông báo lỗi */
        }
        /* Hiệu ứng cho nút quay về */
        .back-button {
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <h1>Danh sách xe buýt</h1>

    <c:if test="${not empty updateMessage}">
        <div class="update-message">${updateMessage}</div>
        <c:set var="updateMessage" value="" scope="session"/> 
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="error-message">${errorMessage}</div>
        <c:set var="errorMessage" value="" scope="session"/> 
    </c:if>

    <form action="manab" method="post">
        <table>
            <tr>
                <th>Bus ID</th>
                <th>Status</th>
                <th>Issues</th>
                <th>License Plate</th>
                <th>Route Name</th>
                <th>Select</th>
            </tr>
            <c:forEach var="bus" items="${buses}">
                <tr>
                    <td>${bus.BusID}</td>
                    <td>${bus.Status}</td>
                    <td>${bus.Issues}</td>
                    <td>${bus.LicensePlate}</td>
                    <td>${bus.RouteName}</td>
                    <td>
                        <input type="checkbox" name="selectedBus" value="${bus.BusID}">
                    </td>
                </tr>
            </c:forEach>
        </table>
        <input type="submit" value="Update Buses" onclick="return checkSelection();">
        <a class="back-button" href="statistic">Quay về Dashboard</a> <!-- Nút quay về dashboard -->
    </form>

    <script>
        function checkSelection() {
            const checkboxes = document.querySelectorAll('input[name="selectedBus"]:checked');
            if (checkboxes.length !== 2) {
                alert('Vui lòng chọn chính xác 2 xe buýt để cập nhật.');
                return false; 
            }
            return true; 
        }
    </script>
</body>
</html>
