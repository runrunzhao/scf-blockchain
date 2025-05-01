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

            double loanAmount = jsonObject.has("loanAmount") && !jsonObject.get("loanAmount").isJsonNull()
                    ? jsonObject.get("loanAmount").getAsDouble()
                    : 0;

            String correspondpingTX = jsonObject.has("correspondpingTX")
                    && !jsonObject.get("correspondpingTX").isJsonNull()
                            ? jsonObject.get("correspondpingTX").getAsString()
                            : null;
            String correspondpingTXDateString = jsonObject.has("correspondpingTXDate")
                    && !jsonObject.get("correspondpingTXDate").isJsonNull()
                            ? jsonObject.get("correspondpingTXDate").getAsString()
                            : null;
            System.err.println(correspondpingTXDateString);

            String loanDescription = jsonObject.has("loanDescription")
                    && !jsonObject.get("loanDescription").isJsonNull()
                            ? jsonObject.get("loanDescription").getAsString()
                            : "";

            java.sql.Date formattedDate = null;
            if (correspondpingTXDateString != null && !correspondpingTXDateString.isEmpty()) {
                try {
                    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd, hh:mm:ss a", Locale.US);
                    java.util.Date parsedDate = inputFormat.parse(correspondpingTXDateString);
                    // 使用 Date 而不是 Timestamp，因为数据库字段是 date 类型
                    formattedDate = new java.sql.Date(parsedDate.getTime());
                } catch (ParseException e) {
                    System.err.println("Error parsing date: " + e.getMessage());
                    // 解析失败时使用当前时间
                    formattedDate = new java.sql.Date(System.currentTimeMillis());
                }
            }
            // 5. Database insertion
            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                conn = DBUtil.getConnection();
                String sql = "INSERT INTO loanRecord ( loanAmount,  correspondpingTX, correspondpingTXDate, loanDescription) VALUES (?,?, ?, ?)";
                pstmt = conn.prepareStatement(sql);

                pstmt.setDouble(1, loanAmount);
                pstmt.setString(2, correspondpingTX);
                pstmt.setDate(3, formattedDate);
                pstmt.setString(4, loanDescription);

                int rowsAffected = pstmt.executeUpdate();

                // 6. Create response
                JsonObject responseJson = new JsonObject();
                responseJson.addProperty("success", rowsAffected > 0);
                responseJson.addProperty("message", rowsAffected > 0 ? "贷款记录创建成功" : "贷款记录创建失败");
                out.print(gson.toJson(responseJson));

            } catch (SQLException e) {
                throw new SQLException("dabase connection error: " + e.getMessage());
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
            errorResponse.addProperty("message", "error: " + e.getMessage());
            out.print(gson.toJson(errorResponse));

            e.printStackTrace();
        } finally {
            out.flush();
        }
    }
}