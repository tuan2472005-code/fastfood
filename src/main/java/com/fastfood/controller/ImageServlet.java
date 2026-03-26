package com.fastfood.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet({"/uploads/*", "/images/*"})
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String requestedFile = request.getPathInfo();
        if (requestedFile == null || requestedFile.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Remove leading slash
        if (requestedFile.startsWith("/")) {
            requestedFile = requestedFile.substring(1);
        }

        // Determine which directory to serve from based on the servlet path
        String servletPath = request.getServletPath();
        String basePath;
        if (servletPath.equals("/images")) {
            basePath = getServletContext().getRealPath("/images");
        } else {
            basePath = getServletContext().getRealPath("/uploads");
        }
        
        File file = new File(basePath, requestedFile);

        // Security check - make sure the file is within the base directory
        String canonicalBasePath = new File(basePath).getCanonicalPath();
        String canonicalFilePath = file.getCanonicalPath();
        
        if (!canonicalFilePath.startsWith(canonicalBasePath)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // Check if file exists
        if (!file.exists() || !file.isFile()) {
            System.out.println("File not found: " + file.getAbsolutePath());
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Set content type based on file extension
        String contentType = getServletContext().getMimeType(file.getName());
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        response.setContentType(contentType);
        response.setContentLength((int) file.length());

        // Set cache headers
        response.setHeader("Cache-Control", "public, max-age=31536000"); // 1 year
        response.setDateHeader("Expires", System.currentTimeMillis() + 31536000000L);

        // Stream the file
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        }
    }
}