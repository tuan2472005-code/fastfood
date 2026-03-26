package com.fastfood.controller;

import java.io.IOException; 
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Cookie;

import com.fastfood.dao.OrderDAO;
import com.fastfood.dao.ProductDAO;
import com.fastfood.dao.VoucherDAO;
import com.fastfood.model.CartItem;
import com.fastfood.model.Order;
import com.fastfood.model.OrderItem;
import com.fastfood.model.Product;
import com.fastfood.model.User;
import com.fastfood.model.Voucher;

public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private OrderDAO orderDAO;
    private ProductDAO productDAO;
    private VoucherDAO voucherDAO;
    
    public void init() {
        orderDAO = new OrderDAO();
        productDAO = new ProductDAO();
        voucherDAO = new VoucherDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cấu hình encoding UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (user == null) {
            session.setAttribute("redirectAfterLogin", "/checkout");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy giỏ hàng từ session
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cartItems");
        
        
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("error", "Giỏ hàng trống. Vui lòng thêm sản phẩm trước khi thanh toán.");
            response.sendRedirect(request.getContextPath() + "/cart/view");
            return;
        }
        
        // Tính tổng tiền
        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : cart.values()) {
            subtotal = subtotal.add(item.getSubtotal());
        }
        
        // Phí ship cố định
        BigDecimal shippingFee = new BigDecimal("15000.00");
        BigDecimal totalAmount = subtotal.add(shippingFee);
        
        request.setAttribute("cart", cart);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("totalAmount", totalAmount);
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            session.setAttribute("redirectAfterLogin", "/checkout");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy thông tin từ form
        String customerName = request.getParameter("customerName");
        String customerPhone = request.getParameter("customerPhone");
        String customerAddress = request.getParameter("customerAddress");
        String notes = request.getParameter("notes");
        String paymentMethod = request.getParameter("paymentMethod");
        String voucherCode = request.getParameter("voucherCode");
        String shippingVoucherCode = request.getParameter("shippingVoucherCode");
        
        // Validate input
        if (customerName == null || customerName.trim().isEmpty() ||
            customerPhone == null || customerPhone.trim().isEmpty() ||
            customerAddress == null || customerAddress.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin giao hàng");
            doGet(request, response);
            return;
        }
        
        // Lấy giỏ hàng
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cartItems");
        
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("error", "Giỏ hàng trống");
            response.sendRedirect(request.getContextPath() + "/cart/view");
            return;
        }
        
        try {
            // Tạo đơn hàng
            Order order = new Order();
            order.setUserId(user.getId());
            order.setShippingName(customerName);
            order.setShippingPhone(customerPhone);
            order.setShippingAddress(customerAddress);
            order.setNote(notes);
            
            // Map payment method to database enum values
            String dbPaymentMethod;
            switch (paymentMethod) {
                case "COD":
                    dbPaymentMethod = "TIEN_MAT";
                    break;
                case "BANK_TRANSFER":
                    dbPaymentMethod = "CHUYEN_KHOAN";
                    break;
                case "QR_CODE":
                    dbPaymentMethod = "VI_DIEN_TU";
                    break;
                case "CREDIT_CARD":
                    dbPaymentMethod = "THE_TIN_DUNG";
                    break;
                default:
                    dbPaymentMethod = "TIEN_MAT";
                    break;
            }
            order.setPaymentMethod(dbPaymentMethod);
            
            // Xử lý trạng thái đơn hàng theo phương thức thanh toán
            if ("COD".equals(paymentMethod)) {
                // Thanh toán khi nhận hàng - đặt trạng thái DANG_CHUAN_BI (đã xác nhận, bắt đầu chuẩn bị)
                order.setStatus("DANG_CHUAN_BI");
            } else if ("BANK_TRANSFER".equals(paymentMethod) || "QR_CODE".equals(paymentMethod)) {
                // Thanh toán chuyển khoản/QR - đặt trạng thái CHO_XAC_NHAN (chờ xác nhận thanh toán)
                order.setStatus("CHO_XAC_NHAN");
            } else {
                // Mặc định - chờ xác nhận
                order.setStatus("CHO_XAC_NHAN");
            }
            
            // Tính tổng tiền
            BigDecimal subtotal = BigDecimal.ZERO;
            for (CartItem item : cart.values()) {
                subtotal = subtotal.add(item.getSubtotal());
            }
            
            // Phí ship cố định
            BigDecimal shippingFee = new BigDecimal("15000.00");
            BigDecimal totalAmount = subtotal.add(shippingFee);
            
            // Xử lý voucher sản phẩm (áp dụng giảm giá cho subtotal)
            BigDecimal discountAmount = BigDecimal.ZERO;
            Voucher productVoucher = null;
            if (voucherCode != null && !voucherCode.trim().isEmpty()) {
                productVoucher = voucherDAO.findByCodeAndType(voucherCode.trim().toUpperCase(), "PRODUCT");
                if (productVoucher != null && productVoucher.isValid()) {
                    if (subtotal.compareTo(productVoucher.getMinOrderAmount()) >= 0) {
                        discountAmount = productVoucher.calculateDiscount(subtotal);
                        
                        // Cập nhật ghi chú đơn hàng với thông tin voucher sản phẩm
                        String voucherNote = "Áp dụng voucher sản phẩm: " + productVoucher.getCode() + " - " + productVoucher.getName();
                        if (notes != null && !notes.trim().isEmpty()) {
                            notes = notes + "\n" + voucherNote;
                        } else {
                            notes = voucherNote;
                        }
                    }
                }
            }
            
            // Xử lý voucher vận chuyển (áp dụng giảm giá cho phí ship)
            BigDecimal shippingDiscountAmount = BigDecimal.ZERO;
            Voucher shippingVoucher = null;
            if (shippingVoucherCode != null && !shippingVoucherCode.trim().isEmpty()) {
                shippingVoucher = voucherDAO.findByCodeAndType(shippingVoucherCode.trim().toUpperCase(), "SHIPPING");
                if (shippingVoucher != null && shippingVoucher.isValid()) {
                    // Voucher vận chuyển áp dụng cho phí ship
                    shippingDiscountAmount = shippingVoucher.calculateDiscount(shippingFee);
                    
                    // Cập nhật ghi chú đơn hàng với thông tin voucher vận chuyển
                    String shippingVoucherNote = "Áp dụng voucher vận chuyển: " + shippingVoucher.getCode() + " - " + shippingVoucher.getName();
                    if (notes != null && !notes.trim().isEmpty()) {
                        notes = notes + "\n" + shippingVoucherNote;
                    } else {
                        notes = shippingVoucherNote;
                    }
                }
            }
            
            // Tính phí ship cuối cùng sau giảm giá
            BigDecimal finalShippingFee = shippingFee.subtract(shippingDiscountAmount);
            if (finalShippingFee.compareTo(BigDecimal.ZERO) < 0) {
                finalShippingFee = BigDecimal.ZERO;
            }
            
            // Tính tổng tiền cuối cùng (subtotal - product_discount + final_shipping_fee)
            BigDecimal finalAmount = subtotal.subtract(discountAmount).add(finalShippingFee);
            order.setTotalAmount(finalAmount);
            order.setShippingFee(shippingFee);
            order.setNote(notes);
            
            // Lưu thông tin voucher sản phẩm vào đơn hàng
            if (productVoucher != null && discountAmount.compareTo(BigDecimal.ZERO) > 0) {
                order.setVoucherId(productVoucher.getId());
                order.setVoucherCode(productVoucher.getCode());
                order.setDiscountAmount(discountAmount);
            }
            
            // Lưu thông tin voucher vận chuyển vào đơn hàng
            if (shippingVoucher != null && shippingDiscountAmount.compareTo(BigDecimal.ZERO) > 0) {
                order.setShippingVoucherId(shippingVoucher.getId());
                order.setShippingVoucherCode(shippingVoucher.getCode());
                order.setShippingDiscountAmount(shippingDiscountAmount);
            }
            
            // Lưu đơn hàng và lấy ID
            int orderId = orderDAO.createOrder(order);
            
            if (orderId > 0) {
                // Lưu chi tiết đơn hàng
                for (CartItem cartItem : cart.values()) {
                    Product product = productDAO.getProductById(cartItem.getProductId());
                    if (product != null) {
                        OrderItem orderItem = new OrderItem();
                        orderItem.setOrderId(orderId);
                        orderItem.setProductId(cartItem.getProductId());
                        orderItem.setProductName(product.getName());
                        orderItem.setPrice(product.getPrice());
                        orderItem.setQuantity(cartItem.getQuantity());
                        orderItem.setSubtotal(cartItem.getSubtotal());
                        
                        orderDAO.addOrderItem(orderItem);
                    }
                }
                
                // Cập nhật số lần sử dụng voucher sản phẩm nếu có
                if (productVoucher != null && discountAmount.compareTo(BigDecimal.ZERO) > 0) {
                    voucherDAO.incrementUsage(productVoucher.getId());
                }
                
                // Cập nhật số lần sử dụng voucher vận chuyển nếu có
                if (shippingVoucher != null && shippingDiscountAmount.compareTo(BigDecimal.ZERO) > 0) {
                    voucherDAO.incrementUsage(shippingVoucher.getId());
                }
                
                // Xóa giỏ hàng
                session.removeAttribute("cartItems");
                Cookie cookie = new Cookie("cart", "");
                String ctx = request.getContextPath();
                cookie.setPath((ctx != null && !ctx.isEmpty()) ? ctx : "/");
                cookie.setMaxAge(0);
                response.addCookie(cookie);
                try {
                    java.util.List<String> history = (java.util.List<String>) session.getAttribute("activityHistory");
                    if (history == null) history = new java.util.LinkedList<>();
                    history.add(0, "Đặt hàng thành công #" + orderId + " tổng " + finalAmount + " lúc " + new java.text.SimpleDateFormat("HH:mm dd/MM/yyyy").format(new java.util.Date()));
                    if (history.size() > 50) { history = history.subList(0, 50); }
                    session.setAttribute("activityHistory", history);
                } catch (Exception ignore) {}
                
                // Lưu thông tin voucher vào session để hiển thị ở trang success
                if (productVoucher != null && discountAmount.compareTo(BigDecimal.ZERO) > 0) {
                    session.setAttribute("appliedProductVoucher", productVoucher);
                    session.setAttribute("productDiscountAmount", discountAmount);
                }
                
                if (shippingVoucher != null && shippingDiscountAmount.compareTo(BigDecimal.ZERO) > 0) {
                    session.setAttribute("appliedShippingVoucher", shippingVoucher);
                    session.setAttribute("shippingDiscountAmount", shippingDiscountAmount);
                }
                
                // Chuyển đến trang thành công với thông tin phương thức thanh toán
                request.setAttribute("orderId", orderId);
                request.setAttribute("paymentMethod", paymentMethod);
                request.setAttribute("subtotal", subtotal);
                request.setAttribute("shippingFee", shippingFee);
                request.setAttribute("totalAmount", finalAmount);
                
                if ("COD".equals(paymentMethod)) {
                    request.setAttribute("success", "Đặt hàng thành công! Mã đơn hàng: " + orderId);
                    request.setAttribute("message", "Đơn hàng của bạn đã được xác nhận. Chúng tôi sẽ giao hàng trong thời gian sớm nhất.");
                } else {
                    request.setAttribute("success", "Đặt hàng thành công! Mã đơn hàng: " + orderId);
                    request.setAttribute("message", "Vui lòng chuyển khoản theo thông tin đã cung cấp. Đơn hàng sẽ được xác nhận sau khi chúng tôi nhận được thanh toán.");
                }
                
                request.getRequestDispatcher("/WEB-INF/views/checkout-success.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Đặt hàng thất bại. Vui lòng thử lại.");
                doGet(request, response);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi đặt hàng. Vui lòng thử lại.");
            doGet(request, response);
        }
    }
}
