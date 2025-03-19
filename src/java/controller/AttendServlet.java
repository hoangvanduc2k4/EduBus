
package controller;

import dal.ParentDAO;
import dal.StudentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Parent;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import model.Attend;
import model.Student;

/**
 *
 * @author DIEN MAY XANH
 */
public class AttendServlet extends HttpServlet {

    private static final String LISTA_ATTRIBUTE = "lista";

    ParentDAO dp = new ParentDAO();
    StudentDAO sp = new StudentDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AttendServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AttendServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        Account a = (Account) session.getAttribute("account");
        List<Parent> listp = dp.getParentByAccId(a.getAccountid() + "");
        request.setAttribute("listp", listp);
        Date currentDate = new Date(System.currentTimeMillis());
        request.setAttribute("ad", currentDate);

        List<Attend> lista = sp.getAttend(currentDate + "", a.getAccountid());
        request.setAttribute(LISTA_ATTRIBUTE, lista);
        List<Student> lists = sp.getStudentByAccid(a.getAccountid() + "");
        request.setAttribute("lists", lists);
        request.getRequestDispatcher("attend.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Account a = (Account) session.getAttribute("account");
        List<Parent> listp = dp.getParentByAccId(a.getAccountid() + "");
        request.setAttribute("listp", listp);
        List<Student> lists = sp.getStudentByAccid(a.getAccountid() + "");
        request.setAttribute("lists", lists);
        List<Attend> lista;
        String action = request.getParameter("action") == null
                ? ""
                : request.getParameter("action");
        switch (action) {
            case "attend":
                String dob = request.getParameter("dob");
                request.setAttribute("dob", dob);
                String tp = request.getParameter("tp");
                request.setAttribute("tp", tp);
                String name = request.getParameter("name");
                request.setAttribute("name", name);

                String attend = request.getParameter("attend");
                request.setAttribute("attend", attend);

                String pr = request.getParameter("pr");

                request.setAttribute("pr", pr);

                java.util.Date utilDate;

                try {
                    utilDate = sdf.parse(dob);
                    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                    Attend atte = new Attend(0, Integer.parseInt(name), name, sqlDate, tp, null, null, null, null, pr, "waiting", attend);

                    sp.insertAttendance(atte);

                } catch (NumberFormatException | ParseException e) {

                    request.setAttribute("errorMessage", "An error occurred while processing your request.");
                    request.getRequestDispatcher("attend.jsp").forward(request, response);
                    return;
                }

                lista = sp.getAttend(dob, a.getAccountid());
                request.setAttribute("ad", dob);

                request.setAttribute(LISTA_ATTRIBUTE, lista);
                request.getRequestDispatcher("attend.jsp").forward(request, response);
                break;

            case "search":
                String ad = request.getParameter("ad");
                lista = sp.getAttend(ad, a.getAccountid());
                request.setAttribute("ad", ad);
                request.setAttribute(LISTA_ATTRIBUTE, lista);
                request.getRequestDispatcher("attend.jsp").forward(request, response);
                break;
            case "delete":
                String aid = request.getParameter("aid");
                sp.deleteAttend(aid);
                response.sendRedirect("attend");
                break;
            default:
                request.setAttribute("errorMessage", "Invalid action requested.");
                request.getRequestDispatcher("attend.jsp").forward(request, response);
                break;

        }

    }

    

}
