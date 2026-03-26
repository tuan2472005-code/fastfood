<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${voucher != null ? 'Chỉnh sửa' : 'Thêm'}Voucher-
	Fastfood</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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

.table-container {
	background: white;
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.form-container {
	background: white;
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	padding: 30px;
}

.required {
	color: #dc3545;
}

.form-label {
	font-weight: 600;
	color: #495057;
}

.btn-primary {
	background: linear-gradient(135deg, #FF6B35 0%, #F7931E 100%);
	border: none;
	border-radius: 10px;
}

.btn-primary:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(255, 107, 53, 0.4);
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
				</a> <a href="${pageContext.request.contextPath}/admin/users"> <i
					class="fas fa-users me-2"></i> Người dùng
				</a> <a href="${pageContext.request.contextPath}/admin/voucher"
					class="active"> <i class="fas fa-ticket-alt me-2"></i> Voucher
                </a> <a href="${pageContext.request.contextPath}/admin/statistics">
                    <i class="fas fa-chart-bar me-2"></i> Thống kê
                </a> <a href="${pageContext.request.contextPath}/admin/chat"> <i class="fas fa-comments me-2"></i> Chat</a>
                <a href="${pageContext.request.contextPath}/logout"> <i
                    class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                </a>
			</div>

			<!-- Main Content -->
			<div class="col-md-10 main-content">
				<!-- Nút hamburger cho mobile -->
				<div class="d-lg-none mb-3">
					<button class="btn btn-outline-dark mobile-menu-btn"
						id="mobileMenuBtn">
						<i class="fas fa-bars me-2"></i>Menu
					</button>
				</div>
				<div id="menuOverlay" class="menu-overlay"></div>
				<div class="d-flex justify-content-between align-items-center mb-4">
					<h2>
						<i class="fas fa-ticket-alt me-2 text-primary"></i> ${voucher != null ? 'Chỉnh sửa' : 'Thêm'}
						Voucher
					</h2>
					<a href="${pageContext.request.contextPath}/admin/voucher"
						class="btn btn-secondary"> <i class="fas fa-arrow-left me-2"></i>Quay
						lại
					</a>
				</div>

				<!-- Thông báo lỗi/thành công nếu có -->
				<c:if test="${not empty errorMessage}">
					<div class="alert alert-danger">
						<i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
					</div>
				</c:if>
				<c:if test="${not empty successMessage}">
					<div class="alert alert-success">
						<i class="fas fa-check-circle me-2"></i>${successMessage}
					</div>
				</c:if>

				<!-- Voucher Form -->
				<div class="form-container">
					<form method="post"
						action="${pageContext.request.contextPath}/admin/voucher"
						id="voucherForm">
						<input type="hidden" name="action"
							value="${voucher != null ? 'update' : 'save'}">
						<c:if test="${voucher != null}">
							<input type="hidden" name="id" value="${voucher.id}">
						</c:if>

						<div class="row">
							<!-- Mã Voucher -->
							<div class="col-md-6 mb-3">
								<label for="code" class="form-label">Mã Voucher <span
									class="required">*</span></label> <input type="text"
									class="form-control" id="code" name="code"
									value="${voucher.code}" required maxlength="20"
									placeholder="VD: SAVE20, FREESHIP">
								<div class="form-text">Mã voucher sẽ được chuyển thành chữ
									hoa tự động</div>
							</div>

							<!-- Tên Voucher -->
							<div class="col-md-6 mb-3">
								<label for="name" class="form-label">Tên Voucher <span
									class="required">*</span></label> <input type="text"
									class="form-control" id="name" name="name"
									value="${voucher.name}" required maxlength="100"
									placeholder="VD: Giảm giá 20%">
							</div>
						</div>

						<div class="row">
							<!-- Loại giảm giá -->
							<div class="col-md-4 mb-3">
								<label for="discountType" class="form-label">Loại giảm
									giá <span class="required">*</span>
								</label> <select class="form-select" id="discountType"
									name="discountType" required onchange="toggleDiscountFields()">
									<option value="">Chọn loại giảm giá</option>
									<option value="PERCENTAGE"
										${voucher.discountType == 'PERCENTAGE' ? 'selected' : ''}>Phần
										trăm (%)</option>
									<option value="FIXED_AMOUNT"
										${voucher.discountType == 'FIXED_AMOUNT' ? 'selected' : ''}>Số
										tiền cố định (₫)</option>
								</select>
							</div>

							<!-- Giá trị giảm -->
							<div class="col-md-4 mb-3">
								<label for="discountValue" class="form-label">Giá trị
									giảm <span class="required">*</span>
								</label>
								<div class="input-group">
									<input type="number" class="form-control" id="discountValue"
										name="discountValue" value="${voucher.discountValue}" required
										min="0" step="0.01"> <span class="input-group-text"
										id="discountUnit">₫</span>
								</div>
							</div>

							<!-- Đơn hàng tối thiểu -->
							<div class="col-md-4 mb-3">
								<label for="minOrderAmount" class="form-label">Đơn hàng
									tối thiểu</label>
								<div class="input-group">
									<input type="number" class="form-control" id="minOrderAmount"
										name="minOrderAmount" value="${voucher.minOrderAmount}"
										min="0" step="1000"> <span class="input-group-text">₫</span>
								</div>
								<div class="form-text">Để trống hoặc 0 nếu không yêu cầu</div>
							</div>
						</div>

						<div class="row">
							<!-- Giảm giá tối đa (chỉ áp dụng cho loại phần trăm) -->
							<div class="col-md-6 mb-3" id="maxDiscountField"
								style="display: none;">
								<label for="maxDiscountAmount" class="form-label">Giảm
									giá tối đa</label>
								<div class="input-group">
									<input type="number" class="form-control"
										id="maxDiscountAmount" name="maxDiscountAmount"
										value="${voucher.maxDiscountAmount}" min="0" step="1000">
									<span class="input-group-text">₫</span>
								</div>
								<div class="form-text">Áp dụng cho voucher giảm theo phần
									trăm. Để trống nếu không giới hạn</div>
							</div>
						</div>

						<div class="row">
							<!-- Giới hạn số lần sử dụng -->
							<div class="col-md-4 mb-3">
								<label for="usageLimit" class="form-label">Giới hạn số
									lần dùng</label> <input type="number" class="form-control"
									id="usageLimit" name="usageLimit" value="${voucher.usageLimit}"
									min="1">
								<div class="form-text">Để trống nếu không giới hạn</div>
							</div>

							<!-- Loại voucher -->
							<div class="col-md-4 mb-3">
								<label for="voucherType" class="form-label">Loại voucher
									<span class="required">*</span>
								</label> <select class="form-select" id="voucherType" name="voucherType"
									required>
									<option value="PRODUCT"
										${voucher == null || voucher.voucherType == 'PRODUCT' ? 'selected' : ''}>Voucher
										sản phẩm</option>
									<option value="SHIPPING"
										${voucher.voucherType == 'SHIPPING' ? 'selected' : ''}>Voucher
										vận chuyển</option>
								</select>
								<div class="form-text">Chọn loại voucher áp dụng</div>
							</div>

							<!-- Trạng thái -->
							<div class="col-md-4 mb-3">
								<label class="form-label">Trạng thái</label>
								<div class="form-check form-switch">
									<input class="form-check-input" type="checkbox" id="isActive"
										name="isActive"
										${voucher == null || voucher.active ? 'checked' : ''}>
									<label class="form-check-label" for="isActive"> Kích
										hoạt voucher </label>
								</div>
							</div>
						</div>

						<div class="row">
							<!-- Ngày bắt đầu -->
							<div class="col-md-6 mb-3">
								<label for="startDate" class="form-label">Ngày bắt đầu <span
									class="required">*</span></label> <input type="datetime-local"
									class="form-control" id="startDate" name="startDate" required
									value="<fmt:formatDate value='${voucher.startDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/>">
							</div>

							<!-- Ngày kết thúc -->
							<div class="col-md-6 mb-3">
								<label for="endDate" class="form-label">Ngày kết thúc <span
									class="required">*</span></label> <input type="datetime-local"
									class="form-control" id="endDate" name="endDate" required
									value="<fmt:formatDate value='${voucher.endDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/>">
							</div>
						</div>

						<!-- Submit Buttons -->
						<div class="row">
							<div class="col-12">
								<hr>
								<div class="d-flex justify-content-end gap-2">
									<a href="${pageContext.request.contextPath}/admin/voucher"
										class="btn btn-secondary"> <i class="fas fa-times me-2"></i>Hủy
									</a>
									<button type="submit" class="btn btn-primary">
										<i class="fas fa-save me-2"></i>${voucher != null ? 'Cập nhật' : 'Tạo'}
										Voucher
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
        function toggleDiscountFields() {
            const discountType = document.getElementById('discountType').value;
            const discountUnit = document.getElementById('discountUnit');
            const discountValue = document.getElementById('discountValue');
            const maxDiscountField = document.getElementById('maxDiscountField');
            
            if (discountType === 'PERCENTAGE') {
                discountUnit.textContent = '%';
                discountValue.max = '100';
                maxDiscountField.style.display = 'block';
            } else if (discountType === 'FIXED_AMOUNT') {
                discountUnit.textContent = '₫';
                discountValue.max = '';
                maxDiscountField.style.display = 'none';
            } else {
                maxDiscountField.style.display = 'none';
            }
        }
        
        // Initialize form on page load
        document.addEventListener('DOMContentLoaded', function() {
            toggleDiscountFields();
        });
        
        // Form validation
        document.getElementById('voucherForm').addEventListener('submit', function(e) {
            const startDate = new Date(document.getElementById('startDate').value);
            const endDate = new Date(document.getElementById('endDate').value);
            
            if (endDate <= startDate) {
                e.preventDefault();
                alert('Ngày kết thúc phải sau ngày bắt đầu');
                return false;
            }
            
            const discountType = document.getElementById('discountType').value;
            const discountValue = parseFloat(document.getElementById('discountValue').value);
            
            if (discountType === 'PERCENTAGE' && discountValue > 100) {
                e.preventDefault();
                alert('Giá trị giảm giá phần trăm không được vượt quá 100%');
                return false;
            }
            
            return true;
        });
        
        // Auto uppercase voucher code
        document.getElementById('code').addEventListener('input', function(e) {
            e.target.value = e.target.value.toUpperCase();
        });
        
        // Initialize discount fields
        document.addEventListener('DOMContentLoaded', function() {
            toggleDiscountFields();
            
            // Set default start date to now if creating new voucher
            <c:if test="${voucher == null}">
                const now = new Date();
                now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
                document.getElementById('startDate').value = now.toISOString().slice(0, 16);
                
                // Set default end date to 30 days from now
                const endDate = new Date(now.getTime() + 30 * 24 * 60 * 60 * 1000);
                document.getElementById('endDate').value = endDate.toISOString().slice(0, 16);
            </c:if>
        });
        
        // Auto hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);

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
