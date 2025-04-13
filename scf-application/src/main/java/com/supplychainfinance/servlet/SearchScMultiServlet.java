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

public class SearchScMultiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String scTransAddr = request.getParameter("scTransAddr");
        String signerAddress = request.getParameter("signerAddress");
        String searchMode = request.getParameter("mode"); // Add a mode parameter to explicitly switch behavior
        
        JSONObject jsonResponse = new JSONObject();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection();
            
            // Only use signerAddress if mode is explicitly set to "signer"
            // This ensures existing functionality remains intact
            if ("signer".equals(searchMode) && signerAddress != null && !signerAddress.isEmpty()) {
                String sql = "SELECT * FROM scMulti WHERE signer1 = ? OR signer2 = ? OR signer3 = ? ORDER BY scmultiCreateTime DESC LIMIT 1";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, signerAddress);
                pstmt.setString(2, signerAddress);
                pstmt.setString(3, signerAddress);
            } 
            // Default behavior - unchanged from original
            else if (scTransAddr != null && !scTransAddr.isEmpty()) {
                String sql = "SELECT * FROM scMulti WHERE scTransAddr = ? ORDER BY scmultiCreateTime DESC LIMIT 1";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, scTransAddr);
            } 
            else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Missing required parameter: scTransAddr");
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print(jsonResponse.toString());
                out.flush();
                return;
            }
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                JSONObject scMultiData = new JSONObject();
                scMultiData.put("multiTokenID", rs.getInt("multiTokenID"));
                scMultiData.put("scTransAddr", rs.getString("scTransAddr"));
                scMultiData.put("signer1", rs.getString("signer1"));
                scMultiData.put("signer2", rs.getString("signer2"));
                scMultiData.put("signer3", rs.getString("signer3"));
                scMultiData.put("memo", rs.getString("memo"));
                scMultiData.put("genmuliContractAddr", rs.getString("genmuliContractAddr"));
                scMultiData.put("scmultiCreateTime", rs.getString("scmultiCreateTime"));
                
                jsonResponse.put("success", true);
                jsonResponse.put("data", scMultiData);
            } else {
                String searchTerm = "signer".equals(searchMode) ? "signer address" : "SCTrans address";
                String paramValue = "signer".equals(searchMode) ? signerAddress : scTransAddr;
                jsonResponse.put("success", false);
                jsonResponse.put("message", "No SCMulti record found for the given " + searchTerm + ": " + paramValue);
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