package com.fastfood.util;

import java.sql.Connection; 
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static final String url = "jdbc:postgresql://db.cqockwjguuuckuclwuxk.supabase.co:5432/postgres";
    private static final String user = "postgres";
    private static final String password = "Tuan0966035418@";
    // ✅ Hàm tạo kết nối
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = System.getenv("DB_URL");
            String user = System.getenv("DB_USER");
            String pass = System.getenv("DB_PASS");

            if (url == null || url.isEmpty()) url = DEFAULT_URL;
            if (user == null || user.isEmpty()) user = DEFAULT_USER;
            if (pass == null || pass.isEmpty()) pass = DEFAULT_PASS;

            Connection conn = DriverManager.getConnection(url, user, pass);

            if (conn != null) {
                System.out.println("✅ Connected to database!");
            } else {
                System.out.println("❌ Connection failed!");
            }

            return conn;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Kiểm tra nhanh kết nối
    public static void main(String[] args) {
        Connection con = getConnection();
        if (con != null) {
            System.out.println("✅ Database sẵn sàng!");
        } else {
            System.out.println("❌ Không thể kết nối tới database!");
        }
    }
}
