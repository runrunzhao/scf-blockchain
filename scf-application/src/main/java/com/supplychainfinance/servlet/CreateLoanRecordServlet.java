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
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CreateLoanRecordServlet extends HttpServlet {

    private Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
            // 1. Parse JSON data
            JsonObject jsonObject = gson.fromJson(data, JsonObject.class);

            // 2. Extract data from JSON
            String enterpriseID = jsonObject.has("enterpriseID") && !jsonObject.get("enterpriseID").isJsonNull()
                    ? jsonObject.get("enterpriseID").getAsString()
                    : null;
            double loanAmount = jsonObject.has("loanAmount") && !jsonObject.get("loanAmount").isJsonNull()
                    ? jsonObject.get("loanAmount").getAsDouble()
                    : 0;
            double interestRate = jsonObject.has("interestRate") && !jsonObject.get("interestRate").isJsonNull()
                    ? jsonObject.get("interestRate").getAsDouble()
                    : 0;
            String loanDueDateStr = jsonObject.has("loanDueDate") && !jsonObject.get("loanDueDate").isJsonNull()
                    ? jsonObject.get("loanDueDate").getAsString()
                    : null;
            String correspondpingTX = jsonObject.has("correspondpingTX") && !jsonObject.get("correspondpingTX").isJsonNull()
                    ? jsonObject.get("correspondpingTX").getAsString()
                    : null;
            String correspondpingTXDate = jsonObject.has("correspondpingTXDate") && !jsonObject.get("correspondpingTXDate").isJsonNull()
                    ? jsonObject.get("correspondpingTXDate").getAsString()
                    : null;
            String loanDescription = jsonObject.has("loanDescription") && !jsonObject.get("loanDescription").isJsonNull()
                    ? jsonObject.get("loanDescription").getAsString()
                    : "";

            // 3. Validate data
            if (enterpriseID == null || enterpriseID.isEmpty() || loanAmount <= 0 || interestRate <= 0 || loanDueDateStr == null || loanDueDateStr.isEmpty() || correspondpingTX == null || correspondpingTX.isEmpty() || correspondpingTXDate == null || correspondpingTXDate.isEmpty()) {
                throw new IllegalArgumentException("Missing or invalid data");
            }

            // 4. Parse the loanDueDate string to a Date object
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date loanDueDate;
            try {
                loanDueDate = dateFormat.parse(loanDueDateStr);
            } catch (ParseException e) {
                throw new IllegalArgumentException("日期格式不正确");
            }

            // 5. Database insertion
            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                conn = DBUtil.getConnection();
                String sql = "INSERT INTO loanRecord (enterpriseID, loanAmount, interestRate, loanDueDate, correspondpingTX, correspondpingTXDate, loanDescription) VALUES (?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, enterpriseID);
                pstmt.setDouble(2, loanAmount);
                pstmt.setDouble(3, interestRate);
                pstmt.setDate(4, new java.sql.Date(loanDueDate.getTime()));
                pstmt.setString(5, correspondpingTX);
                pstmt.setString(6, correspondpingTXDate);
                pstmt.setString(7, loanDescription);

                int rowsAffected = pstmt.executeUpdate();

                // 6. Create response
                JsonObject responseJson = new JsonObject();
                responseJson.addProperty("success", rowsAffected > 0);
                responseJson.addProperty("message", rowsAffected > 0 ? "贷款记录创建成功" : "贷款记录创建失败");
                out.print(gson.toJson(responseJson));

            } catch (SQLException e) {
                throw new SQLException("数据库操作失败: " + e.getMessage());
            } finally {
                if (pstmt != null) {
                    try {
                        pstmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace(); // Log the exception
                    }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace(); // Log the exception
                    }
                }
            }

        } catch (IllegalArgumentException | SQLException e) {
            // 7. Handle errors
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "操作失败: " + e.getMessage());
            out.print(gson.toJson(errorResponse));

            e.printStackTrace();
        } finally {
            out.flush();
        }
    }
}