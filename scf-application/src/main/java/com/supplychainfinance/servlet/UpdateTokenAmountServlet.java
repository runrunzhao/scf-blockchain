package com.supplychainfinance.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.supplychainfinance.util.DBUtil;

public class UpdateTokenAmountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        
        try {
            // Get parameters
            String tokenIDStr = request.getParameter("tokenID");
            String tokenAmountStr = request.getParameter("tokenAmount");
            
            // Validate parameters
            if (tokenIDStr == null || tokenIDStr.isEmpty() || 
                tokenAmountStr == null || tokenAmountStr.isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Missing required parameters");
                out.print(jsonResponse.toString());
                return;
            }
            
            int tokenID;
            double tokenAmount;
            
            try {
                tokenID = Integer.parseInt(tokenIDStr);
                tokenAmount = Double.parseDouble(tokenAmountStr);
            } catch (NumberFormatException e) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Invalid numeric parameters");
                out.print(jsonResponse.toString());
                return;
            }
            
            // Create current timestamp
            Timestamp currentTime = new Timestamp(new Date().getTime());
            
            // Update token amount and token create time in database
            Connection conn = DBUtil.getConnection();
            String sql = "UPDATE SCToken SET tokenAmount = ?, tokenCreateTime = ? WHERE tokenID = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setDouble(1, tokenAmount);
            pstmt.setTimestamp(2, currentTime);
            pstmt.setInt(3, tokenID);
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Token amount and creation time updated successfully");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "No matching token found with ID: " + tokenID);
            }
            
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error: " + e.getMessage());
        }
        
        out.print(jsonResponse.toString());
    }
}