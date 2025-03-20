package com.supplychainfinance.servlet;

import com.google.gson.Gson;
import com.supplychainfinance.dao.DBConnectionManager;
import com.supplychainfinance.model.Enterprise;
import com.supplychainfinance.model.Contract;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


/**
 * Servlet that handles requests for related entities data based on the tier and role
 * in the enterprise table structure.
 */
public class EnterpriseRelationController extends HttpServlet {
    private static final long serialVersionUID = 1L;

 /*   // 在类中添加此方法
private void testEnterpriseTable(PrintWriter out) {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    ResultSet columns = null;
    
    try {
        conn = DBConnectionManager.getConnection();
        
        // 查询表结构
        columns = conn.getMetaData().getColumns(null, null, "enterprise", null);
        out.println("=== enterprise TABLE COLUMNS ===");
        while (columns.next()) {
            out.println(columns.getString("COLUMN_NAME") + " (" + columns.getString("TYPE_NAME") + ")");
        }
        out.println("=============================");
        
        // 查询表内容示例
        stmt = conn.prepareStatement("SELECT * FROM enterprise LIMIT 1");
        rs = stmt.executeQuery();
        
        out.println("=== SAMPLE ROW ===");
        if (rs.next()) {
            ResultSetMetaData meta = rs.getMetaData();
            for (int i = 1; i <= meta.getColumnCount(); i++) {
                String colName = meta.getColumnName(i);
                out.println(colName + ": " + rs.getString(colName));
            }
        } else {
            out.println("No data found in enterprise table");
        }
        out.println("=================");
        
    } catch (SQLException e) {
        out.println("ERROR: " + e.getMessage());
        e.printStackTrace(new PrintWriter(out));
    } finally {
        closeResources(conn, stmt, rs);
        try {
            if (columns != null) columns.close();
        } catch (SQLException e) {
            e.printStackTrace(new PrintWriter(out));
        }
    }
}

*/

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    PrintWriter out = response.getWriter();
    
    // Get request parameters
    String type = request.getParameter("type");
    String id = request.getParameter("id");
    
    System.out.println("EnterpriseRelationController: processing request for type=" + type + ", id=" + id);
    
