package com.fastfood.controller;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 

import com.fastfood.dao.UserDAO;
import com.fastfood.model.User;
 

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO = new UserDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String step = request.getParameter("step");
        if ("verify".equals(step)) {
            HttpSession session = request.getSession();
            String inputOtp = request.getParameter("otp");
            String sessionOtp = (String) session.getAttribute("otpCode");
            Timestamp expiresAt = (Timestamp) session.getAttribute("otpExpiresAt");
            User pendingUser = (User) session.getAttribute("pendingUser");
            if (pendingUser == null || sessionOtp == null || expiresAt == null) {
                request.setAttribute("error", "Phiên xác thực không hợp lệ");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }
            long now = System.currentTimeMillis();
            if (!sessionOtp.equals(inputOtp)) {
                request.setAttribute("otpStep", true);
                request.setAttribute("error", "Mã OTP không đúng");
                request.setAttribute("targetEmail", pendingUser.getEmail());
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }
            if (expiresAt.getTime() < now) {
                request.setAttribute("otpStep", true);
                request.setAttribute("error", "Mã OTP đã hết hạn");
                request.setAttribute("targetEmail", pendingUser.getEmail());
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }
            boolean success = userDAO.registerUser(pendingUser);
            session.removeAttribute("pendingUser");
            session.removeAttribute("otpCode");
            session.removeAttribute("otpExpiresAt");
            if (success) {
                request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            }
            return;
        }
        if ("verifyLink".equals(step)) {
            String token = request.getParameter("token");
            PendingRecord rec = token != null ? TOKEN_STORE.remove(token) : null;
            if (rec == null || rec.expiresAt < System.currentTimeMillis()) {
                request.setAttribute("error", "Liên kết xác thực không hợp lệ hoặc đã hết hạn");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }
            boolean success = userDAO.registerUser(rec.user);
            if (success) {
                request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            }
            return;
        }
        if ("resend".equals(step)) {
            HttpSession session = request.getSession();
            User pendingUser = (User) session.getAttribute("pendingUser");
            if (pendingUser == null) {
                request.setAttribute("error", "Phiên xác thực không hợp lệ");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }
            String otp = generateOtp();
            session.setAttribute("otpCode", otp);
            session.setAttribute("otpExpiresAt", new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000));
            String token = java.util.UUID.randomUUID().toString().replaceAll("-", "");
            TOKEN_STORE.put(token, new PendingRecord(pendingUser, System.currentTimeMillis() + 5 * 60 * 1000));
            boolean mailSent = sendOtpEmail(pendingUser.getEmail(), otp, token);
            request.setAttribute("otpStep", true);
            request.setAttribute("targetEmail", pendingUser.getEmail());
            if (!mailSent) {
                request.setAttribute("infoMessage", "Không gửi được email, vui lòng nhập mã OTP hiển thị");
                request.setAttribute("debugOtp", otp);
            } else {
                request.setAttribute("success", "Đã gửi lại mã OTP");
            }
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        String fullName = "";
        if (firstName != null && !firstName.trim().isEmpty()) {
            fullName += firstName.trim();
        }
        if (lastName != null && !lastName.trim().isEmpty()) {
            if (!fullName.isEmpty()) {
                fullName += " ";
            }
            fullName += lastName.trim();
        }

        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        if (userDAO.getUserByUsername(username) != null) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        if (userDAO.getUserByEmail(email) != null) {
            request.setAttribute("error", "Email đã được sử dụng");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        user.setRole("KHACH_HANG");

        HttpSession session = request.getSession();
        String otp = generateOtp();
        String token = UUID.randomUUID().toString().replaceAll("-", "");
        session.setAttribute("pendingUser", user);
        session.setAttribute("otpCode", otp);
        session.setAttribute("otpExpiresAt", new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000));
        TOKEN_STORE.put(token, new PendingRecord(user, System.currentTimeMillis() + 5 * 60 * 1000));

        boolean mailSent = sendOtpEmail(email, otp, token);
        request.setAttribute("otpStep", true);
        request.setAttribute("targetEmail", email);
        if (!mailSent) {
            request.setAttribute("infoMessage", "Không gửi được email, vui lòng nhập mã OTP hiển thị");
            request.setAttribute("debugOtp", otp);
        }
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    private String generateOtp() {
        SecureRandom random = new SecureRandom();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }

    private boolean sendOtpEmail(String toEmail, String otp, String token) {
        String host = getServletContext().getInitParameter("mail.smtp.host");
        String port = getServletContext().getInitParameter("mail.smtp.port");
        String username = getServletContext().getInitParameter("mail.smtp.username");
        String password = getServletContext().getInitParameter("mail.smtp.password");
        String from = getServletContext().getInitParameter("mail.smtp.from");
        String baseUrl = getServletContext().getInitParameter("app.baseUrl");
        if (host == null || host.isEmpty()) host = System.getenv("SMTP_HOST");
        if (port == null || port.isEmpty()) port = System.getenv("SMTP_PORT");
        if (username == null || username.isEmpty()) username = System.getenv("SMTP_USERNAME");
        if (password == null || password.isEmpty()) password = System.getenv("SMTP_PASSWORD");
        if (from == null || from.isEmpty()) from = System.getenv("SMTP_FROM");
        if (baseUrl == null || baseUrl.isEmpty()) {
            String envBase = System.getenv("APP_BASE_URL");
            baseUrl = (envBase != null && !envBase.isEmpty()) ? envBase : "http://localhost:8082/fastfood";
        }
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        if ("465".equals(port)) {
            props.put("mail.smtp.ssl.enable", "true");
        } else {
            props.put("mail.smtp.starttls.enable", "true");
        }
        props.put("mail.smtp.host", host != null ? host : "");
        props.put("mail.smtp.port", port != null ? port : "");
        props.put("mail.smtp.ssl.trust", host != null ? host : "");
        if (username == null || username.isEmpty() || host == null || host.isEmpty()) {
            String link = (baseUrl != null ? baseUrl : "") + "/register?step=verifyLink&token=" + token;
            String subject = "Xác thực đăng ký";
            String body = "Mã OTP của bạn là: " + otp + "\nMã sẽ hết hạn sau 5 phút.\n\n" +
                          "Hoặc bấm vào liên kết để xác thực mà không cần nhập mã: " + link;
            boolean apiSent = sendEmailViaResend(from, toEmail, subject, body);
            return apiSent;
        }
        try {
            Class<?> sessionCls = Class.forName("jakarta.mail.Session");
            Class<?> authenticatorCls = Class.forName("jakarta.mail.Authenticator");
            Object mailSession = sessionCls
                .getMethod("getInstance", Properties.class, authenticatorCls)
                .invoke(null, props, null);

            Class<?> mimeMessageCls = Class.forName("jakarta.mail.internet.MimeMessage");
            Object message = mimeMessageCls.getConstructor(sessionCls).newInstance(mailSession);

            Class<?> internetAddressCls = Class.forName("jakarta.mail.internet.InternetAddress");
            Object fromAddress = internetAddressCls.getConstructor(String.class)
                .newInstance((from != null && !from.isEmpty()) ? from : username);
            mimeMessageCls.getMethod("setFrom", internetAddressCls).invoke(message, fromAddress);

            Class<?> messageCls = Class.forName("jakarta.mail.Message");
            Class<?> recipientTypeCls = Class.forName("jakarta.mail.Message$RecipientType");
            Class<?> addressesArrayCls = Class.forName("[Ljakarta.mail.Address;");
            Object toAddresses = internetAddressCls.getMethod("parse", String.class).invoke(null, toEmail);
            Object toType = recipientTypeCls.getField("TO").get(null);
            mimeMessageCls.getMethod("setRecipients", recipientTypeCls, addressesArrayCls).invoke(message, toType, toAddresses);

            String link = baseUrl + "/register?step=verifyLink&token=" + token;
            mimeMessageCls.getMethod("setSubject", String.class).invoke(message, "Xác thực đăng ký");
            String body = "Mã OTP của bạn là: " + otp + "\nMã sẽ hết hạn sau 5 phút.\n\n" +
                          "Hoặc bấm vào liên kết để xác thực mà không cần nhập mã: " + link;
            mimeMessageCls.getMethod("setText", String.class).invoke(message, body);

            Class<?> transportCls = Class.forName("jakarta.mail.Transport");
            Object transport = sessionCls.getMethod("getTransport", String.class).invoke(mailSession, "smtp");
            transportCls.getMethod("connect", String.class, String.class, String.class)
                .invoke(transport, host, username, password);
            transportCls.getMethod("sendMessage", messageCls, addressesArrayCls).invoke(transport, message, toAddresses);
            transportCls.getMethod("close").invoke(transport);
            return true;
        } catch (Exception e) {
            String link = (baseUrl != null ? baseUrl : "") + "/register?step=verifyLink&token=" + token;
            String subject = "Xác thực đăng ký";
            String body = "Mã OTP của bạn là: " + otp + "\nMã sẽ hết hạn sau 5 phút.\n\n" +
                          "Hoặc bấm vào liên kết để xác thực mà không cần nhập mã: " + link;
            boolean apiSent = sendEmailViaResend(from, toEmail, subject, body);
            return apiSent;
        }
    }

    private boolean sendEmailViaResend(String from, String to, String subject, String text) {
        String apiKey = getServletContext().getInitParameter("mail.api.resend.key");
        String apiFrom = getServletContext().getInitParameter("mail.api.resend.from");
        if (apiKey == null || apiKey.isEmpty()) apiKey = System.getenv("RESEND_API_KEY");
        if ((from == null || from.isEmpty())) from = System.getenv("RESEND_FROM");
        if (apiFrom != null && !apiFrom.isEmpty()) from = apiFrom;
        if (apiKey == null || apiKey.isEmpty() || from == null || from.isEmpty()) {
            return false;
        }
        try {
            java.net.URL url = new java.net.URL("https://api.resend.com/emails");
            javax.net.ssl.HttpsURLConnection conn = (javax.net.ssl.HttpsURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + apiKey);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);
            String payload = "{" +
                    "\"from\":\"" + from + "\"," +
                    "\"to\":[\"" + to + "\"]," +
                    "\"subject\":\"" + subject.replace("\"", "") + "\"," +
                    "\"text\":\"" + text.replace("\"", "") + "\"}";
            try (java.io.OutputStream os = conn.getOutputStream()) {
                byte[] input = payload.getBytes(java.nio.charset.StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }
            int code = conn.getResponseCode();
            return code >= 200 && code < 300;
        } catch (Exception e) {
            return false;
        }
    }

    private static final Map<String, PendingRecord> TOKEN_STORE = new ConcurrentHashMap<>();

    private static class PendingRecord {
        User user;
        long expiresAt;
        PendingRecord(User u, long exp) { this.user = u; this.expiresAt = exp; }
    }
}