<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Parent Information</title>
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
            #errorMessages p, #formErrorMessages p {
                margin-bottom: 5px;
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
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
                    </c:if>

                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success">${successMessage}</div>
                    </c:if>

                    <div id="errorMessages" class="alert alert-danger mt-2" style="display: none;"></div>
                    <form id="searchForm" class="mb-4" action="parentinfo" method="GET">
                        <div class="form-row">
                            <div class="col-md-2">
                                <input type="text" id="searchFullName" name="name" class="form-control" placeholder="Search Full Name" value="${name}">
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="searchEmail" name="email" class="form-control" placeholder="Search Email" value="${email}">
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="searchPhone" name="phone" class="form-control" placeholder="Search Phone" value="${phone}">
                            </div>
                            <div class="col-md-2">
                                <input type="date" id="searchDOB" name="dob" class="form-control" placeholder="Search Date of Birth" value="${dob}">
                            </div>
                            <div class="col-md-2">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" name="gender" type="radio" id="genderMale" value="Male" <c:if test="${gender == 'Male'}">checked</c:if>>
                                        <label class="form-check-label" for="genderMale">Male</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" name="gender" type="radio" id="genderFemale" value="Female" <c:if test="${gender == 'Female'}">checked</c:if>>
                                        <label class="form-check-label" for="genderFemale">Female</label>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <select id="searchRole" name="role" class="form-control">
                                        <option value="">All Roles</option>
                                    <c:forEach var="r" items="${listR}">
                                        <option value="${r}" <c:if test="${r == role}">selected</c:if>>${r}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-row mt-2">
                            <div class="col">
                                <button type="submit" class="btn btn-primary">Search</button>
                            </div>
                            <div class="col">
                                <button type="button" class="btn btn-primary" onclick="window.location.href = 'parentinfo'">All Parent</button>                           
                            </div>
                        </div>
                    </form>

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
                                            <th class="text_page_head">Email</th>
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
                                    <tbody>
                                        <c:forEach items="${listP}" var="p">
                                            <tr>
                                                <td class="text_page" style="font-weight: 500">${p.name}</td>
                                                <td class="text_page" style="font-weight: 500">
                                                    <img style="width: 70px; height: 70px" src="${p.img}" alt="Avatar">
                                                </td>
                                                <td class="text_page" style="font-weight: 500">${p.email}</td>
                                                <td class="text_page" style="font-weight: 500">${p.phone}</td>
                                                <td class="text_page" style="font-weight: 500">${p.gender}</td>
                                                <td class="text_page" style="font-weight: 500">${p.dob}</td>
                                                <td class="text_page" style="font-weight: 500">${p.role}</td>
                                                <td class="text_page" style="padding: 0 12px 16px">
                                                    <button type="button" class="btn btn-info" data-toggle="modal" data-target="#updateParentModal" 
                                                            data-id="${p.pid}" data-name="${p.name}" data-email="${p.email}" data-phone="${p.phone}" 
                                                            data-gender="${p.gender}" data-dob="${p.dob}" data-role="${p.role}">
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

            <div class="row mt-3">
                <div class="col-md-12">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="parentinfo?page=${currentPage - 1}&pageSize=${pageSize}&name=${name}&email=${email}&phone=${phone}&dob=${dob}&gender=${gender}&role=${role}" aria-label="Previous">
                                        Trước
                                    </a>
                                </li>
                            </c:if>
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="parentinfo?page=${i}&pageSize=${pageSize}&name=${name}&email=${email}&phone=${phone}&dob=${dob}&gender=${gender}&role=${role}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="parentinfo?page=${currentPage + 1}&pageSize=${pageSize}&name=${name}&email=${email}&phone=${phone}&dob=${dob}&gender=${gender}&role=${role}" aria-label="Next">
                                        Sau
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </main>

        <div id="addParentModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">

                    <c:if test="${not empty errorMessage}">
                        <div id="errorAdd" class="alert alert-danger">${errorMessage}</div>
                    </c:if>
                    <form id="form" action="parentinfo" method="post">

                        <!-- Hidden fields lưu các tham số phân trang và search hiện tại -->
                        <input type="hidden" name="page" value="${currentPage}" />
                        <input type="hidden" name="pageSize" value="${pageSize}" />
                        <input type="hidden" name="searchName" value="${name}" />
                        <input type="hidden" name="searchEmail" value="${email}" />
                        <input type="hidden" name="searchPhone" value="${phone}" />
                        <input type="hidden" name="searchDob" value="${dob}" />
                        <input type="hidden" name="searchGender" value="${gender}" />
                        <input type="hidden" name="searchRole" value="${role}" />

                        <input type="hidden" name="action" value="add" />
                        <div class="modal-header">
                            <h4 class="modal-title">Add Member</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        </div>
                        <div class="modal-body">
                            <div id="formErrorMessages" class="alert alert-danger" style="display: none;"></div>
                            <div class="form-group">
                                <label>Full Name</label>
                                <input name="name" type="text" class="form-control" required value="${modalToOpen == 'add' ? name : ''}">
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input name="email" type="text" class="form-control" required value="${modalToOpen == 'add' ? email : ''}">
                            </div>
                            <div class="form-group">
                                <label>Phone:</label>
                                <input name="phone" type="text" class="form-control" required value="${modalToOpen == 'add' ? phone : ''}">
                            </div>
                            <div class="form-group">
                                <label>Gender</label>
                                <select name="gender" class="form-control">
                                    <option value="Male" <c:if test="${modalToOpen == 'add' and gender == 'Male'}">selected</c:if>>Male</option>
                                    <option value="Female" <c:if test="${modalToOpen == 'add' and gender == 'Female'}">selected</c:if>>Female</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Date of birth:</label>
                                    <input name="dob" type="date" class="form-control" required value="${modalToOpen == 'add' ? dob : ''}">
                            </div>
                            <div class="form-group">
                                <label>Role in Family:</label>
                                <input name="role" type="text" class="form-control" required value="${modalToOpen == 'add' ? role : ''}">
                            </div>
                            <div class="form-group">
                                <label>Image(URL):</label>
                                <input id="updateImg" name="img" type="text" class="form-control" value="${modalToOpen == 'add' ? img : ''}">
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

        <div id="updateParentModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="parentinfo" method="post">
                        <input type="hidden" name="action" value="update" />
                        <div class="modal-header">
                            <h4 class="modal-title">Update Member</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" id="updateId" name="id" />
                            <div class="form-group">
                                <label>Full Name</label>
                                <input id="updateName" name="name" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input id="updateEmail" name="email" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Phone</label>
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
                            <input type="submit" class="btn btn-info" value="Save">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>

        <script>
            $('#updateParentModal').on('show.bs.modal', function (event) {
                if (event.relatedTarget) {
                    var button = $(event.relatedTarget);
                    var id = button.data('id');
                    var name = button.data('name');
                    var email = button.data('email');
                    var phone = button.data('phone');
                    var gender = button.data('gender');
                    var dob = button.data('dob');
                    var role = button.data('role');
                    var img = button.closest('tr').find('img').attr('src');

                    var modal = $(this);
                    modal.find('#updateId').val(id);
                    modal.find('#updateName').val(name);
                    modal.find('#updateEmail').val(email);
                    modal.find('#updatePhone').val(phone);
                    modal.find('#updateGender').val(gender);
                    modal.find('#updateDOB').val(dob);
                    modal.find('#updateRole').val(role);
                    modal.find('#updateImg').val(img);
                }
            });

            $(document).ready(function () {
                var modalToOpen = "${modalToOpen}";
                if (modalToOpen === "update") {
                    $('#updateParentModal').modal('show');
                } else if (modalToOpen === "add") {
                    $('#addParentModal').modal('show');
                }
            });

            $("#searchForm").on("submit", function (e) {
                e.preventDefault();
                e.stopImmediatePropagation();

                var isValid = true;
                var errorMsg = "";
                var $errorDiv = $("#errorMessages");

                $errorDiv.hide().empty();

                var searchFullNameOrig = $("#searchFullName").val();
                var searchFullName = $.trim(searchFullNameOrig);
                var searchEmailOrig = $("#searchEmail").val();
                var searchEmail = $.trim(searchEmailOrig);
                var searchPhoneOrig = $("#searchPhone").val();
                var searchPhone = $.trim(searchPhoneOrig);
                var searchDOB = $.trim($("#searchDOB").val());

                if (searchFullNameOrig.length > 0 && searchFullName === "") {
                    isValid = false;
                    errorMsg += "<p>Search Full Name không được nhập toàn dấu cách.</p>";
                    $("#searchFullName").val("");
                }
                if (searchEmailOrig.length > 0 && searchEmail === "") {
                    isValid = false;
                    errorMsg += "<p>Search Email không được nhập toàn dấu cách.</p>";
                    $("#searchEmail").val("");
                }
                if (searchPhoneOrig.length > 0 && searchPhone === "") {
                    isValid = false;
                    errorMsg += "<p>Search Phone không được nhập toàn dấu cách.</p>";
                    $("#searchPhone").val("");
                }

                if (searchFullName !== "") {
                    var nameRegex = /^[A-Za-z]+(?: [A-Za-z]+)*$/;
                    if (!nameRegex.test(searchFullName)) {
                        isValid = false;
                        errorMsg += "<p>Search Full Name chỉ được chứa chữ cái, không nhập số hay ký tự đặc biệt và chỉ được phép có 1 dấu cách giữa các từ.</p>";
                        $("#searchFullName").val("");
                    }
                }

                if (searchEmail !== "") {
                    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailRegex.test(searchEmail)) {
                        isValid = false;
                        errorMsg += "<p>Search Email phải đúng định dạng email.</p>";
                        $("#searchEmail").val("");
                    }
                }

                if (searchPhone !== "") {
                    var phoneRegex = /^[0-9]{1,10}$/;
                    if (!phoneRegex.test(searchPhone)) {
                        isValid = false;
                        errorMsg += "<p>Search Phone chỉ được nhập tối đa 10 chữ số, không chứa ký tự hay khoảng trắng.</p>";
                        $("#searchPhone").val("");
                    }
                }

                if (searchDOB !== "") {
                    var inputDate = new Date(searchDOB);
                    var today = new Date();
                    today.setHours(0, 0, 0, 0);
                    if (inputDate > today) {
                        isValid = false;
                        errorMsg += "<p>Search Date of Birth không được nhập ngày trong tương lai.</p>";
                        $("#searchDOB").val("");
                    }
                }

                if (!isValid) {
                    $errorDiv.html(errorMsg).show();
                    return false;
                }

                this.submit();
            });

        </script>



    </body>
</html>