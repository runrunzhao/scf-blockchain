package com.supplychainfinance.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
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
            String tokenAmountStr = request.getParameter("tokenAmout");
            String memo = request.getParameter("memo");

    
            // Replace the if condition with this:
            if (ownerAddr == null || ownerAddr.trim().isEmpty() ||
                    tokenName == null || tokenName.trim().isEmpty() ||
                    tokenSymbol == null || tokenSymbol.trim().isEmpty() ||
                    scexpireDateStr == null || scexpireDateStr.trim().isEmpty()) {

                jsonResponse.put("success", false);
                jsonResponse.put("message", "Missing required parameters");
                return;
            }

            // Parse expiration date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date expireDate = dateFormat.parse(scexpireDateStr);
            Timestamp scexpireDate = new Timestamp(expireDate.getTime());

            // Parse token amount
            double tokenAmount = Double.parseDouble(tokenAmountStr);

            // Get database connection
            Connection conn = DBUtil.getConnection();

            // Prepare SQL statement
            String sql = "INSERT INTO SCToken (owerAddr, tokenName, tokenSymbol, scexpireDate, " +
                    "genContractAddr, tokenAmout, memo) VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, ownerAddr);
            pstmt.setString(2, tokenName);
            pstmt.setString(3, tokenSymbol);
            pstmt.setTimestamp(4, scexpireDate);
            pstmt.setString(5, genContractAddr);
            pstmt.setDouble(6, tokenAmount);
            pstmt.setString(7, memo);

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