<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đặt hàng thành công - Fast Food</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<style>
body {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	margin: 0;
	padding: 20px;
	box-sizing: border-box;
}

.success-container {
	background: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(10px);
	border-radius: 25px;
	box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
	padding: 3rem;
	text-align: center;
	max-width: 700px;
	width: 100%;
	border: 1px solid rgba(255, 255, 255, 0.2);
	margin: auto;
}

@media ( max-width : 768px) {
	.success-container {
		padding: 2rem;
		margin: 10px;
		max-width: calc(100% - 20px);
	}
}

.success-icon {
	width: 120px;
	height: 120px;
	background: linear-gradient(135deg, #4CAF50, #45a049);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto 2rem;
	animation: successPulse 2s infinite;
	box-shadow: 0 10px 30px rgba(76, 175, 80, 0.3);
}

@
keyframes successPulse { 0% {
	transform: scale(1);
	box-shadow: 0 10px 30px rgba(76, 175, 80, 0.3);
}

50


%
{
transform


:


scale
(


1
.05


)
;


box-shadow


:


0


15px


40px


rgba
(


76
,
175
,
80
,
0
.4


)
;


}
100


%
{
transform


:


scale
(


1


)
;


box-shadow


:


0


10px


30px


rgba
(


76
,
175
,
80
,
0
.3


)
;


}
}
.order-info {
	background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
	border-radius: 20px;
	padding: 2.5rem;
	margin: 2rem 0;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
	border: 1px solid rgba(0, 0, 0, 0.05);
}

.order-items {
	background: white;
	border-radius: 15px;
	padding: 1.5rem;
	margin-top: 1rem;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.order-items .border-bottom:last-child {
	border-bottom: none !important;
}

.btn-action {
	border-radius: 15px;
	padding: 15px 35px;
	font-weight: 600;
	margin: 0.5rem;
	transition: all 0.3s ease;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.btn-primary {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	border: none;
	color: white;
}

.btn-primary:hover {
	background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
	transform: translateY(-2px);
	box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
}

.btn-warning {
	background: linear-gradient(135deg, #ff9a56 0%, #ff6b35 100%);
	border: none;
	color: white;
}

.btn-warning:hover {
	background: linear-gradient(135deg, #ff8a46 0%, #e55a2b 100%);
	transform: translateY(-2px);
	box-shadow: 0 8px 25px rgba(255, 107, 53, 0.3);
}

.alert-info {
	background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
	border: 1px solid #2196f3;
	border-radius: 15px;
}

.badge {
	padding: 8px 15px;
	border-radius: 20px;
	font-size: 0.85rem;
}

.text-primary {
	color: #667eea !important;
}

.border-bottom {
	border-bottom: 1px solid #e9ecef !important;
}

h2, h4, h5, h6 {
	color: #2c3e50;
}

.lead {
	color: #6c757d;
	font-size: 1.1rem;
}
</style>
</head>
<body>
	<div class="success-container">
		<div class="success-icon">
			<i class="fas fa-check fa-3x text-white"></i>
		</div>

		<h2 class="text-success mb-3">Đặt hàng thành công!</h2>
		<p class="lead text-muted mb-4">${message}</p>

		<div class="order-info">
			<h5 class="mb-3">
				<i class="fas fa-receipt me-2 text-primary"></i>Thông tin đơn hàng
			</h5>
			<div class="row">
				<div class="col-md-6">
					<p>
						<strong>Mã đơn hàng:</strong>
					</p>
					<h4 class="text-primary">#${orderId}</h4>
				</div>
				<div class="col-md-6">
					<p>
						<strong>Trạng thái:</strong>
					</p>
					<c:choose>
						<c:when test="${paymentMethod == 'COD'}">
							<span class="badge bg-success fs-6">Đã xác nhận</span>
						</c:when>
						<c:otherwise>
							<span class="badge bg-warning fs-6">Chờ thanh toán</span>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div class="row mt-3">
				<div class="col-md-6">
					<p>
						<strong>Phương thức thanh toán:</strong>
					</p>
					<c:choose>
						<c:when test="${paymentMethod == 'COD'}">
							<span class="badge bg-success">Thanh toán khi nhận hàng</span>
						</c:when>
						<c:when test="${paymentMethod == 'BANK_TRANSFER'}">
							<span class="badge bg-info">Chuyển khoản ngân hàng</span>
						</c:when>
						<c:otherwise>
							<span class="badge bg-primary">QR Code</span>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="col-md-6">
					<p>
						<strong>Chi tiết thanh toán:</strong>
					</p>
					<div class="mb-2">
						<span>Tạm tính: </span> <span><fmt:formatNumber
								value="${subtotal}" type="currency" currencySymbol="₫" /></span>
					</div>
					<div class="mb-2">
						<span>Phí vận chuyển: </span> <span><fmt:formatNumber
								value="${shippingFee}" type="currency" currencySymbol="₫" /></span>
					</div>
					<!-- Product Discount -->
                    <c:if
                        test="${not empty sessionScope.appliedProductVoucher and not empty sessionScope.productDiscountAmount and sessionScope.productDiscountAmount > 0}">
                        <div class="mb-2 text-info">
                            <span><i class="fas fa-tag me-1"></i>Giảm giá sản phẩm
                                (${sessionScope.appliedProductVoucher.code}): </span> <span>-<fmt:formatNumber
                                    value="${sessionScope.productDiscountAmount}" type="currency"
                                    currencySymbol="₫" /></span>
                        </div>
                    </c:if>
                    <!-- Shipping Discount -->
                    <c:if
                        test="${not empty sessionScope.appliedShippingVoucher and not empty sessionScope.shippingDiscountAmount and sessionScope.shippingDiscountAmount > 0}">
                        <div class="mb-2 text-success">
                            <span><i class="fas fa-shipping-fast me-1"></i>Giảm giá
                                vận chuyển (${sessionScope.appliedShippingVoucher.code}): </span> <span>-<fmt:formatNumber
                                    value="${sessionScope.shippingDiscountAmount}" type="currency"
                                    currencySymbol="₫" /></span>
                        </div>
                    </c:if>
					<hr>
					<div class="fw-bold">
						<span>Tổng cộng: </span> <span class="text-danger"><fmt:formatNumber
								value="${totalAmount}" type="currency" currencySymbol="₫" /></span>
					</div>
				</div>
			</div>

			<!-- Chi tiết sản phẩm trong đơn hàng -->
			<c:if test="${not empty sessionScope.cart}">
				<hr>
				<h6 class="mb-3">
					<i class="fas fa-shopping-bag me-2 text-primary"></i>Chi tiết đơn
					hàng
				</h6>
				<div class="order-items">
					<c:forEach var="item" items="${sessionScope.cart}">
						<div
							class="d-flex justify-content-between align-items-center py-2 border-bottom">
							<div class="d-flex align-items-center">
								<div class="me-3">
									<img
										src="${pageContext.request.contextPath}/images/${item.product.image}"
										alt="${item.product.name}" class="rounded"
										style="width: 50px; height: 50px; object-fit: cover;">
								</div>
								<div>
									<h6 class="mb-1">${item.product.name}</h6>
									<small class="text-muted"> <fmt:formatNumber
											value="${item.product.price}" type="currency"
											currencySymbol="₫" /> x ${item.quantity}
									</small>
								</div>
							</div>
							<div class="text-end">
								<strong> <fmt:formatNumber
										value="${item.product.price * item.quantity}" type="currency"
										currencySymbol="₫" />
								</strong>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:if>

			<!-- Hiển thị thông tin chuyển khoản nếu không phải COD -->
			<c:if test="${paymentMethod != 'COD'}">
				<hr>
				<div class="alert alert-info">
					<h6 class="alert-heading">
						<i class="fas fa-university me-2"></i>Thông tin chuyển khoản
					</h6>
					<div class="row">
						<div class="col-md-6">
							<strong>Ngân hàng:</strong> MB Bank<br> <strong>Số
								tài khoản:</strong> tuanne247<br> <strong>Chủ tài khoản:</strong>
							NGUYEN MINH TUAN
						</div>
						<div class="col-md-6">
							<strong>Số tiền:</strong> <span class="text-danger"><fmt:formatNumber
									value="${totalAmount}" type="currency" currencySymbol="₫" /></span><br>
							<strong>Nội dung:</strong> Thanh toán đơn hàng ${orderId}
						</div>
					</div>
					<div class="mt-2">
						<small class="text-muted"> <i
							class="fas fa-exclamation-triangle me-1"></i> Vui lòng chuyển
							khoản đúng số tiền và nội dung để đơn hàng được xử lý nhanh
							chóng.
						</small>
					</div>
				</div>
			</c:if>

			<hr>

			<div class="text-start">
				<h6>
					<i class="fas fa-info-circle me-2"></i>Lưu ý:
				</h6>
				<ul class="text-muted">
					<c:choose>
						<c:when test="${paymentMethod == 'COD'}">
							<li>Đơn hàng đã được xác nhận và sẽ được xử lý ngay</li>
							<li>Chúng tôi sẽ gọi điện xác nhận trước khi giao hàng</li>
							<li>Thời gian giao hàng dự kiến: 30-45 phút</li>
							<li>Vui lòng chuẩn bị tiền mặt khi nhận hàng</li>
						</c:when>
						<c:otherwise>
							<li>Đơn hàng sẽ được xác nhận sau khi chúng tôi nhận được
								thanh toán</li>
							<li>Vui lòng chuyển khoản trong vòng 30 phút để giữ đơn hàng</li>
							<li>Admin sẽ xác nhận đơn hàng sau khi kiểm tra thanh toán</li>
							<li>Thời gian giao hàng: 30-45 phút sau khi xác nhận thanh
								toán</li>
						</c:otherwise>
					</c:choose>
					<li>Bạn có thể theo dõi đơn hàng qua số điện thoại đã đăng ký</li>
				</ul>
			</div>
		</div>

		<div class="d-flex flex-wrap justify-content-center">
			<a href="${pageContext.request.contextPath}/home"
				class="btn btn-primary btn-action"> <i class="fas fa-home me-2"></i>Về
				trang chủ
			</a> <a href="${pageContext.request.contextPath}/products"
				class="btn btn-warning btn-action"> <i
				class="fas fa-utensils me-2"></i>Đặt thêm món
			</a>
		</div>

		<div class="mt-4 pt-3 border-top">
			<p class="text-muted mb-0">
				<i class="fas fa-phone me-2"></i>Hotline hỗ trợ: <strong
					class="text-primary">1900-1234</strong>
			</p>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        // Auto redirect after 10 seconds
        setTimeout(function() {
            if (confirm('Bạn có muốn quay về trang chủ không?')) {
                window.location.href = '${pageContext.request.contextPath}/home';
            }
        }, 10000);
    </script>
</body>
</html>
