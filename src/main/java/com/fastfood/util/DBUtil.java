package com.fastfood.util;

import java.sql.Connection; 
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static final String DEFAULT_URL =
        "jdbc:mysql://localhost:3306/fastfood_db?useUnicode=true&characterEncoding=UTF-8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Ho_Chi_Minh";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASS = "root";

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
            System.out.println("✅ Kết nối database thành công!");
            return conn;
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Không tìm thấy MySQL Driver!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi kết nối database!");
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
