package com.supplychainfinance.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.supplychainfinance.util.DBUtil;


public class UpdateSettingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        
        // Get the verified wallet address
        String walletAddr = request.getParameter("walletAddr");
        String walletVerified = request.getParameter("walletVerified");
        
        // Only update if wallet is verified
        if (username != null && walletAddr != null && "true".equals(walletVerified)) {
            try (Connection  conn = DBUtil.getConnection();) {
                // Update walletAddr in users table
                String sql = "UPDATE users SET walletAddr = ? WHERE username = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, walletAddr);
                stmt.setString(2, username);
                
                int rowsUpdated = stmt.executeUpdate();
                if (rowsUpdated > 0) {
                    session.setAttribute("walletAddr", walletAddr);
                    session.setAttribute("message", "Wallet address saved successfully!");
                } else {
                    session.setAttribute("message", "Failed to save wallet address. User not found.");
                }
                
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("message", "Error saving wallet address: " + e.getMessage());
            }
        } else {
            session.setAttribute("message", "Wallet address must be verified before saving.");
        }
        
        // Redirect back to the settings page
        response.sendRedirect("settings.jsp");
    }
}