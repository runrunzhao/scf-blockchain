package com.supplychainfinance.servlet;

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

import org.json.JSONObject;
import com.supplychainfinance.util.DBUtil;

public class SearchConnectionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String scTransAddr = request.getParameter("scTransAddr");
        
        JSONObject jsonResponse = new JSONObject();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection();
            
            String sql = "SELECT * FROM scTransMultiConnection WHERE scTransAddr = ? ORDER BY scConnectTime DESC LIMIT 1";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, scTransAddr);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                JSONObject connectionData = new JSONObject();
                connectionData.put("connectionID", rs.getInt("connectionID"));
                connectionData.put("scTransAddr", rs.getString("scTransAddr"));
                connectionData.put("scMultiAddr", rs.getString("scMultiAddr"));
                connectionData.put("scConnectTime", rs.getString("scConnectTime"));
                connectionData.put("memo", rs.getString("memo"));
                
                jsonResponse.put("success", true);
                jsonResponse.put("data", connectionData);
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "No connection found for the given SCTrans address");
            }
        } catch (SQLException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(rs, pstmt, conn);
        }
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
}
