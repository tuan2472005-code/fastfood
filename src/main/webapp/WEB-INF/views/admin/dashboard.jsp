<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard - Fastfood</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
body {
	background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	min-height: 100vh;
}

.dashboard-title {
	background: linear-gradient(135deg, #FF6B35 0%, #F7931E 100%);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
	font-weight: 700;
}

.container-fluid {
	min-height: 100vh;
}

.row {
	height: auto;
}

@media ( min-width : 768px) {
	.col-md-2 {
		flex: 0 0 16.666667%;
		max-width: 16.666667%;
	}
	.col-md-10 {
		flex: 0 0 83.333333%;
		max-width: 83.333333%;
	}
}

@media ( max-width : 767.98px) {
    /* Off-canvas sidebar for mobile */
    .sidebar h4 video { display: none !important; }
    .sidebar {
        position: fixed;
        top: 0;
        left: 0;
		height: 100vh;
		width: 260px;
		transform: translateX(-100%);
		transition: transform 0.3s ease;
		z-index: 1040;
	}
	.sidebar.active {
		transform: translateX(0);
	}
	.sidebar-overlay {
		position: fixed;
		inset: 0;
		background: rgba(0, 0, 0, 0.4);
		z-index: 1035;
		display: none;
	}
	.sidebar-overlay.show {
		display: block;
	}
}

.sidebar {
	min-height: 100vh;
	background: linear-gradient(135deg, #FF6B35 0%, #F7931E 100%);
	color: white;
	box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
}

.sidebar::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: linear-gradient(45deg, rgba(255, 255, 255, 0.1) 0%,
		transparent 50%);
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
	padding: 15px;
}

.table-container {
	background: white;
	border-radius: 15px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	margin-top: 10px;
	padding: 15px 20px;
}

.stats-card {
	background: white;
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin-bottom: 0;
	transition: transform 0.3s ease;
	height: 140px;
	display: flex;
	flex-direction: row;
	align-items: center;
	gap: 15px;
}

.stats-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
}

.stats-icon {
	width: 60px;
	height: 60px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.5rem;
	color: white;
	flex-shrink: 0;
	transition: all 0.3s ease;
}

.stats-card:hover .stats-icon {
	transform: scale(1.1);
}

.stats-content {
	flex: 1;
	display: flex;
	flex-direction: column;
	justify-content: center;
	text-align: right;
}

.stats-content h3 {
	font-size: 2rem;
	font-weight: bold;
	margin-bottom: 5px;
	line-height: 1.2;
}

.stats-content p {
	color: #6c757d;
	margin-bottom: 0;
	font-size: 1rem;
}

.status-badge {
	padding: 4px 8px;
	border-radius: 12px;
	font-size: 0.8em;
	font-weight: 500;
}

.status-pending {
	background-color: #fff3cd;
	color: #856404;
}

.status-processing {
	background-color: #cce5ff;
	color: #004085;
}

.status-completed {
	background-color: #d4edda;
	color: #155724;
}

.status-cancelled {
	background-color: #f8d7da;
	color: #721c24;
}

.order-cards {
	display: grid;
	grid-template-columns: 1fr;
	gap: 12px;
}

@media ( min-width : 576px) {
	.order-cards {
		grid-template-columns: 1fr 1fr;
	}
}

@media ( min-width : 992px) {
	.order-cards {
		grid-template-columns: 1fr 1fr 1fr;
	}
}

.order-card {
	background: #fff;
	border: 1px solid #eee;
	border-radius: 12px;
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.06);
	padding: 12px 14px;
}

.order-card-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.order-card-meta {
	display: flex;
	justify-content: space-between;
	margin-top: 8px;
	font-size: 0.95rem;
}

