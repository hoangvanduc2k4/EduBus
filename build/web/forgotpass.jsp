<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background: linear-gradient(to bottom right, #d4e157, #8bc34a); /* Yellow-green gradient */
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .container {
                max-width: 400px;
                background: rgba(255, 255, 255, 0.9); /* Slightly transparent white */
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            }
            h2 {
                text-align: center;
                color: #333;
            }
            input[type="text"] {
                width: 95%;
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            button {
                width: 100%;
                padding: 10px;
                background-color: yellowgreen; /* Main button color */
                color: black;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            button:hover {
                background-color: #aaf600; /* Lighter shade on hover */
            }
            .message {
                text-align: center;
                margin-top: 10px;
                color: #333;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Forgot Password</h2>
            <form method="get" action="register">
                <input type="text" name="phone" placeholder="Enter your phone number" required value="${phone}">
                <button type="submit">Get Username and Password</button>
            </form>
            <div class="message">
                <p style="color: red; font-style: italic;">${error}</p>
                <c:if test="${a!=null}">
                    Username: ${a.username}<br>
                    Password: ${a.password}

                </c:if>
            </div>
            <br>
            <button class='login-btn' onclick="window.location.href = 'login'">Back to Login</button>
        </div>
        <script>
            const messageDiv = document.querySelector('.message');
            if (messageDiv.innerHTML.includes("Username:")) {
                const loginButton = document.querySelector('.login-btn');
                loginButton.style.display = 'block';
            }
        </script>
    </body>
</html>