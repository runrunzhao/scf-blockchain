package com.supplychainfinance.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.supplychainfinance.blockchain.service.CTTTokenService;
import com.supplychainfinance.util.ServletUtils;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import java.util.logging.Logger;


public class GenerateCTTServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(GenerateCTTServlet.class.getName());
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    private final CTTTokenService cttTokenService = new CTTTokenService();
   // private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Parse request body
            JsonObject requestBody = ServletUtils.parseRequestBody(request);
            
            // Extract parameters from request
            String issuer = requestBody.get("issuer").getAsString();
            String owner = requestBody.get("owner").getAsString();
            double amount = requestBody.get("amount").getAsDouble();
            String description = requestBody.get("description").getAsString();
            
            // Generate token ID
            String tokenId = "CTT-" + UUID.randomUUID().toString().substring(0, 8);
            
            // Set dates
            String issuedDate = dateFormat.format(new Date());
            
            // Default expiry date to 1 year from now
            Date expiryDate = new Date();
            expiryDate.setTime(expiryDate.getTime() + 365L * 24 * 60 * 60 * 1000);
            String expiryDateStr = dateFormat.format(expiryDate);
            
            // Generate CTT token
            String result = cttTokenService.generateCTTToken(
                tokenId, issuer, owner, amount, issuedDate, expiryDateStr, "", description
            );
            
            // Return response
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("message", "CTT token generated successfully");
            jsonResponse.addProperty("tokenId", tokenId);
            jsonResponse.addProperty("result", result);
            
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());
            
        } catch (Exception e) {
            logger.severe("Error generating CTT token: " + e.getMessage());
            
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("error", e.getMessage());
            
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(jsonResponse.toString());
        }
    }
}