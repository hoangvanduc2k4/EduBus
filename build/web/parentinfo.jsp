<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông tin phụ huynh</title>
        <link rel="icon" href="images/logo1.png"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <style>
            body {
                background-color: #fbfbfb;
            }
            .text_page_head {
                font-size: 18px;
                font-weight: 600;
            }
            .text_page {
                font-size: 14px;
                font-weight: 600;
            }
        </style>
    </head>

    <body>
        <c:set var="user" value="${sessionScope.account}" />

        <c:if test="${user != null && user.role != 'Parent'}">
            <c:redirect url="accdn.jsp"/>
        </c:if>
        <jsp:include page="header1.jsp"/>
        <div style="display: block; margin-top: 7%;"></div>

        <main>
            <div class="container pt-4" style="max-width: 1200px">
                <section class="mb-4">
                       <a href="changepass.jsp" class="btn btn-warning change-pass-btn">
                                                    <i class="fa-solid fa-key"></i> Change Pass
                                                </a>
                    <div class="card">
                      
                        <c:if test="${error != null}">
                            <div style="margin-top: 20px" class="alert alert-danger" role="alert">${error}</div>
                        </c:if>
                        <c:if test="${mess != null}">
                            <div style="margin-top: 20px" class="alert alert-success" role="alert">${mess}</div>
                        </c:if>

                        <div class="card-body" style="padding: 0">

                            <div class="table-responsive">

                                <table class="table table-hover text-nowrap" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th class="text_page_head">Full Name</th>
                                            <th class="text_page_head">Avatar</th>
                                            <th class="text_page_head">Email </th>
                                            <th class="text_page_head">Phone</th>
                                            <th class="text_page_head">Gender</th>
                                            <th class="text_page_head">Date of Birth</th>
                                            <th class="text_page_head">Role</th>
                                            <th>

                                                <a style="margin-left: 5px" href="#addParentModal" class="btn btn-success" data-toggle="modal">
                                                    <i class="fa-solid fa-plus"></i>
                                                </a>

                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="contentt">
                                        <c:forEach items="${listP}" var="p">
                                            <tr>
                                                <td class="text_page" style="font-weight: 500">${p.name}</td>
                                                <td class="text_page" style="font-weight: 500"><img style="width: 70px; height: 70px" src="${p.img}" alt="Avatar"></td>
                                                <td class="text_page" style="font-weight: 500">${p.email}</td>
                                                <td class="text_page" style="font-weight: 500">${p.phone}</td>
                                                <td class="text_page" style="font-weight: 500">${p.gender}</td>
                                                <td class="text_page" style="font-weight: 500">${p.dob}</td>
                                                <td class="text_page" style="font-weight: 500">${p.role}</td>
                                                <td class="text_page" style="padding: 0 12px 16px">

                                                    <button type="button" class="btn btn-info" data-toggle="modal" data-target="#updateParentModal" 
                                                            data-id="${p.pid}" 
                                                            data-name="${p.name}" 
                                                            data-email="${p.email}" 
                                                            data-phone="${p.phone}" 
                                                            data-gender="${p.gender}" 
                                                            data-dob="${p.dob}" 
                                                            data-role="${p.role}">
                                                        <i class="fa-solid fa-pen" data-toggle="tooltip" title="Cập nhật"></i>
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

        <!-- Add Parent Modal -->
        <div id="addParentModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="form" action="parentinfo" method="post">
                        <input type="hidden" name="action" value="add" />
                        <div class="modal-header">
                            <h4 class="modal-title">Add Member</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Full Name</label>
                                <input name="name" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input name="email" type="email" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Phone:</label>
                                <input name="phone" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Gender</label>
                                <select name="gender" class="form-control">
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Date of birth:</label>
                                <input name="dob" type="date" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Role in Family:</label>
                                <input name="role" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Image(URL):</label>
                                <input id="updateImg" name="img" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" value="ADD">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Update Parent Modal -->
        <div id="updateParentModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="updateForm" action="parentinfo" method="post">
                        <input type="hidden" name="action" value="update" />
                        <input type="hidden" name="id" id="updateId" />
                        <div class="modal-header">
                            <h4 class="modal-title">Update Member</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Full Name</label>
                                <input id="updateName" name="name" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input id="updateEmail" name="email" type="email" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Phone:</label>
                                <input id="updatePhone" name="phone" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Gender</label>
                                <select id="updateGender" name="gender" class="form-control">
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Date of birth:</label>
                                <input id="updateDOB" name="dob" type="date" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Role in Family:</label>
                                <input id="updateRole" name="role" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Image(URL):</label>
                                <input id="updateImg" name="img" type="text" class="form-control">
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

            // Populate update form with existing data
            $('#updateParentModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget); // Button that triggered the modal
                var id = button.data('id');
                var name = button.data('name');
                var email = button.data('email');
                var phone = button.data('phone');
                var gender = button.data('gender');
                var dob = button.data('dob');
                var role = button.data('role');
                var img = button.find('img').attr('src'); // Lấy URL hình ảnh

                // Update the modal's content
                var modal = $(this);
                modal.find('#updateId').val(id);
                modal.find('#updateName').val(name);
                modal.find('#updateEmail').val(email);
                modal.find('#updatePhone').val(phone);
                modal.find('#updateGender').val(gender);
                modal.find('#updateDOB').val(dob);
                modal.find('#updateRole').val(role);
                modal.find('#updateImg').val(img); // Điền URL hình ảnh vào input

            });
        </script>
    </body>
</html>