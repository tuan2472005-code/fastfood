package com.fastfood.servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.fastfood.model.User;
import com.fastfood.util.DBUtil;

@WebServlet("/user/profile")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5MB max file size
public class UserProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get updated user information from database
        try {
            User updatedUser = getUserFromDatabase(user.getId());
            if (updatedUser != null) {
                session.setAttribute("user", updatedUser);
                request.setAttribute("user", updatedUser);
            } else {
                request.setAttribute("user", user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("user", user);
            request.setAttribute("error", "Không thể tải thông tin người dùng");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/user-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("updateProfile".equals(action)) {
            updateProfile(request, response, user);
        } else if ("changePassword".equals(action)) {
            changePassword(request, response, user);
        } else if ("uploadAvatar".equals(action)) {
            uploadAvatar(request, response, user);
        } else {
            response.sendRedirect(request.getContextPath() + "/user/profile");
        }
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // Validate input
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Họ và tên không được để trống");
            doGet(request, response);
            return;
        }
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email không được để trống");
            doGet(request, response);
            return;
        }
        
        // Check if email is already used by another user
        if (!email.equals(user.getEmail()) && isEmailExists(email, user.getId())) {
            request.setAttribute("error", "Email này đã được sử dụng bởi tài khoản khác");
            doGet(request, response);
            return;
        }
        
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "UPDATE nguoi_dung SET ho_ten = ?, email = ?, so_dien_thoai = ?, dia_chi = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullName.trim());
            stmt.setString(2, email.trim());
            stmt.setString(3, phone != null ? phone.trim() : null);
            stmt.setString(4, address != null ? address.trim() : null);
            stmt.setInt(5, user.getId());
            
            int rowsUpdated = stmt.executeUpdate();
            
            if (rowsUpdated > 0) {
                // Update user object in session
                user.setFullName(fullName.trim());
                user.setEmail(email.trim());
                user.setPhone(phone != null ? phone.trim() : null);
                user.setAddress(address != null ? address.trim() : null);
                
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                try {
                    java.util.List<String> history = (java.util.List<String>) session.getAttribute("activityHistory");
                    if (history == null) history = new java.util.LinkedList<>();
                    history.add(0, "Cập nhật thông tin cá nhân lúc " + new java.text.SimpleDateFormat("HH:mm dd/MM/yyyy").format(new java.util.Date()));
                    if (history.size() > 50) { history = history.subList(0, 50); }
                    session.setAttribute("activityHistory", history);
                } catch (Exception ignore) {}
                
                request.setAttribute("success", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("error", "Không thể cập nhật thông tin");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }
        
        doGet(request, response);
    }
    
    private void uploadAvatar(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        try {
            Part filePart = request.getPart("avatar");
            
            if (filePart == null || filePart.getSize() == 0) {
                request.setAttribute("error", "Vui lòng chọn file ảnh");
                doGet(request, response);
                return;
            }
            
            String fileName = filePart.getSubmittedFileName();
            if (fileName == null || fileName.isEmpty()) {
                request.setAttribute("error", "File không hợp lệ");
                doGet(request, response);
                return;
            }
            
            // Check file type
            String contentType = filePart.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                request.setAttribute("error", "Chỉ chấp nhận file ảnh (JPG, PNG, GIF)");
                doGet(request, response);
                return;
            }
            
            // Check file size (5MB max)
            if (filePart.getSize() > 5 * 1024 * 1024) {
                request.setAttribute("error", "Kích thước file không được vượt quá 5MB");
                doGet(request, response);
                return;
            }
            
            // Create upload directory if not exists
            String uploadPath = getServletContext().getRealPath("/uploads/avatars");
            System.out.println("Upload path: " + uploadPath); // Debug log
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                boolean created = uploadDir.mkdirs();
                System.out.println("Directory created: " + created); // Debug log
            }
            
            // Generate unique filename
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            String uniqueFileName = "avatar_" + user.getId() + "_" + UUID.randomUUID().toString() + fileExtension;
            
            // Save file
            Path filePath = Paths.get(uploadPath, uniqueFileName);
            System.out.println("Saving file to: " + filePath.toString()); // Debug log
            
            Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
            
            // Update database
            String avatarUrl = "uploads/avatars/" + uniqueFileName;
            try (Connection conn = DBUtil.getConnection()) {
                String sql = "UPDATE nguoi_dung SET avatar = ? WHERE id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, avatarUrl);
                stmt.setInt(2, user.getId());
                
                int rowsUpdated = stmt.executeUpdate();
                
                if (rowsUpdated > 0) {
                    // Update user object in session
                    user.setAvatar(avatarUrl);
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    try {
                        java.util.List<String> history = (java.util.List<String>) session.getAttribute("activityHistory");
                        if (history == null) history = new java.util.LinkedList<>();
                        history.add(0, "Cập nhật ảnh đại diện lúc " + new java.text.SimpleDateFormat("HH:mm dd/MM/yyyy").format(new java.util.Date()));
                        if (history.size() > 50) { history = history.subList(0, 50); }
                        session.setAttribute("activityHistory", history);
                    } catch (Exception ignore) {}
                    
                    request.setAttribute("success", "Cập nhật ảnh đại diện thành công!");
                } else {
                    request.setAttribute("error", "Không thể cập nhật ảnh đại diện trong cơ sở dữ liệu");
                }
                
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi upload file: " + e.getMessage());
        }
        
        doGet(request, response);
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        if (currentPassword == null || currentPassword.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập mật khẩu hiện tại");
            doGet(request, response);
            return;
        }
        
        if (newPassword == null || newPassword.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập mật khẩu mới");
            doGet(request, response);
            return;
        }
        
        if (newPassword.length() < 6) {
            request.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự");
            doGet(request, response);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Xác nhận mật khẩu không khớp");
            doGet(request, response);
            return;
        }
        
        // Verify current password
        if (!verifyCurrentPassword(user.getId(), currentPassword)) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng");
            doGet(request, response);
            return;
        }
        
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "UPDATE nguoi_dung SET mat_khau = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword); // In production, should hash the password
            stmt.setInt(2, user.getId());
            
            int rowsUpdated = stmt.executeUpdate();
            
            if (rowsUpdated > 0) {
                request.setAttribute("success", "Đổi mật khẩu thành công!");
                try {
                    java.util.List<String> history = (java.util.List<String>) request.getSession().getAttribute("activityHistory");
                    if (history == null) history = new java.util.LinkedList<>();
                    history.add(0, "Đổi mật khẩu lúc " + new java.text.SimpleDateFormat("HH:mm dd/MM/yyyy").format(new java.util.Date()));
                    if (history.size() > 50) { history = history.subList(0, 50); }
                    request.getSession().setAttribute("activityHistory", history);
                } catch (Exception ignore) {}
            } else {
                request.setAttribute("error", "Không thể đổi mật khẩu");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }
        
        doGet(request, response);
    }
    
    private boolean isEmailExists(String email, int excludeUserId) {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT id FROM nguoi_dung WHERE email = ? AND id != ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setInt(2, excludeUserId);
            
            ResultSet rs = stmt.executeQuery();
            return rs.next();
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private boolean verifyCurrentPassword(int userId, String password) {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT mat_khau FROM nguoi_dung WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("mat_khau");
                return password.equals(storedPassword); // In production, should use password hashing
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    private User getUserFromDatabase(int userId) throws SQLException {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM nguoi_dung WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("ten_dang_nhap"));
                user.setFullName(rs.getString("ho_ten"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("so_dien_thoai"));
                user.setAddress(rs.getString("dia_chi"));
                user.setRole(rs.getString("vai_tro"));
                user.setAvatar(rs.getString("avatar"));
                
                Timestamp createdAt = rs.getTimestamp("ngay_tao");
                if (createdAt != null) {
                    user.setCreatedAt(createdAt);
                }
                
                return user;
            }
        }
        
        return null;
    }
}
