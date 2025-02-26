package com.supplychainfinance.servlet;

import com.supplychainfinance.dao.EnterpriseDAO;
import com.supplychainfinance.model.Enterprise;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

public class GetEnterpriseServlet extends HttpServlet {
    
    private EnterpriseDAO enterpriseDAO = new EnterpriseDAO();
    private Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        
        if (id != null && !id.trim().isEmpty()) {
            Enterprise enterprise = enterpriseDAO.getEnterpriseById(id);
            
            if (enterprise != null) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(gson.toJson(enterprise));
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Enterprise not found");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("No enterprise ID provided");
        }
    }
}