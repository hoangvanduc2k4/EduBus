<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xem Các Tuyến Xe</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 20px;
            }
            .container {
                max-width: 800px;
                margin: auto;
                padding: 20px;
                background: white;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h2 {
                text-align: center;
                color: #f24405; /* Màu xanh lá lúa */
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 10px;
                text-align: left;
                border: 1px solid black;
            }
            th {
                background-color: #FFFACD; /* Màu vàng nhạt */
                color: #333;
            }
            tr:hover {
                background-color: #f1f1f1;
            }
            button {
                padding: 10px;
                background-color: #f24405; /* Màu xanh lá lúa */
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 5px;
            }
            button:hover {
                background-color: #4C6B1F; /* Màu xanh lá đậm hơn */
            }
            .search-form {
                margin-bottom: 20px;
            }
            input[type="text"] {
                padding: 10px;
                width: calc(100% - 120px);
                margin-right: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <c:set var="user" value="${sessionScope.account}" />

        <c:if test="${user != null && user.role != 'Parent'}">
            <c:redirect url="accdn.jsp"/>
        </c:if>
        <jsp:include page="header1.jsp"/>
        <br><br><br><br>

        <div class="container" style="background-color: #FFE082; ">
            <h2>List Routes</h2>
            <form action="route" method="POST" class="search-form">
                <input type="hidden" name="action" value="sbs" />
                <input type="text" name="stop" placeholder="Enter address...." required>
                <button type="submit">Search</button>
            </form>

            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Route</th>
                        <th>Stop</th>
                        <th>Register</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="o" items="${listR}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${o.name}</td>
                            <td>${o.road}</td>
                            <td>
                                <form action="route" style="display:inline;" method="post">
                                    <input type="hidden" name="action" value="register" />
                                    <input type="hidden" name="rid" value="${o.rid}">
                                    <button type="submit">Choose</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>
        <jsp:include page="footer.jsp"/>


    </body>
</html>