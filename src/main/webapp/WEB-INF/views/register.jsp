<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng ký - Fast Food</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<style>
* {
	font-family: 'Poppins', sans-serif;
}

body {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	min-height: 100vh;
	overflow-x: hidden;
}

/* Animated Background */
.bg-animation {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	z-index: -1;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.bg-animation::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background:
		url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><radialGradient id="a" cx="50%" cy="50%" r="50%"><stop offset="0%" stop-color="rgba(255,255,255,0.1)"/><stop offset="100%" stop-color="rgba(255,255,255,0)"/></radialGradient></defs><circle cx="20" cy="20" r="20" fill="url(%23a)"><animate attributeName="cx" values="20;80;20" dur="10s" repeatCount="indefinite"/></circle><circle cx="80" cy="80" r="15" fill="url(%23a)"><animate attributeName="cy" values="80;20;80" dur="8s" repeatCount="indefinite"/></circle></svg>');
	animation: float 20s ease-in-out infinite;
}

@
keyframes float { 0%, 100% {
	transform: translateY(0px);
}

50


%
{
transform


:


translateY
(


-20px


)
;


}
}

/* Main Container */
.main-container {
	min-height: 100vh;
	display: flex;
	align-items: center;
	padding: 2rem 0;
}

.register-card {
	background: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(20px);
	border-radius: 25px;
	box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
	overflow: hidden;
	max-width: 1200px;
	width: 100%;
	margin: 0 auto;
}

.register-left {
	background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
	color: white;
	padding: 3rem;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
	position: relative;
	overflow: hidden;
}

.register-left::before {
	content: '';
	position: absolute;
	top: -50%;
	left: -50%;
	width: 200%;
	height: 200%;
	background:
		url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="2" fill="rgba(255,255,255,0.1)"><animate attributeName="r" values="2;10;2" dur="3s" repeatCount="indefinite"/></circle></svg>');
	animation: rotate 30s linear infinite;
}

@
keyframes rotate {from { transform:rotate(0deg);
	
}

to {
	transform: rotate(360deg);
}

}
.register-right {
	padding: 3rem;
	background: white;
}

.welcome-text {
	font-size: 2.5rem;
	font-weight: 700;
	margin-bottom: 1rem;
	position: relative;
	z-index: 2;
}

.welcome-subtitle {
	font-size: 1.1rem;
	opacity: 0.9;
	margin-bottom: 2rem;
	position: relative;
	z-index: 2;
}

.feature-item {
	display: flex;
	align-items: center;
	margin-bottom: 1rem;
	position: relative;
	z-index: 2;
}

.feature-icon {
	width: 40px;
	height: 40px;
	background: rgba(255, 255, 255, 0.2);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 1rem;
	font-size: 1.2rem;
}

.logo-section {
	text-align: center;
	margin-bottom: 2rem;
}

.logo-section video {
	height: 80px;
	margin-bottom: 1rem;
}

.logo-title {
	font-size: 2rem;
	font-weight: 700;
	color: #333;
	margin-bottom: 0.5rem;
}

.logo-subtitle {
	color: #666;
	font-size: 0.9rem;
}

.form-floating {
	margin-bottom: 1.5rem;
}

.form-floating>.form-control {
	border: 2px solid #e9ecef;
	border-radius: 15px;
	padding: 1rem 0.75rem;
	height: auto;
	background: #f8f9fa;
	transition: all 0.3s ease;
}

.form-floating>.form-control:focus {
	border-color: #ff6b35;
	box-shadow: 0 0 0 0.2rem rgba(255, 107, 53, 0.25);
	background: white;
}

.form-floating>label {
	color: #666;
	font-weight: 500;
}

.btn-register {
	background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
	border: none;
	border-radius: 15px;
	padding: 1rem;
	font-weight: 600;
	font-size: 1.1rem;
	transition: all 0.3s ease;
	position: relative;
	overflow: hidden;
}

.btn-register:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(255, 107, 53, 0.4);
}

.btn-register::before {
	content: '';
	position: absolute;
	top: 0;
	left: -100%;
	width: 100%;
	height: 100%;
	background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2),
		transparent);
	transition: left 0.5s;
}

.btn-register:hover::before {
	left: 100%;
}

