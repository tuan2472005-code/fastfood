<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${product.ten}-Fast Food</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
.product-image {
	max-height: 500px;
	object-fit: cover;
	border-radius: 15px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
	transition: transform 0.3s ease;
}

.product-image:hover {
	transform: scale(1.02);
	transform-origin: center;
}

.footer {
	background-color: #ff6b35;
	color: white;
	padding: 60px 0;
	margin-top: 40px;
.btn-primary {
    background-color: #ff6b35;
    border-color: #ff6b35;
}
/* Notifications */
.notif-btn{position:relative}
.notif-badge{position:absolute;top:0;right:0;transform:translate(50%,-50%);background:#dc3545;color:#fff;border-radius:999px;font-size:.65rem;line-height:1;padding:2px 6px;min-width:18px;text-align:center}
.dropdown-menu.notifications{min-width:340px;border-radius:12px;box-shadow:0 6px 20px rgba(0,0,0,.15)}
.notifications .notif-header{padding:.5rem 1rem;font-weight:600}
.notifications .notif-item{display:flex;align-items:flex-start;gap:.5rem;padding:.5rem 1rem}
.notifications .notif-item i{color:#ff6b35}
.notifications .notif-empty{padding:.75rem 1rem;color:#6c757d}
.notifications .notif-item + .notif-item{border-top:1px solid #eee}
.notifications .notif-thumb{width:28px;height:28px;border-radius:6px;object-fit:cover;border:1px solid #eee}
	border-radius: 25px;
	padding: 12px 30px;
	font-weight: 600;
	transition: all 0.3s ease;
}

.btn-primary:hover {
	background-color: #e55a2b;
	border-color: #e55a2b;
	transform: translateY(-1px);
	box-shadow: 0 4px 12px rgba(255, 107, 53, 0.3);
}

.price-section {
	background: linear-gradient(135deg, #ff6b35, #ff8c42);
	color: white;
	padding: 20px;
	border-radius: 15px;
	margin: 20px 0;
	box-shadow: 0 5px 20px rgba(255, 107, 53, 0.3);
}

.original-price {
	text-decoration: line-through;
	color: #ffcccc;
	font-size: 1.1rem;
}

.discount-price {
	font-size: 2rem;
	font-weight: bold;
	color: #fff;
}

.current-price {
	font-size: 2rem;
	font-weight: bold;
	color: #fff;
}

.product-info-card {
	background: #f8f9fa;
	border-radius: 15px;
	padding: 25px;
	margin: 20px 0;
	border: 1px solid #e9ecef;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.info-item {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
	padding: 10px;
	background: white;
	border-radius: 8px;
	border-left: 4px solid #ff6b35;
}

.info-item i {
	color: #ff6b35;
	margin-right: 12px;
	width: 20px;
	text-align: center;
}

.stock-badge {
	display: inline-block;
	padding: 8px 15px;
	border-radius: 20px;
	font-weight: 600;
	font-size: 0.9rem;
}

.stock-available {
	background-color: #d4edda;
	color: #155724;
	border: 1px solid #c3e6cb;
}

.stock-low {
	background-color: #fff3cd;
	color: #856404;
	border: 1px solid #ffeaa7;
}

.stock-out {
	background-color: #f8d7da;
	color: #721c24;
	border: 1px solid #f5c6cb;
}

.breadcrumb {
	background: none;
	padding: 0;
	margin: 20px 0;
}

.breadcrumb-item a {
	color: #ff6b35;
	text-decoration: none;
}

.breadcrumb-item a:hover {
	color: #e55a2b;
	text-decoration: underline;
}

.quantity-input {
	border-radius: 10px;
	border: 2px solid #e9ecef;
	padding: 10px;
	text-align: center;
	font-weight: 600;
}

.quantity-input:focus {
	border-color: #ff6b35;
	box-shadow: 0 0 0 0.2rem rgba(255, 107, 53, 0.25);
}

.product-title {
	color: #2c3e50;
	font-weight: 700;
	margin-bottom: 15px;
}

.product-description {
	color: #6c757d;
	line-height: 1.8;
	font-size: 1.1rem;
}

/* User Avatar Button Styles */
.user-avatar-btn {
	border-radius: 25px !important;
	padding: 8px 16px !important;
	box-shadow: 0 3px 6px rgba(0, 0, 0, 0.15) !important;
	transition: all 0.3s ease !important;
	border: 2px solid rgba(255, 255, 255, 0.3) !important;
}

.user-avatar-btn:hover {
	transform: translateY(-1px) !important;
	box-shadow: 0 5px 10px rgba(0, 0, 0, 0.25) !important;
	border-color: rgba(255, 255, 255, 0.5) !important;
}

.user-avatar-btn:active {
	transform: translateY(0) !important;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.15) !important;
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

/* Star Rating Styles */
.star-rating {
	display: flex;
	align-items: center;
	gap: 5px;
	margin: 10px 0;
}

.stars {
	display: flex;
	gap: 2px;
}

.star {
	color: #ffc107;
	font-size: 1.2rem;
}

.star.empty {
	color: #e9ecef;
}

.rating-text {
	margin-left: 8px;
	color: #6c757d;
	font-size: 0.9rem;
}

/* Review Form Styles */
.rating-input {
	margin: 10px 0;
}

.stars-input {
	display: flex;
	gap: 5px;
	margin-bottom: 5px;
}

.star-input {
	font-size: 1.5rem;
	color: #ddd;
	cursor: pointer;
	transition: color 0.2s ease;
}

.star-input:hover, .star-input.active {
	color: #ffc107;
}

.star-input.hover {
	color: #ffeb3b;
}

.review-item {
	border-bottom: 1px solid #eee;
	padding: 20px 0;
}

.review-item:last-child {
	border-bottom: none;
}

.review-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.review-author {
	font-weight: 600;
	color: #2c3e50;
}

.review-date {
	font-size: 0.9rem;
	color: #6c757d;
}

.review-content {
	color: #495057;
	line-height: 1.6;
}

.rating-summary {
	background: #fff3cd;
	border: 1px solid #ffeaa7;
	border-radius: 8px;
	padding: 15px;
	margin: 15px 0;
}

.rating-summary .rating-number {
	font-size: 2rem;
	font-weight: bold;
	color: #ff6b35;
}

/* Header Styling */
.navbar {
	position: fixed !important;
	top: 0;
	left: 0;
	right: 0;
	z-index: 1030;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15) !important;
	padding: 0.8rem 0 !important;
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
	color: #fff !important;
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
    border: none !important;
    border-radius: 25px !important;
    padding: 8px 20px !important;
    font-weight: 500 !important;
    transition: all 0.3s ease !important;
    box-shadow: none !important;
}
.btn-outline-light:hover {
    background-color: rgba(255, 255, 255, 0.2) !important;
    border-color: transparent !important;
    transform: translateY(-2px) !important;
    box-shadow: none !important;
}

.user-avatar-btn {
    background: transparent !important;
    border: none !important;
    color: white;
    border-radius: 25px;
    padding: 0.5rem 1rem;
    transition: all 0.3s ease;
    box-shadow: none !important;
}
.user-avatar-btn:hover {
    background: rgba(255, 255, 255, 0.2);
    border-color: transparent !important;
    color: white;
    transform: translateY(-2px);
    box-shadow: none !important;
}

.avatar-image {
	width: 28px;
	height: 28px;
	border-radius: 50%;
	object-fit: cover;
}

.avatar-icon {
	font-size: 24px;
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
    <c:if test="${not empty sessionScope.flashError}">
        <div class="toast-container position-fixed top-0 start-0 p-3" style="z-index: 1080;">
            <div id="flashErrorToast" class="toast align-items-center text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                        <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.flashError}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <script>
        document.addEventListener('DOMContentLoaded', function() {
            var el = document.getElementById('flashErrorToast');
            if (el && window.bootstrap && window.bootstrap.Toast) {
                var t = new bootstrap.Toast(el, {delay: 3000});
                t.show();
            }
        });
        </script>
        <% session.removeAttribute("flashError"); %>
    </c:if>
    <c:if test="${not empty sessionScope.flashSuccess}">
        <div class="toast-container position-fixed top-0 start-0 p-3"
            style="z-index: 1080;">
            <div id="flashToast"
                class="toast align-items-center text-bg-success border-0"
                role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
					<div class="toast-body">
						<i class="fas fa-check-circle me-2"></i>${sessionScope.flashSuccess}</div>
					<button type="button" class="btn-close btn-close-white me-2 m-auto"
						data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
			</div>
		</div>
		<script>
        document.addEventListener('DOMContentLoaded', function() {
            var el = document.getElementById('flashToast');
            if (el && window.bootstrap && window.bootstrap.Toast) {
                var t = new bootstrap.Toast(el, {delay: 2500});
                t.show();
            }
        });
        </script>
		<% session.removeAttribute("flashSuccess"); %>
	</c:if>
	<!-- Header/Navbar -->
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
                        class="btn btn-outline-light me-2 notif-btn">
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

	<!-- Breadcrumb -->
	<div class="container mt-3">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/home"><i
						class="fas fa-home"></i> Trang chủ</a></li>
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
				<c:if test="${not empty product.categoryName}">
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}/products?categoryId=${product.categoryId}">${product.categoryName}</a></li>
				</c:if>
				<li class="breadcrumb-item active" aria-current="page">${product.ten}</li>
			</ol>
		</nav>
	</div>

	<!-- Product Detail -->
	<div class="container my-5">
		<div class="row">
			<!-- Product Image -->
			<div class="col-lg-6 mb-4">
				<div class="text-center">
					<c:choose>
						<c:when
							test="${not empty product.hinhAnh && (fn:startsWith(product.hinhAnh, 'http://') || fn:startsWith(product.hinhAnh, 'https://'))}">
							<img src="${product.hinhAnh}" class="img-fluid product-image"
								alt="${product.ten}">
						</c:when>
						<c:otherwise>
							<img src="${pageContext.request.contextPath}/${product.hinhAnh}"
								class="img-fluid product-image" alt="${product.ten}">
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<!-- Product Information -->
			<div class="col-lg-6">
				<h1 class="product-title">${product.ten}</h1>

				<!-- Category Badge -->
				<c:if test="${not empty product.categoryName}">
					<span class="badge bg-secondary mb-3"> <i
						class="fas fa-tag me-1"></i>${product.categoryName}
					</span>
				</c:if>

				<!-- Price Section -->
				<div class="price-section">
					<c:choose>
						<c:when
							test="${not empty product.discountPrice && product.discountPrice > 0}">
							<div class="d-flex align-items-center">
								<span class="original-price me-3"> <fmt:formatNumber
										value="${product.price}" type="number" groupingUsed="true" />
									đ
								</span> <span class="discount-price"> <fmt:formatNumber
										value="${product.discountPrice}" type="number"
										groupingUsed="true" /> đ
								</span>
							</div>
							<small class="text-light"> <i
								class="fas fa-percentage me-1"></i> Tiết kiệm: <fmt:formatNumber
									value="${product.price - product.discountPrice}" type="number"
									groupingUsed="true" /> đ
							</small>
						</c:when>
						<c:otherwise>
							<span class="current-price"> <fmt:formatNumber
									value="${product.price}" type="number" groupingUsed="true" />
								đ
							</span>
						</c:otherwise>
					</c:choose>
				</div>

				<!-- Rating Summary -->
				<div class="rating-summary">
					<div class="d-flex align-items-center justify-content-between">
						<div>
							<div class="star-rating">
								<div class="stars">
									<c:forEach var="i" begin="1" end="5">
										<c:choose>
											<c:when test="${i <= product.averageRating}">
												<i class="fas fa-star star"></i>
											</c:when>
											<c:when test="${i - 0.5 <= product.averageRating}">
												<i class="fas fa-star-half-alt star"></i>
											</c:when>
											<c:otherwise>
												<i class="far fa-star star empty"></i>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</div>
								<span class="rating-text"> <fmt:formatNumber
										value="${product.averageRating}" maxFractionDigits="1" />
									(${product.reviewCount} đánh giá)
								</span>
							</div>
						</div>
						<div class="rating-number">
							<fmt:formatNumber value="${product.averageRating}"
								maxFractionDigits="1" />
						</div>
					</div>
				</div>

				<!-- Product Information Card -->
				<div class="product-info-card">
				<h5 class="mb-3">
					<i class="fas fa-info-circle me-2"></i>Thông tin sản phẩm
				</h5>

					<!-- Product Status -->
                    <div class="info-item">
                        <i class="fas fa-toggle-on"></i>
                        <div>
                            <strong>Trạng thái:</strong> <span class="ms-2"> <c:choose>
                                    <c:when test="${fn:toLowerCase(product.status) == 'active'}">
                                        <span class="badge bg-success">Đang bán</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning">Tạm ngưng</span>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>

					<!-- Featured Product -->
					<c:if test="${product.featured}">
						<div class="info-item">
							<i class="fas fa-star"></i>
							<div>
								<strong>Sản phẩm nổi bật</strong> <span
									class="badge bg-warning text-dark ms-2"> <i
									class="fas fa-crown me-1"></i>Bestseller
								</span>
							</div>
						</div>
					</c:if>
				</div>

				<!-- Description -->
				<div class="mb-4">
					<h5>
						<i class="fas fa-align-left me-2"></i>Mô tả sản phẩm
					</h5>
					<p class="product-description">${product.description}</p>
				</div>

				<!-- Add to Cart Form -->
                <c:if test="${product.stock > 0 && fn:toLowerCase(product.status) == 'active'}">
                    <form action="${pageContext.request.contextPath}/cart/add"
                        method="post" class="mt-4">
                        <input type="hidden" name="productId" value="${product.id}">
                        <div class="row align-items-end">
                            <div class="col-md-4 mb-3">
                                <label for="quantity" class="form-label"> <i
                                    class="fas fa-sort-numeric-up me-1"></i>Số lượng
                                </label> <input type="number" class="form-control quantity-input"
                                    id="quantity" name="quantity" value="1" min="1"
                                    max="${product.stock}">
                            </div>
                            <div class="col-md-8 mb-3">
                                <button type="submit" class="btn btn-primary btn-lg w-100">
                                    <i class="fas fa-cart-plus me-2"></i>Thêm vào giỏ hàng
                                </button>
                            </div>
                        </div>
                    </form>
                </c:if>



				<!-- Additional Actions -->
				<div class="mt-4">
					<a href="${pageContext.request.contextPath}/products"
						class="btn btn-outline-secondary me-2"> <i
						class="fas fa-arrow-left me-1"></i>Quay lại danh sách
					</a>
					<c:if test="${not empty product.categoryName}">
						<a
							href="${pageContext.request.contextPath}/products?categoryId=${product.categoryId}"
							class="btn btn-outline-primary"> <i class="fas fa-list me-1"></i>Xem
							thêm ${product.categoryName}
						</a>
					</c:if>
				</div>
			</div>
		</div>
	</div>

	<!-- Review Section -->
	<div class="container my-5">
		<div class="row">
			<div class="col-lg-8 mx-auto">
				<!-- Review Form -->
				<div class="card shadow-sm mb-4">
					<div class="card-header bg-primary text-white">
						<h5 class="mb-0">
							<i class="fas fa-star me-2"></i>Đánh giá sản phẩm
						</h5>
					</div>
					<div class="card-body">
						<!-- Success Message -->
						<c:if test="${param.reviewAdded == 'true'}">
							<div class="alert alert-success alert-dismissible fade show"
								role="alert">
								<i class="fas fa-check-circle me-2"></i> Cảm ơn bạn đã đánh giá!
								Đánh giá của bạn sẽ được xem xét và hiển thị sớm.
								<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
							</div>
						</c:if>

                        <c:choose>
                            <c:when test="${empty sessionScope.user}">
                                <div class="alert alert-warning" role="alert">
                                    <i class="fas fa-exclamation-circle me-2"></i> Vui lòng đăng nhập để gửi đánh giá.
                                </div>
                                <a class="btn btn-primary"
                                   href="${pageContext.request.contextPath}/login?redirect=/product?id=${product.id}">
                                   <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                                </a>
                            </c:when>
                            <c:otherwise>
                            <form action="${pageContext.request.contextPath}/review"
                                method="post" id="reviewForm">
                                <input type="hidden" name="action" value="add"> <input
                                    type="hidden" name="sanPhamId" value="${product.id}">

                                <div class="row">
								<div class="col-md-6 mb-3">
									<label for="hoTen" class="form-label">Họ tên <span
										class="text-danger">*</span></label> <input type="text"
										class="form-control" id="hoTen" name="hoTen" required
										value="${sessionScope.user != null ? sessionScope.user.fullName : ''}"
										placeholder="Nhập họ tên của bạn">
								</div>
								<div class="col-md-6 mb-3">
									<label for="email" class="form-label">Email</label> <input
										type="email" class="form-control" id="email" name="email"
										value="${sessionScope.user != null ? sessionScope.user.email : ''}"
										placeholder="Nhập email của bạn (tùy chọn)">
								</div>
							</div>

							<div class="mb-3">
								<label class="form-label">Đánh giá <span
									class="text-danger">*</span></label>
								<div class="rating-input">
									<div class="stars-input" id="starsInput">
										<i class="fas fa-star star-input" data-rating="1"></i> <i
											class="fas fa-star star-input" data-rating="2"></i> <i
											class="fas fa-star star-input" data-rating="3"></i> <i
											class="fas fa-star star-input" data-rating="4"></i> <i
											class="fas fa-star star-input" data-rating="5"></i>
									</div>
									<input type="hidden" name="rating" id="ratingValue" value="0"
										required> <small class="text-muted">Nhấp vào
										sao để đánh giá</small>
								</div>
							</div>

							<div class="mb-3">
								<label for="binhLuan" class="form-label">Nhận xét</label>
								<textarea class="form-control" id="binhLuan" name="binhLuan"
									rows="4"
									placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này..."></textarea>
							</div>

                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-paper-plane me-2"></i>Gửi đánh giá
                                    </button>
                                </div>
                            </form>
                            </c:otherwise>
                        </c:choose>
					</div>
				</div>

				<!-- Existing Reviews -->
				<div class="card shadow-sm">
					<div class="card-header bg-light">
						<h5 class="mb-0">
							<i class="fas fa-comments me-2"></i>Đánh giá từ khách hàng
						</h5>
					</div>
					<div class="card-body">
						<div id="reviewsList">
							<div class="text-center py-4">
								<i class="fas fa-spinner fa-spin fa-2x text-muted"></i>
								<p class="text-muted mt-2">Đang tải đánh giá...</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer class="footer">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<h5>Fast Food</h5>
					<p>Cung cấp các món ăn nhanh chất lượng cao với giá cả phải
						chăng.</p>
				</div>
				<div class="col-md-4">
					<h5>Liên kết nhanh</h5>
					<ul class="list-unstyled">
						<li><a href="${pageContext.request.contextPath}/home"
							class="text-white">Trang chủ</a></li>
						<li><a href="${pageContext.request.contextPath}/about"
							class="text-white">Giới thiệu</a></li>
						<li><a href="${pageContext.request.contextPath}/contact"
							class="text-white">Liên hệ</a></li>
					</ul>
				</div>
				<div class="col-md-4">
					<h5>Liên hệ</h5>
					<address>
						<p>
							<i class="fas fa-map-marker-alt"></i> 123 Đường ABC, Quận XYZ,
							TP. HCM
						</p>
						<p>
							<i class="fas fa-phone"></i> (123) 456-7890
						</p>
						<p>
							<i class="fas fa-envelope"></i> info@fastfood.com
						</p>
					</address>
				</div>
			</div>
			<hr class="bg-white">
			<div class="text-center">
				<p>&copy; 2023 Fast Food. All rights reserved.</p>
			</div>
		</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

	<script>
        // Rating stars functionality
        document.addEventListener('DOMContentLoaded', function() {
            const stars = document.querySelectorAll('.star-input');
            const ratingValue = document.getElementById('ratingValue');
            let currentRating = 0;
            
            stars.forEach((star, index) => {
                star.addEventListener('mouseover', function() {
                    highlightStars(index + 1);
                });
                
                star.addEventListener('mouseout', function() {
                    highlightStars(currentRating);
                });
                
                star.addEventListener('click', function() {
                    currentRating = index + 1;
                    ratingValue.value = currentRating;
                    highlightStars(currentRating);
                });
            });
            
            function highlightStars(rating) {
                stars.forEach((star, index) => {
                    if (index < rating) {
                        star.classList.add('active');
                    } else {
                        star.classList.remove('active');
                    }
                });
            }
            
            // Load existing reviews
            loadReviews();
            
            // Form validation
            document.getElementById('reviewForm').addEventListener('submit', function(e) {
                if (currentRating === 0) {
                    e.preventDefault();
                    alert('Vui lòng chọn số sao đánh giá!');
                    return false;
                }
            });
        });
        
        // Load reviews function
        function loadReviews() {
            const productId = ${product.id};
            const reviewsList = document.getElementById('reviewsList');
            
            fetch('${pageContext.request.contextPath}/review?action=listReviews&productId=' + productId)
                .then(response => response.json())
                .then(data => {
                    if (data.reviews && data.reviews.length > 0) {
                        let html = '';
                        data.reviews.forEach(review => {
                             html += '<div class="review-item">' +
                                     '<div class="review-header">' +
                                     '<div>' +
                                     '<div class="review-author">' + review.hoTen + '</div>' +
                                     '<div class="star-rating">' +
                                     '<div class="stars">' + generateStars(review.rating) + '</div>' +
                                     '<span class="rating-text">(' + review.rating + '/5)</span>' +
                                     '</div>' +
                                     '</div>' +
                                     '<div class="review-date">' + formatDate(review.ngayTao) + '</div>' +
                                     '</div>' +
                                     (review.binhLuan ? '<div class="review-content">' + review.binhLuan + '</div>' : '') +
                                     '</div>';
                         });
                        reviewsList.innerHTML = html;
                    } else {
                        reviewsList.innerHTML = '<div class="text-center py-4"><p class="text-muted">Chưa có đánh giá nào. Hãy là người đầu tiên đánh giá sản phẩm này!</p></div>';
                    }
                })
                .catch(error => {
                     console.error('Lỗi khi tải đánh giá:', error);
                     reviewsList.innerHTML = '<div class="text-center py-4"><p class="text-muted">Không thể tải đánh giá. Vui lòng thử lại sau.</p></div>';
                 });
         }
         
         // Tạo HTML cho sao
         function generateStars(rating) {
             let stars = '';
             for (let i = 1; i <= 5; i++) {
                 if (i <= rating) {
                     stars += '<i class="fas fa-star star"></i>';
                 } else {
                     stars += '<i class="fas fa-star star empty"></i>';
                 }
             }
             return stars;
         }
         
         // Format ngày tháng
         function formatDate(dateString) {
             const date = new Date(dateString);
             return date.toLocaleDateString('vi-VN', {
                year: 'numeric',
                month: 'long', 
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
             });
         }
    </script>
    <jsp:include page="/WEB-INF/views/includes/chat-widget.jsp" />
</body>
</html>
