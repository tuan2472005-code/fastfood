package com.fastfood.controller;

import java.io.IOException; 	
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.fastfood.model.User;


public class ChatServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    private Map<String, List<Map<String, String>>> getStore(ServletContext ctx) {
        Map<String, List<Map<String, String>>> store = (Map<String, List<Map<String, String>>>) ctx.getAttribute("chatStore");
        if (store == null) {
            store = new ConcurrentHashMap<>();
            ctx.setAttribute("chatStore", store);
        }
        return store;
    }

    @SuppressWarnings("unchecked")
    private Map<String, Map<String, String>> getMeta(ServletContext ctx) {
        Map<String, Map<String, String>> meta = (Map<String, Map<String, String>>) ctx.getAttribute("chatMeta");
        if (meta == null) {
            meta = new ConcurrentHashMap<>();
            ctx.setAttribute("chatMeta", meta);
        }
        return meta;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
        response.setHeader("Pragma", "no-cache");
        HttpSession session = request.getSession();
        Object userObjGet = session.getAttribute("user");
        if (userObjGet == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            PrintWriter out = response.getWriter();
            out.write("{\"error\":\"Vui lòng đăng nhập để chat\"}");
            out.flush();
            return;
        }
        ServletContext ctx = getServletContext();
        String sid = session.getId();
        Map<String, List<Map<String, String>>> store = getStore(ctx);
        List<Map<String, String>> messages = store.get(sid);
        if (messages == null) {
            messages = new ArrayList<>();
            Map<String, String> m = new HashMap<>();
            m.put("sender", "support");
            m.put("content", "Xin chào! Bạn cần hỗ trợ gì?");
            m.put("time", new SimpleDateFormat("HH:mm dd/MM").format(new Date()));
            messages.add(m);
            store.put(sid, messages);
            Map<String, Map<String, String>> meta = getMeta(ctx);
            Map<String, String> info = new HashMap<>();
            info.put("name", "Khách");
            try {
                Object uo = session.getAttribute("user");
                if (uo instanceof User) {
                    User u = (User) uo;
                    if (u.getAvatar() != null) info.put("avatar", u.getAvatar());
                }
            } catch (Exception ignore) {}
            info.put("lastTime", new SimpleDateFormat("HH:mm dd/MM").format(new Date()));
            meta.put(sid, info);
        }
        PrintWriter out = response.getWriter();
        out.write(listToJson(messages));
        out.flush();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
        response.setHeader("Pragma", "no-cache");
        HttpSession session = request.getSession();
        Object userObjPost = session.getAttribute("user");
        if (userObjPost == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            PrintWriter out = response.getWriter();
            out.write("{\"error\":\"Vui lòng đăng nhập để chat\"}");
            out.flush();
            return;
        }
        ServletContext ctx = getServletContext();
        String sid = session.getId();
        Map<String, List<Map<String, String>>> store = getStore(ctx);
        Map<String, Map<String, String>> meta = getMeta(ctx);
        String content = request.getParameter("message");
        if (content == null || content.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Nội dung không được rỗng\"}");
            return;
        }
        List<Map<String, String>> messages = store.get(sid);
        if (messages == null) messages = new ArrayList<>();
        Map<String, String> userMsg = new HashMap<>();
        userMsg.put("sender", "user");
        userMsg.put("content", content.trim());
        userMsg.put("time", new SimpleDateFormat("HH:mm dd/MM").format(new Date()));
        try {
            Object uo = session.getAttribute("user");
            if (uo instanceof User) {
                User u = (User) uo;
                if (u.getAvatar() != null) userMsg.put("avatar", u.getAvatar());
            }
        } catch (Exception ignore) {}
        messages.add(userMsg);
        boolean hasAck = false;
        for (Map<String, String> msg : messages) {
            String sender = msg.get("sender");
            String cnt = msg.get("content");
            if ("support".equals(sender) && "CSKH đã nhận tin nhắn của bạn. Nhân viên sẽ phản hồi sớm.".equals(cnt)) {
                hasAck = true;
                break;
            }
        }
        if (!hasAck) {
            Map<String, String> supportMsg = new HashMap<>();
            supportMsg.put("sender", "support");
            supportMsg.put("content", "CSKH đã nhận tin nhắn của bạn. Nhân viên sẽ phản hồi sớm.");
            supportMsg.put("time", new SimpleDateFormat("HH:mm dd/MM").format(new Date()));
            messages.add(supportMsg);
        }
        if (messages.size() > 200) messages = messages.subList(messages.size() - 200, messages.size());
        store.put(sid, messages);
        Object userObj = session.getAttribute("user");
        Map<String, String> m = meta.getOrDefault(sid, new HashMap<>());
        String name = "Khách";
        if (userObj instanceof User) {
            User u = (User) userObj;
            if (u.getFullName() != null && !u.getFullName().isEmpty()) name = u.getFullName();
            else if (u.getUsername() != null) name = u.getUsername();
            if (u.getAvatar() != null) m.put("avatar", u.getAvatar());
        }
        m.put("name", name);
        m.put("lastTime", new SimpleDateFormat("HH:mm dd/MM").format(new Date()));
        meta.put(sid, m);
        PrintWriter out = response.getWriter();
        out.write(listToJson(messages));
        out.flush();
    }

    private String escapeJson(String s) {
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }

    private String listToJson(List<Map<String, String>> messages) {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < messages.size(); i++) {
            Map<String, String> m = messages.get(i);
            sb.append("{");
            sb.append("\"sender\":\"").append(escapeJson(m.get("sender"))).append("\",");
            sb.append("\"content\":\"").append(escapeJson(m.get("content"))).append("\",");
            sb.append("\"time\":\"").append(escapeJson(m.get("time"))).append("\"");
            String av = m.get("avatar");
            if (av != null) { sb.append(",\"avatar\":\"").append(escapeJson(av)).append("\""); }
            sb.append("}");
            if (i < messages.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
}
