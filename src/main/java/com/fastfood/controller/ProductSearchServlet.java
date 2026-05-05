package com.fastfood.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fastfood.dao.ProductDAO;
import com.fastfood.model.Product;
import com.google.gson.Gson;

public class ProductSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO;
    private Gson gson;
    
    public void init() {
        productDAO = new ProductDAO();
        this.gson = new Gson();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        String query = request.getParameter("query");
        String categoryIdParam = request.getParameter("categoryId");
        
        try {
            List<Product> products;
            if (query != null && !query.trim().isEmpty()) {
                products = productDAO.searchProducts(query.trim());
                // Nếu có categoryId, lọc thêm theo category
                if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                    int categoryId = Integer.parseInt(categoryIdParam);
                    products.removeIf(p -> p.getCategoryId() != categoryId);
                }
            } else if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                int categoryId = Integer.parseInt(categoryIdParam);
                products = productDAO.getProductsByCategory(categoryId);
            } else {
                products = productDAO.getAllProducts();
            }
            
            String json = this.gson.toJson(products);
            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"error\": \"Lỗi server khi tìm kiếm\"}");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
