package com.supplychainfinance.servlet;

import com.supplychainfinance.dao.EnterpriseDAO;
import com.supplychainfinance.model.Enterprise;
import java.io.IOException;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class CoreEnterpriseServlet extends HttpServlet {
    
    private EnterpriseDAO enterpriseDAO = new EnterpriseDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get core enterprise from database
            Enterprise coreEnterprise = enterpriseDAO.getCoreEnterprise();
            
            if (coreEnterprise != null) {
                // Set the core enterprise as a request attribute
                request.setAttribute("coreEnterprise", coreEnterprise);
            }
            
            // Forward to index.jsp
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching core enterprise data");
        }
    }
}