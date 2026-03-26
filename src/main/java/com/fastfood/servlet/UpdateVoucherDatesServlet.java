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
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/admin/update-voucher-dates")
public class UpdateVoucherDatesServlet extends HttpServlet {
    private VoucherDAO voucherDAO;

    @Override
    public void init() throws ServletException {
        voucherDAO = new VoucherDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Lấy tất cả voucher
            List<Voucher> vouchers = voucherDAO.findAll();
            
            out.println("<html><body>");
            out.println("<h2>Cập nhật ngày hết hạn voucher</h2>");
            
            // Cập nhật ngày hết hạn cho các voucher hết hạn
            Timestamp newEndDate = Timestamp.valueOf("2025-12-31 23:59:59");
            int updatedCount = 0;
            
            for (Voucher voucher : vouchers) {
                if (voucher.getEndDate().before(new Timestamp(System.currentTimeMillis()))) {
                    voucher.setEndDate(newEndDate);
                    if (voucherDAO.update(voucher)) {
                        updatedCount++;
                        out.println("<p>✅ Đã cập nhật voucher: " + voucher.getCode() + "</p>");
                    } else {
                        out.println("<p>❌ Lỗi cập nhật voucher: " + voucher.getCode() + "</p>");
                    }
                }
            }
            
            out.println("<h3>Kết quả:</h3>");
            out.println("<p>Đã cập nhật " + updatedCount + " voucher</p>");
            
            // Hiển thị danh sách voucher hiện tại
            out.println("<h3>Danh sách voucher hiện tại:</h3>");
            out.println("<table border='1'>");
            out.println("<tr><th>Mã</th><th>Tên</th><th>Ngày bắt đầu</th><th>Ngày kết thúc</th><th>Trạng thái</th></tr>");
            
            for (Voucher voucher : voucherDAO.findAll()) {
                out.println("<tr>");
                out.println("<td>" + voucher.getCode() + "</td>");
                out.println("<td>" + voucher.getName() + "</td>");
                out.println("<td>" + voucher.getStartDate() + "</td>");
                out.println("<td>" + voucher.getEndDate() + "</td>");
                out.println("<td>" + (voucher.isActive() ? "Hoạt động" : "Không hoạt động") + "</td>");
                out.println("</tr>");
            }
            
            out.println("</table>");
            out.println("<br><a href='" + request.getContextPath() + "/checkout'>Quay lại trang checkout</a>");
            out.println("</body></html>");
            
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Lỗi: " + e.getMessage() + "</p>");
        }
    }
}