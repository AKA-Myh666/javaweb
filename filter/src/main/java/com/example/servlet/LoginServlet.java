package com.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 处理登录逻辑
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 简单验证，实际应用中应连接数据库进行验证
        if ("admin".equals(username) && "password".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", username); // 设置用户信息到Session
            response.sendRedirect(request.getContextPath() + "/index.html"); // 跳转到主页
        } else {
            response.sendRedirect(request.getContextPath() + "/login.html?error=true");
        }
    }
}