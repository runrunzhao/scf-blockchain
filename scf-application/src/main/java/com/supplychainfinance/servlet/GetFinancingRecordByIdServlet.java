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
import org.json.JSONObject;

public class GetFinancingRecordByIdServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();

        try {
            // Get record ID from request
            String recordId = request.getParameter("recordId");
         //   System.out.println("QueryString: " + request.getQueryString());
          
            if (recordId == null || recordId.trim().isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Missing recordId parameter");
                out.print(jsonResponse.toString());
                return;
            }

            // Query database for the specific financing record
            Connection conn = DBUtil.getConnection();
            String sql = "SELECT id, user_address, ctt_amount, interest_rate, due_date, settlement_amount, status, created_at "
                    + "FROM financing_records WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, Long.parseLong(recordId));
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                JSONObject record = new JSONObject();
                record.put("id", rs.getLong("id"));
                record.put("userAddress", rs.getString("user_address"));
                record.put("cttAmount", rs.getBigDecimal("ctt_amount"));
                record.put("interestRate", rs.getBigDecimal("interest_rate"));
                record.put("dueDate", dateFormat.format(rs.getDate("due_date")));
                record.put("settlementAmount", rs.getBigDecimal("settlement_amount"));
                record.put("status", rs.getString("status"));
                record.put("createdAt", dateFormat.format(rs.getTimestamp("created_at")));

                jsonResponse.put("success", true);
                jsonResponse.put("record", record);
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Record not found");
            }

            // Close resources
            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error: " + e.getMessage());
            e.printStackTrace();
        }
      //  System.out.println("JSON Response: " + jsonResponse.toString()); // Add this line
        out.print(jsonResponse.toString());
    }
}