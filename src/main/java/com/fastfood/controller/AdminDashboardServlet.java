package com.fastfood.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fastfood.dao.OrderDAO;
import com.fastfood.dao.ProductDAO;
import com.fastfood.dao.UserDAO;
import com.fastfood.model.Order;
import com.fastfood.model.User;

public class AdminDashboardServlet extends HttpServlet {
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
            // Lấy thống kê tổng quan
            int totalOrders = orderDAO.getTotalOrderCount();
            double totalRevenue = orderDAO.getTotalRevenue();
            int totalProducts = productDAO.getTotalProductCount();
            int totalUsers = userDAO.getTotalUserCount();
            
            // Lấy đơn hàng gần đây (5 đơn hàng mới nhất)
            List<Order> recentOrders = orderDAO.getRecentOrders(5);
            java.util.Map<String, Integer> statusCounts = orderDAO.getOrderCountsByStatus();
            
            // Đặt thuộc tính cho request
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("recentOrders", recentOrders);
            request.setAttribute("countPending", statusCounts.get("CHO_XAC_NHAN"));
            request.setAttribute("countPreparing", statusCounts.get("DANG_CHUAN_BI"));
            request.setAttribute("countDelivering", statusCounts.get("DANG_GIAO"));
            request.setAttribute("countDelivered", statusCounts.get("DA_GIAO"));
            request.setAttribute("countCancelled", statusCounts.get("DA_HUY"));
            
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            // Nếu có lỗi, vẫn hiển thị dashboard với dữ liệu mặc định
            request.setAttribute("error", "Có lỗi xảy ra khi tải dữ liệu thống kê");
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
