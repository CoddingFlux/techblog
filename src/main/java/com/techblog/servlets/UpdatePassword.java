package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.techblog.dao.UserDao;
import com.techblog.entitties.User;
import com.techblog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdatePassword")
@MultipartConfig
public class UpdatePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = Logger.getLogger(UpdatePassword.class.getName());

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json");

		try (PrintWriter pw = resp.getWriter()) {
			HttpSession session = req.getSession();
			User user = (User) session.getAttribute("user");

			if (user == null) {
				pw.print("{\"status\":\"error\", \"message\":\"User session expired. Please log in again.\"}");
				return;
			}

			String password = req.getParameter("user_password1").trim();
			String confirmPassword = req.getParameter("user_password2").trim();

			// Validate passwords
			if (password.isEmpty() || confirmPassword.isEmpty()) {
				pw.print("{\"status\":\"error\", \"message\":\"Password fields cannot be empty.\"}");
				return;
			}

			if (!password.equals(confirmPassword)) {
				pw.print("{\"status\":\"error\", \"message\":\"Passwords do not match.\"}");
				return;
			}

			// Update password in the database
			UserDao dao = new UserDao(ConnectionProvider.getConnection());
			boolean isUpdated = dao.updatePassword(user.getuId(), password);

			if (isUpdated) {
				pw.print("{\"status\":\"success\", \"message\":\"Password updated successfully!\"}");
			} else {
				pw.print("{\"status\":\"error\", \"message\":\"Failed to update password. Please try again.\"}");
			}
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Error updating password", e);
//            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
		}
	}
}
