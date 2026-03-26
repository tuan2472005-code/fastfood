<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản lý Voucher - Fastfood</title>
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
	overflow-x: auto;
}

.table {
	min-width: 1200px;
	margin-bottom: 0;
}

.table th, .table td {
	white-space: nowrap;
	vertical-align: middle;
	padding: 12px 8px;
}

.table th:nth-child(3), .table td:nth-child(3) {
	max-width: 120px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.table th:nth-child(10), .table td:nth-child(10) {
	width: 100px;
	text-align: center;
	white-space: normal;
}

.table th:last-child, .table td:last-child {
	width: 120px;
	text-align: center;
}

.badge-active {
	background-color: #28a745;
	color: white;
	padding: 6px 12px;
	border-radius: 15px;
	font-size: 0.75em;
	font-weight: 500;
	display: inline-block;
	min-width: 70px;
	text-align: center;
	white-space: nowrap;
}

.badge-inactive {
	background-color: #dc3545;
	color: white;
	padding: 6px 12px;
	border-radius: 15px;
	font-size: 0.75em;
	font-weight: 500;
	display: inline-block;
	min-width: 70px;
	text-align: center;
	white-space: nowrap;
}

.btn-group .btn {
	margin-right: 5px;
}

/* Mobile-friendly card layout */
@media ( max-width : 576px) {
    .table {
        min-width: auto;
    }
	.table-container {
		overflow: visible;
	}
	.table thead {
		display: none;
	}
	.table {
		border: 0;
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
@media ( max-width : 991.98px) {
    .sidebar h4 video { display: none !important; }
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
				</a> <a href="${pageContext.request.contextPath}/admin/orders"> <i
					class="fas fa-shopping-cart me-2"></i> Đơn hàng
				</a> <a href="${pageContext.request.contextPath}/admin/users"> <i
					class="fas fa-users me-2"></i> Người dùng
				</a> <a href="${pageContext.request.contextPath}/admin/voucher"
					class="active"> <i class="fas fa-ticket-alt me-2"></i> Voucher
                </a> <a href="${pageContext.request.contextPath}/admin/statistics">
                    <i class="fas fa-chart-bar me-2"></i> Thống kê
                </a> <a href="${pageContext.request.contextPath}/admin/chat"> <i class="fas fa-comments me-2"></i> Chat</a>
                <a href="${pageContext.request.contextPath}/logout"> <i
                    class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                </a>
			</div>

			<!-- Main Content -->
			<div class="col-md-10 main-content">
				<div class="d-md-none mb-3">
					<button class="btn btn-outline-primary" id="adminMenuBtn"
						aria-label="Mở menu">
						<i class="fas fa-bars"></i>
					</button>
				</div>
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>
                        <i class="fas fa-ticket-alt me-2 text-primary"></i>Quản lý Voucher
                    </h2>
                    <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                        <a
                            href="${pageContext.request.contextPath}/admin/voucher?action=add"
                            class="btn btn-primary"> <i class="fas fa-plus me-2"></i>Thêm
                            Voucher
                        </a>
                    </c:if>
                </div>
				<script>
                    (function() {
                        const btn = document.getElementById('adminMenuBtn');
                        const sidebar = document.querySelector('.sidebar');
                        let overlay = document.getElementById('sidebarOverlay');
                        if (!overlay) {
                            overlay = document.createElement('div');
                            overlay.id = 'sidebarOverlay';
                            overlay.className = 'sidebar-overlay d-md-none';
                            document.body.appendChild(overlay);
                        }
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

				<!-- Voucher Table -->
				<div class="table-container">
					<div class="p-4">
						<div class="table-responsive">
							<table class="table table-hover">
								<thead class="table-light">
									<tr>
										<th><i class="fas fa-hashtag me-1"></i>ID</th>
										<th><i class="fas fa-code me-1"></i>Mã voucher</th>
										<th><i class="fas fa-info-circle me-1"></i>Mô tả</th>
										<th><i class="fas fa-tag me-1"></i>Loại</th>
										<th><i class="fas fa-percentage me-1"></i>Giảm giá</th>
										<th><i class="fas fa-dollar-sign me-1"></i>Giá trị tối
											thiểu</th>
										<th><i class="fas fa-sort-numeric-up me-1"></i>Giới hạn</th>
										<th><i class="fas fa-users me-1"></i>Đã sử dụng</th>
										<th><i class="fas fa-calendar-alt me-1"></i>Ngày bắt đầu</th>
										<th><i class="fas fa-calendar-times me-1"></i>Ngày kết
											thúc</th>
										<th><i class="fas fa-toggle-on me-1"></i>Trạng thái</th>
										<th><i class="fas fa-cogs me-1"></i>Hành động</th>
									</tr>
								</thead>
								<tbody>
									<% request.setAttribute("now", new java.util.Date()); %>
									<c:choose>
										<c:when test="${empty vouchers}">
											<tr>
												<td colspan="11" class="text-center text-muted py-4"><i
													class="fas fa-ticket-alt fa-3x mb-3 text-muted"></i>
													<p>Chưa có voucher nào được tạo</p></td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="voucher" items="${vouchers}" varStatus="loop">
												<tr>
													<td data-label="ID"><strong>#${loop.index +
															1}</strong></td>
													<td data-label="Mã voucher"><code>${voucher.code}</code></td>
													<td data-label="Mô tả" title="${voucher.name}">${voucher.name}</td>
													<td data-label="Loại"><c:choose>
															<c:when test="${voucher.voucherType == 'SHIPPING'}">
																<span class="badge bg-info text-dark"> <i
																	class="fas fa-shipping-fast me-1"></i>Vận chuyển
																</span>
															</c:when>
															<c:otherwise>
																<span class="badge bg-primary"> <i
																	class="fas fa-box me-1"></i>Sản phẩm
																</span>
															</c:otherwise>
														</c:choose></td>
													<td data-label="Giảm giá"><c:choose>
															<c:when test="${voucher.discountType == 'PERCENTAGE'}">
																<span class="text-success">${voucher.discountValue}%</span>
															</c:when>
															<c:otherwise>
																<span class="text-success"><fmt:formatNumber
																		value="${voucher.discountValue}" pattern="#,###" />đ</span>
															</c:otherwise>
														</c:choose></td>
													<td data-label="Giá trị tối thiểu"><c:choose>
															<c:when test="${voucher.minOrderAmount > 0}">
																<fmt:formatNumber value="${voucher.minOrderAmount}"
																	pattern="#,###" />đ
                                                        </c:when>
															<c:otherwise>
																<span class="text-muted">Không yêu cầu</span>
															</c:otherwise>
														</c:choose></td>
													<td data-label="Giới hạn"><c:choose>
															<c:when test="${voucher.usageLimit > 0}">
                                                            ${voucher.usageLimit}
                                                        </c:when>
															<c:otherwise>
																<span class="text-muted">Không giới hạn</span>
															</c:otherwise>
														</c:choose></td>
													<td data-label="Đã sử dụng">${voucher.usedCount}</td>
													<td data-label="Ngày bắt đầu"><fmt:formatDate
															value="${voucher.startDate}" pattern="dd/MM/yyyy HH:mm" />
													</td>
													<td data-label="Ngày kết thúc"><fmt:formatDate
															value="${voucher.endDate}" pattern="dd/MM/yyyy HH:mm" />
													</td>
													<td data-label="Trạng thái"><c:choose>
															<c:when test="${not voucher.active}">
																<span class="badge-inactive">Tạm ngưng</span>
															</c:when>
															<c:when
																test="${voucher.startDate != null && voucher.startDate.time > now.time}">
																<span class="badge-inactive">Chưa bắt đầu</span>
															</c:when>
															<c:when
																test="${voucher.endDate != null && voucher.endDate.time < now.time}">
																<span class="badge-inactive">Hết hạn</span>
															</c:when>
															<c:when
																test="${voucher.usageLimit > 0 && voucher.usedCount >= voucher.usageLimit}">
																<span class="badge-inactive">Hết lượt</span>
															</c:when>
															<c:otherwise>
																<span class="badge-active">Đang hoạt động</span>
															</c:otherwise>
														</c:choose></td>
                                                    <td class="actions" data-label="Hành động">
                                                        <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                                                            <div class="btn-group" role="group">
                                                                <a
                                                                    href="${pageContext.request.contextPath}/admin/voucher?action=edit&id=${voucher.id}"
                                                                    class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>
                                                                <button type="button"
                                                                    class="btn btn-sm btn-outline-danger"
                                                                    onclick="confirmDelete(${voucher.id}, '${voucher.code}')"
                                                                    title="Xóa">
                                                                    <i class="fas fa-trash"></i>
                                                                </button>
                                                            </div>
                                                        </c:if>
                                                    </td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Delete Confirmation Modal -->
	<div class="modal fade" id="deleteModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Xác nhận xóa</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<p>
						Bạn có chắc chắn muốn xóa voucher <strong id="voucherCode"></strong>?
					</p>
					<p class="text-danger">
						<small>Hành động này không thể hoàn tác.</small>
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Hủy</button>
					<a href="#" id="deleteLink" class="btn btn-danger">Xóa</a>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        function confirmDelete(id, code) {
            document.getElementById('voucherCode').textContent = code;
            document.getElementById('deleteLink').href = '${pageContext.request.contextPath}/admin/voucher?action=delete&id=' + id;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
        
        // Auto hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>
