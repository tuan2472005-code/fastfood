<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng nhập - Fast Food</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
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

.login-card {
	background: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(20px);
	border-radius: 25px;
	box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
	overflow: hidden;
	max-width: 1000px;
	width: 100%;
	margin: 0 auto;
}

.login-left {
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

.login-left::before {
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
.login-right {
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

.logo-section img {
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

.btn-login {
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

.btn-login:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(255, 107, 53, 0.4);
}

.btn-login::before {
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

.btn-login:hover::before {
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

.register-link {
	text-align: center;
	margin-top: 2rem;
}

.register-link a {
	color: #ff6b35;
	text-decoration: none;
	font-weight: 600;
	transition: all 0.3s ease;
}

.register-link a:hover {
	color: #e55a2b;
	text-decoration: underline;
}

.alert {
	border-radius: 15px;
	border: none;
	margin-bottom: 1.5rem;
}

/* Responsive */
@media ( max-width : 768px) {
	.login-left {
		display: none;
	}
	.main-container {
		padding: 1rem;
	}
	.login-right {
		padding: 2rem;
	}
	.welcome-text {
		font-size: 2rem;
	}
}
</style>
</head>
<body>
	<!-- Animated Background -->
	<div class="bg-animation"></div>

	<!-- Main Container -->
	<div class="main-container">
		<div class="container">
			<div class="login-card">
				<div class="row g-0">
					<!-- Left Side - Welcome Section -->
					<div class="col-lg-6 login-left">
						<div class="welcome-text">Chào mừng trở lại!</div>
						<div class="welcome-subtitle">Đăng nhập để trải nghiệm những
							món ăn ngon nhất</div>

						<div class="feature-item">
							<div class="feature-icon">
								<i class="fas fa-shipping-fast"></i>
							</div>
							<div>
								<strong>Giao hàng nhanh chóng</strong><br> <small>Miễn
									phí giao hàng cho đơn từ 200.000đ</small>
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

						<div class="feature-item">
							<div class="feature-icon">
								<i class="fas fa-gift"></i>
							</div>
							<div>
								<strong>Ưu đãi hấp dẫn</strong><br> <small>Nhiều
									chương trình khuyến mãi</small>
							</div>
						</div>
					</div>

					<!-- Right Side - Login Form -->
					<div class="col-lg-6 login-right">
						<div class="logo-section">
							<img src="${pageContext.request.contextPath}/images/logofastfood.png" alt="Fast Food Logo" >
							<div class="logo-title">Fast Food</div>
							<div class="logo-subtitle">Hệ thống đặt món trực tuyến</div>
						</div>

						<% if(request.getAttribute("success") != null) { %>
						<div class="toast-container position-fixed top-0 end-0 p-3"
							style="z-index: 1080;">
							<div id="loginSuccessToast"
								class="toast align-items-center text-bg-success border-0"
								role="alert" aria-live="assertive" aria-atomic="true">
								<div class="d-flex">
									<div class="toast-body">
										<i class="fas fa-check-circle me-2"></i><%= request.getAttribute("success") %></div>
									<button type="button"
										class="btn-close btn-close-white me-2 m-auto"
										data-bs-dismiss="toast" aria-label="Close"></button>
								</div>
							</div>
						</div>
						<script>
						document.addEventListener('DOMContentLoaded', function() {
							var el = document.getElementById('loginSuccessToast');
							if (el && window.bootstrap && window.bootstrap.Toast) {
								var t = new bootstrap.Toast(el, {delay: 2500});
								t.show();
							}
						});
						</script>
						<% } %>

						<% if(request.getAttribute("error") != null) { %>
						<div class="alert alert-danger" role="alert">
							<i class="fas fa-exclamation-circle me-2"></i>
							<%= request.getAttribute("error") %>
						</div>
						<% } %>

                        <form action="login" method="post">
                            <c:if test="${not empty param.redirect}">
                                <input type="hidden" name="redirect" value="${param.redirect}">
                            </c:if>
							<div class="form-floating">
								<input type="text" class="form-control" id="username"
									name="username" placeholder="Tên đăng nhập" required> <label
									for="username"><i class="fas fa-user me-2"></i>Tên đăng
									nhập</label>
							</div>

							<div class="form-floating">
								<input type="password" class="form-control" id="password"
									name="password" placeholder="Mật khẩu" required> <label
									for="password"><i class="fas fa-lock me-2"></i>Mật khẩu</label>
							</div>

							<div
								class="d-flex justify-content-between align-items-center mb-3">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="remember">
									<label class="form-check-label" for="remember"> Ghi nhớ
										đăng nhập </label>
								</div>
								<a href="#" class="text-decoration-none">Quên mật khẩu?</a>
							</div>

							<button type="submit"
								class="btn btn-login btn-primary w-100 mb-3">
								<i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
							</button>
                        </form>

						<div class="divider">
							<span>Hoặc đăng nhập với</span>
						</div>

						<div class="social-login">
							<a href="#" class="social-btn"> <i class="fab fa-google me-2"></i>Google
							</a> <a href="#" class="social-btn"> <i
								class="fab fa-facebook-f me-2"></i>Facebook
							</a>
						</div>

						<div class="register-link">
							<p>
								Chưa có tài khoản? <a href="register">Đăng ký ngay</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	<jsp:include page="/WEB-INF/views/includes/chat-widget.jsp" />
</body>
</html>
