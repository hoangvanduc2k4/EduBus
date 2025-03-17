<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Account Management</title>
        <link rel="icon" href="images/logo1.png"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css"/> 
        <style>

            body {
                background-color: #fff3e0;
                color: #4a4a4a;
            }
            .text_page_head {
                font-size: 22px;
                font-weight: 600;
                color: #ff9800;
            }
            .text_page {
                font-size: 14px;
                font-weight: 600;
                color: #6d6d6d;
            }
            .card {
                border: 1px solid #ffcc80;
            }
            .btn-success {
                background-color: #ffb74d;
                border-color: #ffb74d;
            }
            .btn-warning {
                background-color: #ffca28;
                border-color: #ffca28;
            }
            .modal-content {
                background-color: #fff;
                border-radius: 8px;
            }
            .modal-header, .modal-footer {
                border: none;
            }
            .alert-danger {
                background-color: #ffebee;
                color: #d32f2f;
            }
            .alert-success {
                background-color: #e8f5e9;
                color: #388e3c;
            }
            .table-hover tbody tr:hover {
                background-color: #ffe0b2;
            }
            /* Style cho phần filter */
            .filter-form {
                display: flex;
                flex-wrap: wrap;
                align-items: center;
                justify-content: flex-start;
                margin: 15px 0;
            }
            .filter-form .form-group {
                margin-right: 10px;
            }
            /* Style cho phân trang */
            .pagination {
                margin: 20px 0;
                justify-content: center;
            }

            .filter-form .form-group {
                display: flex;
                align-items: center;
                margin: 0;
            }
            .filter-form label {
                margin-right: 10px;
                white-space: nowrap;
            }
            .filter-form input.form-control,
            .filter-form select.form-control {
                border-radius: 4px;
                margin-left: 5px;
            }
            .filter-form .radio-inline {
                display: inline-flex;
                align-items: center;
            }
            .filter-form button {
                margin-left: 5px;
            }
        </style>
    </head>
    <body>
        <c:set var="user" value="${sessionScope.account}" />
        <c:if test="${user != null && user.role != 'Admin'}">
            <c:redirect url="accdn.jsp"/>
        </c:if>
        <jsp:include page="header1.jsp"/>
        <div style="display: block; margin-top: 7%;"></div>

        <main>
            <div class="container pt-4" style="max-width: 1200px; background-color: #FFCF85">
                <section class="mb-4">
                    <div class="card">
                        <!-- Tiêu đề Manage Account ở phần header của card -->
                        <div class="card-header text-center">
                            <h2 class="text_page_head">Manage Account</h2>
                        </div>
                        <!-- Form Filter -->
                        <div class="card-body">
                            <form action="manageacc" method="GET" class="filter-form" id="filterForm">
                                <input type="hidden" name="action" value="search" />

                                <div class="form-group">
                                    <input id="fullname" name="fullname" type="text" class="form-control" placeholder="Full Name" value="${param.fullname}">
                                </div>

                                <div class="form-group">
                                    <select id="role" name="role" class="form-control">
                                        <option value="">-- Select Role --</option>
                                        <option value="Admin" ${param.role eq 'Admin' ? 'selected' : ''}>Admin</option>
                                        <option value="Driver" ${param.role eq 'Driver' ? 'selected' : ''}>Driver</option>
                                        <option value="Parent" ${param.role eq 'Parent' ? 'selected' : ''}>Parent</option>
                                        <option value="Manager" ${param.role eq 'Manager' ? 'selected' : ''}>Manager</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <input id="phone" name="phone" type="text" class="form-control" placeholder="Phone" value="${param.phone}">
                                </div>

                                <div class="form-group">
                                    <div style="display: flex; align-items: center;">
                                        <label class="radio-inline">
                                            <input type="radio" style="margin-right: 20px; margin-left: 40px;"  name="status" value="Active" ${param.status eq 'Active' ? 'checked' : ''}> Active
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" style="margin-right: 20px; margin-left: 40px;" name="status" value="Inactive" ${param.status eq 'Inactive' ? 'checked' : ''}> Inactive
                                        </label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <button type="submit" class="btn btn-warning">Filter</button>
                                </div>

                                <div class="form-group">
                                    <button type="button" class="btn btn-warning" id="resetFilterBtn">Reset</button>
                                </div>
                            </form>
                        </div>
                        <!-- Thông báo lỗi / thành công -->
                        <c:if test="${error != null}">
                            <div style="margin-top: 20px" class="alert alert-danger" role="alert">${error}</div>
                        </c:if>
                        <c:if test="${mess != null}">
                            <div style="margin-top: 20px" class="alert alert-success" role="alert">${mess}</div>
                        </c:if>
                        <!-- Bảng hiển thị dữ liệu -->
                        <div class="card-body" style="padding: 0">
                            <div class="table-responsive">
                                <table class="table table-hover text-nowrap">
                                    <thead>
                                        <tr>
                                            <th class="text_page_head">Full Name</th>
                                            <th class="text_page_head">Avatar</th>
                                            <th class="text_page_head">Username</th>
                                            <th class="text_page_head">Role</th>
                                            <th class="text_page_head">Phone</th>
                                            <th class="text_page_head">Status</th>
                                            <th>
                                                <a style="margin-left: 5px" href="#addAccountModal" class="btn btn-success" data-toggle="modal">
                                                    <i class="fa-solid fa-plus"></i>
                                                </a>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="contentt">
                                        <c:forEach items="${listU}" var="u">
                                            <tr>
                                                <td class="text_page" style="font-weight: 500">${u.name}</td>
                                                <td class="text_page" style="font-weight: 500">
                                                    <img style="width: 70px; height: 70px" src="${u.img}">
                                                </td>
                                                <td class="text_page" style="font-weight: 500">${u.username}</td>
                                                <td class="text_page" style="font-weight: 500">${u.role}</td>
                                                <td class="text_page" style="font-weight: 500">${u.phone}</td>
                                                <td class="text_page" style="font-weight: 500">${u.status}</td>
                                                <td class="text_page" style="padding: 0 12px 16px">
                                                    <!-- Update Status Button -->
                                                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#updateStatusModal" 
                                                            data-id="${u.accid}" 
                                                            data-status="${u.status}">
                                                        <i class="fa-solid fa-pencil" data-toggle="tooltip" title="Update Status"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- Phân trang -->
                        <div class="col-12" style="margin-top: 1%;">
                            <div class="d-md-flex align-items-center justify-content-end">
                                <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="manageacc?action=search&page=${currentPage - 1}&fullname=${fullname}&role=${role}&phone=${phone}&status=${status}&pageSize=${pageSize}" style="color: black;">Trước</a>
                                        </li>
                                    </c:if>
                                    <c:forEach begin="1" end="${totalPages}" var="p">
                                        <li class="page-item ${p == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="manageacc?action=search&page=${p}&fullname=${fullname}&role=${role}&phone=${phone}&status=${status}&pageSize=${pageSize}"style="color: black; ">${p}</a>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="manageacc?action=search&page=${currentPage + 1}&fullname=${fullname}&role=${role}&phone=${phone}&status=${status}&pageSize=${pageSize}" style="color: black; ">Sau</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </main>

        <!-- Modal Add Account -->
        <div id="addAccountModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="form" action="manageacc" method="GET">
                        <input type="hidden" name="action" value="add" />
                        <div class="modal-header">						
                            <h4 class="modal-title">Add Account</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">	
                            <!-- DIV hiển thị lỗi validate, ẩn mặc định -->
                            <div id="addAccountError" class="alert alert-danger" style="display: none;"></div>
                            <div class="form-group">
                                <label>Username</label>
                                <input name="user" type="text" class="form-control" id="username" required>
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input name="pass" type="password" class="form-control" id="password" required>
                            </div>
                            <div class="form-group">
                                <label>Role</label>
                                <select name="role" class="form-control">
                                    <option>Admin</option>
                                    <option>Manager</option>
                                    <option>Driver</option>
                                    <option>Parent</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" value="Add">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal Update Status -->
        <div id="updateStatusModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="updateStatusForm" action="manageacc" method="get">
                        <input type="hidden" name="action" value="update" />
                        <input type="hidden" name="id" id="updateStatusId" />
                        <div class="modal-header">
                            <h4 class="modal-title">Update Status</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Status</label>
                                <select name="status" id="updateStatusSelect" class="form-control">
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" value="Update">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
        <script>
