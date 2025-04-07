package com.supplychainfinance.model;

import java.util.Date;

public class Invoice {
    private String invoiceID;
    private String contractID;
    private double amount;
    private Date payDate;
    private String status;
    private String memo;
    private String paymentMethod;
  
    // Constructors
    public Invoice() {
    }
    
    public Invoice(String invoiceID, String contractID, double amount, Date payDate, String status, String memo) {
        this.invoiceID = invoiceID;
        this.contractID = contractID;
        this.amount = amount;
        this.payDate = payDate;
        this.status = status;
        this.memo = memo;
        this.paymentMethod = "CTT"; // Default payment method
    }
    
    // Getters and setters
    public String getInvoiceID() {
        return invoiceID;
    }
    
    public void setInvoiceID(String invoiceID) {
        this.invoiceID = invoiceID;
    }
    
    public String getContractID() {
        return contractID;
    }
    
    public void setContractID(String contractID) {
        this.contractID = contractID;
    }
    
    public double getAmount() {
        return amount;
    }
    
    public void setAmount(double amount) {
        this.amount = amount;
    }
    
    public Date getPayDate() {
        return payDate;
    }
    
    public void setPayDate(Date payDate) {
        this.payDate = payDate;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getMemo() {
        return memo;
    }
    
    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    
    @Override
    public String toString() {
        return "Invoice{" +
                "invoiceID='" + invoiceID + '\'' +
                ", contractID='" + contractID + '\'' +
                ", amount=" + amount +
                ", payDate=" + payDate +
                ", status='" + status + '\'' +
                ", memo='" + memo + '\'' +
                '}';
    }
}