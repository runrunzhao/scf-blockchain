package com.supplychainfinance.dao;

import com.supplychainfinance.model.Contract;
import com.supplychainfinance.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ContractDAO {
    
    /**
     * Search contracts based on criteria
     * 
     * @param contractId Contract ID (optional)
     * @param enterpriseName Enterprise name (optional)
     * @param contractStatus Contract status (optional)
     * @param contractType Contract type (optional)
     * @return List of matching contracts
     */
    public List<Contract> searchContracts(String contractId, String enterpriseName, 
                                          String contractStatus, String contractType) {
        List<Contract> contracts = new ArrayList<>();
        StringBuilder sqlBuilder = new StringBuilder("SELECT c.*, e1.enterpriseName as fromEnterpriseName, " +
                                                   "e2.enterpriseName as toEnterpriseName FROM contract c " +
                                                   "LEFT JOIN enterprise e1 ON c.part1 = e1.enterpriseID " +
                                                   "LEFT JOIN enterprise e2 ON c.part2 = e2.enterpriseID WHERE 1=1");
        
        List<Object> params = new ArrayList<>();
        
        // Add filters if provided
        if (contractId != null && !contractId.trim().isEmpty()) {
            sqlBuilder.append(" AND c.contractID LIKE ?");
            params.add("%" + contractId + "%");
        }
        
        if (enterpriseName != null && !enterpriseName.trim().isEmpty()) {
            sqlBuilder.append(" AND (e1.enterpriseName LIKE ? OR e2.enterpriseName LIKE ?)");
            params.add("%" + enterpriseName + "%");
            params.add("%" + enterpriseName + "%");
        }
        
        if (contractStatus != null && !contractStatus.trim().isEmpty()) {
            sqlBuilder.append(" AND c.status = ?");
            params.add(contractStatus);
        }
        
        // Note: contractType is not in your schema, so we'll skip that filter
        
        System.out.println("ContractDAO - SQL Query: " + sqlBuilder.toString());
        System.out.println("ContractDAO - Parameters: " + params);
        
        try (Connection conn = DBUtil.getConnection()) {
            if (conn == null) {
                System.err.println("ERROR: Database connection is null!");
                return contracts;
            }
            
            PreparedStatement stmt = conn.prepareStatement(sqlBuilder.toString());
            
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Contract contract = new Contract();
                contract.setContractId(rs.getString("contractID")); // Updated field name
                contract.setContractName(rs.getString("realNo"));
                contract.setFromEnterpriseId(rs.getString("part1"));
                contract.setFromEnterpriseName(rs.getString("fromEnterpriseName"));
                contract.setToEnterpriseId(rs.getString("part2"));
                contract.setToEnterpriseName(rs.getString("toEnterpriseName"));
                contract.setStatus(rs.getString("status"));
                contract.setAmount(rs.getDouble("amount"));
                
                // Update date fields according to your schema
                java.sql.Date signingDate = rs.getDate("signingDate");
                java.sql.Date effectiveDate = rs.getDate("effectiveDate");
                java.sql.Date invalidDate = rs.getDate("invalidDate");
                
                if (signingDate != null) contract.setSignDate(signingDate.toString());
                if (effectiveDate != null) contract.setEffectiveDate(effectiveDate.toString());
                if (invalidDate != null) contract.setExpiryDate(invalidDate.toString());
                
                contracts.add(contract);
            }
            
            System.out.println("ContractDAO - Found " + contracts.size() + " contracts");
            
        } catch (SQLException e) {
            System.err.println("ERROR in ContractDAO.searchContracts: " + e.getMessage());
            e.printStackTrace();
        }
        
        return contracts;
    }
    
    /**
     * Get contract by ID
     */
    public Contract getContract(String contractId) {
        if (contractId == null || contractId.trim().isEmpty()) {
            return null;
        }
        
        Contract contract = null;
        String sql = "SELECT c.*, e1.enterpriseName as fromEnterpriseName, " +
                    "e2.enterpriseName as toEnterpriseName FROM contract c " +
                    "LEFT JOIN enterprise e1 ON c.part1 = e1.enterpriseID " + // Updated join condition
                    "LEFT JOIN enterprise e2 ON c.part2 = e2.enterpriseID " + // Updated join condition
                    "WHERE c.contractID = ?"; // Updated field name
        
        try (Connection conn = DBUtil.getConnection()) {
            if (conn == null) {
                System.err.println("ERROR: Database connection is null!");
                return null;
            }
            
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, contractId);
            System.out.println("ContractDAO.getContract - Searching for contract: " + contractId);
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                contract = new Contract();
                contract.setContractId(rs.getString("contractID")); // Updated field name
                contract.setContractName(rs.getString("realNo"));
                contract.setFromEnterpriseId(rs.getString("part1"));
                contract.setFromEnterpriseName(rs.getString("fromEnterpriseName"));
                contract.setToEnterpriseId(rs.getString("part2"));
                contract.setToEnterpriseName(rs.getString("toEnterpriseName"));
                contract.setStatus(rs.getString("status"));
                contract.setAmount(rs.getDouble("amount"));
                
                // Update date fields according to your schema
                java.sql.Date signingDate = rs.getDate("signingDate");
                java.sql.Date effectiveDate = rs.getDate("effectiveDate");
                java.sql.Date invalidDate = rs.getDate("invalidDate");
                
                if (signingDate != null) contract.setSignDate(signingDate.toString());
                if (effectiveDate != null) contract.setEffectiveDate(effectiveDate.toString());
                if (invalidDate != null) contract.setExpiryDate(invalidDate.toString());
                
                System.out.println("ContractDAO.getContract - Found contract: " + contract.getContractId());
            } else {
                System.out.println("ContractDAO.getContract - No contract found with ID: " + contractId);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in ContractDAO.getContract: " + e.getMessage());
            e.printStackTrace();
        }
        
        return contract;
    }
}