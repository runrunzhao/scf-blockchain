package com.supplychainfinance.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import com.supplychainfinance.util.DBUtil;

public class ScheduleTransferServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        
        try {
            // Get parameters
            String fromAddress = request.getParameter("fromAddress");
            String toAddress = request.getParameter("toAddress");
            String amountStr = request.getParameter("amount");
            String scheduledTimeStr = request.getParameter("scheduledTime");
            String invoiceId = request.getParameter("invoiceId"); // Optional invoice reference
            
            // Validate parameters
            if (fromAddress == null || fromAddress.isEmpty() ||
                toAddress == null || toAddress.isEmpty() ||
                amountStr == null || amountStr.isEmpty() ||
                scheduledTimeStr == null || scheduledTimeStr.isEmpty()) {
                
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Missing required parameters");
                out.print(jsonResponse.toString());
                return;
            }
            
            // Parse amount
            double amount;
            try {
                amount = Double.parseDouble(amountStr);
                if (amount <= 0) {
                    throw new NumberFormatException("Amount must be positive");
                }
            } catch (NumberFormatException e) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Invalid amount: " + e.getMessage());
                out.print(jsonResponse.toString());
                return;
            }
            
            // Parse scheduled time
            Timestamp scheduledTime;
            try {
                scheduledTimeStr = scheduledTimeStr.replace("T", " ") + ":00";
                scheduledTime = Timestamp.valueOf(scheduledTimeStr);
                
                // Ensure time is in the future
                if (scheduledTime.getTime() <= System.currentTimeMillis()) {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Scheduled time must be in the future");
                    out.print(jsonResponse.toString());
                    return;
                }
            } catch (Exception e) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Invalid date format: " + e.getMessage());
                out.print(jsonResponse.toString());
                return;
            }
            
            // Insert into database
            Connection conn = DBUtil.getConnection();
            String sql = "INSERT INTO scheduledTransfers (fromAddress, toAddress, amount, scheduledTime) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, fromAddress);
            pstmt.setString(2, toAddress);
            pstmt.setDouble(3, amount);
            pstmt.setTimestamp(4, scheduledTime);
            
            int rowsInserted = pstmt.executeUpdate();
            
            if (rowsInserted > 0) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Payment scheduled successfully");
                
                // If invoice ID was provided, update invoice with scheduled payment info
                if (invoiceId != null && !invoiceId.isEmpty()) {
                    try {
                        String updateInvoiceSql = "UPDATE invoice SET paymentScheduled = TRUE WHERE invoiceID = ?";
                        PreparedStatement invoicePstmt = conn.prepareStatement(updateInvoiceSql);
                        invoicePstmt.setString(1, invoiceId);
                        invoicePstmt.executeUpdate();
                        invoicePstmt.close();
                    } catch (SQLException e) {
                        // Log error but don't fail the operation
                        System.err.println("Warning: Could not update invoice payment status: " + e.getMessage());
                    }
                }
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Failed to schedule payment");
            }
            
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