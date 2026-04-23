<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Fast Food - Trang chủ</title>
<link rel="icon" href="<c:url value='/images/logofastfood.png'/>" type="image/png">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
.hero-section {
	background-color: #f8f9fa;
	padding: 60px 0;
}
/* Section Divider */
.section-divider {
	width: 60px;
	height: 4px;
	background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
	margin: 1rem auto;
	border-radius: 2px;
}

/* Product Cards */
.product-card {
	border: none;
	border-radius: 15px;
	overflow: hidden;
	transition: all 0.3s ease;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.product-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
}

.product-image-wrapper {
	position: relative;
	overflow: hidden;
}

.product-image {
	height: 250px;
	object-fit: cover;
	transition: transform 0.3s ease;
}

.product-card:hover .product-image {
	transform: scale(1.05);
}

/* User Avatar Button Styles */
.user-avatar-btn {
	border-radius: 25px !important;
	padding: 8px 16px !important;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2) !important;
	transition: all 0.3s ease !important;
	border: 2px solid rgba(255, 255, 255, 0.2) !important;
}

.user-avatar-btn:hover {
	transform: translateY(-1px) !important;
	box-shadow: 0 5px 10px rgba(0, 0, 0, 0.25) !important;
	border-color: rgba(255, 255, 255, 0.4) !important;
}

.user-avatar-btn:active {
    transform: translateY(0) !important;
    box-shadow: none !important;
}

.avatar-image {
    border: 2px solid white !important;
    box-shadow: none !important;
    outline: none !important;
    background-color: transparent !important;
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
	justify-content: center;
	margin-bottom: 10px;
	font-size: 0.9em;
}

.stars {
	display: flex;
	margin-right: 8px;
}

.star {
	color: #ffc107;
	font-size: 14px;
	margin-right: 2px;
}

.star.empty {
	color: #e0e0e0;
}

.rating-text {
	color: #666;
	font-size: 0.85em;
}

.product-overlay {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.7);
	display: flex;
	align-items: center;
	justify-content: center;
	opacity: 0;
	transition: opacity 0.3s ease;
}

.product-card:hover .product-overlay {
	opacity: 1;
}

.product-actions {
	display: flex;
	gap: 10px;
}

.product-actions .btn {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: transform 0.3s ease;
}

.product-actions .btn:hover {
	transform: scale(1.1);
}

.product-badge {
	position: absolute;
	top: 15px;
	left: 15px;
	z-index: 2;
}

.product-badge .badge {
	font-size: 0.8rem;
	padding: 0.5rem 1rem;
	border-radius: 20px;
}

.product-name {
	font-size: 1.2rem;
	font-weight: 600;
	color: #ff6b35;
	margin-bottom: 0.5rem;
}

.product-price {
	font-size: 1.4rem;
	font-weight: bold;
	color: #ff6b35;
	margin-bottom: 0.5rem;
}

.btn-add-cart {
	border-radius: 25px;
	padding: 0.5rem 1.5rem;
	font-weight: 500;
	transition: all 0.3s ease;
}

.btn-add-cart:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(255, 107, 53, 0.4);
}

.category-section {
	padding: 40px 0;
}

.footer {
	background-color: #ff6b35;
	color: white;
	padding: 40px 0;
}

.btn-primary {
	background-color: #ff6b35;
	border-color: #ff6b35;
}

.btn-primary:hover {
	background-color: #e55a2b;
	border-color: #e55a2b;
}

/* Banner Carousel Styles */
.banner-slide {
	padding: 80px 0;
	min-height: 400px;
	display: flex;
	align-items: center;
}

.banner-1 {
	background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
	color: white;
}

.banner-2 {
	background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
	color: white;
}

.banner-3 {
	background: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);
	color: white;
}

.banner-title {
	font-size: 3rem;
	font-weight: bold;
	margin-bottom: 1rem;
	animation: slideInLeft 1s ease-out;
}

.banner-text {
	font-size: 1.2rem;
	margin-bottom: 2rem;
	animation: slideInLeft 1s ease-out 0.3s both;
}

