package controller;

import dal.AccountDAO;
import java.io.IOException;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

public class LoginServlet extends HttpServlet {

    private static final String USERNAME_PATTERN = "^[a-zA-Z0-9]+$";
    private final AccountDAO d = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        String rem = request.getParameter("re");

        // Validate username format
        if (user == null || !Pattern.matches(USERNAME_PATTERN, user)) {
            request.setAttribute("error1", "Invalid username! Only letters and numbers are allowed, no special characters or spaces.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        Cookie u = new Cookie("cu", user);
        Cookie p = new Cookie("cp", pass);
        Cookie r = new Cookie("cr", rem);

        if (rem != null) {
            u.setMaxAge(60 * 60 * 24);
            p.setMaxAge(60 * 60 * 24);
            r.setMaxAge(60 * 60 * 24);
        } else {
            u.setMaxAge(0);
            p.setMaxAge(0);
            r.setMaxAge(0);
        }
        response.addCookie(r);
        response.addCookie(u);
        response.addCookie(p);

        Account userCheck = d.getAccountByUsername(user); // Check if username exists
        Account a = d.checkAcc(user, pass); // Check username + password combination

        if (a != null) {
            if (a.getSt().equals("Inactive")) {
                request.setAttribute("error1", "This account is not activated.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                session.setAttribute("account", a);
                if (a.getRole().equals("Admin")) {
                    response.sendRedirect("statistic");
                } else {
                    request.getRequestDispatcher("home.jsp").forward(request, response);
                }
            }
        } else {
            if (userCheck == null) {
                request.setAttribute("error1", "Incorrect User Name");
            } else if (!userCheck.getPassword().equals(pass)) {
                request.setAttribute("error1", "Incorrect password.");
            } else {
                request.setAttribute("error1", "Username and password do not correct.");
            }
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
