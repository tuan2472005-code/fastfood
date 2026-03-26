package com.fastfood.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fastfood.dao.OrderDAO;
import com.fastfood.dao.ProductDAO;
import com.fastfood.dao.UserDAO;
import com.fastfood.model.Order;

@WebServlet("/debug/stats")
public class DebugStatsServlet extends HttpServlet {
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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head><title>Debug Statistics</title></head>");
        out.println("<body>");
        out.println("<h1>Debug Statistics</h1>");
        
        try {
            // Test các phương thức DAO
            int totalOrders = orderDAO.getTotalOrderCount();
            double totalRevenue = orderDAO.getTotalRevenue();
            int totalProducts = productDAO.getTotalProductCount();
            int totalUsers = userDAO.getTotalUserCount();
            
            out.println("<h2>Statistics Values:</h2>");
            out.println("<p><strong>Total Orders:</strong> " + totalOrders + "</p>");
            out.println("<p><strong>Total Revenue:</strong> " + totalRevenue + "</p>");
            out.println("<p><strong>Total Products:</strong> " + totalProducts + "</p>");
            out.println("<p><strong>Total Users:</strong> " + totalUsers + "</p>");
            
            // Kiểm tra đơn hàng gần đây
            List<Order> recentOrders = orderDAO.getRecentOrders(5);
            out.println("<h2>Recent Orders:</h2>");
            out.println("<p><strong>Recent Orders Count:</strong> " + recentOrders.size() + "</p>");
            
            if (!recentOrders.isEmpty()) {
                out.println("<ul>");
                for (Order order : recentOrders) {
                    out.println("<li>Order #" + order.getId() + " - " + order.getCustomerName() + " - " + order.getTotalAmount() + " - " + order.getStatus() + "</li>");
                }
                out.println("</ul>");
            } else {
                out.println("<p>No recent orders found.</p>");
            }
            
        } catch (SQLException e) {
            out.println("<h2>Error:</h2>");
            out.println("<p style='color: red;'>" + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        
        out.println("</body>");
        out.println("</html>");
    }
}