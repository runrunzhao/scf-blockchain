package com.supplychainfinance.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.supplychainfinance.util.DBUtil;

public class SearchTokenServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        
        try {
            // Get the wallet address parameter (optional)
            String walletAddress = request.getParameter("walletAddress");
            
            Connection conn = DBUtil.getConnection();
            String sql;
            PreparedStatement pstmt;
            
            // Get only the most recent record by sccreateTime
            if (walletAddress != null && !walletAddress.trim().isEmpty()) {
                sql = "SELECT tokenID,owerAddr, tokenName, tokenSymbol, scexpireDate, genContractAddr, sccreateTime,tokenAmount  " +
                      "FROM SCToken WHERE owerAddr = ? " +
                      "ORDER BY sccreateTime DESC LIMIT 1";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, walletAddress);
            } else {
                // Get the most recent record regardless of owner
                sql = "SELECT tokenID,owerAddr, tokenName, tokenSymbol, scexpireDate, genContractAddr , sccreateTime,tokenAmount " +
                      "FROM SCToken ORDER BY sccreateTime DESC LIMIT 1";
                pstmt = conn.prepareStatement(sql);
            }
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                JSONObject token = new JSONObject();
                token.put("owerAddr", rs.getString("owerAddr"));
                token.put("tokenName", rs.getString("tokenName"));
                token.put("tokenSymbol", rs.getString("tokenSymbol"));
                token.put("tokenID", rs.getInt("tokenID"));
                token.put("tokenAmount", rs.getInt("tokenAmount"));
                // Format the date to yyyy-MM-dd
                java.sql.Date expireDate = rs.getDate("scexpireDate");
                token.put("scexpireDate", expireDate != null ? 
                          new SimpleDateFormat("yyyy-MM-dd").format(expireDate) : "");
                
                // Include contract address if available
                String contractAddr = rs.getString("genContractAddr");
                token.put("genContractAddr", contractAddr != null ? contractAddr : "");

                java.sql.Timestamp createTime = rs.getTimestamp("sccreateTime");
                token.put("sccreateTime", createTime != null ? 
                          new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(createTime) : "");
                
                jsonResponse.put("success", true);
                jsonResponse.put("token", token);
                jsonResponse.put("message", "Latest contract found");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "No contracts found. You can create a new one manually.");
            }
            
            rs.close();
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