package com.supplychainfinance.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import com.supplychainfinance.util.DBUtil;

public class UpdateSCMultiAddressServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String multiTokenID = request.getParameter("multiTokenID");
        String contractAddress = request.getParameter("contractAddress");
        
        JSONObject jsonResponse = new JSONObject();
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            // 验证参数
            if(multiTokenID == null || multiTokenID.trim().isEmpty() || 
               contractAddress == null || contractAddress.trim().isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Missing required parameters");
                return;
            }
            
            conn = DBUtil.getConnection();
            
            // 更新SCMulti合约地址
            String sql = "UPDATE scMulti SET genmuliContractAddr = ? WHERE multiTokenID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, contractAddress);
            pstmt.setString(2, multiTokenID);
            
            int rowsAffected = pstmt.executeUpdate();
            
            if(rowsAffected > 0) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "SCMulti contract address updated successfully");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Failed to update SCMulti contract address. Record not found.");
            }
        } catch(SQLException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(null, pstmt, conn);
        }
        
        // 设置响应内容类型并发送响应
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
}