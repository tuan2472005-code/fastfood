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
<title>Giỏ hàng - Fast Food</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
.footer {
	background-color: #ff6b35;
	color: white;
	padding: 60px 0;
	margin-top: 40px;
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
    box-shadow: none !important;
}

.avatar-icon {
	color: white !important;
	filter: drop-shadow(0 0 2px white)
		drop-shadow(0 0 4px rgba(0, 123, 255, 0.8)) !important;
}

/* Header/Navbar Styles */
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
	background-color: rgba(255, 255, 255, 0.1);
	transform: translateY(-1px);
}

.navbar-nav .nav-link.active {
	background-color: rgba(255, 255, 255, 0.2);
	font-weight: 600;
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
    transform: translateY(-2px);
    box-shadow: none !important;
    border-color: transparent !important;
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

/* Responsive */
@media ( max-width : 768px) {
    .navbar {
        padding: 10px 0 !important;
    }
    .navbar-brand {
        font-size: 1.6rem !important;
        font-weight: 800 !important;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.3) !important;
    }
    .navbar-brand video { display: none !important; }
    .navbar-nav .nav-link {
        padding: 0.4rem 0.8rem !important;
        margin: 0 0.2rem;
    }
	.user-avatar-btn {
		padding: 6px 12px !important;
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
    <c:if test="${not empty sessionScope.flashError}">
        <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1080;">
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
		<div class="toast-container position-fixed top-0 end-0 p-3"
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
    <!-- Header/Navbar (copied from home.jsp) -->
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #ff6b35;">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <video src="${pageContext.request.contextPath}/images/logofastfood.mp4" alt="Fast Food Logo" style="height: 30px; margin-right: 10px;" autoplay muted loop></video>
                Fast Food
            </a>
            <div class="mobile-actions d-flex align-items-center ms-auto d-lg-none">
                <c:set var="cartCount" value="${sessionScope.cartItems != null ? fn:length(sessionScope.cartItems) : 0}" />
                <a href="${pageContext.request.contextPath}/cart/view" class="btn btn-outline-light me-2 notif-btn active">
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
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/promotions">Khuyến mãi</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                </ul>
                <div class="d-none d-lg-flex align-items-center ms-auto">
                    <c:set var="cartCount" value="${sessionScope.cartItems != null ? fn:length(sessionScope.cartItems) : 0}" />
                    <a href="${pageContext.request.contextPath}/cart/view" class="btn btn-outline-light me-3 active notif-btn">
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
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light ms-2">
                                <i class="fas fa-user"></i> Đăng nhập
                            </a>
                        </c:when>
                        <c:otherwise>
                            <div class="dropdown ms-2">
                                <button class="btn btn-primary dropdown-toggle d-flex align-items-center user-avatar-btn" type="button" id="userDropdown" data-bs-toggle="dropdown">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user.avatar}">
                                            <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" alt="Avatar" class="rounded-circle me-2 avatar-image" style="width: 32px; height: 32px; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-user-circle me-2 avatar-icon" style="font-size: 24px;"></i>
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

	<!-- Cart Content -->
	<div class="container my-5">
		<h1 class="mb-4">Giỏ hàng của bạn</h1>

		<c:choose>
			<c:when test="${empty cart}">
				<div class="alert alert-info">
					<p>Giỏ hàng của bạn đang trống.</p>
					<a href="${pageContext.request.contextPath}/home"
						class="btn btn-primary mt-3">Tiếp tục mua sắm</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="table-responsive">
					<table class="table table-hover">
						<thead class="table-dark">
							<tr>
								<th>Sản phẩm</th>
								<th>Giá</th>
								<th>Số lượng</th>
								<th>Tổng</th>
								<th>Thao tác</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="totalAmount" value="0" />
							<c:forEach var="entry" items="${cart}">
								<c:set var="item" value="${entry.value}" />
								<tr>
									<td>
										<div class="d-flex align-items-center">
											<c:choose>
												<c:when
													test="${not empty item.product.hinhAnh && (fn:startsWith(item.product.hinhAnh, 'http://') || fn:startsWith(item.product.hinhAnh, 'https://'))}">
													<img src="${item.product.hinhAnh}"
														alt="${item.product.name}"
														style="width: 50px; height: 50px; object-fit: cover;"
														class="me-3">
												</c:when>
												<c:otherwise>
													<img
														src="${pageContext.request.contextPath}/${item.product.hinhAnh}"
														alt="${item.product.name}"
														style="width: 50px; height: 50px; object-fit: cover;"
														class="me-3">
												</c:otherwise>
											</c:choose>
											<div>
												<h6 class="mb-0">${item.product.name}</h6>
											</div>
										</div>
									</td>
									<td><fmt:formatNumber value="${item.product.price}"
											type="currency" currencySymbol="đ" maxFractionDigits="0" /></td>
									<td>
										<form action="${pageContext.request.contextPath}/cart/update"
											method="post" class="d-flex align-items-center">
											<input type="hidden" name="productId"
												value="${item.product.id}"> <input type="number"
												name="quantity" value="${item.quantity}" min="1"
												class="form-control" style="width: 70px;">
											<button type="submit"
												class="btn btn-sm btn-outline-primary ms-2">
												<i class="fas fa-sync-alt"></i>
											</button>
										</form>
									</td>
									<td><fmt:formatNumber value="${item.totalPrice}"
											type="currency" currencySymbol="đ" maxFractionDigits="0" /></td>
									<td>
										<form action="${pageContext.request.contextPath}/cart/remove"
											method="post">
											<input type="hidden" name="productId"
												value="${item.product.id}">
											<button type="submit" class="btn btn-sm btn-danger">
												<i class="fas fa-trash"></i> Xóa
											</button>
										</form>
									</td>
								</tr>
								<c:set var="totalAmount"
									value="${totalAmount + item.totalPrice}" />
							</c:forEach>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="3" class="text-end fw-bold">Tổng cộng:</td>
								<td class="fw-bold"><fmt:formatNumber
										value="${totalAmount}" type="currency" currencySymbol="đ"
										maxFractionDigits="0" /></td>
								<td></td>
							</tr>
						</tfoot>
					</table>
				</div>

                <div class="row g-2 mt-4 cart-actions">
                    <div class="col-12 col-md-auto">
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-primary w-100">
                            <i class="fas fa-arrow-left"></i> Tiếp tục mua sắm
                        </a>
                    </div>
                    <div class="col-12 col-md-auto">
                        <form action="${pageContext.request.contextPath}/cart/clear" method="post">
                            <button type="submit" class="btn btn-outline-danger w-100">
                                <i class="fas fa-trash"></i> Xóa giỏ hàng
                            </button>
                        </form>
                    </div>
                    <div class="col-12 col-md-auto">
                        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success w-100">
                            <i class="fas fa-shopping-bag"></i> Thanh toán
                        </a>
                    </div>
                </div>
			</c:otherwise>
		</c:choose>
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
</body>
</html>
