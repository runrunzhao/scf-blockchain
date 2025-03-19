package com.supplychainfinance.servlet;

import com.supplychainfinance.dao.UserDAO;
import com.supplychainfinance.model.User;
import com.supplychainfinance.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class RegisterUserServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String enterpriseId = request.getParameter("enterpriseId");
        String termsCheck = request.getParameter("termsCheck");
        
        // Validate form data
        UserDAO userDAO = new UserDAO();
        
        // Check if username already exists
        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("errorMessage", "Username already exists. Please choose a different username.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check if email already exists
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("errorMessage", "Email already registered. Please use a different email.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check if terms are accepted
        if (termsCheck == null) {
            request.setAttribute("errorMessage", "You must accept the Terms of Service and Privacy Policy.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Hash the password
        String hashedPassword = PasswordUtil.hashPassword(password);
        
        // Create user object
        User newUser = new User(username, hashedPassword, firstName, lastName, email, enterpriseId);
        
        // Register the user
        boolean success = userDAO.registerUser(newUser);
        
        if (success) {
            // Registration successful
            request.setAttribute("successMessage", "Registration successful! You can now login.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            // Registration failed
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}