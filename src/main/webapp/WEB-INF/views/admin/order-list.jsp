<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản lý đơn hàng - Fastfood</title>
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
	min-height: 100vh;
	background: linear-gradient(135deg, #FF6B35 0%, #F7931E 100%);
	color: white;
	box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
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

/* Dropdown menu styles */
/* Ensure all parent containers allow overflow */
.main-content, .table-container, .p-4, .table-responsive, .card-body,
	.table, tbody, tr, td {
	overflow: visible !important;
}

.btn-group {
	position: relative;
	display: inline-block;
	vertical-align: middle;
	overflow: visible !important;
}

.dropdown-menu {
	position: absolute !important;
	top: 100% !important;
	right: 0 !important;
	left: auto !important;
	z-index: 99999 !important;
	display: none;
	float: none;
	min-width: 160px;
	padding: 5px 0;
	margin: 2px 0 0;
	font-size: 14px;
	text-align: left;
	list-style: none;
	background-color: #fff;
	background-clip: padding-box;
	border: 1px solid #ccc;
	border: 1px solid rgba(0, 0, 0, .15);
	border-radius: 4px;
	box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
	transform: translateX(0) !important;
}

.dropdown-menu.show {
	display: block !important;
}

.dropdown-item {
	display: block;
	width: 100%;
	padding: 3px 20px;
	clear: both;
	font-weight: normal;
	line-height: 1.42857143;
	color: #333;
	white-space: nowrap;
	text-decoration: none;
}

.dropdown-item:hover {
	color: #262626;
	text-decoration: none;
	background-color: #f5f5f5;
}

.table td {
	vertical-align: middle;
	position: relative;
	overflow: visible !important;
}

/* Mobile-friendly card layout for orders table */
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
	.table tbody td.actions {
		justify-content: flex-start;
		gap: 8px;
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
						<c:if test="${not empty errorMessage}">
							<div class="alert alert-warning" role="alert">
								<i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
							</div>
						</c:if>
						<div
							class="d-flex justify-content-between align-items-center mb-3">
							<div class="d-flex align-items-center">
								<button class="btn btn-outline-primary d-md-none me-2"
									id="adminMenuBtn" aria-label="Mở menu">
									<i class="fas fa-bars"></i>
								</button>
								<h4 class="mb-0">
									<i class="fas fa-shopping-cart me-2 text-primary"></i>Danh sách
									đơn hàng
								</h4>
							</div>
						</div>

						<c:if test="${not empty message}">
							<div class="alert alert-success alert-dismissible fade show"
								role="alert">
								<i class="fas fa-check-circle me-2"></i>${message}
								<button type="button" class="btn-close" data-bs-dismiss="alert"
									aria-label="Close"></button>
							</div>
						</c:if>

						+
						<div class="table-responsive">
							<table class="table table-hover align-middle">
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
									<c:forEach var="order" items="${orders}" varStatus="loop">
										<tr>
											<td data-label="ID"><strong>#${loop.index + 1}</strong></td>
											<td data-label="Khách hàng"><strong>${order.customerName}</strong></td>
											<td data-label="Ngày đặt"><fmt:formatDate
													value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm" /></td>
											<td data-label="Tổng tiền"><strong><fmt:formatNumber
														value="${order.totalAmount}" type="currency"
														currencySymbol="VNĐ" /></strong></td>
											<td data-label="Trạng thái"><c:choose>
													<c:when test="${order.status eq 'CHO_XAC_NHAN'}">
														<span class="status-badge status-pending">Chờ xác
															nhận</span>
													</c:when>
													<c:when test="${order.status eq 'DANG_CHUAN_BI'}">
														<span class="status-badge status-processing">Đang
															chuẩn bị</span>
													</c:when>
													<c:when test="${order.status eq 'DANG_GIAO'}">
														<span class="status-badge status-processing">Đang
															giao</span>
													</c:when>
													<c:when test="${order.status eq 'DA_GIAO'}">
														<span class="status-badge status-completed">Đã giao</span>
													</c:when>
													<c:when test="${order.status eq 'DA_HUY'}">
														<span class="status-badge status-cancelled">Đã hủy</span>
													</c:when>
												</c:choose></td>
                                            <td class="actions" data-label="Thao tác"><a
                                                href="${pageContext.request.contextPath}/admin/orders?action=view&id=${order.id}"
                                                class="btn btn-sm btn-outline-primary me-1"> <i
                                                    class="fas fa-eye"></i>
                                            </a>
                                                <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                                                    <div class="btn-group">
                                                        <button type="button"
                                                            class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                                            aria-expanded="false">
                                                            <i class="fas fa-cog"></i>
                                                        </button>
                                                        <ul class="dropdown-menu">
                                                            <li><a class="dropdown-item"
                                                                href="${pageContext.request.contextPath}/admin/orders?action=update&id=${order.id}&status=CHO_XAC_NHAN"><i
                                                                    class="fas fa-clock me-2"></i>Chờ xác nhận</a></li>
                                                            <li><a class="dropdown-item"
                                                                href="${pageContext.request.contextPath}/admin/orders?action=update&id=${order.id}&status=DANG_CHUAN_BI"><i
                                                                    class="fas fa-utensils me-2"></i>Đang chuẩn bị</a></li>
                                                            <li><a class="dropdown-item"
                                                                href="${pageContext.request.contextPath}/admin/orders?action=update&id=${order.id}&status=DANG_GIAO"><i
                                                                    class="fas fa-truck me-2"></i>Đang giao</a></li>
                                                            <li><a class="dropdown-item"
                                                                href="${pageContext.request.contextPath}/admin/orders?action=update&id=${order.id}&status=DA_GIAO"><i
                                                                    class="fas fa-check me-2"></i>Đã giao</a></li>
                                                            <li><a class="dropdown-item"
                                                                href="${pageContext.request.contextPath}/admin/orders?action=update&id=${order.id}&status=DA_HUY"><i
                                                                    class="fas fa-times me-2"></i>Đã hủy</a></li>
                                                        </ul>
                                                    </div>
                                                </c:if>
                                            </td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							+
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
        // Ensure dropdowns work properly
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Initializing dropdowns...');
            
            // Find all dropdown toggles
            const dropdowns = document.querySelectorAll('.dropdown-toggle');
            console.log('Found dropdowns:', dropdowns.length);
            
            dropdowns.forEach(function(dropdown, index) {
                console.log('Setting up dropdown', index + 1);
                
                // Remove any existing event listeners
                dropdown.removeEventListener('click', handleDropdownClick);
                
                // Add click event listener
                dropdown.addEventListener('click', handleDropdownClick);
            });
            
            function handleDropdownClick(e) {
                e.preventDefault();
                e.stopPropagation();
                
                console.log('Dropdown clicked');
                
                const btnGroup = this.closest('.btn-group');
                const menu = btnGroup ? btnGroup.querySelector('.dropdown-menu') : null;
                
                if (menu) {
                    // Close all other dropdowns first
                    document.querySelectorAll('.dropdown-menu.show').forEach(function(openMenu) {
                        if (openMenu !== menu) {
                            openMenu.classList.remove('show');
                        }
                    });
                    
                    // Toggle current dropdown
                    menu.classList.toggle('show');
                    console.log('Menu toggled, now showing:', menu.classList.contains('show'));
                }
            }
            
            // Close dropdown when clicking outside
            document.addEventListener('click', function(e) {
                if (!e.target.closest('.btn-group')) {
                    document.querySelectorAll('.dropdown-menu.show').forEach(function(menu) {
                        menu.classList.remove('show');
                    });
                }
            });
        });
    </script>
	<script>
        (function() {
            const btn = document.getElementById('adminMenuBtn');
            const sidebar = document.querySelector('.sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            const openMenu = () => {
                sidebar.classList.add('active');
                overlay.classList.add('show');
                document.body.style.overflow = 'hidden';
            };
            const closeMenu = () => {
                sidebar.classList.remove('active');
                overlay.classList.remove('show');
                document.body.style.overflow = '';
            };
            if (btn && sidebar && overlay) {
                btn.addEventListener('click', function() {
                    if (sidebar.classList.contains('active')) { closeMenu(); } else { openMenu(); }
                });
                overlay.addEventListener('click', closeMenu);
                window.addEventListener('resize', function(){
                    if (window.innerWidth >= 992) closeMenu();
                });
            }
        })();
    </script>
</body>
</html>
