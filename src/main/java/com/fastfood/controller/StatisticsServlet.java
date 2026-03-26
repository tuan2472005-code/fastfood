package com.fastfood.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fastfood.dao.OrderDAO;
import com.fastfood.dao.ProductDAO;
import com.fastfood.dao.UserDAO;
import com.fastfood.model.Order;
import com.fastfood.model.Product;
import com.fastfood.model.User;

public class StatisticsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private OrderDAO orderDAO;
    private ProductDAO productDAO;
    private UserDAO userDAO;
    
    public void init() {
        orderDAO = new OrderDAO();
        productDAO = new ProductDAO();
        userDAO = new UserDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !("ADMIN".equals(user.getRole()) || "STAFF".equals(user.getRole()))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Thống kê tổng quan
            Map<String, Object> statistics = new HashMap<>();
            
            // Tổng số đơn hàng
            List<Order> allOrders = orderDAO.getAllOrders();
            statistics.put("totalOrders", allOrders.size());
            
            // Tổng doanh thu
            BigDecimal totalRevenue = BigDecimal.ZERO;
            for (Order order : allOrders) {
                if ("DA_GIAO".equals(order.getStatus())) {
                    totalRevenue = totalRevenue.add(order.getTotalAmount());
                }
            }
            statistics.put("totalRevenue", totalRevenue);
            
            // Tổng số sản phẩm
            List<Product> allProducts = productDAO.getAllProducts();
            statistics.put("totalProducts", allProducts.size());
            
            // Tổng số người dùng
            List<User> allUsers = userDAO.getAllUsers();
            statistics.put("totalUsers", allUsers.size());
            
            // Thống kê theo trạng thái đơn hàng
            Map<String, Integer> orderStatusStats = new HashMap<>();
            orderStatusStats.put("CHO_XAC_NHAN", 0);
            orderStatusStats.put("DANG_CHUAN_BI", 0);
            orderStatusStats.put("DANG_GIAO", 0);
            orderStatusStats.put("DA_GIAO", 0);
            orderStatusStats.put("DA_HUY", 0);
            
            for (Order order : allOrders) {
                String status = order.getStatus();
                orderStatusStats.put(status, orderStatusStats.getOrDefault(status, 0) + 1);
            }
            
            // Thống kê doanh thu theo tháng
            List<Object[]> monthlyRevenue = orderDAO.getMonthlyRevenue();
            
            // Sản phẩm bán chạy nhất
            List<Object[]> topProducts = orderDAO.getTopSellingProducts();
            
            // Đơn hàng gần đây (lấy 10 đơn hàng đầu tiên)
            List<Order> recentOrders = allOrders.size() > 10 ? allOrders.subList(0, 10) : allOrders;
            
            request.setAttribute("statistics", statistics);
            request.setAttribute("orderStatusStats", orderStatusStats);
            request.setAttribute("countPending", orderStatusStats.get("CHO_XAC_NHAN"));
            request.setAttribute("countPreparing", orderStatusStats.get("DANG_CHUAN_BI"));
            request.setAttribute("countDelivering", orderStatusStats.get("DANG_GIAO"));
            request.setAttribute("countDelivered", orderStatusStats.get("DA_GIAO"));
            request.setAttribute("countCancelled", orderStatusStats.get("DA_HUY"));
            request.setAttribute("monthlyRevenue", monthlyRevenue);
            request.setAttribute("topProducts", topProducts);
            request.setAttribute("recentOrders", recentOrders);
            
            request.getRequestDispatcher("/WEB-INF/views/admin/statistics.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải thống kê");
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
