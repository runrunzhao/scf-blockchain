package com.supplychainfinance.model;

import java.util.Date;

public class CTTToken {
    private String tokenId;
    private String issuer;
    private String owner;
    private Double amount;
    private Date issuedDate;
    private Date expiryDate;
    private String state;
    private String sourceInvoiceId;
    private String description;

    // Constructors
    public CTTToken() {
    }

    public CTTToken(String tokenId, String issuer, String owner, Double amount, 
                  Date issuedDate, Date expiryDate, String state, 
                  String sourceInvoiceId, String description) {
        this.tokenId = tokenId;
        this.issuer = issuer;
        this.owner = owner;
        this.amount = amount;
        this.issuedDate = issuedDate;
        this.expiryDate = expiryDate;
        this.state = state;
        this.sourceInvoiceId = sourceInvoiceId;
        this.description = description;
    }

    // Getters and setters
    public String getTokenId() {
        return tokenId;
    }

    public void setTokenId(String tokenId) {
        this.tokenId = tokenId;
    }

    public String getIssuer() {
        return issuer;
    }

    public void setIssuer(String issuer) {
        this.issuer = issuer;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Date getIssuedDate() {
        return issuedDate;
    }

    public void setIssuedDate(Date issuedDate) {
        this.issuedDate = issuedDate;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getSourceInvoiceId() {
        return sourceInvoiceId;
    }

    public void setSourceInvoiceId(String sourceInvoiceId) {
        this.sourceInvoiceId = sourceInvoiceId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "CTTToken{" +
                "tokenId='" + tokenId + '\'' +
                ", issuer='" + issuer + '\'' +
                ", owner='" + owner + '\'' +
                ", amount=" + amount +
                ", issuedDate=" + issuedDate +
                ", expiryDate=" + expiryDate +
                ", state='" + state + '\'' +
                ", sourceInvoiceId='" + sourceInvoiceId + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}