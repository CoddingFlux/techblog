package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;


import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;

import com.techblog.dao.CommentDao;
import com.techblog.entitties.Comment;
import com.techblog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CommentServlet
 */
@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = (Logger) LoggerFactory.getLogger(CommentServlet.class);
	private static final CommentDao codao = new CommentDao(ConnectionProvider.getConnection());

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("application/json");

		try (PrintWriter pw = res.getWriter()) {
			// Parse parameters safely
			String message = req.getParameter("msg");
			Long pid = Long.valueOf(req.getParameter("pid"));
			Long uid = Long.valueOf(req.getParameter("uid"));
			Comment co = new Comment(message, pid, uid);
			boolean success = codao.saveComment(co);
			pw.print(success ? "{\"status\":\"success\"}" : "{\"status\":\"error\"}");
		} catch (NumberFormatException e) {
			logger.error("Invalid parameters for AddLikes : {}", e);
//	            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
		} catch (Exception e) {
			logger.error("Error in AddLikes servlet : {}", e);
//	            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error");
		}

	}

}
