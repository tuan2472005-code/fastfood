package com.fastfood.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fastfood.dao.CategoryDAO;
import com.fastfood.dao.ProductDAO;
import com.fastfood.model.Category;
import com.fastfood.model.Product;


public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private CategoryDAO categoryDAO;
    private ProductDAO productDAO;
    
    public void init() {
        categoryDAO = new CategoryDAO();
        productDAO = new ProductDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cấu hình encoding UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        try {
            // Lấy danh sách danh mục
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            
            // Lấy sản phẩm nổi bật (giả sử là 4 sản phẩm đầu tiên)
            List<Product> featuredProducts = productDAO.getFeaturedProducts();
            request.setAttribute("featuredProducts", featuredProducts);
            
            // Lấy sản phẩm theo từng danh mục
            Map<Integer, List<Product>> productsByCategory = new HashMap<>();
            for (Category category : categories) {
                List<Product> products = productDAO.getProductsByCategory(category.getId());
                productsByCategory.put(category.getId(), products);
            }
            request.setAttribute("productsByCategory", productsByCategory);
            
            // Chuyển hướng đến trang chủ
            request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải dữ liệu");
        }
    }
}