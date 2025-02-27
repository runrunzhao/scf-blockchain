package com.supplychainfinance.servlet;

import com.supplychainfinance.dao.ContractDAO;
import com.supplychainfinance.model.Contract;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


public class SearchContractServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Set response type before any processing
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            // Get search parameters from request
            String contractId = request.getParameter("contractId");
            String enterpriseName = request.getParameter("enterpriseName");
            String contractStatus = request.getParameter("contractStatus");
            // We'll ignore contractType since it's not in your schema
            
            System.out.println("SearchContractServlet - Searching for: ID=" + contractId + 
                    ", Enterprise=" + enterpriseName + 
                    ", Status=" + contractStatus);
            
            // Search for contracts
            ContractDAO contractDAO = new ContractDAO();
            List<Contract> contracts = contractDAO.searchContracts(
                contractId, enterpriseName, contractStatus, null);
            
            System.out.println("SearchContractServlet - Found " + contracts.size() + " contracts");
            
            // Convert to JSON and send response
            Gson gson = new Gson();
            String json = gson.toJson(contracts);
            
            // Write the JSON response
            response.getWriter().write(json);
            
        } catch (Exception e) {
            // Log the error
            System.err.println("ERROR in SearchContractServlet: " + e.getMessage());
            e.printStackTrace();
            
            // Send an error response in JSON format
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
    }
}