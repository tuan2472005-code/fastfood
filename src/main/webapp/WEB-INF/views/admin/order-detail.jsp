<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Chi tiết đơn hàng #${order.id} - Admin Fast Food</title>
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
	min-height: 100vh;
	overflow-x: hidden;
	overflow-y: auto;
}

.container-fluid {
	padding: 0;
	margin: 0;
	width: 100%;
	height: 100vh;
}

.row {
	margin: 0;
	height: 100%;
}

.row.g-4 {
	display: flex;
	align-items: stretch;
}

.col-lg-8, .col-lg-4 {
	display: flex;
	flex-direction: column;
}

.col-md-2 {
	padding: 0;
	flex: 0 0 16.666667%;
	max-width: 16.666667%;
}

.col-md-10 {
	padding: 0;
	flex: 0 0 83.333333%;
	max-width: 83.333333%;
}

/* Sidebar với gradient đẹp hơn */
.sidebar {
	background: linear-gradient(135deg, #FF6B35 0%, #F7931E 50%, #FF8C42 100%);
	color: white;
	box-shadow: 4px 0 20px rgba(0, 0, 0, 0.15);
	padding: 0;
	position: relative;
	display: block !important;
	height: 100vh;
	min-height: 100vh;
}

.sidebar::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: linear-gradient(45deg, rgba(255, 255, 255, 0.1) 0%,
		transparent 100%);
	pointer-events: none;
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

.main-content {
	height: 100vh;
	overflow-y: auto;
	padding: 30px;
}

/* Card với hiệu ứng glass morphism */
.order-card {
	background: white;
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	padding: 30px;
	margin-bottom: 30px;
}

.row.g-4 {
	margin-bottom: 2rem;
}

.d-flex.flex-column.h-100 {
	min-height: 100%;
}

.flex-fill {
	flex: 1;
}

.order-card h5 {
	margin-bottom: 1rem;
	font-weight: 600;
	color: #495057;
}

.order-card .card-content {
	flex: 1;
	display: flex;
	flex-direction: column;
}

.order-card p {
	margin-bottom: 1rem;
	line-height: 1.6;
}

.order-card .row {
	margin-bottom: 1rem;
}

/* Removed top stripe on order card */
.order-card::before {
	content: none;
	display: none;
}

/* Removed hover effect for order-card */
.status-badge {
	padding: 8px 15px;
	border-radius: 20px;
	font-weight: 600;
	font-size: 0.8rem;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.status-pending {
	background: linear-gradient(135deg, #ffc107, #ffb300);
	color: #212529;
}

.status-preparing {
	background: linear-gradient(135deg, #17a2b8, #138496);
	color: white;
}

.status-delivering {
	background: linear-gradient(135deg, #007bff, #0056b3);
	color: white;
}

.status-completed {
	background: linear-gradient(135deg, #28a745, #1e7e34);
	color: white;
}

.status-cancelled {
	background: linear-gradient(135deg, #dc3545, #c82333);
	color: white;
}

/* Timeline với hiệu ứng đẹp hơn */
.timeline {
	position: relative;
	padding-left: 30px;
	flex: 1;
}

.timeline::before {
	content: '';
	position: absolute;
	left: 0.7rem;
	top: 0;
	bottom: 0;
	width: 3px;
	background: linear-gradient(to bottom, #FF6B35, #F7931E);
	border-radius: 2px;
}

.timeline-item {
	position: relative;
	margin-bottom: 1rem;
	padding: 15px;
	background: white;
	border-radius: 8px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.timeline-item:last-child {
	margin-bottom: 0;
}

/* Removed hover effect for timeline-item */
.timeline-item::before {
	content: '';
	position: absolute;
	left: -2.2rem;
	top: 1.2rem;
	width: 16px;
	height: 16px;
	border-radius: 50%;
	background: #6c757d;
	border: 3px solid white;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
	transition: all 0.3s ease;
}

.timeline-item.active::before {
	background: linear-gradient(45deg, #28a745, #20c997);
	transform: scale(1.2);
	box-shadow: 0 4px 15px rgba(40, 167, 69, 0.4);
}

.product-item {
	border: 1px solid #e9ecef;
	border-radius: 8px;
	padding: 15px;
	margin-bottom: 1rem;
	background: white;
}

.product-item:last-child {
	margin-bottom: 0;
}

.product-item img {
	border-radius: 12px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.product-item h6 {
	margin-bottom: 0.75rem;
	font-weight: 600;
	color: #2c3e50;
}

.product-item .text-muted {
	margin-bottom: 0.5rem;
}

.product-item::before {
	content: '';
	position: absolute;
	top: 0;
	left: -100%;
	width: 100%;
	height: 100%;
	background: linear-gradient(90deg, transparent, rgba(255, 107, 53, 0.1),
		transparent);
	transition: left 0.6s ease;
}

/* Removed hover effects for product-item */

/* Button improvements */
.btn-status {
	border-radius: 20px;
	padding: 10px 20px;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	transition: all 0.3s ease;
}

/* Removed hover effects for buttons */

/* Header improvements */
h2, h5 {
	background: linear-gradient(45deg, #FF6B35, #F7931E);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
	font-weight: 700;
}

/* Animated icons */
.fas, .fab {
	transition: all 0.3s ease;
}

/* Note container styling */
.note-container {
	transition: all 0.3s ease;
	cursor: help;
	border-left: 4px solid #007bff;
}

/* Removed hover effect for note-container */

/* Price styling */
.text-danger {
	background: linear-gradient(45deg, #dc3545, #e74c3c);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
	font-weight: 700;
}

/* Responsive improvements */
@media ( max-width : 768px) {
	.main-content {
		padding: 15px;
	}
	.order-card {
		padding: 20px;
		margin-bottom: 20px;
	}
	.sidebar a {
		padding: 12px 20px;
		margin: 2px 10px;
	}
}

/* Breadcrumb và màu nhấn đồng bộ */
.breadcrumb {
	background: none;
	padding: 0;
}

.breadcrumb-item a {
	color: #FF6B35;
	text-decoration: none;
	transition: all 0.3s ease;
}

.breadcrumb-item a:hover {
	color: #e55a2b;
	/* Removed transform effect */
}

.text-primary {
	color: #FF6B35 !important;
}

/* Additional enhancements */
.badge {
	border-radius: 15px;
	padding: 8px 15px;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.alert {
	border-radius: 15px;
	border: none;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	margin-bottom: 2rem;
	padding: 1.5rem;
}

.alert h6 {
	margin-bottom: 1rem;
	font-weight: 600;
}

.alert p {
	margin-bottom: 0.5rem;
}

.alert p:last-child {
	margin-bottom: 0;
}

/* Responsive Design */
@media ( max-width : 992px) {
	.col-lg-8, .col-lg-4 {
		flex: 0 0 100%;
		max-width: 100%;
	}
	.d-flex.flex-column.h-100 {
		flex-direction: column;
	}
}

@media ( max-width : 768px) {
	.container-fluid {
		height: auto;
	}
	.row {
		height: auto;
	}
	.main-content {
		margin-left: 0;
		padding: 1rem;
		width: 100%;
		height: auto;
		min-height: 100vh;
	}
	.order-card {
		padding: 1.5rem;
		margin-bottom: 1rem;
	}
	.order-card h5 {
		font-size: 1.1rem;
		margin-bottom: 1rem;
	}
	.product-item {
		padding: 1rem;
		margin-bottom: 1rem;
	}
	.product-item .row {
		flex-direction: column;
	}
	.product-item .col-md-2 {
		margin-bottom: 1rem;
		text-align: center;
	}
	.product-item img {
		max-width: 80px;
		height: 80px;
	}
	.btn-status {
		padding: 10px 20px;
		font-size: 0.85rem;
		margin-bottom: 0.5rem;
	}
	.status-badge {
		padding: 8px 14px;
		font-size: 0.75rem;
	}
	.timeline-item {
		padding: 15px;
		margin-bottom: 1.5rem;
	}
	.alert {
		padding: 1rem;
		margin-bottom: 1.5rem;
	}
	.d-flex.justify-content-between {
		flex-direction: column;
		gap: 0.5rem;
	}
	.text-danger.fw-bold.fs-5 {
		font-size: 1.1rem !important;
	}
	.row.g-4 {
		margin-bottom: 1rem;
	}
}

@media ( max-width : 576px) {
	.order-card {
		padding: 1rem;
		border-radius: 15px;
		margin-bottom: 0.75rem;
	}
	.product-item {
		padding: 0.75rem;
	}
	.btn-status {
		padding: 8px 16px;
		font-size: 0.8rem;
	}
	.status-badge {
		padding: 6px 12px;
		font-size: 0.7rem;
	}
	h2 {
		font-size: 1.3rem;
	}
	.order-card h5 {
		font-size: 1rem;
	}
	.row.g-4 {
		margin-bottom: 0.75rem;
	}
}
/* Header task bar base styles */
.page-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 0.5rem;
	flex-wrap: wrap;
}

.page-header h2 {
	margin: 0;
	line-height: 1.25;
}

.page-header .text-muted {
	white-space: nowrap;
}

@media ( max-width : 991.98px) {
    .sidebar h4 video { display: none !important; }
    .page-header h2 {
        font-size: 1.25rem;
    }
}
/* Mobile off-canvas sidebar */
@media ( max-width : 991.98px) {
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
	.mobile-menu-btn {
		display: inline-flex;
		align-items: center;
		gap: 8px;
	}
	.menu-overlay {
		position: fixed;
		inset: 0;
		background: rgba(0, 0, 0, 0.4);
		opacity: 0;
		visibility: hidden;
		transition: opacity .3s ease, visibility .3s ease;
		z-index: 1030;
	}
	.menu-overlay.show {
		opacity: 1;
		visibility: visible;
	}
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row g-0">
			<!-- Sidebar (copy from dashboard) -->
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
				</a> <a href="${pageContext.request.contextPath}/admin/orders"
					class="active"> <i class="fas fa-shopping-cart me-2"></i> Đơn
					hàng
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
				<div id="menuOverlay" class="menu-overlay"></div>
				<div class="d-flex justify-content-between align-items-center mb-2">
					<div class="d-flex align-items-center">
						<!-- Removed sidebar toggle menu button in order detail header -->
						<h2>
							<i class="fas fa-receipt me-2 text-primary"></i>Chi tiết đơn hàng
							#${order.id}
						</h2>
					</div>
					<div class="text-muted d-flex align-items-center ms-auto">
						<i class="fas fa-user me-2"></i>Xin chào, ${user.fullName}
					</div>
				</div>

				<div class="row g-4">
					<!-- Left Side: Order Information & Product Details -->
					<div class="col-lg-8">
						<!-- Order Information -->
						<div class="order-card mb-3">
							<h5 class="mb-3">
								<i class="fas fa-info-circle me-2 text-primary"></i>Thông tin
								đơn hàng
							</h5>
							<div class="row">
								<div class="col-md-6">
									<p>
										<strong>Mã đơn hàng:</strong> #${order.id}
									</p>
									<p>
										<strong>Ngày đặt:</strong>
										<fmt:formatDate value="${order.createdAt}"
											pattern="dd/MM/yyyy HH:mm" />
									</p>
									<p>
										<strong>Khách hàng:</strong> ${order.customerName}
									</p>
									<p>
										<strong>Số điện thoại:</strong> ${order.customerPhone}
									</p>
									<p>
										<strong><i
											class="fas fa-info-circle me-2 text-primary"
											data-bs-toggle="tooltip" data-bs-placement="top"
											title="Trạng thái hiện tại của đơn hàng"></i>Trạng thái:</strong>
										<c:choose>
											<c:when test="${order.status == 'CHO_XAC_NHAN'}">
												<span class="status-badge status-pending"> <i
													class="fas fa-clock me-1"></i>Chờ xác nhận
												</span>
											</c:when>
											<c:when test="${order.status == 'DANG_CHUAN_BI'}">
												<span class="status-badge status-preparing"> <i
													class="fas fa-utensils me-1"></i>Đang chuẩn bị
												</span>
											</c:when>
											<c:when test="${order.status == 'DANG_GIAO'}">
												<span class="status-badge status-delivering"> <i
													class="fas fa-truck me-1"></i>Đang giao
												</span>
											</c:when>
											<c:when test="${order.status == 'DA_GIAO'}">
												<span class="status-badge status-completed"> <i
													class="fas fa-check-circle me-1"></i>Đã giao
												</span>
											</c:when>
											<c:when test="${order.status == 'DA_HUY'}">
												<span class="status-badge status-cancelled"> <i
													class="fas fa-times-circle me-1"></i>Đã hủy
												</span>
											</c:when>
											<c:otherwise>
												<span class="status-badge status-pending"> <i
													class="fas fa-question-circle me-1"></i>${order.status}
												</span>
											</c:otherwise>
										</c:choose>
									</p>

                                    <!-- Voucher Information moved below notes -->

                                    <!-- Customer Notes -->
                                    <c:if test="${not empty order.note}">
                                        <p>
                                            <strong><i class="fas fa-sticky-note me-2 text-info"></i>Ghi
                                                chú:</strong><br>
                                            <span class="text-muted" style="white-space: pre-line;">${order.note}</span>
                                        </p>
                                        <c:set var="noteText" value="${order.note}" />
                                       
                                        <c:if test="${pStart >= 0}">
                                            <div class="text-muted" style="white-space: pre-line;">
                                                <c:out value="${fn:substring(noteText, pStart, (sStart >= 0 ? sStart : fn:length(noteText)))}" />
                                            </div>
                                        </c:if>
                                        <c:if test="${sStart >= 0}">
                                            <div class="text-muted" style="white-space: pre-line;">
                                                <c:out value="${fn:substring(noteText, sStart, fn:length(noteText))}" />
                                            </div>
                                        </c:if>
                                    </c:if>
								</div>
								<div class="col-md-6">
									<p>
										<strong>Địa chỉ giao hàng:</strong><br>
										${order.customerAddress}
									</p>
									<p>
										<strong><i
											class="fas fa-credit-card me-2 text-primary"
											data-bs-toggle="tooltip" data-bs-placement="top"
											title="Phương thức thanh toán được chọn"></i>Phương thức
											thanh toán:</strong>
										<c:choose>
											<c:when test="${order.paymentMethod == 'TIEN_MAT'}">
												<span class="badge bg-warning text-dark"> <i
													class="fas fa-money-bill-wave me-1"></i>Thanh toán khi nhận
													hàng
												</span>
											</c:when>
											<c:when test="${order.paymentMethod == 'CHUYEN_KHOAN'}">
												<span class="badge bg-info"> <i
													class="fas fa-university me-1"></i>Chuyển khoản ngân hàng
												</span>
											</c:when>
											<c:when test="${order.paymentMethod == 'VI_DIEN_TU'}">
												<span class="badge bg-primary"> <i
													class="fas fa-qrcode me-1"></i>QR Code
												</span>
											</c:when>
											<c:otherwise>
												<span class="badge bg-secondary"> <i
													class="fas fa-question-circle me-1"></i>${order.paymentMethod}
												</span>
											</c:otherwise>
										</c:choose>
									</p>

									<!-- Hiển thị thông tin thanh toán chi tiết cho các phương thức không phải COD -->
									<c:if test="${order.paymentMethod != 'TIEN_MAT'}">
										<div class="alert alert-info mt-3">
											<h6>
												<i class="fas fa-info-circle me-2"></i>Thông tin thanh toán
											</h6>
											<p class="mb-2">
												<strong>Ngân hàng:</strong> Mb Bank
											</p>
											<p class="mb-2">
												<strong>Số tài khoản:</strong> 0966035418
											</p>
											<p class="mb-2">
												<strong>Chủ tài khoản:</strong> FAST FOOD RESTAURANT
											</p>
											<p class="mb-2">
												<strong>Nội dung chuyển khoản:</strong> DH${order.id}
											</p>
											<p class="mb-0">
												<strong>Số tiền:</strong> <span class="text-danger fw-bold">
													<fmt:formatNumber value="${order.totalAmount}"
														pattern="#,###" />đ
												</span>
											</p>

										</div>
									</c:if>
								</div>
							</div>

							<!-- Ordered Products Summary -->
							<div class="mt-3">
								<p class="mb-1">
									<strong>Sản phẩm đã đặt:</strong>
									<c:choose>
										<c:when test="${not empty orderItems}">
											<c:forEach var="item" items="${orderItems}" varStatus="loop">
                                                ${item.productName} <span
													class="text-muted">x${item.quantity}</span>
												<c:if test="${!loop.last}">, </c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<span class="text-muted">Chưa có sản phẩm trong đơn</span>
										</c:otherwise>
									</c:choose>
								</p>
							</div>


						</div>

						<!-- Order Items -->
						<div class="order-card">
							<h5 class="mb-3">
								<i class="fas fa-list me-2 text-primary"></i>Chi tiết sản phẩm
							</h5>
							<!-- Tính tạm tính từ các item -->
							<c:set var="computedSubtotal" value="0" />
							<c:choose>
								<c:when test="${not empty orderItems}">
									<c:forEach var="item" items="${orderItems}">
										<div class="product-item">
											<div class="row align-items-center">
												<div class="col-md-2">
													<c:set var="rawImageUrl" value="${item.product.imageUrl}" />
													<c:choose>
														<c:when test="${empty rawImageUrl}">
															<c:set var="safeImageUrl"
																value="${pageContext.request.contextPath}/images/logofastfood.png" />
														</c:when>
														<c:when
															test="${fn:startsWith(rawImageUrl, 'http://') || fn:startsWith(rawImageUrl, 'https://')}">
															<c:set var="safeImageUrl" value="${rawImageUrl}" />
														</c:when>
														<c:when test="${fn:startsWith(rawImageUrl, '/fastfood/')}">
															<c:set var="safeImageUrl" value="${rawImageUrl}" />
														</c:when>
														<c:otherwise>
															<c:set var="safeImageUrl"
																value="${pageContext.request.contextPath}/${rawImageUrl}" />
														</c:otherwise>
													</c:choose>
													<img src="${safeImageUrl}" alt="${item.product.name}"
														class="img-fluid rounded"
														style="max-height: 80px; object-fit: cover;">
												</div>
												<div class="col-md-4">
													<h6 class="mb-1">${item.product.name}</h6>
													<small class="text-muted">${item.product.description}</small>
												</div>
												<div class="col-md-2 text-center">
													<span class="fw-bold"> <fmt:formatNumber
															value="${item.price}" type="currency" currencySymbol="₫" />
													</span>
												</div>
												<div class="col-md-2 text-center">
													<span class="badge bg-secondary fs-6">x${item.quantity}</span>
												</div>
												<div class="col-md-2 text-end">
													<span class="fw-bold text-primary"> <fmt:formatNumber
															value="${item.price * item.quantity}" type="currency"
															currencySymbol="₫" />
													</span>
												</div>
											</div>
										</div>
										<!-- Cộng dồn tạm tính -->
										<c:set var="computedSubtotal"
											value="${computedSubtotal + (item.price * item.quantity)}" />
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="alert alert-warning">Đơn hàng chưa có sản
										phẩm.</div>
								</c:otherwise>
							</c:choose>

							<div class="border-top pt-3 mt-3">
								<div class="row">
									<div class="col-md-8"></div>
									<div class="col-md-4">
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Tạm tính:</span> <span><fmt:formatNumber
                                                    value="${computedSubtotal}" type="currency"
                                                    currencySymbol="₫" /></span>
                                        </div>
                                        <c:if test="${not empty order.discountAmount && order.discountAmount > 0}">
                                            <div class="d-flex justify-content-between mb-2">
                                                <span>Giảm giá sản phẩm:</span>
                                                <span class="text-success">-<fmt:formatNumber value="${order.discountAmount}" type="currency" currencySymbol="₫"/></span>
                                            </div>
                                        </c:if>
                                        <c:set var="shippingDiscount" value="${empty order.shippingDiscountAmount ? 0 : order.shippingDiscountAmount}" />
                                        <c:set var="finalShippingFee" value="${order.shippingFee - shippingDiscount}" />
                                        <c:if test="${finalShippingFee < 0}"><c:set var="finalShippingFee" value="0" /></c:if>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Phí giao hàng:</span> <span><fmt:formatNumber
                                                    value="${order.shippingFee}" type="currency"
                                                    currencySymbol="₫" /></span>
                                        </div>
                                        <c:if test="${shippingDiscount > 0}">
                                            <div class="d-flex justify-content-between mb-2">
                                                <span>Giảm phí giao hàng:</span>
                                                <span class="text-success">-<fmt:formatNumber value="${shippingDiscount}" type="currency" currencySymbol="₫"/></span>
                                            </div>
                                        </c:if>
                                        <c:set var="discountProduct" value="${empty order.discountAmount ? 0 : order.discountAmount}" />
                                        <hr>
                                        <div class="d-flex justify-content-between fw-bold fs-5">
                                            <span>Tổng cộng:</span> <span class="text-danger"> <fmt:formatNumber
                                                    value="${order.totalAmount}" type="currency"
                                                    currencySymbol="₫" />
                                            </span>
                                        </div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Right Side: Status Update, Timeline & Quick Actions -->
					<div class="col-lg-4">
						<div class="d-flex flex-column h-100">
							<!-- Status Update -->
							<div class="order-card mb-3">
								<h5 class="mb-3">
									<i class="fas fa-cogs me-2 text-primary"></i>Cập nhật trạng
									thái
								</h5>
								<form
									action="${pageContext.request.contextPath}/admin/orders?action=updateStatus"
									method="post">
									<input type="hidden" name="orderId" value="${order.id}">
									<div class="d-grid gap-2">
										<c:if test="${order.status == 'CHO_XAC_NHAN'}">
											<button type="submit" name="status" value="DANG_CHUAN_BI"
												class="btn btn-info btn-status">
												<i class="fas fa-check me-1"></i>Xác nhận đơn hàng
											</button>
											<button type="submit" name="status" value="DA_HUY"
												class="btn btn-danger btn-status">
												<i class="fas fa-times me-1"></i>Hủy đơn hàng
											</button>
										</c:if>

										<c:if test="${order.status == 'DANG_CHUAN_BI'}">
											<button type="submit" name="status" value="DANG_GIAO"
												class="btn btn-primary btn-status">
												<i class="fas fa-truck me-1"></i>Bắt đầu giao hàng
											</button>
											<button type="submit" name="status" value="DA_HUY"
												class="btn btn-danger btn-status">
												<i class="fas fa-times me-1"></i>Hủy đơn hàng
											</button>
										</c:if>

										<c:if test="${order.status == 'DANG_GIAO'}">
											<button type="submit" name="status" value="DA_GIAO"
												class="btn btn-success btn-status">
												<i class="fas fa-check-circle me-1"></i>Hoàn thành đơn hàng
											</button>
										</c:if>
									</div>
								</form>
							</div>

							<!-- Timeline -->
							<div class="order-card flex-fill mb-3">
								<h5 class="mb-3">
									<i class="fas fa-history me-2 text-primary"></i>Lịch sử đơn
									hàng
								</h5>
								<div class="timeline">
									<div class="timeline-item active">
										<div class="fw-bold">Đơn hàng được tạo</div>
										<small class="text-muted"> <fmt:formatDate
												value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm" />
										</small>
									</div>

									<c:if test="${order.status != 'CHO_XAC_NHAN'}">
										<div class="timeline-item active">
											<div class="fw-bold">Đã xác nhận</div>
											<small class="text-muted"> <fmt:formatDate
													value="${order.updatedAt}" pattern="dd/MM/yyyy HH:mm" />
											</small>
										</div>
									</c:if>

									<c:if
										test="${order.status == 'DANG_CHUAN_BI' || order.status == 'DANG_GIAO' || order.status == 'DA_GIAO'}">
										<div class="timeline-item active">
											<div class="fw-bold">Đang chuẩn bị</div>
											<small class="text-muted"> <fmt:formatDate
													value="${order.updatedAt}" pattern="dd/MM/yyyy HH:mm" />
											</small>
										</div>
									</c:if>

									<c:if
										test="${order.status == 'DANG_GIAO' || order.status == 'DA_GIAO'}">
										<div class="timeline-item active">
											<div class="fw-bold">Đang giao hàng</div>
											<small class="text-muted"> <fmt:formatDate
													value="${order.updatedAt}" pattern="dd/MM/yyyy HH:mm" />
											</small>
										</div>
									</c:if>

									<c:if test="${order.status == 'DA_GIAO'}">
										<div class="timeline-item active">
											<div class="fw-bold">Hoàn thành</div>
											<small class="text-muted"> <fmt:formatDate
													value="${order.updatedAt}" pattern="dd/MM/yyyy HH:mm" />
											</small>
										</div>
									</c:if>

									<c:if test="${order.status == 'DA_HUY'}">
										<div class="timeline-item" style="color: #dc3545;">
											<div class="fw-bold">Đã hủy</div>
											<small class="text-muted"> <fmt:formatDate
													value="${order.updatedAt}" pattern="dd/MM/yyyy HH:mm" />
											</small>
										</div>
									</c:if>
								</div>
							</div>

							<!-- Card ghi chú riêng biệt đã được xóa -->

							<!-- Quick Actions -->
							<div class="order-card">
								<h5 class="mb-3">
									<i class="fas fa-tools me-2 text-primary"></i>Thao tác nhanh
								</h5>
								<div class="d-grid gap-2">
                                    <a
                                        href="${pageContext.request.contextPath}/admin/orders?action=invoice&id=${order.id}"
                                        class="btn btn-outline-primary" target="_blank"> <i
                                        class="fas fa-print me-1"></i>In hóa đơn
                                    </a> <a href="${pageContext.request.contextPath}/admin/orders"
										class="btn btn-outline-secondary"> <i
										class="fas fa-arrow-left me-1"></i>Quay lại danh sách
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        // Display current date + initialize tooltips
        document.addEventListener('DOMContentLoaded', function() {
            const el = document.getElementById('currentDate');
            if (el) {
                const currentDate = new Date();
                const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
                el.textContent = currentDate.toLocaleDateString('vi-VN', options);
            }
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
        });

        // Confirm status change
        document.querySelectorAll('button[name="status"]').forEach(button => {
            button.addEventListener('click', function(e) {
                const status = this.value;
                let message = '';
                
                switch(status) {
                    case 'DANG_CHUAN_BI':
                        message = 'Bạn có chắc chắn muốn xác nhận đơn hàng này?';
                        break;
                    case 'DANG_GIAO':
                        message = 'Bạn có chắc chắn muốn bắt đầu giao hàng?';
                        break;
                    case 'DA_GIAO':
                        message = 'Bạn có chắc chắn đơn hàng đã được hoàn thành?';
                        break;
                    case 'DA_HUY':
                        message = 'Bạn có chắc chắn muốn hủy đơn hàng này?';
                        break;
                }
                
                if (!confirm(message)) {
                    e.preventDefault();
                }
            });
        });

        // Toggle sidebar mobile (hamburger)
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
