package com.fastfood.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.fastfood.dao.CategoryDAO;
import com.fastfood.model.Category;
import com.fastfood.model.User;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
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
            case "new":
                if (!isAdmin) { listCategories(request, response); break; }
                showNewForm(request, response);
                break;
            case "edit":
                if (!isAdmin) { listCategories(request, response); break; }
                showEditForm(request, response);
                break;
            case "delete":
                if (!isAdmin) { listCategories(request, response); break; }
                deleteCategory(request, response);
                break;
            default:
                listCategories(request, response);
                break;
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        switch (action) {
            case "create":
                createCategory(request, response);
                break;
            case "update":
                updateCategory(request, response);
                break;
            default:
                listCategories(request, response);
                break;
        }
    }
    
    private void listCategories(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/views/admin/category-list.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving categories", e);
        }
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/category-form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Category category = categoryDAO.getCategoryById(id);
            request.setAttribute("category", category);
            request.getRequestDispatcher("/WEB-INF/views/admin/category-form.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving category", e);
        }
    }
    
    private void createCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String description = request.getParameter("description");

            String imageUrl = handleImageUpload(request, null);
            
            Category category = new Category();
            category.setName(name);
            category.setDescription(description);
            category.setImageUrl(imageUrl);
            
            categoryDAO.addCategory(category);
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } catch (SQLException e) {
            throw new ServletException("Error creating category", e);
        }
    }
    
    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");

            String currentImage = request.getParameter("currentImage");
            String imageUrl = handleImageUpload(request, currentImage);
            
            Category category = new Category();
            category.setId(id);
            category.setName(name);
            category.setDescription(description);
            category.setImageUrl(imageUrl);
            
            categoryDAO.updateCategory(category);
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } catch (SQLException e) {
            throw new ServletException("Error updating category", e);
        }
    }

    private String handleImageUpload(HttpServletRequest request, String currentImageUrl) throws ServletException, IOException {
        try {
            Part filePart = null;
            try {
                filePart = request.getPart("imageFile");
            } catch (IllegalStateException ise) {
                // multipart size exceeded or not multipart; continue with URL handling
            }

            // Check if user wants to remove current image
            String removeImage = request.getParameter("removeImage");
            if ("true".equals(removeImage)) {
                return null; // allow NULL in DB for no image
            }

            // If no new file uploaded, keep current image or use provided URL
            if (filePart == null || filePart.getSize() == 0) {
                String imageUrl = request.getParameter("imageUrl");
                if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                    return imageUrl.trim();
                }
                return currentImageUrl; // may be null
            }

            String fileName = filePart.getSubmittedFileName();
            if (fileName == null || fileName.isEmpty()) {
                return currentImageUrl; // may be null
            }

            // Check file type
            String contentType = filePart.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                throw new ServletException("Chỉ chấp nhận file ảnh");
            }

            // Create upload directory if not exists
            String uploadPath = getServletContext().getRealPath("/") + "uploads" + File.separator + "categories";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Generate unique filename
            String fileExtension = "";
            int dotIdx = fileName.lastIndexOf('.');
            if (dotIdx != -1) {
                fileExtension = fileName.substring(dotIdx);
            }
            String uniqueFileName = "category_" + UUID.randomUUID().toString() + fileExtension;

            // Save file
            Path filePath = Paths.get(uploadPath, uniqueFileName);
            Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            // Return relative URL with context path used in project
            return "/fastfood/uploads/categories/" + uniqueFileName;
        } catch (Exception e) {
            System.err.println("Lỗi khi upload file danh mục: " + e.getMessage());
            e.printStackTrace();
            return currentImageUrl; // fallback to current or null
        }
    }
    
    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean deleted = categoryDAO.deleteCategory(id);
            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?success=deleted");
            } else {
                // Không xóa được do không tồn tại hoặc không có dòng nào bị ảnh hưởng
                response.sendRedirect(request.getContextPath() + "/admin/categories?error=not_deleted");
            }
        } catch (java.sql.SQLIntegrityConstraintViolationException e) {
            // Không thể xóa do ràng buộc khóa ngoại (ví dụ có sản phẩm thuộc danh mục)
            response.sendRedirect(request.getContextPath() + "/admin/categories?error=in_use");
        } catch (SQLException e) {
            // MySQL: SQLState 23000 hoặc errorCode 1451 cho lỗi khóa ngoại
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            if ("23000".equals(sqlState) || errorCode == 1451) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?error=in_use");
            } else {
                throw new ServletException("Error deleting category", e);
            }
        }
    }
}
