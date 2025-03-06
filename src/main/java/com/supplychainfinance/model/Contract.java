package com.supplychainfinance.model;

import java.math.BigDecimal;
import java.util.Date;

public class Contract {
    // 基本字段
    private String contractId;
    private String contractName;
    private String fromEnterpriseId;
    private String fromEnterpriseName;
    private String toEnterpriseId;
    private String toEnterpriseName;
    private String contractType;
    private String status;
    private double amount;
    private String createDate;
    private String signDate;
    private String effectiveDate;
    private String expiryDate;
    private String paymentTerms;
    private String description;
    private String remarks;
    
    // 兼容字段 - 用于与不同命名约定的代码配合使用
    private String contractID;
    private String contractNumber;
    private BigDecimal contractAmount;
    private Date contractDate;
    private Date startDate;
    private Date endDate;
    private String partyAID;
    private String partyBID;

    // 原有字段的 Getters 和 Setters
    public String getContractId() {
        return contractId;
    }
    
    public void setContractId(String contractId) {
        this.contractId = contractId;
        // 同时设置兼容字段
        this.contractID = contractId;
    }
    
    public String getContractName() {
        return contractName;
    }
    
    public void setContractName(String contractName) {
        this.contractName = contractName;
        // 同时设置兼容字段
        this.contractNumber = contractName;
    }
    
    public String getFromEnterpriseId() {
        return fromEnterpriseId;
    }
    
    public void setFromEnterpriseId(String fromEnterpriseId) {
        this.fromEnterpriseId = fromEnterpriseId;
        // 同时设置兼容字段
        this.partyAID = fromEnterpriseId;
    }
    
    public String getFromEnterpriseName() {
        return fromEnterpriseName;
    }
    
    public void setFromEnterpriseName(String fromEnterpriseName) {
        this.fromEnterpriseName = fromEnterpriseName;
    }
    
    public String getToEnterpriseId() {
        return toEnterpriseId;
    }
    
    public void setToEnterpriseId(String toEnterpriseId) {
        this.toEnterpriseId = toEnterpriseId;
        // 同时设置兼容字段
        this.partyBID = toEnterpriseId;
    }
    
    public String getToEnterpriseName() {
        return toEnterpriseName;
    }
    
    public void setToEnterpriseName(String toEnterpriseName) {
        this.toEnterpriseName = toEnterpriseName;
    }
    
    public String getContractType() {
        return contractType;
    }
    
    public void setContractType(String contractType) {
        this.contractType = contractType;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public double getAmount() {
        return amount;
    }
    
    public void setAmount(double amount) {
        this.amount = amount;
        // 同时设置兼容字段
        this.contractAmount = BigDecimal.valueOf(amount);
    }
    
    public String getCreateDate() {
        return createDate;
    }
    
    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }
    
    public String getSignDate() {
        return signDate;
    }
    
    public void setSignDate(String signDate) {
        this.signDate = signDate;
    }
    
    public String getEffectiveDate() {
        return effectiveDate;
    }
    
    public void setEffectiveDate(String effectiveDate) {
        this.effectiveDate = effectiveDate;
    }
    
    public String getExpiryDate() {
        return expiryDate;
    }
    
    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }
    
    public String getPaymentTerms() {
        return paymentTerms;
    }
    
    public void setPaymentTerms(String paymentTerms) {
        this.paymentTerms = paymentTerms;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getRemarks() {
        return remarks;
    }
    
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
    
    // 兼容字段的 Getters 和 Setters
    public String getContractID() {
        return contractId; // 返回原字段值
    }
    
    public void setContractID(String contractID) {
        this.contractID = contractID;
        this.contractId = contractID; // 同步设置原字段
    }
    
    public String getContractNumber() {
        return contractName; // 返回原字段值
    }
    
    public void setContractNumber(String contractNumber) {
        this.contractNumber = contractNumber;
        this.contractName = contractNumber; // 同步设置原字段
    }
    
    public BigDecimal getContractAmount() {
        return BigDecimal.valueOf(amount); // 返回原字段转换值
    }
    
    public void setContractAmount(BigDecimal contractAmount) {
        this.contractAmount = contractAmount;
        if (contractAmount != null) {
            this.amount = contractAmount.doubleValue(); // 同步设置原字段
        }
    }
    
    public Date getContractDate() {
        return contractDate;
    }
    
    public void setContractDate(Date contractDate) {
        this.contractDate = contractDate;
    }
    
    public Date getStartDate() {
        return startDate;
    }
    
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    
    public Date getEndDate() {
        return endDate;
    }
    
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    
    public String getPartyAID() {
        return fromEnterpriseId; // 返回原字段值
    }
    
    public void setPartyAID(String partyAID) {
        this.partyAID = partyAID;
        this.fromEnterpriseId = partyAID; // 同步设置原字段
    }
    
    public String getPartyBID() {
        return toEnterpriseId; // 返回原字段值
    }
    
    public void setPartyBID(String partyBID) {
        this.partyBID = partyBID;
        this.toEnterpriseId = partyBID; // 同步设置原字段
    }
}