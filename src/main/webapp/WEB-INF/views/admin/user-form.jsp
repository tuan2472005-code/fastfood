<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sửa thông tin người dùng - Admin Fast Food</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
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
	/* Sidebar off-canvas trên mobile */
	.sidebar {
		position: fixed;
		top: 0;
		bottom: 0;
		left: 0;
		width: 260px;
		max-width: 80%;
		transform: translateX(-100%);
		transition: transform 0.3s ease;
		z-index: 1040;
	}
	.sidebar.open {
		transform: translateX(0);
	}
	/* Nút hamburger */
	.mobile-menu-btn {
		display: inline-flex;
		align-items: center;
		gap: 8px;
	}
	/* Overlay */
	.menu-overlay {
		position: fixed;
		inset: 0;
		background: rgba(0, 0, 0, 0.4);
		opacity: 0;
		visibility: hidden;
		transition: opacity 0.3s ease, visibility 0.3s ease;
		z-index: 1030;
	}
	.menu-overlay.show {
		opacity: 1;
		visibility: visible;
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

.form-control {
	border-radius: 10px;
	border: 2px solid #e9ecef;
	padding: 0.75rem 1rem;
	transition: all 0.3s ease;
}

.form-control:focus {
	border-color: #667eea;
	box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
}

.btn-primary {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	border: none;
	border-radius: 10px;
	padding: 0.75rem 2rem;
	font-weight: 600;
	transition: all 0.3s ease;
}

.btn-primary:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
}

.btn-secondary {
	border-radius: 10px;
	padding: 0.75rem 2rem;
	font-weight: 600;
}

