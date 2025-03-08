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
                background: linear-gradient(135deg, #ffedbc 0%, #f8d3a0 100%);
                color: #4a4a4a;
                font-family: "Nunito", sans-serif;
                transition: background-color 0.3s ease;
            }
            .card {
                border: none;
                border-radius: 10px;
                margin-top: 20px;
                background-color: rgba(255, 255, 255, 0.9);
                transition: transform 0.3s ease;
            }
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            }
            .card-header {
                background-color: #ffcc80;
                font-weight: bold;
                color: #3c3c3c;
            }
            .avatar img {
                width: 150px;
                border-radius: 50%;
                border: 2px solid #ffab40;
                transition: transform 0.3s ease;
            }
            .avatar img:hover {
                transform: scale(1.1);
            }
            .btn-primary {
                background-color: #ffb300;
                border: none;
                transition: background-color 0.3s ease;
            }
            .btn-success {
                background-color: #ffb300;
                border: none;
                transition: background-color 0.3s ease;
                margin-top: 10px;
            }
            .btn-primary:hover {
                background-color: #ffa000;
            }
            .btn-success:hover {
                background-color: #ffca28;
            }
            .form-control {
                transition: background-color 0.3s ease;
            }
            .form-control:focus {
                background-color: rgba(255, 255, 255, 1);
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
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
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </c:if>
                        <div class="card-header">YOUR PROFILE</div>
                        <div class="card-body">
                            <form method="post" action="profile">
                                <input type="hidden" name="role" value="${account.role}" />
                                <input type="hidden" name="accid" value="${o.accid}" />
                                <div class="mb-3">
                                    <label for="fullName" class="form-label">Full Name</label>
                                    <input class="form-control" id="fullName" name="name" type="text" value="${o.name}" readonly>
                                    <c:if test="${not empty errorName}">
                                        <span class="text-danger">${errorName}</span>
                                    </c:if>
                                </div>
                                <div class="mb-3">
                                    <label for="phone" class="form-label">Phone</label>
                                    <input class="form-control" id="phone" name="phone" type="text" value="${o.phone}" readonly>
                                    <c:if test="${not empty errorPhone}">
                                        <span class="text-danger">${errorPhone}</span>
                                    </c:if>
                                </div>
                                <div class="mb-3">
                                    <label for="gender" class="form-label">Gender</label>
                                    <input class="form-control" id="gender" name="gender" type="text" value="${o.gender}" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="dob" class="form-label">Date of Birth</label>
                                    <input class="form-control" id="dob" name="dob" type="date" value="${o.dob}" readonly>
                                    <c:if test="${not empty errorDob}">
                                        <span class="text-danger">${errorDob}</span>
                                    </c:if>
                                </div>
                                <div class="mb-3">
                                    <label for="img" class="form-label">Image Link</label>
                                    <input class="form-control" id="img" name="img" type="text" value="${o.img}" readonly>
                                </div>
                                <button type="button" class="btn btn-primary" onclick="toggleEdit()">Edit Profile</button>
                                <button type="submit" class="btn btn-success" style="display:none;" id="saveButton">Save</button>
                            </form>
                            <c:if test="${not empty success}">
                                <p style="text-align: center; color: greenyellow;">${success}</p>
                            </c:if>
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
                // Hiển thị nút Save khi chuyển sang chế độ edit
                document.getElementById('saveButton').style.display = 'block';
            }
        </script>
        <!-- Nếu có lỗi validate thì tự động chuyển sang trạng thái edit -->
        <c:if test="${not empty errorName or not empty errorDob or not empty errorPhone}">
            <script>
                // Gọi hàm toggleEdit() để mở chế độ chỉnh sửa nếu có lỗi
                toggleEdit();
            </script>
        </c:if>
    </body>
</html>
