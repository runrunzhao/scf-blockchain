package com.supplychainfinance.servlet;

import com.google.gson.Gson;
import com.supplychainfinance.dao.InvoiceDAO;
import com.supplychainfinance.model.Invoice;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SingleInvoiceServlet extends HttpServlet {
    private InvoiceDAO invoiceDAO;
    private Gson gson = new Gson();
    
    @Override
    public void init() {
        invoiceDAO = new InvoiceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "get":
                getSingleInvoice(request, response);
                break;
            case "list":
                listInvoices(request, response);
                break;
            case "getByContract":
                getInvoicesByContract(request, response);
                break;
            default:
                listInvoices(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "add";
        }
        
        switch (action) {
            case "add":
                addInvoice(request, response);
                break;
            case "addBatch":
                addInvoiceBatch(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action: " + action);
        }
    }

    private void addInvoice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Map<String, Object> result = new HashMap<>();
        
        try {
            // Get parameters from request
            String contractID = request.getParameter("contractID");
            if (contractID == null || contractID.isEmpty()) {
                result.put("success", false);
                result.put("message", "Contract ID is required");
                out.print(gson.toJson(result));
                return;
            }
            
            double amount;
            try {
                amount = Double.parseDouble(request.getParameter("amount"));
                if (amount <= 0) {
                    result.put("success", false);
                    result.put("message", "Amount must be greater than zero");
                    out.print(gson.toJson(result));
                    return;
                }
            } catch (NumberFormatException e) {
                result.put("success", false);
                result.put("message", "Invalid amount format");
                out.print(gson.toJson(result));
                return;
            }
            
            String payDateStr = request.getParameter("payDate");
            if (payDateStr == null || payDateStr.isEmpty()) {
                result.put("success", false);
                result.put("message", "Payment date is required");
                out.print(gson.toJson(result));
                return;
            }
            
           // String paymentMethod = request.getParameter("paymentMethod");
            String memo = request.getParameter("memo");
            
            // Parse date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date payDate;
            try {
                payDate = sdf.parse(payDateStr);
            } catch (ParseException e) {
                result.put("success", false);
                result.put("message", "Invalid date format");
                out.print(gson.toJson(result));
                return;
            }
            
            // Generate invoice ID
            String invoiceID = invoiceDAO.generateInvoiceID();
            
            // Create invoice object
            Invoice invoice = new Invoice();
            invoice.setInvoiceID(invoiceID);
            invoice.setContractID(contractID);
            invoice.setAmount(amount);
            invoice.setPayDate(payDate);
                 invoice.setMemo(memo);
            invoice.setStatus("Draft"); // Default status
                      
            // Save invoice to database using the correct method name
            boolean success = invoiceDAO.createInvoice(invoice);
            
            if (success) {
                result.put("success", true);
                result.put("message", "Invoice added successfully");
                result.put("invoiceId", invoice.getInvoiceID());
            } else {
                result.put("success", false);
                result.put("message", "Failed to add invoice");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
            e.printStackTrace(); // Log the error for debugging
        }
        
        out.print(gson.toJson(result));
        out.flush();
    }
    
    private void addInvoiceBatch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Map<String, Object> result = new HashMap<>();
        
        try {
            // In a real application, you'd parse a JSON array of invoices
            // For this example, we'll just create a simple batch
            String contractID = request.getParameter("contractID");
            String[] amountStrings = request.getParameterValues("amount");
            String[] payDateStrings = request.getParameterValues("payDate");
            
            if (contractID == null || amountStrings == null || payDateStrings == null || 
                amountStrings.length != payDateStrings.length) {
                result.put("success", false);
                result.put("message", "Invalid batch parameters");
                out.print(gson.toJson(result));
                return;
            }
            
            List<Invoice> invoices = new ArrayList<>();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            for (int i = 0; i < amountStrings.length; i++) {
                try {
                    double amount = Double.parseDouble(amountStrings[i]);
                    Date payDate = sdf.parse(payDateStrings[i]);
                    
                    Invoice invoice = new Invoice();
                    invoice.setInvoiceID(invoiceDAO.generateInvoiceID());
                    invoice.setContractID(contractID);
                    invoice.setAmount(amount);
                    invoice.setPayDate(payDate);
                    invoice.setStatus("Draft");
                                  
                    invoices.add(invoice);
                } catch (Exception e) {
                    // Skip invalid entries
                    System.err.println("Error creating invoice in batch: " + e.getMessage());
                }
            }
            
            if (invoices.isEmpty()) {
                result.put("success", false);
                result.put("message", "No valid invoices found in batch");
                out.print(gson.toJson(result));
                return;
            }
            
            boolean success = invoiceDAO.createInvoicesBatch(invoices);
            
            if (success) {
                result.put("success", true);
                result.put("message", "Batch invoices added successfully");
                result.put("count", invoices.size());
            } else {
                result.put("success", false);
                result.put("message", "Failed to add batch invoices");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
            e.printStackTrace();
        }
        
        out.print(gson.toJson(result));
        out.flush();
    }

    private void getSingleInvoice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Map<String, Object> result = new HashMap<>();
        
        try {
            String invoiceId = request.getParameter("invoiceId");
            if (invoiceId != null && !invoiceId.isEmpty()) {
                Invoice invoice = invoiceDAO.getInvoiceById(invoiceId);
                if (invoice != null) {
                    out.print(gson.toJson(invoice));
                } else {
                    result.put("success", false);
                    result.put("message", "Invoice not found");
                    out.print(gson.toJson(result));
                }
            } else {
                result.put("success", false);
                result.put("message", "Invoice ID is required");
                out.print(gson.toJson(result));
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
            out.print(gson.toJson(result));
            e.printStackTrace();
        }
        out.flush();
    }
    
    private void getInvoicesByContract(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Map<String, Object> result = new HashMap<>();
        
        try {
            String contractId = request.getParameter("contractId");
            if (contractId != null && !contractId.isEmpty()) {
                List<Invoice> invoices = invoiceDAO.getInvoicesByContractID(contractId);
                out.print(gson.toJson(invoices));
            } else {
                result.put("success", false);
                result.put("message", "Contract ID is required");
                out.print(gson.toJson(result));
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
            out.print(gson.toJson(result));
            e.printStackTrace();
        }
        out.flush();
    }

    private void listInvoices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            // Get search parameters
            String invoiceId = request.getParameter("invoiceId");
            String contractId = request.getParameter("contractId");
            String enterpriseName = request.getParameter("enterpriseName");
            String status = request.getParameter("status");
            
            // Use the DAO's searchInvoices with all parameters
            List<Invoice> invoices = invoiceDAO.searchInvoices(invoiceId, contractId, enterpriseName, status);
            out.print(gson.toJson(invoices));
        } catch (Exception e) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
            out.print(gson.toJson(result));
            e.printStackTrace();
        }
        out.flush();
    }
}