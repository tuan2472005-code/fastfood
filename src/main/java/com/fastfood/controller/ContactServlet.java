package com.fastfood.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fastfood.dao.CategoryDAO;
import com.fastfood.model.Category;

public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private CategoryDAO categoryDAO;
    
    public void init() {
        categoryDAO = new CategoryDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy danh sách danh mục để hiển thị menu
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            
            request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải trang liên hệ");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xử lý form liên hệ
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");
        if (user == null) {
            session.setAttribute("redirectAfterLogin", "/contact");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        
        // Validate input
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            subject == null || subject.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {
            
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc.");
            doGet(request, response);
            return;
        }
        
        // Validate email format
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("error", "Email không hợp lệ.");
            doGet(request, response);
            return;
        }
        
        try {
            // Trong thực tế, ở đây bạn có thể:
            // 1. Lưu thông tin liên hệ vào database
            // 2. Gửi email thông báo cho admin
            // 3. Gửi email xác nhận cho khách hàng
            
            // Hiện tại chỉ hiển thị thông báo thành công
            request.setAttribute("success", "Cảm ơn bạn đã liên hệ! Chúng tôi sẽ phản hồi trong thời gian sớm nhất.");
            
            // Lấy danh sách danh mục để hiển thị menu
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            
            request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi gửi thông tin liên hệ. Vui lòng thử lại.");
            doGet(request, response);
        }
    }
}
