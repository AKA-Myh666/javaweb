package com.example.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

@WebFilter("/*")
public class LoginFilter implements Filter {

    // 定义不需要登录就能访问的路径
    private static final Set<String> EXCLUDED_PATHS = new HashSet<>();

    static {
        // 初始化排除列表
        EXCLUDED_PATHS.add("/login.html");
        EXCLUDED_PATHS.add("/register.html");
        EXCLUDED_PATHS.add("/public/**");  // 假设/public下的所有资源都是公开的
        EXCLUDED_PATHS.add("/LoginServlet");
        EXCLUDED_PATHS.add("/RegisterServlet");
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 过滤器初始化时执行的逻辑
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String path = httpRequest.getServletPath();

        // 检查当前请求路径是否在排除列表中
        if (isExcluded(path)) {
            // 如果在排除列表中, 直接允许请求通过
            chain.doFilter(request, response);
        } else {
            // 如果不在排除列表中, 检查用户是否已登录
            if (session != null && session.getAttribute("user") != null) {
                // 用户已登录, 允许请求继续
                chain.doFilter(request, response);
            } else {
                // 用户未登录, 重定向到登录页面
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.html");
            }
        }
    }

    @Override
    public void destroy() {
        // 过滤器销毁时执行的逻辑
    }

    /**
     * 检查给定的路径是否在排除列表中。
     *
     * @param path 请求路径
     * @return 如果路径在排除列表中返回 true, 否则返回 false
     */
    private boolean isExcluded(String path) {
        for (String excludedPath : EXCLUDED_PATHS) {
            if (path.equals(excludedPath) || path.startsWith(excludedPath)) {
                return true;
            }
        }
        return false;
    }
}