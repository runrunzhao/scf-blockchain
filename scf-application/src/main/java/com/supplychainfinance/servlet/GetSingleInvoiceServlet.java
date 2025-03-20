package com.supplychainfinance.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.supplychainfinance.dao.InvoiceDAO;
import com.supplychainfinance.model.Invoice;

/**
 * Servlet to handle requests for a single invoice by invoice ID
 */
public class GetSingleInvoiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String invoiceId = request.getParameter("invoiceId");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Log the request
        System.out.println("GetSingleInvoiceServlet: Fetching invoice with ID: " + invoiceId);
        
        if (invoiceId == null || invoiceId.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Invoice ID is required\"}");
            return;
        }
        
        try {
            InvoiceDAO invoiceDAO = new InvoiceDAO();
            
            Invoice invoice = invoiceDAO.getInvoiceById(invoiceId);
            
            if (invoice != null) {
                Gson gson = new Gson();
                String jsonResponse = gson.toJson(invoice);
                response.getWriter().write(jsonResponse);
                System.out.println("Invoice found and returned successfully");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\":\"Invoice not found\"}");
                System.out.println("Invoice not found with ID: " + invoiceId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Server error: " + e.getMessage() + "\"}");
        }
    }
}