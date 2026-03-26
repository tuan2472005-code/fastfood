package com.fastfood.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fastfood.dao.ProductDAO;
import com.fastfood.model.Product;

public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO;
    
    public void init() {
        productDAO = new ProductDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cấu hình encoding UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(productId);
            
            if (product != null) {
                request.setAttribute("product", product);
                request.getRequestDispatcher("/WEB-INF/views/product-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}