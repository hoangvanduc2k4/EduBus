<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Add New Route</title>
        <style>
            /* Style for the entire body */
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #fffde7; /* Light pastel background */
                color: #333; /* Dark text for contrast */
                margin: 0;
                padding: 20px;
            }

            /* Main header style */
            h2 {
                color: #ff8f00; /* Bright orange color */
                text-align: center;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1); /* Subtle text shadow */
            }

            /* Form styles */
            form {
                background-color: #ffffff; /* White background for form */
                border-radius: 15px; /* More rounded corners */
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1); /* Deeper shadow for depth */
                padding: 30px;
                max-width: 600px;
                margin: auto;
                transition: transform 0.3s; /* Subtle lift effect on hover */
            }

            form:hover {
                transform: translateY(-5px); /* Lift effect */
            }

            /* Input styles */
            input[type="text"],
            input[type="number"],
            input[type="submit"] {
                width: calc(100% - 20px); /* Full width minus padding */
                padding: 12px;
                border: 2px solid #ff8f00; /* Bright border */
                border-radius: 10px; /* More rounded corners */
                transition: border-color 0.3s, box-shadow 0.3s; /* Transition for focus */
                font-size: 16px; /* Larger font size */
            }

            /* Input focus effect */
            input[type="text"]:focus,
            input[type="number"]:focus {
                border-color: #ff6f00; /* Darker orange on focus */
                box-shadow: 0 0 10px rgba(255, 111, 0, 0.5); /* Brighter shadow on focus */
                outline: none; /* Remove default outline */
            }

            /* Button styles */
            button {
                background-color: #ff8f00; /* Bright orange background */
                color: white;
                border: none;
                border-radius: 10px;
                padding: 12px 18px;
                cursor: pointer;
                font-size: 16px; /* Larger font size */
                transition: background-color 0.3s, transform 0.2s; /* Transition for hover */
                margin-top: 10px; /* Spacing */
            }

            /* Button hover effect */
            button:hover {
                background-color: #ff6f00; /* Darker on hover */
                transform: scale(1.05); /* Slightly grow on hover */
            }

            /* Success and error message styles */
            .success {
                color: #4caf50; /* Bright green for success */
                margin: 15px 0;
                font-weight: bold;
                text-align: center;
            }

            .error {
                color: #f44336; /* Bright red for error */
                margin: 15px 0;
                font-weight: bold;
                text-align: center;
            }

            /* Style for links */
            a.button {
                display: inline-block; /* Block link */
                margin-top: 20px;
                padding: 12px 18px;
                background-color: #ff8f00; /* Matching background */
                color: white;
                border-radius: 10px;
                text-decoration: none; /* No underline */
                transition: background-color 0.3s; /* Transition */
                font-size: 16px; /* Larger font size */
            }

            /* Link hover effect */
            a.button:hover {
                background-color: #ff6f00; /* Darker on hover */
            }

            /* Style for stop list */
            .stop {
                margin-bottom: 15px; /* Spacing between stops */
                border: 2px solid #ff8f00; /* Bright border */
                border-radius: 10px; /* More rounded corners */
                padding: 15px; /* Padding for content */
                background-color: #fff3e0; /* Light pastel background for stops */
                transition: box-shadow 0.3s; /* Shadow transition */
            }

            .stop:hover {
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Shadow on hover */
            }

            /* Add Route button styles */
            input[type="submit"] {
                width: 100%; /* Full width button */
                padding: 15px;
                background: linear-gradient(45deg, #ffcc80, #ff8f00); /* Gradient background */
                border: none;
                border-radius: 15px;
                color: white;
                font-size: 18px; /* Larger font size */
                font-weight: bold; /* Bold text */
                text-transform: uppercase; /* Make text uppercase */
                cursor: pointer;
                transition: background 0.4s ease, transform 0.3s ease, box-shadow 0.3s ease; /* Smooth transitions */
                box-shadow: 0 4px 15px rgba(255, 143, 0, 0.5); /* Glow effect */
            }

            /* Add Route button hover effect */
            input[type="submit"]:hover {
                background: linear-gradient(45deg, #ffa726, #ff6f00); /* Darker gradient on hover */
                transform: scale(1.05); /* Slightly increase size on hover */
                box-shadow: 0 8px 20px rgba(255, 143, 0, 0.7); /* Larger glow on hover */
            }

            /* Add Route button focus effect */
            input[type="submit"]:focus {
                outline: none; /* Remove default focus outline */
                box-shadow: 0 8px 25px rgba(255, 143, 0, 0.9); /* Stronger glow on focus */
            }



        </style>
    </head>
    <body>
        <h2>Add New Route</h2>

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
        <a id="nut1" class="button" href="manar">All Routes</a> 
        <form action="addroute" method="post">
            <label for="routeName">Route Name:</label>
            <input type="text" id="routeName" name="routeName" required><br><br>

            <h3>List Stop:</h3>
            <div id="stopList">
                <div class="stop">
                    <label for="stopOrder1">Stop Order:</label>
                    <input type="number" id="stopOrder1" name="stopOrder" value="1" required readonly>
                    <label for="stopName1">Stop Name:</label>
                    <input type="text" id="stopName1" name="stopName" required>
                    <button type="button" onclick="removeStop(this)">Delete</button><br><br>
                </div>
            </div>

            <button type="button" onclick="addStop()">Add Stop</button><br><br>

            <input type="submit" value="Add Route">
        </form>



        <script>
            let stopCount = 1;

            function addStop() {
                stopCount++;
                const stopDiv = document.createElement("div");
                stopDiv.classList.add("stop");
                stopDiv.innerHTML = `
                    <label for="stopOrder${stopCount}">Stop Order:</label>
                    <input type="number" id="stopOrder${stopCount}" name="stopOrder" value="${stopCount}" required readonly>
                    <label for="stopName${stopCount}">Stop Name:</label>
                    <input type="text" id="stopName${stopCount}" name="stopName" required>
                    <button type="button" onclick="removeStop(this)">Delete</button><br><br>
                `;
                document.getElementById("stopList").appendChild(stopDiv);
                updateStopOrders();
            }

            function removeStop(button) {
                const stops = document.querySelectorAll('#stopList .stop');
                if (stops.length > 1) {  // Chỉ cho phép xóa nếu còn nhiều hơn 1 stop
                    const stopDiv = button.parentElement;
                    stopDiv.remove();
                    updateStopOrders();
                } else {
                    alert("Phải có ít nhất một điểm dừng.");
                }
            }

            function updateStopOrders() {
                const stops = document.querySelectorAll('#stopList .stop');
                stopCount = stops.length;
                stops.forEach((stop, index) => {
                    const stopOrderInput = stop.querySelector('input[name="stopOrder"]');
                    stopOrderInput.value = index + 1;
                });
            }
        </script>
    </body>
</html>
