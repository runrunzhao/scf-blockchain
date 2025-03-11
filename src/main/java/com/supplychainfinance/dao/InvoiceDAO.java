package com.supplychainfinance.dao;

import com.supplychainfinance.model.Invoice;
import com.supplychainfinance.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
            String sql = "INSERT INTO invoice (invoiceID, contractID, amount, PayDate, status, memo) " +
                         "VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, invoice.getInvoiceID());
            pstmt.setString(2, invoice.getContractID());
            pstmt.setDouble(3, invoice.getAmount());
            pstmt.setDate(4, new java.sql.Date(invoice.getPayDate().getTime()));
            pstmt.setString(5, invoice.getStatus());
            pstmt.setString(6, invoice.getMemo());
            
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
            }
            
            int[] rowsAffected = pstmt.executeBatch();
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
}