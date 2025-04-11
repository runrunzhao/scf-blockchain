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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String scTransAddr = request.getParameter("scMultiTransAddress");
        String signer1 = request.getParameter("multiAddress1");
        String signer2 = request.getParameter("multiAddress2");
        String signer3 = request.getParameter("multiAddress3"); // Optional
        String memo = request.getParameter("memo"); // Optional
        String genmuliContractAddr = request.getParameter("genContractAddr"); // Optional
        String tokenIdParam = request.getParameter("tokenId"); // Optional for update

        JSONObject jsonResponse = new JSONObject();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection();

            // Check if we're updating an existing record
            if (tokenIdParam != null && !tokenIdParam.isEmpty()) {
                int tokenId = Integer.parseInt(tokenIdParam);
                
                // Update existing record
                String sql = "UPDATE scMulti SET scTransAddr = ?, signer1 = ?, signer2 = ?, signer3 = ?, "
                        + "memo = ?, genmuliContractAddr = ?, scmultiCreateTime = NOW() "
                        + "WHERE multiTokenID = ?";
                
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, scTransAddr);
                pstmt.setString(2, signer1);
                pstmt.setString(3, signer2);
                pstmt.setString(4, signer3);
                pstmt.setString(5, memo);
                pstmt.setString(6, genmuliContractAddr);
                pstmt.setInt(7, tokenId);
                
                int updateCount = pstmt.executeUpdate();
                
                if (updateCount > 0) {
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "SCMulti updated successfully");
                    jsonResponse.put("tokenId", tokenId);
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Failed to update SCMulti record");
                }
            } else {
                // Insert new record
                String sql = "INSERT INTO scMulti (scTransAddr, signer1, signer2, signer3, memo, genmuliContractAddr, scmultiCreateTime) "
                        + "VALUES (?, ?, ?, ?, ?, ?, NOW())";
                
                pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstmt.setString(1, scTransAddr);
                pstmt.setString(2, signer1);
                pstmt.setString(3, signer2);
                pstmt.setString(4, signer3);
                pstmt.setString(5, memo);
                pstmt.setString(6, genmuliContractAddr);
                
                int affectedRows = pstmt.executeUpdate();
                
                if (affectedRows > 0) {
                    rs = pstmt.getGeneratedKeys();
                    if (rs.next()) {
                        int tokenId = rs.getInt(1);
                        jsonResponse.put("success", true);
                        jsonResponse.put("message", "SCMulti saved successfully");
                        jsonResponse.put("tokenId", tokenId);
                    } else {
                        jsonResponse.put("success", false);
                        jsonResponse.put("message", "Failed to retrieve tokenId");
                    }
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Failed to save SCMulti");
                }
            }
        } catch (SQLException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error: " + e.getMessage());
            e.printStackTrace();
        } catch (NumberFormatException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Invalid token ID format");
        } finally {
            DBUtil.closeResources(rs, pstmt, conn);
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
}