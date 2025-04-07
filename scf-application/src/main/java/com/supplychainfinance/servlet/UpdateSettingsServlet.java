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
        
        // Get form parameters
        String walletAddr = request.getParameter("walletAddr");
        String walletVerified = request.getParameter("walletVerified");
        String enterpriseId = request.getParameter("enterpriseId"); // Add enterprise ID parameter
        
        boolean settingsUpdated = false;
        
        // Update enterprise ID (no verification required)
        if (username != null && enterpriseId != null) {
            try (Connection conn = DBUtil.getConnection()) {
                String sql = "UPDATE users SET enterprise_id = ? WHERE username = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, enterpriseId);
                stmt.setString(2, username);
                
                int rowsUpdated = stmt.executeUpdate();
                if (rowsUpdated > 0) {
                    session.setAttribute("enterpriseId", enterpriseId);
                    settingsUpdated = true;
                }
                stmt.close();
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("message", "Error updating enterprise ID: " + e.getMessage());
            }
        }
        
        // Only update wallet if wallet is verified (keep original logic)
        if (username != null && walletAddr != null && "true".equals(walletVerified)) {
            try (Connection conn = DBUtil.getConnection()) {
                // Update walletAddr in users table
                String sql = "UPDATE users SET walletAddr = ? WHERE username = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, walletAddr);
                stmt.setString(2, username);
                
                int rowsUpdated = stmt.executeUpdate();
                if (rowsUpdated > 0) {
                    session.setAttribute("walletAddr", walletAddr);
                    settingsUpdated = true;
                } else {
                    session.setAttribute("message", "Failed to save wallet address. User not found.");
                }
                
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("message", "Error saving wallet address: " + e.getMessage());
            }
        } else if (walletAddr != null && !"true".equals(walletVerified)) {
            session.setAttribute("message", "Wallet address must be verified before saving.");
        }
        
        // Set success message if any settings were updated
        if (settingsUpdated && session.getAttribute("message") == null) {
            session.setAttribute("message", "Settings updated successfully!");
        }
        
        // Redirect back to the settings page
        response.sendRedirect("settings.jsp");
    }
}