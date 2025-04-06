package com.supplychainfinance.dao;

import com.supplychainfinance.model.User;
import com.supplychainfinance.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Date;


public class UserDAO {

    // Register new user
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, password, first_name, last_name, email, enterprise_id, registration_date, account_status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                     
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword()); // Should be hashed before passing to this method
            pstmt.setString(3, user.getFirstName());
            pstmt.setString(4, user.getLastName());
            pstmt.setString(5, user.getEmail());
            pstmt.setString(6, user.getEnterpriseId());
            
            // Set current date as registration date
            Date currentDate = new Date(System.currentTimeMillis());
            pstmt.setDate(7, currentDate);
            
            pstmt.setString(8, "active");
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Check if username already exists
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Check if email already exists
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Get user by username
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setFirstName(rs.getString("first_name"));
                    user.setLastName(rs.getString("last_name"));
                    user.setEmail(rs.getString("email"));
                    user.setEnterpriseId(rs.getString("enterprise_id"));
                    user.setRegistrationDate(rs.getDate("registration_date"));
                    user.setLastLogin(rs.getTimestamp("last_login"));
                    user.setAccountStatus(rs.getString("account_status"));
                    user.setMemo(rs.getString("memo"));
                    user.setWalletAddr(rs.getString("walletAddr")); 
                    return user;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

// 添加以下方法到现有的 UserDAO 类中

// Update last login time
public boolean updateLastLogin(int userId, Timestamp lastLogin) {
    String sql = "UPDATE users SET last_login = ? WHERE user_id = ?";
    
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setTimestamp(1, lastLogin);
        pstmt.setInt(2, userId);
        
        int rowsAffected = pstmt.executeUpdate();
        return rowsAffected > 0;
        
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

}