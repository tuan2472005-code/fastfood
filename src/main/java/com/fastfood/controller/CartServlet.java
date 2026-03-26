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
import javax.servlet.http.HttpSession;
import javax.servlet.http.Cookie;

import com.fastfood.dao.CategoryDAO;
import com.fastfood.dao.ProductDAO;
import com.fastfood.model.CartItem;
import com.fastfood.model.Category;
import com.fastfood.model.Product;

public class CartServlet extends HttpServlet {
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
        
        String action = request.getPathInfo();
        
        if (action == null) {
            action = "/view";
        }
        
        try {
            switch (action) {
                case "/view":
                    viewCart(request, response);
                    break;
                case "/add":
                    addToCart(request, response);
                    break;
                case "/update":
                    updateCart(request, response);
                    break;
                case "/remove":
                    removeFromCart(request, response);
                    break;
                case "/clear":
                    clearCart(request, response);
                    break;
                default:
                    viewCart(request, response);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý giỏ hàng");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void viewCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cartItems");
        
        if (cart == null || cart.isEmpty()) {
            cart = new HashMap<>();
            Map<Integer, CartItem> fromCookie = loadCartFromCookie(request);
            if (fromCookie != null && !fromCookie.isEmpty()) {
                cart.putAll(fromCookie);
                session.setAttribute("cartItems", cart);
            }
        }
        
        // Lấy danh sách danh mục để hiển thị menu
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.setAttribute("cart", cart);
        
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            if (quantity <= 0) {
                quantity = 1;
            }
            
            Product product = productDAO.getProductById(productId);
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            String status = product.getStatus();
            boolean isActive = status != null && status.equalsIgnoreCase("active");
            if (!isActive || product.getStock() <= 0) {
                if (!isActive) {
                    request.getSession().setAttribute("flashError", "Sản phẩm đang tạm ngưng, không thể thêm vào giỏ hàng");
                } else {
                    request.getSession().setAttribute("flashError", "Sản phẩm đã hết hàng, không thể thêm vào giỏ hàng");
                }
                String referer = request.getHeader("Referer");
                if (referer != null && !referer.isEmpty()) {
                    response.sendRedirect(referer);
                } else {
                    response.sendRedirect(request.getContextPath() + "/home");
                }
                return;
            }
            
            HttpSession session = request.getSession();
            @SuppressWarnings("unchecked")
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cartItems");
            
            if (cart == null) {
                cart = new HashMap<>();
            }
            
            if (cart.containsKey(productId)) {
                // Nếu sản phẩm đã có trong giỏ hàng, tăng số lượng
                CartItem existingItem = cart.get(productId);
                existingItem.setQuantity(existingItem.getQuantity() + quantity);
            } else {
                // Thêm sản phẩm mới vào giỏ hàng
                CartItem newItem = new CartItem(product, quantity);
                cart.put(productId, newItem);
            }
            
            session.setAttribute("cartItems", cart);
            saveCartToCookie(request, response, cart);
            session.setAttribute("flashSuccess", "Thêm sản phẩm thành công");

            try {
                java.util.List<String> history = (java.util.List<String>) session.getAttribute("activityHistory");
                if (history == null) history = new java.util.LinkedList<>();
                String now = new java.text.SimpleDateFormat("HH:mm dd/MM/yyyy").format(new java.util.Date());
                String nameEsc = (product.getName() != null) ? product.getName().replace("\\", "\\\\").replace("\"", "\\\"") : "";
                String imgEsc = (product.getImageUrl() != null) ? product.getImageUrl().replace("\\", "\\\\").replace("\"", "\\\"") : "";
                String json = "{"+
                    "\"type\":\"ADD_TO_CART\","+
                    "\"productId\":"+product.getId()+","+
                    "\"name\":\""+nameEsc+"\","+
                    "\"qty\":"+quantity+","+
                    "\"imageUrl\":\""+imgEsc+"\","+
                    "\"time\":\""+now+"\""+
                "}";
                history.add(0, json);
                if (history.size() > 50) { history = history.subList(0, 50); }
                session.setAttribute("activityHistory", history);
            } catch (Exception ignore) {}
            
            // Redirect về trang trước đó hoặc trang sản phẩm
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
    
    private void updateCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            HttpSession session = request.getSession();
            @SuppressWarnings("unchecked")
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cartItems");
            
            if (cart != null && cart.containsKey(productId)) {
                if (quantity <= 0) {
                    cart.remove(productId);
                } else {
                    CartItem item = cart.get(productId);
                    item.setQuantity(quantity);
                }
                session.setAttribute("cartItems", cart);
                saveCartToCookie(request, response, cart);

                try {
                    java.util.List<String> history = (java.util.List<String>) session.getAttribute("activityHistory");
                    if (history == null) history = new java.util.LinkedList<>();
                    history.add(0, "Cập nhật giỏ hàng cho sản phẩm ID=" + productId + " số lượng=" + quantity + " lúc " + new java.text.SimpleDateFormat("HH:mm dd/MM/yyyy").format(new java.util.Date()));
                    if (history.size() > 50) { history = history.subList(0, 50); }
                    session.setAttribute("activityHistory", history);
                } catch (Exception ignore) {}
            }
            
            response.sendRedirect(request.getContextPath() + "/cart/view");
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/cart/view");
        }
    }
    
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            
            HttpSession session = request.getSession();
            @SuppressWarnings("unchecked")
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cartItems");
            
            if (cart != null) {
                cart.remove(productId);
                session.setAttribute("cartItems", cart);
                saveCartToCookie(request, response, cart);

                try {
                    java.util.List<String> history = (java.util.List<String>) session.getAttribute("activityHistory");
                    if (history == null) history = new java.util.LinkedList<>();
                    history.add(0, "Xóa khỏi giỏ: sản phẩm ID=" + productId + " lúc " + new java.text.SimpleDateFormat("HH:mm dd/MM/yyyy").format(new java.util.Date()));
                    if (history.size() > 50) { history = history.subList(0, 50); }
                    session.setAttribute("activityHistory", history);
                } catch (Exception ignore) {}
            }
            
            response.sendRedirect(request.getContextPath() + "/cart/view");
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/cart/view");
        }
    }
    
    private void clearCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("cartItems");
        clearCartCookie(request, response);

        try {
            java.util.List<String> history = (java.util.List<String>) session.getAttribute("activityHistory");
            if (history == null) history = new java.util.LinkedList<>();
            history.add(0, "Xóa toàn bộ giỏ hàng lúc " + new java.text.SimpleDateFormat("HH:mm dd/MM/yyyy").format(new java.util.Date()));
            if (history.size() > 50) { history = history.subList(0, 50); }
            session.setAttribute("activityHistory", history);
        } catch (Exception ignore) {}
        response.sendRedirect(request.getContextPath() + "/cart/view");
    }

    private Map<Integer, CartItem> loadCartFromCookie(HttpServletRequest request) throws SQLException {
        Cookie[] cookies = request.getCookies();
        if (cookies == null) return new HashMap<>();
        String ctx = request.getContextPath();
        String raw = null;
        for (Cookie c : cookies) {
            if ("cart".equals(c.getName())) { raw = c.getValue(); break; }
        }
        if (raw == null || raw.isEmpty()) return new HashMap<>();
        Map<Integer, CartItem> map = new HashMap<>();
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
                    map.put(id, new CartItem(prod, qty));
                }
            } catch (Exception ignore) {}
        }
        return map;
    }

    private void saveCartToCookie(HttpServletRequest request, HttpServletResponse response, Map<Integer, CartItem> cart) {
        StringBuilder sb = new StringBuilder();
        if (cart != null && !cart.isEmpty()) {
            boolean first = true;
            for (Map.Entry<Integer, CartItem> e : cart.entrySet()) {
                int id = e.getKey();
                int qty = e.getValue() != null ? e.getValue().getQuantity() : 0;
                if (qty <= 0) continue;
                if (!first) sb.append('|');
                sb.append(id).append(':').append(qty);
                first = false;
            }
        }
        Cookie cookie = new Cookie("cart", sb.toString());
        String ctx = request.getContextPath();
        cookie.setPath((ctx != null && !ctx.isEmpty()) ? ctx : "/");
        cookie.setMaxAge(60 * 60 * 24 * 30);
        response.addCookie(cookie);
    }

    private void clearCartCookie(HttpServletRequest request, HttpServletResponse response) {
        Cookie cookie = new Cookie("cart", "");
        String ctx = request.getContextPath();
        cookie.setPath((ctx != null && !ctx.isEmpty()) ? ctx : "/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }
}
