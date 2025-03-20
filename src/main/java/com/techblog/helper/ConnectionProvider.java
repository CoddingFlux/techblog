package com.techblog.helper;

import java.sql.Connection;
import java.sql.DriverManager;


import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;


public class ConnectionProvider {

	private static final Logger logger = (Logger) LoggerFactory.getLogger(FileManager.class);
	
//	private static final String URL = "jdbc:postgresql://localhost:5432/techblog";
//    private static final String USER = "postgres";
//    private static final String PASSWORD = "@Renish(*)9092@";
	
	private static final String URL = "jdbc:postgresql://dpg-cve2un3tq21c73eb667g-a.oregon-postgres.render.com:5432/techblogdb_6li7";
	private static final String USER = "techuser";
	private static final String PASSWORD = "1i49y4E0R4eEI8ySWW4XdkH7ydQba6wt";




    private static Connection con;

    public static Connection getConnection() {

		try {

//			Class.forName("com.mysql.cj.jdbc.Driver");
			Class.forName("org.postgresql.Driver");
			if (con == null) {
//				con = DriverManager.getConnection("jdbc:mysql://localhost/techblog", "root", "#Mysql(*)3306#");
				con = DriverManager.getConnection(URL,USER,PASSWORD);
				
				logger.info("Connection established... : {}",con);
				return con;
			}

		} catch (Exception e) {
			logger.error("Connection failed...! : {}",e);
		}

		return con;
	}
}
