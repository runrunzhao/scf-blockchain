package com.supplychainfinance.servlet;

import com.supplychainfinance.dao.ContractDAO;
import com.supplychainfinance.dao.InvoiceDAO;
import com.supplychainfinance.model.Contract;
import com.supplychainfinance.model.Invoice;
import com.supplychainfinance.model.PaymentPeriod;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SaveContractServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        // Read JSON data from request
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
        Map<String, Object> result = new HashMap<>();
        
        try {
            // Parse request JSON into Contract object
            Type contractType = new TypeToken<Map<String, Object>>() {}.getType();
            Map<String, Object> contractData = gson.fromJson(sb.toString(), contractType);
            
            // Create Contract object
            Contract contract = new Contract();
            
            // Check if this is an update or new contract
            boolean isUpdate = contractData.get("contractId") != null && !contractData.get("contractId").toString().isEmpty();
            
            if (isUpdate) {
                contract.setContractId(contractData.get("contractId").toString());
            } else {
                // Generate new contract ID
                ContractDAO contractDAO = new ContractDAO();
                String newContractID = contractDAO.generateContractId();
                contract.setContractId(newContractID);
            }
            
            contract.setContractName(contractData.get("contractName").toString());
            contract.setContractType(contractData.get("contractType").toString());
            contract.setStatus(contractData.get("status").toString());
            contract.setFromEnterpriseId(contractData.get("fromEnterpriseId").toString());
            contract.setToEnterpriseId(contractData.get("toEnterpriseId").toString());
            contract.setAmount(Double.parseDouble(contractData.get("amount").toString()));
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            if (contractData.get("signDate") != null && !contractData.get("signDate").toString().isEmpty()) {
                contract.setSignDate(dateFormat.parse(contractData.get("signDate").toString()));
            }
            
            if (contractData.get("effectiveDate") != null && !contractData.get("effectiveDate").toString().isEmpty()) {
                contract.setEffectiveDate(dateFormat.parse(contractData.get("effectiveDate").toString()));
            }
            
            if (contractData.get("expiryDate") != null && !contractData.get("expiryDate").toString().isEmpty()) {
                contract.setExpiryDate(dateFormat.parse(contractData.get("expiryDate").toString()));
            }
            
            contract.setDescription(contractData.get("description") != null ? contractData.get("description").toString() : "");
            contract.setRemarks(contractData.get("remarks") != null ? contractData.get("remarks").toString() : "");
            
            // Parse payment periods
            List<PaymentPeriod> paymentPeriods = new ArrayList<>();
            if (contractData.get("paymentPeriods") != null) {
                Type periodListType = new TypeToken<ArrayList<Map<String, Object>>>() {}.getType();
                List<Map<String, Object>> periodData = gson.fromJson(
                        gson.toJson(contractData.get("paymentPeriods")), periodListType);
                
                for (Map<String, Object> period : periodData) {
                    PaymentPeriod paymentPeriod = new PaymentPeriod();
                    paymentPeriod.setPeriod(Integer.parseInt(period.get("period").toString()));
                    
                    if (period.get("date") != null && !period.get("date").toString().isEmpty()) {
                        paymentPeriod.setDate(dateFormat.parse(period.get("date").toString()));
                    }
                    
                    if (period.get("amount") != null && !period.get("amount").toString().isEmpty()) {
                        paymentPeriod.setAmount(Double.parseDouble(period.get("amount").toString()));
                    }
                    
                    paymentPeriod.setTerms(period.get("terms") != null ? period.get("terms").toString() : "");
                    paymentPeriods.add(paymentPeriod);
                }
            }
            contract.setPaymentPeriods(paymentPeriods);
            
            // Save contract data
            ContractDAO contractDAO = new ContractDAO();
            boolean success = false;
            
            try {
                if (isUpdate) {
                    contractDAO.updateContract(contract);
                    success = true;
                } else {
                    contractDAO.insertContract(contract);
                    success = true;
                }
            } catch (SQLException e) {
                e.printStackTrace();
                success = false;
            }
            
            if (success) {
                // Generate invoices from payment periods
                boolean invoicesGenerated = generateInvoicesFromPaymentPeriods(contract.getContractId(), paymentPeriods);
                
                result.put("success", true);
                result.put("contractId", contract.getContractId());
                result.put("message", isUpdate ? "Contract updated successfully" : "Contract created successfully");
                if (invoicesGenerated) {
                    result.put("invoicesGenerated", true);
                }
            } else {
                result.put("success", false);
                result.put("error", "Failed to save contract data");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("error", "Error processing contract data: " + e.getMessage());
        }
        
        out.println(gson.toJson(result));
    }
    
    /**
     * Generate invoice records from payment periods
     * @param contractId The contract ID
     * @param paymentPeriods List of payment periods
     * @return boolean - success/failure
     */
    private boolean generateInvoicesFromPaymentPeriods(String contractId, List<PaymentPeriod> paymentPeriods) {
        if (paymentPeriods == null || paymentPeriods.isEmpty()) {
            return false;
        }
        
        try {
            InvoiceDAO invoiceDAO = new InvoiceDAO();
            List<Invoice> invoices = new ArrayList<>();
            
            // Get existing invoices for this contract
            List<Invoice> existingInvoices = invoiceDAO.getInvoicesByContractID(contractId);
            
            // If there are existing invoices, we won't create new ones
            if (existingInvoices != null && !existingInvoices.isEmpty()) {
                return true;
            }
            
            // Create new invoices for each payment period
            for (PaymentPeriod period : paymentPeriods) {
                if (period.getDate() == null || period.getAmount() <= 0) {
                    continue; // Skip invalid periods
                }
                
                String invoiceID = invoiceDAO.generateInvoiceID();
                Invoice invoice = new Invoice();
                invoice.setInvoiceID(invoiceID);
                invoice.setContractID(contractId);
                invoice.setAmount(period.getAmount());
                invoice.setPayDate(period.getDate());
                invoice.setStatus("Pending"); // Default status
                invoice.setMemo(period.getTerms());
                
                invoices.add(invoice);
            }
            
            return invoiceDAO.createInvoicesBatch(invoices);
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}