package com.supplychainfinance.dao;

import com.supplychainfinance.model.Invoice;
import com.supplychainfinance.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;

public class InvoiceDAO {
    
    /**
     * Generate a new invoice ID
     * @return String - new invoice ID
     */
    public String generateInvoiceID() {
        // 生成发票ID
        return "I" + String.format("%07d", Math.abs(System.currentTimeMillis() % 10000000));
    }
    
    /**
     * Create a new invoice record
     * @param invoice The invoice object to save
     * @return boolean - success/failure
     */
    public boolean createInvoice(Invoice invoice) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "INSERT INTO invoice (invoiceID, contractID, amount, PayDate, status, memo,paymentMethod) " +
                         "VALUES (?, ?, ?, ?, ?, ?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, invoice.getInvoiceID());
            pstmt.setString(2, invoice.getContractID());
            pstmt.setDouble(3, invoice.getAmount());
            pstmt.setDate(4, new java.sql.Date(invoice.getPayDate().getTime()));
            pstmt.setString(5, invoice.getStatus());
            pstmt.setString(6, invoice.getMemo());
            pstmt.setString(7, invoice.getPaymentMethod());
            int rowsAffected = pstmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
    
    /**
     * Create multiple invoices in batch
     * @param invoices List of invoice objects to save
     * @return boolean - success/failure
     */
    public boolean createInvoicesBatch(List<Invoice> invoices) {
        if (invoices == null || invoices.isEmpty()) {
            return false;
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);
            
            String sql = "INSERT INTO invoice (invoiceID, contractID, amount, PayDate, status, memo) " +
                         "VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            
            for (Invoice invoice : invoices) {
                pstmt.setString(1, invoice.getInvoiceID());
                pstmt.setString(2, invoice.getContractID());
                pstmt.setDouble(3, invoice.getAmount());
                pstmt.setDate(4, new java.sql.Date(invoice.getPayDate().getTime()));
                pstmt.setString(5, invoice.getStatus());
                pstmt.setString(6, invoice.getMemo());
                pstmt.addBatch();
                 System.out.println("Added to batch: Invoice " + invoice.getInvoiceID());
            }
            
            int[] rowsAffected = pstmt.executeBatch();
         System.out.println("Batch execution results: " + Arrays.toString(rowsAffected)); // 修复变量名

            conn.commit();
            
            // Check if all inserts were successful
            success = true;
            for (int rows : rowsAffected) {
                if (rows <= 0) {
                    success = false;
                    break;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            success = false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
    
    /**
     * Get invoices by contract ID
     * @param contractID The contract ID to search for
     * @return List of Invoice objects
     */
    public List<Invoice> getInvoicesByContractID(String contractID) {
        List<Invoice> invoices = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM invoice WHERE contractID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, contractID);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Invoice invoice = new Invoice();
                invoice.setInvoiceID(rs.getString("invoiceID"));
                invoice.setContractID(rs.getString("contractID"));
                invoice.setAmount(rs.getDouble("amount"));
                invoice.setPayDate(rs.getDate("PayDate"));
                invoice.setStatus(rs.getString("status"));
                invoice.setMemo(rs.getString("memo"));
                invoices.add(invoice);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return invoices;
    }

    /**
 * Search invoices based on criteria
 * @param invoiceId Invoice ID (optional)
 * @param contractId Contract ID (optional)
 * @param enterpriseName Enterprise name (optional)
 * @param status Invoice status (optional)
 * @return List of matching invoices
 */
public List<Invoice> searchInvoices(String invoiceId, String contractId, 
                                   String enterpriseName, String status) {
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    List<Invoice> invoices = new ArrayList<>();
    
    try {
        conn = DBUtil.getConnection();
        
        // 构建动态查询
        StringBuilder sql = new StringBuilder(
            "SELECT i.*, c.part1, c.part2 " +
            "FROM invoice i " +
            "LEFT JOIN contract c ON i.contractID = c.contractID " +
            "WHERE 1=1 ");
        
        List<Object> params = new ArrayList<>();
        
        // 添加过滤条件
        if (invoiceId != null && !invoiceId.trim().isEmpty()) {
            sql.append("AND i.invoiceID LIKE ? ");
            params.add("%" + invoiceId + "%");
        }
        
        if (contractId != null && !contractId.trim().isEmpty()) {
            sql.append("AND i.contractID LIKE ? ");
            params.add("%" + contractId + "%");
        }
        
        if (enterpriseName != null && !enterpriseName.trim().isEmpty()) {
            sql.append("AND (c.part1 LIKE ? OR c.part2 LIKE ?) ");
            params.add("%" + enterpriseName + "%");
            params.add("%" + enterpriseName + "%");
        }
        
        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND i.status = ? ");
            params.add(status);
        }
        
        sql.append("ORDER BY i.payDate DESC");
        
        System.out.println("Executing SQL: " + sql.toString());
        System.out.println("With parameters: " + params);
        
        pstmt = conn.prepareStatement(sql.toString());
        
        // 设置参数
        for (int i = 0; i < params.size(); i++) {
            pstmt.setObject(i + 1, params.get(i));
        }
        
        rs = pstmt.executeQuery();
        
        // 处理结果
        while (rs.next()) {
            Invoice invoice = new Invoice();
            invoice.setInvoiceID(rs.getString("invoiceID"));
            invoice.setContractID(rs.getString("contractID"));
            invoice.setAmount(rs.getDouble("amount"));
            invoice.setPayDate(rs.getDate("payDate"));
            invoice.setStatus(rs.getString("status"));
            invoice.setMemo(rs.getString("memo"));
            
              
            invoices.add(invoice);
        }
        
        System.out.println("Found " + invoices.size() + " invoices");
        
    } catch (SQLException e) {
        System.out.println("Error searching invoices: " + e.getMessage());
        e.printStackTrace();
    } finally {
        // 关闭资源
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    return invoices;
}

/**
 * Get an invoice by its ID
 * @param invoiceId The invoice ID to retrieve
 * @return Invoice object or null if not found
 */
public Invoice getInvoiceById(String invoiceId) {
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    Invoice invoice = null;
    
    try {
        conn = DBUtil.getConnection();
        String sql = "SELECT * FROM invoice WHERE invoiceID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, invoiceId);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            invoice = new Invoice();
            invoice.setInvoiceID(rs.getString("invoiceID"));
            invoice.setContractID(rs.getString("contractID"));
            invoice.setAmount(rs.getDouble("amount"));
            invoice.setPayDate(rs.getDate("PayDate"));
            invoice.setStatus(rs.getString("status"));
            invoice.setMemo(rs.getString("memo"));
            invoice.setPaymentMethod(rs.getString("paymentMethod"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    return invoice;
}

}