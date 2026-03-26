package com.fastfood.servlet;

import com.fastfood.dao.VoucherDAO;
import com.fastfood.model.Voucher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

@WebServlet("/voucher")
public class VoucherServlet extends HttpServlet {
    private VoucherDAO voucherDAO;

    @Override
    public void init() throws ServletException {
        voucherDAO = new VoucherDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String voucherCode = request.getParameter("code");
        String totalAmountStr = request.getParameter("total");
        String voucherType = request.getParameter("type"); // PRODUCT hoặc SHIPPING
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            if (voucherCode == null || voucherCode.trim().isEmpty()) {
                writeJson(out, false, "Vui lòng nhập mã voucher", null, null);
                return;
            }
            
            if (totalAmountStr == null || totalAmountStr.trim().isEmpty()) {
                writeJson(out, false, "Không thể xác định tổng tiền đơn hàng", null, null);
                return;
            }
            
            // Mặc định là PRODUCT nếu không có type
            if (voucherType == null || voucherType.trim().isEmpty()) {
                voucherType = "PRODUCT";
            }
            
            BigDecimal totalAmount = new BigDecimal(totalAmountStr);
            
            // Tìm voucher theo mã và loại
            Voucher voucher = voucherDAO.findByCodeAndType(voucherCode.trim().toUpperCase(), voucherType.trim().toUpperCase());
            
            if (voucher == null) {
                String errorMessage = "SHIPPING".equals(voucherType) ? 
                    "Mã voucher vận chuyển không tồn tại hoặc không hợp lệ" : 
                    "Mã voucher sản phẩm không tồn tại hoặc không hợp lệ";
                writeJson(out, false, errorMessage, null, null);
                return;
            }
            
            // Kiểm tra voucher có hợp lệ không
            String validationResult = validateVoucher(voucher, totalAmount);
            if (validationResult != null) {
                writeJson(out, false, validationResult, null, null);
                return;
            }
            
            // Tính toán giảm giá
            BigDecimal discountAmount = calculateDiscount(voucher, totalAmount);
            
            String successMessage = "SHIPPING".equals(voucherType) ? 
                "Áp dụng voucher vận chuyển thành công" : 
                "Áp dụng voucher sản phẩm thành công";
            writeJson(out, true, successMessage, discountAmount, voucher);
            
        } catch (NumberFormatException e) {
            writeJson(out, false, "Tổng tiền không hợp lệ", null, null);
        } catch (Exception e) {
            e.printStackTrace();
            writeJson(out, false, "Có lỗi xảy ra khi xử lý voucher", null, null);
        }
    }
    
    private String validateVoucher(Voucher voucher, BigDecimal totalAmount) {
        System.out.println("DEBUG: Validating voucher: " + voucher.getCode());
        
        // Kiểm tra voucher có đang hoạt động không
        System.out.println("DEBUG: Voucher isActive: " + voucher.isActive());
        if (!voucher.isActive()) {
            return "Voucher đã bị vô hiệu hóa";
        }
        
        // Kiểm tra thời gian hiệu lực
        long currentTime = System.currentTimeMillis();
        System.out.println("DEBUG: Current time: " + new java.util.Date(currentTime));
        System.out.println("DEBUG: Start date: " + voucher.getStartDate());
        System.out.println("DEBUG: End date: " + voucher.getEndDate());
        
        if (voucher.getStartDate().getTime() > currentTime) {
            System.out.println("DEBUG: Voucher not yet valid");
            return "Voucher chưa có hiệu lực";
        }
        
        if (voucher.getEndDate().getTime() < currentTime) {
            System.out.println("DEBUG: Voucher expired");
            return "Voucher đã hết hạn";
        }
        
        // Kiểm tra giới hạn sử dụng
        System.out.println("DEBUG: Usage limit: " + voucher.getUsageLimit() + ", Used count: " + voucher.getUsedCount());
        if (voucher.getUsageLimit() > 0 && voucher.getUsedCount() >= voucher.getUsageLimit()) {
            return "Voucher đã hết lượt sử dụng";
        }
        
        // Kiểm tra đơn tối thiểu
        System.out.println("DEBUG: Total amount: " + totalAmount + ", Min order amount: " + voucher.getMinOrderAmount());
        if (totalAmount.compareTo(voucher.getMinOrderAmount()) < 0) {
            return "Đơn hàng chưa đạt giá trị tối thiểu " + 
                   String.format("%,.0f", voucher.getMinOrderAmount()) + "đ";
        }
        
        System.out.println("DEBUG: Voucher validation passed!");
        return null; // Voucher hợp lệ
    }
    
    private BigDecimal calculateDiscount(Voucher voucher, BigDecimal totalAmount) {
        System.out.println("DEBUG: calculateDiscount called");
        System.out.println("DEBUG: voucher.getDiscountType(): " + voucher.getDiscountType());
        System.out.println("DEBUG: voucher.getDiscountValue(): " + voucher.getDiscountValue());
        System.out.println("DEBUG: totalAmount: " + totalAmount);
        
        BigDecimal discount;
        
        if ("PERCENTAGE".equals(voucher.getDiscountType())) {
            // Giảm theo phần trăm
            discount = totalAmount.multiply(voucher.getDiscountValue()).divide(new BigDecimal(100));
            System.out.println("DEBUG: Calculated percentage discount: " + discount);
            System.out.println("DEBUG: voucher.getMaxDiscountAmount(): " + voucher.getMaxDiscountAmount());
            
            // Kiểm tra giảm tối đa (chỉ áp dụng khi maxDiscountAmount > 0)
            if (voucher.getMaxDiscountAmount() != null && 
                voucher.getMaxDiscountAmount().compareTo(BigDecimal.ZERO) > 0 &&
                discount.compareTo(voucher.getMaxDiscountAmount()) > 0) {
                System.out.println("DEBUG: Applying max discount limit");
                discount = voucher.getMaxDiscountAmount();
            }
        } else if ("FIXED_AMOUNT".equals(voucher.getDiscountType())) {
            // Giảm số tiền cố định
            discount = voucher.getDiscountValue();
        } else {
            // Trường hợp không xác định
            discount = BigDecimal.ZERO;
        }
        
        // Đảm bảo giảm giá không vượt quá tổng tiền
        if (discount.compareTo(totalAmount) > 0) {
            discount = totalAmount;
        }
        
        System.out.println("DEBUG: Final discount amount: " + discount);
        return discount;
    }
    
    private void writeJson(PrintWriter out, boolean success, String message, 
                          BigDecimal discountAmount, Voucher voucher) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"success\": ").append(success).append(",");
        json.append("\"message\": \"").append(safe(message)).append("\"");
        
        if (success && discountAmount != null) {
            json.append(",\"discountAmount\": ").append(discountAmount);
            json.append(",\"discountFormatted\": \"").append(String.format("%,.0f", discountAmount)).append("đ\"");
            
            if (voucher != null) {
                json.append(",\"voucher\": {");
                json.append("\"id\": ").append(voucher.getId()).append(",");
                json.append("\"code\": \"").append(safe(voucher.getCode())).append("\",");
                json.append("\"name\": \"").append(safe(voucher.getName())).append("\",");
                json.append("\"discountType\": \"").append(safe(voucher.getDiscountType())).append("\"");
                json.append("}");
            }
        }
        
        json.append("}");
        out.print(json.toString());
    }
    
    private String safe(String str) {
        if (str == null) return "";
        return escapeJson(str);
    }
    
    private String escapeJson(String str) {
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}