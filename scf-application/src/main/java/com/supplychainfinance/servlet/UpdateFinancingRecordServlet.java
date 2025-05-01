package com.supplychainfinance.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.supplychainfinance.util.DBUtil;
import org.json.JSONObject;

public class UpdateFinancingRecordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();

        try {
            // Read the request body
            BufferedReader reader = request.getReader();
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            String requestBody = sb.toString();

            // Parse the JSON from the request body
            JSONObject jsonRequest = new JSONObject(requestBody);
            String toAddress = jsonRequest.getString("toAddress");
            System.out.println("toAddress: " + toAddress);

            // Get record ID from request parameter
            String recordId = request.getParameter("recordId");
            System.out.println("QueryString: " + recordId);
            if (recordId == null || recordId.trim().isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Missing recordId parameter");
                out.print(jsonResponse.toString());
                return;
            }

            // Update database
            Connection conn = DBUtil.getConnection();
            String sql = "UPDATE financing_records SET status = 'ACCEPTED', bank_address = ? WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, toAddress);
            pstmt.setLong(2, Long.parseLong(recordId));

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Financing record updated successfully");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Record not found or update failed");
            }

            // Close resources
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error: " + e.getMessage());
            e.printStackTrace();
        }
        out.print(jsonResponse.toString());
    }
}