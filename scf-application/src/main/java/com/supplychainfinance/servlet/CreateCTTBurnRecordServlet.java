package com.supplychainfinance.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.supplychainfinance.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types; // Import Types for setting NULL
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Date; // Import java.util.Date

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

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Parse JSON data
            JsonObject jsonObject = gson.fromJson(data, JsonObject.class);

            // Extract burn amount
            double amount = jsonObject.has("amount") && !jsonObject.get("amount").isJsonNull()
                    ? jsonObject.get("amount").getAsDouble()
                    : 0;

            // Extract proposal transaction hash (sent as correspondpingTX from JS)
            String correspondpingTX = jsonObject.has("correspondpingTX") && !jsonObject.get("correspondpingTX").isJsonNull()
                    ? jsonObject.get("correspondpingTX").getAsString()
                    : null;

            // Extract execution transaction hash (sent as txHash from JS, maps to execTX)
            // This might be null during initial creation
            String execTX = jsonObject.has("txHash") && !jsonObject.get("txHash").isJsonNull()
                    ? jsonObject.get("txHash").getAsString()
                    : null;

            // Extract operation date string
            String operationDateString = jsonObject.has("operationDate") && !jsonObject.get("operationDate").isJsonNull()
                    ? jsonObject.get("operationDate").getAsString()
                    : null;

            // Validate required fields (correspondpingTX is now mandatory for creation)
            if (amount <= 0) {
                throw new IllegalArgumentException("Invalid amount. Amount must be positive.");
            }
            if (correspondpingTX == null || correspondpingTX.isEmpty()) {
                throw new IllegalArgumentException("Missing proposal transaction hash (correspondpingTX).");
            }
             if (operationDateString == null || operationDateString.isEmpty()) {
                throw new IllegalArgumentException("Missing operation date.");
            }

            // Format date
            java.sql.Date formattedDate;
            try {
                SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
                Date parsedDate = inputFormat.parse(operationDateString);
                formattedDate = new java.sql.Date(parsedDate.getTime());
            } catch (ParseException e) {
                throw new IllegalArgumentException("Invalid date format. Use YYYY-MM-DD.", e);
            }


            // Insert into database - include execTX
            String sql = "INSERT INTO CTTBurnRecord (amount, correspondpingTX, operationDate, execTX) VALUES (?, ?, ?, ?)";
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setDouble(1, amount);
            pstmt.setString(2, correspondpingTX); // Save proposal hash here
            pstmt.setDate(3, formattedDate);

            // Set execTX, allowing for NULL if not provided
            if (execTX != null && !execTX.isEmpty()) {
                pstmt.setString(4, execTX);
            } else {
                pstmt.setNull(4, Types.VARCHAR); // Set SQL NULL if execTX is missing or empty
            }


            int rowsAffected = pstmt.executeUpdate();

            // Create response
            JsonObject responseJson = new JsonObject();
            responseJson.addProperty("success", rowsAffected > 0);
            responseJson.addProperty("message", rowsAffected > 0 ? "CTT burn record created successfully" : "Failed to create CTT burn record");
            out.print(gson.toJson(responseJson));

        } catch (IllegalArgumentException | SQLException | com.google.gson.JsonSyntaxException e) {
            // Handle errors (JSON parsing, validation, DB)
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Use appropriate status code
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Error: " + e.getMessage());
            out.print(gson.toJson(errorResponse));
            e.printStackTrace();
        } finally {
            // Close resources
            if (pstmt != null) {
                try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (out != null) {
                out.flush();
            }
        }
    }
}