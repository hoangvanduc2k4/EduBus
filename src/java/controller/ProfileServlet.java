/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import java.util.Date;
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

    @Override
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
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            // Chuyển đổi ngày từ String sang java.util.Date và java.sql.Date
            java.util.Date utilDate = sdf.parse(dob);
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

            // Nếu img rỗng, gán giá trị mặc định
            if (img.isBlank()) {
                img = "image/default.jpg";
            }

            // Xử lý cập nhật theo vai trò (Driver hoặc Manager)
            if (role.equals("Driver")) {
                Drivers o = new Drivers(0, name, phone, gender, sqlDate, img, accid);
                sd.updateDriver(o);
                request.setAttribute("o", o);
            } else {
                Manager o = new Manager(0, name, phone, gender, sqlDate, img, accid);
                sd.updateManager(o);
                request.setAttribute("o", o);
            }

            // Nếu cập nhật thành công, đẩy attribute success
            request.setAttribute("success", "Cập nhật thành công.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);

        } catch (ParseException ex) {
            request.setAttribute("error", "Lỗi xử lý ngày sinh.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
