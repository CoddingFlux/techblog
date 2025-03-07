package com.techblog.servlets;

import java.io.IOException;

import org.slf4j.LoggerFactory;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.techblog.entitties.CustomProperty;

import ch.qos.logback.classic.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = (Logger) LoggerFactory.getLogger(LogoutServlet.class);

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json");
		HttpSession session = req.getSession(); // Get session only if it exists

		try {
			if (session != null && session.getAttribute("user") != null && session.getAttribute("idtoken") != null) {
				try {
					FirebaseToken decodedToken = FirebaseAuth.getInstance()
							.verifyIdToken((String) session.getAttribute("idtoken"));
					FirebaseAuth.getInstance().revokeRefreshTokens(decodedToken.getUid());
					session.removeAttribute("user");
					session.removeAttribute("jwt_token");
					session.removeAttribute("idtoken");

					logger.info("✅ Google Sign-In token revoked successfully.");
					resp.sendRedirect("login");
				} catch (FirebaseAuthException e) {
					logger.error("❌ Error revoking Google token: {}", e.getMessage(), e);
					resp.sendRedirect("error");
				}
			} else if (session != null && session.getAttribute("user") != null) {
				session.removeAttribute("user");
				session.removeAttribute("jwt_token");
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
			logger.error("Error during logout : {}", e);
//            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error during logout.");
			resp.sendRedirect("error");
		}
	}
}
