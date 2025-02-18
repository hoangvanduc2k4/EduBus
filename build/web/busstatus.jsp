<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cập nhật Tình trạng Xe</title>
        <style>
            body {
                background-image: url('image/bg.jpg'); /* Background image */

                font-family: Arial, sans-serif;
                background-color: #f9f911;
                margin: 0;
                padding: 20px;
            }
            .container {
                max-width: 800px;
                margin: auto;
                padding: 30px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }
            h2 {
                text-align: center;
                color: black;
                margin-bottom: 20px;
            }
            .form-group {
                margin-bottom: 20px;
                padding: 15px;
                border: 1px solid #e0e0e0;
                border-radius: 5px;
                background-color: #fafafa;
            }
            label {
                font-weight: bold;
                color: #333;
            }
            input[type="text"], input[type="number"], select {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }
            button {
                padding: 10px;
                background-color: #F06651; /* Màu vàng */
                color: #333;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                width: 100%;
                transition: background-color 0.3s;
                font-size: 16px;
            }
            button:hover {
                background-color: #FEB599; /* Vàng nhạt hơn khi hover */
            }
            .status-message {
                text-align: center;
                margin-top: 20px;
                color: #4CAF50;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <c:set var="user" value="${sessionScope.account}" />

        <c:if test="${user != null && user.role != 'Driver'}">
            <c:redirect url="accdn.jsp"/>
        </c:if>
        <jsp:include page="header1.jsp"/>
        <br><br><br>
        <br/>

        <div class="container" style="background-color: #FFCC80">
            <h2>Update Bus Status</h2>
            <form action="bus" method="post">
                <input type="hidden" name="action" value="up" />
                <div class="form-group">
                    <label for="lic">License Plate:</label>
                    <select name="lic" required>
                        <c:forEach items="${listB}" var="o">
                            <option ${o.license == b.license ? 'selected' : ''} value="${o.license}">${o.license}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="status">Status:</label>
                    <select id="status" name="status" required>
                        <option  value="">Choose status</option>
                        <option ${"Active" == b.status ? 'selected' : ''} value="Active">Active</option>
                        <option ${"Inactive" == b.status ? 'selected' : ''} value="Inactive">Inactive</option>
                        <option ${"Under maintenance" == b.status ? 'selected' : ''} value="Under maintenance">Under maintenance</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="iss">Issues:</label>
                    <input type="text" id="comments" name="iss" value="${b.issues}">
                </div>
                <button type="submit">UPDATE</button>
                <div class="status-message" id="success-message">${error}</div>
            </form>
        </div>

        <jsp:include page="footer.jsp"/>

    </body>
</html>