package com.techblog.helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {

    private static Connection con;

    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            if (con == null) {
                con = DriverManager.getConnection("jdbc:mysql://localhost/techblog", "root", "#Mysql(*)3306#");
                return con;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}
