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
<title>Đơn hàng của tôi - Fast Food</title>
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

.orders-container {
	background: white;
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	padding: 2rem;
	margin-bottom: 2rem;
}

.order-card {
	border: 1px solid #dee2e6;
	border-radius: 10px;
	padding: 1.5rem;
	margin-bottom: 1.5rem;
	transition: all 0.3s ease;
}

.order-card:hover {
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	transform: translateY(-2px);
}

.order-header {
	background: linear-gradient(135deg, #ff6b35 100%);
	color: white;
	border-radius: 15px;
	padding: 2rem;
	text-align: center;
	margin-bottom: 2rem;
}

.status-badge {
	font-size: 0.875rem;
	padding: 0.5rem 1rem;
	border-radius: 20px;
}

.status-pending {
	background-color: #fff3cd;
	color: #856404;
}

.status-confirmed {
	background-color: #d1ecf1;
	color: #0c5460;
}

.status-preparing {
	background-color: #f8d7da;
	color: #721c24;
}

.status-delivering {
	background-color: #d4edda;
	color: #155724;
}

.status-completed {
    background-color: #d1ecf1;
    color: #0c5460;
}

.notif-badge{position:absolute;top:0;right:0;transform:translate(50%,-50%);background:#dc3545;color:#fff;border-radius:999px;font-size:.65rem;line-height:1;padding:2px 6px;min-width:18px;text-align:center}
.dropdown-menu.notifications{min-width:340px;border-radius:12px;box-shadow:0 6px 20px rgba(0,0,0,.15)}
.notifications .notif-header{padding:.5rem 1rem;font-weight:600}
.notifications .notif-item{display:flex;align-items:flex-start;gap:.5rem;padding:.5rem 1rem}
.notifications .notif-item i{color:#ff6b35}
.notifications .notif-empty{padding:.75rem 1rem;color:#6c757d}
.notifications .notif-item + .notif-item{border-top:1px solid #eee}
.notifications .notif-thumb{width:28px;height:28px;border-radius:6px;object-fit:cover;border:1px solid #eee}

.status-cancelled {
	background-color: #f8d7da;
	color: #721c24;
}

.order-item {
	border-bottom: 1px solid #eee;
	padding: 0.75rem 0;
}

.order-item:last-child {
	border-bottom: none;
}

.btn-detail {
	background: linear-gradient(135deg, #ff6b35 100%);
	border: none;
	border-radius: 20px;
	padding: 8px 20px;
	color: white;
	font-size: 0.875rem;
}

.btn-detail:hover {
	background: linear-gradient(135deg, #e55a2b 100%);
	color: white;
}

.empty-orders {
	text-align: center;
	padding: 3rem;
	color: #6c757d;
}


/* Enhanced Navbar Styles */
.navbar {
	position: fixed !important;
	top: 0;
	left: 0;
	right: 0;
	z-index: 1030;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15) !important;
	padding: 1rem 0 !important;
	transition: all 0.3s ease !important;
	min-height: 76px !important;
}

/* Body padding to prevent content being hidden behind fixed header */
body {
	padding-top: 76px;
}

.navbar-brand {
    font-weight: 800 !important;
    font-size: 1.9rem !important;
    color: #fff !important;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3) !important;
    transition: all 0.3s ease !important;
}

.navbar-brand:hover {
	color: white !important;
	transform: scale(1.05) !important;
}

.navbar-nav .nav-link {
	font-weight: 500 !important;
	transition: all 0.3s ease !important;
	padding: 0.5rem 1rem !important;
	border-radius: 8px !important;
	margin: 0 0.2rem !important;
}

.navbar-nav .nav-link:hover {
	background-color: rgba(255, 255, 255, 0.1) !important;
	transform: translateY(-2px) !important;
}

.navbar-nav .nav-link:active {
	background-color: rgba(255, 255, 255, 0.2) !important;
}
.btn-outline-light {
    border-radius: 25px !important;
    padding: 8px 20px !important;
    font-weight: 500 !important;
    transition: all 0.3s ease !important;
    border: none !important;
    box-shadow: none !important;
}
.btn-outline-light:hover {
    background-color: rgba(255, 255, 255, 0.2) !important;
    border-color: transparent !important;
    transform: translateY(-2px) !important;
    box-shadow: none !important;
}

.user-avatar-btn {
    border-radius: 25px !important;
    padding: 8px 16px !important;
    box-shadow: none !important;
    transition: all 0.3s ease !important;
    border: none !important;
    background-color: transparent !important;
}
.user-avatar-btn:hover {
    transform: translateY(-1px) !important;
    box-shadow: none !important;
    border-color: transparent !important;
}
.user-avatar-btn:active {
    transform: translateY(0) !important;
    box-shadow: none !important;
}

.avatar-image {
	border: 2px solid white !important;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1) !important;
}

.avatar-icon {
	color: white !important;
	filter: drop-shadow(0 0 2px white)
		drop-shadow(0 0 4px rgba(0, 123, 255, 0.8)) !important;
}
.btn-primary:hover {
	background: linear-gradient(135deg, #e55a2b 100%);
}

@media ( max-width : 991px) {
    .navbar-brand video { display: none !important; }
    .navbar .container { display:flex !important; align-items:center !important; justify-content:space-between !important; flex-wrap:wrap !important; }
    .navbar-collapse { flex-basis:100% !important; width:100% !important; margin-top:.5rem !important; }
    .mobile-actions { margin-left:auto !important; gap:.25rem !important; align-items:center !important; flex-wrap:nowrap !important; }
    .mobile-actions .btn { padding:6px 8px !important; line-height:1 !important; }
    .mobile-actions .notif-badge { top:-4px !important; right:-6px !important; transform:none !important; }
    .dropdown-menu.notifications { min-width: 280px !important; border-radius: 12px !important; margin-top: 8px !important; }
}
</style>
</head>
<body>
	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark"
		style="background-color: #ff6b35;">
		<div class="container">
            <a class="navbar-brand fw-bold"
                href="${pageContext.request.contextPath}/home"> <video
                    src="${pageContext.request.contextPath}/images/logofastfood.mp4"
                    alt="Fast Food Logo" style="height: 30px; margin-right: 10px;"
                    autoplay muted loop></video> Fast Food
            </a>
            <div class="mobile-actions d-flex align-items-center ms-auto d-lg-none">
                <c:set var="cartCount" value="${sessionScope.cartItems != null ? fn:length(sessionScope.cartItems) : 0}" />
                <a href="${pageContext.request.contextPath}/cart/view" class="btn btn-outline-light me-2 notif-btn">
                    <i class="fas fa-shopping-cart"></i>
                    <c:if test="${cartCount > 0}"><span class="notif-badge" data-total="${cartCount}">${cartCount}</span></c:if>
                </a>
                <div class="dropdown me-2">
                    <c:set var="notifCount" value="${sessionScope.activityHistory != null ? fn:length(sessionScope.activityHistory) : 0}" />
                    <button class="btn btn-outline-light notif-btn" type="button" id="notifDropdownMobile" data-bs-toggle="dropdown" data-bs-display="static">
                        <i class="fas fa-bell"></i>
                        <c:if test="${notifCount > 0}"><span class="notif-badge" data-total="${notifCount}">${notifCount}</span></c:if>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end notifications" aria-labelledby="notifDropdownMobile">
                        <li class="notif-header">Hoạt động gần đây</li>
                        <c:choose>
                            <c:when test="${not empty sessionScope.activityHistory}">
                                <c:forEach var="a" items="${sessionScope.activityHistory}" begin="0" end="9">
                                    <li class="notif-item" data-json="${fn:escapeXml(a)}"><i class="fas fa-check-circle mt-1"></i><span class="small">${a}</span></li>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <li class="notif-empty small">Chưa có hoạt động nào</li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
                <button class="navbar-toggler ms-1" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>
			<div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                    <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>
                    <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/promotions">Khuyến mãi</a></li>
                    <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                </ul>
                <div class="d-none d-lg-flex align-items-center ms-auto">
                    <c:set var="cartCount" value="${sessionScope.cartItems != null ? fn:length(sessionScope.cartItems) : 0}" />
                    <a href="${pageContext.request.contextPath}/cart/view"
                        class="btn btn-outline-light me-3 notif-btn">
                        <i class="fas fa-shopping-cart"></i>
                        <c:if test="${cartCount > 0}"><span class="notif-badge" data-total="${cartCount}">${cartCount}</span></c:if>
                    </a>
                    <div class="dropdown ms-2">
                        <c:set var="notifCount" value="${sessionScope.activityHistory != null ? fn:length(sessionScope.activityHistory) : 0}" />
                        <button class="btn btn-outline-light notif-btn" type="button" id="notifDropdown" data-bs-toggle="dropdown">
                            <i class="fas fa-bell"></i>
                            <c:if test="${notifCount > 0}"><span class="notif-badge" data-total="${notifCount}">${notifCount}</span></c:if>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end notifications" aria-labelledby="notifDropdown">
                            <li class="notif-header">Hoạt động gần đây</li>
                            <c:choose>
                                <c:when test="${not empty sessionScope.activityHistory}">
                                    <c:forEach var="a" items="${sessionScope.activityHistory}" begin="0" end="9">
                                        <li class="notif-item" data-json="${fn:escapeXml(a)}"><i class="fas fa-check-circle mt-1"></i><span class="small">${a}</span></li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <li class="notif-empty small">Chưa có hoạt động nào</li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <a href="${pageContext.request.contextPath}/login"
                                class="btn btn-outline-light ms-2"> <i class="fas fa-user"></i>
                                Đăng nhập
                            </a>
                        </c:when>
                        <c:otherwise>
                            <div class="dropdown ms-2">
                                <button
                                    class="btn btn-primary dropdown-toggle d-flex align-items-center user-avatar-btn"
                                    type="button" id="userDropdown" data-bs-toggle="dropdown">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user.avatar}">
                                            <img
                                                src="${pageContext.request.contextPath}/${sessionScope.user.avatar}"
                                                alt="Avatar" class="rounded-circle me-2 avatar-image"
                                                style="width: 32px; height: 32px; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-user-circle me-2 avatar-icon" style="font-size: 24px;"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <span style="font-weight: 500;">${sessionScope.user.fullName}</span>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item"
                                        href="${pageContext.request.contextPath}/user/profile"> <i
                                            class="fas fa-user me-2"></i>Thông tin cá nhân
                                    </a></li>
                                    <li><a class="dropdown-item active"
                                        href="${pageContext.request.contextPath}/user/orders"> <i
                                            class="fas fa-shopping-bag me-2"></i>Đơn hàng của tôi
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item"
                                        href="${pageContext.request.contextPath}/logout"> <i
                                            class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                                    </a></li>
                                </ul>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="d-lg-none mt-2">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light w-100">
                                <i class="fas fa-user"></i> Đăng nhập
                            </a>
                        </c:when>
                        <c:otherwise>
                            <div class="dropdown w-100">
                                <button class="btn btn-primary dropdown-toggle d-flex align-items-center user-avatar-btn w-100" type="button" id="userDropdownMobileCollapse" data-bs-toggle="dropdown">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user.avatar}">
                                            <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" alt="Avatar" class="rounded-circle me-2 avatar-image" style="width: 24px; height: 24px; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-user-circle me-2 avatar-icon" style="font-size: 20px;"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <span style="font-weight: 500;">${sessionScope.user.fullName}</span>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile"><i class="fas fa-user me-2"></i>Thông tin cá nhân</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/orders"><i class="fas fa-shopping-bag me-2"></i>Đơn hàng của tôi</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                                </ul>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
			</div>
		</div>
    </nav>
    <script>
    document.addEventListener('DOMContentLoaded',function(){
        function setupNotif(id){
            var btn=document.getElementById(id);
            if(!btn) return;
            var badge=btn.querySelector('.notif-badge');
            var total=badge?parseInt(badge.getAttribute('data-total')||'0',10):0;
            try{
                var seen=parseInt(localStorage.getItem('notifSeenCount')||'0',10);
                var unread=Math.max(total - seen, 0);
                if(badge){ if(unread>0){ badge.textContent=String(unread); badge.style.display='inline-block'; } else { badge.style.display='none'; } }
            }catch(e){}
            btn.addEventListener('click',function(){ if(badge){ badge.style.display='none'; }
                try{ localStorage.setItem('notifSeenCount', String(total)); }catch(e){}
            });
        }
        setupNotif('notifDropdown');
        setupNotif('notifDropdownMobile');

        var ctx = '${pageContext.request.contextPath}';
        document.querySelectorAll('.notifications .notif-item').forEach(function(li){
            var raw = li.getAttribute('data-json') || '';
            if(raw && raw.trim().charAt(0)==='{'){
                try{
                    var j = JSON.parse(raw);
                    if(j.type === 'ADD_TO_CART'){
                        var src = j.imageUrl || '';
                        if(src && /^https?:/i.test(src)){
                        } else if(src && src.startsWith('/')){
                        } else if(src){ src = ctx + '/' + src.replace(/^\/+/, ''); }
                        var imgHtml = src ? '<img class="notif-thumb" src="'+src+'" alt="'+(j.name||'')+'">' : '<i class="fas fa-check-circle mt-1"></i>';
                        var textHtml = '<span class="small">Thêm vào giỏ: '+(j.name||'')+' x'+(j.qty||1)+' lúc '+(j.time||'')+'</span>';
                        li.innerHTML = imgHtml + textHtml;
                    }
                }catch(e){}
            }
        });
    });
    </script>

	<div class="container mt-4">
		<div class="row">
			<div class="col-md-10 mx-auto">
				<!-- Orders Header -->
				<div class="order-header">
					<h3 class="mb-1">
						<i class="fas fa-shopping-bag me-2"></i>Đơn hàng của tôi
					</h3>
					<p class="mb-0 opacity-75">Theo dõi và quản lý các đơn hàng của
						bạn</p>
				</div>

				<!-- Filter Options -->
				<div class="orders-container">
					<div class="row mb-4">
						<div class="col-md-6">
							<h5 class="mb-0">
								<i class="fas fa-list me-2 text-primary"></i>Danh sách đơn hàng
							</h5>
						</div>
						<div class="col-md-6 text-end">
							<select class="form-select d-inline-block w-auto"
								id="statusFilter">
								<option value="">Tất cả trạng thái</option>
								<option value="CHO_XAC_NHAN">Chờ xác nhận</option>
								<option value="DANG_CHUAN_BI">Đang chuẩn bị</option>
								<option value="DANG_GIAO">Đang giao hàng</option>
								<option value="DA_GIAO">Hoàn thành</option>
								<option value="DA_HUY">Đã hủy</option>
							</select>
						</div>
					</div>

					<!-- Orders List -->
					<c:choose>
						<c:when test="${not empty orders}">
							<c:forEach var="order" items="${orders}">
								<div class="order-card" data-status="${order.status}">
									<div class="row align-items-center">
										<div class="col-md-3">
											<h6 class="mb-1">
												<i class="fas fa-receipt me-2"></i>Đơn hàng #${order.id}
											</h6>
											<small class="text-muted"> <fmt:formatDate
													value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
											</small>
										</div>
										<div class="col-md-2">
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
														class="fas fa-truck me-1"></i>Đang giao hàng
													</span>
												</c:when>
												<c:when test="${order.status == 'DA_GIAO'}">
													<span class="status-badge status-completed"> <i
														class="fas fa-check-circle me-1"></i>Hoàn thành
													</span>
												</c:when>
												<c:when test="${order.status == 'DA_HUY'}">
													<span class="status-badge status-cancelled"> <i
														class="fas fa-times me-1"></i>Đã hủy
													</span>
												</c:when>
											</c:choose>
										</div>
										<div class="col-md-2">
											<strong class="text-success"> <fmt:formatNumber
													value="${order.totalAmount}" type="currency"
													currencySymbol="₫" />
											</strong>
										</div>
										<div class="col-md-3">
											<small class="text-muted"> <i
												class="fas fa-map-marker-alt me-1"></i>
												${order.customerAddress}
											</small>
										</div>
										<div class="col-md-2 text-end">
											<button class="btn btn-detail btn-sm"
												onclick="toggleOrderDetails(${order.id})">
												<i class="fas fa-eye me-1"></i>Chi tiết
											</button>
										</div>
									</div>

									<!-- Order Details (Hidden by default) -->
									<div id="orderDetails${order.id}" class="order-details mt-3"
										style="display: none;">
										<hr>
										<div class="row">
											<div class="col-md-6">
												<h6>
													<i class="fas fa-user me-2"></i>Thông tin khách hàng
												</h6>
												<p class="mb-1">
													<strong>Tên:</strong> ${order.customerName}
												</p>
												<p class="mb-1">
													<strong>Điện thoại:</strong> ${order.customerPhone}
												</p>
												<p class="mb-1">
													<strong>Địa chỉ:</strong> ${order.customerAddress}
												</p>
												<c:if test="${not empty order.notes}">
													<p class="mb-1">
														<strong>Ghi chú:</strong> ${order.notes}
													</p>
												</c:if>
											</div>
											<div class="col-md-6">
												<h6>
													<i class="fas fa-credit-card me-2"></i>Thông tin thanh toán
												</h6>
												<p class="mb-1">
													<strong>Phương thức:</strong>
													<c:choose>
														<c:when test="${order.paymentMethod == 'TIEN_MAT'}">
															<span class="badge bg-success">Thanh toán khi nhận
																hàng</span>
														</c:when>
														<c:when test="${order.paymentMethod == 'CHUYEN_KHOAN'}">
															<span class="badge bg-info">Chuyển khoản ngân hàng</span>
														</c:when>
														<c:when test="${order.paymentMethod == 'VI_DIEN_TU'}">
															<span class="badge bg-primary">QR Code</span>
														</c:when>
														<c:otherwise>
															<span class="badge bg-secondary">${order.paymentMethod}</span>
														</c:otherwise>
													</c:choose>
												</p>
												<p class="mb-1">
													<strong>Trạng thái thanh toán:</strong>
													<c:choose>
														<c:when test="${order.paymentStatus == 'PAID'}">
															<span class="badge bg-success">Đã thanh toán</span>
														</c:when>
														<c:otherwise>
															<span class="badge bg-warning">Chưa thanh toán</span>
														</c:otherwise>
													</c:choose>
												</p>
											</div>
										</div>

										<h6 class="mt-3">
											<i class="fas fa-shopping-cart me-2"></i>Sản phẩm đã đặt
										</h6>
										<c:forEach var="item" items="${order.orderItems}">
											<div class="order-item">
												<div class="row align-items-center">
													<div class="col-md-6">
														<strong>${item.product.name}</strong>
													</div>
													<div class="col-md-2 text-center">
														<span class="badge bg-secondary">x${item.quantity}</span>
													</div>
													<div class="col-md-2 text-center">
														<fmt:formatNumber value="${item.price}" type="currency"
															currencySymbol="₫" />
													</div>
													<div class="col-md-2 text-end">
														<strong class="text-success"> <fmt:formatNumber
																value="${item.subtotal}" type="currency"
																currencySymbol="₫" />
														</strong>
													</div>
												</div>
											</div>
										</c:forEach>

										<div class="text-end mt-3">
											<div class="row">
												<div class="col-md-8"></div>
												<div class="col-md-4">
													<c:if
														test="${not empty order.shippingFee and order.shippingFee > 0}">
														<div class="d-flex justify-content-between mb-1">
															<span>Phí vận chuyển:</span> <span><fmt:formatNumber
																	value="${order.shippingFee}" type="currency"
																	currencySymbol="₫" /></span>
														</div>
													</c:if>
													<c:if
														test="${not empty order.discountAmount and order.discountAmount > 0}">
														<div
															class="d-flex justify-content-between mb-1 text-success">
															<span>Giảm giá:</span> <span>-<fmt:formatNumber
																	value="${order.discountAmount}" type="currency"
																	currencySymbol="₫" /></span>
														</div>
													</c:if>
													<hr>
													<div class="d-flex justify-content-between">
														<strong>Tổng cộng:</strong> <strong class="text-success">
															<fmt:formatNumber value="${order.totalAmount}"
																type="currency" currencySymbol="₫" />
														</strong>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="empty-orders">
								<i class="fas fa-shopping-bag fa-4x mb-3"></i>
								<h5>Bạn chưa có đơn hàng nào</h5>
								<p class="text-muted">Hãy đặt hàng ngay để thưởng thức những
									món ăn ngon!</p>
								<a href="${pageContext.request.contextPath}/products"
									class="btn btn-primary"> <i
									class="fas fa-shopping-cart me-2"></i>Đặt hàng ngay
								</a>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        // Toggle order details
        function toggleOrderDetails(orderId) {
            const details = document.getElementById('orderDetails' + orderId);
            if (details.style.display === 'none') {
                details.style.display = 'block';
            } else {
                details.style.display = 'none';
            }
        }

        // Filter orders by status
        document.getElementById('statusFilter').addEventListener('change', function() {
            const selectedStatus = this.value;
            const orderCards = document.querySelectorAll('.order-card');
            
            orderCards.forEach(card => {
                if (selectedStatus === '' || card.dataset.status === selectedStatus) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    </script>
    <jsp:include page="/WEB-INF/views/includes/chat-widget.jsp" />
</body>
</html>
