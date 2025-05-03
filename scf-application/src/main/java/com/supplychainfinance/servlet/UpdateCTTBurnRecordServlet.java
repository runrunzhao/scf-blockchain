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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;

public class UpdateCTTBurnRecordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
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

            // Extract burnID (mandatory)
            if (!jsonObject.has("burnID") || jsonObject.get("burnID").isJsonNull()) {
                throw new IllegalArgumentException("burnID is required for update.");
            }
            int burnID = jsonObject.get("burnID").getAsInt();

            // Extract fields to update (e.g., execTX)
            String execTX = jsonObject.has("execTX") && !jsonObject.get("execTX").isJsonNull()
                    ? jsonObject.get("execTX").getAsString()
                    : null;

            // Extract optional operation date
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
                    System.err.println("Error parsing date for update: " + e.getMessage() + ". Date will not be updated.");
                    // Decide if you want to throw an error or just skip updating the date
                }
            }


            // Build the SQL UPDATE statement dynamically based on provided fields
            StringBuilder sqlBuilder = new StringBuilder("UPDATE CTTBurnRecord SET ");
            boolean firstField = true;

            if (execTX != null && !execTX.isEmpty()) {
                sqlBuilder.append("execTX = ?");
                firstField = false;
            }
             if (formattedDate != null) {
                if (!firstField) sqlBuilder.append(", ");
                sqlBuilder.append("operationDate = ?");
                firstField = false;
            }
            // Add other updatable fields here in the same pattern

            // Check if any field was actually provided for update
            if (firstField) {
                 throw new IllegalArgumentException("No fields provided for update.");
            }

            sqlBuilder.append(" WHERE burnID = ?");
            String sql = sqlBuilder.toString();

            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);

            // Set parameters for the prepared statement
            int paramIndex = 1;
            if (execTX != null && !execTX.isEmpty()) {
                pstmt.setString(paramIndex++, execTX);
            }
             if (formattedDate != null) {
                pstmt.setDate(paramIndex++, formattedDate);
            }
            // Set parameters for other fields here

            pstmt.setInt(paramIndex, burnID); // Set the burnID for the WHERE clause

            int rowsAffected = pstmt.executeUpdate();

            // Create response
            JsonObject responseJson = new JsonObject();
            responseJson.addProperty("success", rowsAffected > 0);
            responseJson.addProperty("message", rowsAffected > 0 ? "CTT burn record updated successfully" : "Failed to update CTT burn record (record not found or no changes)");
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

     // Optionally implement doPost to call doPut if you want to allow POST for updates too
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPut(req, resp);
    }
}