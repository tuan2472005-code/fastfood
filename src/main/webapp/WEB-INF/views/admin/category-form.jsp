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
		<c:when test="${not empty category}">Sửa danh mục</c:when>
		<c:otherwise>Thêm danh mục mới</c:otherwise>
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
/* Đồng bộ style link sidebar với trang sản phẩm */
.sidebar .nav-link {
	color: rgba(255, 255, 255, 0.9);
	padding: 15px 25px;
	display: block;
	text-decoration: none;
	transition: all 0.3s ease;
	border-radius: 8px;
	margin: 2px 10px;
}

.sidebar .nav-link:hover {
	color: white;
	background-color: rgba(255, 255, 255, 0.2);
	transform: translateX(5px);
}

.sidebar .nav-link.active {
	background-color: rgba(255, 255, 255, 0.3);
	color: white;
	font-weight: 600;
}

@media ( min-width : 992px) {
	.main-content {
		height: 100vh;
		overflow-y: auto;
	}
}

@media ( max-width : 991.98px) {
	.main-content {
		height: auto;
		overflow-y: visible;
		padding: 16px;
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
	max-width: 200px;
	max-height: 200px;
	border-radius: 15px;
	border: 2px dashed #dee2e6;
	padding: 1rem;
	text-align: center;
	background-color: #f8f9fa;
	transition: all 0.3s ease;
	margin: 0 auto;
}

.image-preview:hover {
	border-color: #FF6B35;
	background-color: rgba(255, 107, 53, 0.05);
}

.image-preview img {
	max-width: 100%;
	max-height: 150px;
	border-radius: 10px;
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
	background-color: rgba(255, 107, 53, 0.08);
}

.required {
	color: #dc3545;
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
				<nav class="nav flex-column">
					<a href="${pageContext.request.contextPath}/admin/dashboard"
						class="nav-link"> <i class="fas fa-tachometer-alt me-2"></i>
						Dashboard
					</a> <a href="${pageContext.request.contextPath}/admin/products"
						class="nav-link"> <i class="fas fa-hamburger me-2"></i> Sản
						phẩm
					</a> <a href="${pageContext.request.contextPath}/admin/categories"
						class="nav-link active"> <i class="fas fa-tags me-2"></i> Danh
						mục
					</a> <a href="${pageContext.request.contextPath}/admin/orders"
						class="nav-link"> <i class="fas fa-shopping-cart me-2"></i>
						Đơn hàng
					</a> <a href="${pageContext.request.contextPath}/admin/users"
						class="nav-link"> <i class="fas fa-users me-2"></i> Người dùng
					</a> <a href="${pageContext.request.contextPath}/admin/voucher"
						class="nav-link"> <i class="fas fa-ticket-alt me-2"></i>
						Voucher
                </a> <a href="${pageContext.request.contextPath}/admin/statistics"
                    class="nav-link"> <i class="fas fa-chart-bar me-2"></i> Thống
                    kê
                </a> <a href="${pageContext.request.contextPath}/admin/chat" class="nav-link"> <i class="fas fa-comments me-2"></i> Chat</a>
                <hr class="text-white-50">
                <a href="${pageContext.request.contextPath}/logout"
                    class="nav-link"> <i class="fas fa-sign-out-alt me-2"></i>
                    Đăng xuất
                </a>
				</nav>
			</div>

			<!-- Main Content -->
			<div class="col-md-10 main-content">
				<div class="d-md-none mb-3">
					<button class="btn btn-outline-primary" id="adminMenuBtn"
						aria-label="Mở menu">
						<i class="fas fa-bars"></i>
					</button>
				</div>
				<div class="d-flex justify-content-between align-items-center mb-4">
					<h2>
						<i class="fas fa-tags me-2 text-primary"></i>
						<c:choose>
							<c:when test="${not empty category}">Sửa danh mục</c:when>
							<c:otherwise>Thêm danh mục mới</c:otherwise>
						</c:choose>
					</h2>
					<a href="${pageContext.request.contextPath}/admin/categories"
						class="btn btn-secondary"> <i class="fas fa-arrow-left me-2"></i>Quay
						lại
					</a>
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

				<!-- Category Form -->
				<div class="form-card">
					<form action="${pageContext.request.contextPath}/admin/categories"
						method="post" enctype="multipart/form-data" id="categoryForm">

						<input type="hidden" name="action"
							value="${not empty category ? 'update' : 'create'}">
						<c:if test="${not empty category}">
							<input type="hidden" name="id" value="${category.id}">
							<input type="hidden" name="currentImage"
								value="${category.imageUrl}">
						</c:if>

						<div class="row">
							<div class="col-md-8">
								<h5 class="mb-3">
									<i class="fas fa-info-circle me-2 text-primary"></i>Thông tin
									danh mục
								</h5>

								<div class="mb-3">
									<label for="name" class="form-label"> Tên danh mục <span
										class="required">*</span>
									</label> <input type="text" class="form-control" id="name" name="name"
										value="${category.name}" required>
								</div>

								<div class="mb-3">
									<label for="description" class="form-label">Mô tả</label>
									<textarea class="form-control" id="description"
										name="description" rows="4">${category.description}</textarea>
								</div>

								<div class="mb-3">
									<label class="form-label">Hình ảnh danh mục</label>
									<div class="row g-2">
										<div class="col-md-6">
											<label for="imageUrl" class="form-label">URL hình ảnh</label>
											<input type="url" class="form-control" id="imageUrl"
												name="imageUrl" value="${category.imageUrl}"
												placeholder="https://example.com/image.jpg"> <small
												class="text-muted d-block mt-2">Bạn có thể nhập URL
												hoặc tải lên file ảnh. Nếu cả hai đều có, hệ thống sẽ ưu
												tiên file tải lên.</small>
										</div>
									</div>
								</div>
							</div>

							<div class="col-md-4">
								<h5 class="mb-3">
									<i class="fas fa-image me-2 text-primary"></i>Hình ảnh danh mục
								</h5>
								<div class="image-preview mb-3" id="imagePreview">
									<c:choose>
										<c:when test="${not empty category.imageUrl}">
											<img src="${category.imageUrl}" alt="Preview" id="previewImg"
												class="img-fluid rounded">
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
										onclick="document.getElementById('imageFile').click()">Chọn
										file</button>
									<input type="file" id="imageFile" name="imageFile"
										accept="image/*" class="d-none"> <small
										class="text-muted d-block mt-2">Định dạng: JPG, PNG,
										GIF. Tối đa 5MB</small>
								</div>

								<c:if test="${not empty category.imageUrl}">
									<div class="form-check mt-2">
										<input class="form-check-input" type="checkbox"
											id="removeImage" name="removeImage"> <label
											class="form-check-label text-danger" for="removeImage">Xóa
											hình ảnh hiện tại</label>
									</div>
								</c:if>
							</div>
						</div>

						<hr class="my-4">

						<div class="d-flex justify-content-end gap-2">
							<a href="${pageContext.request.contextPath}/admin/categories"
								class="btn btn-secondary"> <i class="fas fa-times me-2"></i>Hủy
							</a>
							<button type="submit" class="btn btn-primary">
								<i class="fas fa-save me-2"></i>
								<c:choose>
									<c:when test="${not empty category}">Cập nhật</c:when>
									<c:otherwise>Thêm mới</c:otherwise>
								</c:choose>
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        // Image upload handling (drag & drop + input)
        const imageUrlInput = document.getElementById('imageUrl');
        const imageFile = document.getElementById('imageFile');
        const uploadArea = document.getElementById('uploadArea');
        const imagePreview = document.getElementById('imagePreview');

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

        // Drag and drop handlers
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
                if (files && files.length > 0) {
                    handleFileSelect(files[0]);
                }
            });
        }

        function handleFileSelect(file) {
            if (!file) return;
            if (!file.type.startsWith('image/')) {
                alert('Vui lòng chọn file hình ảnh!');
                return;
            }
            if (file.size > 5 * 1024 * 1024) {
                alert('File quá lớn! Vui lòng chọn file nhỏ hơn 5MB.');
                return;
            }
            const reader = new FileReader();
            reader.onload = function(e) {
                setPreviewSrc(e.target.result);
            };
            reader.readAsDataURL(file);
            if (imageFile) {
                const dataTransfer = new DataTransfer();
                dataTransfer.items.add(file);
                imageFile.files = dataTransfer.files;
            }
        }

        // Remove image toggling
        const removeImageCheckbox = document.getElementById('removeImage');
        if (removeImageCheckbox) {
            removeImageCheckbox.addEventListener('change', function() {
                if (this.checked) {
                    imagePreview.innerHTML = `<div class=\"text-muted\"><i class=\"fas fa-image fa-3x mb-2\"></i><p>Chưa có hình ảnh</p></div>`;
                } else if (imageUrlInput && imageUrlInput.value) {
                    setPreviewSrc(imageUrlInput.value);
                }
            });
        }

        // Form validation
        document.getElementById('categoryForm').addEventListener('submit', function(e) {
            const name = document.getElementById('name').value.trim();
            
            if (!name) {
                e.preventDefault();
                alert('Vui lòng nhập tên danh mục!');
                document.getElementById('name').focus();
                return false;
            }
        });
		</script>
</body>
</html>
