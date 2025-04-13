package com.supplychainfinance.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import com.supplychainfinance.util.DBUtil;


public class UpdateConnectionSignTxServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters from request
        String scTransAddr = request.getParameter("scTransAddr");
        String scMultiAddr = request.getParameter("scMultiAddr");
        String signTx = request.getParameter("signTx");
        
        // Create JSON response object
        JSONObject jsonResponse = new JSONObject();
        
        // Basic parameter validation
        if (scTransAddr == null || scTransAddr.isEmpty() || 
            scMultiAddr == null || scMultiAddr.isEmpty() || 
            signTx == null || signTx.isEmpty()) {
            
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Missing required parameters: scTransAddr, scMultiAddr, and signTx are required");
            sendJsonResponse(response, jsonResponse);
            return;
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            
            // First, check if a connection exists between these addresses
            String checkSql = "SELECT connectionID FROM scTransMultiConnection WHERE scTransAddr = ? AND scMultiAddr = ? ORDER BY scConnectTime DESC LIMIT 1";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, scTransAddr);
            pstmt.setString(2, scMultiAddr);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // Connection exists, update the signTx field
                int connectionId = rs.getInt("connectionID");
                
                String updateSql = "UPDATE scTransMultiConnection SET signTx = ?, scConnectTime = NOW() WHERE connectionID = ?";
                pstmt.close();
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setString(1, signTx);
                pstmt.setInt(2, connectionId);
                
                int updateCount = pstmt.executeUpdate();
                
                if (updateCount > 0) {
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "Transaction signature updated successfully");
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Failed to update transaction signature");
                }
            } else {
                // No connection found between these addresses
                jsonResponse.put("success", false);
                jsonResponse.put("message", "No connection found between the specified addresses");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error: " + e.getMessage());
        } finally {
            // Close resources
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (pstmt != null) {
                try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        
        // Send the response back to the client
        sendJsonResponse(response, jsonResponse);
    }
    
    private void sendJsonResponse(HttpServletResponse response, JSONObject json) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
    }
}