package com.supplychainfinance.dao;

import com.supplychainfinance.model.Contract;
import com.supplychainfinance.util.DBUtil;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class ContractDAO {
    
    // 搜索合同方法
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
                contract.setContractId(rs.getString("contractID"));
                contract.setContractName(rs.getString("realNo"));
                contract.setFromEnterpriseId(rs.getString("part1"));
                contract.setFromEnterpriseName(rs.getString("fromEnterpriseName"));
                contract.setToEnterpriseId(rs.getString("part2"));
                contract.setToEnterpriseName(rs.getString("toEnterpriseName"));
                contract.setStatus(rs.getString("status"));
                
                // 读取金额 - 使用双重类型转换避免问题
                double amount = rs.getDouble("amount");
                contract.setAmount(amount);
                
                // 获取日期信息
                java.sql.Date signingDate = rs.getDate("signingDate");
                java.sql.Date effectiveDate = rs.getDate("effectiveDate");
                java.sql.Date invalidDate = rs.getDate("invalidDate");
                
                // 转换为 java.util.Date
                if (signingDate != null) contract.setSignDate(new java.util.Date(signingDate.getTime()));
                if (effectiveDate != null) contract.setEffectiveDate(new java.util.Date(effectiveDate.getTime()));
                if (invalidDate != null) contract.setExpiryDate(new java.util.Date(invalidDate.getTime()));
                
                contracts.add(contract);
            }
            
            System.out.println("ContractDAO - Found " + contracts.size() + " contracts");
            
        } catch (SQLException e) {
            System.err.println("ERROR in ContractDAO.searchContracts: " + e.getMessage());
            e.printStackTrace();
        }
        
        return contracts;
    }
    
    // 根据ID获取合同
    public Contract getContract(String contractId) {
        Contract contract = null;
        String sql = "SELECT c.*, e1.enterpriseName as fromEnterpriseName, " +
                    "e2.enterpriseName as toEnterpriseName FROM contract c " +
                    "LEFT JOIN enterprise e1 ON c.part1 = e1.enterpriseID " +
                    "LEFT JOIN enterprise e2 ON c.part2 = e2.enterpriseID " +
                    "WHERE contractID = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, contractId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                contract = new Contract();
                contract.setContractId(rs.getString("contractID"));
                contract.setContractName(rs.getString("realNo"));
                contract.setFromEnterpriseId(rs.getString("part1"));
                contract.setFromEnterpriseName(rs.getString("fromEnterpriseName"));
                contract.setToEnterpriseId(rs.getString("part2"));
                contract.setToEnterpriseName(rs.getString("toEnterpriseName"));
                contract.setAmount(rs.getDouble("amount"));
                contract.setStatus(rs.getString("status"));
                
                // Get dates
                java.sql.Date signingDate = rs.getDate("signingDate");
                java.sql.Date effectiveDate = rs.getDate("effectiveDate");
                java.sql.Date invalidDate = rs.getDate("invalidDate");
                
                // Convert to java.util.Date
                if (signingDate != null) contract.setSignDate(new java.util.Date(signingDate.getTime()));
                if (effectiveDate != null) contract.setEffectiveDate(new java.util.Date(effectiveDate.getTime()));
                if (invalidDate != null) contract.setExpiryDate(new java.util.Date(invalidDate.getTime()));
                
                // TODO: Load additional fields if needed
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in ContractDAO.getContract: " + e.getMessage());
            e.printStackTrace();
        }
        
        return contract;
    }
    
    // 插入合同
    public void insertContract(Contract contract) throws SQLException {
        String sql = "INSERT INTO contract (contractID, realNo, part1, part2, amount, signingDate, effectiveDate, invalidDate, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            // 检查合同 ID，如果为空则生成一个新的
            if (contract.getContractId() == null || contract.getContractId().trim().isEmpty()) {
                contract.setContractId(generateContractId());
            }
            
            stmt.setString(1, contract.getContractId());
            stmt.setString(2, contract.getContractName()); // realNo 对应 contractName
            stmt.setString(3, contract.getFromEnterpriseId()); // part1
            stmt.setString(4, contract.getToEnterpriseId()); // part2
            
            // 金额设置
            stmt.setDouble(5, contract.getAmount());
            
            // 日期处理
            if (contract.getSignDate() != null) {
                stmt.setDate(6, new java.sql.Date(contract.getSignDate().getTime()));
            } else {
                stmt.setDate(6, new java.sql.Date(System.currentTimeMillis()));
            }
            
            if (contract.getEffectiveDate() != null) {
                stmt.setDate(7, new java.sql.Date(contract.getEffectiveDate().getTime()));
            } else {
                stmt.setDate(7, new java.sql.Date(System.currentTimeMillis()));
            }
            
            if (contract.getExpiryDate() != null) {
                stmt.setDate(8, new java.sql.Date(contract.getExpiryDate().getTime()));
            } else {
                // 默认到期日为一年后
                Calendar calendar = Calendar.getInstance();
                calendar.add(Calendar.YEAR, 1);
                stmt.setDate(8, new java.sql.Date(calendar.getTimeInMillis()));
            }
            
            stmt.setString(9, contract.getStatus() != null ? contract.getStatus() : "Active");
            
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Failed to insert contract, no rows affected.");
            }
        }
    }
    
    // 更新合同
    public void updateContract(Contract contract) throws SQLException {
        String sql = "UPDATE contract SET realNo = ?, part1 = ?, part2 = ?, " +
                    "amount = ?, signingDate = ?, effectiveDate = ?, " +
                    "invalidDate = ?, status = ? " +
                    "WHERE contractID = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, contract.getContractName()); // realNo 对应 contractName
            stmt.setString(2, contract.getFromEnterpriseId()); // part1
            stmt.setString(3, contract.getToEnterpriseId()); // part2
            
            // 金额设置
            stmt.setDouble(4, contract.getAmount());
            
            // 日期处理
            if (contract.getSignDate() != null) {
                stmt.setDate(5, new java.sql.Date(contract.getSignDate().getTime()));
            } else {
                stmt.setDate(5, new java.sql.Date(System.currentTimeMillis()));
            }
            
            if (contract.getEffectiveDate() != null) {
                stmt.setDate(6, new java.sql.Date(contract.getEffectiveDate().getTime()));
            } else {
                stmt.setDate(6, new java.sql.Date(System.currentTimeMillis()));
            }
            
            if (contract.getExpiryDate() != null) {
                stmt.setDate(7, new java.sql.Date(contract.getExpiryDate().getTime()));
            } else {
                // 默认到期日为一年后
                Calendar calendar = Calendar.getInstance();
                calendar.add(Calendar.YEAR, 1);
                stmt.setDate(7, new java.sql.Date(calendar.getTimeInMillis()));
            }
            
            stmt.setString(8, contract.getStatus());
            stmt.setString(9, contract.getContractId());
            
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Failed to update contract, no rows affected. Contract ID may not exist: " + contract.getContractId());
            }
        }
    }
    
    // 生成合同ID
    private String generateContractId() {
        return "C" + String.format("%07d", Math.abs(System.currentTimeMillis() % 10000000));
    }
}