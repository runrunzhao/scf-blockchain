package com.supplychainfinance.util;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class scTransAddressUtil {
    
    public static String getLatestScTransAddr() throws SQLException {
        String scTransAddr = null;
        String sql = "SELECT scTransAddr FROM scTransMultiConnection ORDER BY scConnectTime DESC LIMIT 1";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            if (rs.next()) {
                scTransAddr = rs.getString("scTransAddr");
            }
        }
        
        return scTransAddr;
    }
}