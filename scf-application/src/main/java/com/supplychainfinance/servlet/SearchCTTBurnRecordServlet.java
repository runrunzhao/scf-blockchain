package com.supplychainfinance.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.supplychainfinance.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SearchCTTBurnRecordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String burnIdParam = request.getParameter("burnID");
        String txParam = request.getParameter("correspondpingTX"); // Corrected parameter name

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = null;
        Object searchValue = null;

        try {
            // Determine search criteria
            if (burnIdParam != null && !burnIdParam.isEmpty()) {
                sql = "SELECT * FROM CTTBurnRecord WHERE burnID = ?";
                try {
                    searchValue = Integer.parseInt(burnIdParam);
                } catch (NumberFormatException e) {
                    throw new IllegalArgumentException("Invalid burnID format. Must be an integer.");
                }
            } else if (txParam != null && !txParam.isEmpty()) {
                sql = "SELECT * FROM CTTBurnRecord WHERE correspondpingTX = ?"; // Corrected column name
                searchValue = txParam;
            } else {
                throw new IllegalArgumentException("Missing search parameter. Provide either 'burnID' or 'correspondpingTX'.");
            }

            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);

            // Set the parameter based on type
            if (searchValue instanceof Integer) {
                pstmt.setInt(1, (Integer) searchValue);
            } else if (searchValue instanceof String) {
                pstmt.setString(1, (String) searchValue);
            }

            rs = pstmt.executeQuery();

            JsonObject resultJson = null;
            if (rs.next()) {
                // Record found, build JSON object
                resultJson = new JsonObject();
                resultJson.addProperty("burnID", rs.getInt("burnID"));
                resultJson.addProperty("amount", rs.getDouble("amount"));
                // Handle potential null date
                java.sql.Date operationDate = rs.getDate("operationDate");
                resultJson.addProperty("operationDate", operationDate != null ? operationDate.toString() : null);
                 // Handle potential null execTX
                String execTx = rs.getString("execTX");
                resultJson.addProperty("execTX", execTx);
                 // Handle potential null correspondpingTX
                String correspondingTx = rs.getString("correspondpingTX"); // Corrected column name
                resultJson.addProperty("correspondpingTX", correspondingTx);

                // Add other fields as needed
            }

            // Create response
            JsonObject responseJson = new JsonObject();
            if (resultJson != null) {
                responseJson.addProperty("success", true);
                responseJson.add("record", resultJson);
            } else {
                responseJson.addProperty("success", false);
                responseJson.addProperty("message", "No CTT burn record found for the given criteria.");
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404 Not Found
            }
            out.print(gson.toJson(responseJson));

        } catch (IllegalArgumentException | SQLException e) {
            // Handle errors (validation, DB)
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Use appropriate status code
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Error: " + e.getMessage());
            out.print(gson.toJson(errorResponse));
            e.printStackTrace();
        } finally {
            // Close resources
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
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