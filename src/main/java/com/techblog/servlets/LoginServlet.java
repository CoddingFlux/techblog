package com.techblog.servlets;

import java.io.IOException;


import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;

import com.techblog.dao.UserDao;
import com.techblog.entitties.CustomProperty;
import com.techblog.entitties.User;
import com.techblog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = (Logger) LoggerFactory.getLogger(DisLikes.class);

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("text/html");

		String username = req.getParameter("user_email");
		String password = req.getParameter("user_password");

		HttpSession httpSession = req.getSession();
		CustomProperty cProperty = new CustomProperty();

		UserDao userDao = null;
		User user = null;

		try {

			userDao = new UserDao(ConnectionProvider.getConnection());
			user = userDao.getUserByUsernameAndPassword(username.trim(), password.trim());

			if (user == null) {
				cProperty.setContent("Invalid username or password.");
				cProperty.setContentType("error : Login Failed");
				cProperty.setCssClass("alert alert-danger");
				httpSession.setAttribute("customProperty", cProperty);
				resp.sendRedirect("login");
			} else {
				httpSession.setAttribute("user", user);
				resp.sendRedirect("posts");
			}

		} catch (Exception e) {
			// Handle database connection failure
			cProperty.setContent("Database connection error. Please try again later.");
			cProperty.setContentType("error : Login Failed");
			cProperty.setCssClass("alert alert-danger");
			httpSession.setAttribute("customProperty", cProperty);
			resp.sendRedirect("login");
			logger.error("Error to login servlet : {}", e); // Debugging purpose (You can log this instead)
		}
	}
}
