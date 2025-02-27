package com.supplychainfinance.model;

public class Contract {
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
    
    // Getters and setters
    public String getContractId() {
        return contractId;
    }
    
    public void setContractId(String contractId) {
        this.contractId = contractId;
    }
    
    public String getContractName() {
        return contractName;
    }
    
    public void setContractName(String contractName) {
        this.contractName = contractName;
    }
    
    public String getFromEnterpriseId() {
        return fromEnterpriseId;
    }
    
    public void setFromEnterpriseId(String fromEnterpriseId) {
        this.fromEnterpriseId = fromEnterpriseId;
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
}