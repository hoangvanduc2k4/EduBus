package controller;

import dal.SchoolDAO;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Drivers;
import model.Manager;
import util.Validation;

public class ProfileServlet extends HttpServlet {

    SchoolDAO sd = new SchoolDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account s = (Account) session.getAttribute("account");

        if (s != null) {
            if ("Driver".equals(s.getRole())) {
                Drivers o = sd.getDriver(String.valueOf(s.getAccountid()));
                request.setAttribute("o", o);
            } else if ("Manager".equals(s.getRole())) {
                Manager o = sd.getManager(String.valueOf(s.getAccountid()));
                request.setAttribute("o", o);
            }
        }
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account s = (Account) session.getAttribute("account");

        if (s == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            // Lấy tham số từ request
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String gender = request.getParameter("gender");
            String dob = request.getParameter("dob");
            String img = request.getParameter("img");
            String role = request.getParameter("role");
            int accid = Integer.parseInt(request.getParameter("accid"));

            // Validate tên và ngày sinh
            String errorName = Validation.validateUsername(name);
            String errorDob = Validation.validateDob(dob);

            if (errorName != null || errorDob != null) {
                if (errorName != null) {
                    request.setAttribute("errorName", errorName);
                }
                if (errorDob != null) {
                    request.setAttribute("errorDob", errorDob);
                }
                // Gửi lại dữ liệu đã nhập theo đúng vai trò
                if ("Driver".equals(role)) {
                    request.setAttribute("o", new Drivers(0, name, phone, gender,
                        new java.sql.Date(sdf.parse(dob).getTime()), img, accid));
                } else if ("Manager".equals(role)) {
                    request.setAttribute("o", new Manager(0, name, phone, gender,
                        new java.sql.Date(sdf.parse(dob).getTime()), img, accid));
                }
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            // Kiểm tra số điện thoại hợp lệ
            if (!Validation.isValidPhone(phone)) {
                request.setAttribute("errorPhone", "Số điện thoại không hợp lệ! Vui lòng nhập lại.");
                if ("Driver".equals(role)) {
                    request.setAttribute("o", new Drivers(0, name, phone, gender,
                        new java.sql.Date(sdf.parse(dob).getTime()), img, accid));
                } else if ("Manager".equals(role)) {
                    request.setAttribute("o", new Manager(0, name, phone, gender,
                        new java.sql.Date(sdf.parse(dob).getTime()), img, accid));
                }
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            // Chuyển đổi ngày sinh từ String sang java.sql.Date
            java.sql.Date sqlDate = new java.sql.Date(sdf.parse(dob).getTime());

            // Nếu img rỗng, gán giá trị mặc định
            if (img == null || img.isBlank()) {
                img = "image/default.jpg";
            }

            // Cập nhật dữ liệu theo vai trò
            if ("Driver".equals(role)) {
                Drivers o = new Drivers(0, name, phone, gender, sqlDate, img, accid);
                sd.updateDriver(o);
                request.setAttribute("o", o);
            } else if ("Manager".equals(role)) {
                Manager o = new Manager(0, name, phone, gender, sqlDate, img, accid);
                sd.updateManager(o);
                request.setAttribute("o", o);
            }

            // Cập nhật thành công
            request.setAttribute("success", "Cập nhật thành công.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);

        } catch (ParseException ex) {
            request.setAttribute("error", "Lỗi định dạng ngày tháng.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}
