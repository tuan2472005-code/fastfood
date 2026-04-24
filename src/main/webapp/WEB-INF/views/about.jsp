<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Giới thiệu - Fast Food</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
.hero-section {
	background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
		url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 600"><rect fill="%23ff6b35" width="1200" height="600"/><circle fill="%23ff8c42" cx="200" cy="150" r="80"/><circle fill="%23ffa726" cx="800" cy="300" r="120"/><circle fill="%23ffb74d" cx="1000" cy="100" r="60"/></svg>');
	background-size: cover;
	background-position: center;
	color: white;
	padding: 60px 0;
	text-align: center;
}

.feature-card {
	border: none;
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease;
	height: 100%;
}

.feature-card:hover {
	transform: translateY(-5px);
}

.feature-icon {
	font-size: 3rem;
	color: #ff6b35;
	margin-bottom: 1rem;
}

.stats-section {
	background: linear-gradient(135deg, #ff6b35, #ff8c42);
	color: white;
	padding: 60px 0;
}

.stat-item {
	text-align: center;
	margin-bottom: 30px;
}

.stat-number {
	font-size: 3rem;
	font-weight: bold;
	display: block;
}

.timeline {
	position: relative;
	padding: 20px 0;
}

.timeline::before {
	content: '';
	position: absolute;
	left: 50%;
	top: 0;
	bottom: 0;
	width: 2px;
	background: #ff6b35;
	transform: translateX(-50%);
}

.timeline-item {
	position: relative;
	margin: 40px 0;
	width: 50%;
}

.timeline-item:nth-child(odd) {
	left: 0;
	padding-right: 40px;
	text-align: right;
}

.timeline-item:nth-child(even) {
	left: 50%;
	padding-left: 40px;
}

.timeline-content {
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
}

.timeline-year {
	background: #ff6b35;
	color: white;
	padding: 5px 15px;
	border-radius: 20px;
	font-weight: bold;
	display: inline-block;
	margin-bottom: 10px;
}

@media ( max-width : 768px) {
	.timeline::before {
		left: 20px;
	}
	.timeline-item {
		width: 100%;
		left: 0 !important;
		padding-left: 50px !important;
		padding-right: 0 !important;
		text-align: left !important;
	}
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

/* Enhanced Navbar Styles */
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

.navbar-nav .nav-link {
    font-weight: 500;
    margin: 0 0.5rem;
    transition: all 0.3s ease;
    border-radius: 5px;
    padding: 0.5rem 1rem !important;
}

.navbar-nav .nav-link:hover {
    background-color: rgba(255, 255, 255, 0.1) !important;
    transform: translateY(-2px) !important;
}

.navbar-nav .nav-link.active {
    background-color: rgba(255, 255, 255, 0.2) !important;
    font-weight: 600 !important;
}

.btn-outline-light {
    border: none !important;
    font-weight: 500;
    transition: all 0.3s ease;
    border-radius: 25px;
    padding: 0.5rem 1.2rem;
    box-shadow: none !important;
}

.btn-outline-light:hover {
    background-color: rgba(255, 255, 255, 0.2) !important;
    border-color: transparent !important;
    transform: translateY(-2px) !important;
    box-shadow: none !important;
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
					<li class="nav-item"><a class="nav-link active"
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

	<!-- Hero Section -->
	<section class="hero-section">
		<div class="container">
			<h1 class="display-4 fw-bold mb-4">Về Fast Food</h1>
			<p class="lead mb-4">Hành trình mang đến những món ăn nhanh chất
				lượng cao với hương vị tuyệt vời</p>
		</div>
	</section>

	<!-- About Content -->
	<section class="py-5">
		<div class="container">
			<div class="row align-items-center mb-5">
				<div class="col-lg-6">
					<h2 class="mb-4">Câu chuyện của chúng tôi</h2>
					<p class="text-muted mb-4">Fast Food được thành lập với sứ mệnh
						mang đến những món ăn nhanh chất lượng cao, tươi ngon và an toàn
						cho sức khỏe. Chúng tôi tin rằng thức ăn nhanh không có nghĩa là
						phải hy sinh chất lượng hay hương vị.</p>
					<p class="text-muted mb-4">Với đội ngũ đầu bếp giàu kinh nghiệm
						và nguyên liệu tươi ngon được chọn lọc kỹ càng, chúng tôi cam kết
						mang đến cho khách hàng những trải nghiệm ẩm thực tuyệt vời nhất.
					</p>
				</div>
				<div class="col-lg-6">
					<div class="text-center">
						<svg width="400" height="300" viewBox="0 0 400 300"
							xmlns="http://www.w3.org/2000/svg">
                            <rect fill="#ff6b35" width="400"
								height="300" rx="20" />
                            <circle fill="#fff" cx="200" cy="150" r="80"
								opacity="0.9" />
                            <path fill="#ff8c42"
								d="M160 130 L240 130 L240 170 L160 170 Z" />
                            <circle fill="#ffa726" cx="180" cy="150"
								r="15" />
                            <circle fill="#ffa726" cx="220" cy="150"
								r="15" />
                            <text x="200" y="200" text-anchor="middle"
								fill="#fff" font-size="16" font-weight="bold">Fast Food</text>
                        </svg>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Features Section -->
	<section class="py-5 bg-light">
		<div class="container">
			<div class="text-center mb-5">
				<h2 class="mb-3">Tại sao chọn chúng tôi?</h2>
				<p class="text-muted">Những giá trị cốt lõi làm nên sự khác biệt
					của Fast Food</p>
			</div>
			<div class="row">
				<div class="col-md-4 mb-4">
					<div class="card feature-card text-center p-4">
						<div class="feature-icon">
							<i class="fas fa-clock"></i>
						</div>
						<h5 class="card-title">Giao hàng nhanh</h5>
						<p class="card-text text-muted">Cam kết giao hàng trong vòng
							30 phút với hệ thống logistics hiện đại</p>
					</div>
				</div>
				<div class="col-md-4 mb-4">
					<div class="card feature-card text-center p-4">
						<div class="feature-icon">
							<i class="fas fa-leaf"></i>
						</div>
						<h5 class="card-title">Nguyên liệu tươi ngon</h5>
						<p class="card-text text-muted">Sử dụng 100% nguyên liệu tươi
							ngon, được chọn lọc kỹ càng từ các nhà cung cấp uy tín</p>
					</div>
				</div>
				<div class="col-md-4 mb-4">
					<div class="card feature-card text-center p-4">
						<div class="feature-icon">
							<i class="fas fa-heart"></i>
						</div>
						<h5 class="card-title">Phục vụ tận tâm</h5>
						<p class="card-text text-muted">Đội ngũ nhân viên được đào tạo
							chuyên nghiệp, luôn sẵn sàng phục vụ khách hàng</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Stats Section -->
	<section class="stats-section">
		<div class="container">
			<div class="row">
				<div class="col-md-3">
					<div class="stat-item">
						<span class="stat-number">10K+</span> <span>Khách hàng hài
							lòng</span>
					</div>
				</div>
				<div class="col-md-3">
					<div class="stat-item">
						<span class="stat-number">50+</span> <span>Món ăn đa dạng</span>
					</div>
				</div>
				<div class="col-md-3">
					<div class="stat-item">
						<span class="stat-number">5</span> <span>Năm kinh nghiệm</span>
					</div>
				</div>
				<div class="col-md-3">
					<div class="stat-item">
						<span class="stat-number">24/7</span> <span>Phục vụ không
							ngừng</span>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Timeline Section -->
	<section class="py-5">
		<div class="container">
			<div class="text-center mb-5">
				<h2 class="mb-3">Hành trình phát triển</h2>
				<p class="text-muted">Những cột mốc quan trọng trong quá trình
					phát triển của Fast Food</p>
			</div>
			<div class="timeline">
				<div class="timeline-item">
					<div class="timeline-content">
						<div class="timeline-year">2019</div>
						<h5>Khởi nghiệp</h5>
						<p class="text-muted">Thành lập cửa hàng đầu tiên với 5 món ăn
							cơ bản</p>
					</div>
				</div>
				<div class="timeline-item">
					<div class="timeline-content">
						<div class="timeline-year">2020</div>
						<h5>Mở rộng menu</h5>
						<p class="text-muted">Bổ sung thêm 20 món ăn mới và dịch vụ
							giao hàng</p>
					</div>
				</div>
				<div class="timeline-item">
					<div class="timeline-content">
						<div class="timeline-year">2021</div>
						<h5>Ứng dụng di động</h5>
						<p class="text-muted">Ra mắt ứng dụng đặt hàng trực tuyến</p>
					</div>
				</div>
				<div class="timeline-item">
					<div class="timeline-content">
						<div class="timeline-year">2022</div>
						<h5>Mở chi nhánh</h5>
						<p class="text-muted">Mở thêm 3 chi nhánh mới tại các quận
							trung tâm</p>
					</div>
				</div>
				<div class="timeline-item">
					<div class="timeline-content">
						<div class="timeline-year">2024</div>
						<h5>Hiện tại</h5>
						<p class="text-muted">Phục vụ hơn 10,000 khách hàng với 50+
							món ăn đa dạng</p>
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
