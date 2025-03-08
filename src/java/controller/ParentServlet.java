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
import java.util.regex.Pattern;
import model.Account;
import model.Parent;

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
        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<Parent> listP = d.getParentByAccId(a.getAccountid() + "");
        request.setAttribute("listP", listP);
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String role = request.getParameter("role");
        String img = request.getParameter("img");

        if (img == null || img.isBlank()) {
            img = "image/default.jpg";
        }

        try {
            java.util.Date utilDate = sdf.parse(dob);
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

            if (action.equals("add")) {
                // Kiểm tra email hợp lệ
                if (!isValidEmail(email)) {
                    request.setAttribute("errorAdd", "Email không hợp lệ!");
                    // Giữ lại các giá trị đã nhập
                    request.setAttribute("name", name);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("gender", gender);
                    request.setAttribute("dob", dob);
                    request.setAttribute("role", role);
                    request.setAttribute("img", img);
                    if (action.equals("update")) {
                        request.setAttribute("id", request.getParameter("id"));
                    }
                    request.getRequestDispatcher("parentinfo.jsp").forward(request, response);
                    return;
                }
                Parent p = new Parent(0, name, email, phone, gender, sqlDate, role, img, a.getAccountid());
                d.insert(p);
            } else if (action.equals("update")) {
                // Kiểm tra email hợp lệ
                if (!isValidEmail(email)) {
                    request.setAttribute("errorUpdate", "Email không hợp lệ!");
                    // Giữ lại các giá trị đã nhập
                    request.setAttribute("name", name);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("gender", gender);
                    request.setAttribute("dob", dob);
                    request.setAttribute("role", role);
                    request.setAttribute("img", img);
                    if (action.equals("update")) {
                        request.setAttribute("id", request.getParameter("id"));
                    }
                    request.getRequestDispatcher("parentinfo.jsp").forward(request, response);
                    return;
                }
                int id = Integer.parseInt(request.getParameter("id"));
                Parent p = new Parent(id, name, email, phone, gender, sqlDate, role, img, a.getAccountid());
                d.update(p);
            }
        } catch (ParseException e) {
            request.setAttribute("error", "Lỗi định dạng ngày tháng.");
            request.getRequestDispatcher("parentinfo.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("parentinfo");
    }

    private boolean isValidEmail(String email) {
        // Kiểm tra có chứa dấu cách không
        if (email.contains(" ")) {
            return false;
        }
        // Kiểm tra độ dài tối đa
        if (email.length() > 320) {
            return false;
        }
        // Biểu thức chính quy nâng cấp để kiểm tra email hợp lệ
        String emailRegex = "^(?!.*\\.\\.)([A-Za-z0-9._%+-]{1,64})@([A-Za-z0-9.-]+)\\.([A-Za-z]{2,})$";
        // Kiểm tra bằng regex
        if (!Pattern.matches(emailRegex, email)) {
            return false;
        }
        // Kiểm tra độ dài tên người dùng (trước @) và tên miền (sau @)
        String[] parts = email.split("@");
        if (parts[0].length() > 64 || parts[1].length() > 255) {
            return false;
        }
        return true;
    }
}
