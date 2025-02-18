<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Statistic</title>
        <link rel="icon" href="images/logo1.png"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #fff8e1; /* Nền trắng ngọc trai */
                font-family: Arial, sans-serif;
            }
            .sidebar {
                position: fixed;
                top: 0;
                bottom: 0;
                left: 0;
                padding: 58px 0 0; /* Chiều cao của navbar */
                width: 240px;
                z-index: 600;
                background-color: #ffb74d; /* Màu vàng pastel cho sidebar */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .sidebar .nav-link {
                color: #4e342e; /* Màu chữ tối cho menu */
                padding: 15px 20px;
                text-decoration: none;
                display: flex;
                align-items: center;
                transition: background-color 0.3s;
            }
            .sidebar .nav-link:hover {
                background-color: #ffd54f; /* Màu vàng nhẹ khi hover */
                border-radius: 5px;
            }
            .card {
                border: none;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s;
                background-color: #ffffff; /* Nền thẻ trắng */
            }
            .card:hover {
                transform: scale(1.02); /* Hiệu ứng phóng to khi hover */
            }
            .card-header {
                background-color: #ffe082 ; /* Màu vàng pastel cho header card */
                color: #5d4037; /* Màu chữ tối cho tiêu đề */
                border-bottom: 1px solid #e0e0e0;
                padding: 15px;
            }
            .card-body {
                padding: 20px;
            }
            h1 {
                margin-top: 20px;
                color: #ff9800; /* Màu tiêu đề h1 nhẹ nhàng hơn */
                text-align: center;
                margin-bottom: 30px;
            }
            h4 {
                color: #ff9800; /* Màu tiêu đề card nhẹ nhàng hơn */
            }
            h2 {
                color: #ff9800; /* Màu dữ liệu nổi bật nhưng nhẹ nhàng hơn */
            }
            .chart-container {
                margin-top: 40px;
            }
        </style>    


    </style>
</head>
<body>
    <c:set var="user" value="${sessionScope.account}" />

    <c:if test="${user != null && user.role != 'Admin'}">
        <c:redirect url="accdn.jsp"/>
    </c:if>
    <main>
        <div class="sidebar">
            <a href="manageacc" class="nav-link"><i class="fas fa-cogs"></i> Account Management</a>
            <a href="manar" class="nav-link"><i class="fas fa-route"></i> Route Management</a>
            <a href="manae" class="nav-link"><i class="fas fa-user-tie"></i> Employee Management</a>
            <a href="manab" class="nav-link"><i class="fas fa-bus"></i> Management Bus</a>
            <a href="logout" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>

        <div class="container pt-1" style="margin-left: 240px;">
            <h1>Statistics</h1> <!-- Thay đổi tiêu đề thành h1 với màu nhẹ nhàng hơn -->
            <div class="row" id="total">
                <div class="col-xl-6 col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header">
                            <h4>Total Parents</h4>
                        </div>
                        <div class="card-body d-flex justify-content-between align-items-center">
                            <i class="fa-solid fa-user-friends" style="color: #ff8f00; font-size: 50px;"></i>
                            <h2 class="mb-0">${num1}</h2>
                        </div>
                    </div>
                </div>

                <div class="col-xl-6 col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header">
                            <h4>Total Students</h4>
                        </div>
                        <div class="card-body d-flex justify-content-between align-items-center">
                            <i class="fa-solid fa-user-graduate" style="color: #ff8f00; font-size: 50px;"></i>
                            <h2 class="mb-0">${num2}</h2>
                        </div>
                    </div>
                </div>

                <div class="col-xl-6 col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header">
                            <h4>Total Drivers</h4>
                        </div>
                        <div class="card-body d-flex justify-content-between align-items-center">
                            <i class="fa-solid fa-bus" style="color: #ff8f00; font-size: 50px;"></i>
                            <h2 class="mb-0">${num3}</h2>
                        </div>
                    </div>
                </div>

                <div class="col-xl-6 col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header">
                            <h4>Total Managers</h4>
                        </div>
                        <div class="card-body d-flex justify-content-between align-items-center">
                            <i class="fa-solid fa-user-tie" style="color: #ff8f00; font-size: 50px;"></i>
                            <h2 class="mb-0">${num4}</h2>
                        </div>
                    </div>
                </div>

                <div class="col-xl-6 col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header">
                            <h4>Total Buses</h4>
                        </div>
                        <div class="card-body d-flex justify-content-between align-items-center">
                            <i class="fa-solid fa-bus" style="color: #ff8f00; font-size: 50px;"></i>
                            <h2 class="mb-0">${num5}</h2>
                        </div>
                    </div>
                </div>

                <div class="col-xl-6 col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header">
                            <h4>Total Stops</h4>
                        </div>
                        <div class="card-body d-flex justify-content-between align-items-center">
                            <i class="fa-solid fa-map-marker-alt" style="color: #ff8f00; font-size: 50px;"></i>
                            <h2 class="mb-0">${num6}</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://mdbootstrap.com/previews/ecommerce-demo/js/bootstrap.js"></script>
    <script src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.min.js"></script>
</body>
</html>