.divider {
	text-align: center;
	margin: 2rem 0;
	position: relative;
}

.divider::before {
	content: '';
	position: absolute;
	top: 50%;
	left: 0;
	right: 0;
	height: 1px;
	background: #e9ecef;
}

.divider span {
	background: white;
	padding: 0 1rem;
	color: #666;
	font-size: 0.9rem;
}

.social-login {
	display: flex;
	gap: 1rem;
	margin-bottom: 2rem;
}

.social-btn {
	flex: 1;
	padding: 0.75rem;
	border: 2px solid #e9ecef;
	border-radius: 10px;
	background: white;
	color: #666;
	text-decoration: none;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: all 0.3s ease;
}

.social-btn:hover {
	border-color: #ff6b35;
	color: #ff6b35;
	transform: translateY(-2px);
}

.login-link {
	text-align: center;
	margin-top: 2rem;
}

.login-link a {
	color: #ff6b35;
	text-decoration: none;
	font-weight: 600;
	transition: all 0.3s ease;
}

.login-link a:hover {
	color: #e55a2b;
	text-decoration: underline;
}

.alert {
	border-radius: 15px;
	border: none;
	margin-bottom: 1.5rem;
}

.form-row {
	display: flex;
	gap: 1rem;
}

.form-row .form-floating {
	flex: 1;
}

