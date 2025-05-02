package com.supplychainfinance.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.supplychainfinance.util.DBUtil;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SearchCTTLoanRecordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get search parameters from the request
        String correspondingTX = request.getParameter("correspondingTX");
        String correspondingTXDate = request.getParameter("correspondingTXDate");
        String loanAmountStr = request.getParameter("loanAmount");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Map<String, Object>> results = new ArrayList<>();

        try {
            conn = DBUtil.getConnection();
            
          
            StringBuilder sqlBuilder = new StringBuilder();
            List<Object> params = new ArrayList<>();
    
            sqlBuilder.append("SELECT loanIssueID, loanAmount, correspondpingTX, correspondpingTXDate ");
            sqlBuilder.append("FROM loanRecord WHERE 1=1 ");
            
            // Add conditions based on provided parameters
            if (correspondingTX != null && !correspondingTX.trim().isEmpty()) {
                sqlBuilder.append("AND correspondpingTX LIKE ? ");
                params.add("%" + correspondingTX.trim() + "%");
            }
            
            if (correspondingTXDate != null && !correspondingTXDate.trim().isEmpty()) {
                sqlBuilder.append("AND correspondpingTXDate LIKE ? ");
                params.add("%" + correspondingTXDate.trim() + "%");
            }
            
            if (loanAmountStr != null && !loanAmountStr.trim().isEmpty()) {
                try {
                    double loanAmount = Double.parseDouble(loanAmountStr.trim());
                    sqlBuilder.append("AND loanAmount = ? ");
                    params.add(loanAmount);
                } catch (NumberFormatException e) {
                    System.err.println("Invalid loan amount format: " + loanAmountStr);
                }
            }
            
            // Prepare and execute the SQL query
            pstmt = conn.prepareStatement(sqlBuilder.toString());
            
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            // Execute query
            rs = pstmt.executeQuery();
            
            // Process results
            while (rs.next()) {
                Map<String, Object> loan = new HashMap<>();
                
                // Extract values from result set
                // Use column names from database or aliases from the query
                loan.put("loanIssueID", rs.getString("loanIssueID"));
                loan.put("loanAmount", rs.getDouble("loanAmount"));
                loan.put("correspondpingTX", rs.getString("correspondpingTX"));
                loan.put("correspondpingTXDate", rs.getString("correspondpingTXDate"));
                
                results.add(loan);
            }
            
            // Write JSON response with search results
            out.print(gson.toJson(results));
            
        } catch (SQLException e) {
            // Handle SQL errors
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Database error: " + e.getMessage());
            out.print(gson.toJson(errorResponse));
            e.printStackTrace();
        } catch (Exception e) {
            // Handle other errors
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Error: " + e.getMessage());
            out.print(gson.toJson(errorResponse));
            e.printStackTrace();
        } finally {
            // Close database resources
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            
            out.flush();
        }
    }
}