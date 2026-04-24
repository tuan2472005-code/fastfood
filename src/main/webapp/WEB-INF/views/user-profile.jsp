<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Thông tin cá nhân - Fast Food</title>
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

.profile-container {
	background: white;
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	padding: 2rem;
	margin-bottom: 2rem;
}

.profile-header {
	background: linear-gradient(135deg,#ff6b35 100%);
	color: white;
	border-radius: 15px;
	padding: 2rem;
	text-align: center;
	margin-bottom: 2rem;
}

.profile-avatar {
	width: 100px;
	height: 100px;
	background: rgba(255, 255, 255, 0.2);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto 1rem;
}

.form-control:focus {
	border-color: #667eea;
	box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
}

.btn-primary {
	background: linear-gradient(135deg, #ff6b35 100%);
	border: none;
	border-radius: 10px;
	padding: 12px 30px;
	font-weight: 600;
}

.btn-primary:hover {
	background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
}

.info-card {
	background: #f8f9fa;
	border-radius: 10px;
	padding: 1.5rem;
	margin-bottom: 1rem;
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
        font-size: 1.5rem !important;
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
                                            <i class="fas fa-user-circle me-2 avatar-icon"
                                                style="font-size: 24px;"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <span style="font-weight: 500;">${sessionScope.user.fullName}</span>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item active"
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
			<div class="col-md-8 mx-auto">
				<!-- Profile Header -->
				<div class="profile-header">
					<div class="profile-avatar">
						<c:choose>
							<c:when test="${not empty sessionScope.user.avatar}">
								<img
									src="${pageContext.request.contextPath}/${sessionScope.user.avatar}"
									alt="Avatar" class="rounded-circle"
									style="width: 100px; height: 100px; object-fit: cover;">
							</c:when>
							<c:otherwise>
								<i class="fas fa-user fa-3x"></i>
							</c:otherwise>
						</c:choose>
					</div>
					<h3 class="mb-1">${sessionScope.user.fullName}</h3>
					<p class="mb-0 opacity-75">${sessionScope.user.email}</p>

					<!-- Avatar Upload Button -->
					<button type="button" class="btn btn-light btn-sm mt-2"
						data-bs-toggle="modal" data-bs-target="#avatarModal">
						<i class="fas fa-camera me-1"></i>Thay đổi ảnh đại diện
					</button>
				</div>

				<!-- Success/Error Messages -->
				<c:if test="${not empty success}">
					<div class="alert alert-success alert-dismissible fade show">
						<i class="fas fa-check-circle me-2"></i>${success}
						<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
					</div>
				</c:if>
				<c:if test="${not empty error}">
					<div class="alert alert-danger alert-dismissible fade show">
						<i class="fas fa-exclamation-circle me-2"></i>${error}
						<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
					</div>
				</c:if>

				<!-- Profile Information -->
				<div class="profile-container">
					<h5 class="mb-4">
						<i class="fas fa-edit me-2 text-primary"></i>Thông tin cá nhân
					</h5>

					<form method="post"
						action="${pageContext.request.contextPath}/user/profile">
						<input type="hidden" name="action" value="updateProfile">
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="fullName" class="form-label">Họ và tên <span
									class="text-danger">*</span></label> <input type="text"
									class="form-control" id="fullName" name="fullName"
									value="${sessionScope.user.fullName}" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="email" class="form-label">Email <span
									class="text-danger">*</span></label> <input type="email"
									class="form-control" id="email" name="email"
									value="${sessionScope.user.email}" required readonly> <small
									class="text-muted">Email không thể thay đổi</small>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="phone" class="form-label">Số điện thoại</label> <input
									type="tel" class="form-control" id="phone" name="phone"
									value="${sessionScope.user.phone}">
							</div>
							<div class="col-md-6 mb-3">
								<label for="username" class="form-label">Tên đăng nhập</label> <input
									type="text" class="form-control" id="username" name="username"
									value="${sessionScope.user.username}" readonly> <small
									class="text-muted">Tên đăng nhập không thể thay đổi</small>
							</div>
						</div>

						<div class="mb-3">
							<label for="address" class="form-label">Địa chỉ</label>
							<textarea class="form-control" id="address" name="address"
								rows="3">${sessionScope.user.address}</textarea>
						</div>

						<div class="text-center mt-4">
							<button type="submit" class="btn btn-primary me-2">
								<i class="fas fa-save me-2"></i>Cập nhật thông tin
							</button>
							<a href="${pageContext.request.contextPath}/"
								class="btn btn-outline-secondary"> <i
								class="fas fa-arrow-left me-2"></i>Quay lại
							</a>
						</div>
					</form>

					<!-- Password Change Form -->
					<div class="profile-container mt-4">
						<h5 class="mb-4">
							<i class="fas fa-lock me-2 text-primary"></i>Đổi mật khẩu
						</h5>

						<form method="post"
							action="${pageContext.request.contextPath}/user/profile">
							<input type="hidden" name="action" value="changePassword">
							<div class="row">
								<div class="col-md-4 mb-3">
									<label for="currentPassword" class="form-label">Mật
										khẩu hiện tại</label> <input type="password" class="form-control"
										id="currentPassword" name="currentPassword" required>
								</div>
								<div class="col-md-4 mb-3">
									<label for="newPassword" class="form-label">Mật khẩu
										mới</label> <input type="password" class="form-control"
										id="newPassword" name="newPassword" required>
								</div>
								<div class="col-md-4 mb-3">
									<label for="confirmPassword" class="form-label">Xác
										nhận mật khẩu</label> <input type="password" class="form-control"
										id="confirmPassword" name="confirmPassword" required>
								</div>
							</div>

							<div class="text-center mt-3">
								<button type="submit" class="btn btn-warning">
									<i class="fas fa-key me-2"></i>Đổi mật khẩu
								</button>
							</div>
						</form>
					</div>
				</div>

				<!-- Account Information -->
				<div class="profile-container">
					<h5 class="mb-4">
						<i class="fas fa-info-circle me-2 text-primary"></i>Thông tin tài
						khoản
					</h5>

					<div class="row">
						<div class="col-md-6">
							<div class="info-card">
								<h6>
									<i class="fas fa-calendar-alt me-2"></i>Ngày tham gia
								</h6>
								<p class="mb-0">${sessionScope.user.createdAt}</p>
							</div>
						</div>
						<div class="col-md-6">
							<div class="info-card">
								<h6>
									<i class="fas fa-shield-alt me-2"></i>Trạng thái tài khoản
								</h6>
								<span class="badge bg-success">Đã kích hoạt</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Avatar Upload Modal -->
	<div class="modal fade" id="avatarModal" tabindex="-1"
		aria-labelledby="avatarModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="avatarModalLabel">
						<i class="fas fa-camera me-2"></i>Thay đổi ảnh đại diện
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<form action="${pageContext.request.contextPath}/user/profile"
					method="post" enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" name="action" value="uploadAvatar">

						<div class="text-center mb-3">
							<div class="current-avatar mb-3">
								<c:choose>
									<c:when test="${not empty sessionScope.user.avatar}">
										<img
											src="${pageContext.request.contextPath}/${sessionScope.user.avatar}"
											alt="Current Avatar" class="rounded-circle"
											style="width: 80px; height: 80px; object-fit: cover;">
									</c:when>
									<c:otherwise>
										<div
											class="bg-light rounded-circle d-inline-flex align-items-center justify-content-center"
											style="width: 80px; height: 80px;">
											<i class="fas fa-user fa-2x text-muted"></i>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
							<p class="text-muted small">Ảnh hiện tại</p>
						</div>

						<div class="mb-3">
							<label for="avatar" class="form-label">Chọn ảnh mới</label> <input
								type="file" class="form-control" id="avatar" name="avatar"
								accept="image/*" required>
							<div class="form-text">Chấp nhận file ảnh (JPG, PNG, GIF).
								Kích thước tối đa: 5MB</div>
						</div>

						<div id="imagePreview" class="text-center" style="display: none;">
							<p class="text-muted small mb-2">Xem trước:</p>
							<img id="previewImg" class="rounded-circle"
								style="width: 80px; height: 80px; object-fit: cover;">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-primary">
							<i class="fas fa-upload me-1"></i>Cập nhật ảnh đại diện
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        // Validate password confirmation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = this.value;
            
            if (newPassword && confirmPassword && newPassword !== confirmPassword) {
                this.setCustomValidity('Mật khẩu xác nhận không khớp');
            } else {
                this.setCustomValidity('');
            }
        });
        
        // Image preview for avatar upload
        document.getElementById('avatar').addEventListener('change', function(e) {
            const file = e.target.files[0];
            const preview = document.getElementById('imagePreview');
            const previewImg = document.getElementById('previewImg');
            
            if (file) {
                // Check file type
                if (!file.type.startsWith('image/')) {
                    alert('Vui lòng chọn file ảnh hợp lệ');
                    this.value = '';
                    preview.style.display = 'none';
                    return;
                }
                
                // Check file size (5MB)
                if (file.size > 5 * 1024 * 1024) {
                    alert('Kích thước file không được vượt quá 5MB');
                    this.value = '';
                    preview.style.display = 'none';
                    return;
                }
                
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    preview.style.display = 'block';
                };
                reader.readAsDataURL(file);
            } else {
                preview.style.display = 'none';
            }
        });
    </script>
</body>
</html>
