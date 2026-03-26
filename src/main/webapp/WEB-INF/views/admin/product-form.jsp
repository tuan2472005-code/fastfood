<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><c:choose>
		<c:when test="${not empty product}">Sửa sản phẩm</c:when>
		<c:otherwise>Thêm sản phẩm mới</c:otherwise>
	</c:choose> - Admin Fast Food</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.sidebar {
	min-height: 100vh;
	background: linear-gradient(135deg, #FF6B35 0%, #F7931E 100%);
	color: white;
	box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
}

.sidebar a {
	color: rgba(255, 255, 255, 0.9);
	padding: 12px 20px;
	display: block;
	text-decoration: none;
	transition: all 0.3s ease;
	border-radius: 8px;
	margin: 2px 10px;
}

.sidebar a:hover {
	color: white;
	background-color: rgba(255, 255, 255, 0.2);
	transform: translateX(5px);
}

.sidebar a.active {
	background-color: rgba(255, 255, 255, 0.3);
	color: white;
	font-weight: 600;
}

@media ( min-width : 992px) {
	.main-content {
		height: 100vh;
		overflow-y: auto;
		padding: 30px;
	}
}

@media ( max-width : 991.98px) {
	.main-content {
		height: auto;
		overflow-y: visible;
		padding: 16px;
	}
	.container-fluid, .row {
		height: auto;
	}
	/* Off-canvas sidebar for mobile */
	.sidebar {
		position: fixed;
		top: 0;
		left: 0;
		height: 100vh;
		width: 260px;
		transform: translateX(-100%);
		transition: transform 0.3s ease;
		z-index: 1040;
	}
	.sidebar.active {
		transform: translateX(0);
	}
	.sidebar-overlay {
		position: fixed;
		inset: 0;
		background: rgba(0, 0, 0, 0.4);
		z-index: 1035;
		display: none;
	}
	.sidebar-overlay.show {
		display: block;
	}
}

.form-card {
	background: white;
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	padding: 30px;
	margin-bottom: 30px;
}

.form-label {
	font-weight: 600;
	color: #495057;
	margin-bottom: 0.5rem;
}

.form-control, .form-select {
	border-radius: 10px;
	border: 2px solid #e9ecef;
	padding: 0.75rem 1rem;
	transition: all 0.3s ease;
}

.form-control:focus, .form-select:focus {
	border-color: #FF6B35;
	box-shadow: 0 0 0 0.2rem rgba(255, 107, 53, 0.25);
}

.btn-primary {
	background: linear-gradient(135deg, #FF6B35 0%, #F7931E 100%);
	border: none;
	border-radius: 10px;
	padding: 0.75rem 2rem;
	font-weight: 600;
	transition: all 0.3s ease;
}

.btn-primary:hover {
	background: linear-gradient(135deg, #e55a2b 0%, #e8831a 100%);
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(255, 107, 53, 0.4);
}

.btn-secondary {
	border-radius: 10px;
	padding: 0.75rem 2rem;
	font-weight: 600;
	border: 2px solid #6c757d;
	transition: all 0.3s ease;
}

.btn-secondary:hover {
	transform: translateY(-2px);
}

.image-preview {
	width: 100%;
	min-height: 200px;
	max-height: 300px;
	border-radius: 15px;
	border: 2px dashed #dee2e6;
	padding: 1rem;
	text-align: center;
	background-color: #f8f9fa;
	transition: all 0.3s ease;
	display: flex;
	align-items: center;
	justify-content: center;
}

.image-preview:hover {
	border-color: #FF6B35;
	background-color: rgba(255, 107, 53, 0.05);
}

.image-preview img {
	max-width: 100%;
	max-height: 250px;
	border-radius: 10px;
	object-fit: contain;
}

.upload-area {
	border: 2px dashed #dee2e6;
	border-radius: 15px;
	padding: 2rem;
	text-align: center;
	background-color: #f8f9fa;
	cursor: pointer;
	transition: all 0.3s ease;
}

.upload-area:hover {
	border-color: #FF6B35;
	background-color: rgba(255, 107, 53, 0.05);
}

.upload-area.dragover {
	border-color: #FF6B35;
	background-color: rgba(255, 107, 53, 0.1);
}

.required {
	color: #dc3545;
}

.form-actions {
	position: relative;
	z-index: 10;
	background-color: white;
	padding: 1rem 0;
	margin-top: 2rem;
}

.main-content {
	min-height: 100vh;
	padding-bottom: 100px;
}

.invalid-feedback {
	display: none;
}

.breadcrumb {
	background: none;
	padding: 0;
}

.breadcrumb-item a {
	color: #FF6B35;
	text-decoration: none;
}

.breadcrumb-item a:hover {
	color: #e55a2b;
}

.alert {
	border-radius: 10px;
	border: none;
}

.text-primary {
	color: #FF6B35 !important;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar -->
			<div class="col-md-2 p-0 sidebar">
				<div class="p-4 text-center">
					<h4>
						<video
							src="${pageContext.request.contextPath}/images/logofastfood.mp4"
							alt="Fast Food Logo" style="height: 30px; margin-right: 10px;"
							autoplay muted loop></video>
						Fast Food Admin
					</h4>
					<hr class="text-white">
					<div class="text-center">
						<i class="fas fa-user-circle fa-2x mb-2"></i>
						<p class="mb-0">Admin</p>
						<small class="text-white-50"> <script>document.write(new Date().toLocaleDateString('vi-VN'));</script>
						</small>
					</div>
				</div>
				<a href="${pageContext.request.contextPath}/admin/dashboard"> <i
					class="fas fa-chart-pie me-2"></i> Dashboard
				</a> <a href="${pageContext.request.contextPath}/admin/products"
					class="active"> <i class="fas fa-hamburger me-2"></i> Sản phẩm
				</a> <a href="${pageContext.request.contextPath}/admin/categories">
					<i class="fas fa-tags me-2"></i> Danh mục
				</a> <a href="${pageContext.request.contextPath}/admin/orders"> <i
					class="fas fa-shopping-cart me-2"></i> Đơn hàng
				</a> <a href="${pageContext.request.contextPath}/admin/users"> <i
					class="fas fa-users me-2"></i> Người dùng
				</a> <a href="${pageContext.request.contextPath}/admin/voucher"> <i
					class="fas fa-ticket-alt me-2"></i> Voucher
                </a> <a href="${pageContext.request.contextPath}/admin/statistics">
                    <i class="fas fa-chart-bar me-2"></i> Thống kê
                </a> <a href="${pageContext.request.contextPath}/admin/chat"> <i class="fas fa-comments me-2"></i> Chat</a>
                <a href="${pageContext.request.contextPath}/logout"> <i
                    class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                </a>
			</div>

			<!-- Main Content -->
			<div class="col-md-10 main-content">
				<div class="d-md-none mb-3">
					<button class="btn btn-outline-primary" id="adminMenuBtn"
						aria-label="Mở menu">
						<i class="fas fa-bars"></i>
					</button>
				</div>
				<script>
                    (function() {
                        const btn = document.getElementById('adminMenuBtn');
                        const sidebar = document.querySelector('.sidebar');
                        let overlay = document.getElementById('sidebarOverlay');
                        if (!overlay) {
                            overlay = document.createElement('div');
                            overlay.id = 'sidebarOverlay';
                            overlay.className = 'sidebar-overlay d-md-none';
                            document.body.appendChild(overlay);
                        }
                        if (btn && sidebar && overlay) {
                            btn.addEventListener('click', function() {
                                sidebar.classList.add('active');
                                overlay.classList.add('show');
                            });
                            overlay.addEventListener('click', function() {
                                sidebar.classList.remove('active');
                                overlay.classList.remove('show');
                            });
                        }
                    })();
                </script>
				<div class="d-flex justify-content-between align-items-center mb-4">
					<div>
						<h2>
							<c:choose>
								<c:when test="${not empty product}">
									<i class="fas fa-edit me-2 text-primary"></i>Sửa sản phẩm
                                </c:when>
								<c:otherwise>
									<i class="fas fa-plus me-2 text-primary"></i>Thêm sản phẩm mới
                                </c:otherwise>
							</c:choose>
						</h2>
						<nav aria-label="breadcrumb">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a
									href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
								</li>
								<li class="breadcrumb-item"><a
									href="${pageContext.request.contextPath}/admin/products">Sản
										phẩm</a></li>
								<li class="breadcrumb-item active"><c:choose>
										<c:when test="${not empty product}">Sửa sản phẩm</c:when>
										<c:otherwise>Thêm mới</c:otherwise>
									</c:choose></li>
							</ol>
						</nav>
					</div>
				</div>

				<!-- Error/Success Messages -->
				<c:if test="${not empty error}">
					<div class="alert alert-danger alert-dismissible fade show"
						role="alert">
						<i class="fas fa-exclamation-circle me-2"></i>${error}
						<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
					</div>
				</c:if>

				<c:if test="${not empty success}">
					<div class="alert alert-success alert-dismissible fade show"
						role="alert">
						<i class="fas fa-check-circle me-2"></i>${success}
						<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
					</div>
				</c:if>

				<!-- Product Form -->
				<div class="form-card">
					<!-- Debug Info -->
					<c:if test="${not empty product}">
						<div class="alert alert-info">
							<strong>Chế độ sửa:</strong> Đang sửa sản phẩm ID: ${product.id}
							- ${product.name}
						</div>
					</c:if>
					<c:if test="${empty product}">
						<div class="alert alert-warning">
							<strong>Chế độ thêm mới:</strong> Đang thêm sản phẩm mới
						</div>
					</c:if>

					<c:if test="${not empty errors}">
						<div class="alert alert-danger">
							<ul class="mb-0">
								<c:forEach var="err" items="${errors}">
									<li>${err}</li>
								</c:forEach>
							</ul>
						</div>
					</c:if>

					<form
						action="${pageContext.request.contextPath}/admin/products?action=save"
						method="post" enctype="multipart/form-data" id="productForm">

						<c:if test="${not empty product}">
							<input type="hidden" name="id" value="${product.id}">
						</c:if>

						<div class="row">
							<!-- Product Information -->
							<div class="col-md-8">
								<h5 class="mb-3">
									<i class="fas fa-info-circle me-2 text-primary"></i>Thông tin
									sản phẩm
								</h5>

								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="name" class="form-label"> Tên sản phẩm <span
											class="required">*</span>
										</label> <input type="text" class="form-control" id="name" name="name"
											value="${product.name}" placeholder="Nhập tên sản phẩm"
											required>
										<div class="invalid-feedback">Vui lòng nhập tên sản phẩm
										</div>
									</div>

									<div class="col-md-6 mb-3">
										<label for="categoryId" class="form-label"> Danh mục <span
											class="required">*</span>
										</label> <select class="form-select" id="categoryId" name="categoryId"
											required>
											<option value="">Chọn danh mục</option>
											<c:forEach var="category" items="${categories}">
												<option value="${category.id}"
													<c:if test="${category.id == product.categoryId}">selected</c:if>>
													${category.name}</option>
											</c:forEach>
										</select>
										<div class="invalid-feedback">Vui lòng chọn danh mục</div>
									</div>
								</div>

								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="price" class="form-label"> Giá bán <span
											class="required">*</span>
										</label>
										<div class="input-group">
											<input type="number" class="form-control" id="price"
												name="price" value="${product.price}" placeholder="0"
												min="0" step="1000" required> <span
												class="input-group-text">₫</span>
										</div>
										<div class="invalid-feedback">Vui lòng nhập giá bán hợp
											lệ</div>
									</div>

									<div class="col-md-6 mb-3">
										<label for="status" class="form-label">Trạng thái</label> <select
											class="form-select" id="status" name="status">
											<option value="active"
												<c:if test="${product.status == 'active' || empty product}">selected</c:if>>
												Đang bán</option>
											<option value="inactive"
												<c:if test="${product.status == 'inactive'}">selected</c:if>>
												Tạm ngưng</option>
										</select>
									</div>
								</div>

								<div class="mb-3">
									<label for="description" class="form-label">Mô tả sản
										phẩm</label>
									<textarea class="form-control" id="description"
										name="description" rows="4"
										placeholder="Nhập mô tả chi tiết về sản phẩm...">${product.description}</textarea>
								</div>

								<div class="row">
									<div class="col-md-4 mb-3">
										<label for="featured" class="form-label">Sản phẩm nổi
											bật</label>
										<div class="form-check mt-2">
											<input type="checkbox" class="form-check-input" id="featured"
												name="featured" value="true"
												<c:if test="${product.featured}">checked</c:if>> <label
												class="form-check-label" for="featured"> Đánh dấu là
												sản phẩm nổi bật </label>
										</div>
									</div>

									<div class="col-md-4 mb-3">
										<label for="imageUrl" class="form-label">URL Hình ảnh</label>
										<input type="text" class="form-control" id="imageUrl"
											name="imageUrl" value="${product.imageUrl}"
											placeholder="Nhập URL hình ảnh hoặc để trống">
									</div>
								</div>
							</div>

							<!-- Product Image -->
							<div class="col-md-4">
								<h5 class="mb-3">
									<i class="fas fa-image me-2 text-primary"></i>Hình ảnh sản phẩm
								</h5>

								<div class="image-preview mb-3" id="imagePreview">
									<c:choose>
										<c:when test="${not empty product.imageUrl}">
											<img src="${product.imageUrl}" alt="Product Image"
												id="previewImg">
										</c:when>
										<c:otherwise>
											<div class="text-muted">
												<i class="fas fa-image fa-3x mb-2"></i>
												<p>Chưa có hình ảnh</p>
											</div>
										</c:otherwise>
									</c:choose>
								</div>

								<div class="upload-area" id="uploadArea">
									<i class="fas fa-cloud-upload-alt fa-2x text-muted mb-2"></i>
									<p class="mb-2">Kéo thả hình ảnh vào đây hoặc</p>
									<button type="button" class="btn btn-outline-primary btn-sm"
										onclick="document.getElementById('imageFile').click()">
										Chọn file</button>
									<input type="file" id="imageFile" name="imageFile"
										accept="image/*" style="display: none;"> <small
										class="text-muted d-block mt-2"> Định dạng: JPG, PNG,
										GIF. Tối đa 5MB </small>
								</div>

								<c:if test="${not empty product.imageUrl}">
									<input type="hidden" name="currentImage"
										value="${product.imageUrl}">
									<div class="form-check mt-2">
										<input class="form-check-input" type="checkbox"
											id="removeImage" name="removeImage"> <label
											class="form-check-label" for="removeImage"> Xóa hình
											ảnh hiện tại </label>
									</div>
								</c:if>
							</div>
						</div>

						<!-- Form Actions -->
						<div class="border-top pt-3 mt-4 form-actions">
							<div class="d-flex justify-content-between">
								<a href="${pageContext.request.contextPath}/admin/products"
									class="btn btn-secondary"> <i
									class="fas fa-arrow-left me-1"></i>Quay lại
								</a>

								<div>
									<button type="reset" class="btn btn-outline-secondary me-2">
										<i class="fas fa-undo me-1"></i>Đặt lại
									</button>
									<button type="submit" class="btn btn-primary">
										<i class="fas fa-save me-1"></i>
										<c:choose>
											<c:when test="${product != null}">Cập nhật</c:when>
											<c:otherwise>Thêm mới</c:otherwise>
										</c:choose>
									</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        // Image upload handling
        const imageFile = document.getElementById('imageFile');
        const uploadArea = document.getElementById('uploadArea');
        const imagePreview = document.getElementById('imagePreview');
        const imageUrlInput = document.getElementById('imageUrl');
        
        function setPreviewSrc(src) {
            let img = document.getElementById('previewImg');
            if (!img) {
                imagePreview.innerHTML = `<img src="${src}" alt="Preview" id="previewImg" class="img-fluid rounded">`;
            } else {
                img.src = src;
            }
        }

        // Update preview from URL
        if (imageUrlInput) {
            imageUrlInput.addEventListener('input', function() {
                const url = this.value.trim();
                if (!url) {
                    imagePreview.innerHTML = `<div class="text-muted"><i class="fas fa-image fa-3x mb-2"></i><p>Chưa có hình ảnh</p></div>`;
                    return;
                }
                setPreviewSrc(url);
            });
        }
        
        // File input change
        if (imageFile) {
            imageFile.addEventListener('change', function(e) {
                handleFileSelect(e.target.files[0]);
            });
        }
        
        // Drag and drop
        if (uploadArea) {
            uploadArea.addEventListener('dragover', function(e) {
                e.preventDefault();
                uploadArea.classList.add('dragover');
            });
            
            uploadArea.addEventListener('dragleave', function(e) {
                e.preventDefault();
                uploadArea.classList.remove('dragover');
            });
            
            uploadArea.addEventListener('drop', function(e) {
                e.preventDefault();
                uploadArea.classList.remove('dragover');
                
                const files = e.dataTransfer.files;
                if (files.length > 0) {
                    handleFileSelect(files[0]);
                }
            });
        }
        
        function handleFileSelect(file) {
            if (!file) return;
            
            // Validate file type
            if (!file.type.startsWith('image/')) {
                alert('Vui lòng chọn file hình ảnh!');
                return;
            }
            
            // Validate file size (5MB)
            if (file.size > 5 * 1024 * 1024) {
                alert('File quá lớn! Vui lòng chọn file nhỏ hơn 5MB.');
                return;
            }
            
            // Preview image
            const reader = new FileReader();
            reader.onload = function(e) {
                setPreviewSrc(e.target.result);
            };
            reader.readAsDataURL(file);
            
            // Update file input
            if (imageFile) {
                const dataTransfer = new DataTransfer();
                dataTransfer.items.add(file);
                imageFile.files = dataTransfer.files;
            }
        }
        
        // Form validation
        document.getElementById('productForm').addEventListener('submit', function(e) {
            const name = document.getElementById('name').value.trim();
            const categoryId = document.getElementById('categoryId').value;
            const price = document.getElementById('price').value;
            
            if (!name) {
                e.preventDefault();
                alert('Vui lòng nhập tên sản phẩm!');
                document.getElementById('name').focus();
                return;
            }
            
            if (!categoryId) {
                e.preventDefault();
                alert('Vui lòng chọn danh mục!');
                document.getElementById('categoryId').focus();
                return;
            }
            
            if (!price || price <= 0) {
                e.preventDefault();
                alert('Vui lòng nhập giá bán hợp lệ!');
                document.getElementById('price').focus();
                return;
            }
        });
        

        
        // Format price input
        document.getElementById('price').addEventListener('input', function(e) {
            let value = e.target.value.replace(/[^\d]/g, '');
            if (value) {
                e.target.value = parseInt(value);
            }
        });
        
        // Auto-hide alerts
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                if (alert.classList.contains('show')) {
                    alert.classList.remove('show');
                    setTimeout(() => alert.remove(), 150);
                }
            });
        }, 5000);
    </script>
</body>
</html>
