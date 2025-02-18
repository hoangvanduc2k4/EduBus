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
                background-color: #fff3e0; /* Nền pastel sáng */
                color: #4a4a4a; /* Màu chữ tối */
            }

            .text_page_head {
                font-size: 18px;
                font-weight: 600;
                color: #ff9800; /* Màu vàng cam cho tiêu đề */
            }

            .text_page {
                font-size: 14px;
                font-weight: 600;
                color: #6d6d6d; /* Màu xám nhẹ cho văn bản */
            }

            .card {
                border: 1px solid #ffcc80; /* Viền màu vàng cam nhạt cho thẻ */
            }

            .btn-success {
                background-color: #ffb74d; /* Màu vàng cam cho nút thêm */
                border-color: #ffb74d; /* Viền cho nút thêm */
            }

            .btn-warning {
                background-color: #ffca28; /* Màu vàng cho nút cập nhật trạng thái */
                border-color: #ffca28; /* Viền cho nút cập nhật trạng thái */
            }

            .modal-content {
                background-color: #fff; /* Nền trắng cho modal */
                border-radius: 8px; /* Bo góc modal */
            }

            .modal-header, .modal-footer {
                border: none; /* Bỏ viền cho header và footer của modal */
            }

            .alert-danger {
                background-color: #ffebee; /* Màu nền pastel cho thông báo lỗi */
                color: #d32f2f; /* Màu chữ cho thông báo lỗi */
            }

            .alert-success {
                background-color: #e8f5e9; /* Màu nền pastel cho thông báo thành công */
                color: #388e3c; /* Màu chữ cho thông báo thành công */
            }

            .table-hover tbody tr:hover {
                background-color: #ffe0b2; /* Màu nền khi hover lên dòng bảng */
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
                        <div class="row">
                            <div class="col-sm-4" style="text-align: center; margin-top: 20px; margin-bottom: 20px;">
                                <h3 class="mb-0" style="color: #ffb74d"><strong>Manage Account</strong></h3>
                            </div>
                            <div class="col-lg-6" style="text-align: center; margin-top: 20px; margin-bottom: 20px;">
                                <form action="manageacc" method="GET" style="display: flex; justify-content: center">
                                    <input type="hidden" name="action" value="search" />
                                    <input name="valueSearch" value="${rs}" id="searchId" type="text" placeholder="Search user name, phone, fullname" style="width: 60%; padding: 4px 10px; border-radius: 15px">
                                    <button type="submit" style="border-radius: 50%; width: 40px; font-size: 18px; margin-left: 10px">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </form>
                            </div>
                        </div>

                        <c:if test="${error != null}">
                            <div style="margin-top: 20px" class="alert alert-danger" role="alert">${error}</div>
                        </c:if>
                        <c:if test="${mess != null}">
                            <div style="margin-top: 20px" class="alert alert-success" role="alert">${mess}</div>
                        </c:if>

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
                    </div>
                </section>
            </div>
        </main>

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
                            <div class="form-group">
                                <label>Username</label>
                                <input name="user" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input name="pass" type="password" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Role</label>
                                <select name="role">
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

            $('#updateStatusModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget); // Button that triggered the modal
                var id = button.data('id');
                var status = button.data('status');

                var modal = $(this);
                modal.find('#updateStatusId').val(id);
                modal.find('#updateStatusSelect').val(status);
            });
        </script>
    </body>
</html>
