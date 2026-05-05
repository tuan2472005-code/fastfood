<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản lý đơn hàng theo khách hàng - Fastfood</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
body {
	background-color: #f8f9fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.sidebar {
	height: 100vh;
	background: linear-gradient(135deg, #FF6B35 0%, #F7931E 100%);
	color: white;
	box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
	position: sticky;
	top: 0;
	z-index: 1000;
	overflow-y: auto;
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
	padding: 30px;
}

@media ( max-width : 576px) {
    /* Off-canvas sidebar for mobile */
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

@media ( max-width : 991.98px) {
    .sidebar h4 video { display: none !important; }
}

.table-container {
	background: white;
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.user-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    object-fit: cover;
    margin-right: 10px;
    background-color: #eee;
}

.user-row {
    cursor: pointer;
    transition: background-color 0.2s;
}

.user-row:hover {
    background-color: #fff8f5;
}

.btn-view-orders {
    background-color: #FF6B35;
    color: white;
    border: none;
    border-radius: 8px;
    padding: 5px 15px;
    transition: all 0.3s;
}

.btn-view-orders:hover {
    background-color: #e85a24;
    color: white;
    transform: translateY(-2px);
}

/* Mobile-friendly layout */
@media ( max-width : 576px) {
	.table-responsive {
		overflow: visible;
	}
	.table {
		border: 0;
	}
	.table thead {
		display: none;
	}
	.table tbody tr {
		display: block;
		margin-bottom: 1rem;
		background: #fff;
		border: 1px solid #eee;
		border-radius: 12px;
		box-shadow: 0 6px 12px rgba(0, 0, 0, 0.06);
		overflow: hidden;
	}
	.table tbody td {
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 100%;
		padding: 10px 12px;
		border: 0 !important;
	}
	.table tbody td::before {
		content: attr(data-label);
		font-weight: 600;
		color: #6c757d;
		margin-right: 1rem;
	}
}
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
				<a href="${pageContext.request.contextPath}/admin/dashboard"> <i
					class="fas fa-chart-pie me-2"></i> Dashboard
				</a> <a href="${pageContext.request.contextPath}/admin/products"> <i
					class="fas fa-hamburger me-2"></i> Sản phẩm
				</a> <a href="${pageContext.request.contextPath}/admin/categories">
					<i class="fas fa-tags me-2"></i> Danh mục
				</a> <a href="${pageContext.request.contextPath}/admin/orders"
					class="active"> <i class="fas fa-shopping-cart me-2"></i> Đơn
					hàng
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
				<div class="table-container">
					<div class="p-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="d-flex align-items-center">
                                <button class="btn btn-outline-primary d-md-none me-2"
                                    id="adminMenuBtn" aria-label="Mở menu">
                                    <i class="fas fa-bars"></i>
                                </button>
                                <h4 class="mb-0">
                                    <i class="fas fa-users me-2 text-primary"></i>Khách hàng đã đặt hàng
                                </h4>
                            </div>
                        </div>

						<div class="table-responsive">
							<table class="table table-hover align-middle">
								<thead class="table-light">
									<tr>
										<th>ID Người dùng</th>
										<th>Khách hàng</th>
										<th>Số điện thoại</th>
										<th>Email</th>
										<th>Thao tác</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="u" items="${users}">
										<tr class="user-row" onclick="window.location.href='${pageContext.request.contextPath}/admin/orders?action=listOrders&userId=${u.id}'">
											<td data-label="ID Người dùng"><strong>#${u.id}</strong></td>
											<td data-label="Khách hàng">
                                                <div class="d-flex align-items-center">
                                                    <c:choose>
                                                        <c:when test="${not empty u.avatar}">
                                                            <img src="${pageContext.request.contextPath}/${u.avatar}" class="user-avatar" alt="Avatar">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="user-avatar d-flex align-items-center justify-content-center">
                                                                <i class="fas fa-user text-muted"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div>
                                                        <div class="fw-bold">${u.fullName}</div>
                                                        <small class="text-muted">@${u.username}</small>
                                                    </div>
                                                </div>
                                            </td>
											<td data-label="Số điện thoại">${u.phone}</td>
											<td data-label="Email">${u.email}</td>
											<td data-label="Thao tác">
												<a href="${pageContext.request.contextPath}/admin/orders?action=listOrders&userId=${u.id}"
													class="btn btn-sm btn-view-orders">
													<i class="fas fa-list me-1"></i>Xem đơn hàng
												</a>
											</td>
										</tr>
									</c:forEach>
                                    <c:if test="${empty users}">
                                        <tr>
                                            <td colspan="5" class="text-center py-4">Chưa có khách hàng nào đặt hàng.</td>
                                        </tr>
                                    </c:if>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
    <div id="sidebarOverlay" class="sidebar-overlay d-md-none"></div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Sidebar toggle for mobile
            const adminMenuBtn = document.getElementById('adminMenuBtn');
            const sidebar = document.querySelector('.sidebar');
            const overlay = document.getElementById('sidebarOverlay');

            if (adminMenuBtn) {
                adminMenuBtn.addEventListener('click', function() {
                    sidebar.classList.add('active');
                    overlay.classList.add('show');
                });
            }

            if (overlay) {
                overlay.addEventListener('click', function() {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('show');
                });
            }
        });
    </script>
</body>
</html>
