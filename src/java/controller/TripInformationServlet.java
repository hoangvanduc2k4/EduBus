/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BusDAO;
import dal.ManagerDAO;
import dal.SchoolDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Bus;
import model.Drivers;
import model.Trip;
import java.sql.Date;

/**
 *
 * @author sonNH
 */
public class TripInformationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account managerAccount = (Account) session.getAttribute("account");
        ManagerDAO m = new ManagerDAO();
        int managerID = m.getManagerIDByAccountID(managerAccount.getAccountid());

        List<Trip> l = m.getTripsByManagerId(managerID);

        SchoolDAO s = new SchoolDAO();
        BusDAO b = new BusDAO();

        List<Drivers> drivers = s.getAllDriver();
        List<Bus> buses = b.getAllBus();

        Map<Integer, String> driverNames = new HashMap<>();
        Map<Integer, String> busNames = new HashMap<>();
        Map<Integer, String> managerNames = new HashMap<>();

        for (Trip trip : l) {
            String driver = s.getDriverNameById(trip.getDid());
            driverNames.put(trip.getDid(), driver);

            String bus = b.getLicensePlateById(trip.getBusid());
            busNames.put(trip.getBusid(), bus);

            String managerName = m.getManagerNameById(managerID);
            managerNames.put(trip.getMid(), managerName);
        }


        request.setAttribute("trips", l);
        request.setAttribute("driverNames", driverNames);
        request.setAttribute("busNames", busNames);
        request.setAttribute("managerNames", managerNames);
        request.setAttribute("mid", managerID);
        request.setAttribute("drivers", drivers);
        request.setAttribute("buses", buses);
        request.setAttribute("managerId", managerID);

        request.getRequestDispatcher("tripList.jsp").forward(request, response);

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

        SchoolDAO s = new SchoolDAO();
        BusDAO b = new BusDAO();
        String tripDate = request.getParameter("searchDate");
        String driverId = request.getParameter("driverID");
        String busID = request.getParameter("busID");
        String managerID = request.getParameter("managerID");
        ManagerDAO m = new ManagerDAO();

        List<Trip> l = m.searchTrips(Integer.valueOf(managerID), Integer.valueOf(busID), Integer.valueOf(driverId), Date.valueOf(tripDate));

        if (l.isEmpty()) {
            request.setAttribute("error", "NOT FOUNDED TRIP");
        } else {

            List<Drivers> drivers = s.getAllDriver();
            List<Bus> buses = b.getAllBus();

            Map<Integer, String> driverNames = new HashMap<>();
            Map<Integer, String> busNames = new HashMap<>();
            Map<Integer, String> managerNames = new HashMap<>();

            for (Trip trip : l) {
                String driver = s.getDriverNameById(trip.getDid());
                driverNames.put(trip.getDid(), driver);

                String bus = b.getLicensePlateById(trip.getBusid());
                busNames.put(trip.getBusid(), bus);

                String managerName = m.getManagerNameById(Integer.parseInt(managerID));
                managerNames.put(trip.getMid(), managerName);
            }

            request.setAttribute("trips", l);
            request.setAttribute("driverNames", driverNames);
            request.setAttribute("busNames", busNames);
            request.setAttribute("managerNames", managerNames);
            request.setAttribute("mid", managerID);
            request.setAttribute("drivers", drivers);
            request.setAttribute("buses", buses);
            request.setAttribute("managerId", managerID);
            request.setAttribute("success", "FOUND TRIP SUCCESSFUL");

        }
        request.getRequestDispatcher("tripList.jsp").forward(request, response);
    }

}
