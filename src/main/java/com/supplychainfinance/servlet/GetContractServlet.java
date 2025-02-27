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

public class GetContractServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Set response type before any processing
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            // Get contract ID from request
            String contractId = request.getParameter("contractId");
            System.out.println("GetContractServlet - Getting contract: " + contractId);
            
            // Get contract details
            ContractDAO contractDAO = new ContractDAO();
            Contract contract = contractDAO.getContract(contractId);
            
            if (contract != null) {
                System.out.println("GetContractServlet - Found contract: " + contract.getContractId());
            } else {
                System.out.println("GetContractServlet - No contract found with ID: " + contractId);
            }
            
            // Convert to JSON and send response
            Gson gson = new Gson();
            String json = gson.toJson(contract);
            
            // Write the JSON response
            response.getWriter().write(json);
            
        } catch (Exception e) {
            // Log the error
            System.err.println("ERROR in GetContractServlet: " + e.getMessage());
            e.printStackTrace();
            
            // Send an error response in JSON format
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
    }
}