package com.supplychainfinance.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;
import com.supplychainfinance.util.DBUtil; // Assuming this is your DB utility class

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

public class UpdateCTTLoanRecordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JsonObject responseJson = new JsonObject();

        StringBuilder buffer = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
        } catch (IOException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "Error reading request body: " + e.getMessage());
            out.print(gson.toJson(responseJson));
            return;
        }

        String jsonData = buffer.toString();
        System.out.println("UpdateCTTLoanRecordServlet received JSON: " + jsonData); // Debug log

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Parse JSON data
            JsonObject loanData = gson.fromJson(jsonData, JsonObject.class);

            // Extract loanIssueID (mandatory)
            if (!loanData.has("loanIssueID") || loanData.get("loanIssueID").isJsonNull()) {
                throw new IllegalArgumentException("Missing required field: loanIssueID");
            }
            String loanIssueID = loanData.get("loanIssueID").getAsString();

            // --- Prepare SQL UPDATE statement ---
            // Start building the update query dynamically
            StringBuilder sqlBuilder = new StringBuilder("UPDATE loanRecord SET ");
            java.util.List<Object> params = new java.util.ArrayList<>();
            boolean firstField = true;

            // Add fields to update if they exist in the JSON
            if (loanData.has("interestRate") && !loanData.get("interestRate").isJsonNull()) {
                sqlBuilder.append("interestRate = ?");
                params.add(loanData.get("interestRate").getAsDouble());
                firstField = false;
            }
            if (loanData.has("issueDate") && !loanData.get("issueDate").isJsonNull()) {
                if (!firstField) sqlBuilder.append(", ");
                sqlBuilder.append("issueDate = ?");
                // Assuming date is sent as YYYY-MM-DD string
                params.add(parseSqlDate(loanData.get("issueDate").getAsString()));
                firstField = false;
            }
            if (loanData.has("loanDueDate") && !loanData.get("loanDueDate").isJsonNull()) {
                if (!firstField) sqlBuilder.append(", ");
                sqlBuilder.append("loanDueDate = ?");
                params.add(parseSqlDate(loanData.get("loanDueDate").getAsString()));
                firstField = false;
            }
            // Add other updatable fields similarly
            if (loanData.has("loanAmount") && !loanData.get("loanAmount").isJsonNull()) {
                 if (!firstField) sqlBuilder.append(", ");
                 sqlBuilder.append("loanAmount = ?");
                 params.add(loanData.get("loanAmount").getAsDouble());
                 firstField = false;
            }
             if (loanData.has("correspondpingTX") && !loanData.get("correspondpingTX").isJsonNull()) {
                 if (!firstField) sqlBuilder.append(", ");
                 sqlBuilder.append("correspondpingTX = ?");
                 params.add(loanData.get("correspondpingTX").getAsString());
                 firstField = false;
            }
             if (loanData.has("correspondpingTXDate") && !loanData.get("correspondpingTXDate").isJsonNull()) {
                 if (!firstField) sqlBuilder.append(", ");
                 sqlBuilder.append("correspondpingTXDate = ?");
                 // Assuming this is also a date string, adjust format if needed
                 params.add(parseSqlDate(loanData.get("correspondpingTXDate").getAsString()));
                 firstField = false;
            }
             if (loanData.has("loanDescription") && !loanData.get("loanDescription").isJsonNull()) {
                 if (!firstField) sqlBuilder.append(", ");
                 sqlBuilder.append("loanDescription = ?");
                 params.add(loanData.get("loanDescription").getAsString());
                 firstField = false;
            }
             // Note: coreEnterprise might not be updatable if it's read-only in the form

            // Check if any fields were added to update
            if (firstField) {
                 throw new IllegalArgumentException("No fields provided to update.");
            }


            // Add the WHERE clause
            sqlBuilder.append(" WHERE loanIssueID = ?");
            params.add(loanIssueID); // Add loanIssueID as the last parameter

            // --- Execute Update ---
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction

            pstmt = conn.prepareStatement(sqlBuilder.toString());

            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }

            System.out.println("Executing SQL: " + sqlBuilder.toString()); // Debug log
            System.out.println("With parameters: " + params); // Debug log

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                conn.commit(); // Commit transaction
                responseJson.addProperty("success", true);
                responseJson.addProperty("message", "Loan record updated successfully.");
                System.out.println("Update successful for loanIssueID: " + loanIssueID); // Debug log
            } else {
                conn.rollback(); // Rollback if no rows affected (ID not found?)
                responseJson.addProperty("success", false);
                responseJson.addProperty("message", "Loan record not found or no changes made.");
                 System.out.println("Update failed or no changes for loanIssueID: " + loanIssueID); // Debug log
            }

        } catch (JsonSyntaxException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "Invalid JSON format: " + e.getMessage());
             System.err.println("JSON Parsing Error: " + e.getMessage()); // Debug log
        } catch (IllegalArgumentException | ParseException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "Invalid input data: " + e.getMessage());
             System.err.println("Input Data Error: " + e.getMessage()); // Debug log
        } catch (SQLException e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); } // Rollback on error
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "Database error during update: " + e.getMessage());
            e.printStackTrace(); // Log full error
        } catch (Exception e) {
             if (conn != null) try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "An unexpected error occurred: " + e.getMessage());
            e.printStackTrace();
        }
        finally {
            // Close resources
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { e.printStackTrace(); } // Reset autoCommit and close
            out.print(gson.toJson(responseJson));
            out.flush();
        }
    }

    // Helper function to parse date string (YYYY-MM-DD) to java.sql.Date
    private java.sql.Date parseSqlDate(String dateString) throws ParseException {
        if (dateString == null || dateString.trim().isEmpty()) {
            return null;
        }
        // Adjust format if your input date format is different
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        format.setLenient(false); // Disallow invalid dates like 2025-02-30
        java.util.Date parsedDate = format.parse(dateString.trim());
        return new java.sql.Date(parsedDate.getTime());
    }
}