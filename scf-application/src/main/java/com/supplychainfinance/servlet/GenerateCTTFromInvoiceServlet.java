package com.supplychainfinance.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.supplychainfinance.blockchain.service.InvoiceBlockchainService;
import com.supplychainfinance.util.ServletUtils;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;

public class GenerateCTTFromInvoiceServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(GenerateCTTFromInvoiceServlet.class.getName());
    private final InvoiceBlockchainService invoiceService = new InvoiceBlockchainService();
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Parse request body
            JsonObject requestBody = ServletUtils.parseRequestBody(request);
            
            // Extract parameters
            String invoiceId = requestBody.get("invoiceId").getAsString();
            String recipientId = requestBody.get("recipientId").getAsString();
            
            // Generate CTT from invoice
            String result = invoiceService.generateCTTFromInvoice(invoiceId, recipientId);
            
            // Return response
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("message", "CTT token generated from invoice successfully");
            jsonResponse.addProperty("invoiceId", invoiceId);
            jsonResponse.addProperty("result", result);
            
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());
            
        } catch (Exception e) {
            logger.severe("Error generating CTT from invoice: " + e.getMessage());
            
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("error", e.getMessage());
            
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(jsonResponse.toString());
        }
    }
}