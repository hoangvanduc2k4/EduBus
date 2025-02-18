<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông tin học sinh</title>
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
            <div class="container pt-4" style="max-width: 1200px; background-color: #FFE1B0">
                <section class="mb-4">
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
                                            <th class="text_page_head">Class</th>
                                            <th class="text_page_head">Gender</th>
                                            <th class="text_page_head">Stop</th>
                                            <th class="text_page_head">Date of Birth</th>
                                            <th>
                                                <a style="margin-left: 5px; " href="#addStudentModal" class="btn btn-success" data-toggle="modal">
                                                    <i class="fa-solid fa-plus"></i>
                                                </a>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="contentt">
                                        <c:forEach items="${listS}" var="s">
                                            <tr>
                                                <td class="text_page" style="font-weight: 500">${s.name}</td>
                                                <td class="text_page" style="font-weight: 500"><img style="width: 70px; height: 70px" src="${s.img}"></td>
                                                <td class="text_page" style="font-weight: 500">${s.classes}</td>
                                                <td class="text_page" style="font-weight: 500">${s.gender}</td>
                                                <td class="text_page" style="font-weight: 500">${s.stopname}</td>
                                                <td class="text_page" style="font-weight: 500">${s.dob}</td>
                                                <td class="text_page" style="padding: 0 12px 16px">
                                                    <button style="margin-top: 10px" type="button" class="btn btn-info" data-toggle="modal" 
                                                            data-target="#updateStudentModal" 
                                                            data-id="${s.sid}" 
                                                            data-name="${s.name}" 
                                                            data-gender="${s.gender}" 
                                                            data-dob="${s.dob}" 
                                                            data-class="${s.classes}" 
                                                            >
                                                        <i class="fa-solid fa-pen" data-toggle="tooltip" title="Update"></i>
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

        <!-- Add Student Modal -->
        <div id="addStudentModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="form" action="student" method="post">
                        <input type="hidden" name="action" value="add" />
                        <div class="modal-header">
                            <h4 class="modal-title">Add Student</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Full Name</label>
                                <input name="name" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Gender</label>
                                <select name="gender" class="form-control" required>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Date Of Birth</label>
                                <input name="dob" type="date" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Classes</label>
                                <input name="classes" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Avatar(URL)</label>
                                <input name="img" type="text" class="form-control">
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

        <!-- Update Student Modal -->
        <div id="updateStudentModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="updateForm" action="student" method="post">
                        <input type="hidden" name="action" value="update" />
                        <input type="hidden" name="id" id="updateId" />
                        <div class="modal-header">
                            <h4 class="modal-title">Update Student</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Full Name</label>
                                <input id="updateName" name="name" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Gender</label>
                                <select id="updateGender" name="gender" class="form-control" required>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Date of Birth</label>
                                <input id="updateDOB" name="dob" type="date" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Classes</label>
                                <input id="updateClass" name="classes" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Image(URL)</label>
                                <input id="updateImage" name="img" type="text" class="form-control">
                            </div>

                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                            <input type="submit" class="btn btn-success" value="Cập nhật">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
        <script>
            function confirmDeleteAndSubmit(button) {
                if (confirm("Bạn có chắc chắn muốn xóa học sinh này?")) {
                    button.closest('form').submit();
                }
            }

            $('#updateStudentModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget);
                var id = button.data('id');
                var name = button.data('name');
                var gender = button.data('gender');
                var dob = button.data('dob');
                var className = button.data('class');

                var modal = $(this);
                modal.find('#updateId').val(id);
                modal.find('#updateName').val(name);
                modal.find('#updateGender').val(gender);
                modal.find('#updateDOB').val(dob);
                modal.find('#updateClass').val(className);

            });
        </script>
    </body>
</html>