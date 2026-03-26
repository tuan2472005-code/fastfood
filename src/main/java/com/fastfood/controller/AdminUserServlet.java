package com.fastfood.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fastfood.dao.UserDAO;
import com.fastfood.model.User;

public class AdminUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO = new UserDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            default:
                listUsers(request, response);
                break;
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        switch (action) {
            case "update":
                updateUser(request, response);
                break;
            default:
                listUsers(request, response);
                break;
        }
    }
    
    private void listUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/views/admin/user-list.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        User user = userDAO.getUserByUsername(username);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
    }
    
    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("role");
        
        // Lấy user hiện tại để có ID
        User user = userDAO.getUserByUsername(username);
        if (user != null) {
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRole(role);
            
            HttpSession session = request.getSession();
            boolean isDemoteAdmin = "ADMIN".equals(user.getRole()) && (role == null || !"ADMIN".equals(role));
            if (isDemoteAdmin) {
                try {
                    int adminCount = userDAO.countAdmins();
                    if (adminCount <= 1) {
                        session.setAttribute("flashError", "Không thể giáng cấp quản trị viên cuối cùng");
                        response.sendRedirect(request.getContextPath() + "/admin/users");
                        return;
                    }
                } catch (Exception e) {
                    session.setAttribute("flashError", "Lỗi kiểm tra quyền quản trị");
                    response.sendRedirect(request.getContextPath() + "/admin/users");
                    return;
                }
            }

            boolean updated = userDAO.updateUser(user);
            if (updated) {
                HttpSession s2 = request.getSession(false);
                if (s2 != null) {
                    User sessionUser = (User) s2.getAttribute("user");
                    if (sessionUser != null && sessionUser.getUsername().equals(user.getUsername())) {
                        User refreshed = userDAO.getUserByUsername(user.getUsername());
                        if (refreshed != null) {
                            s2.setAttribute("user", refreshed);
                        }
                    }
                }
                session.setAttribute("flashSuccess", "Cập nhật người dùng thành công");
            } else {
                session.setAttribute("flashError", "Cập nhật người dùng thất bại");
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
    
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        User user = userDAO.getUserByUsername(username);
        HttpSession session = request.getSession();
        if (user != null) {
            if ("ADMIN".equals(user.getRole())) {
                try {
                    int adminCount = userDAO.countAdmins();
                    if (adminCount <= 1) {
                        session.setAttribute("flashError", "Không thể xóa quản trị viên cuối cùng");
                        response.sendRedirect(request.getContextPath() + "/admin/users");
                        return;
                    }
                } catch (Exception e) {
                    session.setAttribute("flashError", "Lỗi kiểm tra quyền quản trị");
                    response.sendRedirect(request.getContextPath() + "/admin/users");
                    return;
                }
            }
            boolean deleted = userDAO.deleteUser(user.getId());
            if (deleted) {
                session.setAttribute("flashSuccess", "Xóa người dùng thành công");
            } else {
                session.setAttribute("flashError", "Xóa người dùng thất bại");
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
