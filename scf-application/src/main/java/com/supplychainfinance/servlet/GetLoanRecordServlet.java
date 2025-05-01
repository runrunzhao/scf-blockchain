package com.supplychainfinance.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.supplychainfinance.util.DBUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetLoanRecordServlet extends HttpServlet {

    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // 1. Get loanIssueID from request
            String loanIssueIDStr = request.getParameter("loanIssueID");
            if (loanIssueIDStr == null || loanIssueIDStr.isEmpty()) {
                throw new IllegalArgumentException("loanIssueID 不能为空");
            }

            int loanIssueID = Integer.parseInt(loanIssueIDStr);

            // 2. Retrieve LoanRecord from database
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            JsonObject loanRecordJson = null;

            try {
                conn = DBUtil.getConnection();
                String sql = "SELECT * FROM loanRecord WHERE loanIssueID = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, loanIssueID);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    loanRecordJson = new JsonObject();
                    loanRecordJson.addProperty("loanIssueID", rs.getInt("loanIssueID"));
                    loanRecordJson.addProperty("enterpriseID", rs.getString("enterpriseID"));
                    loanRecordJson.addProperty("loanAmount", rs.getDouble("loanAmount"));
                    loanRecordJson.addProperty("interestRate", rs.getDouble("interestRate"));
                    loanRecordJson.addProperty("loanDueDate", rs.getString("loanDueDate")); // Consider formatting the date
                    loanRecordJson.addProperty("correspondpingTX", rs.getString("correspondpingTX"));
                    loanRecordJson.addProperty("correspondpingTXDate", rs.getString("correspondpingTXDate"));
                    loanRecordJson.addProperty("loanDescription", rs.getString("loanDescription"));
                    // Add other fields as needed
                }

            } catch (SQLException e) {
                throw new SQLException("数据库操作失败: " + e.getMessage());
            } finally {
                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace(); // Log the exception
                    }
                }
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

            // 3. Create response
            JsonObject responseJson = new JsonObject();
            if (loanRecordJson != null) {
                responseJson.addProperty("success", true);
                responseJson.add("loanRecord", gson.toJsonTree(loanRecordJson)); // Convert JsonObject to JSON
            } else {
                responseJson.addProperty("success", false);
                responseJson.addProperty("message", "未找到贷款记录");
            }

            out.print(gson.toJson(responseJson));

        } catch (NumberFormatException e) {
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "loanIssueID 格式不正确");
            out.print(gson.toJson(errorResponse));
        } catch (IllegalArgumentException | SQLException e) {
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