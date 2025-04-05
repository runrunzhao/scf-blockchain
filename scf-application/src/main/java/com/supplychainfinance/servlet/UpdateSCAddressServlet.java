package com.supplychainfinance.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.supplychainfinance.util.DBUtil;

public class UpdateSCAddressServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        
        try {
            // Get parameters from request
            String tokenIdStr = request.getParameter("tokenId");
            String contractAddress = request.getParameter("contractAddress");
            
            // Validate parameters
            if (tokenIdStr == null || tokenIdStr.trim().isEmpty() ||
                contractAddress == null || contractAddress.trim().isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Missing required parameters");
                out.print(jsonResponse.toString());
                return;
            }
            
            // Parse token ID
            int tokenId = Integer.parseInt(tokenIdStr);
            
            // Get database connection
            Connection conn = DBUtil.getConnection();
            
            // Prepare SQL statement
            String sql = "UPDATE SCToken SET genContractAddr = ? WHERE tokenID = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, contractAddress);
            pstmt.setInt(2, tokenId);
            
            // Execute the update
            int rowsAffected = pstmt.executeUpdate();
            
            // Close resources
            pstmt.close();
            conn.close();
            
            // Check if update was successful
            if (rowsAffected > 0) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Contract address updated successfully");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "No record found with the specified ID");
            }
            
        } catch (NumberFormatException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Invalid token ID format");
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