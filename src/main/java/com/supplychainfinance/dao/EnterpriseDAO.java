package com.supplychainfinance.dao;

import com.supplychainfinance.model.Enterprise;
import com.supplychainfinance.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EnterpriseDAO {

     public String generateEnterpriseId(){
        return "E" + String.format("%07d", Math.abs(System.currentTimeMillis() % 10000000));
     }    
    public Enterprise getEnterpriseById(String id) {
        Enterprise enterprise = null;
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                "SELECT * FROM enterprise WHERE enterpriseID = ?")) {
            
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                enterprise = new Enterprise();
                enterprise.setEnterpriseID(rs.getString("enterpriseID"));
                enterprise.setEnterpriseName(rs.getString("enterpriseName"));
                enterprise.setAddress(rs.getString("address"));
                enterprise.setTelephone(rs.getString("telephone"));
                enterprise.setRole(rs.getString("role"));
                enterprise.setMemo(rs.getString("memo"));
                enterprise.setTier(rs.getInt("tier"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return enterprise;
    }
    
    public List<Enterprise> getAllEnterprises() {
        List<Enterprise> enterprises = new ArrayList<>();
        
        try (Connection conn = DBUtil.getConnection();
        
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM enterprise")) {
            
            while (rs.next()) {
                Enterprise enterprise = new Enterprise();
                enterprise.setEnterpriseID(rs.getString("enterpriseID"));
                enterprise.setEnterpriseName(rs.getString("enterpriseName"));
                enterprise.setAddress(rs.getString("address"));
                enterprise.setTelephone(rs.getString("telephone"));
                enterprise.setRole(rs.getString("role"));
                enterprise.setMemo(rs.getString("memo"));
                enterprise.setTier(rs.getInt("tier")); // 添加这行
                enterprises.add(enterprise);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return enterprises;
    }
    
    public boolean updateEnterprise(Enterprise enterprise) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                "UPDATE enterprise SET enterpriseName = ?, address = ?, telephone = ?, role = ?, memo = ?,tier= ? " +
                "WHERE enterpriseID = ?")) {
            
            stmt.setString(1, enterprise.getEnterpriseName());
            stmt.setString(2, enterprise.getAddress());
            stmt.setString(3, enterprise.getTelephone());
            stmt.setString(4, enterprise.getRole());
            stmt.setString(5, enterprise.getMemo());
            stmt.setInt(6, enterprise.getTier());  // 添加tier字段
            stmt.setString(7, enterprise.getEnterpriseID());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean createEnterprise(Enterprise enterprise) {
       
    String id = enterprise.getEnterpriseID();
    if (id == null || id.trim().isEmpty()) {
        System.out.println("ERROR: Attempting to create enterprise with empty ID!");
        // 如果ID为空，重新生成一个
        id = generateEnterpriseId();
        enterprise.setEnterpriseID(id);
    }
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO enterprise (enterpriseID, enterpriseName, address, telephone, role, memo,tier) " +
                "VALUES (?, ?, ?, ?, ?, ?,?)")) {
            
            stmt.setString(1, enterprise.getEnterpriseID());
            stmt.setString(2, enterprise.getEnterpriseName());
            stmt.setString(3, enterprise.getAddress());
            stmt.setString(4, enterprise.getTelephone());
            stmt.setString(5, enterprise.getRole());
            stmt.setString(6, enterprise.getMemo());
            stmt.setInt(7, enterprise.getTier());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteEnterprise(String id) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM enterprise WHERE enterpriseID = ?")) {
            
            stmt.setString(1, id);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    // Add this method to the EnterpriseDAO class:

/**
 * Search for enterprises based on criteria
 */
// Add or update this method:

/**
 * Search for enterprises based on criteria
 */
public List<Enterprise> searchEnterprises(String id, String name, String type) {
    List<Enterprise> enterprises = new ArrayList<>();
    
    try {
        Connection conn = DBUtil.getConnection();
        System.out.println("Database connection established");
        
        // Build dynamic SQL query based on provided parameters
        StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM enterprise WHERE 1=1");
        List<Object> params = new ArrayList<>();
        
        if (id != null && !id.trim().isEmpty()) {
            sqlBuilder.append(" AND enterpriseID LIKE ?");
            params.add("%" + id + "%");
        }
        
        if (name != null && !name.trim().isEmpty()) {
            sqlBuilder.append(" AND enterpriseName LIKE ?");
            params.add("%" + name + "%");
        }
        
        if (type != null && !type.trim().isEmpty()) {
            sqlBuilder.append(" AND role = ?");
            params.add(type);
        }
        
        // Order by enterprise ID
        sqlBuilder.append(" ORDER BY enterpriseID");
        
        String sql = sqlBuilder.toString();
        System.out.println("Search SQL: " + sql);
        
        // Prepare and execute the query
        PreparedStatement stmt = conn.prepareStatement(sql);
        
        // Set parameters
        for (int i = 0; i < params.size(); i++) {
            stmt.setObject(i + 1, params.get(i));
            System.out.println("Parameter " + (i + 1) + ": " + params.get(i));
        }
        
        ResultSet rs = stmt.executeQuery();
        System.out.println("Query executed");
        
        // Process results
        while (rs.next()) {
            Enterprise enterprise = new Enterprise();
            enterprise.setEnterpriseID(rs.getString("enterpriseID"));
            enterprise.setEnterpriseName(rs.getString("enterpriseName"));
            enterprise.setAddress(rs.getString("address"));
            enterprise.setTelephone(rs.getString("telephone"));
            enterprise.setRole(rs.getString("role"));
            enterprise.setMemo(rs.getString("memo"));
            enterprise.setTier(rs.getInt("tier")); // 添加这行
            enterprises.add(enterprise);
            System.out.println("Found enterprise: " + enterprise.getEnterpriseID() + " - " + enterprise.getEnterpriseName());
        }
        
        System.out.println("Total enterprises found: " + enterprises.size());
        rs.close();
        stmt.close();
        conn.close();
        
    } catch (SQLException e) {
        System.err.println("SQLException in searchEnterprises:");
        e.printStackTrace();
    } catch (Exception e) {
        System.err.println("Exception in searchEnterprises:");
        e.printStackTrace();
    }
    
    return enterprises;
}

/**
 * Get the core enterprise information
 */
public Enterprise getCoreEnterprise() {
    Enterprise enterprise = null;
    
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement stmt = conn.prepareStatement("SELECT * FROM enterprise WHERE role = 'Core' LIMIT 1")) {
        
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            enterprise = new Enterprise();
            enterprise.setEnterpriseID(rs.getString("enterpriseID"));
            enterprise.setEnterpriseName(rs.getString("enterpriseName"));
            enterprise.setAddress(rs.getString("address"));
            enterprise.setTelephone(rs.getString("telephone"));
            enterprise.setRole(rs.getString("role"));
            enterprise.setMemo(rs.getString("memo"));
        }
        
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return enterprise;
}

/**
 * Get Tier 1 suppliers
 * @return List of Tier 1 supplier enterprises
 */
public List<Enterprise> getTier1Suppliers() {
    List<Enterprise> suppliers = new ArrayList<>();
    
    try (Connection conn = DBUtil.getConnection()) {
        String sql = "SELECT * FROM enterprise WHERE role = 'Supplier' AND tier = '1'";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        
        while (rs.next()) {
            Enterprise enterprise = new Enterprise();
            enterprise.setEnterpriseID(rs.getString("enterpriseID"));
            enterprise.setEnterpriseName(rs.getString("enterpriseName"));
            enterprise.setAddress(rs.getString("address"));
            enterprise.setTelephone(rs.getString("telephone"));
            enterprise.setRole(rs.getString("role"));
            enterprise.setTier(rs.getInt("tier"));
            enterprise.setMemo(rs.getString("memo"));
            suppliers.add(enterprise);
        }
        
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return suppliers;
}

/**
 * Get Tier 1 distributors
 * @return List of Tier 1 distributor enterprises
 */
public List<Enterprise> getTier1Distributors() {
    List<Enterprise> distributors = new ArrayList<>();
    
    try (Connection conn = DBUtil.getConnection()) {
        String sql = "SELECT * FROM enterprise WHERE role = 'Distributor' AND tier = '1'";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        
        while (rs.next()) {
            Enterprise enterprise = new Enterprise();
            enterprise.setEnterpriseID(rs.getString("enterpriseID"));
            enterprise.setEnterpriseName(rs.getString("enterpriseName"));
            enterprise.setAddress(rs.getString("address"));
            enterprise.setTelephone(rs.getString("telephone"));
            enterprise.setRole(rs.getString("role"));
            enterprise.setTier(rs.getInt("tier"));
            enterprise.setMemo(rs.getString("memo"));
            distributors.add(enterprise);
        }
        
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return distributors;
}

}