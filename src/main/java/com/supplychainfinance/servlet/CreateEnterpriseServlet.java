package com.supplychainfinance.servlet;

import com.supplychainfinance.dao.EnterpriseDAO;
import com.supplychainfinance.model.Enterprise;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // 解析JSON数据
            JsonObject jsonObject = gson.fromJson(data, JsonObject.class);
            
            // 创建企业对象
            Enterprise enterprise = new Enterprise();
            
            // 检查是否有企业ID，如果没有则生成一个新ID
            String enterpriseID;
            if (jsonObject.has("id") && !jsonObject.get("id").isJsonNull() && 
                !jsonObject.get("id").getAsString().trim().isEmpty()) {
                // 使用前端传来的ID (编辑模式)
                enterpriseID = jsonObject.get("id").getAsString().trim();
            } else {
                // 使用 EnterpriseDAO 的方法生成 ID (添加模式)
                enterpriseID = enterpriseDAO.generateEnterpriseId();
            }
            
            // 设置企业属性
            enterprise.setEnterpriseID(enterpriseID);

            System.out.println("Generated enterprise ID: " + enterpriseID);
            
            if (jsonObject.has("name") && !jsonObject.get("name").isJsonNull()) {
                enterprise.setEnterpriseName(jsonObject.get("name").getAsString());
            } else {
                throw new IllegalArgumentException("企业名称不能为空");
            }
            
            if (jsonObject.has("type") && !jsonObject.get("type").isJsonNull()) {
                enterprise.setRole(jsonObject.get("type").getAsString());
            } else {
                throw new IllegalArgumentException("企业类型不能为空");
            }
            
            if (jsonObject.has("contact") && !jsonObject.get("contact").isJsonNull()) {
                enterprise.setTelephone(jsonObject.get("contact").getAsString());
            } else {
                enterprise.setTelephone("");
            }
            
            if (jsonObject.has("address") && !jsonObject.get("address").isJsonNull()) {
                enterprise.setAddress(jsonObject.get("address").getAsString());
            } else {
                enterprise.setAddress("");
            }
            
            if (jsonObject.has("memo") && !jsonObject.get("memo").isJsonNull()) {
                enterprise.setMemo(jsonObject.get("memo").getAsString());
            } else {
                enterprise.setMemo("");
            }
            
            // 设置Tier，如果存在
            if (jsonObject.has("tier") && !jsonObject.get("tier").isJsonNull()) {
                try {
                    enterprise.setTier(Integer.parseInt(jsonObject.get("tier").getAsString()));
                } catch (NumberFormatException e) {
                    // 如果不是数字，设为默认值
                    enterprise.setTier(1);
                }
            } else {
                enterprise.setTier(1); // 默认为Tier 1
            }
            
            // 确定是创建还是更新
            boolean isUpdate = jsonObject.has("id") && 
                               !jsonObject.get("id").isJsonNull() && 
                               !jsonObject.get("id").getAsString().trim().isEmpty();
            
            boolean success;
            if (isUpdate) {
                // 更新现有企业
                success = enterpriseDAO.updateEnterprise(enterprise);
            } else {
                // 创建新企业
                success = enterpriseDAO.createEnterprise(enterprise);
            }
            
            // 创建响应
            JsonObject responseJson = new JsonObject();
            responseJson.addProperty("success", success);
            responseJson.addProperty("enterpriseID", enterpriseID);
            
            if (success) {
                responseJson.addProperty("message", isUpdate ? "企业更新成功" : "企业创建成功");
            } else {
                responseJson.addProperty("message", isUpdate ? "企业更新失败" : "企业创建失败");
            }
            
            out.print(gson.toJson(responseJson));
            
        } catch (Exception e) {
            // 处理错误情况
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "操作失败: " + e.getMessage());
            out.print(gson.toJson(errorResponse));
            
            e.printStackTrace();
        } finally {
            out.flush();
        }
    }
}