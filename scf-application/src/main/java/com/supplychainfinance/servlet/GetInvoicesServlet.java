package com.supplychainfinance.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.supplychainfinance.dao.InvoiceDAO;
import com.supplychainfinance.model.Invoice;

/**
 * Servlet to handle requests for listing invoices
 */
public class GetInvoicesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String invoiceId = request.getParameter("invoiceID");
        String contractId = request.getParameter("contractId");
        String enterpriseName = request.getParameter("enterpriseName");
        String status = request.getParameter("status");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        System.out.println(invoiceId + " " + contractId + " " + enterpriseName + " " + status);
        
        try {
            InvoiceDAO invoiceDAO = new InvoiceDAO();
            List<Invoice> invoices;
            
            // Otherwise use the search function
            invoices = invoiceDAO.searchInvoices(invoiceId, contractId, enterpriseName, status);
                  
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(invoices);
            response.getWriter().write(jsonResponse);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Server error: " + e.getMessage() + "\"}");
        }
    }
}