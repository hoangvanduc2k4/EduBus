package controller;

import dal.AccountDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.User;

public class ManageAccountServlet extends HttpServlet {

    AccountDAO d = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập UTF-8 cho request và response
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();

        // Lấy tham số phân trang
        int page = 1;
        int size = 5;
        try {
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            if (request.getParameter("pageSize") != null) {
                size = Integer.parseInt(request.getParameter("pageSize"));
            }
        } catch (NumberFormatException e) {
            page = 1;
            size = 5;
        }

        String fullname = null, phone = null,  role = null, status = null;
        // Lấy các tham số filter
        if (request.getParameter("fullname") != null) {
            fullname = request.getParameter("fullname").trim().toLowerCase().replaceAll("\\s+", " ");
        }
        if(request.getParameter("phone") != null){
            phone =  request.getParameter("phone").trim().toLowerCase().replaceAll("\\s+", "");

        }
        if(request.getParameter("role") != null){
            role = request.getParameter("role").toLowerCase();
        }
        if(request.getParameter("status") != null){
            status = request.getParameter("status").toLowerCase();
        }

        // Xử lý các hành động add và update
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        if (action.equalsIgnoreCase("add")) {
            String userParam = request.getParameter("user");
            String pass = request.getParameter("pass");
            String r = request.getParameter("role");
            // Giả sử status mặc định là "Active" khi thêm
            Account a = new Account(0, userParam, pass, r, "Active");
            boolean inserted = d.insertAccount(a);
            if (inserted) {
                request.setAttribute("success", "Account added successfully!");
            } else {
                request.setAttribute("error", "Failed to add account!");
            }
        } else if (action.equalsIgnoreCase("update")) {
            String id_raw = request.getParameter("id");
            String newStatus = request.getParameter("status");
            boolean updated = d.updateUser(id_raw, newStatus);
            if (updated) {
                request.setAttribute("success", "Account updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update account!");
            }
        }

        // Lấy danh sách tài khoản đã được lọc và phân trang từ DAO
        List<User> listU = d.getAccount(fullname, role, phone, status, page, size);

        // Giả sử bạn có thêm một phương thức đếm tổng số bản ghi theo filter để tính số trang
        int totalRecords = d.countAccounts(fullname, role, phone, status);
        int totalPages = (int) Math.ceil((double) totalRecords / size);

        // Gán các giá trị cho JSP
        request.setAttribute("listU", listU);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", size);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("fullname", fullname);
        request.setAttribute("role", role);
        request.setAttribute("phone", phone);
        request.setAttribute("status", status);

        request.getRequestDispatcher("manageAccount.jsp").forward(request, response);
    }

}
