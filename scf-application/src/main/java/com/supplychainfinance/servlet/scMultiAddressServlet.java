package com.supplychainfinance.servlet;

import com.supplychainfinance.util.scTransAddressUtil;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.json.JSONObject;

public class scMultiAddressServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        JSONObject result = new JSONObject();
        
        try {
            String address = scTransAddressUtil.getLatestScMultiAddr();
            if (address != null) {
                result.put("success", true);
                result.put("scMultiAddress", address);
            } else {
                result.put("success", false);
                result.put("message", "No contract address found");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(result.toString());
    }
}