package com.fastfood.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fastfood.dao.CategoryDAO;
import com.fastfood.dao.VoucherDAO;
import com.fastfood.model.Category;
import com.fastfood.model.Voucher;


public class PromotionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CategoryDAO categoryDAO;
    private VoucherDAO voucherDAO;

    public void init() {
        categoryDAO = new CategoryDAO();
        voucherDAO = new VoucherDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        try {
            List<Category> categories = categoryDAO.getAllCategories();
            List<Voucher> vouchers = voucherDAO.findActiveVouchers();
            request.setAttribute("categories", categories);
            request.setAttribute("vouchers", vouchers);
            request.getRequestDispatcher("/WEB-INF/views/promotions.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải trang khuyến mãi");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
