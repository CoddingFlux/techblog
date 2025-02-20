package com.techblog.securityconfig;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        
        String uri = req.getRequestURI();
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        boolean isLoginRequest = uri.endsWith("login") || uri.endsWith("register") || uri.endsWith("LoginServlet") || uri.endsWith("RegisterServlet");
        boolean isAssetRequest = uri.contains("assets");
        boolean isIndexPage = uri.endsWith("index")|| uri.endsWith("contact") || uri.equals(req.getContextPath() + "/");

        // 1. Allow assets (CSS, JS, Images) to load
        if (isAssetRequest) {
            chain.doFilter(request, response);
            return;
        }

        // 2. ALLOW index.jsp before login
        if (isIndexPage) {
            chain.doFilter(request, response);
            return;
        }

        // 3. If user is logged in and tries to access login or register, redirect to profile
        if (isLoggedIn && isLoginRequest) {
            res.sendRedirect("posts");
            return;
        }

        // 4. If user is not logged in and tries to access a restricted page, redirect to login
        if (!isLoggedIn && !isLoginRequest) {
            res.sendRedirect("login");
            return;
        }

        // 5. Proceed with the request
        chain.doFilter(request, response);
    }
}
