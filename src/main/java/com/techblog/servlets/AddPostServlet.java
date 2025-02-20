package com.techblog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

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
	private static final Logger LOGGER = Logger.getLogger(AddPostServlet.class.getName());

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
			String pimage = (part != null) ? part.getSubmittedFileName() : "";

			// Validate required fields
			if (cid == 0 || ptitle.isEmpty() || pcontent.isEmpty()) {
				pw.print("{\"status\":\"error\", \"message\":\"Missing required fields\"}");
				return;
			}

			Post post = new Post(ptitle, pcontent, pcode, pimage, cid, uid);

			if (postDao.savePost(post)) {
				if (!pimage.isEmpty()) {
					String path = req.getServletContext().getRealPath("assets/blog_pics") + File.separator + pimage;
					FileManager.saveFile(part.getInputStream(), path);
				}
				pw.print("{\"status\":\"success\", \"message\":\"Posted successful!\", \"redirect\":\"login\"}");
			} else {
				pw.print("{\"status\":\"error\", \"message\":\"Database error\"}");
			}
		} catch (NumberFormatException e) {
			LOGGER.log(Level.SEVERE, "Invalid category ID", e);
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Error processing post request", e);
		}
	}
}
