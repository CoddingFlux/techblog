package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;

import com.techblog.entitties.Comment;


public class CommentDao {

	private static final Logger logger = (Logger) LoggerFactory.getLogger(CommentDao.class);
	private static final String SAVE_COMMENT_QUERY = "INSERT INTO comment (comessage,pid,uid) VALUES (?,?,?)";
	private static final String GET_COMMENT_BY_PID_UID_QUERY = "SELECT comessage,pid,uid,potime FROM comment WHERE pid=? ORDER BY coid ASC";

	private Connection con;

	public CommentDao(Connection con) {
		super();
		this.con = con;
	}

	public boolean saveComment(Comment co) {

		boolean isSaved = false;

		try (PreparedStatement pstmt = con.prepareStatement(SAVE_COMMENT_QUERY)) {

			pstmt.setString(1, co.getComessage());
			pstmt.setLong(2, co.getPid());
			pstmt.setLong(3, co.getUid());

			isSaved = pstmt.executeUpdate() > 0;

		} catch (Exception e) {
			logger.error("Error to save comment with pid is {} and uid is {} : {} ", co.getPid(), co.getUid(),
					e.getMessage(), e);
		}

		return isSaved;
	}

	public List<Comment> getCommentMsgByPid(Long pid) {

		List<Comment> commentList = new ArrayList<Comment>();

		try (PreparedStatement pstmt = con.prepareStatement(GET_COMMENT_BY_PID_UID_QUERY)) {

			pstmt.setLong(1, pid);

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					Comment co = new Comment(rs.getString("comessage"), rs.getLong("pid"), rs.getLong("uid"),
							rs.getTimestamp("potime"));
					commentList.add(co);
				}
			}

		} catch (SQLException e) {
			logger.error("Error fetching comment for pid : {} and uid : {} : {}", pid, e.getMessage(), e);
		}

		return commentList;

	}
}
