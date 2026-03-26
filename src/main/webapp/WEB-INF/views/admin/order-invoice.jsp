<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Hóa đơn #${order.id}</title>
<style>
body {
	font-family: Arial, sans-serif;
	color: #333;
}

.invoice {
	max-width: 900px;
	margin: 0 auto;
	padding: 24px;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 16px;
}

.brand {
	font-weight: 700;
	font-size: 20px;
}

.meta {
	text-align: right;
}

.meta div {
	margin: 2px 0;
}

.section {
	margin-top: 16px;
}

.items {
	width: 100%;
	border-collapse: collapse;
}

.items th, .items td {
	border: 1px solid #ddd;
	padding: 8px;
}

.items th {
	background: #f5f5f5;
}

.totals {
	margin-top: 12px;
	width: 100%;
}

.totals .row {
	display: flex;
	justify-content: space-between;
	margin: 6px 0;
}

.totals .grand {
	font-weight: 700;
	font-size: 18px;
}

.print-actions {
	text-align: right;
	margin-top: 16px;
}

@media print {
	.print-actions {
		display: none;
	}
}
</style>
<script>
        window.addEventListener('load', function() {
            setTimeout(function(){ window.print(); }, 300);
        });
    </script>
</head>
<body>
	<div class="invoice">
		<div class="header">
			<div class="brand">Fast Food</div>
			<div class="meta">
				<div>Hóa đơn #${order.id}</div>
				<div>
					Ngày:
					<fmt:formatDate value="${order.createdAt}"
						pattern="dd/MM/yyyy HH:mm" />
				</div>
			</div>
		</div>

		<div class="section">
			<strong>Khách hàng</strong>
			<div>${order.customerName}</div>
			<div>${order.customerPhone}</div>
			<div>${order.customerAddress}</div>
		</div>

		<div class="section">
			<table class="items">
				<thead>
					<tr>
						<th>Sản phẩm</th>
						<th class="text-end">Giá</th>
						<th class="text-end">SL</th>
						<th class="text-end">Thành tiền</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="computedSubtotal" value="0" />
					<c:forEach var="item" items="${orderItems}">
						<tr>
							<td>${item.productName}</td>
							<td style="text-align: right"><fmt:formatNumber
									value="${item.price}" type="currency" currencySymbol="₫" /></td>
							<td style="text-align: right">${item.quantity}</td>
							<td style="text-align: right"><fmt:formatNumber
									value="${item.subtotal}" type="currency" currencySymbol="₫" /></td>
						</tr>
						<c:set var="computedSubtotal"
							value="${computedSubtotal + item.subtotal}" />
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="section">
			<div class="totals">
				<div class="row">
					<span>Tạm tính</span><span><fmt:formatNumber
							value="${computedSubtotal}" type="currency" currencySymbol="₫" /></span>
				</div>
				<c:if
					test="${not empty order.discountAmount && order.discountAmount > 0}">
					<div class="row">
						<span>Giảm giá sản phẩm (${order.voucherCode})</span><span>-<fmt:formatNumber
								value="${order.discountAmount}" type="currency"
								currencySymbol="₫" /></span>
					</div>
				</c:if>
				<c:set var="shippingDiscount"
					value="${empty order.shippingDiscountAmount ? 0 : order.shippingDiscountAmount}" />
				<c:set var="finalShippingFee"
					value="${order.shippingFee - shippingDiscount}" />
				<c:if test="${finalShippingFee < 0}">
					<c:set var="finalShippingFee" value="0" />
				</c:if>
				<div class="row">
					<span>Phí giao hàng</span><span><fmt:formatNumber
							value="${finalShippingFee}" type="currency" currencySymbol="₫" /></span>
				</div>
				<c:if test="${shippingDiscount > 0}">
					<div class="row">
						<span>Giảm phí giao hàng (${order.shippingVoucherCode})</span><span
							class="text-success">-<fmt:formatNumber
								value="${shippingDiscount}" type="currency" currencySymbol="₫" /></span>
					</div>
				</c:if>
				<div class="row grand">
					<span>Tổng cộng</span><span><fmt:formatNumber
							value="${order.totalAmount}" type="currency" currencySymbol="₫" /></span>
				</div>
			</div>
		</div>

		<div class="section">
			<strong>Ghi chú</strong>
			<div style="white-space: pre-line;">${order.note}</div>
		</div>

		<div class="print-actions">
			<button onclick="window.print()">In hóa đơn</button>
			<a
				href="${pageContext.request.contextPath}/admin/orders?action=view&id=${order.id}">Quay
				lại</a>
		</div>
	</div>
</body>
</html>