.banner-icon {
	font-size: 8rem;
	opacity: 0.8;
	animation: bounce 2s infinite;
}

/* Service Cards */
.service-card {
    background: white;
    padding: 2rem;
    border: none;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    height: 100%;
}

.service-card:hover {
	transform: translateY(-10px);
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
}

.service-icon {
	width: 80px;
	height: 80px;
	background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto 1.5rem;
	color: white;
	font-size: 2rem;
}

/* Statistics */
.stat-item {
    padding: 2rem;
    border: none;
}

.stat-number {
	font-size: 3rem;
	font-weight: bold;
	color: #ff6b35;
	display: block;
	margin-bottom: 0.5rem;
}

.stat-label {
	font-size: 1.1rem;
	color: #6c757d;
	font-weight: 500;
}

/* Testimonials */
.testimonial-card {
    background: white;
    padding: 2rem;
    border: none;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
    height: 100%;
}

.testimonial-card:hover {
	transform: translateY(-5px);
}

.testimonial-content {
	margin-bottom: 1.5rem;
}

.testimonial-content p {
	font-style: italic;
	color: #6c757d;
	margin-bottom: 0;
}

.testimonial-author {
	display: flex;
	align-items: center;
}

.author-avatar {
	width: 50px;
	height: 50px;
	background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	margin-right: 1rem;
}

.author-info h6 {
	margin-bottom: 0;
	font-weight: 600;
}

/* Custom style for "Xem tất cả sản phẩm" button */
.btn-outline-primary {
	color: #ff6b35 !important;
	border-color: #ff6b35 !important;
}

.btn-outline-primary:hover {
	background-color: #ff6b35 !important;
	border-color: #ff6b35 !important;
	color: white !important;
}

/* Animations */
@
keyframes slideInLeft {from { opacity:0;
	transform: translateX(-50px);
}

to {
	opacity: 1;
	transform: translateX(0);
}

}
@
keyframes bounce { 0%, 20%, 50%, 80%, 100% {
	transform: translateY(0);
}

40


%
{
transform


:


translateY
(


-20px


)
;


}
60


%
{
transform


:


translateY
(


-10px


)
;


}
}

/* Header/Navbar Styles */
.avatar-icon {
	color: white !important;
	filter: drop-shadow(0 0 2px white)
		drop-shadow(0 0 4px rgba(0, 123, 255, 0.8)) !important;
}

.navbar {
	position: fixed !important;
	top: 0;
	left: 0;
	right: 0;
	z-index: 1030;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	transition: all 0.3s ease;
	padding: 15px 0 !important;
	min-height: auto;
}

/* Body padding to prevent content being hidden behind fixed header */
body {
	padding-top: 76px;
}

.navbar-brand {
    font-size: 1.9rem !important;
    font-weight: 800 !important;
    color: #fff !important;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3) !important;
    transition: all 0.3s ease !important;
}

.navbar-brand:hover {
	transform: scale(1.05);
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

.navbar-nav .nav-link {
	font-weight: 500;
	margin: 0 0.5rem;
	transition: all 0.3s ease;
	border-radius: 5px;
	padding: 0.5rem 1rem !important;
}

.navbar-nav .nav-link:hover {
	background-color: rgba(255, 255, 255, 0.1);
	transform: translateY(-1px);
}

.navbar-nav .nav-link.active {
	background-color: rgba(255, 255, 255, 0.2);
	font-weight: 600;
}

.btn-outline-light {
    border: none;
    font-weight: 500;
    transition: all 0.3s ease;
    border-radius: 25px;
    padding: 0.5rem 1.2rem;
}

.btn-outline-light:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(255, 255, 255, 0.3);
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
	box-shadow: 0 5px 10px rgba(0, 0, 0, 0.25) !important;
	border-color: rgba(255, 255, 255, 0.4) !important;
}

.user-avatar-btn:active {
	transform: translateY(0) !important;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2) !important;
}