/* Responsive */
@media ( max-width : 768px) {
	.register-left {
		display: none;
	}
	.main-container {
		padding: 1rem;
	}
	.register-right {
		padding: 2rem;
	}
	.welcome-text {
		font-size: 2rem;
	}
	.form-row {
		flex-direction: column;
		gap: 0;
	}
}
</style>
</head>
<body>
	<div class="bg-animation"></div>

	<div class="main-container">
		<div class="container">
			<div class="register-card">
				<div class="row g-0">
					<div class="col-lg-5 register-left">
						<div class="welcome-text">Tham gia cùng chúng tôi!</div>
						<div class="welcome-subtitle">Tạo tài khoản để trải nghiệm
							những món ăn tuyệt vời</div>

						<div class="feature-item">
							<div class="feature-icon">
								<i class="fas fa-hamburger"></i>
							</div>
							<div>
								<strong>Thực đơn đa dạng</strong><br> <small>Hàng
									trăm món ăn ngon từ khắp nơi</small>
							</div>
						</div>

						<div class="feature-item">
							<div class="feature-icon">
								<i class="fas fa-shipping-fast"></i>
							</div>
							<div>
								<strong>Giao hàng nhanh</strong><br> <small>Chỉ 30
									phút là có món ăn yêu thích</small>
							</div>
						</div>

						<div class="feature-item">
							<div class="feature-icon">
								<i class="fas fa-gift"></i>
							</div>
							<div>
								<strong>Ưu đãi hấp dẫn</strong><br> <small>Giảm giá
									20% cho thành viên mới</small>
							</div>
						</div>

						<div class="feature-item">
							<div class="feature-icon">
								<i class="fas fa-star"></i>
							</div>
							<div>
								<strong>Chất lượng đảm bảo</strong><br> <small>Nguyên
									liệu tươi ngon, an toàn</small>
							</div>
						</div>
					</div>

					<div class="col-lg-7 register-right">
						<div class="logo-section">
							<video
								src="${pageContext.request.contextPath}/images/logofastfood.mp4"
								autoplay muted loop></video>
							<div class="logo-title">Fast Food</div>
							<div class="logo-subtitle">Đăng ký tài khoản mới</div>
						</div>

						<c:if test="${not empty error}">
							<div class="alert alert-danger" role="alert">
								<i class="fas fa-exclamation-triangle me-2"></i>${error}
							</div>
						</c:if>

						<c:if test="${not empty success}">
							<div class="alert alert-success" role="alert">
								<i class="fas fa-check-circle me-2"></i>${success}
							</div>
						</c:if>

						<c:if test="${not empty infoMessage}">
							<div class="alert alert-info" role="alert">
								<i class="fas fa-info-circle me-2"></i>${infoMessage}
							</div>
						</c:if>

						<c:if test="${empty otpStep}">
							<form action="${pageContext.request.contextPath}/register"
								method="post">
								<div class="form-row">
									<div class="form-floating">
										<input type="text" class="form-control" id="firstName"
											name="firstName" placeholder="Họ" required> <label
											for="firstName"><i class="fas fa-user me-2"></i>Họ</label>
									</div>
									<div class="form-floating">
										<input type="text" class="form-control" id="lastName"
											name="lastName" placeholder="Tên" required> <label
											for="lastName"><i class="fas fa-user me-2"></i>Tên</label>
									</div>
								</div>

								<div class="form-floating">
									<input type="email" class="form-control" id="email"
										name="email" placeholder="Email" required> <label
										for="email"><i class="fas fa-envelope me-2"></i>Email</label>
								</div>

								<div class="form-floating">
									<input type="text" class="form-control" id="username"
										name="username" placeholder="Tên đăng nhập" required>
									<label for="username"><i
										class="fas fa-user-circle me-2"></i>Tên đăng nhập</label>
								</div>

								<div class="form-floating">
									<input type="tel" class="form-control" id="phone" name="phone"
										placeholder="Số điện thoại" required> <label
										for="phone"><i class="fas fa-phone me-2"></i>Số điện
										thoại</label>
								</div>

								<div class="form-row">
									<div class="form-floating">
										<input type="password" class="form-control" id="password"
											name="password" placeholder="Mật khẩu" required> <label
											for="password"><i class="fas fa-lock me-2"></i>Mật
											khẩu</label>
									</div>
									<div class="form-floating">
										<input type="password" class="form-control"
											id="confirmPassword" name="confirmPassword"
											placeholder="Xác nhận mật khẩu" required> <label
											for="confirmPassword"><i class="fas fa-lock me-2"></i>Xác
											nhận mật khẩu</label>
									</div>
								</div>

								<div class="form-floating">
									<input type="text" class="form-control" id="address"
										name="address" placeholder="Địa chỉ" required> <label
										for="address"><i class="fas fa-map-marker-alt me-2"></i>Địa
										chỉ</label>
								</div>

								<div class="d-grid">
									<button type="submit" class="btn btn-register text-white">
										<i class="fas fa-user-plus me-2"></i>Tạo tài khoản
									</button>
								</div>
							</form>
						</c:if>

						<c:if test="${otpStep}">
							<form
								action="${pageContext.request.contextPath}/register?step=verify"
								method="post">
								<div class="form-floating">
									<input type="text" class="form-control" id="otp" name="otp"
										placeholder="Nhập mã OTP" required> <label for="otp"><i
										class="fas fa-key me-2"></i>Mã OTP</label>
								</div>
								<div class="d-grid">
									<button type="submit" class="btn btn-register text-white">
										<i class="fas fa-shield-alt me-2"></i>Xác thực OTP
									</button>
								</div>
								<c:if test="${not empty targetEmail}">
									<div class="text-muted mt-2">Đã gửi mã tới:
										${targetEmail}</div>
								</c:if>
								<c:if test="${not empty debugOtp}">
									<div class="text-muted mt-1">
										Mã thử nghiệm: <strong>${debugOtp}</strong>
									</div>
								</c:if>
							</form>
							<form
								action="${pageContext.request.contextPath}/register?step=resend"
								method="post" class="mt-2">
								<button type="submit" class="btn btn-outline-primary w-100">
									<i class="fas fa-paper-plane me-2"></i>Gửi lại OTP
								</button>
							</form>
						</c:if>

						<div class="divider">
							<span>hoặc đăng ký với</span>
						</div>

						<div class="social-login">
							<a href="#" class="social-btn"> <i class="fab fa-google me-2"></i>Google
							</a> <a href="#" class="social-btn"> <i
								class="fab fa-facebook me-2"></i>Facebook
							</a>
						</div>

						<div class="login-link">
							Đã có tài khoản? <a
								href="${pageContext.request.contextPath}/login">Đăng nhập
								ngay</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        // Validate password confirmation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (password !== confirmPassword) {
                this.setCustomValidity('Mật khẩu xác nhận không khớp');
            } else {
                this.setCustomValidity('');
            }
        });
    </script>
    <jsp:include page="/WEB-INF/views/includes/chat-widget.jsp" />
</body>
</html>
