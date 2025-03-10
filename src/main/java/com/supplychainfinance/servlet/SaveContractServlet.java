package com.supplychainfinance.servlet;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.supplychainfinance.dao.ContractDAO;
import com.supplychainfinance.model.Contract;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.stream.Collectors;

public class SaveContractServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();

        try {
            // 读取请求体
            String requestBody = request.getReader().lines().collect(Collectors.joining());
            System.out.println("Received contract data: " + requestBody);

            // 解析 JSON
            JsonObject contractJson = JsonParser.parseString(requestBody).getAsJsonObject();

            // 创建 Contract 对象
            Contract contract = new Contract();

            // 处理 ID（如果存在且不为空）
            if (contractJson.has("contractId") && !contractJson.get("contractId").getAsString().trim().isEmpty()) {
                contract.setContractId(contractJson.get("contractId").getAsString());
            }

            // 设置基本字段
            if (contractJson.has("contractName")) {
                contract.setContractName(contractJson.get("contractName").getAsString());
            }

            if (contractJson.has("fromEnterpriseId")) {
                contract.setFromEnterpriseId(contractJson.get("fromEnterpriseId").getAsString());
            }

            if (contractJson.has("toEnterpriseId")) {
                contract.setToEnterpriseId(contractJson.get("toEnterpriseId").getAsString());
            }

            // 解析金额
            try {
                if (contractJson.has("amount") && !contractJson.get("amount").getAsString().isEmpty()) {
                    String amountStr = contractJson.get("amount").getAsString();
                    contract.setAmount(Double.parseDouble(amountStr));
                }
            } catch (Exception e) {
                contract.setAmount(0.0);
                System.out.println("Error parsing amount: " + e.getMessage());
            }

            // 设置状态
            if (contractJson.has("status")) {
                contract.setStatus(contractJson.get("status").getAsString());
            } else {
                contract.setStatus("Active");  // 默认状态
            }

            // 解析日期 - 使用完全限定名
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            try {
                if (contractJson.has("signDate") && !contractJson.get("signDate").getAsString().isEmpty()) {
                    java.util.Date parsedDate = dateFormat.parse(contractJson.get("signDate").getAsString());
                    contract.setSignDate(parsedDate);
                } else {
                    contract.setSignDate(new java.util.Date()); // 默认今天
                }
            } catch (Exception e) {
                contract.setSignDate(new java.util.Date()); // 解析失败时默认今天
                System.out.println("Error parsing sign date: " + e.getMessage());
            }

            try {
                if (contractJson.has("effectiveDate") && !contractJson.get("effectiveDate").getAsString().isEmpty()) {
                    java.util.Date parsedDate = dateFormat.parse(contractJson.get("effectiveDate").getAsString());
                    contract.setEffectiveDate(parsedDate);
                } else {
                    contract.setEffectiveDate(new java.util.Date()); // 默认今天
                }
            } catch (Exception e) {
                contract.setEffectiveDate(new java.util.Date());
                System.out.println("Error parsing effective date: " + e.getMessage());
            }

            try {
                if (contractJson.has("expiryDate") && !contractJson.get("expiryDate").getAsString().isEmpty()) {
                    java.util.Date parsedDate = dateFormat.parse(contractJson.get("expiryDate").getAsString());
                    contract.setExpiryDate(parsedDate);
                } else {
                    // 默认一年后
                    Calendar calendar = Calendar.getInstance();
                    calendar.add(Calendar.YEAR, 1);
                    contract.setExpiryDate(calendar.getTime());
                }
            } catch (Exception e) {
                // 默认一年后
                Calendar calendar = Calendar.getInstance();
                calendar.add(Calendar.YEAR, 1);
                contract.setExpiryDate(calendar.getTime());
                System.out.println("Error parsing expiry date: " + e.getMessage());
            }

            // 保存非数据库字段
            if (contractJson.has("contractType")) {
                contract.setContractType(contractJson.get("contractType").getAsString());
            }

            if (contractJson.has("paymentTerms")) {
                contract.setPaymentTerms(contractJson.get("paymentTerms").getAsString());
            }

            if (contractJson.has("description")) {
                contract.setDescription(contractJson.get("description").getAsString());
            }

            if (contractJson.has("remarks")) {
                contract.setRemarks(contractJson.get("remarks").getAsString());
            }

            // 使用 DAO 保存到数据库
            ContractDAO contractDAO = new ContractDAO();

            if (contract.getContractId() == null || contract.getContractId().trim().isEmpty()) {
                contractDAO.insertContract(contract);
            } else {
                contractDAO.updateContract(contract);
            }

            // 返回成功响应
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("contractId", contract.getContractId());
            out.print(jsonResponse);

        } catch (Exception e) {
            e.printStackTrace();

            // 返回错误响应
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("error", e.getMessage());
            out.print(jsonResponse);
        }
    }
}