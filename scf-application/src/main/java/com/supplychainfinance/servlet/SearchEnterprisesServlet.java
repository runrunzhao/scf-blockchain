package com.supplychainfinance.servlet;

import com.supplychainfinance.dao.EnterpriseDAO;
import com.supplychainfinance.model.Enterprise;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

public class SearchEnterprisesServlet extends HttpServlet {
    
    private EnterpriseDAO enterpriseDAO = new EnterpriseDAO();
    private Gson gson = new Gson();
    
   @Override
    public void init() throws ServletException {
        super.init();
        enterpriseDAO = new EnterpriseDAO();
        gson = new Gson();
        System.out.println("SearchEnterprisesServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("SearchEnterprisesServlet.doGet() called");
        // Set character encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        
        try {
            // Get search parameters
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String type = request.getParameter("type");
            
            // Search for enterprises
            List<Enterprise> enterprises = enterpriseDAO.searchEnterprises(id, name, type);
            
            // Ensure we're returning an empty array if no results found
            if (enterprises == null) {
                enterprises = new ArrayList<>();
            }
            
            // Send response
            response.getWriter().write(gson.toJson(enterprises));
            
        } catch (Exception e) {
            // Log the exception
            e.printStackTrace();
            
            // Return an error message as JSON
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}