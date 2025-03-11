package com.supplychainfinance.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.supplychainfinance.dao.InvoiceDAO;
import com.supplychainfinance.model.Invoice;

public class GetInvoicesServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            String invoiceId = request.getParameter("invoiceId");
            String contractId = request.getParameter("contractId");
            String enterpriseName = request.getParameter("enterpriseName");
            String status = request.getParameter("status");
            
            InvoiceDAO invoiceDAO = new InvoiceDAO();
            List<Invoice> invoices = invoiceDAO.searchInvoices(invoiceId, contractId, 
                                                              enterpriseName, status);
            
            // 转换为JSON
            Gson gson = new Gson();
            out.print(gson.toJson(invoices));
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}