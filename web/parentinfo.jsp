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

                    <form id="searchForm" class="mb-4">
                        <div class="form-row">
                            <div class="col-md-2">
                                <input type="text" id="searchFullName" class="form-control" placeholder="Search Full Name">
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="searchEmail" class="form-control" placeholder="Search Email">
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="searchPhone" class="form-control" placeholder="Search Phone">
                            </div>
                            <div class="col-md-2">
                                <input type="date" id="searchDOB" class="form-control" placeholder="Search Date of Birth">
                            </div>
                            <div class="col-md-2">
                                <!-- Checkbox cho Gender -->
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" name="gender" type="radio" id="genderMale" value="Male">
                                    <label class="form-check-label" for="genderMale">Male</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" name="gender" type="radio" id="genderFemale" value="Female">
                                    <label class="form-check-label" for="genderFemale">Female</label>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <select id="searchRole" class="form-control">
                                    <option value="">All Roles</option>
                                    <c:forEach var="role" items="${listR}">
                                        <option value="${role}">${role}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2" id="customRoleDiv" style="display: none;">
                                <input type="text" id="customRole" class="form-control" placeholder="Enter custom role">
                            </div>

                        </div>
                        <div class="form-row mt-2">
                            <div class="col">
                                <button type="submit" class="btn btn-primary">Search</button>
                            </div>
                            <div class="col">
                                <button class="btn btn-primary" onclick="window.location.href = 'parentinfo'">
                                    All Parent
                                </button>                           
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
                                    <tbody id="contentt">
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

            <!-- Phân trang -->
            <div class="row mt-3">
                <div class="col-md-12">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <!-- Nút Previous -->
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="parentinfo?page=${currentPage - 1}&pageSize=${pageSize}
                                       &name=${name}&email=${email}&phone=${phone}&dob=${dob}&gender=${gender}&role=${role}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                        Trước
                                    </a>
                                </li>
                            </c:if>
                            <!-- Số trang -->
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="parentinfo?page=${i}&pageSize=${pageSize}
                                       &name=${name}&email=${email}&phone=${phone}&dob=${dob}&gender=${gender}&role=${role}">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>
                            <!-- Nút Next -->
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="parentinfo?page=${currentPage + 1}&pageSize=${pageSize}
                                       &name=${name}&email=${email}&phone=${phone}&dob=${dob}&gender=${gender}&role=${role}" aria-label="Next">
                                        Sau
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
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
                                <input name="name" type="text" class="form-control" required
                                       value="${modalToOpen == 'add' ? name : ''}">
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input name="email" type="text" class="form-control" required
                                       value="${modalToOpen == 'add' ? email : ''}">
                            </div>
                            <div class="form-group">
                                <label>Phone:</label>
                                <input name="phone" type="text" class="form-control" required
                                       value="${modalToOpen == 'add' ? phone : ''}">
                            </div>
                            <div class="form-group">
                                <label>Gender</label>
                                <select name="gender" class="form-control">
                                    <option value="Male" ${modalToOpen == 'add' and gender == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${modalToOpen == 'add' and gender == 'Female' ? 'selected' : ''}>Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Date of birth:</label>
                                <input name="dob" type="date" class="form-control" required
                                       value="${modalToOpen == 'add' ? dob : ''}">
                            </div>
                            <div class="form-group">
                                <label>Role in Family:</label>
                                <input name="role" type="text" class="form-control" required
                                       value="${modalToOpen == 'add' ? role : ''}">
                            </div>
                            <div class="form-group">
                                <label>Image(URL):</label>
                                <input id="updateImg" name="img" type="text" class="form-control"
                                       value="${modalToOpen == 'add' ? img : ''}">
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
                        <input type="hidden" name="id" id="updateId" value="${updateId != null ? updateId : ''}"/>
                        <div class="modal-header">
                            <h4 class="modal-title">Update Member</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <!-- Các trường nhập liệu cho update member -->
                            <div class="form-group">
                                <label>Full Name</label>
                                <input id="updateName" name="name" type="text" class="form-control" required
                                       value="${name != null ? name : ''}">
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input id="updateEmail" name="email" type="text" class="form-control" required
                                       value="${email != null ? email : ''}">
                            </div>
                            <div class="form-group">
                                <label>Phone:</label>
                                <input id="updatePhone" name="phone" type="text" class="form-control" required
                                       value="${phone != null ? phone : ''}">
                            </div>
                            <div class="form-group">
                                <label>Gender</label>
                                <select id="updateGender" name="gender" class="form-control">
                                    <option value="Male" ${gender == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${gender == 'Female' ? 'selected' : ''}>Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Date of birth:</label>
                                <input id="updateDOB" name="dob" type="date" class="form-control" required
                                       value="${dob != null ? dob : ''}">
                            </div>
                            <div class="form-group">
                                <label>Role in Family:</label>
                                <input id="updateRole" name="role" type="text" class="form-control" required
                                       value="${role != null ? role : ''}">
                            </div>
                            <div class="form-group">
                                <label>Image(URL):</label>
                                <input id="updateImg" name="img" type="text" class="form-control"
                                       value="${img != null ? img : ''}">
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
            // Xử lý modal cập nhật (update)
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
                    var img = button.find('img').attr('src'); // Lấy URL hình ảnh

                    // Cập nhật nội dung modal
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
                // Hiển thị modal theo yêu cầu
                var modalToOpen = "${modalToOpen}";
                if (modalToOpen === "update") {
                    $('#updateParentModal').modal('show');
                } else if (modalToOpen === "add") {
                    $('#addParentModal').modal('show');
                }

                // Xử lý tìm kiếm khi submit form
                $("#searchForm").on("submit", function (e) {
                    e.preventDefault();
                    var searchFullName = $("#searchFullName").val().toLowerCase();
                    var searchEmail = $("#searchEmail").val().toLowerCase();
                    var searchPhone = $("#searchPhone").val().toLowerCase();
                    var searchDOB = $("#searchDOB").val().toLowerCase();

                    // Lấy các checkbox đã được chọn
                    var selectedGender = [];
                    if ($("#genderMale").is(":checked")) {
                        selectedGender.push("male");
                    }
                    if ($("#genderFemale").is(":checked")) {
                        selectedGender.push("female");
                    }

                    // Lấy giá trị role (nếu chưa chọn thì là "")
                    var searchRole = $("#searchRole").val().toLowerCase();

                    $("#contentt tr").filter(function () {
                        var fullName = $(this).find("td").eq(0).text().toLowerCase();
                        var email = $(this).find("td").eq(2).text().toLowerCase();
                        var phone = $(this).find("td").eq(3).text().toLowerCase();
                        var gender = $(this).find("td").eq(4).text().toLowerCase();
                        var dob = $(this).find("td").eq(5).text().toLowerCase();
                        var role = $(this).find("td").eq(6).text().toLowerCase();

                        // Kiểm tra nếu có lựa chọn checkbox, thì gender của dòng phải khớp với một trong các giá trị đã chọn
                        var genderMatch = selectedGender.length === 0 || selectedGender.indexOf(gender) > -1;

                        // Nếu role đã chọn (khác rỗng) thì phải khớp
                        var roleMatch = searchRole === "" || role === searchRole;

                        return fullName.indexOf(searchFullName) > -1 &&
                                email.indexOf(searchEmail) > -1 &&
                                phone.indexOf(searchPhone) > -1 &&
                                dob.indexOf(searchDOB) > -1 &&
                                genderMatch &&
                                roleMatch;
                    }).show().end().filter(function () {
                        // Ẩn những dòng không khớp
                        var fullName = $(this).find("td").eq(0).text().toLowerCase();
                        var email = $(this).find("td").eq(2).text().toLowerCase();
                        var phone = $(this).find("td").eq(3).text().toLowerCase();
                        var gender = $(this).find("td").eq(4).text().toLowerCase();
                        var dob = $(this).find("td").eq(5).text().toLowerCase();
                        var role = $(this).find("td").eq(6).text().toLowerCase();

                        var genderMatch = selectedGender.length === 0 || selectedGender.indexOf(gender) > -1;
                        var roleMatch = searchRole === "" || role === searchRole;

                        return !(fullName.indexOf(searchFullName) > -1 &&
                                email.indexOf(searchEmail) > -1 &&
                                phone.indexOf(searchPhone) > -1 &&
                                dob.indexOf(searchDOB) > -1 &&
                                genderMatch &&
                                roleMatch);
                    }).hide();
                });
            });
        </script>
        <script>
            $("#searchForm").on("submit", function (e) {
                // Ngăn không cho submit form theo mặc định và ngăn chặn các xử lý sự kiện sau nếu lỗi xảy ra
                e.preventDefault();
                e.stopImmediatePropagation();

                var isValid = true;
                var errorMsg = "";

                // Lấy giá trị ban đầu và giá trị đã trim cho các trường
                var searchFullNameOrig = $("#searchFullName").val();
                var searchFullName = $.trim(searchFullNameOrig);

                var searchEmailOrig = $("#searchEmail").val();
                var searchEmail = $.trim(searchEmailOrig);

                var searchPhoneOrig = $("#searchPhone").val();
                var searchPhone = $.trim(searchPhoneOrig);

                var searchDOB = $.trim($("#searchDOB").val());

                // Kiểm tra nếu nhập toàn khoảng trắng cho các trường (với điều kiện ban đầu có ký tự nhưng sau trim bằng rỗng)
                if (searchFullNameOrig.length > 0 && searchFullName === "") {
                    isValid = false;
                    errorMsg += "Search Full Name không được nhập toàn dấu cách.\n";
                    $("#searchFullName").val(""); // xóa giá trị sai
                }
                if (searchEmailOrig.length > 0 && searchEmail === "") {
                    isValid = false;
                    errorMsg += "Search Email không được nhập toàn dấu cách.\n";
                    $("#searchEmail").val("");
                }
                if (searchPhoneOrig.length > 0 && searchPhone === "") {
                    isValid = false;
                    errorMsg += "Search Phone không được nhập toàn dấu cách.\n";
                    $("#searchPhone").val("");
                }

                // Validate Search Full Name (nếu không rỗng)
                if (searchFullName !== "") {
                    // Chỉ cho phép chữ cái và dấu cách (giữa các từ chỉ có 1 dấu cách)
                    var nameRegex = /^[A-Za-z]+(?: [A-Za-z]+)*$/;
                    if (!nameRegex.test(searchFullName)) {
                        isValid = false;
                        errorMsg += "Search Full Name chỉ được chứa chữ cái, không nhập số hay ký tự đặc biệt và chỉ được phép có 1 dấu cách giữa các từ.\n";
                        $("#searchFullName").val("");
                    }
                }

                // Validate Search Email (nếu không rỗng)
                if (searchEmail !== "") {
                    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailRegex.test(searchEmail)) {
                        isValid = false;
                        errorMsg += "Search Email phải đúng định dạng email.\n";
                        $("#searchEmail").val("");
                    }
                }

                // Validate Search Phone (nếu không rỗng)
                if (searchPhone !== "") {
                    // Chỉ cho phép số (tối đa 10 chữ số, không chứa ký tự hay khoảng trắng)
                    var phoneRegex = /^[0-9]{1,10}$/;
                    if (!phoneRegex.test(searchPhone)) {
                        isValid = false;
                        errorMsg += "Search Phone chỉ được nhập tối đa 10 chữ số, không chứa ký tự hay khoảng trắng.\n";
                        $("#searchPhone").val("");
                    }
                }

                // Validate Search Date (nếu không rỗng)
                if (searchDOB !== "") {
                    var inputDate = new Date(searchDOB);
                    var today = new Date();
                    today.setHours(0, 0, 0, 0);
                    if (inputDate > today) {
                        isValid = false;
                        errorMsg += "Search Date of Birth không được nhập ngày trong tương lai.\n";
                        $("#searchDOB").val("");
                    }
                }

                // Nếu có lỗi thì thông báo và dừng xử lý, không thực hiện filter
                if (!isValid) {
                    alert(errorMsg);
                    return false;
                }

                // Nếu hợp lệ, chuyển các giá trị đã trim sang lowercase để filter
                searchFullName = searchFullName.toLowerCase();
                searchEmail = searchEmail.toLowerCase();
                searchPhone = searchPhone.toLowerCase();
                searchDOB = searchDOB.toLowerCase();

                var selectedGender = [];
                if ($("#genderMale").is(":checked")) {
                    selectedGender.push("male");
                }
                if ($("#genderFemale").is(":checked")) {
                    selectedGender.push("female");
                }

                var searchRole = $("#searchRole").val().toLowerCase();

                // Thực hiện filter trên bảng
                $("#contentt tr").filter(function () {
                    var fullName = $(this).find("td").eq(0).text().toLowerCase();
                    var email = $(this).find("td").eq(2).text().toLowerCase();
                    var phone = $(this).find("td").eq(3).text().toLowerCase();
                    var gender = $(this).find("td").eq(4).text().toLowerCase();
                    var dob = $(this).find("td").eq(5).text().toLowerCase();
                    var role = $(this).find("td").eq(6).text().toLowerCase();

                    var genderMatch = selectedGender.length === 0 || selectedGender.indexOf(gender) > -1;
                    var roleMatch = searchRole === "" || role === searchRole;

                    return fullName.indexOf(searchFullName) > -1 &&
                            email.indexOf(searchEmail) > -1 &&
                            phone.indexOf(searchPhone) > -1 &&
                            dob.indexOf(searchDOB) > -1 &&
                            genderMatch &&
                            roleMatch;
                }).show().end().filter(function () {
                    var fullName = $(this).find("td").eq(0).text().toLowerCase();
                    var email = $(this).find("td").eq(2).text().toLowerCase();
                    var phone = $(this).find("td").eq(3).text().toLowerCase();
                    var gender = $(this).find("td").eq(4).text().toLowerCase();
                    var dob = $(this).find("td").eq(5).text().toLowerCase();
                    var role = $(this).find("td").eq(6).text().toLowerCase();

                    var genderMatch = selectedGender.length === 0 || selectedGender.indexOf(gender) > -1;
                    var roleMatch = searchRole === "" || role === searchRole;

                    return !(fullName.indexOf(searchFullName) > -1 &&
                            email.indexOf(searchEmail) > -1 &&
                            phone.indexOf(searchPhone) > -1 &&
                            dob.indexOf(searchDOB) > -1 &&
                            genderMatch &&
                            roleMatch);
                }).hide();
            });

            // Sự kiện blur để validate ngay khi rời khỏi ô (tùy chọn)
            $("#searchFullName").on("blur", function () {
                var valOrig = $(this).val();
                var val = $.trim(valOrig);
                if (valOrig.length > 0 && val === "") {
                    alert("Search Full Name không được nhập toàn dấu cách.");
                    $(this).val("");
                }
            });

            $("#searchEmail").on("blur", function () {
                var valOrig = $(this).val();
                var val = $.trim(valOrig);
                if (valOrig.length > 0 && val === "") {
                    alert("Search Email không được nhập toàn dấu cách.");
                    $(this).val("");
                }
            });

            $("#searchPhone").on("blur", function () {
                var valOrig = $(this).val();
                var val = $.trim(valOrig);
                if (valOrig.length > 0 && val === "") {
                    alert("Search Phone không được nhập toàn dấu cách.");
                    $(this).val("");
                }
            });

            $("#searchDOB").on("blur", function () {
                var val = $.trim($(this).val());
                if (val !== "") {
                    var inputDate = new Date(val);
                    var today = new Date();
                    today.setHours(0, 0, 0, 0);
                    if (inputDate > today) {
                        alert("Search Date of Birth không được nhập ngày trong tương lai.");
                        $(this).val("");
                    }
                }
            });

            $(document).ready(function () {
                $("#searchRole").change(function () {
                    if ($(this).val() === "custom") {
                        $("#customRoleDiv").show();
                    } else {
                        $("#customRoleDiv").hide();
                    }
                });
            });

            document.getElementById("form").addEventListener("submit", function (event) {
                let name = document.querySelector("input[name='name']").value.trim();
                let phone = document.querySelector("input[name='phone']").value.trim();

                let nameRegex = /^[A-Za-zÀ-Ỹà-ỹ]+(?: [A-Za-zÀ-Ỹà-ỹ]+)*$/;
                let phoneRegex = /^[0-9]{10}$/;

                // Validate Full Name
                if (!name || !nameRegex.test(name)) {
                    alert("Full Name không hợp lệ! Chỉ chứa chữ cái, mỗi từ cách nhau một dấu cách.");
                    event.preventDefault();
                    return;
                }

                // Validate Phone
                if (!phone || !phoneRegex.test(phone)) {
                    alert("Số điện thoại không hợp lệ! Nhập đúng 10 chữ số, không chứa ký tự đặc biệt.");
                    event.preventDefault();
                    return;
                }
            });

            document.getElementById("form").addEventListener("submit", function (event) {
                let name = document.querySelector("input[name='name']").value.trim();
                let phone = document.querySelector("input[name='phone']").value.trim();

                let nameRegex = /^[A-Za-zÀ-Ỹà-ỹ]+(?: [A-Za-zÀ-Ỹà-ỹ]+)*$/;
                let phoneRegex = /^0[0-9]{9}$/; // Số điện thoại phải bắt đầu bằng số 0 và có đúng 10 chữ số.

                // Validate Full Name
                if (!name || !nameRegex.test(name)) {
                    alert("Full Name không hợp lệ! Chỉ chứa chữ cái, mỗi từ cách nhau một dấu cách.");
                    event.preventDefault();
                    return;
                }

                // Validate Phone
                if (!phone || !phoneRegex.test(phone)) {
                    alert("Số điện thoại không hợp lệ! Phải bắt đầu bằng số 0, gồm đúng 10 chữ số và không chứa ký tự đặc biệt.");
                    event.preventDefault();
                    return;
                }
            });


        </script>




    </body>
</html>