.avatar-image {
    border: 2px solid white !important;
    box-shadow: none !important;
    outline: none !important;
    background-color: transparent !important;
}

/* Responsive */
@media ( max-width : 768px) {
	.navbar {
		padding: 10px 0 !important;
	}
	.navbar-brand {
		font-size: 1.3rem;
	}
	.navbar-brand video { display: none !important; }
	.navbar-nav .nav-link {
		padding: 0.4rem 0.8rem !important;
		margin: 0 0.2rem;
	}
	.user-avatar-btn {
		padding: 6px 12px !important;
	}
    .navbar .container {
        display: flex !important;
        align-items: center !important;
        justify-content: space-between !important;
        flex-wrap: wrap !important;
    }
    .navbar-collapse {
        flex-basis: 100% !important;
        width: 100% !important;
        margin-top: .5rem !important;
    }
    .mobile-actions {
        margin-left: auto !important;
        gap: .25rem !important;
        align-items: center !important;
        flex-wrap: nowrap !important;
    }
    .mobile-actions .btn {
        padding: 6px 8px !important;
        line-height: 1 !important;
    }
    .mobile-actions .btn i { font-size: 1.05rem !important; }
    .mobile-actions .notif-badge { top: -4px !important; right: -6px !important; transform: none !important; }
    .dropdown-menu.notifications { min-width: 280px !important; border-radius: 12px !important; margin-top: 8px !important; }
}
    .mobile-actions > * { flex: 0 0 auto !important; }
}

/* Responsive */
@media ( max-width : 768px) {
	.banner-title {
		font-size: 2rem;
	}
	.banner-text {
		font-size: 1rem;
	}
	.banner-icon {
		font-size: 4rem;
	}
.stat-number {
	font-size: 2rem;
}
	.navbar-nav .nav-link {
		margin: 0.2rem 0;
	}
}

.banner-illustration {
	max-width: 100%;
	height: 250px;
	object-fit: cover;
	border-radius: 12px;
	box-shadow: 0 6px 18px rgba(0,0,0,0.12);
}

