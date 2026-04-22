package com.fastfood.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import com.fastfood.model.Order;
import com.fastfood.model.OrderItem;
import com.fastfood.util.DBUtil;

public class OrderDAO {
    
    public List<Order> getAllOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT dh.id, dh.nguoi_dung_id, dh.tong_tien, dh.phi_ship, dh.trang_thai, dh.phuong_thuc_thanh_toan, " +
                     "dh.dia_chi_giao_hang, dh.so_dien_thoai_giao_hang, dh.ten_nguoi_nhan, dh.ghi_chu, " +
                     "dh.voucher_id, dh.voucher_code, dh.discount_amount, " +
                     "dh.ngay_tao, dh.ngay_cap_nhat, nd.ho_ten as customer_name " +
                    "FROM don_hang dh " +
                    "LEFT JOIN nguoi_dung nd ON dh.nguoi_dung_id = nd.id " +
                    "ORDER BY dh.ngay_tao DESC";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement() 
             ResultSet rs = stmt.executeQuery(sql));{
              System.out.println(sql);
            while (rs.next()) {
                Order order = mapResultSetToOrderSimple(rs);
                // Set customer name from JOIN
                order.setCustomerName(rs.getString("customer_name"));
                orders.add(order);
            }
        }
        
        return orders;
    }
    
    public List<Order> getOrdersByUserId(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT id, nguoi_dung_id, tong_tien, phi_ship, trang_thai, phuong_thuc_thanh_toan, " +
                     "dia_chi_giao_hang, so_dien_thoai_giao_hang, ten_nguoi_nhan, ghi_chu, " +
                     "voucher_id, voucher_code, discount_amount, " +
                     "ngay_tao, ngay_cap_nhat " +
                     "FROM don_hang WHERE nguoi_dung_id = ? ORDER BY ngay_tao DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Order order = mapResultSetToOrderSimple(rs);
                    orders.add(order);
                }
            }
        }
        
        return orders;
    }
    
    public Order getOrderById(int id) throws SQLException {
        String sql = "SELECT id, nguoi_dung_id, tong_tien, phi_ship, trang_thai, phuong_thuc_thanh_toan, " +
                     "dia_chi_giao_hang, so_dien_thoai_giao_hang, ten_nguoi_nhan, ghi_chu, " +
                     "voucher_id, voucher_code, discount_amount, " +
                     "shipping_voucher_id, shipping_voucher_code, shipping_discount_amount, " +
                     "ngay_tao, ngay_cap_nhat " +
                     "FROM don_hang WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToOrder(rs);
                }
            }
        }
        
        return null;
    }

    /**
     * Lấy danh sách chi tiết đơn hàng (OrderItem) theo mã đơn hàng
     */
    public List<OrderItem> getOrderItemsByOrderId(int orderId) throws SQLException {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT ctdh.*, sp.ten as product_name, sp.mo_ta as product_description, sp.hinh_anh as image_url " +
                     "FROM chi_tiet_don_hang ctdh " +
                     "JOIN san_pham sp ON ctdh.san_pham_id = sp.id " +
                     "WHERE ctdh.don_hang_id = ? " +
                     "ORDER BY ctdh.id";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(rs.getInt("id"));
                    item.setOrderId(rs.getInt("don_hang_id"));
                    item.setProductId(rs.getInt("san_pham_id"));
                    item.setQuantity(rs.getInt("so_luong"));
                    item.setPrice(rs.getBigDecimal("gia"));
                    item.setSubtotal(rs.getBigDecimal("thanh_tien"));

                    // Set flattened fields for JSP convenience
                    item.setProductName(rs.getString("product_name"));
                    // Chúng ta sẽ để mô tả/hình ảnh trên đối tượng Product nếu có

                    // Nạp đối tượng Product tối thiểu
                    com.fastfood.model.Product product = new com.fastfood.model.Product();
                    product.setId(rs.getInt("san_pham_id"));
                    product.setName(rs.getString("product_name"));
                    product.setDescription(rs.getString("product_description"));
                    product.setImageUrl(rs.getString("image_url"));
                    item.setProduct(product);

                    orderItems.add(item);
                }
            }
        }

        return orderItems;
    }
    
    public int createOrder(Order order) throws SQLException {
        String sql = "INSERT INTO don_hang (nguoi_dung_id, tong_tien, phi_ship, trang_thai, phuong_thuc_thanh_toan, dia_chi_giao_hang, " +
                     "so_dien_thoai_giao_hang, ten_nguoi_nhan, ghi_chu, voucher_id, voucher_code, discount_amount, " +
                     "shipping_voucher_id, shipping_voucher_code, shipping_discount_amount, ngay_tao, ngay_cap_nhat) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, order.getUserId());
            stmt.setBigDecimal(2, order.getTotalAmount());
            if (order.getShippingFee() != null) {
                stmt.setBigDecimal(3, order.getShippingFee());
            } else {
                stmt.setBigDecimal(3, BigDecimal.ZERO);
            }
            stmt.setString(4, order.getStatus());
            stmt.setString(5, order.getPaymentMethod());
            stmt.setString(6, order.getShippingAddress());
            stmt.setString(7, order.getShippingPhone());
            stmt.setString(8, order.getShippingName());
            stmt.setString(9, order.getNote());
            
            // Set product voucher information
            if (order.getVoucherId() != null) {
                stmt.setInt(10, order.getVoucherId());
            } else {
                stmt.setNull(10, java.sql.Types.INTEGER);
            }
            stmt.setString(11, order.getVoucherCode());
            if (order.getDiscountAmount() != null) {
                stmt.setBigDecimal(12, order.getDiscountAmount());
            } else {
                stmt.setBigDecimal(12, BigDecimal.ZERO);
            }
            
            // Set shipping voucher information
            if (order.getShippingVoucherId() != null) {
                stmt.setInt(13, order.getShippingVoucherId());
            } else {
                stmt.setNull(13, java.sql.Types.INTEGER);
            }
            stmt.setString(14, order.getShippingVoucherCode());
            if (order.getShippingDiscountAmount() != null) {
                stmt.setBigDecimal(15, order.getShippingDiscountAmount());
            } else {
                stmt.setBigDecimal(15, BigDecimal.ZERO);
            }
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        }
        
        return -1;
    }
    
    public boolean updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE don_hang SET trang_thai = ?, ngay_cap_nhat = NOW() WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    public boolean deleteOrder(int id) throws SQLException {
        String sql = "DELETE FROM don_hang WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("nguoi_dung_id"));
        order.setTotalAmount(rs.getBigDecimal("tong_tien"));
        order.setShippingFee(rs.getBigDecimal("phi_ship"));
        order.setStatus(rs.getString("trang_thai"));
        order.setPaymentMethod(rs.getString("phuong_thuc_thanh_toan"));
        order.setShippingAddress(rs.getString("dia_chi_giao_hang"));
        order.setShippingPhone(rs.getString("so_dien_thoai_giao_hang"));
        order.setShippingName(rs.getString("ten_nguoi_nhan"));
        order.setNote(rs.getString("ghi_chu"));
        order.setCreatedAt(rs.getTimestamp("ngay_tao"));
        order.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
        
        // Set product voucher information
        Integer voucherId = rs.getInt("voucher_id");
        if (!rs.wasNull()) {
            order.setVoucherId(voucherId);
        }
        order.setVoucherCode(rs.getString("voucher_code"));
        order.setDiscountAmount(rs.getBigDecimal("discount_amount"));
        
        // Set shipping voucher information
        Integer shippingVoucherId = rs.getInt("shipping_voucher_id");
        if (!rs.wasNull()) {
            order.setShippingVoucherId(shippingVoucherId);
        }
        order.setShippingVoucherCode(rs.getString("shipping_voucher_code"));
        order.setShippingDiscountAmount(rs.getBigDecimal("shipping_discount_amount"));
        
        // Set customer name if available (from JOIN)
        try {
            String customerName = rs.getString("customer_name");
            if (customerName != null) {
                order.setCustomerName(customerName);
            }
        } catch (SQLException e) {
            // Column doesn't exist, ignore
        }
        
        return order;
    }
    
    private Order mapResultSetToOrderSimple(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("nguoi_dung_id"));
        order.setTotalAmount(rs.getBigDecimal("tong_tien"));
        order.setShippingFee(rs.getBigDecimal("phi_ship"));
        order.setStatus(rs.getString("trang_thai"));
        order.setPaymentMethod(rs.getString("phuong_thuc_thanh_toan"));
        order.setShippingAddress(rs.getString("dia_chi_giao_hang"));
        order.setShippingPhone(rs.getString("so_dien_thoai_giao_hang"));
        order.setShippingName(rs.getString("ten_nguoi_nhan"));
        order.setNote(rs.getString("ghi_chu"));
        order.setCreatedAt(rs.getTimestamp("ngay_tao"));
        order.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
        
        // Set product voucher information
        Integer voucherId = rs.getInt("voucher_id");
        if (!rs.wasNull()) {
            order.setVoucherId(voucherId);
        }
        order.setVoucherCode(rs.getString("voucher_code"));
        order.setDiscountAmount(rs.getBigDecimal("discount_amount"));
        
        // Set customer name if available (from JOIN)
        try {
            String customerName = rs.getString("customer_name");
            if (customerName != null) {
                order.setCustomerName(customerName);
            }
        } catch (SQLException e) {
            // Column doesn't exist, ignore
        }
        
        return order;
    }
    
    public List<Object[]> getMonthlyRevenue() throws SQLException {
    String sql = "SELECT EXTRACT(MONTH FROM ngay_tao) AS month, " +
             "EXTRACT(YEAR FROM ngay_tao) AS year, " +
             "SUM(tong_tien) AS revenue " +
             "FROM don_hang " +
             "WHERE trang_thai = 'DA_GIAO' " +
             "GROUP BY EXTRACT(YEAR FROM ngay_tao), EXTRACT(MONTH FROM ngay_tao) " +
             "ORDER BY year DESC, month DESC " +
             "LIMIT 12";
        
        List<Object[]> monthlyRevenue = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Object[] data = new Object[3];
                data[0] = rs.getInt("month");
                data[1] = rs.getInt("year");
                data[2] = rs.getBigDecimal("revenue");
                monthlyRevenue.add(data);
            }
        }
        return monthlyRevenue;
    }
    
    public List<Object[]> getTopSellingProducts() throws SQLException {
        String sql = "SELECT p.ten, SUM(oi.so_luong) as total_sold, SUM(oi.so_luong * oi.gia) as total_revenue " +
                    "FROM chi_tiet_don_hang oi " +
                    "JOIN san_pham p ON oi.san_pham_id = p.id " +
                    "JOIN don_hang o ON oi.don_hang_id = o.id " +
                    "WHERE o.trang_thai = 'DA_GIAO' " +
                    "GROUP BY p.id, p.ten " +
                    "ORDER BY total_sold DESC LIMIT 10";
        
        
        List<Object[]> topProducts = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Object[] data = new Object[3];
                data[0] = rs.getString("ten");
                data[1] = rs.getInt("total_sold");
                data[2] = rs.getBigDecimal("total_revenue");
                topProducts.add(data);
            }
        }
        return topProducts;
    }
    
    public boolean addOrderItem(OrderItem orderItem) throws SQLException {
        String sql = "INSERT INTO chi_tiet_don_hang (don_hang_id, san_pham_id, ten_san_pham, gia, so_luong, thanh_tien) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderItem.getOrderId());
            stmt.setInt(2, orderItem.getProductId());
            stmt.setString(3, orderItem.getProductName());
            stmt.setBigDecimal(4, orderItem.getPrice());
            stmt.setInt(5, orderItem.getQuantity());
            stmt.setBigDecimal(6, orderItem.getSubtotal());
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    public int getTotalOrderCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM don_hang";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        
        return 0;
    }
    
    public double getTotalRevenue() throws SQLException {
        String sql = "SELECT SUM(tong_tien) FROM don_hang WHERE trang_thai = 'DA_GIAO'";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getDouble(1);
            }
        }
        
        return 0.0;
    }
    
    public List<Order> getRecentOrders(int limit) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT dh.id, dh.nguoi_dung_id, dh.tong_tien, dh.phi_ship, dh.trang_thai, dh.phuong_thuc_thanh_toan, " +
                     "dh.dia_chi_giao_hang, dh.so_dien_thoai_giao_hang, dh.ten_nguoi_nhan, dh.ghi_chu, " +
                     "dh.voucher_id, dh.voucher_code, dh.discount_amount, " +
                     "dh.ngay_tao, dh.ngay_cap_nhat, nd.ho_ten as customer_name " +
                    "FROM don_hang dh " +
                    "LEFT JOIN nguoi_dung nd ON dh.nguoi_dung_id = nd.id " +
                    "ORDER BY dh.ngay_tao DESC LIMIT ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Order order = mapResultSetToOrderSimple(rs);
                    // Set customer name from JOIN
                    order.setCustomerName(rs.getString("customer_name"));
                    orders.add(order);
                }
            }
        }
        
        return orders;
    }

    public Map<String, Integer> getOrderCountsByStatus() throws SQLException {
        String sql = "SELECT trang_thai, COUNT(*) AS cnt FROM don_hang GROUP BY trang_thai";
        Map<String, Integer> counts = new HashMap<>();
        counts.put("CHO_XAC_NHAN", 0);
        counts.put("DANG_CHUAN_BI", 0);
        counts.put("DANG_GIAO", 0);
        counts.put("DA_GIAO", 0);
        counts.put("DA_HUY", 0);
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                String status = rs.getString("trang_thai");
                int cnt = rs.getInt("cnt");
                counts.put(status, cnt);
            }
        }
        return counts;
    }
}
