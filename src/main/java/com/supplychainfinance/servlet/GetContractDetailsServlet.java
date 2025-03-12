package com.supplychainfinance.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.supplychainfinance.dao.ContractDAO;
import com.supplychainfinance.model.Contract;

/**
 * Servlet to handle requests for contract details by contract ID
 */
public class GetContractDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String contractId = request.getParameter("contractId");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Log the request
        System.out.println("GetContractDetailsServlet: Fetching contract with ID: " + contractId);
        
        if (contractId == null || contractId.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Contract ID is required\"}");
            return;
        }
        
        try {
            ContractDAO contractDAO = new ContractDAO();
            Contract contract = contractDAO.getContract(contractId);
            
            if (contract != null) {
                Gson gson = new Gson();
                String jsonResponse = gson.toJson(contract);
                response.getWriter().write(jsonResponse);
                System.out.println("Contract found and returned successfully");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\":\"Contract not found\"}");
                System.out.println("Contract not found with ID: " + contractId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Server error: " + e.getMessage() + "\"}");
        }
    }
}