    try {
        // Default pagination parameters
        int limit = 10;
        int offset = 0;
        
        // Get pagination parameters if provided
        String limitParam = request.getParameter("limit");
        String offsetParam = request.getParameter("offset");
        
        if (limitParam != null && !limitParam.isEmpty()) {
            try {
                limit = Integer.parseInt(limitParam);
            } catch (NumberFormatException e) {
                // Use default
            }
        }
        
        if (offsetParam != null && !offsetParam.isEmpty()) {
            try {
                offset = Integer.parseInt(offsetParam);
            } catch (NumberFormatException e) {
                // Use default
            }
        }
        
        List<?> data = null;
        
        // Based on the type parameter, fetch the appropriate related entities
        switch (type) {
            case "suppliers":
                data = getRelatedSuppliers(id, limit, offset);
                break;
                
            case "distributors":
                data = getRelatedDistributors(id, limit, offset);
                break;
                
            case "contracts":
                data = getRelatedContracts(id, limit, offset);
                break;
                
            default:
                out.write("{\"error\": \"Invalid entity type. Supported types: suppliers, distributors, contracts\", \"success\": false}");
                return;
        }
        
        // Make sure we have data, even if it's an empty list
        if (data == null) {
            data = new ArrayList<>();
        }
        
        // Convert to JSON and send response
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(data);
        //System.out.println("Sending JSON response: " + jsonResponse);
        out.write(jsonResponse);
        
    } catch (Exception e) {
        System.err.println("Error in EnterpriseRelationController: " + e.getMessage());
        e.printStackTrace();
        out.write("{\"error\":\"" + e.getMessage() + "\", \"success\": false}");
    }
}

    
    /**
     * Gets the tier value for the specified enterprise
     * 
     * @param enterpriseId The enterprise ID
     * @return The tier value or -1 if not found
     */
    private int getEnterpriseTier(String enterpriseId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int tier = -1;
        
        try {
            conn = DBConnectionManager.getConnection();
            String sql = "SELECT tier FROM enterprise WHERE enterpriseID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, enterpriseId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                tier = rs.getInt("tier");
            }
        } catch (SQLException e) {
            System.err.println("Error getting enterprise tier: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return tier;
    }
    
    private List<Enterprise> getRelatedSuppliers(String enterpriseId, int limit, int offset) {
    List<Enterprise> suppliers = new ArrayList<>();
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    try {
        conn = DBConnectionManager.getConnection();
        
        // 获取当前企业的tier值
        int currentTier = getEnterpriseTier(enterpriseId);
              
        String sql = "SELECT * FROM enterprise WHERE role = 'Supplier' AND tier = ? LIMIT ? OFFSET ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, currentTier + 1);
        stmt.setInt(2, limit);
        stmt.setInt(3, offset);
        
        rs = stmt.executeQuery();
        
        while (rs.next()) {
            Enterprise supplier = new Enterprise();
            supplier.setEnterpriseID(rs.getString("enterpriseID"));
            supplier.setEnterpriseName(rs.getString("enterpriseName"));
            supplier.setRole("Supplier");
            supplier.setTelephone(rs.getString("telephone"));
            supplier.setAddress(rs.getString("address"));
            supplier.setTier(rs.getInt("tier"));  // 一定要设置tier值
            
            suppliers.add(supplier);
        }
    } catch (SQLException e) {
        System.err.println("Error fetching suppliers: " + e.getMessage());
        e.printStackTrace();
    } finally {
        closeResources(conn, stmt, rs);
    }
    
    return suppliers;
}

private List<Enterprise> getRelatedDistributors(String enterpriseId, int limit, int offset) {
    List<Enterprise> distributors = new ArrayList<>();
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    try {
        conn = DBConnectionManager.getConnection();
        
        // 获取当前企业的tier值
        int currentTier = getEnterpriseTier(enterpriseId);
        System.out.println("Current enterprise tier: " + currentTier);
        
        // 修改SQL查询，只获取tier值=currentTier+1的分销商
        String sql = "SELECT * FROM enterprise WHERE role = 'Distributor' AND tier = ? LIMIT ? OFFSET ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, currentTier + 1);
        stmt.setInt(2, limit);
        stmt.setInt(3, offset);
        
        rs = stmt.executeQuery();
        
        while (rs.next()) {
            Enterprise distributor = new Enterprise();
            distributor.setEnterpriseID(rs.getString("enterpriseID"));
            distributor.setEnterpriseName(rs.getString("enterpriseName"));
            distributor.setRole("Distributor");
            distributor.setTelephone(rs.getString("telephone"));
            distributor.setAddress(rs.getString("address"));
            distributor.setTier(rs.getInt("tier"));  // 一定要设置tier值
            
            distributors.add(distributor);
        }
    } catch (SQLException e) {
        System.err.println("Error fetching distributors: " + e.getMessage());
        e.printStackTrace();
    } finally {
        closeResources(conn, stmt, rs);
    }
    
    return distributors;
}
    
    /**
     * 获取与指定企业关联的合同
     * 
     * @param enterpriseId 企业ID
     * @param limit 最大返回记录数
     * @param offset 跳过的记录数
     * @return 合同列表
     */
    private List<Contract> getRelatedContracts(String enterpriseId, int limit, int offset) {
        List<Contract> contracts = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnectionManager.getConnection();
            
            // 获取与此企业关联的合同（作为甲方或乙方）
            String sql = "SELECT * FROM contract " +
                         "WHERE part1 = ? OR part2 = ? " +
                         "ORDER BY  signingDate DESC " +
                         "LIMIT ? OFFSET ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, enterpriseId);
            stmt.setString(2, enterpriseId);
            stmt.setInt(3, limit);
            stmt.setInt(4, offset);
            
            System.out.println("Executing contracts query for enterprise " + enterpriseId + 
                               ", limit=" + limit + ", offset=" + offset);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Contract contract = new Contract();
                contract.setContractID(rs.getString("contractID"));
                contract.setContractNumber(rs.getString("realNO"));
                
                // 安全地获取可能不存在的字段
                try { contract.setContractAmount(rs.getBigDecimal("amount")); } 
                catch (SQLException e) { /* Ignore */ }
                
                try { contract.setContractDate(rs.getDate("signingDate")); } 
                catch (SQLException e) { /* Ignore */ }
                
                try { contract.setStartDate(rs.getDate("EffectiveDate")); } 
                catch (SQLException e) { /* Ignore */ }
                
                try { contract.setEndDate(rs.getDate("invalidDate")); } 
                catch (SQLException e) { /* Ignore */ }
                
                try { contract.setStatus(rs.getString("status")); } 
                catch (SQLException e) { contract.setStatus("Active"); }
                
                try { contract.setPartyAID(rs.getString("part1")); } 
                catch (SQLException e) { /* Ignore */ }
                
                try { contract.setPartyBID(rs.getString("part2")); } 
                catch (SQLException e) { /* Ignore */ }
                
                contracts.add(contract);
            }
            
            System.out.println("Found " + contracts.size() + " contracts for enterprise " + enterpriseId);
            
        } catch (SQLException e) {
            System.err.println("Error fetching contracts: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return contracts;
    }
    
    /**
     * 关闭数据库资源以防止泄漏
     */
    private void closeResources(Connection conn, PreparedStatement stmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            System.err.println("Error closing database resources: " + e.getMessage());
            e.printStackTrace();
        }
    }
}