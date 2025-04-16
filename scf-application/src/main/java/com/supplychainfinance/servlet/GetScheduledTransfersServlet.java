package com.supplychainfinance.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import org.json.JSONArray;
import com.supplychainfinance.util.DBUtil;

public class GetScheduledTransfersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        
        try {
            String address = request.getParameter("address");
            
            if (address == null || address.isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Address parameter is required");
                out.print(jsonResponse.toString());
                return;
            }
            
            Connection conn = DBUtil.getConnection();
            String sql = "SELECT * FROM scheduledTransfers WHERE fromAddress = ? ORDER BY scheduledTime ASC";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, address);
            
            ResultSet rs = pstmt.executeQuery();
            
            JSONArray transfersArray = new JSONArray();
            
            while (rs.next()) {
                JSONObject transfer = new JSONObject();
                transfer.put("id", rs.getInt("id"));
                transfer.put("fromAddress", rs.getString("fromAddress"));
                transfer.put("toAddress", rs.getString("toAddress"));
                transfer.put("amount", rs.getDouble("amount"));
                transfer.put("scheduledTime", rs.getTimestamp("scheduledTime").toString());
                transfer.put("executed", rs.getBoolean("executed"));
                
                Timestamp executionTime = rs.getTimestamp("executionTime");
                transfer.put("executionTime", executionTime != null ? executionTime.toString() : null);
                transfer.put("transactionHash", rs.getString("transaction_hash"));
                transfer.put("status", rs.getString("status"));
                transfer.put("createdTime", rs.getTimestamp("createdTime").toString());
                
                transfersArray.put(transfer);
            }
            
            jsonResponse.put("success", true);
            jsonResponse.put("transfers", transfersArray);
            
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