// Hàm kiểm tra username
            function validateUsername(username) {
                if (!username || username.trim() === "") {
                    return "Username không được để trống.";
                }
                var trimmed = username.trim();
                if (trimmed.length < 8) {
                    return "Username phải có ít nhất 8 ký tự.";
                }
                if (trimmed.length > 30) {
                    return "Username chỉ được tối đa 30 ký tự.";
                }
                var firstChar = trimmed.charAt(0);
                if (!isNaN(firstChar)) {
                    return "Ký tự đầu tiên của Username không được là số.";
                }
                var regex = /^[a-zA-Z0-9]+$/;
                if (!regex.test(trimmed)) {
                    return "Username chỉ được chứa chữ hoặc số (không chứa ký tự đặc biệt).";
                }
                return null;
            }

            // Hàm validate Password bằng JavaScript
            function validatePassword(password) {
                if (password.length < 6) {
                    return false;
                }
                var hasUpperCase = false;
                var hasLowerCase = false;
                var hasDigit = false;
                var hasSpecialChar = false;
                for (var i = 0; i < password.length; i++) {
                    var c = password.charAt(i);
                    if (c >= 'A' && c <= 'Z') {
                        hasUpperCase = true;
                    } else if (c >= 'a' && c <= 'z') {
                        hasLowerCase = true;
                    } else if (c >= '0' && c <= '9') {
                        hasDigit = true;
                    } else {
                        hasSpecialChar = true;
                    }
                }
                return hasUpperCase && hasLowerCase && hasDigit && hasSpecialChar;
            }

            $(document).ready(function () {
                $("#form").on("submit", function (e) {
                    var errorMsgDiv = $("#addAccountError");
                    errorMsgDiv.hide().html(""); // Reset lỗi

                    var username = $("#username").val();
                    var password = $("#password").val();

                    // Kiểm tra username trước
                    var usernameError = validateUsername(username);
                    if (usernameError !== null) {
                        errorMsgDiv.html(usernameError).show();
                        e.preventDefault();
                        return;
                    }

                    // Kiểm tra độ dài password
                    if (password.length < 6) {
                        errorMsgDiv.html("Password quá ngắn. Phải có ít nhất 6 ký tự.").show();
                        e.preventDefault();
                        return;
                    }
                    if (password.length > 30) {
                        errorMsgDiv.html("Password quá dài. Không được quá 30 ký tự.").show();
                        e.preventDefault();
                        return;
                    }

                    // Kiểm tra có chữ in hoa
                    if (!/[A-Z]/.test(password)) {
                        errorMsgDiv.html("Password phải chứa ít nhất một chữ in hoa.").show();
                        e.preventDefault();
                        return;
                    }

                    // Kiểm tra có chữ thường
                    if (!/[a-z]/.test(password)) {
                        errorMsgDiv.html("Password phải chứa ít nhất một chữ thường.").show();
                        e.preventDefault();
                        return;
                    }

                    // Kiểm tra có số
                    if (!/[0-9]/.test(password)) {
                        errorMsgDiv.html("Password phải chứa ít nhất một chữ số.").show();
                        e.preventDefault();
                        return;
                    }

                    // Kiểm tra có ký tự đặc biệt
                    if (!/[\W_]/.test(password)) {
                        errorMsgDiv.html("Password phải chứa ít nhất một ký tự đặc biệt.").show();
                        e.preventDefault();
                        return;
                    }
                });
            });

            $(document).ready(function () {
                $("#resetFilterBtn").click(function () {
                    var form = $(".filter-form");

                    // Reset tất cả input text về rỗng
                    form.find("input[type='text']").val('');

                    // Reset select về option đầu tiên
                    form.find("select").prop("selectedIndex", 0);
                });
            });


            // Setup modal update data
            $('#updateStatusModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget);
                var id = button.data('id');
                var status = button.data('status');
                var modal = $(this);
                modal.find('#updateStatusId').val(id);
                modal.find('#updateStatusSelect').val(status);
            });
        </script>
    </body>
</html>
