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
<title>Quản lý sản phẩm - Fastfood</title>
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

@media ( min-width : 992px) {
	.main-content {
		height: 100vh;
		overflow-y: auto;
		padding: 30px;
	}
}

@media ( max-width : 576px) {
	.main-content {
		height: auto;
		overflow-y: visible;
		padding: 16px;
	}
	.container-fluid, .row {
		height: auto;
	}
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

.table-container {
	background: white;
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.product-image {
	border-radius: 8px;
	object-fit: cover;
}

.status-badge {
	padding: 4px 8px;
	border-radius: 12px;
	font-size: 0.8em;
	font-weight: 500;
}

.status-active {
	background-color: #d4edda;
	color: #155724;
}

.status-inactive {
	background-color: #f8d7da;
	color: #721c24;
}

/* Mobile-friendly card layout */
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
	}
	.table tbody td {
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 100%;
		padding: 10px 12px;
		border: 0 !important;
		white-space: normal;
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
		flex-wrap: wrap;
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
				</a> <a href="${pageContext.request.contextPath}/admin/products"
					class="active"> <i class="fas fa-hamburger me-2"></i> Sản phẩm
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
				<div class="table-container">
					<div class="p-4">
						<div
							class="d-flex justify-content-between align-items-center mb-3">
							<div class="d-flex align-items-center">
								<button class="btn btn-outline-primary d-md-none me-2"
									id="adminMenuBtn" aria-label="Mở menu">
									<i class="fas fa-bars"></i>
								</button>
								<h4 class="mb-0">
									<i class="fas fa-hamburger me-2 text-primary"></i>Danh sách sản
									phẩm
								</h4>
							</div>
                            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                                <a
                                    href="${pageContext.request.contextPath}/admin/products?action=new"
                                    class="btn btn-primary"> <i class="fas fa-plus me-2"></i>
                                    Thêm sản phẩm mới
                                </a>
                            </c:if>
						</div>

						<c:if test="${not empty message}">
							<div class="alert alert-success alert-dismissible fade show"
								role="alert">
								<i class="fas fa-check-circle me-2"></i>${message}
								<button type="button" class="btn-close" data-bs-dismiss="alert"
									aria-label="Close"></button>
							</div>
                        </c:if>
                        <div class="table-responsive">
							<table class="table table-hover">
								<thead class="table-light">
									<tr>
										<th><i class="fas fa-hashtag me-1"></i>ID</th>
										<th><i class="fas fa-image me-1"></i>Hình ảnh</th>
										<th><i class="fas fa-tag me-1"></i>Tên sản phẩm</th>
										<th><i class="fas fa-folder me-1"></i>Danh mục</th>
										<th><i class="fas fa-money-bill me-1"></i>Giá</th>
										<th><i class="fas fa-toggle-on me-1"></i>Trạng thái</th>
										<th><i class="fas fa-cogs me-1"></i>Thao tác</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="product" items="${products}">
										<tr>
											<td data-label="ID"><strong>#${product.id}</strong></td>
											<td data-label="Hình ảnh"><c:choose>
													<c:when
														test="${not empty product.imageUrl && (fn:startsWith(product.imageUrl, 'http://') || fn:startsWith(product.imageUrl, 'https://'))}">
														<img src="${product.imageUrl}" alt="${product.name}"
															width="50" height="50" class="product-image"
															style="object-fit: cover; border-radius: 4px;">
													</c:when>
													<c:when test="${not empty product.imageUrl}">
														<img
															src="${pageContext.request.contextPath}/${product.imageUrl}"
															alt="${product.name}" width="50" height="50"
															class="product-image"
															style="object-fit: cover; border-radius: 4px;">
													</c:when>
													<c:otherwise>
														<div class="text-center text-muted"
															style="width: 50px; height: 50px; display: flex; align-items: center; justify-content: center; border: 1px dashed #ccc; border-radius: 4px;">
															<i class="fas fa-image"></i>
														</div>
													</c:otherwise>
												</c:choose></td>
											<td data-label="Tên sản phẩm"><strong>${product.name}</strong></td>
											<td data-label="Danh mục"><span
												class="badge bg-secondary">${product.categoryName}</span></td>
											<td data-label="Giá"><strong><fmt:formatNumber
														value="${product.price}" type="currency"
														currencySymbol="đ" /></strong></td>
											<td data-label="Trạng thái"><c:choose>
													<c:when
														test="${fn:toLowerCase(product.status) == 'active'}">
														<span class="status-badge status-active">Đang bán</span>
													</c:when>
													<c:otherwise>
														<span class="status-badge status-inactive">Tạm
															ngưng</span>
													</c:otherwise>
												</c:choose></td>
                                            <td class="actions" data-label="Thao tác">
                                                <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                                                    <a
                                                        href="${pageContext.request.contextPath}/admin/products?action=edit&id=${product.id}"
                                                        class="btn btn-sm btn-outline-primary me-1"
                                                        title="Sửa sản phẩm"> <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="javascript:void(0)"
                                                        onclick="confirmDelete(${product.id})"
                                                        class="btn btn-sm btn-outline-danger" title="Xóa sản phẩm">
                                                            <i class="fas fa-trash"></i>
                                                    </a>
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

	<!-- Delete Confirmation Modal -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
		aria-labelledby="deleteModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Bạn có chắc chắn muốn xóa sản phẩm này
					không?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Hủy</button>
					<a href="#" id="confirmDeleteBtn" class="btn btn-danger">Xóa</a>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        function confirmDelete(id) {
            document.getElementById('confirmDeleteBtn').href = '${pageContext.request.contextPath}/admin/products?action=delete&id=' + id;
            var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
            deleteModal.show();
        }
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
    </script>
</body>
</html>
