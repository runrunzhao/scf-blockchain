package com.supplychainfinance.dao;

import com.supplychainfinance.model.Invoice;
import com.supplychainfinance.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class InvoiceDAO {

    /**
     * 生成新的发票ID
     * 
     * @return String - 新的发票ID
     */
    public String generateInvoiceID() {
        return "I" + String.format("%07d", Math.abs(System.currentTimeMillis() % 10000000));
    }

    /**
     * 创建新的发票记录
     * 
     * @param invoice 要保存的发票对象
     * @return boolean - 成功/失败
     */
    public boolean createInvoice(Invoice invoice) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        String sql = "INSERT INTO invoice (invoiceID, contractID, amount, PayDate, status, memo, paymentMethod, payPeriod) "
                +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                System.err.println("Failed to get database connection.");
                return false;
            }

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, invoice.getInvoiceID());
            pstmt.setString(2, invoice.getContractID());
            pstmt.setDouble(3, invoice.getAmount());

            if (invoice.getPayDate() != null) {
                pstmt.setDate(4, new java.sql.Date(invoice.getPayDate().getTime()));
            } else {
                pstmt.setNull(4, java.sql.Types.DATE);
            }

            pstmt.setString(5, invoice.getStatus());
            pstmt.setString(6, invoice.getMemo());
            pstmt.setString(7, invoice.getPaymentMethod());
            pstmt.setInt(8, invoice.getPayPeriod());

            int rowsAffected = pstmt.executeUpdate();
            success = (rowsAffected > 0);

            if (success) {
                System.out.println("Successfully created invoice: " + invoice.getInvoiceID());
            } else {
                System.err.println("Failed to create invoice: " + invoice.getInvoiceID());
            }
        } catch (SQLException e) {
            System.err.println("SQL error creating invoice: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, pstmt, conn);
        }
        return success;
    }

    /**
     * 批量创建多个发票
     * 
     * @param invoices 要保存的发票对象列表
     * @return boolean - 如果所有发票都成功创建则返回true，否则返回false
     */
    public boolean createInvoicesBatch(List<Invoice> invoices) {
        if (invoices == null || invoices.isEmpty()) {
            System.out.println("Invoice batch is empty, nothing to create.");
            return true; // 视为成功，因为没有要处理的内容
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        String sql = "INSERT INTO invoice (invoiceID, contractID, amount, PayDate, status, memo, payPeriod, paymentMethod) "
                +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                System.err.println("Failed to get database connection.");
                return false;
            }

            conn.setAutoCommit(false); // 开始事务
            pstmt = conn.prepareStatement(sql);

            for (Invoice invoice : invoices) {
                if (invoice == null || invoice.getInvoiceID() == null || invoice.getContractID() == null) {
                    System.err.println("Skipping invalid invoice object in batch");
                    continue;
                }

                pstmt.setString(1, invoice.getInvoiceID());
                pstmt.setString(2, invoice.getContractID());
                pstmt.setDouble(3, invoice.getAmount());

                if (invoice.getPayDate() != null) {
                    pstmt.setDate(4, new java.sql.Date(invoice.getPayDate().getTime()));
                } else {
                    pstmt.setNull(4, java.sql.Types.DATE);
                }

                pstmt.setString(5, invoice.getStatus());
                pstmt.setString(6, invoice.getMemo());
                pstmt.setInt(7, invoice.getPayPeriod());
                pstmt.setString(8, invoice.getPaymentMethod());
                pstmt.addBatch();
            }

            int[] rowsAffected = pstmt.executeBatch();

            success = true;
            for (int result : rowsAffected) {
                if (result == Statement.EXECUTE_FAILED) {
                    System.err.println("Batch insert failed for at least one invoice record.");
                    success = false;
                    break;
                }
            }

            if (success) {
                conn.commit();
                System.out.println("Successfully created " + rowsAffected.length + " invoices in batch.");
            } else {
                conn.rollback();
                System.err.println("Batch invoice creation failed, transaction rolled back.");
            }
        } catch (SQLException e) {
            System.err.println("SQL error in batch invoice creation: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                    System.err.println("Transaction rolled back due to error.");
                } catch (SQLException ex) {
                    System.err.println("Error during rollback: " + ex.getMessage());
                }
            }
            return false;
        } finally {
            // 恢复自动提交
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException e) {
                    System.err.println("Error resetting autoCommit: " + e.getMessage());
                }
            }
            closeResources(null, pstmt, conn);
        }
        return success;
    }

    /**
     * 更新现有发票记录
     * 
     * @param invoice 包含更新数据的发票对象（必须包含invoiceID）
     * @return boolean - 成功/失败
     */
    public boolean updateInvoice(Invoice invoice) {
        if (invoice == null || invoice.getInvoiceID() == null || invoice.getInvoiceID().isEmpty()) {
            System.err.println("Cannot update invoice: Invoice object or ID is null/empty.");
            return false;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        String sql = "UPDATE invoice SET contractID = ?, amount = ?, PayDate = ?, status = ?, memo = ?, payPeriod = ?, paymentMethod = ? "
                +
                "WHERE invoiceID = ?";

        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                System.err.println("Failed to get database connection.");
                return false;
            }

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, invoice.getContractID());
            pstmt.setDouble(2, invoice.getAmount());

            if (invoice.getPayDate() != null) {
                pstmt.setDate(3, new java.sql.Date(invoice.getPayDate().getTime()));
            } else {
                pstmt.setNull(3, java.sql.Types.DATE);
            }

            pstmt.setString(4, invoice.getStatus());
            pstmt.setString(5, invoice.getMemo());
            pstmt.setInt(6, invoice.getPayPeriod());
            pstmt.setString(7, invoice.getPaymentMethod());
            pstmt.setString(8, invoice.getInvoiceID());

            int rowsAffected = pstmt.executeUpdate();
            success = (rowsAffected > 0);

            if (success) {
                System.out.println("Successfully updated invoice: " + invoice.getInvoiceID());
            } else {
                System.err.println(
                        "Update invoice failed, no rows affected. Invoice ID may not exist: " + invoice.getInvoiceID());
            }
        } catch (SQLException e) {
            System.err.println("SQL error updating invoice: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, pstmt, conn);
        }
        return success;
    }

    /**
     * 根据ID删除发票记录
     * 
     * @param invoiceId 要删除的发票ID
     * @return boolean - 成功/失败
     */
    public boolean deleteInvoice(String invoiceId) {
        if (invoiceId == null || invoiceId.isEmpty()) {
            System.err.println("Cannot delete invoice: Invoice ID is null or empty.");
            return false;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        String sql = "DELETE FROM invoice WHERE invoiceID = ?";

        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                System.err.println("Failed to get database connection.");
                return false;
            }

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, invoiceId);

            int rowsAffected = pstmt.executeUpdate();
            success = (rowsAffected > 0);

            if (success) {
                System.out.println("Successfully deleted invoice: " + invoiceId);
            } else {
                System.err.println("Delete invoice failed, no rows affected. Invoice ID may not exist: " + invoiceId);
            }
        } catch (SQLException e) {
            System.err.println("SQL error deleting invoice: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, pstmt, conn);
        }
        return success;
    }

    public List<Invoice> getInvoicesByContractID(String contractID) {
        List<Invoice> invoices = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT invoiceID, contractID, amount, PayDate, status, memo, payPeriod, paymentMethod " +
                "FROM invoice WHERE contractID = ? ORDER BY payPeriod, PayDate";

        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                System.err.println("Failed to get database connection.");
                return invoices;
            }

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, contractID);
            rs = pstmt.executeQuery();

            System.out.println("Retrieving invoices for contract: " + contractID);
            int count = 0;

            while (rs.next()) {
                count++;
                Invoice invoice = new Invoice();
                invoice.setInvoiceID(rs.getString("invoiceID"));
                invoice.setContractID(rs.getString("contractID"));
                invoice.setAmount(rs.getDouble("amount"));
                invoice.setPayDate(rs.getDate("PayDate"));
                invoice.setStatus(rs.getString("status"));
                invoice.setMemo(rs.getString("memo"));
                

                // Explicitly check and log the payPeriod value from database
                int payPeriod = rs.getInt("payPeriod");
                System.out.println("Invoice " + rs.getString("invoiceID") + " has raw payPeriod: " + payPeriod +
                        " (isNull: " + rs.wasNull() + ")");

                // Set payPeriod - handle NULL case properly
                if (!rs.wasNull()) {
                    invoice.setPayPeriod(payPeriod);
                } else {
                    invoice.setPayPeriod(0); // Default value for NULL
                }

                invoice.setPaymentMethod(rs.getString("paymentMethod"));
                invoices.add(invoice);

                System.out.println("Loaded invoice: ID=" + invoice.getInvoiceID() +
                        ", Period=" + invoice.getPayPeriod() + ", ContractID=" + invoice.getContractID());
            }

            System.out.println("Found " + count + " invoices for contract ID: " + contractID);
        } catch (SQLException e) {
            System.err.println("SQL error getting invoices for contract: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return invoices;
    }

    

    /**
     * 根据ID获取单个发票
     * 
     * @param invoiceId 要查询的发票ID
     * @return Invoice对象，未找到则返回null
     */
    public Invoice getInvoiceById(String invoiceId) {
        Invoice invoice = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT invoiceID, contractID, amount, PayDate, status, memo, payPeriod, paymentMethod " +
                "FROM invoice WHERE invoiceID = ?";

        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                System.err.println("Failed to get database connection.");
                return null;
            }

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
                invoice.setPayPeriod(rs.getInt("payPeriod"));
                invoice.setPaymentMethod(rs.getString("paymentMethod"));
                System.out.println("Found invoice: " + invoiceId);
            } else {
                System.out.println("Invoice not found: " + invoiceId);
            }
        } catch (SQLException e) {
            System.err.println("SQL error getting invoice by ID: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return invoice;
    }

    /**
     * 更新发票状态
     * 
     * @param invoiceId 发票ID
     * @param newStatus 新状态
     * @return boolean - 成功/失败
     */
    public boolean updateInvoiceStatus(String invoiceId, String newStatus) {
        if (invoiceId == null || invoiceId.isEmpty() || newStatus == null || newStatus.isEmpty()) {
            System.err.println("Cannot update invoice status: Invalid parameters.");
            return false;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        String sql = "UPDATE invoice SET status = ? WHERE invoiceID = ?";

        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                System.err.println("Failed to get database connection.");
                return false;
            }

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newStatus);
            pstmt.setString(2, invoiceId);

            int rowsAffected = pstmt.executeUpdate();
            success = (rowsAffected > 0);

            if (success) {
                System.out.println("Successfully updated status to '" + newStatus + "' for invoice: " + invoiceId);
            } else {
                System.err.println("Update status failed, no rows affected. Invoice ID may not exist: " + invoiceId);
            }
        } catch (SQLException e) {
            System.err.println("SQL error updating invoice status: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, pstmt, conn);
        }
        return success;
    }

    /**
     * 根据多个条件搜索发票
     * 
     * @param invoiceId      发票ID（可选）
     * @param contractId     合同ID（可选）
     * @param enterpriseName 企业名称（可选）
     * @param status         状态（可选）
     * @return 符合条件的发票列表
     */
    public List<Invoice> searchInvoices(String invoiceId, String contractId, String enterpriseName, String status) {
        List<Invoice> invoices = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append(
                "SELECT i.invoiceID, i.contractID, i.amount, i.PayDate, i.status, i.memo, i.payPeriod, i.paymentMethod ");
        sqlBuilder.append("FROM invoice i ");

        if (enterpriseName != null && !enterpriseName.trim().isEmpty()) {
            sqlBuilder.append("JOIN contract c ON i.contractID = c.contractID ");
            sqlBuilder.append("JOIN enterprise e1 ON c.part1 = e1.enterpriseID ");
            sqlBuilder.append("JOIN enterprise e2 ON c.part2 = e2.enterpriseID ");

        }

        sqlBuilder.append("WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        if (invoiceId != null && !invoiceId.trim().isEmpty()) {
            sqlBuilder.append("AND i.invoiceID = ? ");
            params.add(invoiceId);
        }

        if (contractId != null && !contractId.trim().isEmpty()) {
            sqlBuilder.append("AND i.contractID = ? ");
            params.add(contractId);
        }

        if (status != null && !status.trim().isEmpty()) {
            sqlBuilder.append("AND i.status = ? ");
            params.add(status);
        }

        if (enterpriseName != null && !enterpriseName.trim().isEmpty()) {
            sqlBuilder.append("AND (e1.enterpriseName LIKE ? OR e2.enterpriseName LIKE ?) ");
            params.add("%" + enterpriseName + "%");
            params.add("%" + enterpriseName + "%");
        }

        // 排序
        sqlBuilder.append("ORDER BY i.PayDate, i.payPeriod");

        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                System.err.println("Failed to get database connection.");
                return invoices;
            }

            String sql = sqlBuilder.toString();
            System.out.println("执行SQL查询: " + sql);
            pstmt = conn.prepareStatement(sql);

            // 设置参数
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Invoice invoice = new Invoice();
                invoice.setInvoiceID(rs.getString("invoiceID"));
                invoice.setContractID(rs.getString("contractID"));
                invoice.setAmount(rs.getDouble("amount"));
                invoice.setPayDate(rs.getDate("PayDate"));
                invoice.setStatus(rs.getString("status"));
                invoice.setMemo(rs.getString("memo"));
                invoice.setPayPeriod(rs.getInt("payPeriod"));
                invoice.setPaymentMethod(rs.getString("paymentMethod"));
                invoices.add(invoice);
            }

            System.out.println("搜索到 " + invoices.size() + " 条发票记录");
        } catch (SQLException e) {
            System.err.println("SQL错误：搜索发票失败: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }

        return invoices;
    }

    /**
     * 关闭资源的辅助方法
     */
    private void closeResources(ResultSet rs, Statement stmt, Connection conn) {
        try {
            if (rs != null)
                rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (stmt != null)
                stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (conn != null)
                conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}