package com.supplychainfinance.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.supplychainfinance.util.DBUtil;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet to handle CTT burn record creation
 */
public class CreateCTTBurnRecordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read JSON data from request body
        StringBuilder buffer = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            buffer.append(line);
        }

        String data = buffer.toString();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Parse JSON data
            JsonObject jsonObject = gson.fromJson(data, JsonObject.class);

            // Extract burn amount
            double amount = jsonObject.has("amount") && !jsonObject.get("amount").isJsonNull()
                    ? jsonObject.get("amount").getAsDouble()
                    : 0;
            
            if (amount <= 0) {
                throw new IllegalArgumentException("Burn amount must be greater than 0");
            }

            // Extract blockchain transaction ID
            String execTX = jsonObject.has("txHash") && !jsonObject.get("txHash").isJsonNull()
                    ? jsonObject.get("txHash").getAsString()
                    : null;
            
            if (execTX == null || execTX.isEmpty()) {
                throw new IllegalArgumentException("Transaction hash cannot be empty");
            }
            
            // Extract operation date (optional - use current date if not provided)
            String operationDateString = jsonObject.has("operationDate") && !jsonObject.get("operationDate").isJsonNull()
                    ? jsonObject.get("operationDate").getAsString()
                    : null;
            
            java.sql.Date formattedDate = null;
            if (operationDateString != null && !operationDateString.isEmpty()) {
                try {
                    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
                    java.util.Date parsedDate = inputFormat.parse(operationDateString);
                    formattedDate = new java.sql.Date(parsedDate.getTime());
                } catch (ParseException e) {
                    System.err.println("Error parsing date: " + e.getMessage());
                    // Use current date if parsing fails
                    formattedDate = new java.sql.Date(System.currentTimeMillis());
                }
            } else {
                // Use current date if no date provided
                formattedDate = new java.sql.Date(System.currentTimeMillis());
            }

            // Database insertion
            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                conn = DBUtil.getConnection();
                String sql = "INSERT INTO CTTBurnRecord (amount, operationDate, execTX) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(sql);

                pstmt.setDouble(1, amount);
                pstmt.setDate(2, formattedDate);
                pstmt.setString(3, execTX);

                int rowsAffected = pstmt.executeUpdate();

                // Create response
                JsonObject responseJson = new JsonObject();
                responseJson.addProperty("success", rowsAffected > 0);
                responseJson.addProperty("message", rowsAffected > 0 ? "CTT burn record created successfully" : "Failed to create CTT burn record");
                out.print(gson.toJson(responseJson));

            } catch (SQLException e) {
                throw new SQLException("Database connection error: " + e.getMessage());
            } finally {
                if (pstmt != null) {
                    try {
                        pstmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }

        } catch (IllegalArgumentException | SQLException e) {
            // Handle errors
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Error: " + e.getMessage());
            out.print(gson.toJson(errorResponse));
            e.printStackTrace();
        } finally {
            out.flush();
        }
    }
}