.role-badge {
	padding: 0.5rem 1rem;
	border-radius: 20px;
	font-size: 0.875rem;
	font-weight: 600;
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
				</a> <a href="${pageContext.request.contextPath}/admin/products"> <i
					class="fas fa-hamburger me-2"></i> Sản phẩm
				</a> <a href="${pageContext.request.contextPath}/admin/categories">
					<i class="fas fa-tags me-2"></i> Danh mục
				</a> <a href="${pageContext.request.contextPath}/admin/orders"> <i
					class="fas fa-shopping-cart me-2"></i> Đơn hàng
				</a> <a href="${pageContext.request.contextPath}/admin/users"
					class="active"> <i class="fas fa-users me-2"></i> Người dùng
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
				<!-- Nút hamburger hiển thị trên mobile -->
				<div class="d-lg-none mb-3">
					<button class="btn btn-outline-dark mobile-menu-btn"
						id="mobileMenuBtn">
						<i class="fas fa-bars me-2"></i>Menu
					</button>
				</div>
				<div id="menuOverlay" class="menu-overlay"></div>
				<div class="d-flex justify-content-between align-items-center mb-4">
					<h2 class="mb-0">
						<i class="fas fa-user-edit me-2 text-primary"></i> Sửa thông tin
						người dùng
					</h2>
					<nav aria-label="breadcrumb">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a
								href="${pageContext.request.contextPath}/admin/dashboard"> <i
									class="fas fa-home"></i> Dashboard
							</a></li>
							<li class="breadcrumb-item"><a
								href="${pageContext.request.contextPath}/admin/users">Người
									dùng</a></li>
							<li class="breadcrumb-item active">Sửa thông tin</li>
						</ol>
					</nav>
				</div>

				<div class="row justify-content-center">
					<div class="col-lg-8">
						<div class="form-card">
							<div class="text-center mb-4">
								<div class="avatar-container mb-3">
									<i class="fas fa-user-circle fa-4x text-primary"></i>
								</div>
								<h4 class="mb-0">
									Thông tin người dùng: <strong>${user.username}</strong>
								</h4>
								<p class="text-muted">Cập nhật thông tin chi tiết của người
									dùng</p>
							</div>

							<form method="post"
								action="${pageContext.request.contextPath}/admin/users">
								<input type="hidden" name="action" value="update"> <input
									type="hidden" name="username" value="${user.username}">

								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="username" class="form-label"> <i
											class="fas fa-user me-1"></i>Tên đăng nhập
										</label> <input type="text" class="form-control" id="username"
											value="${user.username}" readonly> <small
											class="text-muted">Tên đăng nhập không thể thay đổi</small>
									</div>
									<div class="col-md-6 mb-3">
										<label for="fullName" class="form-label"> <i
											class="fas fa-id-card me-1"></i>Họ và tên <span
											class="text-danger">*</span>
										</label> <input type="text" class="form-control" id="fullName"
											name="fullName" value="${user.fullName}" required>
									</div>
								</div>

								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="email" class="form-label"> <i
											class="fas fa-envelope me-1"></i>Email <span
											class="text-danger">*</span>
										</label> <input type="email" class="form-control" id="email"
											name="email" value="${user.email}" required>
									</div>
									<div class="col-md-6 mb-3">
										<label for="phone" class="form-label"> <i
											class="fas fa-phone me-1"></i>Số điện thoại
										</label> <input type="tel" class="form-control" id="phone"
											name="phone" value="${user.phone}">
									</div>
								</div>

								<div class="mb-3">
									<label for="address" class="form-label"> <i
										class="fas fa-map-marker-alt me-1"></i>Địa chỉ
									</label>
									<textarea class="form-control" id="address" name="address"
										rows="3">${user.address}</textarea>
								</div>

								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="role" class="form-label"> <i
											class="fas fa-user-tag me-1"></i>Vai trò <span
											class="text-danger">*</span>
										</label> <select class="form-control" id="role" name="role" required>
											<option value="KHACH_HANG"
												${user.role eq 'KHACH_HANG' ? 'selected' : ''}><i
													class="fas fa-user"></i> Khách hàng
                                            </option>
                                            <option value="STAFF"
                                                ${user.role eq 'STAFF' ? 'selected' : ''}>Nhân viên
                                            </option>
                                            <option value="ADMIN"
                                                ${user.role eq 'ADMIN' ? 'selected' : ''}><i
                                                    class="fas fa-crown"></i> Quản trị viên
                                            </option>
										</select>
									</div>
									<div class="col-md-6 mb-3">
										<label class="form-label"> <i
											class="fas fa-calendar-alt me-1"></i>Ngày tạo
										</label> <input type="text" class="form-control"
											value="<fmt:formatDate value='${user.createdAt}' pattern='dd/MM/yyyy HH:mm'/>"
											readonly>
									</div>
								</div>

								<div class="text-center mt-4">
									<button type="submit" class="btn btn-primary me-3">
										<i class="fas fa-save me-2"></i>Cập nhật thông tin
									</button>
									<a href="${pageContext.request.contextPath}/admin/users"
										class="btn btn-secondary"> <i
										class="fas fa-arrow-left me-2"></i>Quay lại danh sách
									</a>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const fullName = document.getElementById('fullName').value.trim();
            const email = document.getElementById('email').value.trim();
            
            if (!fullName) {
                e.preventDefault();
                alert('Vui lòng nhập họ và tên!');
                document.getElementById('fullName').focus();
                return;
            }
            
            if (!email) {
                e.preventDefault();
                alert('Vui lòng nhập email!');
                document.getElementById('email').focus();
                return;
            }
            
            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Email không hợp lệ!');
                document.getElementById('email').focus();
                return;
            }
        });

        // Toggle sidebar mobile
        document.addEventListener('DOMContentLoaded', function() {
            const sidebar = document.querySelector('.sidebar');
            const btn = document.getElementById('mobileMenuBtn');
            let overlay = document.getElementById('menuOverlay');
            if (!overlay) {
                overlay = document.createElement('div');
                overlay.id = 'menuOverlay';
                overlay.className = 'menu-overlay';
                document.body.appendChild(overlay);
            }
            const openMenu = () => {
                sidebar.classList.add('open');
                overlay.classList.add('show');
                document.body.style.overflow = 'hidden';
            };
            const closeMenu = () => {
                sidebar.classList.remove('open');
                overlay.classList.remove('show');
                document.body.style.overflow = '';
            };
            btn && btn.addEventListener('click', function(){
                if (sidebar.classList.contains('open')) closeMenu(); else openMenu();
            });
            overlay.addEventListener('click', closeMenu);
            window.addEventListener('resize', function(){
                if (window.innerWidth >= 992) closeMenu();
            });
        });
    </script>
</body>
</html>
