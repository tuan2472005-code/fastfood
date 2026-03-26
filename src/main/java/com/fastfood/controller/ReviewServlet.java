package com.fastfood.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fastfood.dao.ReviewDAO;
import com.fastfood.dao.CategoryDAO;
import com.fastfood.model.Review;
import com.fastfood.model.User;
import com.fastfood.model.Category;

public class ReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ReviewDAO reviewDAO;
    private CategoryDAO categoryDAO;
    
    public void init() {
        reviewDAO = new ReviewDAO();
        categoryDAO = new CategoryDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Cấu hình encoding UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addReview(request, response);
        } else if ("list".equals(action)) {
            listReviews(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Hành động không hợp lệ");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("list".equals(action)) {
            listReviews(request, response);
        } else if ("listReviews".equals(action)) {
            listReviewsJson(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Hành động không hợp lệ");
        }
    }
    
    private void addReview(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Lấy thông tin từ form
            int sanPhamId = Integer.parseInt(request.getParameter("sanPhamId"));
            String hoTen = request.getParameter("hoTen");
            String email = request.getParameter("email");
            int rating = Integer.parseInt(request.getParameter("rating"));
            String binhLuan = request.getParameter("binhLuan");
            
            HttpSession session = request.getSession();
            User sessionUser = (User) session.getAttribute("user");
            if (sessionUser == null) {
                session.setAttribute("redirectAfterLogin", "/product?id=" + sanPhamId);
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            // Kiểm tra dữ liệu đầu vào
            if (hoTen == null || hoTen.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Họ tên không được để trống");
                return;
            }
            
            if (rating < 1 || rating > 5) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Rating phải từ 1 đến 5 sao");
                return;
            }
            
            // Tạo đối tượng Review
            Review review = new Review();
            review.setSanPhamId(sanPhamId);
            review.setHoTen(hoTen.trim());
            review.setEmail(email != null ? email.trim() : null);
            review.setRating(rating);
            review.setBinhLuan(binhLuan != null ? binhLuan.trim() : null);
            review.setTrangThai("approved"); // Set trạng thái approved cho đánh giá mới
            
            review.setNguoiDungId(sessionUser.getId());
            
            // Thêm đánh giá vào database
            boolean success = reviewDAO.addReview(review);
            
            if (success) {
                // Chuyển hướng về trang chi tiết sản phẩm với thông báo thành công
                response.sendRedirect(request.getContextPath() + "/product?id=" + sanPhamId + "&reviewAdded=true");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể thêm đánh giá");
            }
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống");
        }
    }
    
    private void listReviews(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int sanPhamId = Integer.parseInt(request.getParameter("sanPhamId"));
            
            // Lấy danh sách đánh giá của sản phẩm
            List<Review> reviews = reviewDAO.getReviewsByProductId(sanPhamId);
            
            // Lấy danh sách danh mục để hiển thị menu
            List<Category> categories = categoryDAO.getAllCategories();
            
            request.setAttribute("reviews", reviews);
            request.setAttribute("categories", categories);
            request.setAttribute("sanPhamId", sanPhamId);
            
            request.getRequestDispatcher("/WEB-INF/views/reviews.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID sản phẩm không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống");
        }
    }
    
    private void listReviewsJson(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            
            // Lấy danh sách đánh giá của sản phẩm
            List<Review> reviews = reviewDAO.getReviewsByProductId(productId);
            
            // Cấu hình response để trả về JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            // Tạo JSON response
            StringBuilder json = new StringBuilder();
            json.append("{\"reviews\":[");
            
            for (int i = 0; i < reviews.size(); i++) {
                Review review = reviews.get(i);
                if (i > 0) json.append(",");
                
                json.append("{");
                json.append("\"id\":").append(review.getId()).append(",");
                json.append("\"hoTen\":\"").append(escapeJson(review.getHoTen())).append("\",");
                json.append("\"rating\":").append(review.getRating()).append(",");
                json.append("\"binhLuan\":\"").append(escapeJson(review.getBinhLuan())).append("\",");
                json.append("\"ngayTao\":\"").append(review.getNgayTao()).append("\"");
                json.append("}");
            }
            
            json.append("]}");
            
            response.getWriter().write(json.toString());
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"ID sản phẩm không hợp lệ\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Lỗi hệ thống\"}");
        }
    }
    
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
