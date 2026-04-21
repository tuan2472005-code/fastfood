package com.fastfood.util;

import java.sql.Connection; 
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static final String DEFAULT_URL = "jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require";
    private static final String DEFAULT_USER = "postgres.cqockwjguuuckuclwuxk";
    private static final String DEFAULT_PASS = "Tuan0966035418a";

    public static Connection getConnection() {
        try {
            Class.forName("org.postgresql.Driver");

            String url = System.getenv("DB_URL");
            String user = System.getenv("DB_USER");
            String pass = System.getenv("DB_PASS");

            if (url == null || url.isEmpty()) url = DEFAULT_URL;
            if (user == null || user.isEmpty()) user = DEFAULT_USER;
            if (pass == null || pass.isEmpty()) pass = DEFAULT_PASS;

            Connection conn = DriverManager.getConnection(url, user, pass);

            if (conn != null) {
                System.out.println("Connected to database!");
            } else {
                System.out.println("Connection failed!");
            }

            return conn;

        } catch (Exception e) {
            System.out.println("Loi khi ket noi database!");
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        Connection con = getConnection();
        if (con != null) {
            System.out.println("Database san sang!");
        } else {
            System.out.println("Khong the ket noi toi database!");
        }
    }
}
