package com.java.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.java.pojo.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {
    /**
     * 进入 Controller 之前检查是否已登录
     */
    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        User u = (session != null) ? (User) session.getAttribute("user") : null;
        if (u != null) {
            return true;  // 已登录，放行
        }
        // 未登录，重定向到登录页
        String loginUrl = request.getContextPath() + "/login";
        response.sendRedirect(loginUrl);
        return false;
    }

    // postHandle 和 afterCompletion 可先留空
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) throws Exception { }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
                                Object handler, Exception ex) throws Exception { }
}