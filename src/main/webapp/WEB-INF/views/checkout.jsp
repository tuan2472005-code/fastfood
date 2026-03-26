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
<title>Thanh toán - Fast Food</title>
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

.checkout-container {
	background: white;
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	padding: 2rem;
	margin-bottom: 2rem;
}

.order-summary {
	background: #f8f9fa;
	border-radius: 10px;
	padding: 1.5rem;
}

.product-item {
	border-bottom: 1px solid #dee2e6;
	padding: 1rem 0;
}

.product-item:last-child {
	border-bottom: none;
}

.btn-checkout {
	background: linear-gradient(135deg, #28a745, #20c997);
	border: none;
	border-radius: 10px;
	padding: 15px;
	font-weight: 600;
	font-size: 1.1rem;
}

.btn-checkout:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
}

.form-control, .form-select {
	border-radius: 10px;
	border: 2px solid #e9ecef;
	padding: 12px 15px;
}

.form-control:focus, .form-select:focus {
    border-color: #28a745;
    box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
}

.notif-badge{position:absolute;top:0;right:0;transform:translate(50%,-50%);background:#dc3545;color:#fff;border-radius:999px;font-size:.65rem;line-height:1;padding:2px 6px;min-width:18px;text-align:center}
.dropdown-menu.notifications{min-width:340px;border-radius:12px;box-shadow:0 6px 20px rgba(0,0,0,.15)}
.notifications .notif-header{padding:.5rem 1rem;font-weight:600}
.notifications .notif-item{display:flex;align-items:flex-start;gap:.5rem;padding:.5rem 1rem}
.notifications .notif-item i{color:#ff6b35}
.notifications .notif-empty{padding:.75rem 1rem;color:#6c757d}
.notifications .notif-item + .notif-item{border-top:1px solid #eee}
.notifications .notif-thumb{width:28px;height:28px;border-radius:6px;object-fit:cover;border:1px solid #eee}

.payment-method {
	border: 2px solid #e9ecef;
	border-radius: 10px;
	padding: 1rem;
	margin-bottom: 1rem;
	cursor: pointer;
	transition: all 0.3s ease;
	position: relative;
	background: white;
}

.payment-method:hover {
	border-color: #28a745;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(40, 167, 69, 0.15);
}

.payment-method.selected {
	border-color: #28a745;
	background: linear-gradient(135deg, #f8fff9, #e8f5e8);
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(40, 167, 69, 0.25);
}

.payment-method.selected::before {
	content: '✓';
	position: absolute;
	top: 10px;
	right: 15px;
	background: #28a745;
	color: white;
	border-radius: 50%;
	width: 24px;
	height: 24px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 14px;
	font-weight: bold;
}

.qr-code {
	text-align: center;
	padding: 2rem;
	background: #f8f9fa;
	border-radius: 10px;
	margin-top: 1rem;
}

.btn-primary {
	background-color: #ff6b35;
	border-color: #ff6b35;
}

.btn-primary:hover {
	background-color: #e55a2b;
	border-color: #e55a2b;
}

/* Avatar Icon Styles */
.avatar-icon {
	color: white !important;
	filter: drop-shadow(0 0 2px white)
		drop-shadow(0 0 4px rgba(0, 123, 255, 0.8)) !important;
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
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3) !important;
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

/* User Avatar Button Styles */
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

/* Responsive adjustments */
@media ( max-width : 991px) {
    .navbar-brand {
        font-size: 1.6rem !important;
        font-weight: 800 !important;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.3) !important;
    }
    .navbar-brand video { display: none !important; }
    
    .btn-outline-light {
        padding: 6px 16px !important;
        font-size: 0.9rem !important;
    }
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
	<nav class="navbar navbar-expand-lg navbar-dark"
		style="background-color: #ff6b35;">
		<div class="container">
			<a class="navbar-brand"
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
                                            <i class="fas fa-user-circle me-2 avatar-icon"
                                                style="font-size: 24px;"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <span style="font-weight: 500;">${sessionScope.user.fullName}</span>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item"
                                        href="${pageContext.request.contextPath}/user/profile"> <i
                                            class="fas fa-user me-2"></i>Thông tin cá nhân
                                    </a></li>
                                    <li><a class="dropdown-item"
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
			<div class="col-md-8">
				<div class="checkout-container">
					<h3 class="mb-4">
						<i class="fas fa-credit-card me-2 text-primary"></i>Thông tin
						thanh toán
					</h3>

					<c:if test="${not empty error}">
						<div class="alert alert-danger">
							<i class="fas fa-exclamation-circle me-2"></i>${error}
						</div>
					</c:if>

					<form method="post"
						action="${pageContext.request.contextPath}/checkout">
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="customerName" class="form-label">Họ và tên <span
									class="text-danger">*</span></label> <input type="text"
									class="form-control" id="customerName" name="customerName"
									value="${sessionScope.user.fullName}" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="customerPhone" class="form-label">Số điện
									thoại <span class="text-danger">*</span>
								</label> <input type="tel" class="form-control" id="customerPhone"
									name="customerPhone" value="${sessionScope.user.phone}"
									required>
							</div>
						</div>

						<div class="mb-3">
							<label for="customerAddress" class="form-label">Địa chỉ
								giao hàng <span class="text-danger">*</span>
							</label>
							<textarea class="form-control" id="customerAddress"
								name="customerAddress" rows="3" required>${sessionScope.user.address}</textarea>
						</div>

						<div class="mb-4">
							<label for="notes" class="form-label">Ghi chú</label>
							<textarea class="form-control" id="notes" name="notes" rows="2"
								placeholder="Ghi chú thêm cho đơn hàng (tùy chọn)"></textarea>
						</div>

						<h5 class="mb-3">Phương thức thanh toán</h5>
						<div class="payment-method" onclick="selectPayment('COD', this)">
							<input type="radio" name="paymentMethod" value="COD" id="cod"
								checked> <label for="cod" class="ms-2"> <i
								class="fas fa-money-bill-wave me-2 text-success"></i> <strong>Thanh
									toán khi nhận hàng (COD)</strong> <br> <small class="text-muted">Thanh
									toán bằng tiền mặt khi nhận hàng</small>
							</label>
						</div>

						<div class="payment-method"
							onclick="selectPayment('BANK_TRANSFER', this)">
							<input type="radio" name="paymentMethod" value="BANK_TRANSFER"
								id="bank"> <label for="bank" class="ms-2"> <i
								class="fas fa-university me-2 text-primary"></i> <strong>Chuyển
									khoản ngân hàng</strong> <br> <small class="text-muted">Chuyển
									khoản qua ngân hàng</small>
							</label>
						</div>

						<div class="payment-method"
							onclick="selectPayment('QR_CODE', this)">
							<input type="radio" name="paymentMethod" value="QR_CODE" id="qr">
							<label for="qr" class="ms-2"> <i
								class="fas fa-qrcode me-2 text-info"></i> <strong>Thanh
									toán QR Code</strong> <br> <small class="text-muted">Quét
									mã QR để thanh toán</small>
							</label>
						</div>

						<!-- QR Code Section -->
						<div id="qrCodeSection" class="qr-code" style="display: none;">
							<h6 class="mb-3">Quét mã QR để thanh toán</h6>
							<div class="d-flex justify-content-center mb-3">
								<div id="qrCodeImage"
									style="width: 200px; height: 200px; background: white; border: 2px solid #ddd; border-radius: 10px; padding: 10px; display: flex; justify-content: center; align-items: center;">
									<img src="${pageContext.request.contextPath}/images/qr.png"
										alt="QR Code thanh toán"
										style="max-width: 100%; max-height: 100%; object-fit: contain;">
								</div>
							</div>
							<div class="bank-info bg-light p-3 rounded">
								<h6 class="text-center mb-3">Thông tin chuyển khoản</h6>
								<div class="row">
									<div class="col-6">
										<strong>Ngân hàng:</strong><br> <span>MB Bank</span>
									</div>
									<div class="col-6">
										<strong>Số tài khoản:</strong><br> <span>tuanne247</span>
									</div>
								</div>
								<div class="row mt-2">
									<div class="col-6">
										<strong>Chủ tài khoản:</strong><br> <span>NGUYEN
											MINH TUAN</span>
									</div>
									<div class="col-6">
                                    <strong>Số tiền:</strong><br> <span class="text-danger bank-transfer-amount" id="bankTransferAmount"><fmt:formatNumber
                                                value="${totalAmount}" type="currency" currencySymbol="₫" /></span>
									</div>
								</div>
								<div class="mt-2">
									<strong>Nội dung:</strong><br> <span id="transferContent">Thanh
										toán đơn hàng</span>
								</div>
							</div>
							<div class="alert alert-warning mt-3">
								<i class="fas fa-exclamation-triangle me-2"></i> <strong>Lưu
									ý:</strong> Sau khi chuyển khoản, đơn hàng sẽ được xác nhận bởi admin.
								Bạn sẽ nhận được thông báo khi đơn hàng được duyệt.
							</div>
						</div>

						<!-- Bank Transfer Section -->
						<div id="bankTransferSection" class="qr-code"
							style="display: none;">
							<h6 class="mb-3">Thông tin chuyển khoản ngân hàng</h6>
							<div class="bank-info bg-light p-3 rounded">
								<div class="row">
									<div class="col-6">
										<strong>Ngân hàng:</strong><br> <span>MB Bank</span>
									</div>
									<div class="col-6">
										<strong>Số tài khoản:</strong><br> <span>tuanne247</span>
									</div>
								</div>
								<div class="row mt-2">
									<div class="col-6">
										<strong>Chủ tài khoản:</strong><br> <span>NGUYEN
											MINH TUAN</span>
									</div>
									<div class="col-6">
                                        <strong>Số tiền:</strong><br> <span class="text-danger bank-transfer-amount" id="bankTransferAmountBank"><fmt:formatNumber
                                                value="${totalAmount}" type="currency" currencySymbol="₫" /></span>
									</div>
								</div>
								<div class="mt-2">
									<strong>Nội dung chuyển khoản:</strong><br> <span
										id="bankTransferContent">Thanh toán đơn hàng</span>
								</div>
							</div>
							<div class="alert alert-warning mt-3">
								<i class="fas fa-exclamation-triangle me-2"></i> <strong>Lưu
									ý:</strong> Sau khi chuyển khoản, đơn hàng sẽ được xác nhận bởi admin.
								Bạn sẽ nhận được thông báo khi đơn hàng được duyệt.
							</div>
						</div>

						<div class="mt-4">
							<button type="button"
								class="btn btn-success btn-checkout w-100 mb-2"
								onclick="submitCheckoutForm()">
								<i class="fas fa-check-circle me-2"></i>Đặt hàng
							</button>
						</div>

						<!-- Hidden inputs for voucher codes -->
						<input type="hidden" id="appliedVoucherCode" name="voucherCode"
							value=""> <input type="hidden"
							id="appliedShippingVoucherCode" name="shippingVoucherCode"
							value="">

					</form>
				</div>
			</div>

			<div class="col-md-4">
				<div class="checkout-container">
					<h5 class="mb-3">
						<i class="fas fa-receipt me-2 text-primary"></i>Đơn hàng của bạn
					</h5>

					<div class="order-summary">
						<c:forEach var="item" items="${cart}">
							<div class="product-item">
								<div class="d-flex justify-content-between align-items-center">
									<div>
										<h6 class="mb-1">${item.value.product.name}</h6>
										<small class="text-muted">Số lượng:
											${item.value.quantity}</small>
									</div>
									<div class="text-end">
										<strong><fmt:formatNumber
												value="${item.value.subtotal}" type="currency"
												currencySymbol="₫" /></strong>
									</div>
								</div>
							</div>
						</c:forEach>

						<hr>

						<!-- Product Voucher Section -->
						<div class="voucher-section mb-3">
							<label class="form-label text-muted small"> <i
								class="fas fa-tag me-1"></i>Voucher sản phẩm
							</label>
							<div class="input-group">
                                <input type="text" class="form-control" id="voucherCode"
                                    name="voucherCode" placeholder="Nhập mã voucher sản phẩm" value="${param.voucherCode}"
                                    style="border-radius: 8px 0 0 8px;">
								<button type="button" class="btn btn-outline-primary"
									id="applyVoucherBtn" style="border-radius: 0 8px 8px 0;"
									onclick="applyVoucher()">
									<i class="fas fa-tag me-1"></i>Áp dụng
								</button>
							</div>
							<div id="voucherMessage" class="mt-2" style="display: none;"></div>
						</div>

						<!-- Shipping Voucher Section -->
						<div class="voucher-section mb-3">
							<label class="form-label text-muted small"> <i
								class="fas fa-shipping-fast me-1"></i>Voucher vận chuyển
							</label>
							<div class="input-group">
								<input type="text" class="form-control" id="shippingVoucherCode"
									name="shippingVoucherCode"
									placeholder="Nhập mã voucher vận chuyển"
									style="border-radius: 8px 0 0 8px;">
								<button type="button" class="btn btn-outline-success"
									id="applyShippingVoucherBtn"
									style="border-radius: 0 8px 8px 0;"
									onclick="applyShippingVoucher()">
									<i class="fas fa-shipping-fast me-1"></i>Áp dụng
								</button>
							</div>
							<div id="shippingVoucherMessage" class="mt-2"
								style="display: none;"></div>
						</div>

						<!-- Order Total -->
						<div id="orderTotal">
							<div
								class="d-flex justify-content-between align-items-center mb-2">
								<span>Tạm tính:</span> <span id="subtotal"> <fmt:formatNumber
										value="${subtotal}" type="currency" currencySymbol="₫" />
								</span>
							</div>
							<div
								class="d-flex justify-content-between align-items-center mb-2">
								<span>Phí vận chuyển:</span> <span id="shippingFee"> <fmt:formatNumber
										value="${shippingFee}" type="currency" currencySymbol="₫" />
								</span>
							</div>
							<!-- Product Discount Row -->
							<div id="productDiscountRow"
								class="d-flex justify-content-between align-items-center mb-2 text-info"
								style="display: none;">
								<span><i class="fas fa-tag me-1"></i>Giảm giá sản phẩm:</span> <span
									id="productDiscountAmount">-0₫</span>
							</div>
							<!-- Shipping Discount Row -->
							<div id="shippingDiscountRow"
								class="d-flex justify-content-between align-items-center mb-2 text-success"
								style="display: none;">
								<span><i class="fas fa-shipping-fast me-1"></i>Giảm giá
									vận chuyển:</span> <span id="shippingDiscountAmount">-0₫</span>
							</div>
							<hr>
							<div class="d-flex justify-content-between align-items-center">
								<h5 class="mb-0">Tổng cộng:</h5>
								<h5 class="mb-0 text-success" id="finalTotal">
									<fmt:formatNumber value="${totalAmount}" type="currency"
										currencySymbol="₫" />
								</h5>
							</div>
						</div>
					</div>

					<div class="mt-3">
						<a href="${pageContext.request.contextPath}/cart/view"
							class="btn btn-outline-secondary w-100"> <i
							class="fas fa-arrow-left me-2"></i>Quay lại giỏ hàng
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/qrcode@1.5.3/build/qrcode.min.js"></script>
	<script>
        function selectPayment(method, element) {
            console.log('selectPayment called with method:', method);
            
            // Remove selected class from all payment methods
            document.querySelectorAll('.payment-method').forEach(function(el) {
                el.classList.remove('selected');
            });
            
            // Add selected class to clicked payment method
            if (element) {
                element.classList.add('selected');
            }
            
            // Check the corresponding radio button
            const radioId = method.toLowerCase() === 'cod' ? 'cod' : 
                           method.toLowerCase() === 'bank_transfer' ? 'bank' : 'qr';
            const radioElement = document.getElementById(radioId);
            if (radioElement) {
                radioElement.checked = true;
                console.log('Radio button checked:', radioId);
            }
            
            // Hide all payment sections
            const qrSection = document.getElementById('qrCodeSection');
            const bankSection = document.getElementById('bankTransferSection');
            
            console.log('QR Section found:', !!qrSection);
            console.log('Bank Section found:', !!bankSection);
            
            if (qrSection) qrSection.style.display = 'none';
            if (bankSection) bankSection.style.display = 'none';
            
            // Show appropriate section and generate content
            if (method === 'QR_CODE' && qrSection) {
                console.log('Showing QR section');
                qrSection.style.display = 'block';
                generateQRCode();
            } else if (method === 'BANK_TRANSFER' && bankSection) {
                console.log('Showing Bank section');
                bankSection.style.display = 'block';
                generateTransferContent();
            }
        }
        
        function generateQRCode() {
            const totalAmount = '${totalAmount}';
            const orderId = 'DH' + Date.now();
            
            // Cập nhật nội dung chuyển khoản
            document.getElementById('transferContent').textContent = 'Thanh toán đơn hàng ' + orderId;
            
            // Giữ nguyên ảnh QR tĩnh, không tạo QR code động
            // QR code image đã được thiết lập trong HTML
        }
        
        function generateTransferContent() {
            const orderId = 'DH' + Date.now();
            document.getElementById('bankTransferContent').textContent = 'Thanh toan don hang ' + orderId;
        }
        
        // Test function to manually show QR section
        function testShowQR() {
            const qrSection = document.getElementById('qrCodeSection');
            if (qrSection) {
                qrSection.style.display = 'block';
                console.log('QR section manually shown');
            } else {
                console.log('QR section not found');
            }
        }
        
        // Function to submit checkout form
        function submitCheckoutForm() {
            console.log('submitCheckoutForm called');
            
            try {
                // Validate required fields
                const customerName = document.getElementById('customerName');
                const customerPhone = document.getElementById('customerPhone');
                const customerAddress = document.getElementById('customerAddress');
                const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
                
                if (!customerName || !customerPhone || !customerAddress) {
                    console.error('Required form fields not found');
                    alert('Có lỗi xảy ra với form. Vui lòng tải lại trang!');
                    return false;
                }
                
                const customerNameValue = customerName.value.trim();
                const customerPhoneValue = customerPhone.value.trim();
                const customerAddressValue = customerAddress.value.trim();
                
                if (!customerNameValue) {
                    alert('Vui lòng nhập họ và tên');
                    customerName.focus();
                    return false;
                }
                
                if (!customerPhoneValue) {
                    alert('Vui lòng nhập số điện thoại');
                    customerPhone.focus();
                    return false;
                }
                
                // Validate phone number format
                const phoneRegex = /^[0-9]{10,11}$/;
                if (!phoneRegex.test(customerPhoneValue)) {
                    alert('Số điện thoại không hợp lệ!');
                    customerPhone.focus();
                    return false;
                }
                
                if (!customerAddressValue) {
                    alert('Vui lòng nhập địa chỉ giao hàng');
                    customerAddress.focus();
                    return false;
                }
                
                if (!paymentMethod) {
                    alert('Vui lòng chọn phương thức thanh toán');
                    return false;
                }
                
                // Submit the form
                const form = document.querySelector('form[action*="/checkout"]');
                if (form) {
                    console.log('Submitting form to:', form.action);
                    form.submit();
                    return true;
                } else {
                    console.error('Form not found');
                    alert('Có lỗi xảy ra. Vui lòng thử lại.');
                    return false;
                }
                
            } catch (error) {
                console.error('Error in submitCheckoutForm:', error);
                alert('Có lỗi xảy ra khi đặt hàng. Vui lòng thử lại!');
                return false;
            }
        }
        
        // Voucher handling
        let appliedVoucher = null;
        let appliedShippingVoucher = null;
        let originalSubtotal = ${subtotal};
        let shippingFee = ${shippingFee};
        let originalTotal = ${totalAmount};
        let currentProductDiscount = 0;
        let currentShippingDiscount = 0;
        
        function applyVoucher() {
            const voucherCode = document.getElementById('voucherCode').value.trim();
            const messageDiv = document.getElementById('voucherMessage');
            const applyBtn = document.getElementById('applyVoucherBtn');
            
            if (!voucherCode) {
                showVoucherMessage('Vui lòng nhập mã voucher', 'danger');
                return;
            }
            
            // Disable button and show loading
            applyBtn.disabled = true;
            applyBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Đang kiểm tra...';
            
            // Call voucher validation API for product voucher
            fetch('${pageContext.request.contextPath}/voucher?code=' + encodeURIComponent(voucherCode) + '&total=' + originalSubtotal + '&type=PRODUCT')
                .then(response => response.json())
                .then(data => {
                    console.log('Product Voucher API Response:', data);
                    if (data.success) {
                        appliedVoucher = data.voucher;
                        currentProductDiscount = data.discountAmount;
                        updateOrderTotal();
                        showVoucherMessage('Áp dụng voucher sản phẩm thành công: ' + data.voucher.name, 'success');
                        
                        // Set voucher code to hidden input
                        document.getElementById('appliedVoucherCode').value = voucherCode;
                        
                        // Change button to remove voucher
                        applyBtn.innerHTML = '<i class="fas fa-times me-1"></i>Hủy';
                        applyBtn.onclick = removeVoucher;
                        document.getElementById('voucherCode').disabled = true;
                    } else {
                        showVoucherMessage(data.message || 'Mã voucher sản phẩm không hợp lệ', 'danger');
                        applyBtn.innerHTML = '<i class="fas fa-tag me-1"></i>Áp dụng';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showVoucherMessage('Có lỗi xảy ra khi kiểm tra voucher', 'danger');
                    applyBtn.innerHTML = '<i class="fas fa-tag me-1"></i>Áp dụng';
                })
                .finally(() => {
                    applyBtn.disabled = false;
                });
        }
        
        function removeVoucher() {
            appliedVoucher = null;
            currentProductDiscount = 0;
            updateOrderTotal();
            showVoucherMessage('', '');
            
            // Clear voucher code from hidden input
            document.getElementById('appliedVoucherCode').value = '';
            
            const applyBtn = document.getElementById('applyVoucherBtn');
            applyBtn.innerHTML = '<i class="fas fa-tag me-1"></i>Áp dụng';
            applyBtn.onclick = applyVoucher;
            
            document.getElementById('voucherCode').value = '';
            document.getElementById('voucherCode').disabled = false;
        }
        
        // Shipping Voucher Functions
        function applyShippingVoucher() {
            const shippingVoucherCode = document.getElementById('shippingVoucherCode').value.trim();
            const messageDiv = document.getElementById('shippingVoucherMessage');
            const applyBtn = document.getElementById('applyShippingVoucherBtn');
            
            if (!shippingVoucherCode) {
                showShippingVoucherMessage('Vui lòng nhập mã voucher vận chuyển', 'danger');
                return;
            }
            
            // Disable button and show loading
            applyBtn.disabled = true;
            applyBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Đang kiểm tra...';
            
            // Call voucher validation API for shipping voucher
            fetch('${pageContext.request.contextPath}/voucher?code=' + encodeURIComponent(shippingVoucherCode) + '&total=' + shippingFee + '&type=SHIPPING')
                .then(response => response.json())
                .then(data => {
                    console.log('Shipping Voucher API Response:', data);
                    if (data.success) {
                        appliedShippingVoucher = data.voucher;
                        currentShippingDiscount = data.discountAmount;
                        updateOrderTotal();
                        showShippingVoucherMessage('Áp dụng voucher vận chuyển thành công: ' + data.voucher.name, 'success');
                        
                        // Set shipping voucher code to hidden input
                        document.getElementById('appliedShippingVoucherCode').value = shippingVoucherCode;
                        
                        // Change button to remove voucher
                        applyBtn.innerHTML = '<i class="fas fa-times me-1"></i>Hủy';
                        applyBtn.onclick = removeShippingVoucher;
                        document.getElementById('shippingVoucherCode').disabled = true;
                    } else {
                        showShippingVoucherMessage(data.message || 'Mã voucher vận chuyển không hợp lệ', 'danger');
                        applyBtn.innerHTML = '<i class="fas fa-shipping-fast me-1"></i>Áp dụng';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showShippingVoucherMessage('Có lỗi xảy ra khi kiểm tra voucher vận chuyển', 'danger');
                    applyBtn.innerHTML = '<i class="fas fa-shipping-fast me-1"></i>Áp dụng';
                })
                .finally(() => {
                    applyBtn.disabled = false;
                });
        }
        
        function removeShippingVoucher() {
            appliedShippingVoucher = null;
            currentShippingDiscount = 0;
            updateOrderTotal();
            showShippingVoucherMessage('', '');
            
            // Clear shipping voucher code from hidden input
            document.getElementById('appliedShippingVoucherCode').value = '';
            
            const applyBtn = document.getElementById('applyShippingVoucherBtn');
            applyBtn.innerHTML = '<i class="fas fa-shipping-fast me-1"></i>Áp dụng';
            applyBtn.onclick = applyShippingVoucher;
            
            document.getElementById('shippingVoucherCode').value = '';
            document.getElementById('shippingVoucherCode').disabled = false;
        }
        
        function updateOrderTotal() {
            console.log('updateOrderTotal called');
            console.log('currentProductDiscount:', currentProductDiscount);
            console.log('currentShippingDiscount:', currentShippingDiscount);
            
            // Calculate final shipping fee after discount
            const finalShippingFee = Math.max(0, shippingFee - currentShippingDiscount);
            
            // Calculate new total
            const newTotal = originalSubtotal - currentProductDiscount + finalShippingFee;
            console.log('Calculation: originalSubtotal:', originalSubtotal, '- productDiscount:', currentProductDiscount, '+ finalShippingFee:', finalShippingFee, '= newTotal:', newTotal);
            
            // Get elements
            const productDiscountRow = document.getElementById('productDiscountRow');
            const productDiscountAmountSpan = document.getElementById('productDiscountAmount');
            const shippingDiscountRow = document.getElementById('shippingDiscountRow');
            const shippingDiscountAmountSpan = document.getElementById('shippingDiscountAmount');
            const finalTotalSpan = document.getElementById('finalTotal');
            const bankTransferAmountSpans = document.querySelectorAll('.bank-transfer-amount');
            
            
            if (currentProductDiscount > 0) {
                if (productDiscountRow) {
                    productDiscountRow.style.display = 'flex';
                }
                if (productDiscountAmountSpan) {
                    productDiscountAmountSpan.textContent = '-' + formatCurrency(currentProductDiscount);
                }
            } else {
                if (productDiscountRow) {
                    productDiscountRow.style.display = 'none';
                }
            }
            
            // Update shipping discount display
            if (currentShippingDiscount > 0) {
                if (shippingDiscountRow) {
                    shippingDiscountRow.style.display = 'flex';
                }
                if (shippingDiscountAmountSpan) {
                    shippingDiscountAmountSpan.textContent = '-' + formatCurrency(currentShippingDiscount);
                }
            } else {
                if (shippingDiscountRow) {
                    shippingDiscountRow.style.display = 'none';
                }
            }
            
            // Update final total
            if (finalTotalSpan) {
                finalTotalSpan.textContent = formatCurrency(newTotal);
            }

            // Update bank transfer amount display
            if (bankTransferAmountSpans && bankTransferAmountSpans.length > 0) {
                bankTransferAmountSpans.forEach(function(el){
                    el.textContent = formatCurrency(newTotal);
                });
            }
        }
        
        function showVoucherMessage(message, type) {
            const messageDiv = document.getElementById('voucherMessage');
            if (message) {
                messageDiv.className = 'mt-2 alert alert-' + type;
                messageDiv.textContent = message;
                messageDiv.style.display = 'block';
            } else {
                messageDiv.style.display = 'none';
            }
        }
        
        function showShippingVoucherMessage(message, type) {
            const messageDiv = document.getElementById('shippingVoucherMessage');
            if (message) {
                messageDiv.className = 'mt-2 alert alert-' + type;
                messageDiv.textContent = message;
                messageDiv.style.display = 'block';
            } else {
                messageDiv.style.display = 'none';
            }
        }
        
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
            }).format(amount);
        }
        
        // Initialize first payment method as selected
        document.addEventListener('DOMContentLoaded', function() {
            // Prefill and auto-apply voucher from promotions link
            try {
                const params = new URLSearchParams(window.location.search);
                const initialVoucher = params.get('voucherCode');
                const initialShippingVoucher = params.get('shippingVoucherCode');
                if (initialVoucher) {
                    const input = document.getElementById('voucherCode');
                    if (input) { input.value = initialVoucher; }
                    if (typeof applyVoucher === 'function') { applyVoucher(); }
                }
                if (initialShippingVoucher) {
                    const sInput = document.getElementById('shippingVoucherCode');
                    if (sInput) { sInput.value = initialShippingVoucher; }
                    if (typeof applyShippingVoucher === 'function') { applyShippingVoucher(); }
                }
            } catch (e) { /* ignore */ }
            console.log('DOM loaded, initializing payment methods');
            
            const firstPaymentMethod = document.querySelector('.payment-method');
            if (firstPaymentMethod) {
                firstPaymentMethod.classList.add('selected');
                console.log('First payment method selected');
            }
            
            // Kiểm tra phương thức thanh toán được chọn và hiển thị phần tương ứng
            const selectedPayment = document.querySelector('input[name="paymentMethod"]:checked');
            console.log('Selected payment:', selectedPayment ? selectedPayment.value : 'none');
            
            if (selectedPayment) {
                const method = selectedPayment.value;
                const qrSection = document.getElementById('qrCodeSection');
                const bankSection = document.getElementById('bankTransferSection');
                
                console.log('Available sections - QR:', !!qrSection, 'Bank:', !!bankSection);
                
                if (method === 'QR_CODE' && qrSection) {
                    qrSection.style.display = 'block';
                    generateQRCode();
                    console.log('QR section initialized');
                } else if (method === 'BANK_TRANSFER' && bankSection) {
                    bankSection.style.display = 'block';
                    generateTransferContent();
                    console.log('Bank section initialized');
                }
            }
            
            // Add click event listeners to payment methods
            document.querySelectorAll('.payment-method').forEach(function(element) {
                element.addEventListener('click', function() {
                    const input = this.querySelector('input[type="radio"]');
                    if (input) {
                        selectPayment(input.value, this);
                    }
                });
            });
            
            // Add event listeners for voucher buttons
            const voucherBtn = document.getElementById('voucherBtn');
            if (voucherBtn) {
                voucherBtn.addEventListener('click', function() {
                    if (appliedVoucher) {
                        removeVoucher();
                    } else {
                        applyVoucher();
                    }
                });
            }
            
            const shippingVoucherBtn = document.getElementById('shippingVoucherBtn');
            if (shippingVoucherBtn) {
                shippingVoucherBtn.addEventListener('click', function() {
                    if (appliedShippingVoucher) {
                        removeShippingVoucher();
                    } else {
                        applyShippingVoucher();
                    }
                });
            }
        });
    </script>
    <jsp:include page="/WEB-INF/views/includes/chat-widget.jsp" />
</body>
</html>
y>
</html>
