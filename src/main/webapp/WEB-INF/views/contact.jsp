<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="vi">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Liên hệ - Fast Food</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
.hero-section {
	background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
		url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 600"><rect fill="%23ff6b35" width="1200" height="600"/><circle fill="%23ff8c42" cx="300" cy="200" r="100"/><circle fill="%23ffa726" cx="900" cy="400" r="150"/><circle fill="%23ffb74d" cx="600" cy="100" r="80"/></svg>');
	background-size: cover;
	background-position: center;
	color: white;
	padding: 60px 0;
	text-align: center;
}

.contact-card {
	border: none;
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease;
	height: 100%;
}

.contact-card:hover {
	transform: translateY(-5px);
}

.contact-icon {
	font-size: 2.5rem;
	color: #ff6b35;
	margin-bottom: 1rem;
}

.form-control:focus {
	border-color: #ff6b35;
	box-shadow: 0 0 0 0.2rem rgba(255, 107, 53, 0.25);
}

.btn-primary {
	background: linear-gradient(135deg, #ff6b35 100%);
	border: none;
	border-radius: 10px;
	padding: 12px 30px;
	font-weight: 600;
}

.btn-primary:hover {
	background: linear-gradient(135deg, #e55a2b 100%);
}

.map-container {
	border-radius: 15px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.contact-info {
	background: linear-gradient(135deg, #ff6b35, #ff8c42);
	color: white;
	border-radius: 15px;
	padding: 2rem;
}

.contact-info h4 {
	margin-bottom: 1.5rem;
}

.contact-info .contact-item {
	display: flex;
	align-items: center;
	margin-bottom: 1rem;
}

.contact-info .contact-item i {
	font-size: 1.2rem;
	margin-right: 1rem;
	width: 20px;
}

.alert {
	border-radius: 10px;
	border: none;
}

.alert-success {
	background-color: #d4edda;
	color: #155724;
}

.alert-danger {
	background-color: #f8d7da;
	color: #721c24;
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
	background: #e55a2b !important ;
    transform: translateY(-2px) !important;
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

/* Header Styling */
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

.navbar-nav .nav-link {
    font-weight: 500;
    margin: 0 0.5rem;
    transition: all 0.3s ease;
    border-radius: 5px;
    padding: 0.5rem 1rem !important;
}

.navbar-nav .nav-link:hover {
    color: white !important;
    background-color: rgba(255, 255, 255, 0.1);
    transform: translateY(-2px);
}

.navbar-nav .nav-link.active {
    background-color: rgba(255, 255, 255, 0.2);
    font-weight: 600;
}

.btn-outline-light {
    border: none !important;
    color: white;
    font-weight: 500;
    padding: 0.5rem 1rem;
    border-radius: 25px;
    transition: all 0.3s ease;
    box-shadow: none !important;
}

.btn-outline-light:hover {
    background-color: white;
    color: #ff6b35;
    border-color: transparent !important;
    transform: translateY(-2px);
    box-shadow: none !important;
}

.notif-btn{position:relative}
.notif-badge{position:absolute;top:0;right:0;transform:translate(50%,-50%);background:#dc3545;color:#fff;border-radius:999px;font-size:.65rem;line-height:1;padding:2px 6px;min-width:18px;text-align:center}
.dropdown-menu.notifications{min-width:340px;border-radius:12px;box-shadow:0 6px 20px rgba(0,0,0,.15)}
.notifications .notif-header{padding:.5rem 1rem;font-weight:600}
.notifications .notif-item{display:flex;align-items:flex-start;gap:.5rem;padding:.5rem 1rem}
.notifications .notif-item i{color:#ff6b35}
.notifications .notif-empty{padding:.75rem 1rem;color:#6c757d}
.notifications .notif-item + .notif-item{border-top:1px solid #eee}
.notifications .notif-thumb{width:28px;height:28px;border-radius:6px;object-fit:cover;border:1px solid #eee}

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
    .navbar-nav .nav-link {
        text-align: left !important;
        margin: 0.25rem 0;
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
					<li class="nav-item"><a class="nav-link active"
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

	<!-- Hero Section -->
	<section class="hero-section">
		<div class="container">
			<h1 class="display-4 fw-bold mb-4">Liên hệ với chúng tôi</h1>
			<p class="lead mb-4">Chúng tôi luôn sẵn sàng lắng nghe và hỗ trợ
				bạn</p>
		</div>
	</section>

	<!-- Contact Info Cards -->
	<section class="py-5">
		<div class="container">
			<div class="row mb-5">
				<div class="col-md-4 mb-4">
					<div class="card contact-card text-center p-4">
						<div class="contact-icon">
							<i class="fas fa-map-marker-alt"></i>
						</div>
						<h5 class="card-title">Địa chỉ</h5>
						<p class="card-text text-muted">
							Ngõ 39, Hồ Tùng Mậu<br> Mai Dịch, Cầu Giấy, Hà Nội
						</p>
					</div>
				</div>
				<div class="col-md-4 mb-4">
					<div class="card contact-card text-center p-4">
						<div class="contact-icon">
							<i class="fas fa-phone"></i>
						</div>
						<h5 class="card-title">Điện thoại</h5>
						<p class="card-text text-muted">
							Hotline: 0966035418<br> Hỗ trợ 24/7
						</p>
					</div>
				</div>
				<div class="col-md-4 mb-4">
					<div class="card contact-card text-center p-4">
						<div class="contact-icon">
							<i class="fas fa-envelope"></i>
						</div>
						<h5 class="card-title">Email</h5>
						<p class="card-text text-muted">
							tuan2472005@gmail.com<br> Phản hồi nhanh chóng
						</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Contact Form & Info -->
	<section class="py-5 bg-light">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 mb-4">
					<div class="card border-0 shadow-sm">
						<div class="card-body p-5">
							<h3 class="mb-4">Gửi tin nhắn cho chúng tôi</h3>

							<!-- Success/Error Messages -->
							<c:if test="${not empty success}">
								<div class="alert alert-success" role="alert">
									<i class="fas fa-check-circle me-2"></i>${success}
								</div>
							</c:if>

							<c:if test="${not empty error}">
								<div class="alert alert-danger" role="alert">
									<i class="fas fa-exclamation-circle me-2"></i>${error}
								</div>
							</c:if>

                            <c:choose>
                                <c:when test="${empty sessionScope.user}">
                                    <div class="alert alert-warning" role="alert">
                                        <i class="fas fa-exclamation-circle me-2"></i> Vui lòng đăng nhập để gửi phản hồi.
                                    </div>
                                    <a class="btn btn-primary btn-lg"
                                       href="${pageContext.request.contextPath}/login?redirect=/contact">
                                       <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <form method="post"
                                        action="${pageContext.request.contextPath}/contact">
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="name" class="form-label">Họ và tên <span
                                                    class="text-danger">*</span></label> <input type="text"
                                                    class="form-control" id="name" name="name" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="email" class="form-label">Email <span
                                                    class="text-danger">*</span></label> <input type="email"
                                                    class="form-control" id="email" name="email" required>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="phone" class="form-label">Số điện thoại</label> <input
                                                    type="tel" class="form-control" id="phone" name="phone">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="subject" class="form-label">Chủ đề <span
                                                    class="text-danger">*</span></label> <select class="form-control"
                                                    id="subject" name="subject" required>
                                                    <option value="">Chọn chủ đề</option>
                                                    <option value="Góp ý về sản phẩm">Góp ý về sản phẩm</option>
                                                    <option value="Khiếu nại dịch vụ">Khiếu nại dịch vụ</option>
                                                    <option value="Hỗ trợ đặt hàng">Hỗ trợ đặt hàng</option>
                                                    <option value="Hợp tác kinh doanh">Hợp tác kinh doanh</option>
                                                    <option value="Khác">Khác</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="message" class="form-label">Nội dung <span
                                                class="text-danger">*</span></label>
                                            <textarea class="form-control" id="message" name="message"
                                                rows="5" required
                                                placeholder="Nhập nội dung tin nhắn của bạn..."></textarea>
                                        </div>
                                        <button type="submit" class="btn btn-primary btn-lg">
                                            <i class="fas fa-paper-plane me-2"></i>Gửi tin nhắn
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
						</div>
					</div>
				</div>

				<div class="col-lg-4">
					<div class="contact-info h-100">
						<h4>Thông tin liên hệ</h4>

						<div class="contact-item">
							<i class="fas fa-clock"></i>
							<div>
								<strong>Giờ hoạt động:</strong><br> Thứ 2 - Chủ nhật: 6:00
								- 23:00
							</div>
						</div>

						<div class="contact-item">
							<i class="fas fa-shipping-fast"></i>
							<div>
								<strong>Giao hàng:</strong><br> 24/7 trong khu vực nội
								thành
							</div>
						</div>

						<div class="contact-item">
							<i class="fas fa-headset"></i>
							<div>
								<strong>Hỗ trợ khách hàng:</strong><br> 24/7 qua hotline và
								email
							</div>
						</div>

						<div class="contact-item">
							<i class="fas fa-credit-card"></i>
							<div>
								<strong>Thông tin thanh toán:</strong><br> MB Bank - NGUYEN
								MINH TUAN<br> STK: tuanne247
							</div>
						</div>

						<div class="contact-item">
							<i class="fas fa-share-alt"></i>
							<div>
								<strong>Mạng xã hội:</strong><br>
								<div class="mt-2">
									<a href="#" class="text-white me-3"><i
										class="fab fa-facebook-f"></i></a> <a href="#"
										class="text-white me-3"><i class="fab fa-instagram"></i></a> <a
										href="#" class="text-white me-3"><i class="fab fa-youtube"></i></a>
									<a href="#" class="text-white"><i class="fab fa-tiktok"></i></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Map Section -->
	<section class="py-5">
		<div class="container">
			<div class="text-center mb-5">
				<h2 class="mb-3">Vị trí cửa hàng</h2>
				<p class="text-muted">Tìm chúng tôi trên bản đồ</p>
			</div>
			<div class="map-container">
				<!-- Embedded Map (Google Maps iframe) -->
				<div
					style="width: 100%; height: 400px; background: linear-gradient(45deg, #ff6b35, #ff8c42); display: flex; align-items: center; justify-content: center; color: white; font-size: 1.2rem;">
					<div class="text-center">
						<i class="fas fa-map-marked-alt fa-3x mb-3"></i>
						<p>Bản đồ sẽ được tích hợp tại đây</p>
						<small>Ngõ 39, Hồ Tùng Mậu, Mai Dịch, Cầu Giấy, Hà Nội</small>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- FAQ Section -->
	<section class="py-5 bg-light">
		<div class="container">
			<div class="text-center mb-5">
				<h2 class="mb-3">Câu hỏi thường gặp</h2>
				<p class="text-muted">Những câu hỏi khách hàng thường quan tâm</p>
			</div>
			<div class="row justify-content-center">
				<div class="col-lg-8">
					<div class="accordion" id="faqAccordion">
						<div class="accordion-item">
							<h2 class="accordion-header" id="faq1">
								<button class="accordion-button" type="button"
									data-bs-toggle="collapse" data-bs-target="#collapse1">
									Thời gian giao hàng là bao lâu?</button>
							</h2>
							<div id="collapse1" class="accordion-collapse collapse show"
								data-bs-parent="#faqAccordion">
								<div class="accordion-body">Chúng tôi cam kết giao hàng
									trong vòng 30 phút cho khu vực nội thành và 45-60 phút cho khu
									vực ngoại thành.</div>
							</div>
						</div>

						<div class="accordion-item">
							<h2 class="accordion-header" id="faq2">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse" data-bs-target="#collapse2">
									Có những hình thức thanh toán nào?</button>
							</h2>
							<div id="collapse2" class="accordion-collapse collapse"
								data-bs-parent="#faqAccordion">
								<div class="accordion-body">Chúng tôi hỗ trợ thanh toán
									tiền mặt khi nhận hàng, chuyển khoản ngân hàng, và thanh toán
									qua ví điện tử.</div>
							</div>
						</div>

						<div class="accordion-item">
							<h2 class="accordion-header" id="faq3">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse" data-bs-target="#collapse3">
									Làm thế nào để theo dõi đơn hàng?</button>
							</h2>
							<div id="collapse3" class="accordion-collapse collapse"
								data-bs-parent="#faqAccordion">
								<div class="accordion-body">Sau khi đặt hàng thành công,
									bạn sẽ nhận được mã đơn hàng. Bạn có thể theo dõi tình trạng
									đơn hàng trong mục "Đơn hàng của tôi" hoặc liên hệ hotline.</div>
							</div>
						</div>

						<div class="accordion-item">
							<h2 class="accordion-header" id="faq4">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse" data-bs-target="#collapse4">
									Có chính sách đổi trả không?</button>
							</h2>
							<div id="collapse4" class="accordion-collapse collapse"
								data-bs-parent="#faqAccordion">
								<div class="accordion-body">Nếu sản phẩm có vấn đề về chất
									lượng hoặc không đúng yêu cầu, vui lòng liên hệ ngay với chúng
									tôi trong vòng 30 phút sau khi nhận hàng để được hỗ trợ.</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Footer -->
	<footer class="text-light py-4" style="background-color: #ff6b35;">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h5>Fast Food</h5>
					<p class="text-muted">Mang đến những món ăn nhanh chất lượng
						cao với hương vị tuyệt vời.</p>
				</div>
				<div class="col-md-6 text-md-end">
					<p class="text-muted">&copy; 2024 Fast Food. Tất cả quyền được
						bảo lưu.</p>
				</div>
			</div>
		</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<jsp:include page="/WEB-INF/views/includes/chat-widget.jsp" />
</body>
</html>