.category-card {
	border: none;
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
	transition: transform 0.2s ease, box-shadow 0.2s ease;
}
.category-card:hover {
	transform: translateY(-3px);
	box-shadow: 0 12px 24px rgba(0, 0, 0, 0.12);
}
.category-image {
	height: 140px;
	width: 100%;
	object-fit: cover;
}
.carousel .banner-slide {
	border-radius: 15px;
	overflow: hidden;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
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
					<li class="nav-item"><a class="nav-link active"
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
                                class="btn btn-outline-light"> <i class="fas fa-user"></i>
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

	<!-- Hero Banner Carousel -->
	<section class="py-0">
		<div id="newBannerCarousel" class="carousel slide"
			data-bs-ride="carousel" data-bs-interval="4000">
            
			<div class="carousel-inner">
				<div class="carousel-item active">
					<div class="banner-slide"
						style="background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), url('${pageContext.request.contextPath}/images/banner1.jpg'); background-size: cover; background-position: center; height: 500px;">
						<div class="container h-100">
							<div class="row align-items-center h-100 text-center">
								<div class="col-12">
									<h1 class="display-4 text-white mb-4">Chào mừng đến với
										Fast Food</h1>
									<p class="lead text-white mb-4">Thưởng thức các món ăn
										nhanh ngon miệng với giá cả phải chăng</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="carousel-item">
					<div class="banner-slide"
						style="background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), url('${pageContext.request.contextPath}/images/banner2.jpg'); background-size: cover; background-position: center; height: 500px;">
						<div class="container h-100">
							<div class="row align-items-center h-100 text-center">
								<div class="col-12">
									<h1 class="display-4 text-white mb-4">Chào mừng đến với
										Fast Food</h1>
									<p class="lead text-white mb-4">Thưởng thức các món ăn
										nhanh ngon miệng với giá cả phải chăng</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="carousel-item">
					<div class="banner-slide"
						style="background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), url('${pageContext.request.contextPath}/images/banner3.jpg'); background-size: cover; background-position: center; height: 500px;">
						<div class="container h-100">
							<div class="row align-items-center h-100 text-center">
								<div class="col-12">
									<h1 class="display-4 text-white mb-4">Chào mừng đến với
										Fast Food</h1>
									<p class="lead text-white mb-4">Thưởng thức các món ăn
										nhanh ngon miệng với giá cả phải chăng</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</section>

	<!-- Featured Products -->
	<section id="featured" class="py-5 bg-white">
		<div class="container">
			<div class="text-center mb-5">
				<h2 class="mb-3">Sản phẩm nổi bật</h2>
				<p class="text-muted">Những món ăn được yêu thích nhất tại Fast
					Food</p>
				<div class="section-divider"></div>
			</div>
			<div class="row">
				<c:forEach var="product" items="${featuredProducts}">
					<div class="col-lg-3 col-md-6 mb-4">
						<div class="card product-card h-100">
							<div class="product-image-wrapper">
								<c:choose>
									<c:when
										test="${not empty product.hinhAnh && (fn:startsWith(product.hinhAnh, 'http://') || fn:startsWith(product.hinhAnh, 'https://'))}">
										<img src="${product.hinhAnh}"
											class="card-img-top product-image" alt="${product.ten}">
									</c:when>
									<c:otherwise>
										<img
											src="${pageContext.request.contextPath}/${product.hinhAnh}"
											class="card-img-top product-image" alt="${product.ten}">
									</c:otherwise>
								</c:choose>
								<div class="product-overlay">
									<div class="product-actions">
										<a
											href="${pageContext.request.contextPath}/product?id=${product.id}"
											class="btn btn-light btn-sm"> <i class="fas fa-eye"></i>
										</a> <a
											href="${pageContext.request.contextPath}/cart/add?productId=${product.id}&quantity=1"
											class="btn btn-primary btn-sm"> <i
											class="fas fa-cart-plus"></i>
										</a>
									</div>
								</div>
								<div class="product-badge">
									<span class="badge bg-warning">Nổi bật</span>
								</div>
							</div>
							<div class="card-body text-center">
								<h5 class="card-title product-name">${product.ten}</h5>

								<!-- Star Rating -->
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
									<span class="rating-text"> <c:choose>
											<c:when test="${product.reviewCount > 0}">
												<fmt:formatNumber value="${product.averageRating}"
													maxFractionDigits="1" /> 
                                                (${product.reviewCount})
                                            </c:when>
											<c:otherwise>
                                                Chưa có đánh giá
                                            </c:otherwise>
										</c:choose>
									</span>
								</div>

                                <c:choose>
                                    <c:when test="${not empty product.discountPrice and product.discountPrice gt 0}">
                                        <p class="product-price">
                                            <fmt:formatNumber value="${product.discountPrice}" type="number" groupingUsed="true" /> đ
                                        </p>
                                        <p class="mb-2">
                                            <small class="text-muted text-decoration-line-through">
                                                <fmt:formatNumber value="${product.gia}" type="number" groupingUsed="true" /> đ
                                            </small>
                                        </p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="product-price">
                                            <fmt:formatNumber value="${product.gia}" type="number" groupingUsed="true" /> đ
                                        </p>
                                    </c:otherwise>
                                </c:choose>
								<a
									href="${pageContext.request.contextPath}/cart/add?productId=${product.id}&quantity=1"
									class="btn btn-primary btn-add-cart"> <i
									class="fas fa-cart-plus me-2"></i>Thêm vào giỏ
								</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="text-center mt-4">
				<a href="${pageContext.request.contextPath}/products"
					class="btn btn-outline-primary btn-lg"> Xem tất cả sản phẩm <i
					class="fas fa-arrow-right ms-2"></i>
				</a>
			</div>
		</div>
	</section>

	<c:if test="${not empty categories}">
	<section id="categories" class="py-5 bg-light">
		<div class="container">
			<div class="text-center mb-5">
				<h2 class="mb-3">Danh mục</h2>
				<p class="text-muted">Khám phá theo danh mục</p>
				<div class="section-divider"></div>
			</div>
            <div class="row">
                <c:forEach var="cat" items="${categories}">
                    <c:set var="fallbackImg"
                           value="${fn:contains(fn:toLowerCase(cat.name),'combo') ? pageContext.request.contextPath.concat('/images/combo1.jpg') : (fn:contains(fn:toLowerCase(cat.name),'đặc') or fn:contains(fn:toLowerCase(cat.name),'dac') or fn:contains(fn:toLowerCase(cat.name),'special')) ? pageContext.request.contextPath.concat('/images/cheeseburger.jpg') : pageContext.request.contextPath.concat('/images/bacon_burger.jpg')}" />
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6 mb-4">
                        <div class="card category-card h-100">
                            <c:set var="img" value="${cat.imageUrl}" />
                            <c:choose>
                                <c:when test="${not empty img && (fn:startsWith(img, 'http://') || fn:startsWith(img, 'https://') || fn:startsWith(img, 'data:'))}">
                                    <img src="${img}" alt="${cat.name}" class="category-image" onerror="this.onerror=null;this.src='${fallbackImg}'">
                                </c:when>
                                <c:when test="${not empty img && fn:startsWith(img, '//')}">
                                    <img src="https:${img}" alt="${cat.name}" class="category-image" onerror="this.onerror=null;this.src='${fallbackImg}'">
                                </c:when>
                                <c:when test="${not empty img && fn:startsWith(img, pageContext.request.contextPath)}">
                                    <img src="${img}" alt="${cat.name}" class="category-image" onerror="this.onerror=null;this.src='${fallbackImg}'">
                                </c:when>
                                <c:when test="${not empty img && fn:startsWith(img, '/')}">
                                    <img src="${pageContext.request.contextPath}${img}" alt="${cat.name}" class="category-image" onerror="this.onerror=null;this.src='${fallbackImg}'">
                                </c:when>
                                <c:when test="${not empty img}">
                                    <img src="${pageContext.request.contextPath}/${img}" alt="${cat.name}" class="category-image" onerror="this.onerror=null;this.src='${fallbackImg}'">
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${fn:contains(fn:toLowerCase(cat.name), 'combo')}">
                                            <img src="${pageContext.request.contextPath}/images/combo1.jpg" alt="${cat.name}" class="category-image">
                                        </c:when>
                                        <c:when test="${fn:contains(fn:toLowerCase(cat.name), 'đặc') || fn:contains(fn:toLowerCase(cat.name), 'dac') || fn:contains(fn:toLowerCase(cat.name), 'special')}">
                                            <img src="${pageContext.request.contextPath}/images/cheeseburger.jpg" alt="${cat.name}" class="category-image">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/images/bacon_burger.jpg" alt="${cat.name}" class="category-image">
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                            <div class="card-body text-center">
                                <h6 class="mb-2">${cat.name}</h6>
                                <a href="${pageContext.request.contextPath}/products?categoryId=${cat.id}" class="btn btn-outline-primary btn-sm">Xem sản phẩm</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
		</div>
	</section>
	</c:if>

	<!-- Banner Carousel -->
	<section class="py-0">
		<div id="bannerCarousel" class="carousel slide"
			data-bs-ride="carousel" data-bs-interval="4000">
		    
			<c:set var="comboImage" value="" />
			<c:set var="specialImage" value="" />
			<c:forEach var="cat" items="${categories}">
				<c:if test="${empty comboImage && fn:contains(fn:toLowerCase(cat.name), 'combo') && not empty cat.imageUrl}">
					<c:set var="comboImage" value="${cat.imageUrl}" />
				</c:if>
				<c:if test="${empty specialImage && (fn:contains(fn:toLowerCase(cat.name), 'đặc') || fn:contains(fn:toLowerCase(cat.name), 'dac') || fn:contains(fn:toLowerCase(cat.name), 'special')) && not empty cat.imageUrl}">
					<c:set var="specialImage" value="${cat.imageUrl}" />
				</c:if>
			</c:forEach>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<div class="banner-slide banner-1">
						<div class="container">
							<div class="row align-items-center">
								<div class="col-md-6">
									<h2 class="banner-title">Combo Đặc Biệt</h2>
									<p class="banner-text">Giảm giá 30% cho tất cả combo trong
										tuần này!</p>
					<a href="${pageContext.request.contextPath}/products"
						class="btn btn-warning btn-lg">Đặt ngay</a>
				</div>
				<div class="col-md-6 text-center">
					<i class="fas fa-hamburger banner-icon"></i>
				</div>
				</div>
				</div>
			</div>
				</div>
				<div class="carousel-item">
					<div class="banner-slide banner-2">
						<div class="container">
							<div class="row align-items-center">
								<div class="col-md-6">
									<h2 class="banner-title">Giao Hàng Miễn Phí</h2>
									<p class="banner-text">Miễn phí giao hàng cho đơn hàng từ
										200.000đ</p>
									<a href="${pageContext.request.contextPath}/products"
										class="btn btn-success btn-lg">Xem menu</a>
								</div>
								<div class="col-md-6 text-center">
									<i class="fas fa-shipping-fast banner-icon"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="carousel-item">
					<div class="banner-slide banner-3">
						<div class="container">
							<div class="row align-items-center">
								<div class="col-md-6">
									<h2 class="banner-title">Thành Viên VIP</h2>
									<p class="banner-text">Đăng ký thành viên để nhận ưu đãi
										độc quyền</p>
									<a href="${pageContext.request.contextPath}/register"
										class="btn btn-primary btn-lg">Đăng ký</a>
								</div>
					<div class="col-md-6 text-center">
						<i class="fas fa-crown banner-icon"></i>
					</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</section>

    <!-- Services Section -->
	<section class="py-5 bg-light">
		<div class="container">
			<div class="text-center mb-5">
				<h2 class="mb-3">Tại sao chọn chúng tôi?</h2>
				<p class="text-muted">Những dịch vụ tuyệt vời mà chúng tôi mang
					đến</p>
			</div>
			<div class="row">
				<div class="col-md-4 mb-4">
					<div class="service-card text-center">
						<div class="service-icon">
							<i class="fas fa-clock"></i>
						</div>
						<h4>Giao hàng nhanh</h4>
						<p class="text-muted">Giao hàng trong vòng 30 phút tại khu vực
							nội thành</p>
					</div>
				</div>
				<div class="col-md-4 mb-4">
					<div class="service-card text-center">
						<div class="service-icon">
							<i class="fas fa-shield-alt"></i>
						</div>
						<h4>Chất lượng đảm bảo</h4>
						<p class="text-muted">Nguyên liệu tươi ngon, quy trình chế
							biến nghiêm ngặt</p>
					</div>
				</div>
				<div class="col-md-4 mb-4">
					<div class="service-card text-center">
						<div class="service-icon">
							<i class="fas fa-headset"></i>
						</div>
						<h4>Hỗ trợ 24/7</h4>
						<p class="text-muted">Đội ngũ chăm sóc khách hàng luôn sẵn
							sàng hỗ trợ</p>
					</div>
				</div>
			</div>
        </div>
    </section>

    <!-- Customer Support -->
    <section class="py-5 bg-white">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="mb-3">Chăm sóc khách hàng</h2>
                <p class="text-muted">Hỗ trợ nhanh chóng, tận tâm 24/7</p>
                <div class="section-divider"></div>
            </div>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="service-card text-center">
                        <div class="service-icon"><i class="fas fa-headset"></i></div>
                        <h4>Hotline</h4>
                        <p class="text-muted">Gọi ngay: 1900-1234 (24/7)</p>
                        <a href="tel:19001234" class="btn btn-primary">Gọi hỗ trợ</a>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="service-card text-center">
                        <div class="service-icon"><i class="fas fa-comments"></i></div>
                        <h4>Trò chuyện trực tuyến</h4>
                        <p class="text-muted">Kết nối ngay với CSKH</p>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#supportModal">Mở chat</button>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="service-card text-center">
                        <div class="service-icon"><i class="fas fa-envelope"></i></div>
                        <h4>Email</h4>
                        <p class="text-muted">cskh@fastfood.vn</p>
                        <a href="mailto:cskh@fastfood.vn" class="btn btn-primary">Gửi mail</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Support Modal -->
    <div class="modal fade" id="supportModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title"><i class="fas fa-comments me-2"></i>Hỗ trợ khách hàng</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <form id="supportForm" method="post" action="${pageContext.request.contextPath}/contact">
              <div class="mb-3">
                <label class="form-label">Nội dung</label>
                <textarea class="form-control" name="message" rows="4" placeholder="Mô tả vấn đề của bạn..."></textarea>
              </div>
              <div class="text-end">
                <button type="submit" class="btn btn-primary">Gửi</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

	<!-- Statistics Section -->
	<section class="py-5">
		<div class="container">
			<div class="row text-center">
				<div class="col-md-3 mb-4">
					<div class="stat-item">
						<div class="stat-number">10K+</div>
						<div class="stat-label">Khách hàng hài lòng</div>
					</div>
				</div>
				<div class="col-md-3 mb-4">
					<div class="stat-item">
						<div class="stat-number">50+</div>
						<div class="stat-label">Món ăn đa dạng</div>
					</div>
				</div>
				<div class="col-md-3 mb-4">
					<div class="stat-item">
						<div class="stat-number">5</div>
						<div class="stat-label">Năm kinh nghiệm</div>
					</div>
				</div>
				<div class="col-md-3 mb-4">
					<div class="stat-item">
						<div class="stat-number">24/7</div>
						<div class="stat-label">Phục vụ không ngừng</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Testimonials Section -->
	<section class="py-5 bg-light">
		<div class="container">
			<div class="text-center mb-5">
				<h2 class="mb-3">Khách hàng nói gì về chúng tôi</h2>
				<p class="text-muted">Những phản hồi tích cực từ khách hàng</p>
			</div>
			<div class="row">
				<div class="col-md-4 mb-4">
					<div class="testimonial-card">
						<div class="testimonial-content">
							<p>"Đồ ăn ngon, giao hàng nhanh. Tôi rất hài lòng với dịch vụ
								của Fast Food!"</p>
						</div>
						<div class="testimonial-author">
							<div class="author-avatar">
								<i class="fas fa-user"></i>
							</div>
							<div class="author-info">
								<h6>Nguyễn Văn A</h6>
								<small class="text-muted">Khách hàng thân thiết</small>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4 mb-4">
					<div class="testimonial-card">
						<div class="testimonial-content">
							<p>"Chất lượng món ăn luôn đảm bảo, giá cả hợp lý. Sẽ tiếp
								tục ủng hộ!"</p>
						</div>
						<div class="testimonial-author">
							<div class="author-avatar">
								<i class="fas fa-user"></i>
							</div>
							<div class="author-info">
								<h6>Trần Thị B</h6>
								<small class="text-muted">Khách hàng VIP</small>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4 mb-4">
					<div class="testimonial-card">
						<div class="testimonial-content">
							<p>"Dịch vụ chăm sóc khách hàng tuyệt vời, nhân viên rất
								nhiệt tình!"</p>
						</div>
						<div class="testimonial-author">
							<div class="author-avatar">
								<i class="fas fa-user"></i>
							</div>
							<div class="author-info">
								<h6>Lê Văn C</h6>
								<small class="text-muted">Khách hàng mới</small>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

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
							<i class="fas fa-map-marker-alt"></i> Ngõ 39, Đường Hồ Tùng Mậu,
							Mai Dịch, Cầu Giấy, Hà Nội
						</p>
						<p>
							<i class="fas fa-phone"></i>(0966) 035-418
						</p>
						<p>
							<i class="fas fa-envelope"></i> minhtuan2472005@gmail.com
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

    <jsp:include page="/WEB-INF/views/includes/chat-widget.jsp" />
</body>
</html>
