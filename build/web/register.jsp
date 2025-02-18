<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng Ký Tuyến Xe</title>
        <style>
            body {
                background-image: url('./image/bgr.jpg');
                font-family: Arial, sans-serif;
                background-color: #FFE082;
                margin: 0;
                padding: 20px;
            }

            .container {
                max-width: 600px;
                margin: auto;
                padding: 20px;
                background: white;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                color: #F24405;
            }

            select {
                width: 100%;
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            button {
                padding: 10px;
                background-color: #F24405;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                width: 48%;
                margin-right: 2%;
            }

            button:hover {
                background-color: #4C6B1F;
            }

            .notice {
                color: greenyellow; /* Change to green for success */
                text-align: center;
                margin: 10px 0;
            }

            .button-container {
                display: flex;
                justify-content: space-between;
            }
        </style>
    </head>
    <body>
        <c:set var="user" value="${sessionScope.account}" />

        <c:if test="${user != null && user.role != 'Parent'}">
            <c:redirect url="home.jsp"/>
        </c:if>
        <jsp:include page="header1.jsp"/>

        <div style="display: block; margin-top: 7%;"></div>
        <div class="container" style="background-color: #FFE082">
            <h2>Register Stop Of Route</h2>

            <c:if test="${not empty message}">
                <div class="notice">${message}</div>
            </c:if>

            <form action="route" method="post">
                <input type="hidden" name="action" value="registop">

                <label for="sid">Student Name:</label>
                <select name="sid" required id="sid">
                    <c:forEach items="${listS}" var="o">
                        <option ${param.sid == o.sid ? 'selected' : ''} value="${o.sid}">${o.name}</option>
                    </c:forEach>
                </select>

                <label for="stopid">Stop:</label>
                <select name="stopid" required id="stopid">
                    <c:forEach items="${listSt}" var="o">
                        <option ${param.stopid == o.stopid ? 'selected' : ''} value="${o.stopid}">${o.stopname}</option>
                    </c:forEach>
                </select>
                <div style="margin-top: 10px" class="button-container">
                    <button type="submit">Register</button>
                    <button type="button" onclick="window.history.back();">Back</button>
                </div>
            </form>
        </div>
        <br/>
        <jsp:include page="footer.jsp"/>
    </body>
</html>