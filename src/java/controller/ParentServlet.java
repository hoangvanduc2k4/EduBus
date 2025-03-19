package controller;

import dal.ParentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
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

        // Lấy tham số phân trang
        int page = 1;
        int pageSize = 2;
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
            // Giữ nguyên pageSize = 5
        }

        // Lấy các tham số tìm kiếm (nếu có)
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String role = request.getParameter("role");

        // Chuyển dob sang Date nếu không null
        java.sql.Date sqlDob = null;
        if (dob != null && !dob.trim().isEmpty()) {
            try {
                java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(dob);
                sqlDob = new java.sql.Date(utilDate.getTime());
            } catch (ParseException ex) {
                ex.printStackTrace();
            }
        }

        // Đếm tổng số Parent thỏa mãn tìm kiếm
        int totalRecords = d.countParents(name, email, phone, sqlDob, gender, role, a.getAccountid());
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Lấy danh sách Parent với phân trang
        List<Parent> listP = d.searchParents(name, email, phone, sqlDob, gender, role, a.getAccountid(), page, pageSize);

        // Lấy list role (nếu cần)
        List<String> roles = null;
        try {
            roles = d.getDistinctParentRoles();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        // Đưa các biến cần thiết về JSP
        request.setAttribute("listP", listP);
        request.setAttribute("listR", roles);

        // Đưa các tham số tìm kiếm & phân trang để giữ trạng thái trên form
        request.setAttribute("name", name);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("dob", dob);
        request.setAttribute("gender", gender);
        request.setAttribute("role", role);

        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("parentinfo.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") == null
                ? ""
                : request.getParameter("action");
        String name = "", email = "", phone = "", gender = "", role = "", dob = "", img = "";
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        java.util.Date utilDate;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        switch (action) {
            case "add":
                name = request.getParameter("name");
                email = request.getParameter("email");
                phone = request.getParameter("phone");
                gender = request.getParameter("gender");
                dob = request.getParameter("dob");
                role = request.getParameter("role");
                img = request.getParameter("img");
                if (img.isBlank()) {
                    img = "image/default.jpg";
                }
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
                    // Sử dụng searchParents thay vì getParentByAccId, chỉ lấy Parent thuộc Account đã đăng nhập
                    List<Parent> listP = d.searchParents("", "", "", null, "", "", a.getAccountid(), 1, 5);
                    request.setAttribute("listP", listP);
                    request.getRequestDispatcher("parentinfo.jsp").forward(request, response);
                    return;
                }
                try {
                    utilDate = sdf.parse(dob);
                    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                    Parent p = new Parent(0, name, email, phone, gender, sqlDate, role, img, a.getAccountid());
                    d.insert(p);
                } catch (ParseException e) {
                }
                break;

            case "update":
                String idr = request.getParameter("id");
                name = request.getParameter("name");
                email = request.getParameter("email");
                phone = request.getParameter("phone");
                gender = request.getParameter("gender");
                dob = request.getParameter("dob");
                role = request.getParameter("role");
                img = request.getParameter("img");
                if (img.isBlank()) {
                    img = "image/default.jpg";
                }

                if (!Validation.isValidEmail(email)) {
                    request.setAttribute("error", "Địa chỉ email không hợp lệ.");
                    request.setAttribute("modalToOpen", "update");
                    request.setAttribute("updateId", idr);
                    request.setAttribute("name", name);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("gender", gender);
                    request.setAttribute("dob", dob);
                    request.setAttribute("role", role);
                    request.setAttribute("img", img);
                    // Sử dụng searchParents thay vì getParentByAccId, chỉ lấy Parent thuộc Account đã đăng nhập
                    List<Parent> listP = d.searchParents("", "", "", null, "", "", a.getAccountid(), 1, 5);
                    request.setAttribute("listP", listP);
                    request.getRequestDispatcher("parentinfo.jsp").forward(request, response);
                    return;
                }

                try {
                    int id = Integer.parseInt(idr);
                    utilDate = sdf.parse(dob);
                    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                    Parent p = new Parent(id, name, email, phone, gender, sqlDate, role, img, a.getAccountid());
                    d.update(p);
                } catch (ParseException e) {
                }
                break;
        }
        response.sendRedirect("parentinfo");
    }
}
