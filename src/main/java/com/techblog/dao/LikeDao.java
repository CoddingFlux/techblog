package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LikeDao {

	Connection con;

	public LikeDao(Connection con) {
		super();
		this.con = con;
	}

	private static final Logger logger = LoggerFactory.getLogger(LikeDao.class);

	private static final String SAVE_LIKE_QUERY = "INSERT INTO liked (pid,uid) VALUES (?,?)";

	private static final String COUNT_POST_LIKE_QUERY = "SELECT COUNT(*) AS total_post FROM liked WHERE pid=?";

	private static final String CHECK_LIKE_QUERY = "SELECT * FROM liked WHERE pid=? AND uid=?";

	private static final String DELETE_LIKE_QUERY = "DELETE FROM liked WHERE pid=? AND uid=?";

	public boolean saveLiked(Long pid, Long uid) {

		boolean isSaved = false;

		try {
			PreparedStatement pstmt = con.prepareStatement(SAVE_LIKE_QUERY);

			pstmt.setLong(1, pid);
			pstmt.setLong(2, uid);

			isSaved = pstmt.executeUpdate() > 0;

		} catch (Exception e) {
			logger.error("Error to save like with pid is {} and uid is {} : {} ", pid, uid, e.getMessage(), e);
		}

		return isSaved;
	}

	public Long countPostLikes(Long pid) {

		Long postCount = 0l;

		try {
			PreparedStatement pstmt = con.prepareStatement(COUNT_POST_LIKE_QUERY);

			pstmt.setLong(1, pid);
			ResultSet total_post = pstmt.executeQuery();
			postCount = total_post.next() ? total_post.getLong("total_post") : 0l;

		} catch (Exception e) {
			logger.error("Error to counting post likes where pid is {} : {} ", pid, e.getMessage(), e);
		}

		return postCount;

	}

	public boolean isPostLikedByUser(Long pid, Long uid) {

		try {
			PreparedStatement pstmt = con.prepareStatement(CHECK_LIKE_QUERY);

			pstmt.setLong(1, pid);
			pstmt.setLong(2, uid);

			try (ResultSet total_post = pstmt.executeQuery()) {
				return total_post.next();
			}
		} catch (Exception e) {
			logger.error("Error checking if post {} is liked by user {} : {}", pid, uid, e.getMessage(), e);
		}

		return false;

	}

	public boolean deleteLiked(Long pid, Long uid) {

		boolean isPostLikeRemoved = false;

		try {
			PreparedStatement pstmt = con.prepareStatement(DELETE_LIKE_QUERY);

			pstmt.setLong(1, pid);
			pstmt.setLong(2, uid);

			isPostLikeRemoved = pstmt.executeUpdate() > 0;

		} catch (Exception e) {
			logger.error("Error to delete like where pid is {} and uid is {} : {} ", pid, uid, e.getMessage(), e);
		}

		return isPostLikeRemoved;
	}

}
