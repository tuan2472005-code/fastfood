package com.fastfood.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Cookie;
import java.util.Map;
import java.util.HashMap;

import com.fastfood.dao.UserDAO;
import com.fastfood.dao.ProductDAO;
import com.fastfood.model.CartItem;
import com.fastfood.model.Product;
import com.fastfood.model.User;


public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO = new UserDAO();
    private ProductDAO productDAO = new ProductDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user = userDAO.authenticate(username, password);
        
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                try {
                    @SuppressWarnings("unchecked")
                    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cartItems");
                    if (cart == null) cart = new HashMap<>();
                    Cookie[] cookies = request.getCookies();
                    String raw = null;
                    if (cookies != null) {
                        for (Cookie c : cookies) { if ("cart".equals(c.getName())) { raw = c.getValue(); break; } }
                    }
                    if (raw != null && !raw.isEmpty()) {
                        String[] parts = raw.split("\\|");
                        for (String p : parts) {
                            if (p == null || p.isEmpty()) continue;
                            int sep = p.indexOf(':');
                            if (sep <= 0) continue;
                            try {
                                int id = Integer.parseInt(p.substring(0, sep));
                                int qty = Integer.parseInt(p.substring(sep+1));
                                if (qty <= 0) continue;
                                Product prod = productDAO.getProductById(id);
                                if (prod != null) {
                                    if (cart.containsKey(id)) {
                                        CartItem ex = cart.get(id);
                                        ex.setQuantity(ex.getQuantity() + qty);
                                    } else {
                                        cart.put(id, new CartItem(prod, qty));
                                    }
                                }
                            } catch (Exception ignore) {}
                        }
                        session.setAttribute("cartItems", cart);
                    }
                } catch (Exception ignore) {}

                try {
                    java.util.List<String> history = (java.util.List<String>) session.getAttribute("activityHistory");
                    if (history == null) {
                        history = new java.util.LinkedList<>();
                    }
                    history.add(0, "Đăng nhập thành công lúc " + new java.text.SimpleDateFormat("HH:mm dd/MM/yyyy").format(new java.util.Date()));
                    if (history.size() > 50) { history = history.subList(0, 50); }
                    session.setAttribute("activityHistory", history);
                } catch (Exception ignore) {}

                String redirectParam = request.getParameter("redirect");
                String redirect = (String) session.getAttribute("redirectAfterLogin");
                if (redirect != null && !redirect.isEmpty()) {
                    session.removeAttribute("redirectAfterLogin");
                    response.sendRedirect(request.getContextPath() + redirect);
                    return;
                }
                if (redirectParam != null && !redirectParam.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + redirectParam);
                    return;
                }

                String role = user.getRole();
                if ("ADMIN".equals(role) || "STAFF".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/home");
                }
            } else {
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        }
}
