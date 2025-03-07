package com.techblog.servlets;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;

import org.slf4j.LoggerFactory;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseToken;
import com.techblog.dao.UserDao;
import com.techblog.entitties.User;
import com.techblog.helper.ConnectionProvider;
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
				

				try {
				    String fileName = uemail.replaceAll("[^a-zA-Z0-9]", "_") + ".jpg";
				    String uploadDir = "assets/pics/"; // Relative to project root
				    
				    // Get absolute path of the `assets/pics/` folder
				    String absoluteUploadDir = getServletContext().getRealPath("/") + uploadDir;
				    Path uploadPath = Path.of(absoluteUploadDir);
				    Path filePath = uploadPath.resolve(fileName);

				    // Ensure directory exists
				    if (!Files.exists(uploadPath)) {
				        Files.createDirectories(uploadPath);
				    }

				    // Check if the file already exists
				    if (!Files.exists(filePath)) {
				        HttpClient client = HttpClient.newHttpClient();
				        HttpRequest request = HttpRequest.newBuilder()
				                .uri(URI.create(uprofile))
				                .GET()
				                .build();

				        HttpResponse<byte[]> response = client.send(request, HttpResponse.BodyHandlers.ofByteArray());

				        if (response.statusCode() == 200) { // HTTP 200 OK
				            Files.write(filePath, response.body(), StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
				            logger.info("✅ Profile image saved: " + filePath.toString());
				        } else {
				            logger.warn("⚠️ Failed to download profile image. HTTP Status: " + response.statusCode());
				        }
				    } else {
				        logger.info("🖼️ Profile image already exists: " + filePath.toString());
				    }

				    // Update user profile to use the local path
				    uprofile = fileName;

				} catch (IOException | InterruptedException e) {
				    logger.error("❌ Failed to download profile image: {}", e.getMessage(), e);
				}

				
				String token = JwtUtility.generateToken(uemail);
				UserDao udao = new UserDao(ConnectionProvider.getConnection());
				user = new User(0l,uemail,uname,uprofile);
				try {
					if (!udao.isUserRegistered(uemail)) {
						if (udao.saveData(user)) {
							System.out.print("{\"status\":\"success\", \"message\":\"Registration successful!\", \"redirect\":\"login\"}");
						} else {
							System.out.print("{\"status\":\"badwarn\", \"message\":\"Email already registered!\"}");
						}
					} else {
						System.out.print("{\"status\":\"badwarn\", \"message\":\"Email already registered!\"}");
					}
				} catch (Exception e) {
					e.printStackTrace();
					System.out.print("{\"status\":\"badwarn\", \"message\":\"Error to register email!\"}");	
				}

				User useralldetail=udao.getUserByEmail(uemail);
				System.out.println("Uid is : "+useralldetail.getuId());
				user = new User(useralldetail.getuId(),uname,uemail,"",useralldetail.getuGender(),useralldetail.getuAbout(),uprofile,useralldetail.getTimestamp());
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
