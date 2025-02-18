<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Route</title>
        <style>
            /* Global styles */
            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #FFF6E5, #FFE2CC); /* Nền vàng cam pastel nhẹ nhàng */
                color: #333;
                padding: 40px;
                margin: 0;
            }

            h2, h3 {
                color: #D35400;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.1); /* Tạo điểm nhấn */
            }

            a {
                text-decoration: none;
                color: #fff;
                font-weight: bold;
                transition: all 0.3s ease;
            }

            a:hover {
                color: #F39C12;
                text-shadow: 2px 2px 5px rgba(243, 156, 18, 0.7); /* Hiệu ứng hover */
            }

            label {
                display: inline-block;
                margin-bottom: 6px;
                color: #D35400;
                font-weight: bold;
            }

            input[type="text"], input[type="number"] {
                width: calc(100% - 10px);
                padding: 12px;
                border: 2px solid #E67E22;
                border-radius: 8px;
                background-color: #FFF1E0;
                color: #D35400;
                font-size: 14px;
                margin-bottom: 10px;
                transition: all 0.3s ease;
            }

            input[type="text"]:focus, input[type="number"]:focus {
                border-color: #E67E22;
                box-shadow: 0 0 10px rgba(230, 126, 34, 0.6); /* Hiệu ứng khi focus */
                outline: none;
            }

            /* Stop List styles */
            .stop {
                background: rgba(255, 250, 240, 0.9); /* Màu nền pastel nhẹ cho danh sách */
                padding: 15px;
                margin-bottom: 15px;
                border-radius: 12px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .stop label {
                color: #D35400;
                font-size: 12px;
                font-weight: 500;
            }

            .stop input {
                width: 70%;
                padding: 10px;
                margin-right: 15px;
                border: 1px solid #E67E22;
                border-radius: 5px;
                background-color: #FFF8F0;
            }

            button {
                background-color: #E67E22; /* Màu cam pastel */
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                cursor: pointer;
                font-weight: bold;
                font-size: 16px;
                box-shadow: 0 5px 15px rgba(230, 126, 34, 0.3); /* Shadow nhẹ cho nút */
                transition: all 0.3s ease;
            }

            button:hover {
                background-color: #D35400;
                box-shadow: 0 10px 25px rgba(211, 84, 0, 0.5); /* Hiệu ứng hover */
            }

            button[type="button"] {
                background-color: #E74C3C;
            }

            button[type="button"]:hover {
                background-color: #C0392B;
                box-shadow: 0 10px 25px rgba(231, 76, 60, 0.5);
            }

            /* Success and error messages */
            .success, .error {
                padding: 12px;
                margin: 20px 0;
                border-radius: 8px;
                font-weight: bold;
                text-align: center;
                font-size: 18px;
            }

            .success {
                background-color: #F39C12; /* Màu vàng pastel */
                color: white;
                box-shadow: 0 4px 15px rgba(243, 156, 18, 0.6); /* Hiệu ứng thành công */
            }

            .error {
                background-color: #E74C3C;
                color: white;
                box-shadow: 0 4px 15px rgba(231, 76, 60, 0.6); /* Hiệu ứng lỗi */
            }

            input[type="submit"] {
                background-color: #F39C12;
                border: none;
                color: white;
                font-weight: bold;
                padding: 12px 30px;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease, transform 0.2s ease;
                box-shadow: 0 5px 20px rgba(243, 156, 18, 0.4); /* Nút submit */
            }

            input[type="submit"]:hover {
                background-color: #E67E22;
                transform: scale(1.05);
                box-shadow: 0 10px 30px rgba(230, 126, 34, 0.6); /* Hiệu ứng hover */
            }

            .button {
                background-color: #F39C12;
                padding: 12px 30px;
                border-radius: 8px;
                display: inline-block;
                color: white;
                font-weight: bold;
                margin-top: 20px;
                transition: all 0.3s ease;
                box-shadow: 0 5px 15px rgba(243, 156, 18, 0.4); /* Bóng nút */
            }

            .button:hover {
                background-color: #E67E22;
                box-shadow: 0 10px 30px rgba(230, 126, 34, 0.6);
                transform: scale(1.05);
            }

            /* Animation */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            body, h2, h3, label, input, button, a {
                animation: fadeIn 0.8s ease-in-out;
            }

            /* Stop button container */
            .button-container {
                display: flex;
                justify-content: flex-end;
                margin-top: 15px;
            }

            /* Add a slight margin to the 'Add Stop' button */
            button[type="button"] {
                margin-bottom: 20px;
            }

        </style>
    </head>
    <body>

        <h2>Update Route</h2>

        <c:set var="user" value="${sessionScope.account}" />
        <c:if test="${user != null && user.role != 'Admin'}">
            <c:redirect url="accdn.jsp"/>
        </c:if>

        <c:if test="${not empty success}">
            <p class="success">${requestScope.success}</p>
        </c:if>

        <c:if test="${not empty error}">    
            <p class="error">${requestScope.error}</p>
        </c:if>


        <form action="updater" method="post">
            <label for="routeName">New Route Name:</label>
            <input type="text" id="routeName" name="routeName" placeholder="${requestScope.routename}" required><br><br>

            <h3>Stops List</h3>
            <div id="stopList">
                <c:forEach var="stop" items="${requestScope.listRoute}" varStatus="status">
                    <div class="stop">
                        <label>Stop Order:</label>
                        <input type="number" name="stopOrder" value="${status.index + 1}" readonly required>

                        <label>Stop Name:</label>
                        <input type="text" name="stopName" value="${stop.stopname}" required >

                        <button type="button" onclick="alert('Cannot delete existing stops.')">Delete</button>
                    </div>
                </c:forEach>
            </div>
            <button type="button" onclick="addStop()">Add Stop</button>
            <input type="hidden" name="rid" value="${requestScope.rid}">
            <input type="submit" value="Update Route">
        </form>
        <a id="nut1" class="button" href="manar">All Routes</a> 

        <script>
            let stopCount = ${fn:length(requestScope.listRoute)};
            let newStops = 0; 

            function addStop() {
                stopCount++;
                newStops++;
                const stopDiv = document.createElement("div");
                stopDiv.classList.add("stop");
                stopDiv.innerHTML = `
                <label>Stop Order:</label>
                <input type="number" name="stopOrder" value="${stopCount}" readonly required>
                <label>Stop Name:</label>
                <input type="text" name="stopName" required>
                <button type="button" onclick="removeStop(this)">Delete</button>
            `;
                document.getElementById("stopList").appendChild(stopDiv);
                updateStopOrders(); // Call this function right after adding a new stop
            }

            function removeStop(button) {
                const stopDiv = button.parentElement;
                stopDiv.remove();
                newStops--; // Decrease count of new stops
                updateStopOrders();
            }

            function updateStopOrders() {
                const stops = document.querySelectorAll('#stopList .stop');
                stops.forEach((stop, index) => {
                    const stopOrderInput = stop.querySelector('input[name="stopOrder"]');
                    stopOrderInput.value = index + 1;
                });
                stopCount = stops.length;
            }
        </script>

    </body>
</html>
