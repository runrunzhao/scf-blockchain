package com.supplychainfinance.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.supplychainfinance.util.DBUtil;
import org.json.JSONObject;

public class CTTFinancingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();

        try {
            // Get parameters from request
            String userAddress = request.getParameter("userAddress");
            String cttAmount = request.getParameter("cttAmount");
            String interestRate = request.getParameter("interestRate");
            String dueDateStr = request.getParameter("dueDate");
            String settlementAmount = request.getParameter("settlementAmount");

            // Validate required parameters
            if (userAddress == null || userAddress.trim().isEmpty() ||
                cttAmount == null || cttAmount.trim().isEmpty() ||
                interestRate == null || interestRate.trim().isEmpty() ||
                dueDateStr == null || dueDateStr.trim().isEmpty() ||
                settlementAmount == null || settlementAmount.trim().isEmpty()) {

                jsonResponse.put("success", false);
                jsonResponse.put("message", "Missing required parameters");
                out.print(jsonResponse.toString());
                return;
            }

            // Parse due date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date dueDate = dateFormat.parse(dueDateStr);
            java.sql.Date sqlDueDate = new java.sql.Date(dueDate.getTime());

            // Create current timestamp
            java.sql.Timestamp currentTime = new java.sql.Timestamp(System.currentTimeMillis());

            // Get database connection
            Connection conn = DBUtil.getConnection();

            // Prepare SQL statement
            String sql = "INSERT INTO financing_records (user_address, ctt_amount, interest_rate, " +
                    "due_date, settlement_amount, status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userAddress);
            pstmt.setDouble(2, Double.parseDouble(cttAmount));
            pstmt.setDouble(3, Double.parseDouble(interestRate));
            pstmt.setDate(4, sqlDueDate);
            pstmt.setDouble(5, Double.parseDouble(settlementAmount));
            pstmt.setString(6, "PENDING");
            pstmt.setTimestamp(7, currentTime);

            // Execute the insert
            int rowsAffected = pstmt.executeUpdate();

            // Close resources
            pstmt.close();
            conn.close();

            // Check if insertion was successful
            if (rowsAffected > 0) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Financing record saved successfully");
                // Add the saved record data to response
                JSONObject recordData = new JSONObject();
                recordData.put("userAddress", userAddress);
                recordData.put("cttAmount", cttAmount);
                recordData.put("interestRate", interestRate);
                recordData.put("dueDate", dueDateStr);
                recordData.put("settlementAmount", settlementAmount);
                recordData.put("status", "PENDING");
                recordData.put("createdAt", currentTime.toString());
                jsonResponse.put("data", recordData);
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Failed to save financing record");
            }

        } catch (SQLException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error: " + e.getMessage());
            e.printStackTrace();
        } catch (ParseException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Date parsing error: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error: " + e.getMessage());
            e.printStackTrace();
        }

        // Send response
        out.print(jsonResponse.toString());
    }

    // Add doGet method to fetch financing records
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();

        try {
            String userAddress = request.getParameter("userAddress");
            if (userAddress == null || userAddress.trim().isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "User address is required");
                out.print(jsonResponse.toString());
                return;
            }

            // Get database connection
            Connection conn = DBUtil.getConnection();

            // Prepare SQL statement to fetch records
            String sql = "SELECT * FROM financing_records WHERE user_address = ? ORDER BY created_at DESC";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userAddress);

            // Execute query and process results
            // ... (implement result set processing here)

            // Close resources
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error: " + e.getMessage());
            e.printStackTrace();
        }

        // Send response
        out.print(jsonResponse.toString());
    }
}