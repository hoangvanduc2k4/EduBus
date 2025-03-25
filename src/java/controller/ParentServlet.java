package controller;

import dal.ParentDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Parent;
import util.Validation;

public class ParentServlet extends HttpServlet {

    ParentDAO d = new ParentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");

        // Nếu account null hoặc role không phải "Parent" thì có thể redirect
        if (a == null || !a.getRole().equals("Parent")) {
            response.sendRedirect("accdn.jsp");
            return;
        }

        // Lấy tham số phân trang
        int page = 1;
        int pageSize = 5;
        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
        }

        try {
            String pageSizeStr = request.getParameter("pageSize");
            if (pageSizeStr != null) {
                pageSize = Integer.parseInt(pageSizeStr);
            }
        } catch (NumberFormatException e) {
        }

        // Lấy các tham số tìm kiếm
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String role = request.getParameter("role");

        // Convert dob sang Date
        java.sql.Date sqlDob = null;
        if (dob != null && !dob.trim().isEmpty()) {
            try {
                java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(dob);
                sqlDob = new java.sql.Date(utilDate.getTime());
            } catch (ParseException ex) {
                ex.printStackTrace();
            }
        }

        // Đếm tổng số Parent thỏa mãn
        int totalRecords = d.countParents(name, email, phone, sqlDob, gender, role, a.getAccountid());
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Lấy danh sách Parent theo trang
        List<Parent> listP = d.searchParents(name, email, phone, sqlDob, gender, role, a.getAccountid(), page, pageSize);

        // Lấy list role (nếu cần hiển thị dropdown)
        List<String> roles = null;
        try {
            roles = d.getDistinctParentRoles();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        // Đưa các biến cần thiết về JSP
        request.setAttribute("listP", listP);
        request.setAttribute("listR", roles);

        // Đưa tham số tìm kiếm & phân trang để giữ lại trên form
        request.setAttribute("name", name);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("dob", dob);
        request.setAttribute("gender", gender);
        request.setAttribute("role", role);

        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);

        // Chuyển sang JSP
        request.getRequestDispatcher("parentinfo.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy action
        String action = (request.getParameter("action") == null) ? "" : request.getParameter("action");

        // Lấy các tham số phân trang & search từ hidden fields
        int page = 1;
        int pageSize = 5;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
        }
        try {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        } catch (NumberFormatException e) {
        }

        // Các tham số search cũ
        String searchName = request.getParameter("searchName");
        String searchEmail = request.getParameter("searchEmail");
        String searchPhone = request.getParameter("searchPhone");
        String searchDob = request.getParameter("searchDob");
        String searchGender = request.getParameter("searchGender");
        String searchRole = request.getParameter("searchRole");

        // Lấy account
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        // Các biến để hứng dữ liệu form Add/Update
        String name = "", email = "", phone = "", gender = "", role = "", dob = "", img = "";

        switch (action) {
            case "add": {
                // 1) Lấy dữ liệu từ form
                name = request.getParameter("name");
                email = request.getParameter("email");
                phone = request.getParameter("phone");
                gender = request.getParameter("gender");
                dob = request.getParameter("dob");
                role = request.getParameter("role");
                img = request.getParameter("img");
                if (img == null || img.isBlank()) {
                    img = "image/default.jpg";
                }

                // 2) Validate Full Name
                if (!Validation.isValidFullName(name)) {
                    request.setAttribute("errorMessage",
                            "Full Name không hợp lệ! "
                            + "Không được nhập toàn dấu cách, "
                            + "không nhập số/ký tự đặc biệt, "
                            + "mỗi từ chỉ được cách nhau đúng 1 dấu cách.");

                    // Mở lại modal Add
                    request.setAttribute("modalToOpen", "add");
                    // Gửi lại dữ liệu người dùng nhập
                    request.setAttribute("name", name);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("gender", gender);
                    request.setAttribute("dob", dob);
                    request.setAttribute("role", role);
                    request.setAttribute("img", img);

                    // Load lại danh sách và phân trang
                    java.sql.Date sqlSearchDob = null;
                    if (searchDob != null && !searchDob.trim().isEmpty()) {
                        try {
                            sqlSearchDob = new java.sql.Date(sdf.parse(searchDob).getTime());
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    int totalRecords = d.countParents(searchName, searchEmail, searchPhone,
                            sqlSearchDob, searchGender, searchRole, a.getAccountid());
                    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
                    List<Parent> listP = d.searchParents(searchName, searchEmail, searchPhone,
                            sqlSearchDob, searchGender, searchRole, a.getAccountid(), page, pageSize);

                    request.setAttribute("listP", listP);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("pageSize", pageSize);
                    request.setAttribute("totalPages", totalPages);

                    // Giữ lại các biến search
                    request.setAttribute("name", searchName);
                    request.setAttribute("email", searchEmail);
                    request.setAttribute("phone", searchPhone);
                    request.setAttribute("dob", searchDob);
                    request.setAttribute("gender", searchGender);
                    request.setAttribute("role", searchRole);

                    request.getRequestDispatcher("parentinfo.jsp").forward(request, response);
                    return;
                }

                // 3) Validate Phone
                if (!Validation.isValidPhone(phone)) {
                    request.setAttribute("errorMessage",
                            "Số điện thoại không hợp lệ! Tối đa 10 số, không chứa ký tự đặc biệt/dấu cách, và phải bắt đầu bằng số 0."
                    );

                    request.setAttribute("modalToOpen", "add");
                    // Gửi lại dữ liệu form
                    request.setAttribute("name", name);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("gender", gender);
                    request.setAttribute("dob", dob);
                    request.setAttribute("role", role);
                    request.setAttribute("img", img);

                    // Load lại danh sách
                    java.sql.Date sqlSearchDob = null;
                    if (searchDob != null && !searchDob.trim().isEmpty()) {
                        try {
                            sqlSearchDob = new java.sql.Date(sdf.parse(searchDob).getTime());
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    int totalRecords = d.countParents(searchName, searchEmail, searchPhone,
                            sqlSearchDob, searchGender, searchRole, a.getAccountid());
                    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
                    List<Parent> listP = d.searchParents(searchName, searchEmail, searchPhone,
                            sqlSearchDob, searchGender, searchRole, a.getAccountid(), page, pageSize);

                    request.setAttribute("listP", listP);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("pageSize", pageSize);
                    request.setAttribute("totalPages", totalPages);

                    // Giữ lại biến search
                    request.setAttribute("name", searchName);
                    request.setAttribute("email", searchEmail);
                    request.setAttribute("phone", searchPhone);
                    request.setAttribute("dob", searchDob);
                    request.setAttribute("gender", searchGender);
                    request.setAttribute("role", searchRole);

                    request.getRequestDispatcher("parentinfo.jsp").forward(request, response);
                    return;
                }

                // 4) Validate Email
                if (!Validation.isValidEmail(email)) {
                    request.setAttribute("error", "Địa chỉ email không hợp lệ.");
                    request.setAttribute("modalToOpen", "add");

                    request.setAttribute("name", name);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("gender", gender);
                    request.setAttribute("dob", dob);
                    request.setAttribute("role", role);
                    request.setAttribute("img", img);

                    // Load lại danh sách
                    java.sql.Date sqlSearchDob = null;
                    if (searchDob != null && !searchDob.trim().isEmpty()) {
                        try {
                            sqlSearchDob = new java.sql.Date(sdf.parse(searchDob).getTime());
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    int totalRecords = d.countParents(searchName, searchEmail, searchPhone,
                            sqlSearchDob, searchGender, searchRole, a.getAccountid());
                    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
                    List<Parent> listP = d.searchParents(searchName, searchEmail, searchPhone,
                            sqlSearchDob, searchGender, searchRole, a.getAccountid(), page, pageSize);

                    request.setAttribute("listP", listP);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("pageSize", pageSize);
                    request.setAttribute("totalPages", totalPages);

                    // Giữ lại biến search
                    request.setAttribute("name", searchName);
                    request.setAttribute("email", searchEmail);
                    request.setAttribute("phone", searchPhone);
                    request.setAttribute("dob", searchDob);
                    request.setAttribute("gender", searchGender);
                    request.setAttribute("role", searchRole);

                    request.getRequestDispatcher("parentinfo.jsp").forward(request, response);
                    return;
                }

                // 5) Nếu qua được 3 bước kiểm tra => parse DOB, insert
                try {
                    java.util.Date utilDate = sdf.parse(dob);
                    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                    Parent p = new Parent(0, name, email, phone, gender, sqlDate, role, img, a.getAccountid());
                    d.insert(p);
                    request.setAttribute("successMessage", "Add Parent Successfully");
                } catch (Exception e) {
                    e.printStackTrace();
                }

                // 6) Load lại danh sách sau khi insert
                java.sql.Date sqlSearchDob = null;
                if (searchDob != null && !searchDob.trim().isEmpty()) {
                    try {
                        sqlSearchDob = new java.sql.Date(sdf.parse(searchDob).getTime());
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                int totalRecords = d.countParents(searchName, searchEmail, searchPhone,
                        sqlSearchDob, searchGender, searchRole, a.getAccountid());
                int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
                List<Parent> listP = d.searchParents(searchName, searchEmail, searchPhone,
                        sqlSearchDob, searchGender, searchRole, a.getAccountid(), page, pageSize);

                request.setAttribute("listP", listP);
                request.setAttribute("currentPage", page);
                request.setAttribute("pageSize", pageSize);
                request.setAttribute("totalPages", totalPages);

                // Giữ lại các biến search
                request.setAttribute("name", searchName);
                request.setAttribute("email", searchEmail);
                request.setAttribute("phone", searchPhone);
                request.setAttribute("dob", searchDob);
                request.setAttribute("gender", searchGender);
                request.setAttribute("role", searchRole);

                // Forward
                request.getRequestDispatcher("parentinfo.jsp").forward(request, response);
                break;
            }

            // Nếu cần, bạn làm tương tự cho case "update"
            default:
                // Hoặc tuỳ logic, ví dụ redirect về trang danh sách
                response.sendRedirect("parentinfo");
        }
    }
}
