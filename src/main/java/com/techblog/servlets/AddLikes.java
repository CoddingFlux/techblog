package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;


import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;

import com.techblog.dao.LikeDao;
import com.techblog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddLikes")
public class AddLikes extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = (Logger) LoggerFactory.getLogger(AddLikes.class);

	private final LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("application/json");

		try (PrintWriter pw = res.getWriter()) {
			// Parse parameters safely
			Long pid = Long.valueOf(req.getParameter("pid"));
			Long uid = Long.valueOf(req.getParameter("uid"));
			String operation = req.getParameter("operation");

			// Validate request operation
			if ("Like".equalsIgnoreCase(operation)) {
				boolean success = likeDao.saveLiked(pid, uid);
				pw.print(success ? "{\"status\":\"success\"}" : "{\"status\":\"error\"}");
			} else {
				pw.print("{\"status\":\"invalid_operation\"}");
			}
		} catch (NumberFormatException e) {
			logger.error("Invalid parameters for AddLikes : {}", e);
//            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
		} catch (Exception e) {
			logger.error("Error in AddLikes servlet : {}", e);
//            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error");
		}
	}
}
