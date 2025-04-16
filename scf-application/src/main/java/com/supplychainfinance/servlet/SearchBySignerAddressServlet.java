package com.supplychainfinance.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.supplychainfinance.util.DBUtil;

public class SearchBySignerAddressServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        
        try {
            // Get the signer address parameter
            String signerAddress = request.getParameter("signerAddress");
            
            if (signerAddress == null || signerAddress.isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Signer address parameter is required");
                out.print(jsonResponse.toString());
                return;
            }
            
            Connection conn = DBUtil.getConnection();
            
            // 查询 scMulti 表中指定签名者的记录
            String sql = "SELECT * FROM scMulti " +
                         "WHERE signer1 = ? OR signer2 = ? OR signer3 = ? " +
                         "ORDER BY scmultiCreateTime DESC LIMIT 1";
                         
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, signerAddress);
            pstmt.setString(2, signerAddress);
            pstmt.setString(3, signerAddress);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // 提取 scMulti 表的数据
                JSONObject multiData = new JSONObject();
                multiData.put("multiTokenID", rs.getInt("multiTokenID"));
                multiData.put("signer1", rs.getString("signer1"));
                multiData.put("signer2", rs.getString("signer2"));
                multiData.put("signer3", rs.getString("signer3"));
                multiData.put("requiredConfirmations", rs.getInt("requiredConfirmations"));
                multiData.put("genmuliContractAddr", rs.getString("genmuliContractAddr"));
                
                java.sql.Timestamp multiCreateTime = rs.getTimestamp("scmultiCreateTime");
                multiData.put("scmultiCreateTime", multiCreateTime != null ? 
                              new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(multiCreateTime) : "");
                
                //  scTransAddr 用于查询 SCToken 表
                String scTransAddr = rs.getString("scTransAddr");
                multiData.put("scTransAddr", scTransAddr);
                
                jsonResponse.put("multi", multiData);
                
                // SCToken 表
                if (scTransAddr != null && !scTransAddr.isEmpty()) {
                    String tokenSql = "SELECT * FROM SCToken WHERE genContractAddr = ? ORDER BY scCreateTime  DESC LIMIT 1";
                    PreparedStatement tokenStmt = conn.prepareStatement(tokenSql);
                    tokenStmt.setString(1, scTransAddr);
                    ResultSet tokenRs = tokenStmt.executeQuery();
                    
                    if (tokenRs.next()) {
                        JSONObject tokenData = new JSONObject();
                        tokenData.put("tokenID", tokenRs.getInt("tokenID"));
                        tokenData.put("owerAddr", tokenRs.getString("owerAddr"));
                        tokenData.put("tokenName", tokenRs.getString("tokenName"));
                        tokenData.put("tokenSymbol", tokenRs.getString("tokenSymbol"));
                        
                        java.sql.Date expireDate = tokenRs.getDate("scexpireDate");
                        tokenData.put("scexpireDate", expireDate != null ? 
                                     new SimpleDateFormat("yyyy-MM-dd").format(expireDate) : "");
                        
                        tokenData.put("genContractAddr", tokenRs.getString("genContractAddr"));
                        
                        java.sql.Timestamp createTime = tokenRs.getTimestamp("scCreateTime");
                        tokenData.put("scCreateTime", createTime != null ? 
                                      new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(createTime) : "");
                        
                        tokenData.put("tokenAmount", tokenRs.getDouble("tokenAmount"));
                        
                        jsonResponse.put("token", tokenData);
                        jsonResponse.put("success", true);
                        jsonResponse.put("message", "Found matching multi-sig contract and token information");
                    } else {
                        jsonResponse.put("success", true);
                        jsonResponse.put("message", "Found multi-sig contract but no matching token information");
                    }
                    
                    tokenRs.close();
                    tokenStmt.close();
                } else {
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "Found multi-sig contract but no scTransAddr is specified");
                }
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "No multi-sig contract found where you are a signer");
            }
            
            rs.close();
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error: " + e.getMessage());
        }
        
        out.print(jsonResponse.toString());
    }
}