package com.supplychainfinance.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.supplychainfinance.util.DBUtil;
import com.google.gson.JsonObject;


public class ContractPartiesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            String contractId = request.getParameter("contractId");
            if (contractId == null || contractId.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\":\"Contract ID is required\"}");
                return;
            }
            
            JsonObject result = getContractPartiesInfo(contractId);
            out.print(result.toString());
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
            e.printStackTrace();
        }
    }
    
    private JsonObject getContractPartiesInfo(String contractId) {
        JsonObject result = new JsonObject();
        System.out.println("contract: " + contractId);
        
        try (Connection conn = DBUtil.getConnection()) {
            // First query: Get part1 and part2 from contract table
            String contractQuery = "SELECT part1, part2 FROM contract WHERE contractID = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(contractQuery)) {
                pstmt.setString(1, contractId);
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        String part1 = rs.getString("part1");  // Payer enterprise ID
                        String part2 = rs.getString("part2");  // Receiver enterprise ID
                        System.out.println(part1 +":" + part2);
                        
                        // Query for payer information
                        if (part1 != null && !part1.isEmpty()) {
                            String payerQuery = 
                                "SELECT e.enterpriseName, u.walletAddr FROM users u " +
                                "JOIN enterprise e ON u.enterprise_id = e.enterpriseID " +
                                "WHERE e.enterpriseID = ?";
                                
                            try (PreparedStatement payerStmt = conn.prepareStatement(payerQuery)) {
                                payerStmt.setString(1, part1);
                                System.out.println(payerStmt);
                                try (ResultSet payerRs = payerStmt.executeQuery()) {
                                    if (payerRs.next()) {
                                        System.out.println(payerRs.getString("enterpriseName"));
                                        System.out.println(payerRs.getString("walletAddr"));
                                        result.addProperty("payerName", payerRs.getString("enterpriseName"));
                                        result.addProperty("payerWalletAddr", payerRs.getString("walletAddr"));
                                    }
                                }
                            }
                        }
                        
                        // Query for receiver information
                        if (part2 != null && !part2.isEmpty()) {
                            String receiverQuery = 
                                "SELECT e.enterpriseName, u.walletAddr FROM users u " +
                                "JOIN enterprise e ON u.enterprise_id = e.enterpriseID" +
                                "WHERE e.enterpriseID = ?";
                                
                            try (PreparedStatement receiverStmt = conn.prepareStatement(receiverQuery)) {
                                receiverStmt.setString(1, part2);
                                
                                try (ResultSet receiverRs = receiverStmt.executeQuery()) {
                                    if (receiverRs.next()) {
                                        result.addProperty("receiverName", receiverRs.getString("enterpriseName"));
                                        result.addProperty("receiverWalletAddr", receiverRs.getString("walletAddr"));
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.addProperty("error", e.getMessage());
        }
        
        return result;
    }
}