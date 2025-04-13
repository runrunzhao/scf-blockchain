package com.supplychainfinance.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import com.supplychainfinance.util.DBUtil;

public class SaveConnectionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters - accept both naming conventions
        String scTransAddr = request.getParameter("scTransAddr"); 
        if (scTransAddr == null) {
            scTransAddr = request.getParameter("connScTransAddress");
        }
        
        String scMultiAddr = request.getParameter("scMultiAddr");
        if (scMultiAddr == null) {
            scMultiAddr = request.getParameter("connScMultiAddress");
        }
        
        // Get wallet address as memo if available
        String memo = request.getParameter("memo");
        if (memo == null) {
            memo = request.getParameter("walletAddress");
        }
        
        JSONObject jsonResponse = new JSONObject();
        
        // Validate required parameters
        if (scTransAddr == null || scTransAddr.isEmpty() || scMultiAddr == null || scMultiAddr.isEmpty()) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Missing required parameters: scTransAddr and scMultiAddr are required");
            sendJsonResponse(response, jsonResponse);
            return;
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
 
            // First, check if a connection already exists
            String checkSql = "SELECT connectionID FROM scTransMultiConnection WHERE scTransAddr = ? AND scMultiAddr = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, scTransAddr);
            pstmt.setString(2, scMultiAddr);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // Connection exists, update it
                int connectionId = rs.getInt("connectionID");
                String updateSql = "UPDATE scTransMultiConnection SET scConnectTime = NOW(), memo = ? WHERE connectionID = ?";
                
                pstmt.close();
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setString(1, memo);
                pstmt.setInt(2, connectionId);
                
                int updateCount = pstmt.executeUpdate();
                
                if (updateCount > 0) {
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "Connection updated successfully");
                    jsonResponse.put("connectionId", connectionId);
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Failed to update connection");
                }
            } else {
                // No connection exists, insert new one
                String insertSql = "INSERT INTO scTransMultiConnection (scTransAddr, scMultiAddr, scConnectTime, memo) "
                                + "VALUES (?, ?, NOW(), ?)";
                
                pstmt.close();
                pstmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
                pstmt.setString(1, scTransAddr);
                pstmt.setString(2, scMultiAddr);
                pstmt.setString(3, memo);
                
                int affectedRows = pstmt.executeUpdate();
                
                if (affectedRows > 0) {
                    rs.close();
                    rs = pstmt.getGeneratedKeys();
                    if (rs.next()) {
                        int connectionId = rs.getInt(1);
                        jsonResponse.put("success", true);
                        jsonResponse.put("message", "Connection saved successfully");
                        jsonResponse.put("connectionId", connectionId);
                    } else {
                        jsonResponse.put("success", false);
                        jsonResponse.put("message", "Failed to retrieve connection ID");
                    }
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Failed to save connection");
                }
            }
        } catch (SQLException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(rs, pstmt, conn);
        }

        sendJsonResponse(response, jsonResponse);
    }
    
    // Helper method to send JSON response
    private void sendJsonResponse(HttpServletResponse response, JSONObject json) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
    }
}