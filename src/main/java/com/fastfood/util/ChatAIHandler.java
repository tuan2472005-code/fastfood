package com.fastfood.util;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;
import java.util.concurrent.TimeUnit;
import okhttp3.*;
import com.google.gson.*;

public class ChatAIHandler {
    
    // --- CẤU HÌNH GROQ AI (Cực nhanh và mạnh mẽ) ---
    // Bạn hãy dán API Key của Groq vào đây
    private static final String API_KEY = "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"; 
    private static final String API_URL = "https://api.groq.com/openai/v1/chat/completions";
    private static final String MODEL = "llama-3.3-70b-versatile"; // Cập nhật sang model Llama 3.3 mới nhất và ổn định nhất
    
    // --- DỮ LIỆU ĐỂ AI "HỌC" (SYSTEM PROMPT) ---
    private static final String SYSTEM_PROMPT = 
        "Bạn là trợ lý CSKH chuyên nghiệp của cửa hàng 'Fast Food'. " +
        "Thông tin cửa hàng: " +
        "- Giờ mở cửa: 8:00 - 22:00 hàng ngày. " +
        "- Thực đơn chính: Burger (Bò, Gà, Tôm), Pizza, Gà rán giòn cay, Khoai tây chiên, Đồ uống. " +
        "- Món ngon nhất (Best-seller): Burger Bò Thượng Hạng và Gà rán giòn cay. " +
        "- Giao hàng: Miễn phí ship đơn từ 200k trong 5km. Giao nhanh trong 30 phút. " +
        "- Phí ship: 15k - 30k tùy khu vực. " +
        "- Khuyến mãi: Giảm 20% khung giờ vàng 14h-16h. Giảm 10% đơn đầu tiên với mã 'FASTFOODNEW'. " +
        "- Thanh toán: Tiền mặt (COD), Chuyển khoản, Ví điện tử. " +
        "- Hotline: 1900 1234. Địa chỉ: 123 Đường Fast Food, Quận 1, TP.HCM. " +
        "Quy tắc trả lời: Ngắn gọn, lịch sự, thân thiện, gọi khách hàng là Anh/Chị dựa theo tên khách cung cấp. " +
        "Trả lời bằng tiếng Việt.";

    private static final OkHttpClient client = new OkHttpClient.Builder()
            .connectTimeout(10, TimeUnit.SECONDS)
            .writeTimeout(10, TimeUnit.SECONDS)
            .readTimeout(30, TimeUnit.SECONDS)
            .build();
    private static final Gson gson = new Gson();

    public static String getResponse(String message, String userName) {
        if (message == null || message.trim().isEmpty()) {
            return "Chào " + (userName != null ? userName : "bạn") + ", tôi có thể giúp gì cho bạn không?";
        }

        // 1. Thử gọi Groq API
        if (API_KEY != null && !API_KEY.startsWith("YOUR_GROQ")) {
            try {
                return getGroqAIResponse(message, userName);
            } catch (Exception e) {
                System.err.println("Lỗi gọi Groq AI: " + e.getMessage());
                e.printStackTrace();
            }
        }

        // 2. AI NỘI BỘ DỰ PHÒNG
        return getInternalAIResponse(message, userName);
    }

    private static String getGroqAIResponse(String message, String userName) throws Exception {
        JsonObject json = new JsonObject();
        json.addProperty("model", MODEL);
        
        JsonArray messages = new JsonArray();
        
        // System message
        JsonObject systemMsg = new JsonObject();
        systemMsg.addProperty("role", "system");
        systemMsg.addProperty("content", SYSTEM_PROMPT);
        messages.add(systemMsg);
        
        // User message
        JsonObject userMsg = new JsonObject();
        userMsg.addProperty("role", "user");
        userMsg.addProperty("content", "Khách hàng tên " + userName + " hỏi: " + message);
        messages.add(userMsg);
        
        json.add("messages", messages);
        json.addProperty("temperature", 0.7);

        RequestBody body = RequestBody.create(
                json.toString(), MediaType.get("application/json; charset=utf-8"));
        
        Request request = new Request.Builder()
                .url(API_URL)
                .header("Authorization", "Bearer " + API_KEY)
                .post(body)
                .build();

        try (Response response = client.newCall(request).execute()) {
            String responseBody = response.body().string();
            if (!response.isSuccessful()) throw new Exception("Groq API Error: " + responseBody);
            
            JsonObject responseJson = gson.fromJson(responseBody, JsonObject.class);
            return responseJson.getAsJsonArray("choices")
                    .get(0).getAsJsonObject()
                    .getAsJsonObject("message")
                    .get("content").getAsString();
        }
    }

    // --- AI NỘI BỘ DỰ PHÒNG ---
    private static final Map<String, String[]> INTENTS = new HashMap<>();
    static {
        INTENTS.put("GREETING", new String[]{"Chào bạn! Tôi là trợ lý ảo của Fast Food. Rất vui được hỗ trợ bạn.", "Xin chào! Chúc bạn một ngày tốt lành."});
        INTENTS.put("OPENING_HOURS", new String[]{"Fast Food mở cửa từ 08:00 đến 22:00 hàng ngày bạn nhé!"});
        INTENTS.put("MENU_GENERAL", new String[]{"Thực đơn gồm Burger, Pizza, Gà rán và Đồ uống. Bạn xem tại mục 'Sản phẩm' nhé."});
        INTENTS.put("SHIPPING_INFO", new String[]{"Giao hàng nhanh 30 phút, miễn phí ship đơn từ 200k ạ."});
        INTENTS.put("HUMAN_SUPPORT", new String[]{"Dạ, nhân viên sẽ tiếp quản chat này sớm. Bạn vui lòng chờ chút nhé!"});
        INTENTS.put("THANK_YOU", new String[]{"Rất vui được hỗ trợ bạn! Chúc bạn ngon miệng!"});
    }

    private static String getInternalAIResponse(String message, String userName) {
        String msg = message.toLowerCase();
        String intent = "UNKNOWN";
        if (match(msg, "chào|hi|hello")) intent = "GREETING";
        else if (match(msg, "giờ|mở cửa|đóng cửa")) intent = "OPENING_HOURS";
        else if (match(msg, "thực đơn|menu|món ăn|sản phẩm")) intent = "MENU_GENERAL";
        else if (match(msg, "ship|giao hàng|vận chuyển")) intent = "SHIPPING_INFO";
        else if (match(msg, "nhân viên|người|hotline|gặp")) intent = "HUMAN_SUPPORT";
        else if (match(msg, "cảm ơn|thanks|thank")) intent = "THANK_YOU";

        String[] responses = INTENTS.get(intent);
        if (responses == null || intent.equals("UNKNOWN")) return "Xin lỗi, tôi chưa hiểu ý bạn. Bạn hãy hỏi về Thực đơn, Giờ mở cửa hoặc yêu cầu 'Gặp nhân viên' nhé!";
        String response = responses[(int) (Math.random() * responses.length)];
        return (userName != null && !userName.equals("Khách")) ? response.replace("bạn", userName) : response;
    }

    private static boolean match(String text, String regex) {
        return Pattern.compile(regex).matcher(text).find();
    }
}
