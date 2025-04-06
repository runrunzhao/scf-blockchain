package com.supplychainfinance.servlet;

import com.supplychainfinance.dao.UserDAO;
import com.supplychainfinance.model.User;
import com.supplychainfinance.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("Login attempt - Username: " + username);

        // Validate input
        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Get user from database
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByUsername(username);

        if (user == null) {
            System.out.println("User not found: " + username);
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

      
        boolean passwordMatches = false;

        String hashedInputPassword = PasswordUtil.hashPassword(password);
        if (hashedInputPassword.equals(user.getPassword())) {
            passwordMatches = true;
            System.out.println("Password matched with encryption.");
        }

       
        if (!passwordMatches) {
            System.out.println("Password does not match!");
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // 登录成功
        System.out.println("Login successful for user: " + username);
        

        // Update last login time
        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
        user.setLastLogin(currentTime);
        userDAO.updateLastLogin(user.getUserId(), currentTime);
        System.out.println(user.getWalletAddr());
        System.out.println(user.getEmail());

        // Create session and store user information
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("isLoggedIn", true);
        session.setAttribute("username", user.getUsername());
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("email", user.getEmail());
        session.setAttribute("walletAddr", user.getWalletAddr());
        // Redirect to contract page instead of index

        response.sendRedirect("index.jsp");
    }
}