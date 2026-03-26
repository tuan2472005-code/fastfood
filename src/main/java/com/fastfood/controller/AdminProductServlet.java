package com.fastfood.controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.fastfood.dao.CategoryDAO;
import com.fastfood.dao.ProductDAO;
import com.fastfood.model.Category;
import com.fastfood.model.Product;
import com.fastfood.model.User;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        try {
            // Kiểm tra quyền
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null || !("ADMIN".equals(user.getRole()) || "STAFF".equals(user.getRole()))) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            boolean isAdmin = "ADMIN".equals(user.getRole());
            switch (action) {
                case "list":
                    listProducts(request, response);
                    break;
                case "new":
                    if (!isAdmin) { listProducts(request, response); break; }
                    showNewForm(request, response);
                    break;
                case "edit":
                    if (!isAdmin) { listProducts(request, response); break; }
                    showEditForm(request, response);
                    break;
                case "delete":
                    if (!isAdmin) { listProducts(request, response); break; }
                    deleteProduct(request, response);
                    break;
                default:
                    listProducts(request, response);
                    break;
            }
        } catch (SQLException ex) {
            System.err.println("Lỗi SQL trong doGet: " + ex.getMessage());
            if (!response.isCommitted()) {
                request.setAttribute("errorMessage", "Đã xảy ra lỗi khi truy cập dữ liệu. Vui lòng thử lại sau.");
                request.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            System.err.println("Lỗi không xác định trong doGet: " + ex.getMessage());
            if (!response.isCommitted()) {
                request.setAttribute("errorMessage", "Đã xảy ra lỗi không xác định. Vui lòng thử lại sau.");
                request.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp").forward(request, response);
            }
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String action = request.getParameter("action");
        System.out.println("DEBUG: doPost called with action: " + action);
        
        try {
            // Kiểm tra quyền admin
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null || !"ADMIN".equals(user.getRole())) {
                System.out.println("DEBUG: User not authorized, redirecting to login");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            switch (action) {
                case "save":
                    String id = request.getParameter("id");
                    System.out.println("DEBUG: Save action - ID: " + id);
                    if (id != null && !id.trim().isEmpty()) {
                        System.out.println("DEBUG: Calling updateProduct");
                        updateProduct(request, response);
                    } else {
                        System.out.println("DEBUG: Calling insertProduct");
                        insertProduct(request, response);
                    }
                    break;
                default:
                    System.out.println("DEBUG: Default action, listing products");
                    listProducts(request, response);
                    break;
            }
        } catch (SQLException ex) {
            System.err.println("Lỗi SQL trong doPost: " + ex.getMessage());
            if (!response.isCommitted()) {
                request.setAttribute("errorMessage", "Đã xảy ra lỗi khi xử lý dữ liệu. Vui lòng thử lại sau.");
                request.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            System.err.println("Lỗi không xác định trong doPost: " + ex.getMessage());
            if (!response.isCommitted()) {
                request.setAttribute("errorMessage", "Đã xảy ra lỗi không xác định. Vui lòng thử lại sau.");
                request.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp").forward(request, response);
            }
        }
    }
    
    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp").forward(request, response);
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy ID sản phẩm từ request
            int id = Integer.parseInt(request.getParameter("id"));
            
            // Lấy thông tin sản phẩm từ database
            Product product = productDAO.getProductById(id);
            
            // Kiểm tra nếu sản phẩm không tồn tại
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/admin/products?error=product_not_found");
                return;
            }
            
            // Lấy danh sách danh mục
            List<Category> categories = categoryDAO.getAllCategories();
            
            // Đặt thuộc tính cho request
            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            
            // Chuyển hướng đến trang form
            request.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            // Xử lý lỗi khi ID không phải là số
            System.err.println("Lỗi: ID sản phẩm không hợp lệ");
            e.printStackTrace();
            if (!response.isCommitted()) {
                response.sendRedirect(request.getContextPath() + "/admin/products?error=invalid_id");
            }
        } catch (SQLException e) {
            // Xử lý lỗi SQL
            System.err.println("Lỗi SQL: " + e.getMessage());
            e.printStackTrace();
            if (!response.isCommitted()) {
                response.sendRedirect(request.getContextPath() + "/admin/products?error=database_error");
            }
        } catch (Exception e) {
            // Xử lý các lỗi khác
            System.err.println("Lỗi không xác định: " + e.getMessage());
            e.printStackTrace();
            if (!response.isCommitted()) {
                response.sendRedirect(request.getContextPath() + "/admin/products?error=unknown_error");
            }
        }
    }
    
    private String handleImageUpload(HttpServletRequest request, String currentImageUrl) throws ServletException, IOException {
        try {
            String contextPath = request.getContextPath();

            Part filePart = null;
            try {
                filePart = request.getPart("imageFile");
            } catch (IllegalStateException ise) {
                // Multipart size exceeded or not multipart; continue with URL handling
            }

            String removeImage = request.getParameter("removeImage");
            if ("true".equals(removeImage)) {
                return null; // clear image
            }

            // If no new file uploaded, keep current image or use provided URL
            if (filePart == null || filePart.getSize() == 0) {
                String imageUrl = request.getParameter("imageUrl");
                if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                    return imageUrl.trim();
                }
                return currentImageUrl; // can be null
            }

            // Validate file
            String fileName = filePart.getSubmittedFileName();
            if (fileName == null || fileName.isEmpty()) {
                return currentImageUrl;
            }

            String contentType = filePart.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                throw new ServletException("Chỉ chấp nhận file ảnh");
            }

            long size = filePart.getSize();
            if (size > 5L * 1024 * 1024) { // 5MB server-side guard
                throw new ServletException("File quá lớn (>{5MB})");
            }

            // Resolve upload directory under webapp
            String uploadRoot = getServletContext().getRealPath("/uploads/products");
            if (uploadRoot == null) {
                // Fallback: temp directory
                uploadRoot = System.getProperty("java.io.tmpdir") + File.separator + "fastfood" + File.separator + "uploads" + File.separator + "products";
            }
            File uploadDir = new File(uploadRoot);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Unique filename
            String fileExtension = "";
            int dotIdx = fileName.lastIndexOf('.');
            if (dotIdx != -1) {
                fileExtension = fileName.substring(dotIdx);
            }
            String uniqueFileName = "product_" + UUID.randomUUID() + fileExtension;

            // Save file
            Path filePath = Paths.get(uploadRoot, uniqueFileName);
            Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            // Build URL relative to application root (no context prefix)
            return "/uploads/products/" + uniqueFileName;
        } catch (Exception e) {
            System.err.println("Lỗi khi upload file sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return currentImageUrl; // do not force placeholder that may not exist
        }
    }

    private Product validateAndCreateProduct(HttpServletRequest request, HttpServletResponse response, boolean isUpdate) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();

        String idParam = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceParam = request.getParameter("price");
        String categoryIdParam = request.getParameter("categoryId");
        String stockParam = request.getParameter("stock");
        String featuredParam = request.getParameter("featured");
        String status = request.getParameter("status");

        if (isUpdate && (idParam == null || idParam.trim().isEmpty())) {
            errors.add("Thiếu ID sản phẩm.");
        }
        if (name == null || name.trim().isEmpty()) {
            errors.add("Tên sản phẩm là bắt buộc.");
        }
        if (description == null) {
            description = "";
        }
        if (priceParam == null || priceParam.trim().isEmpty()) {
            errors.add("Giá sản phẩm là bắt buộc.");
        }
        if (categoryIdParam == null || categoryIdParam.trim().isEmpty()) {
            errors.add("Danh mục là bắt buộc.");
        }

        int id = 0;
        double price = 0;
        int categoryId = 0;
        try {
            if (isUpdate && idParam != null && !idParam.trim().isEmpty()) {
                id = Integer.parseInt(idParam.trim());
            }
            if (priceParam != null && !priceParam.trim().isEmpty()) {
                price = Double.parseDouble(priceParam.trim());
            }
            if (categoryIdParam != null && !categoryIdParam.trim().isEmpty()) {
                categoryId = Integer.parseInt(categoryIdParam.trim());
            }
        } catch (NumberFormatException e) {
            errors.add("Định dạng ID, giá hoặc danh mục không hợp lệ.");
        }

        if (price <= 0) {
            errors.add("Giá sản phẩm phải lớn hơn 0.");
        }
        if (status == null || status.trim().isEmpty()) {
            status = "active";
        } else if (!("active".equals(status) || "inactive".equals(status))) {
            errors.add("Trạng thái không hợp lệ. Chọn 'Đang bán' hoặc 'Ngừng bán'.");
        }

        int stock = 0;
        if (stockParam != null && !stockParam.trim().isEmpty()) {
            try {
                stock = Integer.parseInt(stockParam.trim());
                if (stock < 0) {
                    errors.add("Tồn kho không được âm.");
                }
            } catch (NumberFormatException e) {
                errors.add("Định dạng tồn kho không hợp lệ.");
            }
        }

        boolean featured = false;
        if (featuredParam != null && ("true".equals(featuredParam) || "on".equals(featuredParam))) {
            featured = true;
        }

        String currentImageUrl = null;
        if (isUpdate) {
            String currentImage = request.getParameter("currentImage");
            currentImageUrl = currentImage;
        }
        String imageUrl = handleImageUpload(request, currentImageUrl);

        if (!errors.isEmpty()) {
            try {
                List<Category> categories = categoryDAO.getAllCategories();
                request.setAttribute("categories", categories);
            } catch (SQLException e) {
                // bỏ qua, vẫn tiếp tục hiển thị lỗi form
            }
            request.setAttribute("errors", errors);

            Product draft = new Product();
            if (isUpdate) draft.setId(id);
            draft.setName(name);
            draft.setDescription(description);
            draft.setPrice(BigDecimal.valueOf(price));
            draft.setCategoryId(categoryId);
            draft.setImageUrl(imageUrl);
            draft.setStock(stock);
            draft.setFeatured(featured);
            draft.setStatus(status);
            request.setAttribute("product", draft);

            request.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp").forward(request, response);
            return null;
        }

        Product product = new Product();
        if (isUpdate) {
            product.setId(id);
        }
        product.setName(name);
        product.setDescription(description);
        product.setPrice(BigDecimal.valueOf(price));
        product.setCategoryId(categoryId);
        product.setImageUrl(imageUrl);
        product.setStock(stock);
        product.setFeatured(featured);
        product.setStatus(status);
        return product;
    }
    
    private void insertProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        System.out.println("DEBUG: insertProduct called");
        Product product = validateAndCreateProduct(request, response, false);
        if (product == null) {
            return; // đã forward về form kèm lỗi
        }
        System.out.println("DEBUG: Product created - Name: " + product.getName() + ", ImageUrl: " + product.getImageUrl());
        productDAO.addProduct(product);
        System.out.println("DEBUG: Product added to database successfully");
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        Product product = validateAndCreateProduct(request, response, true);
        if (product == null) {
            return; // đã forward về form kèm lỗi
        }
        productDAO.updateProduct(product);
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
    
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean deleted = productDAO.deleteProduct(id);
            
            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/admin/products?success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/products?error=not_deleted");
            }
        } catch (NumberFormatException e) {
            System.err.println("Lỗi: ID sản phẩm không hợp lệ - " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/products?error=invalid_id");
        } catch (Exception e) {
            System.err.println("Lỗi không xác định khi xóa sản phẩm: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/products?error=unknown_error");
        }
    }
}
