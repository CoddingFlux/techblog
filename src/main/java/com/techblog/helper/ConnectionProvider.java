package com.techblog.helper;

import java.sql.Connection;
import java.sql.DriverManager;


import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;


public class ConnectionProvider {

	private static final Logger logger = (Logger) LoggerFactory.getLogger(FileManager.class);
	private static Connection con;

	public static Connection getConnection() {

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			if (con == null) {
				con = DriverManager.getConnection("jdbc:mysql://localhost/techblog", "root", "#Mysql(*)3306#");
				logger.info("Connection established... : {}",con);
				return con;
			}

		} catch (Exception e) {
			logger.error("Connection failed...! : {}",e);
		}

		return con;
	}
}
