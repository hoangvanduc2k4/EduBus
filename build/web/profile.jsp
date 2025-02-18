<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Profile</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(135deg, #ffedbc 0%, #f8d3a0 100%); /* Nền vàng cam pastel */
                color: #4a4a4a; /* Màu chữ tối */
                font-family: "Nunito", sans-serif;
                transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu nền */
            }

            .card {
                border: none;
                border-radius: 10px;
                margin-top: 20px;
                background-color: rgba(255, 255, 255, 0.9); /* Trắng sáng với độ trong suốt */
                transition: transform 0.3s ease; /* Hiệu ứng phóng to khi di chuột */
            }

            .card:hover {
                transform: translateY(-5px); /* Di chuyển lên khi hover */
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2); /* Đổ bóng */
            }

            .card-header {
                background-color: #ffcc80; /* Màu vàng cam nhạt cho tiêu đề */
                font-weight: bold;
                color: #3c3c3c; /* Màu chữ tối */
            }

            .avatar img {
                width: 150px;
                border-radius: 50%;
                border: 2px solid #ffab40; /* Viền cam */
                transition: transform 0.3s ease; /* Hiệu ứng phóng to cho avatar */
            }

            .avatar img:hover {
                transform: scale(1.1); /* Phóng to khi hover */
            }

            .btn-primary {
                background-color: #ffb300; /* Màu vàng cam */
                border: none;
                transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu khi hover */
            }

            .btn-success {
                background-color: #ffb300; /* Màu vàng */
                border: none;
                transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu khi hover */
                margin-top: 10px;
            }

            .btn-primary:hover {
                background-color: #ffa000; /* Màu vàng cam đậm hơn khi hover */
            }

            .btn-success:hover {
                background-color: #ffca28; /* Màu vàng đậm hơn khi hover */
            }

            .form-control {
                transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu nền */
            }

            .form-control:focus {
                background-color: rgba(255, 255, 255, 1); /* Nền trắng khi focus */
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.3); /* Đổ bóng khi focus */
            }
        </style>
    </head>
    <body>
        <%@include file="header1.jsp" %>
        <br><br><br><br>
        <div style="margin-top: 20px; background-color: #f2b885" class="container mt-4 ma">
            <div class="row">
                <div class="col-xl-4">
                    <div class="card">
                        <div class="card-header">Profile Picture</div>
                        <div class="card-body text-center avatar">
                            <img style="width: 150px; height: 150px;" src="${o.img}" alt="Default Image"/>
                            <h4 style="font-weight: bold;">${account.username}</h4>
                            <p>${account.role}</p>
                            <p>${o.name}</p>
                            <button type="button" class="btn btn-success" onclick="location.href = 'changepass.jsp'">Change Password</button>
                        </div>
                    </div>
                </div>
                <div class="col-xl-8">
                    <div class="card">
                        <div class="card-header">YOUR PROFILE</div>
                        <div class="card-body">
                            <form method="post" action="profile">
                                <input type="hidden" name="role" value="${account.role}" />
                                <input type="hidden" name="accid" value="${o.accid}" />

                                <div class="mb-3">
                                    <label for="fullName" class="form-label">Full Name</label>
                                    <input class="form-control" id="fullName" name="name" type="text" value="${o.name}" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="phone" class="form-label">Phone</label>
                                    <input class="form-control" id="phone" name="phone" readonly type="text" value="${o.phone}">
                                </div>
                                <div class="mb-3">
                                    <label for="gender" class="form-label">Gender</label>
                                    <input class="form-control" id="gender" name="gender" type="text" value="${o.gender}" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="dob" class="form-label">Date of Birth</label>
                                    <input class="form-control" id="dob" name="dob" readonly type="date" value="${o.dob}">
                                </div>
                                <div class="mb-3">
                                    <label for="img" class="form-label">Image Link</label>
                                    <input class="form-control" id="img" name="img" readonly type="text" value="${o.img}">
                                </div>
                                <button type="button" class="btn btn-primary" onclick="toggleEdit()">Edit Profile</button>
                                <button type="submit" class="btn btn-success" style="display:none;" id="saveButton">Save</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function toggleEdit() {
                const inputs = document.querySelectorAll('.form-control');
                inputs.forEach(input => {
                    input.readOnly = !input.readOnly;
                });
                document.getElementById('saveButton').style.display = 'block';
            }
        </script>
    </body>
</html>
