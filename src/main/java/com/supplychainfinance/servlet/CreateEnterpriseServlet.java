package com.supplychainfinance.servlet;

import com.supplychainfinance.dao.EnterpriseDAO;
import com.supplychainfinance.model.Enterprise;
import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class CreateEnterpriseServlet extends HttpServlet {
    
    private EnterpriseDAO enterpriseDAO = new EnterpriseDAO();
    private Gson gson = new Gson();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        StringBuilder buffer = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            buffer.append(line);
        }
        
        String data = buffer.toString();
        
        try {
            // Create Enterprise object from JSON data
            Enterprise enterprise = new Enterprise();
            
            JsonObject jsonObject = gson.fromJson(data, JsonObject.class);
            
            String enterpriseID = jsonObject.get("id").getAsString();
            enterprise.setEnterpriseID(enterpriseID);
            enterprise.setEnterpriseName(jsonObject.get("name").getAsString());
            enterprise.setRole(jsonObject.get("type").getAsString());
            enterprise.setTelephone(jsonObject.get("contact").getAsString());
            enterprise.setAddress(jsonObject.get("address").getAsString());
            enterprise.setMemo(jsonObject.has("memo") ? jsonObject.get("memo").getAsString() : "");
            
            boolean success = enterpriseDAO.createEnterprise(enterprise);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            JsonObject responseJson = new JsonObject();
            responseJson.addProperty("success", success);
            responseJson.addProperty("enterpriseID", enterpriseID);
            
            if (success) {
                responseJson.addProperty("message", "Enterprise created successfully");
            } else {
                responseJson.addProperty("message", "Failed to create enterprise");
            }
            
            response.getWriter().write(gson.toJson(responseJson));
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            
            JsonObject responseJson = new JsonObject();
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "Invalid input: " + e.getMessage());
            
            response.getWriter().write(gson.toJson(responseJson));
        }
    }
}