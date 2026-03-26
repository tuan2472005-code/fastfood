package com.fastfood.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.fastfood.model.Product;
import com.fastfood.util.DBUtil;

public class ProductDAO {
    
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT sp.*, dm.ten as ten_danh_muc, " +
                    "COALESCE(AVG(dg.rating), 0) as avg_rating, " +
                    "COUNT(dg.id) as review_count " +
                    "FROM san_pham sp " +
                    "LEFT JOIN danh_muc dm ON sp.danh_muc_id = dm.id " +
                    "LEFT JOIN danh_gia dg ON sp.id = dg.san_pham_id AND dg.trang_thai = 'approved' " +
                    "GROUP BY sp.id " +
                    "ORDER BY sp.id ASC";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("ten"));
                product.setDescription(rs.getString("mo_ta"));
                product.setPrice(rs.getBigDecimal("gia"));
                product.setDiscountPrice(rs.getBigDecimal("gia_khuyen_mai"));
                product.setImageUrl(rs.getString("hinh_anh"));
                product.setCategoryId(rs.getInt("danh_muc_id"));
                product.setStatus(rs.getString("trang_thai"));
                product.setStock(rs.getInt("ton_kho"));
                product.setFeatured(rs.getBoolean("noi_bat"));
                product.setCategoryName(rs.getString("ten_danh_muc"));
                product.setAverageRating(rs.getDouble("avg_rating"));
                product.setReviewCount(rs.getInt("review_count"));
                product.setCreatedAt(rs.getTimestamp("ngay_tao"));
                product.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
                products.add(product);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return products;
    }
    
    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT sp.*, dm.ten as ten_danh_muc " +
                    "FROM san_pham sp " +
                    "LEFT JOIN danh_muc dm ON sp.danh_muc_id = dm.id " +
                    "WHERE sp.danh_muc_id = ? " +
                    "ORDER BY sp.id ASC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("ten"));
                    product.setDescription(rs.getString("mo_ta"));
                    product.setPrice(rs.getBigDecimal("gia"));
                    product.setDiscountPrice(rs.getBigDecimal("gia_khuyen_mai"));
                    product.setImageUrl(rs.getString("hinh_anh"));
                    product.setCategoryId(rs.getInt("danh_muc_id"));
                    product.setStatus(rs.getString("trang_thai"));
                    product.setStock(rs.getInt("ton_kho"));
                    product.setFeatured(rs.getBoolean("noi_bat"));
                    product.setCategoryName(rs.getString("ten_danh_muc"));
                    product.setCreatedAt(rs.getTimestamp("ngay_tao"));
                    product.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
                    products.add(product);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return products;
    }
    
    public Product getProductById(int id) {
        String sql = "SELECT sp.*, dm.ten as ten_danh_muc, " +
                    "COALESCE(AVG(dg.rating), 0) as avg_rating, " +
                    "COUNT(dg.id) as review_count " +
                    "FROM san_pham sp " +
                    "LEFT JOIN danh_muc dm ON sp.danh_muc_id = dm.id " +
                    "LEFT JOIN danh_gia dg ON sp.id = dg.san_pham_id AND dg.trang_thai = 'approved' " +
                    "WHERE sp.id = ? " +
                    "GROUP BY sp.id";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("ten"));
                    product.setDescription(rs.getString("mo_ta"));
                    product.setPrice(rs.getBigDecimal("gia"));
                    product.setDiscountPrice(rs.getBigDecimal("gia_khuyen_mai"));
                    product.setImageUrl(rs.getString("hinh_anh"));
                    product.setCategoryId(rs.getInt("danh_muc_id"));
                    product.setStock(rs.getInt("ton_kho"));
                    product.setFeatured(rs.getBoolean("noi_bat"));
                    product.setStatus(rs.getString("trang_thai"));
                    product.setCategoryName(rs.getString("ten_danh_muc"));
                    product.setAverageRating(rs.getDouble("avg_rating"));
                    product.setReviewCount(rs.getInt("review_count"));
                    product.setCreatedAt(rs.getTimestamp("ngay_tao"));
                    product.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
                    return product;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO san_pham (ten, mo_ta, gia, gia_khuyen_mai, hinh_anh, danh_muc_id, ton_kho, noi_bat, trang_thai) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setBigDecimal(3, product.getPrice());
            // Handle null discountPrice
            if (product.getDiscountPrice() != null) {
                stmt.setBigDecimal(4, product.getDiscountPrice());
            } else {
                stmt.setNull(4, java.sql.Types.DECIMAL);
            }
            stmt.setString(5, product.getImageUrl());
            stmt.setInt(6, product.getCategoryId());
            stmt.setInt(7, product.getStock());
            stmt.setBoolean(8, product.isFeatured());
            stmt.setString(9, product.getStatus());
            
            int rowsAffected = stmt.executeUpdate();
            System.out.println("Product added successfully. Rows affected: " + rowsAffected);
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error adding product: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateProduct(Product product) {
        String sql = "UPDATE san_pham SET ten = ?, mo_ta = ?, gia = ?, gia_khuyen_mai = ?, hinh_anh = ?, danh_muc_id = ?, ton_kho = ?, noi_bat = ?, trang_thai = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setBigDecimal(3, product.getPrice());
            // Handle null discountPrice
            if (product.getDiscountPrice() != null) {
                stmt.setBigDecimal(4, product.getDiscountPrice());
            } else {
                stmt.setNull(4, java.sql.Types.DECIMAL);
            }
            stmt.setString(5, product.getImageUrl());
            stmt.setInt(6, product.getCategoryId());
            stmt.setInt(7, product.getStock());
            stmt.setBoolean(8, product.isFeatured());
            stmt.setString(9, product.getStatus());
            stmt.setInt(10, product.getId());
            
            int rowsAffected = stmt.executeUpdate();
            System.out.println("Product updated successfully. Rows affected: " + rowsAffected);
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating product: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM san_pham WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Product> getFeaturedProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT sp.*, dm.ten as ten_danh_muc, " +
                    "COALESCE(AVG(dg.rating), 0) as avg_rating, " +
                    "COUNT(dg.id) as review_count " +
                    "FROM san_pham sp " +
                    "LEFT JOIN danh_muc dm ON sp.danh_muc_id = dm.id " +
                    "LEFT JOIN danh_gia dg ON sp.id = dg.san_pham_id AND dg.trang_thai = 'approved' " +
                    "WHERE sp.trang_thai = 'active' AND sp.noi_bat = 1 " +
                    "GROUP BY sp.id " +
                    "ORDER BY sp.ngay_tao DESC LIMIT 4";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("ten"));
                product.setDescription(rs.getString("mo_ta"));
                product.setPrice(rs.getBigDecimal("gia"));
                product.setDiscountPrice(rs.getBigDecimal("gia_khuyen_mai"));
                product.setImageUrl(rs.getString("hinh_anh"));
                product.setCategoryId(rs.getInt("danh_muc_id"));
                product.setStatus(rs.getString("trang_thai"));
                product.setStock(rs.getInt("ton_kho"));
                product.setFeatured(rs.getBoolean("noi_bat"));
                product.setCategoryName(rs.getString("ten_danh_muc"));
                product.setAverageRating(rs.getDouble("avg_rating"));
                product.setReviewCount(rs.getInt("review_count"));
                product.setCreatedAt(rs.getTimestamp("ngay_tao"));
                product.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
                products.add(product);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        
        return products;
    }
    
    public int getTotalProductCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM san_pham WHERE trang_thai = 'active'";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        
        return 0;
    }
    
    public List<Product> searchProducts(String searchQuery) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM san_pham WHERE (ten LIKE ? OR mo_ta LIKE ?) AND trang_thai = 'active' ORDER BY ten";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + searchQuery + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("ten"));
                    product.setDescription(rs.getString("mo_ta"));
                    product.setPrice(rs.getBigDecimal("gia"));
                    product.setDiscountPrice(rs.getBigDecimal("gia_khuyen_mai"));
                    product.setImageUrl(rs.getString("hinh_anh"));
                    product.setCategoryId(rs.getInt("danh_muc_id"));
                    product.setStatus(rs.getString("trang_thai"));
                    product.setStock(rs.getInt("ton_kho"));
                    product.setFeatured(rs.getBoolean("noi_bat"));
                    product.setCreatedAt(rs.getTimestamp("ngay_tao"));
                    product.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
                    products.add(product);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return products;
    }
}