.order-card-actions {
    margin-top: 10px;
    display: flex;
    justify-content: flex-end;
}
.status-chip {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 8px 12px;
    border-radius: 20px;
    font-weight: 600;
    font-size: 0.95rem;
}
.chip-pending { background-color: #fff3cd; color: #856404; }
.chip-preparing { background-color: #cfe2ff; color: #084298; }
.chip-delivering { background-color: #e2f0fb; color: #0b5ed7; }
.chip-delivered { background-color: #d4edda; color: #155724; }
.chip-cancelled { background-color: #f8d7da; color: #721c24; }
.status-breakdown { display: none; position: relative; z-index: 2; }
.status-breakdown.show { display: block; }
.status-row { display: flex; gap: 8px; white-space: nowrap; overflow-x: auto; }
.stats-card.clickable { cursor: pointer; }
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar -->
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
				<a href="${pageContext.request.contextPath}/admin/dashboard"
					class="active"> <i class="fas fa-chart-pie me-2"></i> Dashboard
				</a> <a href="${pageContext.request.contextPath}/admin/products"> <i
					class="fas fa-hamburger me-2"></i> Sản phẩm
				</a> <a href="${pageContext.request.contextPath}/admin/categories">
					<i class="fas fa-tags me-2"></i> Danh mục
				</a> <a href="${pageContext.request.contextPath}/admin/orders"> <i
					class="fas fa-shopping-cart me-2"></i> Đơn hàng
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
				<div class="d-flex justify-content-between align-items-center mb-4">
					<div class="d-flex align-items-center">
						<button class="btn btn-outline-primary d-md-none me-2"
							id="adminMenuBtn" aria-label="Mở menu">
							<i class="fas fa-bars"></i>
						</button>
						<h2 class="dashboard-title mb-0">
							<i class="fas fa-chart-pie me-2"></i>Dashboard
						</h2>
					</div>
					<div class="text-muted">
						<i class="fas fa-user me-2"></i>Xin chào, ${user.fullName}
					</div>
				</div>

				<!-- Thông báo lỗi/thành công nếu có -->
				<c:if test="${not empty errorMessage}">
					<div class="alert alert-danger">
						<i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
					</div>
				</c:if>
				<c:if test="${not empty successMessage}">
					<div class="alert alert-success">
						<i class="fas fa-check-circle me-2"></i>${successMessage}
					</div>
				</c:if>

                <!-- Statistics Cards -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="stats-card clickable" id="totalOrdersCard">
                            <div class="stats-icon bg-primary">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                            <div class="stats-content">
                                <h3>${totalOrders != null ? totalOrders : 0}</h3>
                                <p>Tổng đơn hàng</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stats-icon bg-success">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <div class="stats-content">
                                <h3>${totalRevenue != null ? totalRevenue : 0}đ</h3>
                                <p>Doanh thu</p>
                            </div>
                        </div>
                    </div>
					<div class="col-md-3">
						<div class="stats-card">
							<div class="stats-icon bg-warning">
								<i class="fas fa-hamburger"></i>
							</div>
							<div class="stats-content">
								<h3>${totalProducts != null ? totalProducts : 0}</h3>
								<p>Sản phẩm</p>
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="stats-card">
							<div class="stats-icon bg-info">
								<i class="fas fa-users"></i>
							</div>
							<div class="stats-content">
								<h3>${totalUsers != null ? totalUsers : 0}</h3>
								<p>Khách hàng</p>
							</div>
						</div>
                </div>
            </div>
            <div class="table-container status-breakdown mt-2" id="statusBreakdown">
                <div class="p-3">
                    <div class="status-row">
                        <div class="status-chip chip-pending"><i class="fas fa-hourglass-half"></i>Chờ xác nhận: ${countPending != null ? countPending : 0}</div>
                        <div class="status-chip chip-preparing"><i class="fas fa-tools"></i>Đang chuẩn bị: ${countPreparing != null ? countPreparing : 0}</div>
                        <div class="status-chip chip-delivering"><i class="fas fa-truck"></i>Đang giao: ${countDelivering != null ? countDelivering : 0}</div>
                        <div class="status-chip chip-delivered"><i class="fas fa-check"></i>Đã giao: ${countDelivered != null ? countDelivered : 0}</div>
                        <div class="status-chip chip-cancelled"><i class="fas fa-times"></i>Đã hủy: ${countCancelled != null ? countCancelled : 0}</div>
                    </div>
                </div>
            </div>
            <!-- Recent Orders -->
				<div class="table-container">
					<div class="p-4">
						<div
							class="d-flex justify-content-between align-items-center mb-3">
							<h4 class="mb-0">
								<i class="fas fa-clock me-2 text-primary"></i>Đơn hàng gần đây
							</h4>
						</div>

						<div class="table-responsive d-none d-md-block">
							<table class="table table-hover">
								<thead class="table-light">
									<tr>
										<th><i class="fas fa-hashtag me-1"></i>ID</th>
										<th><i class="fas fa-user me-1"></i>Khách hàng</th>
										<th><i class="fas fa-calendar-alt me-1"></i>Ngày đặt</th>
										<th><i class="fas fa-money-bill me-1"></i>Tổng tiền</th>
										<th><i class="fas fa-info-circle me-1"></i>Trạng thái</th>
										<th><i class="fas fa-cogs me-1"></i>Thao tác</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="order" items="${recentOrders}">
										<tr>
											<td><strong>#${order.id}</strong></td>
											<td>${order.customerName}</td>
											<td><fmt:formatDate value="${order.createdAt}"
													pattern="dd/MM/yyyy" /></td>
											<td><strong><fmt:formatNumber
														value="${order.totalAmount}" pattern=",###" />đ</strong></td>
											<td><c:choose>
													<c:when test="${order.status == 'CHO_XAC_NHAN'}">
														<span class="status-badge status-pending">Chờ xác
															nhận</span>
													</c:when>
													<c:when test="${order.status == 'DANG_CHUAN_BI'}">
														<span class="status-badge status-processing">Đang
															chuẩn bị</span>
													</c:when>
													<c:when test="${order.status == 'DANG_GIAO'}">
														<span class="status-badge status-processing">Đang
															giao</span>
													</c:when>
													<c:when test="${order.status == 'DA_GIAO'}">
														<span class="status-badge status-completed">Đã giao</span>
													</c:when>
													<c:when test="${order.status == 'DA_HUY'}">
														<span class="status-badge status-cancelled">Đã hủy</span>
													</c:when>
													<c:otherwise>
														<span class="status-badge status-pending">${order.status}</span>
													</c:otherwise>
												</c:choose></td>
											<td><a
												href="${pageContext.request.contextPath}/admin/orders?action=view&id=${order.id}"
												class="btn btn-sm btn-outline-primary"> <i
													class="fas fa-eye"></i>
											</a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="d-md-none">
							<c:forEach var="order" items="${recentOrders}" varStatus="loop">
								<div class="order-card">
									<div class="order-card-header">
										<div>
											<strong>#${loop.index + 1}</strong> · ${order.customerName}
										</div>
										<div>
											<c:choose>
												<c:when test="${order.status == 'CHO_XAC_NHAN'}">
													<span class="status-badge status-pending">Chờ xác
														nhận</span>
												</c:when>
												<c:when test="${order.status == 'DANG_CHUAN_BI'}">
													<span class="status-badge status-processing">Đang
														chuẩn bị</span>
												</c:when>
												<c:when test="${order.status == 'DANG_GIAO'}">
													<span class="status-badge status-processing">Đang
														giao</span>
												</c:when>
												<c:when test="${order.status == 'DA_GIAO'}">
													<span class="status-badge status-completed">Đã giao</span>
												</c:when>
												<c:when test="${order.status == 'DA_HUY'}">
													<span class="status-badge status-cancelled">Đã hủy</span>
												</c:when>
												<c:otherwise>
													<span class="status-badge status-pending">${order.status}</span>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="order-card-meta">
										<div>
											<i class="fas fa-calendar-alt me-1"></i>
											<fmt:formatDate value="${order.createdAt}"
												pattern="dd/MM/yyyy" />
										</div>
										<div>
											<i class="fas fa-money-bill me-1"></i><strong><fmt:formatNumber
													value="${order.totalAmount}" pattern="#,###" />đ</strong>
										</div>
									</div>
									<div class="order-card-actions">
										<a
											href="${pageContext.request.contextPath}/admin/orders?action=view&id=${order.id}"
											class="btn btn-sm btn-outline-primary"> <i
											class="fas fa-eye"></i>
										</a>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>

	<div id="sidebarOverlay" class="sidebar-overlay d-md-none"></div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        (function() {
            const btn = document.getElementById('adminMenuBtn');
            const sidebar = document.querySelector('.sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            if (btn && sidebar && overlay) {
                btn.addEventListener('click', function() {
                    sidebar.classList.add('active');
                    overlay.classList.add('show');
                });
                overlay.addEventListener('click', function() {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('show');
                });
            }
        })();

        (function(){
            const totalCard = document.getElementById('totalOrdersCard');
            const panel = document.getElementById('statusBreakdown');
            if (totalCard && panel) {
                totalCard.addEventListener('click', function(){
                    panel.classList.toggle('show');
                });
                document.addEventListener('click', function(e){
                    if (!panel.classList.contains('show')) return;
                    const clickedInside = panel.contains(e.target) || totalCard.contains(e.target);
                    if (!clickedInside) panel.classList.remove('show');
                });
            }
        })();
    </script>
</body>
</html>
