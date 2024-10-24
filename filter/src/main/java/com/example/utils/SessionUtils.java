package com.example.utils;

import jakarta.servlet.http.HttpSession;

public class SessionUtils {

    /**
     * 检查用户是否已登录。
     *
     * @param session HTTP 会话
     * @return 如果用户已登录则返回 true, 否则返回 false
     */
    public static boolean isUserLoggedIn(HttpSession session) {
        return (session != null && session.getAttribute("user") != null);
    }

    /**
     * 将用户信息存储到会话中。
     *
     * @param session HTTP 会话
     * @param username 用户名
     */
    public static void setUserInSession(HttpSession session, String username) {
        if (session != null) {
            session.setAttribute("user", username);
        }
    }

    /**
     * 从会话中移除用户信息。
     *
     * @param session HTTP 会话
     */
    public static void removeUserFromSession(HttpSession session) {
        if (session != null) {
            session.removeAttribute("user");
        }
    }
}