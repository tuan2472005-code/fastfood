package com.fastfood.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fastfood.model.Review;
import com.fastfood.util.DBUtil;

public class ReviewDAO {
    
    public List<Review> getReviewsByProductId(int productId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM danh_gia WHERE san_pham_id = ? AND trang_thai = 'approved' ORDER BY ngay_tao DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, productId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setId(rs.getInt("id"));
                    review.setSanPhamId(rs.getInt("san_pham_id"));
                    review.setNguoiDungId(rs.getObject("nguoi_dung_id", Integer.class));
                    review.setHoTen(rs.getString("ho_ten"));
                    review.setEmail(rs.getString("email"));
                    review.setRating(rs.getInt("rating"));
                    review.setBinhLuan(rs.getString("binh_luan"));
                    review.setNgayTao(rs.getTimestamp("ngay_tao"));
                    review.setTrangThai(rs.getString("trang_thai"));
                    reviews.add(review);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return reviews;
    }
    
    public boolean addReview(Review review) {
        String sql = "INSERT INTO danh_gia (san_pham_id, nguoi_dung_id, ho_ten, email, rating, binh_luan, trang_thai) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, review.getSanPhamId());
            stmt.setObject(2, review.getNguoiDungId());
            stmt.setString(3, review.getHoTen());
            stmt.setString(4, review.getEmail());
            stmt.setInt(5, review.getRating());
            stmt.setString(6, review.getBinhLuan());
            stmt.setString(7, review.getTrangThai());
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public double getAverageRating(int productId) {
        String sql = "SELECT AVG(rating) as avg_rating FROM danh_gia WHERE san_pham_id = ? AND trang_thai = 'approved'";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, productId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("avg_rating");
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    public int getReviewCount(int productId) {
        String sql = "SELECT COUNT(*) as review_count FROM danh_gia WHERE san_pham_id = ? AND trang_thai = 'approved'";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, productId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("review_count");
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT dg.*, sp.ten as ten_san_pham FROM danh_gia dg " +
                    "LEFT JOIN san_pham sp ON dg.san_pham_id = sp.id " +
                    "ORDER BY dg.ngay_tao DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setId(rs.getInt("id"));
                    review.setSanPhamId(rs.getInt("san_pham_id"));
                    review.setNguoiDungId(rs.getObject("nguoi_dung_id", Integer.class));
                    review.setHoTen(rs.getString("ho_ten"));
                    review.setEmail(rs.getString("email"));
                    review.setRating(rs.getInt("rating"));
                    review.setBinhLuan(rs.getString("binh_luan"));
                    review.setNgayTao(rs.getTimestamp("ngay_tao"));
                    review.setTrangThai(rs.getString("trang_thai"));
                    reviews.add(review);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return reviews;
    }
    
    public boolean updateReviewStatus(int reviewId, String status) {
        String sql = "UPDATE danh_gia SET trang_thai = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, reviewId);
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteReview(int reviewId) {
        String sql = "DELETE FROM danh_gia WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, reviewId);
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}