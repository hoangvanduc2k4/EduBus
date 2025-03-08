package controller;

import dal.ParentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import model.Account;
import model.Parent;
import util.Validation; // import lớp Validation

public class ParentServlet extends HttpServlet {

    ParentDAO d = new ParentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        List<Parent> listP = d.getParentByAccId(a.getAccountid() + "");
        request.setAttribute("listP", listP);
        request.getRequestDispatcher("parentinfo.jsp").forward(request, response);
    }

    @Override
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
                // Kiểm tra email hợp lệ
                if (!Validation.isValidEmail(email)) {
                    request.setAttribute("error", "Địa chỉ email không hợp lệ.");
                    // Thiết lập flag mở lại modal Add
                    request.setAttribute("modalToOpen", "add");
                    // Giữ lại dữ liệu vừa nhập
                    request.setAttribute("name", name);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("gender", gender);
                    request.setAttribute("dob", dob);
                    request.setAttribute("role", role);
                    request.setAttribute("img", img);
                    List<Parent> listP = d.getParentByAccId(a.getAccountid() + "");
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
                    // Có thể xử lý thông báo lỗi định dạng ngày nếu cần
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
                // Kiểm tra email hợp lệ cho update
                // Trong case "update":
                if (!Validation.isValidEmail(email)) {
                    request.setAttribute("error", "Địa chỉ email không hợp lệ.");
                    // Thiết lập flag mở lại modal Update
                    request.setAttribute("modalToOpen", "update");
                    request.setAttribute("updateId", idr);
                    request.setAttribute("name", name);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("gender", gender);
                    request.setAttribute("dob", dob);
                    request.setAttribute("role", role);
                    request.setAttribute("img", img);
                    List<Parent> listP = d.getParentByAccId(a.getAccountid() + "");
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
                    // Xử lý lỗi định dạng ngày nếu cần
                }
                break;
        }
        response.sendRedirect("parentinfo");
    }
}
