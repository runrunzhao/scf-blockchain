package com.supplychainfinance.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.supplychainfinance.util.DBUtil;
import org.json.JSONArray;
import org.json.JSONObject;

public class GetFinancingRecordsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();

        try {
            // Get userAddress from request
            String userAddress = request.getParameter("userAddress");
            if (userAddress == null || userAddress.trim().isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Missing userAddress parameter");
                out.print(jsonResponse.toString());
                return;
            }
            System.out.println("Received userAddress: " + userAddress);
            // Query database for financing records
            Connection conn = DBUtil.getConnection();
            String sql = "SELECT id, user_address, ctt_amount, interest_rate, due_date, settlement_amount, status, created_at "
                    + "FROM financing_records WHERE user_address = ? ORDER BY created_at DESC";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userAddress);
            ResultSet rs = pstmt.executeQuery();
            
            // Process results
            JSONArray records = new JSONArray();
            while (rs.next()) {
                JSONObject record = new JSONObject();
                record.put("id", rs.getLong("id"));
                record.put("userAddress", rs.getString("user_address"));
                record.put("cttAmount", rs.getBigDecimal("ctt_amount"));
                System.out.println("CTT amount: " + rs.getBigDecimal("ctt_amount"));
                record.put("interestRate", rs.getBigDecimal("interest_rate"));
              //  record.put("dueDate", rs.getDate("due_date").toString());
                record.put("settlementAmount", rs.getBigDecimal("settlement_amount"));
                record.put("status", rs.getString("status"));
               // record.put("createdAt", rs.getTimestamp("created_at").toString());
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                record.put("createdAt", dateFormat.format(rs.getTimestamp("created_at")));
                record.put("dueDate", dateFormat.format(rs.getDate("due_date")));
                records.put(record);
            }

            // Close resources
            rs.close();
            pstmt.close();
            conn.close();

            // Return records in response
            jsonResponse.put("success", true);
            jsonResponse.put("records", records);

        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error: " + e.getMessage());
            e.printStackTrace();
        }

        out.print(jsonResponse.toString());
    }
}