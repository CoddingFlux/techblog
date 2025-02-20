package com.techblog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.techblog.entitties.CustomProperty;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(LogoutServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");

        try {
            HttpSession session = req.getSession(false); // Get session only if it exists

            if (session != null && session.getAttribute("user") != null) {
                session.removeAttribute("user");
                session.invalidate(); // Completely destroy the session

                CustomProperty cProperty = new CustomProperty();
                cProperty.setContent("Logout successful.");
                cProperty.setContentType("success");
                cProperty.setCssClass("alert alert-success");
                resp.sendRedirect("login");

//                resp.getWriter().print("{\"status\":\"success\", \"message\":\"Logout successful\", \"redirect\":\"login\"}");
            } else {
            	resp.sendRedirect("profile");
//                resp.getWriter().print("{\"status\":\"error\", \"message\":\"No active session found\", \"redirect\":\"profile\"}");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during logout", e);
//            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error during logout.");
        }
    }
}
