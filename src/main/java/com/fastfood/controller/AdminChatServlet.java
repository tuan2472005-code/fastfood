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

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class AdminChatServlet extends HttpServlet {
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
        String action = request.getParameter("action");
        if (action == null) {
            request.getRequestDispatcher("/WEB-INF/views/admin/chat.jsp").forward(request, response);
            return;
        }

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        ServletContext ctx = getServletContext();
        PrintWriter out = response.getWriter();

        if ("listSessions".equals(action)) {
            Map<String, List<Map<String, String>>> store = getStore(ctx);
            Map<String, Map<String, String>> meta = getMeta(ctx);
            List<Map<String, Object>> list = new ArrayList<>();
            for (Map.Entry<String, List<Map<String, String>>> e : store.entrySet()) {
                String sid = e.getKey();
                List<Map<String, String>> msgs = e.getValue();
                Map<String, String> m = meta.get(sid);
                Map<String, Object> row = new HashMap<>();
                row.put("sessionId", sid);
                row.put("name", m != null ? m.getOrDefault("name", "Khách") : "Khách");
                row.put("count", msgs != null ? msgs.size() : 0);
                row.put("lastTime", m != null ? m.getOrDefault("lastTime", "") : "");
                row.put("avatar", m != null ? m.getOrDefault("avatar", "") : "");
                list.add(row);
            }
            out.write(listToJson(list));
            return;
        }

        if ("getMessages".equals(action)) {
            String sid = request.getParameter("sessionId");
            if (sid == null || sid.isEmpty()) { out.write("[]"); return; }
            Map<String, List<Map<String, String>>> store = getStore(ctx);
            List<Map<String, String>> msgs = store.get(sid);
            out.write(listToJsonMsgs(msgs != null ? msgs : new ArrayList<>())); return;
        }

        if ("sessionInfo".equals(action)) {
            String sid = request.getParameter("sessionId");
            if (sid == null || sid.isEmpty()) { out.write("{}\n"); return; }
            Map<String, Map<String, String>> meta = getMeta(ctx);
            Map<String, String> m = meta.get(sid);
            if (m == null) { out.write("{}\n"); return; }
            StringBuilder sb = new StringBuilder("{");
            sb.append("\"name\":\"").append(escape(m.get("name"))).append("\",");
            sb.append("\"lastTime\":\"").append(escape(m.get("lastTime"))).append("\"");
            if (m.get("avatar") != null) sb.append(",\"avatar\":\"").append(escape(m.get("avatar"))).append("\"");
            sb.append("}");
            out.write(sb.toString());
            return;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        ServletContext ctx = getServletContext();
        String action = request.getParameter("action");
        if (!"send".equals(action)) { response.getWriter().write("{}\n"); return; }
        String sid = request.getParameter("sessionId");
        String content = request.getParameter("message");
        if (sid == null || sid.isEmpty() || content == null || content.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Thiếu dữ liệu\"}");
            return;
        }
        Map<String, List<Map<String, String>>> store = getStore(ctx);
        List<Map<String, String>> msgs = store.get(sid);
        if (msgs == null) msgs = new ArrayList<>();
        Map<String, String> m = new HashMap<>();
        m.put("sender", "support");
        m.put("content", content.trim());
        m.put("time", new SimpleDateFormat("HH:mm dd/MM").format(new Date()));
        msgs.add(m);
        store.put(sid, msgs);
        response.getWriter().write(listToJsonMsgs(msgs));
    }

    private String escape(String s){
        return s == null ? "" : s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
    private String listToJson(List<Map<String, Object>> list){
        StringBuilder sb = new StringBuilder("[");
        for (int i=0;i<list.size();i++){
            Map<String,Object> o = list.get(i);
            sb.append("{")
              .append("\"sessionId\":\"").append(escape(String.valueOf(o.get("sessionId")))).append("\",")
              .append("\"name\":\"").append(escape(String.valueOf(o.get("name")))).append("\",")
              .append("\"count\":").append(String.valueOf(o.get("count"))).append(",")
              .append("\"lastTime\":\"").append(escape(String.valueOf(o.get("lastTime")))).append("\"");
            Object av = o.get("avatar");
            if (av != null) { sb.append(",\"avatar\":\"").append(escape(String.valueOf(av))).append("\""); }
            sb.append("}");
            if (i<list.size()-1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
    private String listToJsonMsgs(List<Map<String,String>> messages){
        StringBuilder sb = new StringBuilder("[");
        for (int i=0;i<messages.size();i++){
            Map<String,String> m = messages.get(i);
            sb.append("{")
              .append("\"sender\":\"").append(escape(m.get("sender"))).append("\",")
              .append("\"content\":\"").append(escape(m.get("content"))).append("\",")
              .append("\"time\":\"").append(escape(m.get("time"))).append("\"");
            String av = m.get("avatar");
            if (av != null) { sb.append(",\"avatar\":\"").append(escape(av)).append("\""); }
            sb.append("}");
            if (i<messages.size()-1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
}
