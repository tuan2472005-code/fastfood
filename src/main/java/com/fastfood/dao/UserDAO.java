package com.fastfood.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.fastfood.model.User;
import com.fastfood.util.DBUtil;

public class UserDAO {
    
    public User authenticate(String username, String password) {
        String sql = "SELECT * FROM nguoi_dung WHERE ten_dang_nhap = ? AND mat_khau = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("ten_dang_nhap"));
                    user.setPassword(rs.getString("mat_khau"));
                    user.setFullName(rs.getString("ho_ten"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("so_dien_thoai"));
                    user.setAddress(rs.getString("dia_chi"));
                    user.setRole(rs.getString("vai_tro"));
                    try { user.setAvatar(rs.getString("avatar")); } catch (Exception ignore) {}
                    user.setCreatedAt(rs.getTimestamp("ngay_tao"));
                    user.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public boolean registerUser(User user) {
        String sql = "INSERT INTO nguoi_dung (ten_dang_nhap, mat_khau, ho_ten, email, so_dien_thoai, dia_chi, vai_tro) VALUES (?, ?, ?, ?, ?, ?, ?::user_role_enum)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getAddress());
            stmt.setString(7, user.getRole());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM nguoi_dung";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("ten_dang_nhap"));
                user.setPassword(rs.getString("mat_khau"));
                user.setFullName(rs.getString("ho_ten"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("so_dien_thoai"));
                user.setAddress(rs.getString("dia_chi"));
                user.setRole(rs.getString("vai_tro"));
                try { user.setAvatar(rs.getString("avatar")); } catch (Exception ignore) {}
                user.setCreatedAt(rs.getTimestamp("ngay_tao"));
                user.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
                users.add(user);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return users;
    }
    
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM nguoi_dung WHERE ten_dang_nhap = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("ten_dang_nhap"));
                    user.setPassword(rs.getString("mat_khau"));
                    user.setFullName(rs.getString("ho_ten"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("so_dien_thoai"));
                    user.setAddress(rs.getString("dia_chi"));
                    user.setRole(rs.getString("vai_tro"));
                    try { user.setAvatar(rs.getString("avatar")); } catch (Exception ignore) {}
                    user.setCreatedAt(rs.getTimestamp("ngay_tao"));
                    user.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM nguoi_dung WHERE email = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("ten_dang_nhap"));
                    user.setPassword(rs.getString("mat_khau"));
                    user.setFullName(rs.getString("ho_ten"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("so_dien_thoai"));
                    user.setAddress(rs.getString("dia_chi"));
                    user.setRole(rs.getString("vai_tro"));
                    try { user.setAvatar(rs.getString("avatar")); } catch (Exception ignore) {}
                    user.setCreatedAt(rs.getTimestamp("ngay_tao"));
                    user.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public User getUserById(int id) {
        String sql = "SELECT * FROM nguoi_dung WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("ten_dang_nhap"));
                    user.setPassword(rs.getString("mat_khau"));
                    user.setFullName(rs.getString("ho_ten"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("so_dien_thoai"));
                    user.setAddress(rs.getString("dia_chi"));
                    user.setRole(rs.getString("vai_tro"));
                    user.setCreatedAt(rs.getTimestamp("ngay_tao"));
                    user.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public boolean updateUser(User user) {
        String sql = "UPDATE nguoi_dung SET ten_dang_nhap = ?, mat_khau = ?, ho_ten = ?, email = ?, so_dien_thoai = ?, dia_chi = ?, vai_tro = ?::user_role_enum WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            // Ngăn chặn giáng cấp admin cuối cùng
            try {
                User existing = getUserById(user.getId());
                if (existing != null) {
                    boolean isDemoteAdmin = "ADMIN".equals(existing.getRole()) && (user.getRole() == null || !"ADMIN".equals(user.getRole()));
                    if (isDemoteAdmin) {
                        int adminCount = countAdmins();
                        if (adminCount <= 1) {
                            return false;
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Nếu không thể kiểm tra, an toàn hơn là không thực hiện cập nhật gây mất admin cuối cùng
                return false;
            }

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getAddress());
            stmt.setString(7, user.getRole());
            stmt.setInt(8, user.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM nguoi_dung WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            // Ngăn chặn xóa admin cuối cùng
            try {
                User existing = getUserById(id);
                if (existing != null && "ADMIN".equals(existing.getRole())) {
                    int adminCount = countAdmins();
                    if (adminCount <= 1) {
                        return false;
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }

            stmt.setInt(1, id);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int getTotalUserCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM nguoi_dung WHERE vai_tro = 'KHACH_HANG'";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        
        return 0;
    }

    public int countAdmins() throws SQLException {
        String sql = "SELECT COUNT(*) FROM nguoi_dung WHERE vai_tro = 'ADMIN'";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
