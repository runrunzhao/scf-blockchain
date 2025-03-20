package com.supplychainfinance.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.supplychainfinance.blockchain.service.CTTTokenService;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;


public class QueryCTTTokensServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(QueryCTTTokensServlet.class.getName());
    private final CTTTokenService cttTokenService = new CTTTokenService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String result;
            
            // Check if we're querying by owner
            String owner = request.getParameter("owner");
            if (owner != null && !owner.isEmpty()) {
                // Query tokens by owner
                result = cttTokenService.queryTokensByOwner(owner);
            } else {
                // Query all tokens
                result = cttTokenService.queryAllTokens();
            }
            
            // Return response
            response.setContentType("application/json");
            response.getWriter().write(result);
            
        } catch (Exception e) {
            logger.severe("Error querying CTT tokens: " + e.getMessage());
            
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("error", e.getMessage());
            
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(jsonResponse.toString());
        }
    }
}