package com.supplychainfinance.chaincode.model;

import org.hyperledger.fabric.contract.annotation.DataType;
import org.hyperledger.fabric.contract.annotation.Property;

@DataType
public class Invoice {
    @Property
    private String invoiceId;
    
    @Property
    private String contractId;
    
    @Property
    private String fromEnterpriseId;
    
    @Property
    private String toEnterpriseId;
    
    @Property
    private Double amount;
    
    @Property
    private String issueDate;
    
    @Property
    private String dueDate;
    
    @Property
    private InvoiceState state;
    
    @Property
    private String description;
    
    @Property
    private String tokenId;  // ID of associated CTT token, if any

    // 默认构造函数 - 序列化需要
    public Invoice() {
    }

    // 主构造函数
    public Invoice(String invoiceId, String contractId, String fromEnterpriseId, 
                 String toEnterpriseId, Double amount, String issueDate, 
                 String dueDate, String description) {
        this.invoiceId = invoiceId;
        this.contractId = contractId;
        this.fromEnterpriseId = fromEnterpriseId;
        this.toEnterpriseId = toEnterpriseId;
        this.amount = amount;
        this.issueDate = issueDate;
        this.dueDate = dueDate;
        this.state = InvoiceState.CREATED;
        this.description = description;
        this.tokenId = "";
    }

    // 兼容旧代码的构造函数 - 如果需要的话
    public Invoice(String invoiceId, String contractId, double amount, 
                 String payDate, String status, String memo) {
        this.invoiceId = invoiceId;
        this.contractId = contractId;
        this.amount = amount;
        this.dueDate = payDate;
        this.state = convertStringToState(status);
        this.description = memo;
    }

    // 状态转换辅助方法
    private InvoiceState convertStringToState(String status) {
        if (status == null) return InvoiceState.CREATED;
        
        switch (status.toUpperCase()) {
            case "APPROVED": return InvoiceState.APPROVED;
            case "REJECTED": return InvoiceState.REJECTED;
            case "PAID": return InvoiceState.PAID;
            case "TOKENIZED": return InvoiceState.TOKENIZED;
            default: return InvoiceState.CREATED;
        }
    }

    // Getters 和 Setters - 使用新的属性名
    public String getInvoiceId() { return invoiceId; }
    public void setInvoiceId(String invoiceId) { this.invoiceId = invoiceId; }
    
    public String getContractId() { return contractId; }
    public void setContractId(String contractId) { this.contractId = contractId; }
    
    public String getFromEnterpriseId() { return fromEnterpriseId; }
    public void setFromEnterpriseId(String fromEnterpriseId) { this.fromEnterpriseId = fromEnterpriseId; }
    
    public String getToEnterpriseId() { return toEnterpriseId; }
    public void setToEnterpriseId(String toEnterpriseId) { this.toEnterpriseId = toEnterpriseId; }
    
    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }
    
    public String getIssueDate() { return issueDate; }
    public void setIssueDate(String issueDate) { this.issueDate = issueDate; }
    
    public String getDueDate() { return dueDate; }
    public void setDueDate(String dueDate) { this.dueDate = dueDate; }
    
    public InvoiceState getState() { return state; }
    public void setState(InvoiceState state) { this.state = state; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getTokenId() { return tokenId; }
    public void setTokenId(String tokenId) { this.tokenId = tokenId; }
    
    
    public String getMemo() { return description; }
    public void setMemo(String memo) { this.description = memo; }
    
    public String getStatus() { 
        return state != null ? state.toString() : "CREATED";
    }
    public void setStatus(String status) {
        this.state = convertStringToState(status);
    }
    
    @Override
    public String toString() {
        return "Invoice{" +
                "invoiceId='" + invoiceId + '\'' +
                ", contractId='" + contractId + '\'' +
                ", fromEnterpriseId='" + fromEnterpriseId + '\'' +
                ", toEnterpriseId='" + toEnterpriseId + '\'' +
                ", amount=" + amount +
                ", issueDate='" + issueDate + '\'' +
                ", dueDate='" + dueDate + '\'' +
                ", state=" + state +
                ", description='" + description + '\'' +
                ", tokenId='" + tokenId + '\'' +
                '}';
    }
}