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

@WebServlet("/DisLikes")
public class DisLikes extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = (Logger) LoggerFactory.getLogger(DisLikes.class);

	private final LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("application/json");

		try (PrintWriter pw = res.getWriter()) {
			// Validate request parameters
			String pidStr = req.getParameter("pid");
			String uidStr = req.getParameter("uid");
			String operation = req.getParameter("operation");

			if (pidStr == null || uidStr == null || operation == null) {
//                res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
				return;
			}

			Long pid = Long.parseLong(pidStr);
			Long uid = Long.parseLong(uidStr);

			if (!"DisLike".equalsIgnoreCase(operation)) {
				pw.print("{\"status\":\"error\", \"message\":\"Invalid operation\"}");
				return;
			}

			boolean isDeleted = likeDao.deleteLiked(pid, uid);

			if (isDeleted) {
				pw.print("{\"status\":\"success\", \"message\":\"Like removed\"}");
			} else {
				pw.print("{\"status\":\"error\", \"message\":\"Failed to remove like\"}");
			}
		} catch (NumberFormatException e) {
			logger.error("Invalid ID format : {}", e);
//            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
		} catch (Exception e) {
			logger.error("Error processing dislike request : {}", e);
//            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error");
		}
	}
}
