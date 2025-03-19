package com.supplychainfinance.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Arrays;
import java.util.List;

public class AuthenticationFilter implements Filter {
    // 不需要登录就能访问的页面
    private List<String> excludedURLs = Arrays.asList(
        "/login.jsp", 
        "/register.jsp", 
        "/loginUser", 
        "/registerUser", 
        "/index.jsp",
        "/css/", 
        "/js/",
        "/images/",
        "/favicon.ico"
    );
    
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) 
            throws IOException, ServletException {
            
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        // 检查URL是否在排除列表中
        boolean isExcluded = false;
        for (String excludedURL : excludedURLs) {
            if (path.equals(excludedURL) || path.startsWith(excludedURL)) {
                isExcluded = true;
                break;
            }
        }
        
        // 如果是排除的URL，或者已经登录，则继续
        if (isExcluded || (session != null && session.getAttribute("isLoggedIn") != null 
                && (Boolean)session.getAttribute("isLoggedIn"))) {
            chain.doFilter(request, response);
        } else {
            // 否则重定向到登录页面
            request.setAttribute("errorMessage", "please login first");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    public void destroy() {
    }
}