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
import com.fastfood.model.Order;
import com.fastfood.model.User;

public class AdminOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private OrderDAO orderDAO = new OrderDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cấu hình encoding UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !("ADMIN".equals(user.getRole()) || "STAFF".equals(user.getRole()))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        boolean isAdmin = "ADMIN".equals(user.getRole());
        switch (action) {
            case "view":
                viewOrder(request, response);
                break;
            case "invoice":
                printInvoice(request, response);
                break;
            case "update":
                if (!isAdmin) { listOrders(request, response); break; }
                updateOrderStatus(request, response);
                break;
            case "updateStatus":
                if (!isAdmin) { viewOrder(request, response); break; }
                updateOrderStatusFromForm(request, response);
                break;
            default:
                listOrders(request, response);
                break;
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void listOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Order> orders = orderDAO.getAllOrders();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/WEB-INF/views/admin/order-list.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving orders", e);
        }
    }
    
    private void viewOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xử lý tham số id không hợp lệ
        int orderId;
        try {
            orderId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException nfe) {
            try {
                request.setAttribute("errorMessage", "Tham số đơn hàng không hợp lệ.");
                List<Order> orders = orderDAO.getAllOrders();
                request.setAttribute("orders", orders);
                request.getRequestDispatcher("/WEB-INF/views/admin/order-list.jsp").forward(request, response);
                return;
            } catch (SQLException e) {
                throw new ServletException("Error retrieving orders", e);
            }
        }
 
 
        
        try {
            Order order = orderDAO.getOrderById(orderId);

            // Nếu không tìm thấy đơn hàng, quay về danh sách với thông báo lỗi
            if (order == null) {
                request.setAttribute("errorMessage", "Đơn hàng #" + orderId + " không tồn tại.");
                List<Order> orders = orderDAO.getAllOrders();
                request.setAttribute("orders", orders);
                request.getRequestDispatcher("/WEB-INF/views/admin/order-list.jsp").forward(request, response);
                return;
            }

            // Nạp danh sách sản phẩm trong đơn
            order.setOrderItems(orderDAO.getOrderItemsByOrderId(orderId));

            // Đồng bộ một số trường hiển thị nếu cần
            if (order.getCustomerName() == null && order.getShippingName() != null) {
                order.setCustomerName(order.getShippingName());
            }
            if (order.getCustomerPhone() == null && order.getShippingPhone() != null) {
                order.setCustomerPhone(order.getShippingPhone());
            }
            if (order.getCustomerAddress() == null && order.getShippingAddress() != null) {
                order.setCustomerAddress(order.getShippingAddress());
            }

            request.setAttribute("order", order);
            request.setAttribute("orderItems", order.getOrderItems());
            request.getRequestDispatcher("/WEB-INF/views/admin/order-detail.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving order", e);
        }
    }

    private void printInvoice(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId;
        try {
            orderId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException nfe) {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        try {
            Order order = orderDAO.getOrderById(orderId);
            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                return;
            }

            order.setOrderItems(orderDAO.getOrderItemsByOrderId(orderId));

            if (order.getCustomerName() == null && order.getShippingName() != null) {
                order.setCustomerName(order.getShippingName());
            }
            if (order.getCustomerPhone() == null && order.getShippingPhone() != null) {
                order.setCustomerPhone(order.getShippingPhone());
            }
            if (order.getCustomerAddress() == null && order.getShippingAddress() != null) {
                order.setCustomerAddress(order.getShippingAddress());
            }

            request.setAttribute("order", order);
            request.setAttribute("orderItems", order.getOrderItems());
            request.getRequestDispatcher("/WEB-INF/views/admin/order-invoice.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error printing invoice", e);
        }
    }
    
    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            
            orderDAO.updateOrderStatus(orderId, status);
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        } catch (SQLException e) {
            throw new ServletException("Error updating order status", e);
        }
    }
    
    private void updateOrderStatusFromForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            
            orderDAO.updateOrderStatus(orderId, status);
            response.sendRedirect(request.getContextPath() + "/admin/orders?action=view&id=" + orderId);
        } catch (SQLException e) {
            throw new ServletException("Error updating order status", e);
        }
    }
}
