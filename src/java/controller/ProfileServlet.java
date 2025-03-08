package controller;

import dal.SchoolDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import model.Account;
import model.Drivers;
import model.Manager;
import util.Validation;

/**
 *
 * @author DIEN MAY XANH
 */
public class ProfileServlet extends HttpServlet {

    SchoolDAO sd = new SchoolDAO();

<<<<<<< Updated upstream
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
=======
>>>>>>> Stashed changes
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account s = (Account) session.getAttribute("account");
        if (s.getRole().equals("Driver")) {
            Drivers o = sd.getDriver(s.getAccountid() + "");
            request.setAttribute("o", o);

        } else if (s.getRole().equals("Manager")) {
            Manager o = sd.getManager(s.getAccountid() + "");
            request.setAttribute("o", o);

        }
        request.getRequestDispatcher("profile.jsp").forward(request, response);

    }

<<<<<<< Updated upstream
    @Override
=======
>>>>>>> Stashed changes
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account s = (Account) session.getAttribute("account");
        if (s.getRole().equals("Driver")) {
            Drivers o = sd.getDriver(s.getAccountid() + "");
            request.setAttribute("o", o);
        } else if (s.getRole().equals("Manager")) {
            Manager o = sd.getManager(s.getAccountid() + "");
            request.setAttribute("o", o);
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

<<<<<<< Updated upstream
            // Validate tên (username) và ngày sinh
            String errorName = Validation.validateUsername(name);
            String errorDob = Validation.validateDob(dob);

            // Nếu có lỗi từ validateName hoặc validateDob, đẩy attribute lỗi tương ứng
            if (errorName != null || errorDob != null) {
                if (errorName != null) {
                    request.setAttribute("errorName", errorName);
                }
                if (errorDob != null) {
                    request.setAttribute("errorDob", errorDob);
                }
=======
            // Kiểm tra số điện thoại hợp lệ
            if (!isValidPhone(phone)) {
                request.setAttribute("error", "Số điện thoại không hợp lệ! Vui lòng nhập lại.");

                // Lưu lại thông tin đã nhập
                request.setAttribute("o", new Drivers(0, name, phone, gender, new java.sql.Date(sdf.parse(dob).getTime()), img, accid));
>>>>>>> Stashed changes
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

<<<<<<< Updated upstream
            // Chuyển đổi ngày từ String sang java.util.Date và java.sql.Date
=======
>>>>>>> Stashed changes
            java.util.Date utilDate = sdf.parse(dob);
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

            // Nếu img rỗng, gán giá trị mặc định
            if (img.isBlank()) {
                img = "image/default.jpg";
            }
<<<<<<< Updated upstream

            // Xử lý cập nhật theo vai trò (Driver hoặc Manager)
=======
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

>>>>>>> Stashed changes
            if (role.equals("Driver")) {
                Drivers o = new Drivers(0, name, phone, gender, sqlDate, img, accid);
                sd.updateDriver(o);
                request.setAttribute("o", o);
            } else {
                Manager o = new Manager(0, name, phone, gender, sqlDate, img, accid);
                sd.updateManager(o);
                request.setAttribute("o", o);
            }
<<<<<<< Updated upstream

            // Nếu cập nhật thành công, đẩy attribute success
            request.setAttribute("success", "Cập nhật thành công.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);

        } catch (ParseException ex) {
            request.setAttribute("error", "Lỗi xử lý ngày sinh.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
=======
        } catch (ParseException ex) {
            request.setAttribute("error", "Lỗi định dạng ngày tháng.");
        }

        response.sendRedirect("profile");
>>>>>>> Stashed changes
    }

    private boolean isValidPhone(String phone) {
        // Kiểm tra xem phone có rỗng hoặc null không
        if (phone == null || phone.isBlank()) {
            return false;
        }
        // Kiểm tra xem phone có đúng 10 số không
        if (phone.length() != 10) {
            return false;
        }
        // Kiểm tra phone có bắt đầu bằng số 0 không
        if (!phone.startsWith("0")) {
            return false;
        }
        // Kiểm tra phone chỉ chứa số, không có ký tự đặc biệt hoặc chữ cái
        if (!phone.matches("\\d{10}")) {
            return false;
        }
        return true;
    }

}
