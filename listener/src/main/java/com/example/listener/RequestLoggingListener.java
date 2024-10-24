package com.example.listener;

import jakarta.servlet.ServletRequestEvent;
import jakarta.servlet.ServletRequestListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpServletRequest;
import java.util.logging.Logger;

@WebListener
public class RequestLoggingListener implements ServletRequestListener {
    private static final Logger logger = Logger.getLogger(RequestLoggingListener.class.getName());

    @Override
    public void requestInitialized(ServletRequestEvent sre) {
        HttpServletRequest request = (HttpServletRequest) sre.getServletRequest();

        // 获取请求的详细信息
        String clientIP = request.getRemoteAddr();
        String method = request.getMethod();
        String requestURI = request.getRequestURI();
        String queryString = request.getQueryString() != null ? request.getQueryString() : "N/A";
        String userAgent = request.getHeader("User-Agent");

        // 在请求属性中存储开始时间
        long startTime = System.currentTimeMillis();
        request.setAttribute("startTime", startTime);

        // 记录请求的基本信息
        logger.info(String.format("Request Received: [IP: %s, Method: %s, URI: %s, Query: %s, User-Agent: %s, Start Time: %d]",
                clientIP, method, requestURI, queryString, userAgent, startTime));
    }

    @Override
    public void requestDestroyed(ServletRequestEvent sre) {
        HttpServletRequest request = (HttpServletRequest) sre.getServletRequest();

        // 获取开始时间并计算请求处理时间
        long startTime = (Long) request.getAttribute("startTime");
        long endTime = System.currentTimeMillis();
        long processingTime = endTime - startTime;

        // 记录处理结束时的信息
        logger.info(String.format("Request Completed: [URI: %s, Processing Time: %d ms]", request.getRequestURI(), processingTime));
    }
}
