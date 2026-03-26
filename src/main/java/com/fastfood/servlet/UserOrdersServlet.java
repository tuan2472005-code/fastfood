package com.fastfood.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fastfood.model.Order;
import com.fastfood.model.OrderItem;
import com.fastfood.model.Product;
import com.fastfood.model.User;
import com.fastfood.util.DBUtil;

@WebServlet("/user/orders")
public class UserOrdersServlet extends HttpServlet {
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
        
        String status = request.getParameter("status");
        
        try {
            List<Order> orders = getUserOrders(user.getId(), status);
            request.setAttribute("orders", orders);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải danh sách đơn hàng");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/user-orders.jsp").forward(request, response);
    }
    
    private List<Order> getUserOrders(int userId, String status) throws SQLException {
        List<Order> orders = new ArrayList<>();
        
        try (Connection conn = DBUtil.getConnection()) {
            StringBuilder sql = new StringBuilder(
                "SELECT dh.*, nd.ho_ten as customer_name " +
                "FROM don_hang dh " +
                "JOIN nguoi_dung nd ON dh.nguoi_dung_id = nd.id " +
                "WHERE dh.nguoi_dung_id = ? "
            );
            
            if (status != null && !status.trim().isEmpty()) {
                sql.append("AND dh.trang_thai = ? ");
            }
            
            sql.append("ORDER BY dh.ngay_tao DESC");
            
            PreparedStatement stmt = conn.prepareStatement(sql.toString());
            stmt.setInt(1, userId);
            
            if (status != null && !status.trim().isEmpty()) {
                stmt.setString(2, status);
            }
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("nguoi_dung_id"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setCustomerPhone(rs.getString("so_dien_thoai_giao_hang"));
                order.setCustomerAddress(rs.getString("dia_chi_giao_hang"));
                order.setTotalAmount(rs.getBigDecimal("tong_tien"));
                order.setStatus(rs.getString("trang_thai"));
                order.setPaymentMethod(rs.getString("phuong_thuc_thanh_toan"));
                order.setNotes(rs.getString("ghi_chu"));
                order.setOrderDate(rs.getTimestamp("ngay_tao"));
                
                // Load order items for this order
                order.setOrderItems(getOrderItems(order.getId()));
                
                orders.add(order);
            }
        }
        
        return orders;
    }
    
    private List<OrderItem> getOrderItems(int orderId) throws SQLException {
        List<OrderItem> orderItems = new ArrayList<>();
        
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT ctdh.*, sp.ten as product_name, sp.hinh_anh as image_url " +
                        "FROM chi_tiet_don_hang ctdh " +
                        "JOIN san_pham sp ON ctdh.san_pham_id = sp.id " +
                        "WHERE ctdh.don_hang_id = ? " +
                        "ORDER BY ctdh.id";
            
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("don_hang_id"));
                item.setProductId(rs.getInt("san_pham_id"));
                item.setQuantity(rs.getInt("so_luong"));
                item.setPrice(rs.getBigDecimal("gia"));
                item.setSubtotal(rs.getBigDecimal("thanh_tien"));
                
                // Create product object with basic info
                Product product = new Product();
                product.setId(rs.getInt("san_pham_id"));
                product.setName(rs.getString("product_name"));
                product.setImageUrl(rs.getString("image_url"));
                
                item.setProduct(product);
                orderItems.add(item);
            }
        }
        
        return orderItems;
    }
}