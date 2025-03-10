package com.techblog.servlets;

import java.io.IOException;

import org.slf4j.LoggerFactory;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseToken;
import com.techblog.dao.UserDao;
import com.techblog.entitties.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.FileManager;
import com.techblog.securityconfig.FirebaseInitializer;
import com.techblog.securityconfig.JwtUtility;

import ch.qos.logback.classic.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/GoogleSignInServlet")
public class GoogleSignInServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger logger = (Logger) LoggerFactory.getLogger(GoogleSignInServlet.class);

	public GoogleSignInServlet() {
		super();
	}

	@Override
	public void init() throws ServletException {
		try {
			FirebaseInitializer.initializeFirebase();
			logger.info("✅ Firebase initialized successfully.");
		} catch (Exception e) {
			logger.error("❌ Firebase initialization failed: {}", e.getMessage(), e);
			throw new ServletException("Firebase initialization failed");
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		logger.info("➡️ GoogleSignInServlet POST request received.");

		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");

		HttpSession httpSession = req.getSession();

		resp.setHeader("Access-Control-Allow-Origin", "*");
		resp.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
		resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
		resp.setHeader("Access-Control-Allow-Credentials", "true");

		try {
			String idToken = req.getParameter("idToken");
			logger.info("🔑 Received ID Token: {}", idToken);
			User user = (User) httpSession.getAttribute("user");
			if (idToken != null && !idToken.isEmpty() && user == null) {

				FirebaseToken decodeToken = FirebaseAuth.getInstance().verifyIdToken(idToken);
				String uemail = decodeToken.getEmail();
				String uname = decodeToken.getName();
				String uprofile = decodeToken.getPicture();

//				uprofile = FileManager.saveGoogleProfileImage(req,uprofile, uemail);

				String token = JwtUtility.generateToken(uemail);
				UserDao udao = new UserDao(ConnectionProvider.getConnection());
				try {
					if (!udao.isUserRegistered(uemail)) {
						uprofile = FileManager.uploadImgOnCloudinary(uprofile,null,"upropics");
					
						user = new User(0l, uemail, uname, uprofile);
						
						if (udao.saveData(user)) {
							user=udao.getUserByEmail(uemail);
							user.setuEmail(uemail);
//							System.out.print("{\"status\":\"success\", \"message\":\"Registration successful!\", \"redirect\":\"login\"}");
						} else {
//							System.out.print("{\"status\":\"badwarn\", \"message\":\"Email already registered!\"}");
						}
					} else {
						user=udao.getUserByEmail(uemail);
						
						user.setuEmail(uemail);
//						System.out.print("{\"status\":\"badwarn\", \"message\":\"Email already registered!\"}");
					}
				} catch (Exception e) {
					e.printStackTrace();
//					System.out.print("{\"status\":\"badwarn\", \"message\":\"Error to register email!\"}");
				}

				httpSession.setAttribute("jwt_token", token);
				httpSession.setAttribute("user", user);
				httpSession.setAttribute("idtoken", idToken);
				logger.info("✅ User Verified Successfully.");

				resp.getWriter().write("{\"status\":true, \"message\":\"Login Successfull.\", \"redirect\":\"posts\"}");
			} else {
				logger.warn("⚠️ ID Token is missing or empty.");
				resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				resp.getWriter().write("{\"success\": false, \"message\": \"ID token is missing\"}");
			}
		} catch (

		Exception e) {
			logger.error("❌ Token verification failed: {}", e.getMessage(), e);
			resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			resp.getWriter().write("{\"success\": false, \"message\": \"Invalid token: " + e.getMessage() + "\"}");
		}
	}
}
