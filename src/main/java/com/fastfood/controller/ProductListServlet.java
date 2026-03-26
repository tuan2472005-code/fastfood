package com.fastfood.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fastfood.dao.CategoryDAO;
import com.fastfood.dao.ProductDAO;
import com.fastfood.model.Category;
import com.fastfood.model.Product;

public class ProductListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cấu hình encoding UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        try {
            // Lấy tất cả sản phẩm
            List<Product> products = productDAO.getAllProducts();
            
            // Lấy tất cả danh mục để hiển thị filter
            List<Category> categories = categoryDAO.getAllCategories();
            
            // Kiểm tra nếu có filter theo category
            String categoryIdParam = request.getParameter("categoryId");
            if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                try {
                    int categoryId = Integer.parseInt(categoryIdParam);
                    products = productDAO.getProductsByCategory(categoryId);
                    request.setAttribute("selectedCategoryId", categoryId);
                } catch (NumberFormatException e) {
                    // Nếu categoryId không hợp lệ, hiển thị tất cả sản phẩm
                }
            }
            
            // Kiểm tra nếu có tìm kiếm
            String searchQuery = request.getParameter("search");
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                products = productDAO.searchProducts(searchQuery.trim());
                request.setAttribute("searchQuery", searchQuery);
            }
            
            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            
            request.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải danh sách sản phẩm");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}