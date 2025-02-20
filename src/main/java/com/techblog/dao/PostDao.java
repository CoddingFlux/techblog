package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.techblog.entitties.Categories;
import com.techblog.entitties.Post;

public class PostDao {

	Connection con;

	public PostDao(Connection con) {
		super();
		this.con = con;
	}

	private static final Logger logger = LoggerFactory.getLogger(PostDao.class);

	private static final String GET_ALL_CATEGORIES_QUERY = "SELECT * FROM categories";

	private static final String SAVE_POST_QUERY = "INSERT INTO blogpost (ptitle, pcontent, pcode, pimage, cid, uid) VALUES (?, ?, ?, ?, ?, ?)";

	private static final String GET_ALL_POST_QUERY = "SELECT pid, ptitle, pcontent, pcode, pimage, pdate, cid, uid FROM blogpost ORDER BY pdate DESC";

	private static final String GET_POSTS_BY_CATEGORY_QUERY = "SELECT pid, ptitle, pcontent, pcode, pimage, pdate, uid FROM blogpost WHERE cid=? ORDER BY pid DESC";

	private static final String GET_POST_BY_ID_QUERY = "SELECT ptitle, pcontent, pcode, pdate, pimage, cid, uid FROM blogpost WHERE pid=?";

	private static final String GET_USER_BY_ID_QUERY = "SELECT uname FROM user WHERE uid=?";

	private static final String GET_TOP_POST_QUERY = "SELECT pid, ptitle, pcontent FROM blogpost ORDER BY pdate DESC LIMIT 10";

	public List<Categories> getCategoryList() throws ClassNotFoundException {

		List<Categories> list = new ArrayList<Categories>();

		try {
			PreparedStatement pstmt = con.prepareStatement(GET_ALL_CATEGORIES_QUERY);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Categories category = new Categories(rs.getLong("cid"), rs.getString("cname"),
						rs.getString("cdescription"));
				list.add(category);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			logger.error("Error fetching categories: {}", e.getMessage(), e);
		}

		return list;
	}

	public boolean savePost(Post post) {

		boolean isSaved = false;

		try {
				PreparedStatement pstmt = con.prepareStatement(SAVE_POST_QUERY);

			pstmt.setString(1, post.getPtitle());
			pstmt.setString(2, post.getPcontent());
			pstmt.setString(3, post.getPcode());
			pstmt.setString(4, post.getPimage());
			pstmt.setLong(5, post.getCid());
			pstmt.setLong(6, post.getUid());

			return pstmt.executeUpdate() > 0;

		} catch (Exception e) {
			logger.error("Error saving post with title '{}' and uid {}: {}", post.getPtitle(), post.getUid(),
					e.getMessage(), e);
		}

		return isSaved;

	}

	public List<Post> getAllPost() throws ClassNotFoundException {

		List<Post> postList = new ArrayList<>();

		try {
				PreparedStatement pstmt = con.prepareStatement(GET_ALL_POST_QUERY);

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					Post post = new Post(rs.getLong("pid"), rs.getString("ptitle"), rs.getString("pcontent"),
							rs.getString("pcode"), rs.getString("pimage"), rs.getTimestamp("pdate"), rs.getLong("cid"),
							rs.getLong("uid"));
					postList.add(post);
				}
			}

		} catch (SQLException e) {
			logger.error("Error fetching all posts: {}", e.getMessage(), e);
		}

		return postList;
	}
	
	public List<Post> getTopPosts() throws ClassNotFoundException {

		List<Post> postList = new ArrayList<>();

		try {
				PreparedStatement pstmt = con.prepareStatement(GET_TOP_POST_QUERY);

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					Post post = new Post(rs.getLong("pid"), rs.getString("ptitle"), rs.getString("pcontent"));
					postList.add(post);
				}
			}

		} catch (SQLException e) {
			logger.error("Error fetching all posts: {}", e.getMessage(), e);
		}

		return postList;
	}

	public List<Post> getPostByCatId(Long catid) throws ClassNotFoundException {

		List<Post> postList = new ArrayList<>();

		try {
				PreparedStatement pstmt = con.prepareStatement(GET_POSTS_BY_CATEGORY_QUERY);

			pstmt.setLong(1, catid);

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					Post post = new Post(rs.getLong("pid"), rs.getString("ptitle"), rs.getString("pcontent"),
							rs.getString("pcode"), rs.getString("pimage"), rs.getTimestamp("pdate"), rs.getLong("uid"));
					postList.add(post);
				}
			}

		} catch (SQLException e) {
			logger.error("Error fetching posts for category {}: {}", catid, e.getMessage(), e);
		}

		return postList;
	}

	public Post getPostByPostId(Long pid) throws ClassNotFoundException {

		try {
			PreparedStatement pstmt = con.prepareStatement(GET_POST_BY_ID_QUERY);
		
			pstmt.setLong(1, pid);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return new Post(pid, // Since we are querying by pid, we already know it
							rs.getString("ptitle"), rs.getString("pcontent"), rs.getString("pcode"),
							rs.getString("pimage"), rs.getTimestamp("pdate"), rs.getLong("cid"), rs.getLong("uid"));
				}
			}
		} catch (SQLException e) {
			logger.error("Error fetching post with ID {}: {}", pid, e.getMessage(), e);
		}
		return null; // Return null if post not found
	}

	public String getUserByUid(Long uid) throws ClassNotFoundException {

		try {
				PreparedStatement pstmt = con.prepareStatement(GET_USER_BY_ID_QUERY);
			pstmt.setLong(1, uid);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getString("uname");
				}
			}
		} catch (SQLException e) {
			logger.error("Error fetching user with ID {}: {}", uid, e.getMessage(), e);
		}
		return null; // Return null if user not found
	}

}
