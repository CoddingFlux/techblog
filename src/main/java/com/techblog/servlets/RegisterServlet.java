package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;


import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;

import com.techblog.dao.UserDao;
import com.techblog.entitties.User;
import com.techblog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = (Logger) LoggerFactory.getLogger(RegisterServlet.class);

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json");

		try (PrintWriter out = resp.getWriter()) {
			String uname = req.getParameter("user_name").trim();
			String uemail = req.getParameter("user_email").trim();
			String upassword = req.getParameter("user_password").trim();
			String ugender = req.getParameter("user_gender");
			String uabout = req.getParameter("user_about");
			String ucheck = req.getParameter("user_check");

			if (ucheck == null) {
				out.print("{\"status\":\"badwarn\", \"message\":\"Please accept the terms and conditions.\"}");
				return;
			}

			User user = new User(uname, uemail, upassword, ugender, uabout);
			UserDao udao = new UserDao(ConnectionProvider.getConnection());

			if (!udao.isUserRegistered(uemail)) {
				if (udao.saveData(user)) {
					out.print(
							"{\"status\":\"success\", \"message\":\"Registration successful!\", \"redirect\":\"login\"}");
				} else {
					out.print("{\"status\":\"badwarn\", \"message\":\"Email already registered!\"}");
				}
			} else {
				out.print("{\"status\":\"badwarn\", \"message\":\"Email already registered!\"}");
			}
		} catch (Exception e) {
			logger.error("Error in registration : {}", e);
			resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
					"An error occurred while processing your request.");
		}
	}
}
