<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Khuyến mãi - Fast Food</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
.promo-hero{background:linear-gradient(135deg,#FF6B35 0%,#F7931E 100%);color:#fff;padding:60px 0}
.promo-card{border:none;border-radius:16px;overflow:hidden;box-shadow:0 8px 24px rgba(0,0,0,.08);transition:transform .2s}
.promo-card:hover{transform:translateY(-4px)}
.voucher-code{font-weight:700;font-size:1.25rem;letter-spacing:.5px}
.badge-type{border-radius:20px}
.copy-btn{border-radius:20px}
.muted-line{color:#6c757d}

.navbar{position:fixed;top:0;left:0;right:0;z-index:1030;box-shadow:0 2px 10px rgba(0,0,0,.1);transition:all .3s ease;padding:15px 0 !important;min-height:auto}
body{padding-top:76px}
.navbar-brand{font-size:1.9rem !important;font-weight:800 !important;color:#fff !important;text-shadow:2px 2px 4px rgba(0,0,0,.3) !important;transition:all .3s ease !important}
.navbar-brand:hover{transform:scale(1.05)}
.navbar-nav .nav-link{font-weight:500;margin:0 .5rem !important;transition:all .3s ease;border-radius:5px;padding:.5rem 1rem !important;letter-spacing:0 !important;word-spacing:0 !important;font-size:1rem}
.navbar-nav .nav-item{margin:0 !important;padding:0 !important}
.navbar-nav .nav-link:hover{background-color:rgba(255,255,255,.1);transform:translateY(-1px)}
.navbar-nav .nav-link.active{background-color:rgba(255,255,255,.2);font-weight:600}
.btn-outline-light{border:none !important;box-shadow:none !important;font-weight:500;transition:all .3s ease;border-radius:25px;padding:.5rem 1.2rem}
.btn-outline-light:hover{transform:translateY(-2px);box-shadow:none !important;border-color:transparent !important}
.user-avatar-btn{border-radius:25px;padding:8px 16px;box-shadow:none !important;transition:all .3s ease;border:none !important;background-color:transparent !important}
.avatar-image{border:2px solid #fff;box-shadow:0 2px 4px rgba(0,0,0,.1)}
.avatar-icon{color:#fff;filter:drop-shadow(0 0 2px #fff) drop-shadow(0 0 4px rgba(0,123,255,.8))}
.user-avatar-btn{border-radius:25px !important;padding:8px 16px !important;box-shadow:none !important;transition:all .3s ease !important;border:none !important;background-color:transparent !important}
.user-avatar-btn:hover{transform:translateY(-1px) !important;box-shadow:none !important;border-color:transparent !important}
.user-avatar-btn:active{transform:translateY(0) !important;box-shadow:none !important}
.avatar-image{border:2px solid #fff !important;box-shadow:0 2px 4px rgba(0,0,0,.1) !important}
@media (max-width:768px){.navbar{padding:10px 0 !important}.navbar-brand{font-size:1.3rem}.navbar-nav .nav-link{padding:.4rem .8rem !important;margin:0 .2rem}.user-avatar-btn{padding:6px 12px !important}
    .navbar .container{display:flex !important;align-items:center !important;justify-content:space-between !important;flex-wrap:wrap !important}
    .navbar-collapse{flex-basis:100% !important;width:100% !important;margin-top:.5rem !important}
    .mobile-actions{margin-left:auto !important;gap:.25rem !important;align-items:center !important;flex-wrap:nowrap !important}
    .mobile-actions .btn{padding:6px 8px !important;line-height:1 !important}
    .mobile-actions .notif-badge{top:-4px !important;right:-6px !important;transform:none !important}
    .dropdown-menu.notifications{min-width:280px !important;border-radius:12px !important;margin-top:8px !important}
    .navbar-brand video{display:none !important}
}
@media (max-width:768px){.navbar-nav .nav-link{margin:.2rem 0}}
.btn-primary {background: linear-gradient(135deg, #ff6b35 100%);border: none;border-radius: 10px;padding: 12px 30px;font-weight: 600;}
.btn-primary:hover {background: linear-gradient(135deg, #e55a2b 100%);}
.btn-outline-primary{color:#ff6b35;border-color:#ff6b35}
.btn-outline-primary:hover{background-color:#ff6b35;border-color:#ff6b35;color:#fff}
.btn-outline-primary.active{background-color:#ff6b35;color:#fff;border-color:#fff}
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
</style>
</head>
<body>
    <jsp:useBean id="now" class="java.util.Date" />
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #ff6b35;">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <video src="${pageContext.request.contextPath}/images/logofastfood.mp4" alt="Fast Food Logo" style="height: 30px; margin-right: 10px;" autoplay muted loop></video> Fast Food
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
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/promotions">Khuyến mãi</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                </ul>
                <div class="d-none d-lg-flex align-items-center ms-auto">
                    <c:set var="cartCount" value="${sessionScope.cartItems != null ? fn:length(sessionScope.cartItems) : 0}" />
                    <a href="${pageContext.request.contextPath}/cart/view" class="btn btn-outline-light me-3 notif-btn">
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

    

<section class="promo-hero">
    <div class="container text-center">
            <h1 class="mb-2">Khuyến mãi nổi bật</h1>
            <p class="mb-3">Săn mã ưu đãi tốt nhất và áp dụng ngay khi thanh toán</p>
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <div class="badge bg-light text-dark py-2 px-3" id="stat-total"><i class="fas fa-ticket-alt me-2"></i> <span data-stat="total">0</span> mã đang hoạt động</div>
                <div class="badge bg-light text-dark py-2 px-3" id="stat-product"><i class="fas fa-tags me-2"></i> <span data-stat="product">0</span> mã sản phẩm</div>
                <div class="badge bg-light text-dark py-2 px-3" id="stat-shipping"><i class="fas fa-truck me-2"></i> <span data-stat="shipping">0</span> mã vận chuyển</div>
            </div>
    </div>
</section>

    <div class="container py-5">
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-body">
                <div class="row g-3 align-items-center">
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-search"></i></span>
                            <input type="text" class="form-control" id="promoSearch" placeholder="Tìm theo mã hoặc tên khuyến mãi">
                        </div>
                    </div>
                    
                    <div class="col-md-3">
                        <div class="d-flex flex-wrap gap-2" id="promoFilters">
                            <button type="button" class="btn btn-outline-primary active" data-filter="ALL">Tất cả</button>
                            <button type="button" class="btn btn-outline-primary" data-filter="PRODUCT">Sản phẩm</button>
                            <button type="button" class="btn btn-outline-primary" data-filter="SHIPPING">Vận chuyển</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <c:choose>
            <c:when test="${empty vouchers}">
                <div class="alert alert-info"><i class="fas fa-info-circle me-2"></i>Hiện chưa có chương trình khuyến mãi.</div>
            </c:when>
            <c:otherwise>
                <div class="row g-4 align-items-stretch row-cols-1 row-cols-md-2 row-cols-lg-3">
                    <c:forEach var="v" items="${vouchers}">
                        <div class="col">
                            <div class="card promo-card h-100" data-type="${v.voucherType}" data-discount="${v.discountType == 'PERCENTAGE' ? v.discountValue : v.discountValue}" data-keywords="${fn:toLowerCase(v.code != null ? v.code : '')} ${fn:toLowerCase(v.name != null ? v.name : '')}">
                                <div class="card-body p-4 position-relative d-flex flex-column">
                                    <c:if test="${v.endDate != null && (v.endDate.time - now.time) gt 0 && (v.endDate.time - now.time) le 259200000}">
                                        <span class="position-absolute top-0 start-0 translate-middle badge rounded-pill bg-danger" style="margin-top:14px; margin-left:14px;">Sắp hết hạn</span>
                                    </c:if>
                                    <span class="position-absolute top-0 end-0 translate-middle badge rounded-pill bg-warning text-dark" style="margin-top:14px; margin-right:14px;">HOT</span>
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="voucher-code"><i class="fas fa-ticket-alt me-2"></i>${v.code}</span>
                                        <span class="badge badge-type ${v.voucherType == 'SHIPPING' ? 'bg-info text-dark' : 'bg-success'}">
                                            ${v.voucherType == 'SHIPPING' ? 'Vận chuyển' : 'Sản phẩm'}
                                        </span>
                                    </div>
                                    <h5 class="mb-2">${v.name}</h5>
                                    <p class="mb-2">
                                        <strong>
                                            <c:choose>
                                                <c:when test="${v.discountType == 'PERCENTAGE'}">
                                                    Giảm <span class="text-success">${v.discountValue}%</span>
                                                </c:when>
                                                <c:otherwise>
                                                    Giảm <span class="text-success"><fmt:formatNumber value="${v.discountValue}" type="number" groupingUsed="true"/> đ</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </strong>
                                    </p>
                                    <div class="muted-line">
                                        <c:if test="${v.minOrderAmount != null && v.minOrderAmount gt 0}">
                                            Đơn tối thiểu: <fmt:formatNumber value="${v.minOrderAmount}" type="number" groupingUsed="true"/> đ
                                        </c:if>
                                        <c:if test="${v.maxDiscountAmount != null && v.maxDiscountAmount gt 0}">
                                            • Tối đa: <fmt:formatNumber value="${v.maxDiscountAmount}" type="number" groupingUsed="true"/> đ
                                        </c:if>
                                    </div>
                                    <div class="muted-line mt-2">
                                        Hiệu lực: <fmt:formatDate value="${v.startDate}" pattern="dd/MM/yyyy"/> - <fmt:formatDate value="${v.endDate}" pattern="dd/MM/yyyy"/>
                                    </div>
                                    <div class="d-flex align-items-center mt-3 mt-auto">
                                        <button type="button" class="btn btn-outline-primary copy-btn me-2" data-code="${v.code}"><i class="fas fa-copy me-1"></i> Sao chép</button>
                                        <c:choose>
                                            <c:when test="${v.voucherType == 'SHIPPING'}">
                                                <a href="${pageContext.request.contextPath}/checkout?shippingVoucherCode=${v.code}" class="btn btn-primary"><i class="fas fa-shopping-bag me-1"></i> Áp dụng khi thanh toán</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/checkout?voucherCode=${v.code}" class="btn btn-primary"><i class="fas fa-shopping-bag me-1"></i> Áp dụng khi thanh toán</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        <div class="row mt-5">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-4">
                        <h5 class="mb-3"><i class="fas fa-lightbulb me-2 text-warning"></i>Cách dùng mã khuyến mãi</h5>
                        <ul class="mb-0">
                            <li>Sao chép mã khuyến mãi bằng nút “Sao chép”.</li>
                            <li>Vào trang “Thanh toán” và dán mã vào ô nhập mã giảm giá.</li>
                            <li>Đảm bảo đơn hàng thỏa điều kiện tối thiểu và trong thời gian hiệu lực.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function(){
        var cards = document.querySelectorAll('.promo-card');
        var statTotal = document.querySelector('[data-stat="total"]');
        var statProduct = document.querySelector('[data-stat="product"]');
        var statShipping = document.querySelector('[data-stat="shipping"]');
        var counts = {total:0, product:0, shipping:0};
        cards.forEach(function(card){
            counts.total++;
            var t = card.getAttribute('data-type');
            if(t === 'SHIPPING') counts.shipping++; else counts.product++;
        });
        if(statTotal) statTotal.textContent = counts.total;
        if(statProduct) statProduct.textContent = counts.product;
        if(statShipping) statShipping.textContent = counts.shipping;

        var filterBtns = document.querySelectorAll('#promoFilters .btn');
        var searchInput = document.getElementById('promoSearch');
        var sortSelect = document.getElementById('promoSort');
        var activeFilter = 'ALL';

        function applyFilters(){
            var q = (searchInput?.value || '').toLowerCase();
            var list = Array.from(cards);
            list.forEach(function(card){
                var type = card.getAttribute('data-type');
                var kw = card.getAttribute('data-keywords') || '';
                var byType = (activeFilter === 'ALL') || (type === activeFilter);
                var bySearch = !q || kw.indexOf(q) !== -1;
                card.parentElement.style.display = (byType && bySearch) ? '' : 'none';
            });
            // sort
            var rows = document.querySelector('.row.g-4');
            if(rows){
                var children = Array.from(rows.children);
                children.sort(function(a,b){
                    var da = parseFloat(a.querySelector('.promo-card').getAttribute('data-discount')) || 0;
                    var db = parseFloat(b.querySelector('.promo-card').getAttribute('data-discount')) || 0;
                    return (sortSelect.value === 'asc') ? (da - db) : (db - da);
                });
                children.forEach(function(el){ rows.appendChild(el); });
            }
        }

        filterBtns.forEach(function(btn){
            btn.addEventListener('click', function(){
                filterBtns.forEach(function(b){ b.classList.remove('active'); });
                btn.classList.add('active');
                activeFilter = btn.getAttribute('data-filter');
                applyFilters();
            });
        });
        if(searchInput) searchInput.addEventListener('input', applyFilters);
        if(sortSelect) sortSelect.addEventListener('change', applyFilters);
        applyFilters();
    });

    document.addEventListener('click',function(e){
        var btn=e.target.closest('.copy-btn');
        if(!btn) return;
        var code=btn.getAttribute('data-code');
        navigator.clipboard.writeText(code).then(function(){
            btn.classList.remove('btn-outline-primary');
            btn.classList.add('btn-success');
            btn.innerHTML='<i class="fas fa-check me-1"></i>Đã sao chép';
            setTimeout(function(){
                btn.classList.add('btn-outline-primary');
                btn.classList.remove('btn-success');
                btn.innerHTML='<i class="fas fa-copy me-1"></i> Sao chép';
            },1500);
        });
    });
    </script>
    <jsp:include page="/WEB-INF/views/includes/chat-widget.jsp" />
</body>
</html>
