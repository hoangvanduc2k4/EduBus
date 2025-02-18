
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Change Password</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-image: url('image/bg.jpg'); /* Background image */
                background-size: cover; /* Cover the entire viewport */
                background-position: center; /* Center the image */
                color: #4a4a4a; /* Dark gray text */
                font-family: "Nunito", sans-serif;
            }
            .card {
                border: none;
                border-radius: 10px;
                margin-top: 20px;
                background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white */
            }
            .card-header {
                background-color: #c5e1a5; /* Light green header */
                font-weight: bold;
                color: #3c3c3c; /* Dark text */
            }
            .btn-primary {
                background-color: #8bc34a; /* Green */
                border: none;
            }
            .btn-primary:hover {
                background-color: #7cb342; /* Darker green on hover */
            }
            .error-message {
                color: red; /* Red color for error messages */
                display: none; /* Initially hidden */
            }
        </style>
    </head>
    <body>
        <c:set var="user" value="${sessionScope.account}" />

        <%@include file="header1.jsp" %>
        <br><br><br><br><br>

        <div class="row">
                <div class="col-xl-6 offset-xl-3">
                    <div class="card">
                        <div class="card-header">Change Password</div>
                        <div class="card-body">
                            <form method="post" action="change" onsubmit="return validatePasswords()">
                                <input type="hidden" name="id" value="${sessionScope.account.username}" />
                                <div class="mb-3">
                                    <label for="currentPassword" class="form-label">Current Password</label>
                                    <input class="form-control" id="currentPassword" name="cur" type="password" value="${param.cur}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="newPassword" class="form-label">New Password</label>
                                    <input class="form-control" id="newPassword" name="newp" type="password" value="${param.newp}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                    <input class="form-control" id="confirmPassword" name="con" type="password" value="${param.con}" required>
                                </div>
                                <div class="error-message" id="error-message">Passwords do not match!</div>
                                <button type="submit" class="btn btn-primary">Change Password</button>

                                <c:choose>
                                    <c:when test="${ user.role == 'Parent'}">
                                        <a href="parentinfo" class="btn btn-secondary">Cancel</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="profile" class="btn btn-secondary">Cancel</a>
                                    </c:otherwise>
                                </c:choose>




                                <p style="color: red; font-style: italic;">${error}</p>
                            </form>
                        </div>
                    </div>
                </div>

        </div>
        <script>
            function validatePasswords() {
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                const errorMessage = document.getElementById('error-message');

                if (newPassword !== confirmPassword) {
                    errorMessage.style.display = 'block'; // Hiện thông báo lỗi
                    return false; // Ngăn không cho gửi form
                } else {
                    errorMessage.style.display = 'none'; // Ẩn thông báo lỗi
                    return true; // Cho phép gửi form
                }
            }
        </script>
    </body>
</html>