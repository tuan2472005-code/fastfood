package com.fastfood.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fastfood.dao.VoucherDAO;
import com.fastfood.model.Voucher;

@WebServlet("/admin/voucher")
public class AdminVoucherServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private VoucherDAO voucherDAO;
    
    public void init() {
        voucherDAO = new VoucherDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        com.fastfood.model.User user = (com.fastfood.model.User) request.getSession().getAttribute("user");
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
            case "list":
                listVouchers(request, response);
                break;
            case "add":
                if (!isAdmin) { listVouchers(request, response); break; }
                showAddForm(request, response);
                break;
            case "edit":
                if (!isAdmin) { listVouchers(request, response); break; }
                showEditForm(request, response);
                break;
            case "delete":
                if (!isAdmin) { listVouchers(request, response); break; }
                deleteVoucher(request, response);
                break;
            default:
                listVouchers(request, response);
                break;
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        com.fastfood.model.User user = (com.fastfood.model.User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String action = request.getParameter("action");
        
        if ("save".equals(action)) {
            saveVoucher(request, response);
        } else if ("update".equals(action)) {
            updateVoucher(request, response);
        }
    }
    
    private void listVouchers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Voucher> vouchers = voucherDAO.findAll();
            request.setAttribute("vouchers", vouchers);
            request.getRequestDispatcher("/WEB-INF/views/admin/voucher-list.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách voucher: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/voucher-list.jsp").forward(request, response);
        }
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/voucher-form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Voucher voucher = voucherDAO.findById(id);
            
            if (voucher != null) {
                request.setAttribute("voucher", voucher);
                request.getRequestDispatcher("/WEB-INF/views/admin/voucher-form.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Không tìm thấy voucher");
                listVouchers(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            listVouchers(request, response);
        }
    }
    
    private void saveVoucher(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Voucher voucher = createVoucherFromRequest(request);
            
            // Kiểm tra mã voucher đã tồn tại
            if (voucherDAO.existsByCode(voucher.getCode())) {
                request.setAttribute("error", "Mã voucher đã tồn tại");
                request.setAttribute("voucher", voucher);
                request.getRequestDispatcher("/WEB-INF/views/admin/voucher-form.jsp").forward(request, response);
                return;
            }
            
            boolean success = voucherDAO.save(voucher);
            
            if (success) {
                request.setAttribute("success", "Tạo voucher thành công");
                response.sendRedirect(request.getContextPath() + "/admin/voucher");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi tạo voucher");
                request.setAttribute("voucher", voucher);
                request.getRequestDispatcher("/WEB-INF/views/admin/voucher-form.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/voucher-form.jsp").forward(request, response);
        }
    }
    
    private void updateVoucher(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Voucher voucher = createVoucherFromRequest(request);
            voucher.setId(id);
            
            boolean success = voucherDAO.update(voucher);
            
            if (success) {
                request.setAttribute("success", "Cập nhật voucher thành công");
                response.sendRedirect(request.getContextPath() + "/admin/voucher");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật voucher");
                request.setAttribute("voucher", voucher);
                request.getRequestDispatcher("/WEB-INF/views/admin/voucher-form.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/voucher-form.jsp").forward(request, response);
        }
    }
    
    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean success = voucherDAO.delete(id);
            
            if (success) {
                request.setAttribute("success", "Xóa voucher thành công");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi xóa voucher");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        listVouchers(request, response);
    }
    
    private Voucher createVoucherFromRequest(HttpServletRequest request) throws ParseException {
        Voucher voucher = new Voucher();
        
        voucher.setCode(trim(request.getParameter("code")).toUpperCase());
        voucher.setName(trim(request.getParameter("name")));
        voucher.setDiscountType(trim(request.getParameter("discountType")));
        voucher.setDiscountValue(parseBigDecimal(request.getParameter("discountValue")));
        voucher.setMinOrderAmount(parseBigDecimal(request.getParameter("minOrderAmount")));
        voucher.setMaxDiscountAmount(parseBigDecimal(request.getParameter("maxDiscountAmount")));
        voucher.setUsageLimit(parseInteger(request.getParameter("usageLimit")));
        voucher.setStartDate(parseTimestamp(request.getParameter("startDate")));
        voucher.setEndDate(parseTimestamp(request.getParameter("endDate")));
        voucher.setActive("on".equals(request.getParameter("isActive")));
        
        // Thêm hỗ trợ voucher_type
        String voucherType = trim(request.getParameter("voucherType"));
        voucher.setVoucherType(voucherType.isEmpty() ? "PRODUCT" : voucherType);
        
        return voucher;
    }
    
    private String trim(String str) {
        return str != null ? str.trim() : "";
    }
    
    private BigDecimal parseBigDecimal(String str) {
        try {
            return str != null && !str.trim().isEmpty() ? new BigDecimal(str.trim()) : BigDecimal.ZERO;
        } catch (NumberFormatException e) {
            return BigDecimal.ZERO;
        }
    }
    
    private Integer parseInteger(String str) {
        try {
            return str != null && !str.trim().isEmpty() ? Integer.parseInt(str.trim()) : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }
    
    private Timestamp parseTimestamp(String str) throws ParseException {
        if (str == null || str.trim().isEmpty()) {
            return null;
        }
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Date date = sdf.parse(str.trim());
        return new Timestamp(date.getTime());
    }
}
