package com.supplychainfinance.util;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.logging.Logger;

/**
 * Utility methods for servlet operations
 */
public class ServletUtils {
    private static final Logger logger = Logger.getLogger(ServletUtils.class.getName());
    private static final Gson gson = new Gson();
    
    /**
     * Parse the JSON request body into a JsonObject
     */
    public static JsonObject parseRequestBody(HttpServletRequest request) throws IOException {
        StringBuilder sb = new StringBuilder();
        String line;
        
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        } catch (IOException e) {
            logger.severe("Error reading request body: " + e.getMessage());
            throw new IOException("Failed to read request body", e);
        }
        
        String requestBody = sb.toString();
        if (requestBody.isEmpty()) {
            throw new IOException("Empty request body");
        }
        
        try {
            return JsonParser.parseString(requestBody).getAsJsonObject();
        } catch (Exception e) {
            logger.severe("Error parsing JSON: " + e.getMessage());
            throw new IOException("Invalid JSON format in request body", e);
        }
    }
    
    /**
     * Convert an object to JSON string
     */
    public static String toJson(Object obj) {
        return gson.toJson(obj);
    }
    
    /**
     * Parse JSON string to object
     */
    public static <T> T fromJson(String json, Class<T> classOfT) {
        return gson.fromJson(json, classOfT);
    }
}