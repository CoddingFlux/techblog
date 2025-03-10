package com.techblog.servlets;


import java.io.IOException;
import java.io.PrintWriter;


import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;

import com.techblog.dao.PostDao;
import com.techblog.entitties.Post;
import com.techblog.entitties.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.FileManager;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/AddPostServlet")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // Limit file size to 5MB
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = (Logger) LoggerFactory.getLogger(AddPostServlet.class);

	private final PostDao postDao = new PostDao(ConnectionProvider.getConnection());

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json");

		try (PrintWriter pw = resp.getWriter()) {
			HttpSession httpSession = req.getSession(false);
			if (httpSession == null || httpSession.getAttribute("user") == null) {
				pw.print("{\"status\":\"error\", \"message\":\"User session expired. Please log in again.\"}");
				return;
			}

			User user = (User) httpSession.getAttribute("user");
			Long uid = user.getuId();
			Long cid = Long.valueOf(req.getParameter("pcategory"));
			String ptitle = req.getParameter("ptitle");
			String pcontent = req.getParameter("pcontent");
			String pcode = req.getParameter("pcode");

			Part part = req.getPart("pimage");
			String pimage = "";

			// Validate required fields
			if (cid == 0 || ptitle == null || ptitle.isEmpty() || pcontent == null || pcontent.isEmpty()) {
				pw.print("{\"status\":\"error\", \"message\":\"Missing required fields\"}");
				return;
			}

			// 🔹 Upload image to Cloudinary (if exists)
			if (part != null && part.getSize() > 0) {
				pimage = FileManager.uploadImgOnCloudinary(null, part,"blogpics");
				if (pimage == null || pimage.isEmpty()) {
					pw.print("{\"status\":\"error\", \"message\":\"Image upload failed. Try again later.\"}");
					return;
				}
			}

			Post post = new Post(ptitle, pcontent, pcode, pimage, cid, uid);

			// 🔹 Save post in DB
			if (postDao.savePost(post)) {
				pw.print("{\"status\":\"success\", \"message\":\"Posted successful!\", \"redirect\":\"login\"}");
			} else {
				pw.print("{\"status\":\"error\", \"message\":\"Database error\"}");
			}
		} catch (NumberFormatException e) {
			logger.error("Invalid category ID: {}", e.getMessage());
			resp.getWriter().print("{\"status\":\"error\", \"message\":\"Invalid category ID\"}");
		} catch (Exception e) {
			logger.error("Error processing post request: {}", e.getMessage());
			resp.getWriter().print("{\"status\":\"error\", \"message\":\"An unexpected error occurred\"}");
		}
	}
}
