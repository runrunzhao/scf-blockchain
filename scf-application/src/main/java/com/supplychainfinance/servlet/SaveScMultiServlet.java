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

public class SaveScMultiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from the request
        String scTransAddress = request.getParameter("scTransAddress");
        String multiAddress1 = request.getParameter("multiAddress1");
        String multiAddress2 = request.getParameter("multiAddress2");
        String multiAddress3 = request.getParameter("multiAddress3");
        String tokenIdStr = request.getParameter("tokenId");
        
        // Get required confirmations parameter - NEW CODE
        String requiredConfirmationsStr = request.getParameter("requiredConfirmations");
        int requiredConfirmations = 1; // Default value
        
        // Parse required confirmations - NEW CODE
        if (requiredConfirmationsStr != null && !requiredConfirmationsStr.isEmpty()) {
            try {
                requiredConfirmations = Integer.parseInt(requiredConfirmationsStr);
                // Ensure the value is at least 1
                if (requiredConfirmations < 1) {
                    requiredConfirmations = 1;
                }
            } catch (NumberFormatException e) {
                // Use default if parsing fails
                requiredConfirmations = 1;
            }
        }

        JSONObject jsonResponse = new JSONObject();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();

            // Start transaction
            conn.setAutoCommit(false);

            int tokenId = -1;
            if (tokenIdStr != null && !tokenIdStr.isEmpty()) {
                try {
                    tokenId = Integer.parseInt(tokenIdStr);
                } catch (NumberFormatException e) {
                    // Invalid token ID, will create a new one
                }
            }

            if (tokenId > 0) {
                // Update existing record
                String sql = "UPDATE scMulti SET genmuliContractAddr  = ?, signer1 = ?, signer2 = ?, signer3 = ?, " +
                             "requiredConfirmations = ? WHERE multiTokenID = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, scTransAddress);
                pstmt.setString(2, multiAddress1);
                pstmt.setString(3, multiAddress2);
                pstmt.setString(4, multiAddress3);
                pstmt.setInt(5, requiredConfirmations); // NEW CODE
                pstmt.setInt(6, tokenId);
                pstmt.executeUpdate();
                
                jsonResponse.put("tokenId", tokenId);
                jsonResponse.put("success", true);
                jsonResponse.put("message", "ScMulti record updated successfully");
            } else {
                // Insert new record
                String sql = "INSERT INTO scMulti (scTransAddr, signer1, signer2, signer3, requiredConfirmations,scmultiCreateTime) " + 
                             "VALUES (?, ?, ?, ?, ?, NOW())"; // NEW CODE - added requiredConfirmations
                pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstmt.setString(1, scTransAddress);
                pstmt.setString(2, multiAddress1);
                pstmt.setString(3, multiAddress2);
                pstmt.setString(4, multiAddress3);
                pstmt.setInt(5, requiredConfirmations); // NEW CODE
                pstmt.executeUpdate();

                // Get the generated ID
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    tokenId = rs.getInt(1);
                    jsonResponse.put("tokenId", tokenId);
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "ScMulti record created successfully");
                } else {
                    throw new SQLException("Creating ScMulti record failed, no ID obtained.");
                }
            }

            // Commit the transaction
            conn.commit();

        } catch (SQLException e) {
            // Roll back in case of error
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Close resources
            DBUtil.closeResources(rs, pstmt, conn);
        }

        // Send JSON response
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}