package com.fastfood.dao;

import com.fastfood.model.Voucher;
import com.fastfood.util.DBUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VoucherDAO {
    
    // Tìm voucher theo mã
    public Voucher findByCode(String code) {
        String sql = "SELECT * FROM vouchers WHERE code = ? AND is_active = TRUE";
        
        System.out.println("DEBUG: Searching for voucher with code: " + code);
        System.out.println("DEBUG: SQL query: " + sql);
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            System.out.println("DEBUG: Database connection established");
            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                System.out.println("DEBUG: Voucher found!");
                return mapResultSetToVoucher(rs);
            } else {
                System.out.println("DEBUG: No voucher found with code: " + code);
            }
        } catch (SQLException e) {
            System.out.println("DEBUG: SQL Exception occurred: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    // Tìm voucher theo mã và loại
    public Voucher findByCodeAndType(String code, String voucherType) {
        String sql = "SELECT * FROM vouchers WHERE code = ? AND voucher_type = ? AND is_active = 1";
        
        System.out.println("DEBUG: Searching for voucher with code: " + code + " and type: " + voucherType);
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, code);
            stmt.setString(2, voucherType);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                System.out.println("DEBUG: Voucher found!");
                return mapResultSetToVoucher(rs);
            } else {
                System.out.println("DEBUG: No voucher found with code: " + code + " and type: " + voucherType);
            }
        } catch (SQLException e) {
            System.out.println("DEBUG: SQL Exception occurred: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    // Lấy tất cả voucher
    public List<Voucher> findAll() {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT * FROM vouchers ORDER BY created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                vouchers.add(mapResultSetToVoucher(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vouchers;
    }
    
    // Lấy voucher theo ID
    public Voucher findById(int id) {
        String sql = "SELECT * FROM vouchers WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToVoucher(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Thêm voucher mới
    public boolean save(Voucher voucher) {
        String sql = "INSERT INTO vouchers (code, name, discount_type, discount_value, " +
                    "min_order_amount, max_discount_amount, usage_limit, start_date, end_date, is_active, voucher_type) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, voucher.getCode());
            stmt.setString(2, voucher.getName());
            stmt.setString(3, voucher.getDiscountType());
            stmt.setBigDecimal(4, voucher.getDiscountValue());
            stmt.setBigDecimal(5, voucher.getMinOrderAmount());
            stmt.setBigDecimal(6, voucher.getMaxDiscountAmount());
            stmt.setInt(7, voucher.getUsageLimit());
            stmt.setTimestamp(8, voucher.getStartDate());
            stmt.setTimestamp(9, voucher.getEndDate());
            stmt.setBoolean(10, voucher.isActive());
            stmt.setString(11, voucher.getVoucherType() != null ? voucher.getVoucherType() : "PRODUCT");
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    voucher.setId(generatedKeys.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Cập nhật voucher
    public boolean update(Voucher voucher) {
        String sql = "UPDATE vouchers SET name = ?, discount_type = ?, " +
                    "discount_value = ?, min_order_amount = ?, max_discount_amount = ?, " +
                    "usage_limit = ?, start_date = ?, end_date = ?, is_active = ?, voucher_type = ?, " +
                    "updated_at = CURRENT_TIMESTAMP WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, voucher.getName());
            stmt.setString(2, voucher.getDiscountType());
            stmt.setBigDecimal(3, voucher.getDiscountValue());
            stmt.setBigDecimal(4, voucher.getMinOrderAmount());
            stmt.setBigDecimal(5, voucher.getMaxDiscountAmount());
            stmt.setInt(6, voucher.getUsageLimit());
            stmt.setTimestamp(7, voucher.getStartDate());
            stmt.setTimestamp(8, voucher.getEndDate());
            stmt.setBoolean(9, voucher.isActive());
            stmt.setString(10, voucher.getVoucherType() != null ? voucher.getVoucherType() : "PRODUCT");
            stmt.setInt(11, voucher.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Xóa voucher
    public boolean delete(int id) {
        String sql = "DELETE FROM vouchers WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Tăng số lần sử dụng voucher
    public boolean incrementUsage(int voucherId) {
        String sql = "UPDATE vouchers SET used_count = used_count + 1 WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, voucherId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Kiểm tra mã voucher có tồn tại không
    public boolean existsByCode(String code) {
        String sql = "SELECT COUNT(*) FROM vouchers WHERE code = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Lấy voucher đang hoạt động
    public List<Voucher> findActiveVouchers() {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT * FROM vouchers WHERE is_active = TRUE AND start_date <= NOW() AND end_date >= NOW() ORDER BY created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                vouchers.add(mapResultSetToVoucher(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vouchers;
    }
    
    // Phương thức helper để map ResultSet thành Voucher object
    private Voucher mapResultSetToVoucher(ResultSet rs) throws SQLException {
        Voucher voucher = new Voucher();
        voucher.setId(rs.getInt("id"));
        voucher.setCode(rs.getString("code"));
        voucher.setName(rs.getString("name"));
        voucher.setDescription(""); // Set empty description since column doesn't exist
        voucher.setDiscountType(rs.getString("discount_type"));
        voucher.setDiscountValue(rs.getBigDecimal("discount_value"));
        voucher.setMinOrderAmount(rs.getBigDecimal("min_order_amount"));
        voucher.setMaxDiscountAmount(rs.getBigDecimal("max_discount_amount"));
        voucher.setUsageLimit(rs.getInt("usage_limit"));
        voucher.setUsedCount(rs.getInt("used_count"));
        voucher.setStartDate(rs.getTimestamp("start_date"));
        voucher.setEndDate(rs.getTimestamp("end_date"));
        voucher.setActive(rs.getBoolean("is_active"));
        voucher.setVoucherType(rs.getString("voucher_type"));
        voucher.setCreatedAt(rs.getTimestamp("created_at"));
        voucher.setUpdatedAt(rs.getTimestamp("updated_at"));
        return voucher;
    }
}
