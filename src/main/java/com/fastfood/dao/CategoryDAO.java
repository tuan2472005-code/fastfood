package com.fastfood.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.fastfood.model.Category;
import com.fastfood.util.DBUtil;

public class CategoryDAO {
    
    public List<Category> getAllCategories() throws SQLException {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM danh_muc ORDER BY id";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("ten"));
                category.setDescription(rs.getString("mo_ta"));
                category.setImageUrl(rs.getString("hinh_anh"));
                category.setCreatedAt(rs.getTimestamp("ngay_tao"));
                category.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
                categories.add(category);
            }
        }
        
        return categories;
    }
    
    public Category getCategoryById(int id) throws SQLException {
        String sql = "SELECT * FROM danh_muc WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Category category = new Category();
                    category.setId(rs.getInt("id"));
                    category.setName(rs.getString("ten"));
                    category.setDescription(rs.getString("mo_ta"));
                    category.setImageUrl(rs.getString("hinh_anh"));
                    category.setCreatedAt(rs.getTimestamp("ngay_tao"));
                    category.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
                    return category;
                }
            }
        }
        
        return null;
    }
    
    public boolean addCategory(Category category) throws SQLException {
        String sql = "INSERT INTO danh_muc (ten, mo_ta, hinh_anh, ngay_tao, ngay_cap_nhat) VALUES (?, ?, ?, NOW(), NOW())";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            stmt.setString(3, category.getImageUrl());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        category.setId(generatedKeys.getInt(1));
                        return true;
                    }
                }
            }
        }
        
        return false;
    }
    
    public boolean updateCategory(Category category) throws SQLException {
        String sql = "UPDATE danh_muc SET ten = ?, mo_ta = ?, hinh_anh = ?, ngay_cap_nhat = NOW() WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            stmt.setString(3, category.getImageUrl());
            stmt.setInt(4, category.getId());
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    public boolean deleteCategory(int id) throws SQLException {
        String sql = "DELETE FROM danh_muc WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
}