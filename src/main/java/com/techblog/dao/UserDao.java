package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.slf4j.LoggerFactory;

import com.techblog.entitties.User;
import com.techblog.helper.HashingProvider;

import ch.qos.logback.classic.Logger;

public class UserDao {

	private Connection con;

	public UserDao(Connection con) {
		super();
		this.con = con;
	}

	private static final Logger logger = (Logger) LoggerFactory.getLogger(UserDao.class);

	private static final String INSERT_USER_QUERY = "INSERT INTO user (uname, uemail, upassword, ugender, uabout,uprofile) VALUES (?, ?, ?, ?, ?,?)";

	private static final String GET_USER_BY_EMAIL_AND_PASSWORD_QUERY = "SELECT uid, uname, uemail, upassword, ugender, uabout, uprofile, uregdate FROM user WHERE uemail=?";

	private static final String UPDATE_USER_QUERY = "UPDATE user SET uname=?, uemail=?, ugender=?, uabout=?, uprofile=? WHERE uid=?";

	private static final String UPDATE_PASSWORD_QUERY = "UPDATE user SET upassword=? WHERE uid=?";

	private static final String GET_USER_BY_UID_QUERY = "SELECT uname,uprofile FROM user WHERE uid=?";

	private static final String GET_USER_BY_EMAIL_QUERY = "SELECT uid,uname,ugender,uabout,uregdate,uprofile FROM user WHERE uemail=?";

	private static final String GET_REGISTERED_USER_QUERY = "SELECT uid FROM user WHERE uemail=?";

	public boolean isUserRegistered(String emailid) {
		try (PreparedStatement pstmt = con.prepareStatement(GET_REGISTERED_USER_QUERY)) {
			pstmt.setString(1, emailid);

			try (ResultSet rs = pstmt.executeQuery()) { // ✅ Use executeQuery() for SELECT
				return rs.next(); // ✅ Returns true if a record is found
			}

		} catch (SQLException e) {
			logger.error("Error checking if user is registered: {}", e.getMessage(), e);
			return false;
		}
	}

	// Save user data
	public boolean saveData(User user) throws ClassNotFoundException {
		try (PreparedStatement pstmt = con.prepareStatement(INSERT_USER_QUERY)) {
			pstmt.setString(1, user.getuName());
			pstmt.setString(2, user.getuEmail());
			pstmt.setString(3, user.getuPassword() == null ? null : HashingProvider.hashProvider(user.getuPassword()));
			pstmt.setString(4, user.getuGender() == null ? null : user.getuGender());
			pstmt.setString(5, user.getuAbout() == null ? "Hey, it is a technical blog" : user.getuAbout());
			pstmt.setString(6,user.getuProfile()== null ? "default.png":user.getuProfile());

			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			logger.error("Error saving user: {}", e.getMessage(), e);
			return false;
		}
	}

	// Get user by username (email) and verify password
	public User getUserByUsernameAndPassword(String email, String password) throws ClassNotFoundException {
		try (PreparedStatement pstmt = con.prepareStatement(GET_USER_BY_EMAIL_AND_PASSWORD_QUERY)) {
			pstmt.setString(1, email);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) { // Ensure a row exists
					String hashpass = rs.getString("upassword").trim(); // Retrieve password hash from DB

					// Verify password hash
					boolean isVerified = HashingProvider.hashVerifyer(password, hashpass);

					if (isVerified) {
						return new User(rs.getLong("uid"), rs.getString("uname"), rs.getString("uemail"),
								rs.getString("upassword"), rs.getString("ugender"), rs.getString("uabout"),
								rs.getString("uprofile"), rs.getTimestamp("uregdate"));
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error("Error retrieving user by email {}: {}", email, e.getMessage(), e);
		}
		return null;
	}

	// Update user data
	public boolean updateUser(User user) throws ClassNotFoundException {
		try (PreparedStatement pstmt = con.prepareStatement(UPDATE_USER_QUERY)) {

			pstmt.setString(1, user.getuName());
			pstmt.setString(2, user.getuEmail());
			pstmt.setString(3, user.getuGender());
			pstmt.setString(4, user.getuAbout());
			pstmt.setString(5, user.getuProfile());
			pstmt.setLong(6, user.getuId());

			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			logger.error("Error updating user ID {}: {}", user.getuId(), e.getMessage(), e);
			return false;
		}
	}

	// Update password
	public boolean updatePassword(Long userId, String password) throws ClassNotFoundException {
		try (PreparedStatement pstmt = con.prepareStatement(UPDATE_PASSWORD_QUERY)) {

			pstmt.setString(1, HashingProvider.hashProvider(password));
			pstmt.setLong(2, userId);

			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			logger.error("Error updating password for user ID {}: {}", userId, e.getMessage(), e);
			return false;
		}
	}

	public User getUserByUid(Long uid) throws ClassNotFoundException {
		try (PreparedStatement pstmt = con.prepareStatement(GET_USER_BY_UID_QUERY)) {
			pstmt.setLong(1, uid);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) { // Ensure a row exists
					return new User(rs.getString("uname"), rs.getString("uprofile"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error("Error retrieving user by uid {}: {}", uid, e.getMessage(), e);
		}
		return null;
	}

	public User getUserByEmail(String email) throws ClassNotFoundException {
		try (PreparedStatement pstmt = con.prepareStatement(GET_USER_BY_EMAIL_QUERY)) {
			pstmt.setString(1, email);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) { // Ensure a row exists
					return new User(rs.getLong("uid"), rs.getString("uname"), rs.getString("ugender"),
							rs.getString("uabout"), rs.getString("uprofile"), rs.getTimestamp("uregdate"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error("Error retrieving userID by email {}: {}", email, e.getMessage(), e);
		}
		return null;
	}
}
