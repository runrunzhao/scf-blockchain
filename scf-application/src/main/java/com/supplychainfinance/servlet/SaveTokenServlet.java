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

public class SaveTokenServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();

        try {
            // Get parameters from request
            String ownerAddr = request.getParameter("owerAddr");
            String tokenName = request.getParameter("tokenName");
            String tokenSymbol = request.getParameter("tokenSymbol");
            String scexpireDateStr = request.getParameter("scexpireDate");
            String genContractAddr = request.getParameter("genContractAddr");
            
            // Validate required parameters
            if (ownerAddr == null || ownerAddr.trim().isEmpty() ||
                    tokenName == null || tokenName.trim().isEmpty() ||
                    tokenSymbol == null || tokenSymbol.trim().isEmpty() ||
                    scexpireDateStr == null || scexpireDateStr.trim().isEmpty()) {

                jsonResponse.put("success", false);
                jsonResponse.put("message", "Missing required parameters");
                out.print(jsonResponse.toString());
                return;
            }

            // Parse expiration date - use java.sql.Date instead of Timestamp
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date expireDate = dateFormat.parse(scexpireDateStr);
            java.sql.Date scexpireDate = new java.sql.Date(expireDate.getTime());
            
            // Create current timestamp for scCreateTime
            java.sql.Timestamp currentTime = new java.sql.Timestamp(System.currentTimeMillis());

            // Parse token amount
            double tokenAmount = 0;

            // Get database connection
            Connection conn = DBUtil.getConnection();

            // Prepare SQL statement with correct column names and adding scCreateTime
            String sql = "INSERT INTO SCToken (owerAddr, tokenName, tokenSymbol, scexpireDate, " +
                    "genContractAddr, scCreateTime, tokenAmount) VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, ownerAddr);
            pstmt.setString(2, tokenName);
            pstmt.setString(3, tokenSymbol);
            pstmt.setDate(4, scexpireDate);
            pstmt.setString(5, genContractAddr);
            pstmt.setTimestamp(6, currentTime); // Add current timestamp for scCreateTime
            pstmt.setDouble(7, tokenAmount);

            // Execute the insert
            int rowsAffected = pstmt.executeUpdate();

            // Close resources
            pstmt.close();
            conn.close();

            // Check if insertion was successful
            if (rowsAffected > 0) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Contract saved successfully");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Failed to save contract");
            }
        } catch (SQLException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error: " + e.getMessage());
            e.printStackTrace();
            System.out.println("SQL State: " + e.getSQLState() + ", Error Code: " + e.getErrorCode());
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
}