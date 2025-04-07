package com.supplychainfinance.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.supplychainfinance.dao.UserDAO;
import com.supplychainfinance.model.User;
import com.supplychainfinance.util.DBUtil;

public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String enterpriseId = request.getParameter("enterpriseId");
        
        // Basic validation
        if (username == null || username.isEmpty()) {
            request.setAttribute("message", "You must be logged in to update your profile");
            request.setAttribute("messageType", "danger");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        try (Connection conn = DBUtil.getConnection()) {
            // Update enterprise_id in users table
            String sql = "UPDATE users SET enterprise_id = ? WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, enterpriseId);
            stmt.setString(2, username);
            
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                session.setAttribute("enterpriseId", enterpriseId);
                request.setAttribute("message", "Profile updated successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Failed to update profile. User not found.");
                request.setAttribute("messageType", "danger");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error updating profile: " + e.getMessage());
            request.setAttribute("messageType", "danger");
        }
        
        // Use the existing UserDAO instead of duplicating code
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByUsername(username);
        request.setAttribute("user", user);
        
        // Forward to profile page
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}