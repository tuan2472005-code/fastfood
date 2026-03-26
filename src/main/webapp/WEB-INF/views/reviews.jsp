<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đánh giá sản phẩm - Fast Food</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
.review-item {
	border-bottom: 1px solid #eee;
	padding: 20px 0;
}

.review-item:last-child {
	border-bottom: none;
}

.review-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.review-author {
	font-weight: 600;
	color: #2c3e50;
}

.review-date {
	font-size: 0.9rem;
	color: #6c757d;
}

.review-content {
	color: #495057;
	line-height: 1.6;
}

.star-rating {
	display: flex;
	align-items: center;
	gap: 5px;
	margin: 10px 0;
}

.stars {
	display: flex;
	gap: 2px;
}

.star {
	color: #ffc107;
	font-size: 1rem;
}

.star.empty {
	color: #ddd;
}

.rating-text {
	font-size: 0.9rem;
	color: #6c757d;
	margin-left: 5px;
}
</style>
</head>
<body>
	<div class="container my-5">
		<div class="row">
			<div class="col-lg-8 mx-auto">
				<div class="card shadow-sm">
					<div class="card-header bg-primary text-white">
						<h5 class="mb-0">
							<i class="fas fa-comments me-2"></i> Đánh giá sản phẩm
						</h5>
					</div>
					<div class="card-body">
						<c:choose>
							<c:when test="${not empty reviews}">
								<c:forEach var="review" items="${reviews}">
									<div class="review-item">
										<div class="review-header">
											<div>
												<div class="review-author">${review.hoTen}</div>
												<div class="star-rating">
													<div class="stars">
														<c:forEach begin="1" end="5" var="i">
															<c:choose>
																<c:when test="${i <= review.rating}">
																	<i class="fas fa-star star"></i>
																</c:when>
																<c:otherwise>
																	<i class="fas fa-star star empty"></i>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</div>
													<span class="rating-text">(${review.rating}/5)</span>
												</div>
											</div>
											<div class="review-date">
												<fmt:formatDate value="${review.ngayTao}"
													pattern="dd/MM/yyyy HH:mm" />
											</div>
										</div>
										<c:if test="${not empty review.binhLuan}">
											<div class="review-content">${review.binhLuan}</div>
										</c:if>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="text-center py-4">
									<i class="fas fa-comment-slash fa-3x text-muted mb-3"></i>
									<p class="text-muted">Chưa có đánh giá nào cho sản phẩm
										này.</p>
									<p class="text-muted">Hãy là người đầu tiên đánh giá!</p>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<div class="text-center mt-4">
					<a
						href="${pageContext.request.contextPath}/product?id=${sanPhamId}"
						class="btn btn-primary"> <i class="fas fa-arrow-left me-2"></i>Quay
						lại sản phẩm
					</a>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	<jsp:include page="/WEB-INF/views/includes/chat-widget.jsp" />
</body>
</html>
