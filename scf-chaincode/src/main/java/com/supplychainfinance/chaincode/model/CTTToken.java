package com.supplychainfinance.chaincode.model;

import org.hyperledger.fabric.contract.annotation.DataType;
import org.hyperledger.fabric.contract.annotation.Property;

@DataType
public class CTTToken {
    @Property
    private String tokenId;
    
    @Property
    private String issuer;
    
    @Property
    private String owner;
    
    @Property
    private Double amount;
    
    @Property
    private String issuedDate;
    
    @Property
    private String expiryDate;
    
    @Property
    private TokenState state;
    
    @Property
    private String sourceInvoiceId;
    
    @Property
    private String description;

    public CTTToken() {
        // Default constructor needed for serialization
    }

    public CTTToken(String tokenId, String issuer, String owner, Double amount, 
                  String issuedDate, String expiryDate, String sourceInvoiceId, String description) {
        this.tokenId = tokenId;
        this.issuer = issuer;
        this.owner = owner;
        this.amount = amount;
        this.issuedDate = issuedDate;
        this.expiryDate = expiryDate;
        this.state = TokenState.ISSUED;
        this.sourceInvoiceId = sourceInvoiceId;
        this.description = description;
    }

    // Getters and setters
    public String getTokenId() { return tokenId; }
    public void setTokenId(String tokenId) { this.tokenId = tokenId; }
    
    public String getIssuer() { return issuer; }
    public void setIssuer(String issuer) { this.issuer = issuer; }
    
    public String getOwner() { return owner; }
    public void setOwner(String owner) { this.owner = owner; }
    
    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }
    
    public String getIssuedDate() { return issuedDate; }
    public void setIssuedDate(String issuedDate) { this.issuedDate = issuedDate; }
    
    public String getExpiryDate() { return expiryDate; }
    public void setExpiryDate(String expiryDate) { this.expiryDate = expiryDate; }
    
    public TokenState getState() { return state; }
    public void setState(TokenState state) { this.state = state; }
    
    public String getSourceInvoiceId() { return sourceInvoiceId; }
    public void setSourceInvoiceId(String sourceInvoiceId) { this.sourceInvoiceId = sourceInvoiceId; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}